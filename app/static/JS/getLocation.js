    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
    } else { 
      alert("Geolocation is not supported by this browser.");
    }
  
    function populateCards(data){
      data["result"].forEach(item => {
        var TEMPLATE = '<div class="col-lg-4">' +
                        '<div class="card shadow p-3 mb-5 bg-white rounded">' +
                            '<img ' +
                              'src="https://images.unsplash.com/photo-1453967854176-7e6e8270b0b8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80"' +
                              'class="card-img-top"' +
                              'alt="..."' +
                            '/>' +
                          '<div class="card-body">' +
                            '<h5 class="card-title">' + item.orphanage_name + '</h5>' +
                            '<p class="card-text">' +
                              item.about +
                            '</p>' +
                            '<a href="/orphanage/profile/' + item.or_user_id + '" class="btn btn-primary"' +
                            '>View More Details</a' +
                            '>' +
                          '</div>' +
                        '</div>' +
                      '</div>';
        $("#cards").append(TEMPLATE);
      });
    }
  function showPosition(position) {
    console.log("Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude);
    // $.ajax({url: "http://34.125.223.209/" + position.coords.latitude + "," + position.coords.longitude + ".json", 
    //         success: function(result){
    //             console.log(result);
    //         }
    // });

    $.ajax({url: "https://0.0.0.0:5000/getOrphanages?lat=" + position.coords.latitude + "&lon=" + position.coords.longitude, 
            success: function(result){
                console.log(result);
                populateCards(result);
            }
    });
    
  }