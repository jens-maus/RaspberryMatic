// Title: tigra slider control
// Description: See the demo at url
// URL: http://www.softcomplex.com/products/tigra_slider_control/
// Version: 1.0 (commented source)
// Date: 02/15/2006
// Tech. Support: http://www.softcomplex.com/forum/
// Notes: This script is free. Visit official site for further details.

sliderControl = function(type,id, val, iViewOnly, bSliderPosFlag,min, max, factor, unit)
{
  this.type = type;
  this.parentId = "slidCtrl"+id;
  this.s_name = id+"Perc";
  this.n_value = val;
  this.f_setValue  = f_sliderSetValue;
  this.f_getPos    = f_sliderGetPos;
  if( this.type == "thermo" )
  {
    this.screen_name = id+"Deg";
  }
  if (bSliderPosFlag) {this.bSliderPosFlag = bSliderPosFlag;} else {this.bSliderPosFlag = false;} 
 // if (unit) {this.unit=unit} else {this.unit = " %"}
  if (unit) {this.unit=unit} else {this.unit = " "}
 // if (min) {this.sMinText = min+this.unit} else {this.sMinText = "0%"}
  if (min) {this.sMinText = min+this.unit} else {this.sMinText = "0"}
  if (min) {this.min = min} else {this.min = 0}
  if (max) {this.sMaxText = max+this.unit} else {this.sMaxText = "100%"}
  if (max) {this.max = max} else {this.max = 100}
  if (factor) {this.factor = 100/(max-min);} else {this.factor = 1}

  this.n_minValue = 0;
  this.n_maxValue = 100;
  
  this.n_step = 0;
  this.s_form = null;
  this.b_vertical = false;
  this.n_zIndex = 1;
  this.iViewOnly = iViewOnly;
  
  this.b_watch = true;
  this.n_controlWidth = 200;
  this.n_controlHeight = 82;
  this.n_sliderWidth = 10;
  this.n_sliderHeight = 68;
  this.n_pathLeft = 1;
  this.n_pathTop = 1;
  this.n_pathLength = 190;
  this.s_imgControlGray = '/ise/img/slider/slider_grey.png';
  this.s_imgControlGreen = '/ise/img/slider/slider_yellow.png';
  this.s_imgSlider = '/ise/img/slider/slider.gif';  
  
  // register in the global collection  
  if (!window.A_SLIDERS)
    window.A_SLIDERS = [];
  this.n_id = window.A_SLIDERS.length;
  window.A_SLIDERS[this.n_id] = this;

  this.n_pix2value = this.n_pathLength / (this.n_maxValue - this.n_minValue);
  if (this.n_value == null)
    this.n_value = this.n_minValue;

  // generate the control's HTML
  var sSliderPos = " ";
  var iLeftTextPos = 0;
  var iRightTextPos = -18;
  if (screen.availWidth < 1100) 
  {
    iRightTextPos = -12;
  }
  // if browser is IE and in quirks mode
  if ( (NAV_IE == true && !jQuery.support.boxModel ) )
  {
    iLeftTextPos = 6; 
    this.n_pathTop = 7;   
    if(this.bSliderPosFlag && (screen.availWidth > 1100)) 
    {
      sSliderPos = "background-position:0px 7px;"; 
    }
    else
    {
    
      if (screen.availWidth < 1100) 
      {
        sSliderPos = "background-position:0px 5px;";
        this.n_pathTop = 8;
      } 
      else 
      {
        sSliderPos = "background-position:0px 9px;";
      }
    }
  } 
  else 
  {
    iLeftTextPos = -10;
    this.n_pathTop = 1;
  }
  var sHTML =  '<div style="width:' + this.n_controlWidth + 'px;height:' + this.n_controlHeight + 'px;border:0; background-repeat:no-repeat; background-position:center; background-image:url(' + this.s_imgControlGray + ')" id="sl' + this.n_id + 'base">';
  sHTML += '<div id ="spec'+id+'"><div style="width:5px;height:' + this.n_controlHeight + 'px;border:0;'+sSliderPos+'background-image:url(' + this.s_imgControlGreen + '); background-repeat:no-repeat; position:relative;left:' + this.n_pathLeft + 'px;top:' + this.n_pathTop + 'px;" id="sl' + this.n_id + 'green">';
  sHTML += '<img src="' + this.s_imgSlider + '" width="' + this.n_sliderWidth + '" height="' + this.n_sliderHeight + '" border="0" style="position:relative;left:' + this.n_pathLeft + 'px;top:' + this.n_pathTop + 'px;z-index:' + this.n_zIndex + ';cursor:pointer;visibility:hidden;" name="sl' + this.n_id + 'slider" id="sl' + this.n_id + 'slider" onmousedown="return f_sliderMouseDown(' + this.n_id + ')"/></div>';
  sHTML  += '<div id="slMin" style="position:relative;left:4px;top:'+iLeftTextPos+'px;width:'+this.n_pathLength+'px;color:black;text-align:left;z-index:4;"><b>'+this.sMinText+'</b>';
  sHTML += '<div id="slMax" style="position:relative;left:0px;top:'+iRightTextPos+'px;color:black;text-align:right;z-index:5;"><b>'+this.sMaxText+'</b></div></div>';

  sHTML += '</div></div></div>';
  if( $(this.parentId) ) $(this.parentId).innerHTML = sHTML;
  this.e_base   = get_element('sl' + this.n_id + 'base');
  this.e_green  = get_element('sl' + this.n_id + 'green');
  this.e_slider = get_element('sl' + this.n_id + 'slider');
  
  if (iViewOnly == 0) {
    // safely hook document/window events
    if (document.onmousemove != f_sliderMouseMove) {
      window.f_savedMouseMove = document.onmousemove;
      document.onmousemove = f_sliderMouseMove;
    }
    if (document.onmouseup != f_sliderMouseUp) {
      window.f_savedMouseUp = document.onmouseup;
      document.onmouseup = f_sliderMouseUp;
    }
  }
  // preset to the value in the input box if available
  var e_input = this.s_form == null
    ? get_element(this.s_name)
    : document.forms[this.s_form]
      ? document.forms[this.s_form].elements[this.s_name]
      : null;
  this.f_setValue(e_input && e_input.value != '' ? e_input.value : null, 1);
  this.e_slider.style.visibility = 'visible';
}

