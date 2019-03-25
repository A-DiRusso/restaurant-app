//first require pg-promise can call it immediately which gives us a configured database connector
const pgp = require('pg-promise')();
const options = {
    host: 'localhost',
    database: 'restaurant-app'

};

const db = pgp(options);

db.any("select foo.name, foo.avg, bar.count FROM (select   res.id, res.name, avg(rev.score) FROM restaurants res inner join reviews rev on res.id = rev.rest_id where res.name ilike '%ru%' group by res.id ) as foo INNER JOIN(select fav.rest_id, count(fav.id) from favorites as fav GROUP BY fav.rest_id) as bar ON foo.id = bar.rest_id", [true])
    .then(function(data) {
        // success;
        console.log(data);
    })
    .catch(function(error) {
        console.log(error);
    });