;
$(document).on('ready turbolinks:load', function () {
    // This is called on the first page load *and* also when the page is changed by turbolinks
    initMap();
});

function initMap() {
  let loc = document.getElementById('map').getAttribute('data-loc');
  let [x,y] = loc.replace(/[^\d .-]/g,'').trim().split(/\s+/);
  let lat = parseFloat(x);
  let lng = parseFloat(y);
  let location = { lat, lng };
  let map = new google.maps.Map(document.getElementById("map"), {
    center: location,
    zoom: 14,
  });
  new google.maps.Marker({
    position: location,
    map : map
  })
  }


function formToggle() {
  $('#create_post').toggle();
  $('#create_event').toggle();
}