function initMap() {
  var i = 0
  var myCoords = new google.maps.LatLng(49.866667, 2.333333);

  var mapOptions = {
  zoom: 3,
  streetViewControl: false,
  mapTypeControl: false,
  styles: [
    {
        "featureType": "administrative",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "color": "#444444"
            }
        ]
    },
    {
        "featureType": "administrative.country",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "on"
            },
            {
                "weight": "2"
            },
            {
                "lightness": "-60"
            }
        ]
    },
    {
        "featureType": "administrative.country",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative.province",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative.province",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative.locality",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative.locality",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative.neighborhood",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative.neighborhood",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "administrative.land_parcel",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative.land_parcel",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "all",
        "stylers": [
            {
                "color": "#f2f2f2"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape.natural",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape.natural.terrain",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape.natural.terrain",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "landscape.natural.terrain",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "all",
        "stylers": [
            {
                "saturation": -100
            },
            {
                "lightness": 45
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "all",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "all",
        "stylers": [
            {
                "color": "#3c5e6c"
            },
            {
                "visibility": "on"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    }
  ]
  };

  var map = new google.maps.Map(document.getElementById('bus-map'), mapOptions);
  var infowindow;

  var directionsService = new google.maps.DirectionsService();
  var directionsRenderer = new google.maps.DirectionsRenderer();

  directionsRenderer.setOptions({
    map: map,
    suppressMarkers: true,
    polylineOptions: {
      strokeColor: '#e9d520'
    }
  })

    // Bounds to reset map 
    var bounds = new google.maps.Circle({center: myCoords, radius: 900000}).getBounds();

    function CenterControl(controlDiv, map) {

        // Set CSS for the control border.
        var controlUI = document.createElement('div');
        controlUI.style.backgroundColor = 'rgb(150, 150, 150)';
        controlUI.style.border = '1px solid #fff';
        controlUI.style.borderRadius = '3px';
        controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
        controlUI.style.cursor = 'pointer';
        controlUI.style.marginBottom = '15px';
        controlUI.style.textAlign = 'center';
        controlDiv.appendChild(controlUI);

        // Set CSS for the control interior.
        var controlText = document.createElement('div');
        controlText.style.color = 'rgb(255,255,255)';
        controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
        controlText.style.fontSize = '12px';
        controlText.style.lineHeight = '38px';
        controlText.style.paddingLeft = '5px';
        controlText.style.paddingRight = '5px';
        controlText.innerHTML = I18n.t("js.maps.share.center_map");
        controlUI.appendChild(controlText);

        // Setup the click event listeners: simply set the map to Chicago.
        controlUI.addEventListener('click', function() {
            if (infowindow) {
                infowindow.close();
            }
            map.fitBounds(bounds);
        });

    }

    // Create the DIV to hold the control and call the CenterControl()
    // constructor passing in this DIV.
    var centerControlDiv = document.createElement('div');
    var centerControl = new CenterControl(centerControlDiv, map);

    centerControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(centerControlDiv);

  // Create an array of alphabetical characters used to label the markers.
  var labels = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!-';

    if (typeof trips !== 'undefined') {
        function codeAddress() {

            var tripIndex = 0

            function next() {
                if (tripIndex < trips.length) {
                    var search = trips[tripIndex].departure_lat
                    ++tripIndex;

                    var geocoder = new google.maps.Geocoder;
                    geocoder.geocode({'location': search}, function(results, status){
                        if (status === 'OK') {
                            if (results != null) {
                                createBusMarker(results[0]);
                            }; 
                        } else {
                            console.log(status)
                        };
                        setTimeout(function(){
                            next();
                        }, 1000);
                    });
                }
            }
            next();
        }

        codeAddress();

        var startPoint = trips[0].departure_lat
        var endPoint = trips[trips.length-1].arrival_lat
        var steps = []

        for (var y = 1; y < trips.length; y++) {
            var currentElement = trips[y];
            steps.push ({
            location: currentElement.departure_lat,
            stopover: true});
            };

        function calcRoute() {
            var requestRoute = {
            origin: startPoint,
            destination: endPoint,
            waypoints: steps,
            travelMode: 'DRIVING'
            };
            directionsService.route(requestRoute, function(result, status) {
            if (status == 'OK') {
                directionsRenderer.setDirections(result);
            }
            });
        }

        calcRoute();

        var iconRound = {
            url: '../images/marker_yellow_big.png', // url
            scaledSize: new google.maps.Size(60, 60), // scaled size
            origin: new google.maps.Point(0,0), // origin
            anchor: new google.maps.Point(30, 50), // anchor
            labelOrigin: new google.maps.Point(30, 25)
        };

        var flagIcon = {
            url: '../images/marker_flag.png', // url
            scaledSize: new google.maps.Size(60, 60), // scaled size
            origin: new google.maps.Point(0,0), // origin
            anchor: new google.maps.Point(14, 50), // anchor
            labelOrigin: new google.maps.Point(30, 25)
        };

        // Create last marker on map with flag
        // Unless the values from the first trip departure and the last one are equal (avoid a flag on top of a marker)
        var arrivalPoint = trips[trips.length-1].arrival_lat
        var departurePoint = trips[0].departure_lat
        var geocoder = new google.maps.Geocoder;
        geocoder.geocode({'location': arrivalPoint}, function(results, status){
            if (status === 'OK') {
                if (results != null & JSON.stringify(arrivalPoint) != JSON.stringify(departurePoint)) {
                    createLastMarker(results[0]);
                }; 
            } else {
                console.log(status)
            };
        });

        function createLastMarker(place) {
            new google.maps.Marker({
                map: map,
                animation: google.maps.Animation.DROP,
                position: place.geometry.location,
                icon: flagIcon,
            });
        }

        google.maps.event.addListener(map, "click", function() {
            if(infowindow){
                infowindow.close();
            }
        });

        function createBusMarker(place) {
            var marker = new google.maps.Marker({
                map: map,
                animation: google.maps.Animation.DROP,
                position: place.geometry.location,
                name: trips[i % trips.length].name,
                id: trips[i % trips.length].id,
                label: {
                    color: 'black',
                    fontSize: '15px',
                    fontWeight: 'bold',
                    text: trips[i % trips.length].week,
                    },
                    icon: iconRound,
                });
                
                var contentString = '<div id="content" class="gm-style-iw">'+
                    '<div id="siteNotice">'+
                    '</div>'+
                    '<h1 id="firstHeading" class="firstHeading" style="font-size: 15px;"> <b>' + marker.name + '</b></h1>'+
                    '<div id="bodyContent" style="font-size: 12px; line-height: 2px;">'+
                    '<p>' + '<span style="text-decoration: underline;">' + 
                    I18n.t("js.maps.trips.from_word") + 
                    '</span>' + ": " + '<b>' + trips[i % trips.length].departure + '</b>' +'</p>'+
                    '<p>' + '<span style="text-decoration: underline;">' + 
                    I18n.t("js.maps.trips.to_word") + 
                    '</span>' + ": " + '<b>' + trips[i % trips.length].arrival + '</b>' +' </p>'+
                    '</div>'+
                    '</div>';
                
                google.maps.event.addListener(marker, 'click', function() {
                    if(infowindow){
                        infowindow.close();
                    }
                    infowindow = new google.maps.InfoWindow();
                    infowindow.setContent(contentString);
                    infowindow.open(map, this);
                    map.panTo(this.getPosition());
                });
            i++;
        }
    }
}