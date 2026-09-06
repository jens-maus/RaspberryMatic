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
   * Hängt die Version der HomeMatic WebUI an eine URL an,
   * um Probleme mit dem Browsercache zu umgehen.
   **/
  var addVersion = function(url)
  {
    if (0 <= url.indexOf("?")) { return url + "&_version_=" + WEBUI_VERSION; }
    else                       { return url + "?_version_=" + WEBUI_VERSION; }
  };
  
  /**
   * Lädt synchron Daten und gibt das XMLHttpRequest-Objekt zurück.
   **/
  var load = function(method, url, data)
  {
    url = addVersion(url);
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