f_sliderSetValue = function(n_value, b_noInputCheck) {
  if (n_value == null)
    n_value = this.n_value == null ? this.n_minValue : this.n_value;
  if (isNaN(n_value))
    return false;
  // round to closest multiple if step is specified
  if (this.n_step) n_value = Math.round((n_value - this.n_minValue) / this.n_step) * this.n_step + this.n_minValue;
  // smooth out the result
  n_value = Math.round(n_value-0.5);
  if (n_value % 1) n_value = Math.round(n_value * 1e5) / 1e5;

  if (n_value < this.n_minValue)
    n_value = this.n_minValue;
  if (n_value > this.n_maxValue)
    n_value = this.n_maxValue;

  this.n_value = n_value;

  // move the slider
  if (this.b_vertical)
    this.e_slider.style.top  = (this.n_pathTop + this.n_pathLength - Math.round((n_value - this.n_minValue) * this.n_pix2value)) + 'px';
  else {
    var wVal = (this.n_pathLeft + Math.round((n_value - this.n_minValue) * this.n_pix2value)) + 'px';
    this.e_slider.style.left = wVal;
    this.e_green.style.width = wVal;
  }

  // save new value
  var e_input, e2_input;
  if (this.s_form == null) {
    e_input = get_element(this.s_name);
    
    if (!e_input)
      return b_noInputCheck ? null : f_sliderError(this.n_id, "Can not find the input with ID='" + this.s_name + "'.");
    if( this.type == "thermo" )
    {
      e2_input = get_element(this.screen_name);
      if (!e2_input) return b_noInputCheck ? null : f_sliderError(this.n_id, "Can not find the input with ID='" + this.screen_name + "'.");
    }
  }
  else {
    var e_form = document.forms[this.s_form];
    if (!e_form)
      return b_noInputCheck ? null : f_sliderError(this.n_id, "Can not find the form with NAME='" + this.s_form + "'.");
    e_input = e_form.elements[this.s_name];
    if (!e_input)
      return b_noInputCheck ? null : f_sliderError(this.n_id, "Can not find the input with NAME='" + this.s_name + "'.");
    if( this.type == "thermo" )
    {
      if (!e2_input) return b_noInputCheck ? null : f_sliderError(this.n_id, "Can not find the input with NAME='" + this.screen_name + "'.");
    }
  }
  
  e_input.value = n_value; 
  if( this.type == "thermo" )
  {
    e_input.value = e_input.value/this.factor; 
    //e2_input.value = round((n_value/this.factor)+this.min,2);
    var f = (n_value/this.factor)+this.min;
    e2_input.value = Math.floor(f) + ( Math.round( (f - Math.floor(f)) ) ? 0.5 : 0.0 );
  }
}

