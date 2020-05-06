function initMap() {
    var i = 0
  var myCoords = new google.maps.LatLng(48.866667, 2.333333);

  var mapOptions = {
  center: myCoords,
  zoom: 3,
  streetViewControl: false,
  mapTypeControl: false,
  styles: [
    {
        "featureType": "all",
        "elementType": "labels.text",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.fill",
        "stylers": [
            {
                "saturation": 36
            },
            {
                "color": "#000000"
            },
            {
                "lightness": 40
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.text.stroke",
        "stylers": [
            {
                "visibility": "off"
            },
            {
                "color": "#000000"
            },
            {
                "lightness": 16
            }
        ]
    },
    {
        "featureType": "all",
        "elementType": "labels.icon",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "lightness": 20
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "administrative",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#b8b8b8"
            },
            {
                "lightness": "14"
            }
        ]
    },
    {
        "featureType": "landscape",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 20
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 21
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#f9f9f9"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "lightness": 17
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 29
            },
            {
                "weight": 0.2
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry",
        "stylers": [
            {
                "lightness": 18
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 16
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#fffcfc"
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "transit",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#000000"
            },
            {
                "lightness": 19
            },
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#ffffff"
            },
            {
                "lightness": 17
            }
        ]
    }
]
  };

  var map = new google.maps.Map(document.getElementById('bus-map'), mapOptions);

  var directionsService = new google.maps.DirectionsService();
  var directionsRenderer = new google.maps.DirectionsRenderer();

  directionsRenderer.setOptions({
    map: map,
    suppressMarkers: true,
    polylineOptions: {
      strokeColor: '#e9d520'
    }
  })

  // Create an array of alphabetical characters used to label the markers.
  var labels = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!-';

function codeAddress() {

    var tripIndex = 0
    var newPlace = new google.maps.places.PlacesService(map)

    function next() {
        if (tripIndex < trips.length) {
            var city = JSON.stringify(trips[tripIndex].departure)
            // var country = JSON.stringify(trips[tripIndex].country)
            var search = {query: city, fields: ['geometry'],}    
            ++tripIndex;

            newPlace.findPlaceFromQuery(search, function(results, status){
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                    if (results != null) {
                        createBusMarker(results[0]);
                    }; 
                } else {
                    console.log(status)
                };
                setTimeout(function(){
                    next();
                }, 150);
            });
        }
    }
    next();
}

codeAddress();


  var startPoint = trips[0].departure
  var endPoint = trips[trips.length-1].departure
  var steps = []
  for (var y = 1; y < trips.length - 1; y++) {
    var currentElement = trips[y];
    steps.push ({
      location: currentElement.departure,
      stopover: true});
    }

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
    url: '../images/marker-yellow-big.png', // url
    scaledSize: new google.maps.Size(60, 60), // scaled size
    origin: new google.maps.Point(0,0), // origin
    anchor: new google.maps.Point(30, 50), // anchor
    labelOrigin: new google.maps.Point(30, 25)
  };

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
            '<p>' + '<span style="text-decoration: underline;">' + "from" + '</span>' + ": " + '<b>' + trips[i % trips.length].departure + '</b>' +'</p>'+
            '<p>' + '<span style="text-decoration: underline;">' + "to" + '</span>' + ": " + '<b>' + trips[i % trips.length].arrival + '</b>' +' </p>'+
            '</div>'+
            '</div>';
        
        var infowindow = new google.maps.InfoWindow();

         
        google.maps.event.addListener(marker, 'click', function() {
            if(!this.open){
                infowindow.setContent(contentString);
                infowindow.open(map, this);
                this.open = true;
            }
            else {
                infowindow.close();
                this.open = false;
            }
        });

        i++;

    }
}