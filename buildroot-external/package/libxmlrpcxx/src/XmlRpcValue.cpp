
/* changed by eQ-3 Entwicklung GmbH 2006 */


#include "XmlRpcValue.h"
#include "XmlRpcException.h"
#include "XmlRpcUtil.h"
#include "base64.h"

#ifndef MAKEDEPEND
# include <iostream>
# include <ostream>
# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <math.h>
# if defined(_WINDOWS)
#  include <winsock2.h>
# else
#  include <netinet/in.h>
# endif
#endif

namespace XmlRpc {


  static const char VALUE_TAG[]     = "<value>";
  static const char VALUE_ETAG[]    = "</value>";

  static const char BOOLEAN_TAG[]   = "<boolean>";
  static const char BOOLEAN_ETAG[]  = "</boolean>";
  static const char DOUBLE_TAG[]    = "<double>";
  static const char DOUBLE_ETAG[]   = "</double>";
  static const char INT_TAG[]       = "<int>";
  static const char I4_TAG[]        = "<i4>";
  static const char I4_ETAG[]       = "</i4>";
  static const char STRING_TAG[]    = "<string>";
  static const char DATETIME_TAG[]  = "<dateTime.iso8601>";
  static const char DATETIME_ETAG[] = "</dateTime.iso8601>";
  static const char BASE64_TAG[]    = "<base64>";
  static const char BASE64_ETAG[]   = "</base64>";

  static const char ARRAY_TAG[]     = "<array>";
  static const char DATA_TAG[]      = "<data>";
  static const char DATA_ETAG[]     = "</data>";
  static const char ARRAY_ETAG[]    = "</array>";

  static const char STRUCT_TAG[]    = "<struct>";
  static const char MEMBER_TAG[]    = "<member>";
  static const char NAME_TAG[]      = "<name>";
  static const char NAME_ETAG[]     = "</name>";
  static const char MEMBER_ETAG[]   = "</member>";
  static const char STRUCT_ETAG[]   = "</struct>";

  static const unsigned long STREAM_TAG_INTEGER  = 0x001;
  static const unsigned long STREAM_TAG_BOOLEAN  = 0x002;
  static const unsigned long STREAM_TAG_STRING   = 0x003;
  static const unsigned long STREAM_TAG_DOUBLE   = 0x004;
  static const unsigned long STREAM_TAG_DATETIME = 0x005;
  static const unsigned long STREAM_TAG_BINARY   = 0x006;
  static const unsigned long STREAM_TAG_ARRAY    = 0x100;
  static const unsigned long STREAM_TAG_STRUCT   = 0x101;
      
  // Format strings
  std::string XmlRpcValue::_doubleFormat("%f");



  // Clean up
  void XmlRpcValue::invalidate()
  {
    switch (_type) {
      case TypeString:    delete _value.asString; break;
      case TypeDateTime:  delete _value.asTime;   break;
      case TypeBase64:    delete _value.asBinary; break;
      case TypeArray:     delete _value.asArray;  break;
      case TypeStruct:    delete _value.asStruct; break;
      default: break;
    }
    _type = TypeInvalid;
    _value.asBinary = 0;
  }

  
  // Type checking
  void XmlRpcValue::assertTypeOrInvalid(Type t)
  {
    if (_type == TypeInvalid)
    {
      _type = t;
      switch (_type) {    // Ensure there is a valid value for the type
        case TypeString:   _value.asString = new std::string(); break;
        case TypeDateTime: _value.asTime = new struct tm();     break;
        case TypeBase64:   _value.asBinary = new BinaryData();  break;
        case TypeArray:    _value.asArray = new ValueArray();   break;
        case TypeStruct:   _value.asStruct = new ValueStruct(); break;
        default:           _value.asBinary = 0; break;
      }
    }
    else if (_type != t)
      throw XmlRpcException("type error");
  }

  void XmlRpcValue::assertArray(int size) const
  {
    if (_type != TypeArray)
      throw XmlRpcException("type error: expected an array");
    else if (int(_value.asArray->size()) < size)
      throw XmlRpcException("range error: array index too large");
  }


  void XmlRpcValue::assertArray(int size)
  {
    if (_type == TypeInvalid) {
      _type = TypeArray;
      _value.asArray = new ValueArray(size);
    } else if (_type == TypeArray) {
      if (int(_value.asArray->size()) < size)
        _value.asArray->resize(size);
    } else
      throw XmlRpcException("type error: expected an array");
  }

  void XmlRpcValue::assertStruct()
  {
    if (_type == TypeInvalid) {
      _type = TypeStruct;
      _value.asStruct = new ValueStruct();
    } else if (_type != TypeStruct)
      throw XmlRpcException("type error: expected a struct");
  }


