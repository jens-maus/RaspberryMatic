<!--<html>
<head>-->


<script type="text/javascript">
	setPath("<span onclick='WebUI.enter(SystemConfigPage);'>"+translateKey('menuSettingsPage')+"</span> &gt; "+ translateKey('menuGroupListPage'));

</script>
<!--</head>
<body>-->
<div id="GroupListBody" style="display: none">
<table class="tTable"  border="0" cellpadding="0" cellspacing="0">
    <thead>
    <tr data-bind="foreach: groupListHeaders">
        <td style="height: 40px" class="thCell CLASS04900 clickable" data-bind="click: $parent.sortGroupList, text: title, css: headerClass, attr: {colspan: colspan}"></td>
    </tr>
    </thead>
  <tbody data-bind="foreach: groupList">

    <tr class="CLASS04901">
        <td class="tBodyCell" data-bind="text: id" style="width: 65px; text-align: center"></td>
        <td class="tBodyCell" data-bind="text: name"></td>
        <td class="tBodyCell" data-bind="text: groupTypeLabel"></td>

        <td class="tBodyCell" data-bind="text: virtualDeviceSerialNumber"></td>
        <!--<td class="tBodyCell" data-bind="text: virtualDeviceName"></td>-->
        <td class="tBodyCell" data-bind="text: groupDeviceName"></td>
        <td class="tBodyCell"  style="width: 0; padding-left: 10px; padding-right: 10px">
            <input style="margin: 5px; display: block" type="button" name="btnVirtualDeviceStateAndOperating" value="btnVirtualDeviceStateAndOperating" class="StdButton CLASS04907" data-bind="click: operateVirtualDevice"/>
            <input style="margin: 5px; display: block" type="button" name="btnVirtualDeviceConfiguration" value="btnVirtualDeviceConfiguration" class="StdButton CLASS04907" data-bind="click: configureVirtualDevice"/>
        </td>

        <!-- Start action column -->
        <td class="tBodyCell CLASS04902" style="width: 0; padding-left: 10px; padding-right: 10px">
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td class="CLASS04903">
                                    <input type="button" name="btnRemove" value="btnRemove" class="StdButton CLASS04907" data-bind="click: $root.removeGroup"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td class="CLASS04903">
                                    <input type="button" name="btnEdit" value="btnEdit" class="StdButton CLASS04907" data-bind="click: $root.editGroup"/>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
  

  </tbody>
