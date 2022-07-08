app.get("/check/:ip/:steam", function(req,res) {
  con.query("SELECT * FROM ban_list", function (err, result, fields) {
    if (err) throw err;
    var test = true
    for (var i in result) {

      if (test == true) {
        if (result[i].ip === req.params.ip) {
          test = false;   
        }
  
        if (result[i].steamid === req.params.steam) {
          test = false;    
        }
      }
    }
    res.send(test)
  });
});

app.get("/addbanedplayer/:ip/:steamid", function(req,res) {
  var sql = "DELETE FROM ban_list WHERE ip = '" + req.params.ip + "'";
  con.query(sql, function (err, result) {
    if (err) throw err;
  })

  var sql = "DELETE FROM ban_list WHERE steamid = '" + req.params.steamid + "'";
  con.query(sql, function (err, result) {
    if (err) throw err;
  })

  con.query("INSERT INTO `ban_list` (`ip`, `steamid`)   VALUES ('"+req.params.ip+"', '"+req.params.steamid+"')", function (err, result) {
    if (err) throw err;
  });
});