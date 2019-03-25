create table users (
        id serial primary key,
        first_name varchar(100),
        last_name varchar(100),
        email varchar(100),
        password varchar(500)   --store hashes only
);

create table restaurants (
    id serial primary key,
    name varchar(200),
    address varchar(200),
    city varchar(200),
    state varchar(50),
    phone varchar(20),
    menu varchar(200),
    picture varchar(500)  --link.  never store actual media

);
--this is known as a 'linking table'
-- you can have favorites and not write reviews
create table favorites (
    id serial primary key,
    user_id integer references users(id),  --foreign key
    rest_id integer references restaurants(id)  --fk
    --favorite boolean  --don't need.  if it is in list, it is a favorite
    --review text -- 
);

--users can have multiple reviews of same restaurant
--so a review belongs to a restaurant
-- you can write a review yet not be a favorite
create table reviews (
    id serial primary key,
    rest_id integer references restaurants(id),
    user_id integer references users(id),
    score integer,
    content text        --the review

);