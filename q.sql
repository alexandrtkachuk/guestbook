
CREATE TABLE  IF NOT EXISTS  `guestbook` (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name  VARCHAR(32) NOT NULL,
    email VARCHAR(128) NOT NULL,
    homepage VARCHAR(128) NOT NULL,
    text TEXT NOT NULL,
    time_add DATETIME,
    ip  INT,
    PRIMARY KEY(id)
);
