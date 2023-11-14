/**
 * devicetypelist.js
 **/

/**
 * Liste der verfügbaren Gerätetypen.
 **/
DeviceTypeList = Singleton.create({
  THUMBNAIL_SIZE: 50,   // Größe eines (quadratischen) Thumbnails
  IMAGE_SIZE: 250,   // Größe eines (quadratischen) Bildes
  
  /**
   * Liste der nicht löschbaren Gerätetypen
   **/
  m_undeletableTypeNames: [
    "HM-CCU-1",
    "HM-RCV-50",
    "HMW-RCV-50",
    "HM-Sec-SD-Team",
    "HmIP-CCU3",
    "RPI-RF-MOD"
  ],
  
  /**
   * Konstruktor
   **/
  initialize: function()
  {
    this.deviceTypes = {};     // verfügbare Gerätetypen
    
    for (var i = 0, len = DEV_LIST.length; i < len; i++)
    {
      var deviceType = new DeviceType(DEV_LIST[i]);
      this.deviceTypes[deviceType.id] = deviceType;
    }
  
    this.unknownType = this.deviceTypes["DEVICE"];    
  },
  
  /**
   * Ermittelt, ob ein Gerät von diesem Typ gelöscht werden kann.
   **/
  isDeletable: function(deviceType)
  {
    return !this.m_undeletableTypeNames.ex_contains(deviceType.name);
  },
  
  /**
   * Erstellt den HTML-Code zu einem Bild bzw. Thumbnail
   **/
  getPictureHTML: function(typeId, formName, size)
  {   
    var wrapper, canvas, jg, result;
    
    wrapper = document.createElement("div");
    Element.setStyle(wrapper, {display: "none"});    
    $("body").appendChild(wrapper);
    
    canvas = document.createElement("div");
    wrapper.appendChild(canvas);
    Element.setStyle(canvas, {
      position: "absolute",
      left:     "0px",
      top:      "0px"      
    });    
    
    jg = new jsGraphics(canvas);
    InitGD(jg, size);
    Draw(jg, typeId, size, formName);
    
    result = wrapper.innerHTML;
    
    Element.remove(wrapper);
    return result;
  },
  
  /**
   * Liefert die Liste aller Gerätetypen.
   **/
  listDeviceTypes: function()
  {
    return Object.values(this.deviceTypes);
  },
  
  /**
   * Liefert einen Geratetypen anhand seiner Id
   **/
  getDeviceType: function(id)
  {
    var deviceType = this.deviceTypes[id];
    
    if (typeof(deviceType) != "undefined") { return deviceType; }
    else                                   { return this.unknownType; }
  },
  
  /**
   * Liefert den HTML-Code eines Thumbnails
   **/
  getThumbnailHTML: function(typeId, formName)
  {
    return this.getPictureHTML(typeId, formName, this.THUMBNAIL_SIZE);
  },
  
  /**
   * Liefert den HTML-Code eines Bildes
   **/
  getImageHTML: function(typeId, formName)
  {
    return this.getPictureHTML(typeId, formName, this.IMAGE_SIZE);
  }

});
 