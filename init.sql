-- RESET DATABASE (ONLY USE THIS IN DEV!!)
DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';
SET default_table_access_method = heap;

-- TABLES
CREATE TABLE IF NOT EXISTS public.games (
    gameid SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_date DATE,
    cover TEXT
);

CREATE TABLE IF NOT EXISTS public.genres (
    genreid SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS public.platform (
    platformid SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS public.users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS public.reviews (
    reviewid SERIAL PRIMARY KEY,
    userid INTEGER REFERENCES public.users(userid),
    gameid INTEGER REFERENCES public.games(gameid),
    content TEXT,
    rating SMALLINT CHECK (rating >= 1 AND rating <= 5),
    date_posted TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS public.game_genre (
    gameid INTEGER NOT NULL REFERENCES public.games(gameid),
    genreid INTEGER NOT NULL REFERENCES public.genres(genreid),
    PRIMARY KEY (gameid, genreid)
);

CREATE TABLE IF NOT EXISTS public.game_platform (
    gameid INTEGER NOT NULL REFERENCES public.games(gameid),
    platformid INTEGER NOT NULL REFERENCES public.platform(platformid),
    PRIMARY KEY (gameid, platformid)
);

CREATE TABLE IF NOT EXISTS public.user_favorites (
    userid INTEGER NOT NULL REFERENCES public.users(userid),
    gameid INTEGER NOT NULL REFERENCES public.games(gameid),
    PRIMARY KEY (userid, gameid)
);
