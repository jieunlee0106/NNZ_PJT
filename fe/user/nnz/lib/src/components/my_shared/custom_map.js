var markers = [];

function addMarker(position) {
  var marker = new kakao.maps.Marker({ position: position });

  marker.setMap(map);

  markers.push(marker);
}

for (var i = 0; i < 3; i++) {
  addMarker(
    new kakao.maps.LatLng(33.450701 + 0.0003 * i, 126.570667 + 0.0003 * i)
  );

  kakao.maps.event.addListener(
    markers[i],
    "click",
    (function (i) {
      return function () {
        onTapMarker.postMessage("marker " + i + " is tapped");
      };
    })(i)
  );
}

var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

var mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
