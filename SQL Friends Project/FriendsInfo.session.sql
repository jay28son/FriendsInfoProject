select a.id, a.first_name, a.last_name, c.boba_drink
FROM friendsinfo AS A
inner JOIN friends_boba_order AS B
    on A.ID = B.FRIEND_ID
inner JOIN (SELECT BOBA_drink,boba_id 
            FROM BOBA_ORDERS
            GROUP BY boba_id ) as C
    on b.boba_id = c.boba_id
order by a.id;

