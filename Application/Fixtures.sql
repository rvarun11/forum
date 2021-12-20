

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.posts DISABLE TRIGGER ALL;

INSERT INTO public.posts (id, title, body, created_at) VALUES ('82a01e64-7d98-44ee-9799-3944da1b2bc2', 'Hello', '### Welcome to Canada!
- Best experience', '2021-12-14 09:50:27.072802-05');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;

INSERT INTO public.comments (id, post_id, author, body, created_at) VALUES ('926459f3-fe7b-4d5d-a1e8-bc78f1664eb6', '82a01e64-7d98-44ee-9799-3944da1b2bc2', 'Varun', 'hi', '2021-12-14 11:38:13.742919-05');


ALTER TABLE public.comments ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts, is_admin) VALUES ('813efdee-0289-4ef4-a685-f1d97698bd19', 'admin', 'sha256|17|9eZk71SVHPQoHyO9sPWeug==|1YK+qgcbk32MlItDPAm+0W9L6IDGENwjFKLCdW3q/z4=', NULL, 0, true);


ALTER TABLE public.users ENABLE TRIGGER ALL;