</table>
<script type="text/javascript">

    var sessionTimeoutErrorCode = "42";



    //The Viewmodel
    function GroupListViewModel()
    {
        var self = this;
        var devicesToConfigureAsJson = JSON.parse('{"devices" : ${devicesToConfigure}}');

        self.isDeleting = ko.observable(false);

        self.devicesToConfigure = ko.observableArray();

        ko.utils.arrayForEach(devicesToConfigureAsJson.devices, function(item) {
            self.devicesToConfigure.push(new GroupDevice(item.id, item.serialNumber, item.type));
        });

        self.areDevicesToConfigure = ko.computed( function()
        {
            return self.isDeleting() == false && self.devicesToConfigure().length > 0;
        });

        self.groupList = ko.observableArray();
        <#list objectList as group>self.groupList.push(new VirtualGroup("${group.getId()}", "${group.getName()}",  translateKey("${group.getGroupDefinition().getGroupType().getLabel()}"), "${group.getGroupDefinition().getGroupType().getId()}"));</#list>

        self.groupListHeaders = new Array();
        self.groupListHeaders.push(new Header(translateKey('groupID'), 'id'));
        self.groupListHeaders.push(new Header(translateKey('groupGroupName'), 'name'));
        self.groupListHeaders.push(new Header(translateKey('groupTypeLabel'), 'groupTypeLabel'));

        var header = new Header(translateKey('virtualDeviceSerialNumber'), 'virtualDeviceSerialNumber');
        header.colspan = 3;
        self.groupListHeaders.push(header);
        self.groupListHeaders.push(new Header(translateKey('groupAction'), 'groupAction'));
        self.activeGroupListHeader = self.groupListHeaders[0];

        self.sortGroupList = function(header, event){
            if(self.activeGroupListHeader === header) {
                header.asc = !header.asc;
            } else {
                self.activeGroupListHeader.isActive(false);
                self.activeGroupListHeader = header;
            }
            header.isActive(true);
            var prop = header.sortPropertyName;
            var ascSort = function(a,b){ return a[prop] < b[prop] ? -1 : a[prop] > b[prop] ? 1 : a[prop] == b[prop] ? 0 : 0; };
            var descSort = function(a,b){ return ascSort(b,a); };
            var sortFunc = header.asc ? ascSort : descSort;
            self.groupList.sort(sortFunc);
        };

        self.editGroup = function(group)
        {
            ShowWaitAnim();
            HideWaitAnimAutomatically(60);
            var url = '/pages/jpages/group/edit?sid='+SessionId;
            var data = new Object();
            data.groupId = group.id;
            data.groupDeviceName = (group.device != undefined) ? group.device.getName() : "";
            var pb = JSON.stringify(data);

            var opt = {
                postBody: pb,
                onComplete: function(t)
                {
                    HideWaitAnim();
                    var response = JSON.parse(t.responseText);
                    if(response.isSuccessful)
                    {
                        jQuery("#content").html(response.content);
                    }
                    else
                    {
                        if(response.errorCode == sessionTimeoutErrorCode)
                        {
                            jQuery("#content").html(response.content);
                        }
                    }
                }
            }

            new Ajax.Request(url,opt);
        };

        self.removeGroup = function(group)
        {
            self.isDeleting(true);
            var url = '/pages/jpages/group/delete?sid='+SessionId;
            var data = new Object();
            data.groupId = group.id;
            var pb = JSON.stringify(data);
            var opt = {
                postBody: pb,
                onComplete: function(t){
                    var response = JSON.parse(t.responseText);
                    self.isDeleting(false);
                    if(response.isSuccessful)
                    {
                        self.groupList.remove(group);
                        var devicesToConfigureFromGroup = JSON.parse('{"devices" : '+response.content+'}');
                        ko.utils.arrayForEach(devicesToConfigureFromGroup.devices, function(item){
                            homematic("Device.getReGaIDByAddress", {address:item.id}, function(result) {
                                homematic("Interface.setMetadata", {"objectId":DeviceList.getDeviceByAddress(item.id.split(":")[0]).id, "dataId": "inHeatingGroup", "value" : "false"});
                                homematic("Device.setOperateGroupOnly", {id:result, mode: false}, function() {
                                    if (result != "noDeviceFound") {
                                        DeviceList.devices[result].isOperateGroupOnly = false;
                                    }
                                });
                            });
                            self.addDeviceToList(item.id, item.name, item.type);
                        });
                        jQuery("[name='groupDev']").each(function(index,chType) {
                          var txtElm = jQuery(this);
                          txtElm.text(translateKey(txtElm.text()));
                        });
                        translatePage(".toTranslate");
                    }
                    else
                    {
                        if(response.errorCode == sessionTimeoutErrorCode)
                        {
                            jQuery("#content").html(response.content);
                        }
                    }
                }
            }

            new Ajax.Request(url,opt);
        };

        self.addDeviceToList = function (id, name, type)
        {
            var device = new GroupDevice(id, name, type);
            self.devicesToConfigure.push(device);
        }

        self.ignoreConfigure = function()
        {
            self.devicesToConfigure.removeAll();
        };

        self.checkConfigure = function()
        {
            var tempDevicesToConfigure = new Array();
            ko.utils.arrayForEach(self.devicesToConfigure(), function(item) {
                tempDevicesToConfigure.push(item);
            });

            ko.utils.arrayForEach(tempDevicesToConfigure, function(item) {
                if(item.getConfigPending()==false)
                {
                    self.devicesToConfigure.remove(item);
                }
            });
        };

        self.checkConfigurePending = function(group)
        {
            var data = '{ "virtualDeviceSerialNumber" : "' + group.virtualDeviceSerialNumber + '" }';
            CreateCPPopup("/pages/jpages/group/configureDevices", data);
        };



    }
    var viewModel = new GroupListViewModel();

    // Activates knockout.js
    // This Page needs a new ViewModel
    ko.applyBindings(viewModel, document.getElementById('GroupListBody'));


  NewGroup = function()
  {
    ShowWaitAnim();
	jQuery.ajax({
	url: "/pages/jpages/group/create?sid="+SessionId,
	context: document.body,
	cache : false
	}).done(function(data) {
        HideWaitAnim();
        var response = JSON.parse(data);

        if(response.isSuccessful)
        {
            jQuery("#content").html(response.content);
        }
        else
        {
            if(response.errorCode == sessionTimeoutErrorCode)
            {
                jQuery("#content").html(response.content);
            }
            else {
                jQuery("#content").html(translateKey(response.content));
            }
        }
    });
  };

  /*OpenDevice = function() {
        var data = '{ "serialNumber" : "KEQ0319053", "regaID" : "2254" }';
        CreateCPPopup("/pages/jpages/group/listPossibleGroups", data);
    } */
 
  var s = "";
  s += "<table cellspacing='8'>";
  s += "<tr>";
    s += "<td align='center' valign='middle'><div class='FooterButton' onclick='WebUI.goBack();'>"+ translateKey('footerBtnPageBack') +"</div></td>";
    s += "<td align='center' valign='middle'><div class='FooterButton' onclick='NewGroup();'>"+ translateKey('footerBtnNew') +"</div></td>";
    /*s += "<td align='center' valign='middle'><div class='FooterButton' onclick='OpenDevice();'>Knopf</div></td>";*/
   s += "</tr>";
  s += "</table>";
  setFooter(s);
  translateButtons("btnRemove, btnEdit");
  translateButtons("btnVirtualDeviceStateAndOperating");
  translateButtons("btnVirtualDeviceConfiguration");
  translatePage();
  jQuery("#GroupListBody").show();

