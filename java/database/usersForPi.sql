PGDMP                       }            personal-finance-db    16.3    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    25018    personal-finance-db    DATABASE     �   CREATE DATABASE "personal-finance-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
 %   DROP DATABASE "personal-finance-db";
                postgres    false            �            1259    25032    users    TABLE     �   CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(200) NOT NULL,
    role character varying(50) NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �           0    0    TABLE users    ACL     y   GRANT ALL ON TABLE public.users TO spotowner3;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO frank_the_dog;
          public          postgres    false    216            �            1259    25031    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    216            �           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    215            �           0    0    SEQUENCE users_user_id_seq    ACL     �   GRANT ALL ON SEQUENCE public.users_user_id_seq TO spotowner3;
GRANT SELECT,USAGE ON SEQUENCE public.users_user_id_seq TO frank_the_dog;
          public          postgres    false    215            _           2604    25035    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    216    215    216            �          0    25032    users 
   TABLE DATA           G   COPY public.users (user_id, username, password_hash, role) FROM stdin;
    public          postgres    false    216   [       �           0    0    users_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);
          public          postgres    false    215            a           2606    25037    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    216            c           2606    25039    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    216            �   �  x���Y��@ @�oX��(��'�2<���S(JI���N:�����\����V[��H�����8�R��CeZä���]:#k����ݱ0j�Jl�H����C5���հ�NVN�K�^���Y͖��a��7��R�l�c_w�@`�%+y>���������:��`��U ��4�)?��p�;�D9畯��~y�?��39&���-�Y`<���?̌�y;{�3�J�׊�%��O���hm���XN�&PC�Gk�]�����&9v�Q��(�'ҊH�#c�j��5H���`�7l/4�z����1����1�y�p9��z�a��`�pC��l�H7g���^�6`�I�pm1�p]��LZF�xn\����G&�A2��#�#,�[Po��ڭ�k	�e�7C���g��     