// get absolute position of the element in the document
f_sliderGetPos = function(b_vertical, b_base)
{
  var n_pos = 0, s_coord = (b_vertical ? 'Top' : 'Left');
  var o_elem = o_elem2 = b_base ? this.e_base : this.e_slider;
  while (o_elem)
  {
    n_pos += o_elem["offset" + s_coord];
    o_elem = o_elem.offsetParent;
  }
  o_elem = o_elem2;
  if( o_elem )
  {
    var n_offset;
    while (o_elem.tagName != "BODY")
    {
      n_offset = o_elem["scroll" + s_coord];
      if (n_offset) n_pos -= o_elem["scroll" + s_coord];
      o_elem = o_elem.parentNode;
      if( !o_elem ) break;
    }
  }
  return n_pos;
}

f_sliderMouseDown = function(n_id) {
  window.n_activeSliderId = n_id;
  return false;
}

f_sliderMouseUp = function(e_event, b_watching) {
  if (window.n_activeSliderId != null) {
    var o_slider = window.A_SLIDERS[window.n_activeSliderId];
    //if (typeof o_slider.n_minValue != 'undefined') {
      o_slider.f_setValue(o_slider.n_minValue + (o_slider.b_vertical
        ? (o_slider.n_pathLength - parseInt(o_slider.e_slider.style.top) + o_slider.n_pathTop)
        : (parseInt(o_slider.e_slider.style.left) - o_slider.n_pathLeft)) / o_slider.n_pix2value);
      if (b_watching)  return;
      window.n_activeSliderId = null;
      o_slider.e_green.style.width = (parseInt(o_slider.e_slider.style.left) - o_slider.n_pathLeft) + 3;
    //}
  }
  if (window.f_savedMouseUp)
    return window.f_savedMouseUp(e_event);
}

f_sliderMouseMove = function(e_event) {
  
  if (!e_event && window.event) e_event = window.event;

  // save mouse coordinates
  if (e_event) {
    window.n_mouseX = e_event.clientX + f_scrollLeft();
    window.n_mouseY = e_event.clientY + f_scrollTop();
  }

  // check if in drag mode
  if (window.n_activeSliderId != null) {
    var o_slider = window.A_SLIDERS[window.n_activeSliderId];
    if (!o_slider.iViewOnly) {
      var n_pxOffset;
      if (o_slider.b_vertical) {
        var n_sliderTop = window.n_mouseY - o_slider.n_sliderHeight / 2 - o_slider.f_getPos(1, 1) - 3;
        // limit the slider movement
        if (n_sliderTop < o_slider.n_pathTop)
          n_sliderTop = o_slider.n_pathTop;
        var n_pxMax = o_slider.n_pathTop + o_slider.n_pathLength;
        if (n_sliderTop > n_pxMax)
          n_sliderTop = n_pxMax;
        o_slider.e_slider.style.top = n_sliderTop + 'px';
        n_pxOffset = o_slider.n_pathLength - n_sliderTop + o_slider.n_pathTop;
      }
      else {
        var n_sliderLeft = window.n_mouseX - o_slider.n_sliderWidth / 2 - o_slider.f_getPos(0, 1) - 3;
        // limit the slider movement
        if (n_sliderLeft < o_slider.n_pathLeft)
          n_sliderLeft = o_slider.n_pathLeft;
        var n_pxMax = o_slider.n_pathLeft + o_slider.n_pathLength;
        if (n_sliderLeft > n_pxMax)
          n_sliderLeft = n_pxMax;
        o_slider.e_slider.style.left = n_sliderLeft + 'px';
        n_pxOffset = n_sliderLeft - o_slider.n_pathLeft;
      }
      if (o_slider.b_watch)
         f_sliderMouseUp(e_event, 1);
    }
    return false;
  }
  
  if (window.f_savedMouseMove)
    return window.f_savedMouseMove(e_event);
}

// get the scroller positions of the page
f_scrollLeft = function() {
  return f_filterResults (
    window.pageXOffset ? window.pageXOffset : 0,
    document.documentElement ? document.documentElement.scrollLeft : 0,
    document.body ? document.body.scrollLeft : 0
  );
}

f_scrollTop = function() {
  return f_filterResults (
    window.pageYOffset ? window.pageYOffset : 0,
    document.documentElement ? document.documentElement.scrollTop : 0,
    document.body ? document.body.scrollTop : 0
  );
}

f_filterResults = function(n_win, n_docel, n_body) {
  var n_result = n_win ? n_win : 0;
  if (n_docel && (!n_result || (n_result > n_docel)))
    n_result = n_docel;
  return n_body && (!n_result || (n_result > n_body)) ? n_body : n_result;
}

f_sliderError = function (n_id, s_message) {
  if(dbg){alert("Slider #" + n_id + " Error:\n" + s_message);}
  window.n_activeSliderId = null;
}

get_element = document.all ?
  function (s_id) { return document.all[s_id] } :
  function (s_id) { return document.getElementById(s_id) };