</script>
<div class="DialogLayer" style="z-index: 200; position: absolute; top: 0px; left: 0px; display: none" data-bind="visible: isDeleting">
    <div class="UIFrame" style="width: 324px; height:86px; top: 260px; left: 480px">
        <div class="UIFrameTitle" style="top: 2px; left: 2px; width: 320px; height: 20px; line-height: 20px;">
            ${"$"}{groupWillBeDeletedHeader}
        </div>
        <div class="UIFrameContent" style="top: 24px; left: 2px; width: 320px; height: 60px;">
            <div class="UIText" style="top: 10px; left:10px; width:310px">
                <img src="/ise/img/ajaxload_white.gif" style="float:left;margin-right:10px" />${"$"}{groupWillBeDeletedContent}
            </div>
        </div>
    </div>
</div>
<div data-bind="visible: areDevicesToConfigure"  style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 149; background-image: url('/ise/img/tr50.gif'); display: none">
<div style="position: absolute; z-index: 159; width: 100%; top: 50%;">
    <meta content="no-cache" http-equiv="cache-control">
    <meta content="no-cache" http-equiv="pragma">
    <meta content="0" http-equiv="expires">
    <title>response of request with command: removeLink</title>
    <div style="width: 800px; height: 600px; padding: 0px; position: absolute; left: 50%; margin-left: -400px; margin-top: -150px;">
        <div class="popupTitle" style="font-weight: bold;">${"$"}{dialogCreateLinkTitle}</div>
        <div style="overflow: auto; width: 100%; height: 50%;">
            <div >
                <table class="popupTable" border="1">
                    <thead>
                    <tr class="popupTableHeaderRow">
                        <th>${"$"}{thName}</th>
                        <th>${"$"}{thTypeDescriptorWOLineBreak}</th>
                        <th>${"$"}{thPicture}</th>
                        <th>${"$"}{thHint}</th>
                    </tr>
                    </thead>
                    <tbody data-bind="foreach: devicesToConfigure">
                        <tr class="popupTableRowGray">
                            <td data-bind="text: name"></td>
                            <td name="groupDev" data-bind="text: type"></td>
                            <td style="background-color: white;">
                                <div style="position: relative;" data-bind="event: {mouseover: showDevicePicture, mouseout: hideDevicePicture}">
                                    <img data-bind="attr:{src: imagePath, title: name, alt: name}">
                                </div>
                            </td>
                            <td class="toTranslate" align="left" style="padding: 5px; color: red; font-weight: bold;" data-bind="attr:{rowspan: $root.devicesToConfigure().length}, visible: $root.devicesToConfigure()[0] == $data">
                                ${"$"}{dialogCreateLinkErrorContent1}
                                <ul>
                                    <li>
                                        ${"$"}{dialogCreateLinkErrorContent2}
                                        <ul>
                                            <li>${"$"}{dialogCreateLinkErrorContent3}</li>
                                            <li>${"$"}{dialogCreateLinkErrorContent4}</li>
                                        </ul>
                                    </li>
                                    <li>${"$"}{dialogCreateLinkErrorContent5}</li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="CLASS10200">
                <span class="CLASS10101 colorGradient borderRadius2px" data-bind="click: checkConfigure">${"$"}{btnDirectDeviceLinkCheckAgain}</span>
                <span class="CLASS10101 colorGradient borderRadius2px" data-bind="click: ignoreConfigure">${"$"}{lblIgnore}</span>
            </div>
        </div>
    </div>
</div>
</div>
</div>

<!--</body>
</html>-->
