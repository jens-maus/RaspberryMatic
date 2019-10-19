/**
 * httploader.js
 **/
 
/**
 * Lädt XML- bzw Textdateien synchron.
 **/ 
HttpLoader = new function()
{
  /*####################*/
  /*# Private Elemente #*/
  /*####################*/
  
  /**
   * Lädt synchron Daten und gibt das XMLHttpRequest-Objekt zurück.
   **/
  var load = function(method, url, data)
  {
    var xhr = XMLHttpRequest_create();
    
    if (null !== xhr)
    {
      xhr.open(method, url, false);
      xhr.send(data);
      if ((xhr.status != 200) && (xhr.status !== 0)) { xhr = null; }
    }
    
    return xhr;
  };
 
  /*########################*/
  /*# Öffentliche Elemente #*/
  /*########################*/
  
  /**
   * Lädt einen Text synchron.
   **/
  this.getText = function(url)
  {
    var xhr = load("GET", url, null);
    
    if (null !== xhr) { return xhr.responseText; }
    else              { return ""; }
  };
  
  /**
   * Lädt ein XML-Dokument synchron.
   **/
  this.getXML = function(url)
  {
    var xhr = load("GET", url, null);
    
    if (null !== xhr) { return xhr.responseXML; }
    else              { return null; }
  };

}();
