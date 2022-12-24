import GMaps from 'gmaps/gmaps.js';

const mapElement = document.getElementById('map');
// console.log(mapElement);
if (mapElement) {
  const map = new GMaps({ el: '#map', lat: 0, lng: 0 });
  // console.log(map);
  const markers = JSON.parse(mapElement.dataset.markers);
  // console.log(markers);
  map.addMarkers(markers);
  if (markers.length === 0) {
    map.setZoom(2);
  } else if (markers.length === 1) {
    map.setCenter(markers[0].lat, markers[0].lng);
    map.setZoom(14);
  } else {
    map.fitLatLngBounds(markers);
  }
}