  // Operators
  XmlRpcValue& XmlRpcValue::operator=(XmlRpcValue const& rhs)
  {
    if (this != &rhs)
    {
      invalidate();
      _type = rhs._type;
      switch (_type) {
        case TypeBoolean:  _value.asBool = rhs._value.asBool; break;
        case TypeInt:      _value.asInt = rhs._value.asInt; break;
        case TypeDouble:   _value.asDouble = rhs._value.asDouble; break;
        case TypeDateTime: _value.asTime = new struct tm(*rhs._value.asTime); break;
        case TypeString:   _value.asString = new std::string(*rhs._value.asString); break;
        case TypeBase64:   _value.asBinary = new BinaryData(*rhs._value.asBinary); break;
        case TypeArray:    _value.asArray = new ValueArray(*rhs._value.asArray); break;
        case TypeStruct:   _value.asStruct = new ValueStruct(*rhs._value.asStruct); break;
        default:           _value.asBinary = 0; break;
      }
    }
    return *this;
  }


  // Predicate for tm equality
  static bool tmEq(struct tm const& t1, struct tm const& t2) {
    return t1.tm_sec == t2.tm_sec && t1.tm_min == t2.tm_min &&
            t1.tm_hour == t2.tm_hour && t1.tm_mday == t2.tm_mday &&
            t1.tm_mon == t2.tm_mon && t1.tm_year == t2.tm_year;
  }

  bool XmlRpcValue::operator==(XmlRpcValue const& other) const
  {
    if (_type != other._type)
      return false;

    switch (_type) {
      case TypeBoolean:  return ( !_value.asBool && !other._value.asBool) ||
                                ( _value.asBool && other._value.asBool);
      case TypeInt:      return _value.asInt == other._value.asInt;
      case TypeDouble:   return _value.asDouble == other._value.asDouble;
      case TypeDateTime: return tmEq(*_value.asTime, *other._value.asTime);
      case TypeString:   return *_value.asString == *other._value.asString;
      case TypeBase64:   return *_value.asBinary == *other._value.asBinary;
      case TypeArray:    return *_value.asArray == *other._value.asArray;

      // The map<>::operator== requires the definition of value< for kcc
      case TypeStruct:   //return *_value.asStruct == *other._value.asStruct;
        {
          if (_value.asStruct->size() != other._value.asStruct->size())
            return false;
          
          ValueStruct::const_iterator it1=_value.asStruct->begin();
          ValueStruct::const_iterator it2=other._value.asStruct->begin();
          while (it1 != _value.asStruct->end()) {
            const XmlRpcValue& v1 = it1->second;
            const XmlRpcValue& v2 = it2->second;
            if ( ! (v1 == v2))
              return false;
            it1++;
            it2++;
          }
          return true;
        }
      default: break;
    }
    return true;    // Both invalid values ...
  }

  bool XmlRpcValue::operator!=(XmlRpcValue const& other) const
  {
    return !(*this == other);
  }


  // Works for strings, binary data, arrays, and structs.
  int XmlRpcValue::size() const
  {
    switch (_type) {
      case TypeString: return int(_value.asString->size());
      case TypeBase64: return int(_value.asBinary->size());
      case TypeArray:  return int(_value.asArray->size());
      case TypeStruct: return int(_value.asStruct->size());
      default: break;
    }

    throw XmlRpcException("type error");
  }

  unsigned int XmlRpcValue::erase(unsigned int startIndex, unsigned int count)
  {
	  if(_type != TypeArray)throw XmlRpcException("type error");
	  if(count>_value.asArray->size())count=_value.asArray->size();
	  _value.asArray->erase(_value.asArray->begin(), _value.asArray->begin()+count);
	  return count;
  }

  // Checks for existence of struct member
  bool XmlRpcValue::hasMember(const std::string& name) const
  {
    return _type == TypeStruct && _value.asStruct->find(name) != _value.asStruct->end();
  }

  // Set the value from xml. The chars at *offset into valueXml 
  // should be the start of a <value> tag. Destroys any existing value.
  bool XmlRpcValue::fromXml(std::string const& valueXml, int* offset)
  {
    int savedOffset = *offset;
	bool isEmptyTag;

    invalidate();
    if ( ! XmlRpcUtil::nextTagIs(VALUE_TAG, valueXml, offset, &isEmptyTag))
      return false;       // Not a value, offset not updated

	//handle the empty value tag case as empty string
	if( isEmptyTag )
	{
		(*this) = "";
		return true;
	}

	int afterValueOffset = *offset;
    std::string typeTag = XmlRpcUtil::getNextTag(valueXml, offset);
    bool result = false;
    if (typeTag == BOOLEAN_TAG)
      result = boolFromXml(valueXml, offset);
    else if (typeTag == I4_TAG || typeTag == INT_TAG)
      result = intFromXml(valueXml, offset);
    else if (typeTag == DOUBLE_TAG)
      result = doubleFromXml(valueXml, offset);
    else if (typeTag.empty() || typeTag == STRING_TAG)
      result = stringFromXml(valueXml, offset);
    else if (typeTag == DATETIME_TAG)
      result = timeFromXml(valueXml, offset);
    else if (typeTag == BASE64_TAG)
      result = binaryFromXml(valueXml, offset);
    else if (typeTag == ARRAY_TAG)
      result = arrayFromXml(valueXml, offset);
    else if (typeTag == STRUCT_TAG)
      result = structFromXml(valueXml, offset);
    // Watch for empty/blank strings with no <string>tag
    else if (typeTag == VALUE_ETAG)
    {
      *offset = afterValueOffset;   // back up & try again
      result = stringFromXml(valueXml, offset);
    }

    if (result)  // Skip over the </value> tag
      XmlRpcUtil::findTag(VALUE_ETAG, valueXml, offset);
    else        // Unrecognized tag after <value>
      *offset = savedOffset;

    return result;
  }

