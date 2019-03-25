insert into users
(first_name, last_name, email, password)
values
('Margaret','ONeill','margaret@oneillfish.com','password1'),
('Rob','ONeill','roneill@columbiaprop','password1'),
('Madeline','ONeill','maddie@oneillcrew.com','password1'),
('Eileen','Pickett','epickett@gmail.com','password1'),
('Carol','Jantzen','cmjantzen@srs.gov','password1'),
('Emily','Sasser','ess@gmail.com','password1');

insert into restaurants 
(name, address, city, state, phone, menu, picture )  
values
('Lovies','3420 Piedmont Rd NE','Atlanta','Georgia','404.254.2848','https://loviesbbq.com/wp-content/uploads/2017/10/Menus-New-October-Edits-BREAKFAST.pdf','https://loviesbbq.com/wp-content/uploads/2017/05/braves-smoker.jpg'),
('NaanStop','3420 Piedmont Road NE','Atlanta','Georgia','(404) 846-6226','http://naanstop.com/our-food/menu/','http://naanstop.com/wp-content/uploads/2018/12/slidernewindian.png'),
('Jinya Ramen Bar','3714 Roswell Rd #35','Atlanta','Georgia','404-254-4770','https://jinya-ramenbar.com/menu/','https://jinya-ramenbar.com/img/img-about01.png'),
('RuSans','1529 piedmont ave','Atlanta','Georgia','404-875-7042','http://www.rusansatlanta.com/menu.html','https://s3-media4.fl.yelpcdn.com/bphoto/Fef8BCqV5kYQ74nPTj1d8Q/o.jpg');

insert into favorites 
(user_id,rest_id)
values
(1,3),
(2,4),
(3,1),
(3,2),
(3,3),
(3,4),
(5,1),
(5,2),
(6,3);

insert into reviews
(rest_id,user_id,score,content)
values
(1,3,4,'Great Place'),
(2,2,4,'Great Place'),
(3,3,4,'Great Place'),
(3,4,4,'Great Place'),
(3,6,1,'Awful'),
(4,3,4,'Great Place'),
(4,2,5,'fabulous'),
(4,3,4,'Great Place'),
(2,4,2,'So,so')
; 