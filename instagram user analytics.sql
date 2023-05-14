SELECT COUNT(*) FROM users;
-- 1. MARKETING 

/*Rewarding Most Loyal User*/
SELECT username FROM users
ORDER BY created_at
LIMIT 5;

/*Remind Inactive users to Start Positioning*/
SELECT username
FROM (
SELECT u.id,username,COUNT(image_url) AS no_of_photos
FROM users u
LEFT JOIN photos p
ON u.id = p.user_id
GROUP BY username) AS PT
WHERE no_of_photos = 0;

/*Declaring Contest Winner*/
SELECT p.id,u.username,p.image_url,COUNT(*) AS total_likes
FROM likes l
JOIN photos p ON p.id = l.photo_id
JOIN users u ON u.id = l.photo_id
GROUP BY p.id
ORDER BY total_likes DESC
LIMIT 1;

/* Hashtag Researching */
SELECT tag_name,COUNT(photo_id) AS no_of_tags
FROM photo_tags p
INNER JOIN tags t
ON p.tag_id = t.id
GROUP BY tag_name
ORDER BY no_of_tags DESC
LIMIT 5;

/*Launch AD Compaign*/
SELECT * FROM users;
SELECT  DAYNAME(created_at) AS day_of_week,COUNT(username)
FROM users
GROUP BY day_of_week;

-- 2. INVESTORS METRICS 

/*Users Engagement*/
SELECT AVG(no_of_photos)
FROM (
SELECT username,COUNT(image_url) AS no_of_photos
FROM users u
INNER JOIN photos p
ON u.id = p.user_id
GROUP BY username) AS insta_photo;

SELECT (ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2)) Ratio;


/*Bots and Fake accounts*/

SELECT users.id,username, COUNT(users.id) AS total_likes_by_user
FROM users JOIN likes ON users.id = likes.user_id
GROUP BY users.id
HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);

