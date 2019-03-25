--for user profile page
    -- 1) get all info for user by user_id
    --     get only a few fields for public version
    --     get all fields for private version
    -- 2) get all favorites for a user by user_id
    -- 3) get all reviews written by that user_id

--for public
select U.first_name ||  ' ' || U.last_name as name,
    U.email, R.name as favorites
    from users as U
    INNER join favorites as F
    on U.id = F.user_id
    INNER join restaurants as R
    on F.rest_id = R.id
    where U.id = 1;  
--    ORDER by name;

--you need separate query for reviews
select U.first_name ||  ' ' || U.last_name as name,
    R.name  as restaurant,
	V.content as review
     from users as U
    INNER join reviews as V
        on U.id = V.user_id
    INNER join restaurants as R
        on V.rest_id = R.id
    where U.id = 4;
--    ORDER by name;
    
--for private - just favorites
--same just don't show email??
select U.first_name ||  ' ' || U.last_name as name,
     R.name as restaurant
    from users as U
    INNER join favorites as F
    on U.id = F.user_id
    INNER join restaurants as R
    on F.rest_id = R.id
    where U.id = 1;  


--2) for restaurant profile page

    -- 1) get all info for restaurant by rest_id
    -- 2) get average score from reviews
    SELECT R.name, R.address, avg(V.score) from restaurants as R
    INNER JOIN reviews as V
        ON R.id = V.rest_id
        GROUP BY R.id;  -- group by the unique ID

    -- 3) get count of favorites
    SELECT R.name, R.address, count(F.id) from restaurants as R
    INNER JOIN favorites as F
        ON R.id = F.rest_id
        GROUP BY R.id;

--just get rest id and count of favorites:
SELECT R.id as tempid, count(F.id) as count from restaurants as R
	INNER JOIN favorites as F
		ON R.id = F.rest_id
	
		GROUP BY R.id;
--to combine those:
--  SELECT R.name, R.address, avg(V.score) as avg_rating, min(T.count) as count from restaurants as R
--     INNER JOIN reviews as V
--         ON R.id = V.rest_id
--     INNER JOIN (SELECT R.id as tempid, count(F.id) as count from restaurants as R
--                     INNER JOIN favorites as F
--                         ON R.id = F.rest_id
--                      GROUP BY R.id) as T
--         on R.id = T.tempid
--         GROUP BY R.id;

SELECT R.name, R.address, avg(V.score) as avg_rating, 
        count(F.id) as count from restaurants as R
    INNER JOIN reviews as V
        ON R.id = V.rest_id
    INNER JOIN favorites as F
		ON R.id = F.rest_id
        GROUP BY R.id;

    -- 4) get all reviews for rest_id

--for restaurant search result
 SELECT U.first_name, F.rest_id, R.name from users as U
 	INNER JOIN favorites as F
 		ON U.id = F.user_id
 	INNER JOIN restaurants as R
 		ON R.id = F.rest_id
 		WHERE R.name ilike '%sans%';
    -- 1) get all restaurants for a given city (or location)
    --     case INSENSITIVE search
    -- 2) get average score for each restaurant
    --     limit by minimum review.
    SELeCT * FROM (SELECT  R.name , avg(V.score) as average from restaurants as R
 	INNER JOIN reviews as V
 		oN R.id = V.rest_id
 		
 	GROUP BY R.id
 	ORDER BY average)  as foo WHERE foo.average < 4;

    -- 3) include number of favorites
    -- SELECT R.rest_id, count(R.id) from favorites as R
	-- group by r.rest_id;


    SELECT  R.name , avg(V.score) as average , min(temp.count) from restaurants as R
 	INNER JOIN reviews as V
 		oN R.id = V.rest_id
 		
	INNER JOIN (SELECT R.rest_id, count(R.id) from favorites as R
	group by r.rest_id) as temp
		ON temp.rest_id = R.id
			
 	GROUP BY R.id
 	ORDER BY average;

--with formatting the average
 SELECT  R.name , CAST (avg(V.score)  as DECIMAL(13,2)) as average , min(temp.count) from restaurants as R
    INNER JOIN reviews as V
        oN R.id = V.rest_id
        
    INNER JOIN (SELECT R.rest_id, count(R.id) from favorites as R
    group by r.rest_id) as temp
        ON temp.rest_id = R.id
            
    GROUP BY R.id
    ORDER BY average;


 --or

 SELECT foo.name, min(avg), count(user_id) FROM
(
select   res.id, res.name, avg(rev.score),  fav.user_id
    from restaurants res
    inner join reviews rev
        on res.id = rev.rest_id
    inner join favorites fav
        on res.id = fav.rest_id
where res.name ilike '%ru%'
group by res.id ,fav.user_id
) as foo
GROUP BY foo.name;

--create 2 subtables and join them
	-- i think this is the most logical
    
select foo.name, foo.avg, bar.count 
	FROM (select   res.id, res.name, avg(rev.score)
    from restaurants res
    inner join reviews rev
        on res.id = rev.rest_id
        where res.name ilike '%ru%'
group by res.id ) as foo
	INNER JOIN
		(select fav.rest_id, count(fav.id)
	from favorites as fav
	GROUP BY fav.rest_id) as bar
		ON foo.id = bar.rest_id


    -- 4) PAGINATION - superbonus

    SELECT  R.name , CAST (avg(V.score)  as DECIMAL(13,2)) as average , min(temp.count) from restaurants as R
    INNER JOIN reviews as V
        oN R.id = V.rest_id
        
    INNER JOIN (SELECT R.rest_id, count(R.id) from favorites as R
    group by r.rest_id) as temp
        ON temp.rest_id = R.id
            
    GROUP BY R.id
    ORDER BY average
 	LIMIT 2 OFFSET 2;  --CHANGE THE OFFSET FOR EACH PAGE