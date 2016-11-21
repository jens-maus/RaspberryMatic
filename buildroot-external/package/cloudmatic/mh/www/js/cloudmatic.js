$(document).ready(function() {
  $(".button-collapse").sideNav({ closeOnClick: true });
  var section = getParameterByName('s');
  if (section != null) {
    $(".cm-nav").each(function() {
      $(this).parent().removeClass("active");
      if ($(this).data("content") == section) {
        $(this).parent().addClass("active");
      }
    });
    $(".cm-content").each(function(e) {
      $("#"+this.id).hide();
    });
    $("#"+section).show();
  } else {
    $("#status").show();
  }
  $(".cm-nav").click(function() {
    $(".cm-nav").each(function() {
      $(this).parent().removeClass("active");
    });
    $(".cm-content").each(function(e) {
      $("#"+this.id).hide();
    });
    $(this).parent().addClass("active");
    $("#"+$(this).data("content")).show();
  });
  $(".cancelregister").click(function(e) {
    e.preventDefault();
    $(".modal-submit").attr("href","?s=services");
    $("#service_modal_headline").html('<h5>Registrierung wird zur&uuml;ckgesetzt</h5><br>');
    postdata(this);
  });
  $(".startservice").click(function(e) {
    e.preventDefault();
    $(".modal-submit").attr("href","?s=services");
    $("#service_modal_headline").html('<h5>Dienst wird gestartet</h5>Der Dienst wird gestartet, bitte haben Sie einen Moment Geduld ...<br><br>');
    postdata(this);
  });
  $(".stopservice").click(function(e) {
    e.preventDefault();
    $(".modal-submit").attr("href","?s=services");
    $("#service_modal_headline").html('<h5>Dienst wird beendet</h5>Der Dienst wird beendet, bitte haben Sie einen Moment Geduld ...<br><br>');
    postdata(this);
  });
  $(".startupdate").click(function(e) {
    e.preventDefault();
    $(".modal-submit").attr("href","?s=update");
    $("#service_modal_headline").html('<h5>Updates werden aktiviert</h5>Die automatischen Updates werden aktiviert, bitte haben Sie einen Moment Geduld ...<br><br>');
    postdata(this);
  });
  $(".stopupdate").click(function(e) {
    e.preventDefault();
    $(".modal-submit").attr("href","?s=update");
    $("#service_modal_headline").html('<h5>Updates werden deaktiviert</h5>Ddie automatischen Updates werden deaktiviert, bitte haben Sie einen Moment Geduld ...<br><br>');
    postdata(this);
  });
  $(".manualupdate").click(function(e) {
    e.preventDefault();
    $(".modal-submit").attr("href","?s=update");
    $("#service_modal_headline").html('<h5>Update wird ausgef&uuml;hrt</h5>Das manuelle Update wird ausgef&uuml;hrt, bitte haben Sie einen Moment Geduld ...<br><br>');
    postdata(this);
  });
  $("#delete").click(function(e) {
     e.preventDefault();
     $("#delete_modal").openModal({dismissible: false});
     $("#dodelete").click(function(f) {
       f.preventDefault();
       $("#predelete").hide();
       $("#postdelete").show();
       $.get("cleanup.cgi", function( data ) {
         $("#deleteresult").html(data);
         $("#deletespinner").hide();
         $("#deleteresult").show();
         $(".postdelete").show();
      });
     });
  });
  function postdata(e) {
    $("#serviceresult").hide('');
    $("#spinner").show();
    $("#service_modal").openModal();
    $.post($(e).attr('href'), function(data) {
      $("#serviceresult").html(data);
      $("#spinner").hide();
      $("#serviceresult").show();
    });
  }
  function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)", "i"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
  }
});
