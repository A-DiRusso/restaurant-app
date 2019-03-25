const db = require('./conn');  //requre the conn.js file

function getRestAvgScoreFavCount(rest){

    return db.any(`select foo.name, foo.avg, bar.count FROM (select   res.id, res.name, avg(rev.score) FROM restaurants res inner join reviews rev on res.id = rev.rest_id where res.name ilike '%${rest}%' group by res.id ) as foo INNER JOIN(select fav.rest_id, count(fav.id) from favorites as fav GROUP BY fav.rest_id) as bar ON foo.id = bar.rest_id`, [true])
    .catch(console.error);
}
// getRestAvgScoreFavCount('ru').then(console.log);


//gets everyting for a particular user
function getUseryId(theID) {
    //the return will return a promise change!!
    return db.any(`SELECT * from users where id=${theID}`);

}
// getUseryId(3).then(console.log);

//gets the user name and their favorite restaurant NAMES
//this will interpolate the user id
function getUsersFavoriteRest(user){
    return db.any(`select U.first_name ||  ' ' || U.last_name as name,U.email, R.name as favorites from users as U INNER join favorites as F on U.id = F.user_id INNER join restaurants as R on F.rest_id = R.id where U.id = ${user}`, [true])
    // .then(function(data){
    //     console.log("got to here");
    //     // console.log(data);
    // })
    .catch(console.error);

}
// getUsersFavoriteRest(2).then(console.log);


function restaurantAvgScore(rest) {
    return db.any(`SELECT R.name, R.address, avg(V.score) from restaurants as R INNER JOIN reviews as V ON R.id = V.rest_id WHERE R.name ilike '%${rest}%' GROUP BY R.id `, [true])
    .catch(console.error);
}
// restaurantAvgScore('jin').then(console.log);

function countOfFavorites(rest) {
    return db.any(`SELECT R.name, R.address, count(F.id) from restaurants as R INNER JOIN favorites as F ON R.id = F.rest_id where R.name ilike '%${rest}%' GROUP BY R.id`)
        .catch(console.error);

    
}
// countOfFavorites('na').then(console.log);

function restaurantAvgScoreAndFavCount(rest) {
    return db.any(`select foo.name, foo.avg, bar.count FROM (select   res.id, res.name, avg(rev.score) from restaurants res inner join reviews rev on res.id = rev.rest_id
    where res.name ilike '%${rest}%' group by res.id ) as foo INNER JOIN (select fav.rest_id, count(fav.id) from favorites as fav GROUP BY fav.rest_id) as bar ON foo.id = bar.rest_id`)
}

restaurantAvgScoreAndFavCount('rus').then(console.log);

function restaurantAvgScoreAndFavCountBetter(rest) {
    return db.any(`select foo.name, foo.average, bar.count FROM (select   res.id, res.name, CAST (avg(rev.score)  as DECIMAL(13,2)) as average from restaurants as res inner join reviews as rev on res.id = rev.rest_id
    where res.name ilike '%${rest}%' group by res.id ) as foo INNER JOIN (select fav.rest_id, count(fav.id) from favorites as fav GROUP BY fav.rest_id) as bar ON foo.id = bar.rest_id LIMIT 2 OFFSET 0`)
    .catch(console.error);
}

// restaurantAvgScoreAndFavCountBetter('lov').then(console.log)

function allRest(page,offset){
    return db.any(`select * from restaurants LIMIT ${page} OFFSET ${offset}`)
    .catch(console.error)
}

// allRest(2,1).then(console.log);