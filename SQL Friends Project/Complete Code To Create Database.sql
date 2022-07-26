DROP TABLE friendsinfo
DROP TABLE FRIENDS_FOOD_ORDER
DROP TABLE FOOD
DROP TABLE BOBA_ORDERS
DROP TABLE FRIENDS_BOBA_ORDER
;

--Creating Initial Information Table

create table friendsinfo(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    EMAIL_ADDRESS VARCHAR(255),
    BIRTHDAY VARCHAR(255),
    Gender VARCHAR (255),
    PRIMARY KEY(ID)
);

--Inserting values friends information table

INSERT INTO FRIENDSINFO(FIRST_NAME, LAST_NAME, EMAIL_ADDRESS, BIRTHDAY,GENDER) VALUES 
    ('Jayson','Villena','jayson.villena@gmail.com','09/28','MALE'),
    ('Stephanie', 'Lim','stflim@gmail.com','01/05','FEMALE'),
    ('Michael','Saint-Germain','mst@yahoo.com','03/25','MALE'),
    ('Kyle','Lemon','kylelmn@gmail.com','09/13','MALE'),
    ('Tony','Vo','tonyvo@gmail.com','06/09','MALE'),
    ('Henry','Guerrero','GuerreroDuarte@gmail.com','01/31','MALE'),
    ('Jeanny', 'Villena', 'jeannyvillena@gmail.com', '01/02','FEMALE'),
    ('Jared', 'Villena', 'villenajared@yahoo.com','10/24','MALE'),
    ('Jena', 'Villena','missxjeyna@yahoo.com','06/4','FEMALE'),
    ('Austin','Kim','akim@gmail.com', '12/02','MALE'),
    ('Ryan','Kim','Kim.ryan@gmail.com','05/18','MALE'),
    ('Janelle', 'Langracia','jnelle@gmail.com','01/08','FEMALE'),
    ('Ericka', 'Yap', 'yippieerickia@gmail.com','05/15','FEMALE'),
    ('Grace', 'Ahn','GraceeLautner@gmail.com','02/28','FEMALE'),
    ('Khedrin', 'Teng',' UncleTeng@gmail.com', '11/12','MALE'),
    ('Louis', 'Obero', 'LoiObero@gmail.com', '09/05', 'MALE'),
    ('Mary', 'Park', 'Mpark@gmail.com','07/13', 'FEMALE'),
    ('Charles', 'Yoo', 'Churro@gmail.com', '07/15','MALE'),
    ('Scott', 'Uemura', 'MegaMudkip@gmail.com','03/30', 'MALE')
    ;

--Creating boba orders table

create table boba_orders(
    boba_id INT NOT NULL AUTO_INCREMENT,
    Boba_Drink Varchar(255)
);

--altering table to add cost of each drink+

alter table boba_orders
ADD BOBA_COST Int NOT NULL


--inserting boba orders 

insert INTO boba_orders(Boba_Drink) VALUES
    ('Hojicha Matcha'),
    ('Jasmine Milk Tea'),
    ('Brown Sugar Milk Tea'),
    ('Lavendar Milk Tea'),
    ('Matcha'),
    ('Rose Milk Tea'),
    ('Classic Black tea'),
    ('Taro Milk Tea'),
    ('Thai Milk Tea')
    ;


--Adding Boba costs into table

UPDATE BOBA_ORDERS
SET BOBA_COST$ = 7.10
WHERE BOBA_ID = 1
;

UPDATE BOBA_ORDERS
SET BOBA_COST$ = 3.45
WHERE BOBA_ID = 2
;

UPDATE BOBA_ORDERS
SET BOBA_COST$ = 4
WHERE BOBA_ID = 3
;

UPDATE BOBA_ORDERS
SET BOBA_COST$ = 5
WHERE BOBA_ID = 4
;

UPDATE BOBA_ORDERS
SET BOBA_COST$ = 5
WHERE BOBA_ID = 5
;

update boba_orders
set boba_cost$ = 4
where boba_id = 6
;

update boba_orders
set boba_cost$ = 3
where boba_id = 7
;

update boba_orders
set boba_cost$ = 5
where boba_id = 8
;

update boba_orders
set boba_cost$ = 4
where boba_id = 9
;

--creating table utilizing friend_id and boba_id

create table friends_boba_order(
    id int not NULL AUTO_INCREMENT,
    friend_id INT NOT NULL,
    boba_id INT NOT NULL,
    primary key(id)
)
;

--inserting into friends and boba id table

insert into friends_boba_order(friend_id, boba_id) VALUES
    (1,1),
    (2,1),
    (3,3),
    (4,4),
    (5,5),
    (6,4),
    (7,8),
    (8,2),
    (9,9),
    (10,5),
    (11,5),
    (12,9),
    (13,3),
    (14,7),
    (15,2),
    (16,3),
    (17,5),
    (18,3),
    (19,1)
