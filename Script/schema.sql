CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE role_team (
    role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_name VARCHAR(100) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE images (
    image_id INTEGER PRIMARY KEY AUTOINCREMENT,
    group_id INTEGER,
    src VARCHAR(500) NOT NULL,
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    lastname VARCHAR(100),
    role_id INTEGER,
    description TEXT,
    image_id INTEGER,
    sort_order INTEGER DEFAULT 0,
    active BOOLEAN NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES role_team(role_id),
    FOREIGN KEY (image_id) REFERENCES images(image_id)
);
CREATE TABLE competitions (
    competition_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    place_taken INTEGER,
    results TEXT,
    image_group_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (image_group_id) REFERENCES images(group_id)
);
CREATE TABLE contact_info (
    contact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    email VARCHAR(100),
    phone VARCHAR(50),
    address VARCHAR(255),
    facebook_url VARCHAR(255),
    instagram_url VARCHAR(255),
    twitter_url VARCHAR(255),
    image_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (image_id) REFERENCES images(image_id)
);
CREATE TABLE gallery (
    gallery_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(200),
    description TEXT,
    image_group_id INTEGER,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (image_group_id) REFERENCES images(group_id)
);
CREATE TABLE posts_small (
    small_post_id INTEGER PRIMARY KEY AUTOINCREMENT,
    cover_image_id INTEGER,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(1000),
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cover_image_id) REFERENCES images(image_id)
);
CREATE TABLE posts_big (
    big_post_id INTEGER PRIMARY KEY AUTOINCREMENT,
    image_group_id INTEGER,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (image_group_id) REFERENCES images(group_id)
);
CREATE TABLE posts (
    post_id INTEGER PRIMARY KEY AUTOINCREMENT,
    category_id INTEGER,
    small_post_id INTEGER,
    big_post_id INTEGER,
    importance INTEGER DEFAULT 0,
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (small_post_id) REFERENCES posts_small(small_post_id) ON DELETE SET NULL,
    FOREIGN KEY (big_post_id) REFERENCES posts_big(big_post_id) ON DELETE SET NULL
);
CREATE TABLE user_roles (
    user_role_id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    hashed_password VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    surename VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    user_role_id INTEGER NOT NULL,
    disabled BOOLEAN NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_role_id) REFERENCES user_roles(user_role_id)
);
CREATE TRIGGER update_categories_timestamp 
AFTER UPDATE ON categories 
BEGIN
    UPDATE categories SET updated_at = CURRENT_TIMESTAMP WHERE category_id = NEW.category_id;
END;
CREATE TRIGGER update_role_team_timestamp 
AFTER UPDATE ON role_team 
BEGIN
    UPDATE role_team SET updated_at = CURRENT_TIMESTAMP WHERE role_id = NEW.role_id;
END;
CREATE TRIGGER update_images_timestamp 
AFTER UPDATE ON images 
BEGIN
    UPDATE images SET updated_at = CURRENT_TIMESTAMP WHERE image_id = NEW.image_id;
END;
CREATE TRIGGER update_members_timestamp 
AFTER UPDATE ON members 
BEGIN
    UPDATE members SET updated_at = CURRENT_TIMESTAMP WHERE member_id = NEW.member_id;
END;
CREATE TRIGGER update_competitions_timestamp 
AFTER UPDATE ON competitions 
BEGIN
    UPDATE competitions SET updated_at = CURRENT_TIMESTAMP WHERE competition_id = NEW.competition_id;
END;
CREATE TRIGGER update_contact_info_timestamp 
AFTER UPDATE ON contact_info 
BEGIN
    UPDATE contact_info SET updated_at = CURRENT_TIMESTAMP WHERE contact_id = NEW.contact_id;
END;
CREATE TRIGGER update_gallery_timestamp 
AFTER UPDATE ON gallery 
BEGIN
    UPDATE gallery SET updated_at = CURRENT_TIMESTAMP WHERE gallery_id = NEW.gallery_id;
END;
CREATE TRIGGER update_posts_small_timestamp 
AFTER UPDATE ON posts_small 
BEGIN
    UPDATE posts_small SET updated_at = CURRENT_TIMESTAMP WHERE small_post_id = NEW.small_post_id;
END;
CREATE TRIGGER update_posts_big_timestamp 
AFTER UPDATE ON posts_big 
BEGIN
    UPDATE posts_big SET updated_at = CURRENT_TIMESTAMP WHERE big_post_id = NEW.big_post_id;
END;
CREATE TRIGGER update_posts_timestamp 
AFTER UPDATE ON posts 
BEGIN
    UPDATE posts SET updated_at = CURRENT_TIMESTAMP WHERE post_id = NEW.post_id;
END;
CREATE TRIGGER update_user_roles_timestamp 
AFTER UPDATE ON user_roles 
BEGIN
    UPDATE user_roles SET updated_at = CURRENT_TIMESTAMP WHERE user_role_id = NEW.user_role_id;
END;
CREATE TRIGGER update_users_timestamp 
AFTER UPDATE ON users 
BEGIN
    UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE user_id = NEW.user_id;
END;
