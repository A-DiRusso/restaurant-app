const db = require('./conn');  //requre the conn.js file

db.any("select foo.name, foo.avg, bar.count FROM (select   res.id, res.name, avg(rev.score) FROM restaurants res inner join reviews rev on res.id = rev.rest_id where res.name ilike '%ru%' group by res.id ) as foo INNER JOIN(select fav.rest_id, count(fav.id) from favorites as fav GROUP BY fav.rest_id) as bar ON foo.id = bar.rest_id", [true])
    .then(function(data) {
        // success;
        console.log(data);
    })
    .catch(function(error) {
        console.log(error);
    });
