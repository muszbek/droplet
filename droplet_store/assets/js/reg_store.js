initMap = function() {
    const batman = { lat: 37.889, lng: 41.128 };

    const map = new google.maps.Map(document.getElementById("map"), {
	zoom: 14,
    });
    
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

    /*const marker = new google.maps.Marker({
	position: batman,
	map: map,
    });*/
}