  bool XmlRpcValue::fromStream(std::string const& valueStream, int* offset)
  {
    int savedOffset = *offset;

    invalidate();

	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(*offset)+sizeof(long))return false;

	long tag;
	memcpy(&tag, data, 4);
	tag=ntohl(tag);
	*offset+=4;
	
	bool result=false;
	switch(tag){
	case STREAM_TAG_INTEGER:
		result=intFromStream(valueStream, offset);
		break;
	case STREAM_TAG_BOOLEAN:
		result=boolFromStream(valueStream, offset);
		break;
	case STREAM_TAG_STRING:
		result=stringFromStream(valueStream, offset);
		break;
	case STREAM_TAG_DOUBLE:
		result=doubleFromStream(valueStream, offset);
		break;
	case STREAM_TAG_DATETIME:
		result=timeFromStream(valueStream, offset);
		break;
	case STREAM_TAG_BINARY:
		result=binaryFromStream(valueStream, offset);
		break;
	case STREAM_TAG_ARRAY:
		result=arrayFromStream(valueStream, offset);
		break;
	case STREAM_TAG_STRUCT:
		result=structFromStream(valueStream, offset);
		break;
	default:
		break;
	}

    if (!result) *offset = savedOffset;

    return result;
  }

  bool XmlRpcValue::fromText(std::string const& valueStream, int* offset)
  {
    int dummy=0;
	if(!offset)offset=&dummy;
    int savedOffset = *offset;

    invalidate();

	bool result=false;
//	printf("try stringFromText\n");
	if(!result)result=stringFromText(valueStream, offset);
//	printf("try intFromText\n");
	if(!result)result=intFromText(valueStream, offset);
//	printf("try arrayFromText\n");
	if(!result)result=arrayFromText(valueStream, offset);
//	printf("try boolFromText\n");
	if(!result)result=boolFromText(valueStream, offset);
//	printf("try doubleFromText\n");
	if(!result)result=doubleFromText(valueStream, offset);
//	printf("try timeFromText\n");
	if(!result)result=timeFromText(valueStream, offset);
//	printf("try binaryFromText\n");
	if(!result)result=binaryFromText(valueStream, offset);
//	printf("try structFromText\n");
	if(!result)result=structFromText(valueStream, offset);

    if (!result) *offset = savedOffset;
//	std::cout<<"fromText text="<<valueStream.substr(savedOffset)<<" result="<<result<<", type="<<_type<<", value="<<(*this)<<std::endl;
    return result;
  }

  // Encode the Value in xml
  std::string XmlRpcValue::toXml() const
  {
    switch (_type) {
      case TypeBoolean:  return boolToXml();
      case TypeInt:      return intToXml();
      case TypeDouble:   return doubleToXml();
      case TypeString:   return stringToXml();
      case TypeDateTime: return timeToXml();
      case TypeBase64:   return binaryToXml();
      case TypeArray:    return arrayToXml();
      case TypeStruct:   return structToXml();
      default: break;
    }
    return std::string();   // Invalid value
  }

  // Encode the Value as binary
  std::string XmlRpcValue::toStream() const
  {
    switch (_type) {
      case TypeBoolean:  return boolToStream();
      case TypeInt:      return intToStream();
      case TypeDouble:   return doubleToStream();
      case TypeString:   return stringToStream();
      case TypeDateTime: return timeToStream();
      case TypeBase64:   return binaryToStream();
      case TypeArray:    return arrayToStream();
      case TypeStruct:   return structToStream();
      default: break;
    }
    return std::string();   // Invalid value
  }

  std::string XmlRpcValue::toText() const
  {
    switch (_type) {
      case TypeBoolean:  return boolToText();
      case TypeInt:      return intToText();
      case TypeDouble:   return doubleToText();
      case TypeString:   return stringToText();
      case TypeDateTime: return timeToText();
      case TypeBase64:   return binaryToText();
      case TypeArray:    return arrayToText();
      case TypeStruct:   return structToText();
      default: break;
    }
    return "nil";   // Invalid value
  }


  // Boolean
  bool XmlRpcValue::boolFromXml(std::string const& valueXml, int* offset)
  {
    const char* valueStart = valueXml.c_str() + *offset;
    char* valueEnd;
    long ivalue = strtol(valueStart, &valueEnd, 10);
    if (valueEnd == valueStart || (ivalue != 0 && ivalue != 1))
      return false;

    _type = TypeBoolean;
    _value.asBool = (ivalue == 1);
    *offset += int(valueEnd - valueStart);
    return true;
  }

  std::string XmlRpcValue::boolToXml() const
  {
    std::string xml = VALUE_TAG;
    xml += BOOLEAN_TAG;
    xml += (_value.asBool ? "1" : "0");
    xml += BOOLEAN_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::boolFromStream(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(unsigned long)(*offset)+1)return false;

    _type = TypeBoolean;
    _value.asBool = data[0]!=0;
    *offset += 1;
    return true;
  }

  std::string XmlRpcValue::boolToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_BOOLEAN);
	stream.append((char*)&tag, 4);
	stream.append(_value.asBool ? "\1" : "\0", 1);
    return stream;
  }

  bool XmlRpcValue::boolFromText(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	const char* end=strpbrk(data, ",}]");
	if(!end)end=valueStream.c_str()+valueStream.size();

	unsigned long size=end-data;
	if(size==4 && strncmp(data, "true", 4)==0){
	    _type = TypeBoolean;
		_value.asBool = true;
	}else if(size==5 && strncmp(data, "false", 5)==0){
	    _type = TypeBoolean;
		_value.asBool = false;
	}else{
		return false;
	}
	*offset+=size;
    return true;
  }

  std::string XmlRpcValue::boolToText() const
  {
	  return _value.asBool?"true":"false";
  }

  // Int
  bool XmlRpcValue::intFromXml(std::string const& valueXml, int* offset)
  {
    const char* valueStart = valueXml.c_str() + *offset;
    char* valueEnd;
    long ivalue = strtol(valueStart, &valueEnd, 10);
    if (valueEnd == valueStart)
      return false;

    _type = TypeInt;
    _value.asInt = int(ivalue);
    *offset += int(valueEnd - valueStart);
    return true;
  }

  std::string XmlRpcValue::intToXml() const
  {
    char buf[256];
    snprintf(buf, sizeof(buf)-1, "%d", _value.asInt);
    buf[sizeof(buf)-1] = 0;
    std::string xml = VALUE_TAG;
    xml += I4_TAG;
    xml += buf;
    xml += I4_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::intFromStream(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	unsigned long v;
	memcpy(&v, data, 4);
	v=ntohl(v);
	if(valueStream.length()<(unsigned long)(*offset)+4)return false;

    _type = TypeInt;
    _value.asInt = int(v);
    *offset += 4;
    return true;
  }

  std::string XmlRpcValue::intToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_INTEGER);
	stream.append((char*)&tag, 4);
	unsigned long value=htonl(_value.asInt);
	stream.append((char*)&value, 4);
    return stream;
  }

  bool XmlRpcValue::intFromText(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	const char* end=strpbrk(data, ",}]");
	if(!end)end=valueStream.c_str()+valueStream.size();
	unsigned long size=end-data;

    char* scanEnd;
    long ivalue = strtol(data, &scanEnd, 0);
    if (scanEnd != end)
      return false;

    _type = TypeInt;
    _value.asInt = int(ivalue);
    *offset += size;
    return true;
  }

  std::string XmlRpcValue::intToText() const
  {
    char buf[16];
    snprintf(buf, sizeof(buf)-1, "%d", _value.asInt);
    buf[sizeof(buf)-1] = 0;
    return buf;
  }

  // Double
  bool XmlRpcValue::doubleFromXml(std::string const& valueXml, int* offset)
  {
    const char* valueStart = valueXml.c_str() + *offset;
    char* valueEnd;
    double dvalue = strtod(valueStart, &valueEnd);
    if (valueEnd == valueStart)
      return false;

    _type = TypeDouble;
    _value.asDouble = dvalue;
    *offset += int(valueEnd - valueStart);
    return true;
  }

  std::string XmlRpcValue::doubleToXml() const
  {
    char buf[256];
    snprintf(buf, sizeof(buf)-1, getDoubleFormat().c_str(), _value.asDouble);
    buf[sizeof(buf)-1] = 0;

    std::string xml = VALUE_TAG;
    xml += DOUBLE_TAG;
    xml += buf;
    xml += DOUBLE_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::doubleFromStream(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;
	if(valueStream.length()<(unsigned long)(*offset)+8)return false;
	
	int mantissa;
	memcpy(&mantissa, data, 4);
	mantissa=ntohl(mantissa);
	data+=4;
	int exponent;
	memcpy(&exponent, data, 4);
	exponent=ntohl(exponent);

    _type = TypeDouble;
	_value.asDouble=ldexp(double(mantissa)/double(1<<30), exponent);

    *offset += 8;
    return true;
  }

  std::string XmlRpcValue::doubleToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_DOUBLE);
	stream.append((char*)&tag, 4);
	int mantissa;
	int exponent;
	mantissa=int(frexp(_value.asDouble, &exponent)*double(1<<30));
	unsigned long temp=htonl((unsigned long)mantissa);
	stream.append((char*)&temp, 4);
	temp=htonl((unsigned long)exponent);
	stream.append((char*)&temp, 4);
    return stream;
  }

  bool XmlRpcValue::doubleFromText(std::string const& valueText, int* offset)
  {
	const char* data=valueText.c_str()+*offset;

	const char* end=strpbrk(data, ",}]");
	if(!end)end=valueText.c_str()+valueText.size();
	unsigned long size=end-data;

    char* scanEnd;
    double dvalue = strtod(data, &scanEnd);
    if (scanEnd != end)
      return false;

    _type = TypeDouble;
    _value.asDouble = dvalue;
    *offset += size;
    return true;
  }

  std::string XmlRpcValue::doubleToText() const
  {
    char buf[256];
    snprintf(buf, sizeof(buf)-1, getDoubleFormat().c_str(), _value.asDouble);
    buf[sizeof(buf)-1] = 0;
	return buf;
  }

  // String
  bool XmlRpcValue::stringFromXml(std::string const& valueXml, int* offset)
  {
    size_t valueEnd = valueXml.find('<', *offset);
    if (valueEnd == std::string::npos)
      return false;     // No end tag;

    _type = TypeString;
    _value.asString = new std::string(XmlRpcUtil::xmlDecode(valueXml.substr(*offset, valueEnd-*offset)));
    *offset += int(_value.asString->length());
    return true;
  }

  std::string XmlRpcValue::stringToXml() const
  {
    std::string xml = VALUE_TAG;
    //xml += STRING_TAG; optional
    xml += XmlRpcUtil::xmlEncode(*_value.asString);
    //xml += STRING_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::stringFromStream(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(unsigned long)(*offset)+4)return false;

	unsigned long length;
	memcpy(&length, data, 4);
	length=ntohl(length);

	if(valueStream.length()<(*offset)+4+length)return false;

	data+=4;
    _type = TypeString;
    _value.asString = new std::string(data, length);
    *offset += length+4;
    return true;
  }

  std::string XmlRpcValue::stringToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_STRING);
	stream.append((char*)&tag, 4);
	std::string* value=_value.asString;
	unsigned long length=htonl(value->length());
	stream.append((char*)&length, 4);
	stream.append(*value);
    return stream;
  }

  bool XmlRpcValue::stringFromText(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;
	if(data[0]!='\"')return false;
	const char* left=data+1;
	std::string* s=new std::string;
	while(*left){
		const char* right=strpbrk(left, "\\\"");
		if(!right){
			delete s;
			return false;
		}
		s->append(left, right-left);
		if(right[0]=='\\'){
			if(!right[1]){
				delete s;
				return false;
			}
			if(right[1]=='x'){
				if(!right[2] || !right[3]){
					delete s;
					return false;
				}
				char buffer[3];
				buffer[2]=0;
				memcpy(buffer, right+2, 2);
				char* end;
				s->append(1, (char)strtol(buffer, &end, 16));
				if(end!=buffer+2){
					delete s;
					return false;
				}
				left=right+4;
			}else{
			s->append(right+1, 1);
			left=right+2;
			}
		}else{//right[0]=='\"'
			left=right+1;
			break;
		}
	}
	if(*left!=',' && *left!='}' && *left!=']' && *left!='\0'){
		delete s;
		return false;
	}
    _type = TypeString;
    _value.asString = s;
    *offset += left-data;
    return true;
  }

  std::string XmlRpcValue::stringToText() const
  {
    std::string s;
	s=("\"");
	const char* left=_value.asString->c_str();

	while(true){
		const char* right=strpbrk(left, "\"\\\x0a\x0d");
		if(!right){
			s.append(left);
			break;
		}else{
			s.append(left, right);
			if(*right=='\\' || *right=='\"'){
			s.append("\\");
			s.append(right, 1);
			left=right+1;
			}else if(*right==0x0a){
				s.append("\\x0a");
				left=right+1;
			}else if(*right==0x0d){
				s.append("\\x0d");
				left=right+1;
			}
		}
	}
	s.append("\"");
    return s;
  }

  // DateTime (stored as a struct tm)
  bool XmlRpcValue::timeFromXml(std::string const& valueXml, int* offset)
  {
    size_t valueEnd = valueXml.find('<', *offset);
    if (valueEnd == std::string::npos)
      return false;     // No end tag;

    std::string stime = valueXml.substr(*offset, valueEnd-*offset);

    struct tm t;
    if (sscanf(stime.c_str(),"%4d%2d%2dT%2d:%2d:%2d",&t.tm_year,&t.tm_mon,&t.tm_mday,&t.tm_hour,&t.tm_min,&t.tm_sec) != 6)
      return false;

    t.tm_isdst = -1;
    _type = TypeDateTime;
    _value.asTime = new struct tm(t);
    *offset += int(stime.length());
    return true;
  }

  std::string XmlRpcValue::timeToXml() const
  {
    struct tm* t = _value.asTime;
    char buf[20];
    snprintf(buf, sizeof(buf)-1, "%4d%02d%02dT%02d:%02d:%02d", 
      t->tm_year,t->tm_mon,t->tm_mday,t->tm_hour,t->tm_min,t->tm_sec);
    buf[sizeof(buf)-1] = 0;

    std::string xml = VALUE_TAG;
    xml += DATETIME_TAG;
    xml += buf;
    xml += DATETIME_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::timeFromStream(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(unsigned long)(*offset)+4)return false;

	unsigned long value;
	memcpy(&value, data, 4);
	time_t t=ntohl(value);

    _type = TypeDateTime;
    _value.asTime = new struct tm(*gmtime(&t));
    *offset += 4;
    return true;
  }

  std::string XmlRpcValue::timeToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_DATETIME);
	stream.append((char*)&tag, 4);
	unsigned long value=(unsigned long)mktime(_value.asTime);
	value=htonl(value);
	stream.append((char*)&value, 4);
    return stream;
  }

  bool XmlRpcValue::timeFromText(std::string const& valueText, int* offset)
  {
	const char* data=valueText.c_str()+*offset;

	const char* end=strpbrk(data, ",}]");
	if(!end)end=valueText.c_str()+valueText.size();
	unsigned long size=end-data;
	if(size!=17)return false;
    struct tm t;
    if (sscanf(data,"%4d%2d%2dT%2d:%2d:%2d",&t.tm_year,&t.tm_mon,&t.tm_mday,&t.tm_hour,&t.tm_min,&t.tm_sec) != 6)
      return false;

    t.tm_isdst = -1;
    _type = TypeDateTime;
    _value.asTime = new struct tm(t);
    *offset += size;
    return true;
  }

  std::string XmlRpcValue::timeToText() const
  {
    struct tm* t = _value.asTime;
    char buf[20];
    snprintf(buf, sizeof(buf)-1, "%4d%02d%02dT%02d:%02d:%02d", 
      t->tm_year,t->tm_mon,t->tm_mday,t->tm_hour,t->tm_min,t->tm_sec);
    buf[sizeof(buf)-1] = 0;
	return buf;
  }

  // Base64
  bool XmlRpcValue::binaryFromXml(std::string const& valueXml, int* offset)
  {
    size_t valueEnd = valueXml.find('<', *offset);
    if (valueEnd == std::string::npos)
      return false;     // No end tag;

    _type = TypeBase64;
    std::string asString = valueXml.substr(*offset, valueEnd-*offset);
    _value.asBinary = new BinaryData();
    // check whether base64 encodings can contain chars xml encodes...

    // convert from base64 to binary
    int iostatus = 0;
	  base64<char> decoder;
    std::back_insert_iterator<BinaryData> ins = std::back_inserter(*(_value.asBinary));
		decoder.get(asString.begin(), asString.end(), ins, iostatus);

    *offset += int(asString.length());
    return true;
  }


  std::string XmlRpcValue::binaryToXml() const
  {
    // convert to base64
    std::vector<char> base64data;
    int iostatus = 0;
	  base64<char> encoder;
    std::back_insert_iterator<std::vector<char> > ins = std::back_inserter(base64data);
		encoder.put(_value.asBinary->begin(), _value.asBinary->end(), ins, iostatus, base64<>::crlf());

    // Wrap with xml
    std::string xml = VALUE_TAG;
    xml += BASE64_TAG;
    xml.append(base64data.begin(), base64data.end());
    xml += BASE64_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::binaryFromStream(std::string const& valueStream, int* offset)
  {
	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(unsigned long)(*offset)+4)return false;

	unsigned long length;
	memcpy(&length, data, 4);
	length=ntohl(length);

	if(valueStream.length()<(*offset)+4+length)return false;

	data+=4;
    _type = TypeBase64;
    _value.asBinary = new BinaryData();
	_value.asBinary->resize(length);
	std::copy(data, data+length, _value.asBinary->begin());
    *offset += length + 4;
    return true;
  }


  std::string XmlRpcValue::binaryToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_BINARY);
	stream.append((char*)&tag, 4);
	BinaryData* value=_value.asBinary;
	unsigned long length=htonl(value->size());
	stream.append((char*)&length, 4);
	unsigned long size=stream.size();
	stream.resize(size+value->size());
	std::copy(value->begin(), value->end(), stream.begin()+size);
    return stream;
  }

  bool XmlRpcValue::binaryFromText(std::string const& valueText, int* offset)
  {
	const char* data=valueText.c_str()+*offset;

	if(*data != 'x')return false;
	data++;
	const char* end=strpbrk(data, ",}]");
	if(!end)end=valueText.c_str()+valueText.size();
	unsigned long size=(end-data);
	if(size%2)return false;

	BinaryData* bin=new BinaryData();
	bin->reserve(size/2);

	char buffer[3];
	buffer[2]=0;
	while(data!=end){
		memcpy(buffer, data, 2);
		char *end;
		bin->push_back((char)strtol(buffer, &end, 16));
		if(end!=buffer+2){
		delete bin;
		return false;
	}
		data+=2;
	}

    _type = TypeBase64;
    _value.asBinary = bin;
	*offset+=size+1;

    return true;
  }


  std::string XmlRpcValue::binaryToText() const
  {
	char buffer[3];
    std::string s="x";
	BinaryData::iterator it;
	for(it=_value.asBinary->begin();it!=_value.asBinary->end();it++){
		sprintf(buffer, "%02X", ((int)*it)&0xff);
		s.append(buffer);
	}
    return s;
  }

  // Array
  bool XmlRpcValue::arrayFromXml(std::string const& valueXml, int* offset)
  {
    bool isEmptyTag;
    if ( ! XmlRpcUtil::nextTagIs(DATA_TAG, valueXml, offset, &isEmptyTag))
	{
		return false;
	}

    _type = TypeArray;
    _value.asArray = new ValueArray;
	if( !isEmptyTag )
	{
		XmlRpcValue v;
		while (v.fromXml(valueXml, offset))
			_value.asArray->push_back(v);       // copy...

		// Skip the trailing </data>
		(void) XmlRpcUtil::nextTagIs(DATA_ETAG, valueXml, offset);
	}
	return true;
  }


  // In general, its preferable to generate the xml of each element of the
  // array as it is needed rather than glomming up one big string.
  std::string XmlRpcValue::arrayToXml() const
  {
    std::string xml = VALUE_TAG;
    xml += ARRAY_TAG;
    xml += DATA_TAG;

    int s = int(_value.asArray->size());
    for (int i=0; i<s; ++i)
       xml += _value.asArray->at(i).toXml();

    xml += DATA_ETAG;
    xml += ARRAY_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::arrayFromStream(std::string const& valueStream, int* offset)
  {
	int saveOffset=*offset;

	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(unsigned long)(*offset)+4)return false;

	unsigned long length;
	memcpy(&length, data, 4);
	length=ntohl(length);

	*offset+=4;

    _type = TypeArray;
    _value.asArray = new ValueArray;
	while(length){
		_value.asArray->push_back(XmlRpcValue());
		if(!_value.asArray->back().fromStream(valueStream, offset)){
			break;
		}
		length--;
	}
	if(length){//an error occured
		invalidate();
		*offset=saveOffset;
		return false;
	}
	return true;
  }

  std::string XmlRpcValue::arrayToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_ARRAY);
	stream.append((char*)&tag, 4);
	ValueArray* value=_value.asArray;
	unsigned long length=htonl(value->size());
	stream.append((char*)&length, 4);
	length=value->size();
	for(unsigned int i=0;i<length;i++){
		std::string s=(*value)[i].toStream();
		if(!s.size())return "";
		stream.append(s);
	}
    return stream;
  }

  bool XmlRpcValue::arrayFromText(std::string const& valueStream, int* offset)
  {
	int scanOffset=*offset;

	if(valueStream[scanOffset]!='{')return false;
	scanOffset++;
    ValueArray* a = new ValueArray;
	while(scanOffset<(int)valueStream.size() && valueStream[scanOffset]!='}'){
		a->push_back(XmlRpcValue());
		if(!a->back().fromText(valueStream, &scanOffset)){
			break;
		}
		if(scanOffset>=(int)valueStream.size() || valueStream[scanOffset]!=',')break;
		scanOffset++;
	}
	if(valueStream[scanOffset]!='}'){
		delete a;
		return false;
	}
    _type = TypeArray;
    _value.asArray = a;
	*offset=scanOffset+1;
	return true;
  }

  std::string XmlRpcValue::arrayToText() const
  {
    std::string s="{";
	ValueArray* a=_value.asArray;
	for(unsigned int i=0;i<a->size();i++){
		if(i)s+=",";
		std::string v=(*a)[i].toText();
		if(!v.size())return "";
		s.append(v);
	}
	s+="}";
    return s;
  }

  // Struct
  bool XmlRpcValue::structFromXml(std::string const& valueXml, int* offset)
  {
    _type = TypeStruct;
    _value.asStruct = new ValueStruct;

    while (XmlRpcUtil::nextTagIs(MEMBER_TAG, valueXml, offset)) {
      // name
      const std::string name = XmlRpcUtil::parseTag(NAME_TAG, valueXml, offset);
      // value
      XmlRpcValue val(valueXml, offset);
      if ( ! val.valid()) {
        invalidate();
        return false;
      }
      const std::pair<const std::string, XmlRpcValue> p(name, val);
      _value.asStruct->insert(p);

      (void) XmlRpcUtil::nextTagIs(MEMBER_ETAG, valueXml, offset);
    }
    return true;
  }


  // In general, its preferable to generate the xml of each element
  // as it is needed rather than glomming up one big string.
  std::string XmlRpcValue::structToXml() const
  {
    std::string xml = VALUE_TAG;
    xml += STRUCT_TAG;

    ValueStruct::const_iterator it;
    for (it=_value.asStruct->begin(); it!=_value.asStruct->end(); ++it) {
      xml += MEMBER_TAG;
      xml += NAME_TAG;
      xml += XmlRpcUtil::xmlEncode(it->first);
      xml += NAME_ETAG;
      xml += it->second.toXml();
      xml += MEMBER_ETAG;
    }

    xml += STRUCT_ETAG;
    xml += VALUE_ETAG;
    return xml;
  }

  bool XmlRpcValue::structFromStream(std::string const& valueStream, int* offset)
  {
	int saveOffset=*offset;

	const char* data=valueStream.c_str()+*offset;

	if(valueStream.length()<(unsigned long)(*offset)+4)return false;

	unsigned long length;
	memcpy(&length, data, 4);
	length=ntohl(length);

	*offset+=4;
	data+=4;

    _type = TypeStruct;
    _value.asStruct = new ValueStruct;
	while(length){
		data=valueStream.c_str()+*offset;
		std::string name;
		unsigned long name_length;
		memcpy(&name_length, data, 4);
		name_length=ntohl(name_length);
		*offset+=4;
		data+=4;
		name.append(data, name_length);
		*offset+=name_length;
		(*_value.asStruct)[name]=XmlRpcValue();
		if(!(*_value.asStruct)[name].fromStream(valueStream, offset)){
			break;
		}
		length--;
	}
	if(length){//an error occured
		invalidate();
		*offset=saveOffset;
		return false;
	}
	return true;
  }


  // In general, its preferable to generate the xml of each element
  // as it is needed rather than glomming up one big string.
  std::string XmlRpcValue::structToStream() const
  {
    std::string stream;
	unsigned long tag=htonl(STREAM_TAG_STRUCT);
	stream.append((char*)&tag, 4);
	ValueStruct* value=_value.asStruct;
	unsigned long length=htonl(value->size());
	stream.append((char*)&length, 4);
	length=value->size();

	ValueStruct::iterator it;
	for(it=value->begin();it!=value->end();it++)
	{
		const std::string& name=it->first;
		XmlRpcValue& v=it->second;
		unsigned long name_length=htonl(name.length());
		stream.append((char*)&name_length, 4);
		stream.append(name);
		std::string s=v.toStream();
		if(!s.size())return "";
		stream.append(s);
	}
    return stream;
  }


  // Struct
  bool XmlRpcValue::structFromText(std::string const& valueStream, int* offset)
  {
	int scanOffset=*offset;

	if(valueStream[scanOffset]!='[')return false;
	scanOffset++;
    ValueStruct* s = new ValueStruct;
	while(scanOffset<(int)valueStream.size() && valueStream[scanOffset]!=']'){
		std::string::size_type colon=valueStream.find(':', scanOffset);
		if(colon==std::string::npos){
			delete s;
			return false;
		}
		std::string key=valueStream.substr(scanOffset, colon-scanOffset);
		XmlRpcValue& val=(*s)[key];
		scanOffset=colon+1;
		if(!val.fromText(valueStream, &scanOffset)){
			delete s;
			return false;
		}
		if(scanOffset>=(int)valueStream.size() || valueStream[scanOffset]!=',')break;
		scanOffset++;
	}
	if(valueStream[scanOffset]!=']'){
		delete s;
		return false;
	}
    _type = TypeStruct;
    _value.asStruct = s;
	*offset=scanOffset+1;
	return true;
  }


  // In general, its preferable to generate the xml of each element
  // as it is needed rather than glomming up one big string.
  std::string XmlRpcValue::structToText() const
  {
	  std::string s="[";
	  ValueStruct::const_iterator it;
	  for (it=_value.asStruct->begin(); it!=_value.asStruct->end(); ++it)
	  {
		  if (it!=_value.asStruct->begin()) s+=",";
		  s+=it->first+":";
		  std::string v=it->second.toText();
		  s.append(v);
	  }
	  s+="]";
	  return s;
  }
  
  // Write the value without xml encoding it
  std::ostream& XmlRpcValue::write(std::ostream& os) const {
    switch (_type) {
      default:           break;
      case TypeBoolean:  os << _value.asBool; break;
      case TypeInt:      os << _value.asInt; break;
      case TypeDouble:   os << _value.asDouble; break;
      case TypeString:   os << *_value.asString; break;
      case TypeDateTime:
        {
          struct tm* t = _value.asTime;
          char buf[20];
          snprintf(buf, sizeof(buf)-1, "%4d%02d%02dT%02d:%02d:%02d", 
            t->tm_year,t->tm_mon,t->tm_mday,t->tm_hour,t->tm_min,t->tm_sec);
          buf[sizeof(buf)-1] = 0;
          os << buf;
          break;
        }
      case TypeBase64:
        {
          int iostatus = 0;
          std::ostreambuf_iterator<char> out(os);
          base64<char> encoder;
          encoder.put(_value.asBinary->begin(), _value.asBinary->end(), out, iostatus, base64<>::crlf());
          break;
        }
      case TypeArray:
        {
          int s = int(_value.asArray->size());
          os << '{';
          for (int i=0; i<s; ++i)
          {
            if (i > 0) os << ',';
            _value.asArray->at(i).write(os);
          }
          os << '}';
          break;
        }
      case TypeStruct:
        {
          os << '[';
          ValueStruct::const_iterator it;
          for (it=_value.asStruct->begin(); it!=_value.asStruct->end(); ++it)
          {
            if (it!=_value.asStruct->begin()) os << ',';
            os << it->first << ':';
            it->second.write(os);
          }
          os << ']';
          break;
        }
      
    }
    
    return os;
  }

} // namespace XmlRpc


// ostream
std::ostream& operator<<(std::ostream& os, XmlRpc::XmlRpcValue& v) 
{ 
  // If you want to output in xml format:
  //return os << v.toXml(); 
  return v.write(os);
}

