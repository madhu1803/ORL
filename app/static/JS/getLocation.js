    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else { 
      x.innerHTML = "Geolocation is not supported by this browser.";
    }
  
  function showPosition(position) {
    console.log("Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude);
    $.ajax({url: "http://34.125.223.209/" + position.coords.latitude + "," + position.coords.longitude + ".json", 
            success: function(result){
                console.log(result);
            }
    });
    
  }