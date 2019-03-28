/**
 * Node Native Module for Lib Sodium
 *
 * @Author Pedro Paixao
 * @email paixaop at gmail dot com
 * @License MIT
 */
#ifndef __NODE_SODIUM_H__
#define __NODE_SODIUM_H__

#include <node.h>
#include <node_buffer.h>

#include <cstdlib>
#include <ctime>
#include <cstring>
#include <string>
#include <sstream>

#include <nan.h>

#include "sodium.h"

using namespace node;
using namespace v8;

// As per Libsodium install docs
#define SODIUM_STATIC

// Check if a function argument is a node Buffer. If not throw V8 exception
#define ARG_IS_BUFFER(i, NAME) \
    if (!Buffer::HasInstance(info[i])) { \
       return Nan::ThrowError("argument " #NAME " must be a buffer"); \
    }

#define ARG_IS_BUFFER_OR_NULL(i, NAME) \
    if (!Buffer::HasInstance(info[i])) { \
        if( !info[i]->IsNull() ) { \
            return Nan::ThrowError("argument " #NAME " must be a buffer or null"); \
        } \
    }

// Create a new buffer, and get a pointer to it
#define NEW_BUFFER_AND_PTR(name, size) \
    Local<Object> name = Nan::NewBuffer(size).ToLocalChecked(); \
    unsigned char* name ## _ptr = (unsigned char*)Buffer::Data(name)

#define GET_ARG_AS(i, NAME, TYPE) \
    ARG_IS_BUFFER(i,#NAME); \
    TYPE NAME = (TYPE) Buffer::Data(info[i]->ToObject()); \
    unsigned long long NAME ## _size = Buffer::Length(info[i]->ToObject()); \
    if( NAME ## _size == 0 ) { }

#define GET_ARG_AS_OR_NULL(i, NAME, TYPE) \
    TYPE NAME; \
    unsigned long long NAME ## _size = 0; \
    if( !info[i]->IsNull() ) { \
        ARG_IS_BUFFER(i,#NAME); \
        NAME = (TYPE) Buffer::Data(info[i]->ToObject()); \
        NAME ## _size = Buffer::Length(info[i]->ToObject()); \
        if( NAME ## _size == 0 ) { } \
    } else { \
        NAME = NULL; \
    }

#define GET_ARG_AS_LEN(i, NAME, MAXLEN, TYPE) \
    GET_ARG_AS(i, NAME, TYPE); \
    if( NAME ## _size != MAXLEN ) { \
        return Nan::ThrowError("argument " #NAME " must be " #MAXLEN " bytes long"); \
    }

#define GET_ARG_AS_UCHAR(i, NAME) \
    GET_ARG_AS(i, NAME, unsigned char*)

#define GET_ARG_AS_UCHAR_LEN(i, NAME, MAXLEN) \
    GET_ARG_AS_LEN(i, NAME, MAXLEN, unsigned char*)

#define GET_ARG_AS_VOID(i, NAME) \
    GET_ARG_AS(i, NAME, void*)

#define GET_ARG_AS_VOID_LEN(i, NAME, MAXLEN) \
    GET_ARG_AS_LEN(i, NAME, MAXLEN, void*)

#define GET_ARG_NUMBER(i, NAME) \
    uint32_t NAME; \
    if (info[i]->IsUint32()) { \
        NAME = info[i]->Uint32Value(); \
    } else { \
        return Nan::ThrowError("argument " #NAME " must be a number"); \
    }

#define GET_ARG_AS_STRING(i, NAME) \
    Local<String> NAME;\
    if (info[i]->IsString()) { \
        NAME = info[i]->ToString(); \
    } else { \
        return Nan::ThrowError("argument " #NAME " must be a string"); \
    }

#define ARG_TO_BUFFER_TYPE(NAME, TYPE)              GET_ARG_AS(_arg, NAME, TYPE); _arg++
#define ARG_TO_BUFFER_TYPE_LEN(NAME, MAXLEN, TYPE)  GET_ARG_AS_LEN(_arg, NAME, MAXLEN, TYPE); _arg++
#define ARG_TO_NUMBER(NAME)                         GET_ARG_NUMBER(_arg, NAME); _arg++
#define ARG_TO_VOID_BUFFER_LEN(NAME, MAXLEN)        GET_ARG_AS_VOID_LEN(_arg, NAME, MAXLEN); _arg++
#define ARG_TO_VOID_BUFFER(NAME)                    GET_ARG_AS_VOID(_arg, NAME); _arg++
#define ARG_TO_UCHAR_BUFFER(NAME)                   GET_ARG_AS_UCHAR(_arg, NAME); _arg++
#define ARG_TO_UCHAR_BUFFER_LEN(NAME, MAXLEN)       GET_ARG_AS_UCHAR_LEN(_arg, NAME, MAXLEN); _arg++
#define ARG_TO_BUFFER_OR_NULL(NAME, TYPE)           GET_ARG_AS_OR_NULL(_arg, NAME, TYPE); _arg++
#define ARG_TO_UCHAR_BUFFER_OR_NULL(NAME)           GET_ARG_AS_OR_NULL(_arg, NAME, unsigned char*); _arg++
#define ARG_TO_STRING(NAME)                         GET_ARG_AS_STRING(_arg, NAME); _arg++

#define ARG_TO_UCHAR_BUFFER_LEN_OR_NULL(NAME, MAXLEN) \
    GET_ARG_AS_OR_NULL(_arg, NAME, unsigned char*); \
    if( NAME ## _size != 0 && NAME ## _size != MAXLEN ) { \
        return Nan::ThrowError("argument " #NAME " must be " #MAXLEN " bytes long or null"); \
    } \
    _arg++


#define CHECK_MAX_SIZE(NAME, MAX_SIZE)  \
    if( NAME > MAX_SIZE ) {     \
        return Nan::ThrowError(#NAME " size cannot be bigger than " #MAX_SIZE " bytes"); \
    }

#define CHECK_MIN_SIZE(NAME, MIN_SIZE)  \
    if( NAME < MIN_SIZE ) {     \
        return Nan::ThrowError(#NAME " size cannot be smaller than " #MIN_SIZE " bytes"); \
    }

#define CHECK_SIZE(NAME, MIN_SIZE, MAX_SIZE) \
    CHECK_MIN_SIZE(NAME, MIN_SIZE); \
    CHECK_MAX_SIZE(NAME, MAX_SIZE)

#define ARGS(n, message) \
    int _arg = 0;        \
    NUMBER_OF_MANDATORY_ARGS(n, message)

#define NUMBER_OF_MANDATORY_ARGS(n, message) \
    if (info.Length() < (n)) {               \
        return Nan::ThrowError(message);     \
    }

#define TO_REAL_BUFFER(slowBuffer, actualBuffer) \
    Handle<Value> constructorArgs ## slowBuffer[3] = \
        { slowBuffer->handle_, \
          Nan::New<Integer>(Buffer::Length(slowBuffer)), \
          Nan::New<Integer>(0) }; \
    Local<Object> actualBuffer = bufferConstructor->NewInstance(3, constructorArgs ## slowBuffer);

#define NEW_INT_PROP(NAME) \
    Nan::Maybe<bool> NAME ##_r = \
        target->DefineOwnProperty( \
            Nan::GetCurrentContext(), \
            Nan::New<String>(#NAME).ToLocalChecked(), \
            Nan::New<Integer>(NAME), ReadOnly); \
    if( NAME ## _r.IsNothing() ) { \
        Nan::ThrowError("Property " #NAME " could not be set!"); \
    } 

#define NEW_NUMBER_PROP(NAME) \
    Nan::Maybe<bool> NAME ##_r = \
        target->DefineOwnProperty( \
            Nan::GetCurrentContext(), \
            Nan::New<String>(#NAME).ToLocalChecked(), \
            Nan::New<Number>(NAME), ReadOnly); \
    if( NAME ## _r.IsNothing() ) { \
        Nan::ThrowError("Property " #NAME " could not be set!"); \
    }

#define NEW_STRING_PROP(NAME) \
    Nan::MaybeLocal<String> NAME ## _mvalue = String::NewFromOneByte(Isolate::GetCurrent(), (uint8_t*) &NAME[0], v8::NewStringType::kNormal); \
    Local<Value> NAME ## _value = NAME ## _mvalue.ToLocalChecked(); \
    Nan::Maybe<bool> NAME ## _r = \
        target->DefineOwnProperty( \
            Nan::GetCurrentContext(), \
            Nan::New<String>(#NAME).ToLocalChecked(), \
            NAME ## _value, \
            ReadOnly); \
    if( NAME ## _r.IsNothing() ) { \
        Nan::ThrowError("Property " #NAME " could not be set!"); \
    }

#define NEW_METHOD(NAME) \
    Nan::SetMethod(target, #NAME, bind_ ## NAME)

#define NEW_METHOD_ALIAS(NAME, LINKTO) \
    Nan::SetMethod(target, #NAME, bind_ ## LINKTO)

#define JS_OBJECT_SET_PROPERTY(OBJ, PROP, VALUE) \
    Nan::Maybe<bool> OBJ ## _ ## VALUE ## _bool = \
        OBJ->DefineOwnProperty( \
            Nan::GetCurrentContext(), \
            Nan::New<String>(PROP).ToLocalChecked(), \
            Nan::New<Value>(VALUE), \
            DontDelete); \
    if( OBJ ## _ ## VALUE ## _bool.IsNothing() ) {}

#define JS_OBJECT(OBJ) \
    info.GetReturnValue().Set(OBJ)

#define JS_UNDEFINED \
    JS_OBJECT(Nan::Undefined())

#define JS_NULL \
    JS_OBJECT(Nan::Null())

#define JS_FALSE \
    JS_OBJECT(Nan::False())

#define JS_TRUE \
    JS_OBJECT(Nan::True())

#define JS_TYPE(OBJ, TYPE) \
    JS_OBJECT(Nan::New<TYPE>(OBJ))

#define JS_UINT32(OBJ) \
    JS_TYPE(OBJ, Uint32)

#define JS_INTEGER(OBJ) \
    JS_TYPE(OBJ, Integer)
    
#define JS_STRING(OBJ) \
    JS_OBJECT(Nan::New<String>(OBJ).ToLocalChecked())

#define JS_BUFFER(OBJ) \
    JS_OBJECT(OBJ)

#endif