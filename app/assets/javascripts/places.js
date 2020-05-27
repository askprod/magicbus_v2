// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function initPlacesMap() {
    var myCoords = new google.maps.LatLng(48.866667, 2.333333);

    var mapOptions = {
    center: myCoords,
    zoom: 4,
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

    var map = new google.maps.Map(document.getElementById('map'), mapOptions);

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
        controlText.innerHTML = 'Center Map';
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


    // Select your spot and click View to center that spot on the map
    $(document).ready(function(){
        $(".center-map-point").click(function(){
            var spotLocation = JSON.parse($(this).siblings("#spot_location").val());
            var elmnt = document.getElementById("map");

            var point = new google.maps.LatLng(spotLocation);
            map.setCenter(point);
            map.setZoom(8);
            elmnt.scrollIntoView({ behavior: 'smooth', block: 'center' })
        });
      });

         // Create an array of alphabetical characters used to label the markers.
         var labels = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!-';

         // Add some markers to the map.
         // Note: The code uses the JavaScript Array.prototype.map() method to
         // create an array of markers based on a given "locations" array.
         // The map() method here has nothing to do with the Google Maps API.
         
        var iconRed = {
            url: '../images/marker-red.png', // url
            scaledSize: new google.maps.Size(50, 50), // scaled size
            origin: new google.maps.Point(0,0), // origin
            anchor: new google.maps.Point(25, 42) // anchor
        };

        var iconBlue = {
            url: "../images/marker-blue.png", // url
            scaledSize: new google.maps.Size(50, 50), // scaled size
            origin: new google.maps.Point(0,0), // origin
            anchor: new google.maps.Point(25, 42) // anchor
        };

        var iconYellow = {
            url: '../images/marker-yellow.png', // url
            scaledSize: new google.maps.Size(50, 50), // scaled size
            origin: new google.maps.Point(0,0), // origin
            anchor: new google.maps.Point(25, 42) // anchor
        };

         var markers = locations.map(function(location, i) {
            approved = approvals[i % approvals.length]
            secret = secrets[i % secrets.length]
            if(secret){
                return  new google.maps.Marker({
                    position: location,
                    icon:  iconBlue,
                });
            } else if(approved) {
                return  new google.maps.Marker({
                    position: location,
                    name: names[i % names.length],
                    anecdote: anecdotes[i % anecdotes.length],
                    approved: approvals[i % approvals.length],
                    imageOne: blobOne[i % blobOne.length],
                    imageTwo: blobTwo[i % blobTwo.length],
                    imageThree: blobThree[i % blobThree.length],
                    icon:  iconYellow,
                });
            } else {
                return  new google.maps.Marker({
                    position: location,
                    name: names[i % names.length],
                    anecdote: anecdotes[i % anecdotes.length],
                    approved: approvals[i % approvals.length],
                    icon:  iconRed,
                });
           };
         });

         for (var i = 0; i < markers.length; i++) {
             google.maps.event.addListener(markers[i], 'click', function(){
                map.setZoom(8);
                map.panTo(this.position);
             });
         }

         for (var i = 0; i < markers.length; i++) {
            if (markers[i].approved == true) {
            
                var infowindow = new google.maps.InfoWindow()

                google.maps.event.addListener(markers[i], 'click', function () {
                    infowindow.setContent(                         
                                        '<div class="gm-style-iw">'+
                                        '<h1 id="firstHeading" class="firstHeading giveyouglory yellow" style="font-size: 15px"> <b>' + 
                                        this.name +'</b></h1>'+
                                        '<div id="bodyContent">'+
                                        '<p>' + this.anecdote +' </p>' +
                                        (this.imageOne != undefined ? ('<img src=' + this.imageOne + ' style="margin: 0 20px; height:100px; width: 100px;"></img>') : '' ) + 
                                        (this.imageTwo != undefined ? ('<img src=' + this.imageTwo + ' style="margin: 0 20px; height:100px; width: 100px;"></img>') : '' ) + 
                                        (this.imageThree != undefined ? ('<img src=' + this.imageThree + ' style="margin: 0 20px; height:100px; width: 100px;"></img>') : '' ) + 
                                        '</div>'+
                                        '</div>'
                                        );
                    if(!this.open){
                        infowindow.open(map, this);
                        this.open = true;
                    }
                    else {
                        infowindow.close();
                        this.open = false;
                    }
                })
            }
          }

        // Add a marker clusterer to manage the markers.

        new MarkerClusterer(map, markers,
            { 
            gridSize: 20,
            styles: 
                [{
                height: 50,
                url: '../images/cluster.png',
                width: 50,
                textColor: 'transparent',
            }
                ]
            }
        );

}   

  function initPlacesMap2() {
    var latlng = JSON.parse(document.getElementById('place_location').value);

    var myCoords = new google.maps.LatLng(latlng);

    var mapOptions = {
    center: myCoords,
    zoom: 5
    };
    
    var map = new google.maps.Map(document.getElementById('map2'), mapOptions);
    
    var marker = new google.maps.Marker({
        position: myCoords,
        animation: google.maps.Animation.DROP,
        map: map,
        draggable: true
    });
    var infowindow = new google.maps.InfoWindow({
        content: "Move Me!",
    });

    infowindow.open(map2, marker);

    var input = $('#maps-search-input')[0];

    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.bindTo('bounds', map);

    autocomplete.addListener('place_changed', function() {
        var place = autocomplete.getPlace();
        // If the place has a geometry, then present it on a map.
        if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
            marker.setPosition(place.geometry.location);
        } else {
            map.setCenter(place.geometry.location);
            map.setZoom(15);
        }
    });

    // refresh marker position and recenter map on marker
    function refreshMarker(){
        var myCoords = new google.maps.LatLng(latlng);
        marker.setPosition(myCoords);
        map.setCenter(marker.getPosition());   
    }
    // when input values change call refreshMarker
    document.getElementById('place_location').onchange = refreshMarker;

    // when marker is dragged update input values
    marker.addListener('position_changed', function() {
        lat = marker.getPosition().lat();
        lng = marker.getPosition().lng();
        data = {lat: lat, lng: lng};
        document.getElementById('place_location').value = JSON.stringify(data);
    });
    // When drag ends, center (pan) the map on the marker position
    marker.addListener('dragend', function() {
        map.panTo(marker.getPosition());   
    });
    var infowindow = new google.maps.InfoWindow({
        content: ""
     });
}