;

    
CREATE TABLE FOOD(
    food_id INT NOT NULL AUTO_INCREMENT,
    Culture VARCHAR(255),
    primary key (food_id)
)
;

ALTER TABLE FOOD
ADD AVG_FOOD_COST$ INT NOT NULL
;

--inserting food names into food table

INSERT INTO FOOD(Culture, AVG_FOOD_COST$) VALUES
    ('Japanese', 18),
    ('Korean', 20),
    ('Hispanic', 14),
    ('Italian', 18),
    ('American', 22)
;

CREATE TABLE FRIENDS_FOOD_ORDER(
    food_id INT NOT NULL,
    friend_id INT NOT NULL
)
;


--SQL QUERIES


--Costs of each Person

SELECT a.id, a.first_name, a.last_name, C.BOBA_DRINK, C.BOBA_COST$, E.CULTURE, E.AVG_FOOD_COST$, SUM(c.boba_cost$ + e.AVG_food_cost$) AS TOTAL_COST$
FROM friendsinfo AS a
INNER JOIN friends_boba_order AS B
ON A.ID = B.FRIEND_ID
INNER JOIN (SELECT * 
            FROM boba_orders
            GROUP BY BOBA_ID) AS C
ON B.BOBA_ID = C.BOBA_ID
INNER JOIN friends_food_order AS D
ON A.ID = D.FRIEND_ID
INNER JOIN (SELECT * 
            FROM FOOD 
            GROUP BY FOOD_ID ) AS E
ON D.FOOD_ID = E.FOOD_ID
GROUP BY A.ID;


--Total Cost Spent For Each Gender

SELECT A.GENDER, E.CULTURE,SUM(c.boba_cost$ + e.AVG_food_cost$) AS TOTAL_COST$_SPENT_PER_GENDER_PER_FOOD
FROM friendsinfo AS a
INNER JOIN friends_boba_order AS B
ON A.ID = B.FRIEND_ID
INNER JOIN (SELECT * 
            FROM boba_orders
            GROUP BY BOBA_ID) AS C
ON B.BOBA_ID = C.BOBA_ID
INNER JOIN friends_food_order AS D
ON A.ID = D.FRIEND_ID
INNER JOIN (SELECT * 
            FROM FOOD 
            GROUP BY FOOD_ID ) AS E
ON D.FOOD_ID = E.FOOD_ID
GROUP BY A.GENDER,E.CULTURE
ORDER BY TOTAL_COST$_SPENT_PER_GENDER_PER_FOOD ASC;


--Average Amount Spent Based On Gender

SELECT A.GENDER, TRUNCATE(AVG(c.boba_cost$ + e.AVG_FOOD_COST$),2) AS TOTAL_COST$
FROM friendsinfo AS a
INNER JOIN friends_boba_order AS B
ON A.ID = B.FRIEND_ID
INNER JOIN (SELECT * 
            FROM boba_orders
            GROUP BY BOBA_ID) AS C
ON B.BOBA_ID = C.BOBA_ID
INNER JOIN friends_food_order AS D
ON A.ID = D.FRIEND_ID
INNER JOIN (SELECT * 
            FROM FOOD 
            GROUP BY FOOD_ID ) AS E
ON D.FOOD_ID = E.FOOD_ID
GROUP BY A.GENDER;



SELECT A.GENDER,c.boba_drink, count(boba_drink) as AMOUNT_BOUGHT, (COUNT(BOBA_DRINK)*BOBA_COST$) AS TOTAL_COST_PER_DRINK_PER_GENDER
 FROM FRIENDSINFO AS A
INNER JOIN friends_boba_order AS B
ON A.ID = B.FRIEND_ID
INNER JOIN (SELECT * 
            FROM boba_orders
            GROUP BY BOBA_ID) AS C
ON B.BOBA_ID = C.BOBA_ID
INNER JOIN friends_food_order AS D
ON A.ID = D.FRIEND_ID
INNER JOIN (SELECT * 
            FROM FOOD 
            GROUP BY FOOD_ID ) AS E
ON D.FOOD_ID = E.FOOD_ID
GROUP BY a.gender, c.boba_Drink;

SELECT A.GENDER, e.culture, count(E.culture) as AMOUNT_BOUGHT, (count(e.culture)*e.avg_food_cost$) as TOTAL_COST_PER_FOOD_PER_GENDER
FROM FRIENDSINFO AS A
INNER JOIN friends_boba_order AS B
ON A.ID = B.FRIEND_ID
INNER JOIN (SELECT * 
            FROM boba_orders
            GROUP BY BOBA_ID) AS C
ON B.BOBA_ID = C.BOBA_ID
INNER JOIN friends_food_order AS D
ON A.ID = D.FRIEND_ID
INNER JOIN (SELECT * 
            FROM FOOD 
            GROUP BY FOOD_ID ) AS E
ON D.FOOD_ID = E.FOOD_ID
GROUP BY a.gender, e.culture;