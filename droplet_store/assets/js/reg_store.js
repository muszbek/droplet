initMap = function() {
    const map = new google.maps.Map(document.getElementById("map"), {
	zoom: 14,
    });
    
    initLocation(map);
    initSearch(map);
}

function initLocation(map) {
    const batman = { lat: 37.889, lng: 41.128 };
    
    if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(
	    (position) => {
		pos = {
		    lat: position.coords.latitude,
		    lng: position.coords.longitude,
		};
		map.setCenter(pos);
	    },
	    () => {
		console.log("Browser doesn't support geolocation");
		map.setCenter(batman);
	    }
	);
    } else {
	console.log("Geolocation failed");
	map.setCenter(batman);
    }
}

function initSearch(map) {
    const foundZoom = 17;
    
    const input = document.getElementById("store_address");
    const searchBox = new google.maps.places.SearchBox(input);

    var marker;

    searchBox.addListener("places_changed", () => {
	place = searchBox.getPlaces()[0];
	console.log(place);

	if (marker) {
	    marker.setMap(null);
	}
	
	pos = place.geometry.location;
	marker = new google.maps.Marker({
	    position: pos,
	    map: map,
	});
	map.setCenter(pos);
	map.setZoom(foundZoom);

	document.getElementById("store_google_id").value = place.place_id;
	document.getElementById("store_lat").value = pos.lat();
	document.getElementById("store_lng").value = pos.lng();
    });
}
