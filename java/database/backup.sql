--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-01-23 17:29:09

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 25041)
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    account_id integer NOT NULL,
    user_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(15),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 25040)
-- Name: accounts_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.accounts_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_account_id_seq OWNER TO postgres;

--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 217
-- Name: accounts_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.accounts_account_id_seq OWNED BY public.accounts.account_id;


--
-- TOC entry 222 (class 1259 OID 25075)
-- Name: budgets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.budgets (
    budget_id integer NOT NULL,
    account_id integer NOT NULL,
    category character varying(50) NOT NULL,
    amount_limit numeric(10,2) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT budgets_amount_limit_check CHECK ((amount_limit >= (0)::numeric))
);


ALTER TABLE public.budgets OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25074)
-- Name: budgets_budget_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.budgets_budget_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budgets_budget_id_seq OWNER TO postgres;

--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 221
-- Name: budgets_budget_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.budgets_budget_id_seq OWNED BY public.budgets.budget_id;


--
-- TOC entry 224 (class 1259 OID 25090)
-- Name: goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goals (
    goal_id integer NOT NULL,
    account_id integer NOT NULL,
    goal_name character varying(100) NOT NULL,
    target_amount numeric(10,2) NOT NULL,
    saved_amount numeric(10,2) DEFAULT 0,
    deadline date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT goals_saved_amount_check CHECK ((saved_amount >= (0)::numeric)),
    CONSTRAINT goals_target_amount_check CHECK ((target_amount >= (0)::numeric))
);


ALTER TABLE public.goals OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25089)
-- Name: goals_goal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.goals_goal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.goals_goal_id_seq OWNER TO postgres;

--
-- TOC entry 4910 (class 0 OID 0)
-- Dependencies: 223
-- Name: goals_goal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.goals_goal_id_seq OWNED BY public.goals.goal_id;


--
-- TOC entry 220 (class 1259 OID 25057)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    account_id integer NOT NULL,
    type character varying(10) NOT NULL,
    amount numeric(10,2) NOT NULL,
    category character varying(50),
    date date NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT transactions_amount_check CHECK ((amount > (0)::numeric)),
    CONSTRAINT transactions_type_check CHECK (((type)::text = ANY ((ARRAY['income'::character varying, 'expense'::character varying])::text[])))
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 25056)
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_transaction_id_seq OWNER TO postgres;

--
-- TOC entry 4913 (class 0 OID 0)
-- Dependencies: 219
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- TOC entry 216 (class 1259 OID 25032)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(200) NOT NULL,
    role character varying(50) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 25031)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4916 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4709 (class 2604 OID 25044)
-- Name: accounts account_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts ALTER COLUMN account_id SET DEFAULT nextval('public.accounts_account_id_seq'::regclass);


--
-- TOC entry 4715 (class 2604 OID 25078)
-- Name: budgets budget_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.budgets ALTER COLUMN budget_id SET DEFAULT nextval('public.budgets_budget_id_seq'::regclass);


--
-- TOC entry 4718 (class 2604 OID 25093)
-- Name: goals goal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals ALTER COLUMN goal_id SET DEFAULT nextval('public.goals_goal_id_seq'::regclass);


--
-- TOC entry 4712 (class 2604 OID 25060)
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- TOC entry 4708 (class 2604 OID 25035)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4891 (class 0 OID 25041)
-- Dependencies: 218
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (account_id, user_id, first_name, last_name, email, phone, created_at, updated_at) FROM stdin;
1	3	Nikolas	Knappen	nknappen@gmail.com	410-570-9884	2024-11-11 15:30:00	2024-11-11 16:00:00
3	5	Bobby	Smith	bob@bob.com	123-456-7890	2024-11-12 09:08:53.025521	2024-11-12 09:08:53.025521
4	6	Skipper	Knappen	smknappen@gmail.com	4103499250	2024-11-12 09:24:42.201224	2024-11-12 09:24:42.201224
5	7	Jackson	Knappen	jsknappen@gmail.com	4444444444	2024-11-12 09:35:45.493613	2024-11-12 09:35:45.493613
2	4	Anastasia	Moszkowski	gymlova98@gmail.com	917-684-5505	2024-11-11 17:07:05.260778	2024-11-11 17:07:05.260778
6	8	Scott	Knappen	swknappen@gmail.com	4106867985	2024-11-12 09:43:37.394195	2024-11-12 09:43:37.394195
\.


--
-- TOC entry 4895 (class 0 OID 25075)
-- Dependencies: 222
-- Data for Name: budgets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.budgets (budget_id, account_id, category, amount_limit, start_date, end_date, created_at, updated_at) FROM stdin;
1	1	Housing	2000.00	2024-11-15	2024-12-15	2024-11-14 14:38:21.640426	2024-11-14 14:38:21.640426
2	1	Food	800.00	2024-11-01	2024-11-30	2024-11-18 09:47:29.281991	2024-11-18 09:47:29.281991
3	1	Transportation	50.00	2024-11-01	2024-11-30	2024-11-18 11:12:48.444627	2024-11-18 11:12:48.444627
4	1	Entertainment	200.00	2024-11-01	2024-11-30	2024-11-18 11:13:08.603242	2024-11-18 11:13:08.603242
5	1	Other	50.00	2024-11-01	2024-11-30	2024-11-18 11:13:30.610449	2024-11-18 11:13:30.610449
\.


--
-- TOC entry 4897 (class 0 OID 25090)
-- Dependencies: 224
-- Data for Name: goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goals (goal_id, account_id, goal_name, target_amount, saved_amount, deadline, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4893 (class 0 OID 25057)
-- Dependencies: 220
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (transaction_id, account_id, type, amount, category, date, notes, created_at, updated_at) FROM stdin;
1	1	income	2000.00	Salary	2024-11-12	This will represent a bi-weekly income	2024-11-12 11:05:48.625905	2024-11-12 11:05:48.625905
2	1	expense	200.00	Utility	2024-11-09	Mock BG&E Bill	2024-11-12 14:31:41.845166	2024-11-12 14:31:41.845166
3	1	expense	150.00	Groceries	2024-11-05	Mock Grocerie Bill	2024-11-12 14:34:04.968291	2024-11-12 14:34:04.968291
7	1	income	4000.00	Bonus	2024-11-01	This will represent extra income	2024-11-12 15:36:11.244421	2024-11-12 15:36:11.244421
12	1	expense	100.00	Entertainment	2024-11-01	This will represent extra expense	2024-11-12 15:42:13.50513	2024-11-12 15:42:13.50513
13	1	expense	25.00	Entertainment	2024-11-01	This will represent extra expense test 2	2024-11-12 15:42:45.402981	2024-11-12 15:42:45.402981
14	1	expense	25.00	Entertainment	2024-11-01	This will represent extra expense test 2	2024-11-12 15:43:23.591315	2024-11-12 15:43:23.591315
15	1	expense	25.00	Entertainment	2024-11-01	This will represent extra expense test 3	2024-11-12 15:44:52.045332	2024-11-12 15:44:52.045332
5	1	income	10.00	Venmo	2024-11-04	Testing the edit method	2024-11-12 15:34:32.359695	2024-11-12 15:34:32.359695
17	1	income	55.55		2024-11-13	Testing income from frontend.	2024-11-13 10:11:29.404154	2024-11-13 10:11:29.404154
18	1	expense	10.00		2024-11-11	Testing Calendar	2024-11-13 10:33:51.751212	2024-11-13 10:33:51.751212
19	1	expense	13.50		2024-10-15	Went to the movies with friends!	2024-11-13 10:49:10.332321	2024-11-13 10:49:10.332321
20	1	expense	400.00		2024-11-06	Testing Category	2024-11-13 12:30:00.685066	2024-11-13 12:30:00.685066
23	1	expense	33.33	gas	2024-11-13	Debugging again part 2	2024-11-13 12:43:07.151822	2024-11-13 12:43:07.151822
24	1	income	22.00	interest	2024-11-13	Debugging again part 3	2024-11-13 12:44:20.591248	2024-11-13 12:44:20.591248
26	1	expense	66.33	Dining Out	2024-11-13	Date Night	2024-11-13 12:48:12.941198	2024-11-13 12:48:12.941198
16	1	income	67.89	Bonus	2024-11-13	Did this update part 2	2024-11-13 10:08:21.239672	2024-11-13 10:08:21.239672
27	1	expense	250.00	Home Maintenance	2024-11-14	New table in living room	2024-11-14 11:40:08.105107	2024-11-14 11:40:08.105107
28	1	expense	7.00	Dining Out	2024-11-14	Coffee	2024-11-14 15:32:40.302685	2024-11-14 15:32:40.302685
29	1	expense	180.00	Groceries	2024-10-09	Going way back	2024-11-14 15:37:18.24042	2024-11-14 15:37:18.24042
30	1	expense	200.00	Groceries	2024-11-17	Just got some groceries	2024-11-18 09:01:20.190731	2024-11-18 09:01:20.190731
31	1	expense	30.00	Dining Out	2024-11-16	Coffee and breakfast Sandwiches	2024-11-18 09:02:29.691808	2024-11-18 09:02:29.691808
32	1	expense	80.00	Groceries	2024-11-18	Amazon Order of misc.	2024-11-18 14:35:21.096622	2024-11-18 14:35:21.096622
33	1	expense	30.00	Games	2024-11-19	Subscriptions to PS and X-box	2024-11-19 12:02:01.190451	2024-11-19 12:02:01.190451
34	1	expense	40.00	Fitness	2024-11-20	Monthly Gym membership	2024-11-20 11:09:56.649832	2024-11-20 11:09:56.649832
35	1	expense	700.00	Concerts Events	2024-11-20	Flight	2024-11-20 11:12:08.071976	2024-11-20 11:12:08.071976
25	1	expense	123.45	Mortgage	2024-11-13	Did this update?	2024-11-13 12:45:01.378663	2024-11-13 12:45:01.378663
36	1	expense	180.00	Utilities	2024-11-20	BG&E	2024-11-20 16:20:16.914054	2024-11-20 16:20:16.914054
38	1	expense	40.00	Gas	2024-11-22	Filled Car with Gas	2024-11-22 10:19:50.391887	2024-11-22 10:19:50.391887
39	1	expense	12.34	Movies/Theater	2024-11-22	Went to the Movies	2024-11-22 10:43:42.539508	2024-11-22 10:43:42.539508
40	1	income	2000.00	Salary	2024-10-11	Salary	2024-11-24 20:01:30.880074	2024-11-24 20:01:30.880074
42	1	income	50.00	Gift	2024-09-12	Testing	2024-11-24 20:04:40.015844	2024-11-24 20:04:40.015844
43	1	income	4000.00	Salary	2024-09-20	Monthly Salary	2024-11-24 20:05:13.740353	2024-11-24 20:05:13.740353
44	1	income	4000.00	Salary	2024-08-16	test for chart	2024-11-24 20:10:42.919428	2024-11-24 20:10:42.919428
45	1	expense	250.00	Groceries	2024-08-23	test for chart	2024-11-24 20:11:52.311675	2024-11-24 20:11:52.311675
46	1	expense	600.00	Groceries	2024-10-17	for the chart	2024-11-24 20:13:35.772535	2024-11-24 20:13:35.772535
47	1	expense	800.00	Groceries	2024-07-24	testing 12345 chart test	2024-11-24 20:26:59.147983	2024-11-24 20:26:59.147983
48	1	expense	900.00	Groceries	2024-09-13	testing654321	2024-11-24 20:28:09.726133	2024-11-24 20:28:09.726133
49	1	income	4500.00	Salary	2024-07-17	filling out the chart	2024-11-24 20:28:59.26674	2024-11-24 20:28:59.26674
51	1	expense	1200.00	Groceries	2024-12-20	Data for December	2024-12-04 10:22:35.896889	2024-12-04 10:22:35.896889
52	1	income	4000.00	Salary	2024-11-22	Data for November	2024-12-04 10:23:45.552193	2024-12-04 10:23:45.552193
53	1	expense	500.00	Other	2024-12-06	Shopping	2024-12-06 14:55:43.439576	2024-12-06 14:55:43.439576
54	1	expense	2000.00	Mortgage	2024-12-09		2024-12-09 13:04:08.826701	2024-12-09 13:04:08.826701
50	1	income	6000.00	Salary	2024-12-27	Gathering data for December	2024-12-04 10:21:56.082625	2024-12-04 10:21:56.082625
55	1	expense	40.00	Fitness	2024-12-20	Gym Membership	2024-12-09 13:07:35.532182	2024-12-09 13:07:35.532182
56	1	expense	150.00	Groceries	2024-12-09	Went to store to pick up bread, onions, beef...	2024-12-10 10:57:54.056193	2024-12-10 10:57:54.056193
57	1	expense	175.00	Groceries	2024-12-08	Onions, bananas, meat...	2024-12-10 11:23:06.949722	2024-12-10 11:23:06.949722
58	1	expense	200.00	Dining Out	2024-12-06	Date with my loving and kind wife!	2024-12-10 11:34:29.094974	2024-12-10 11:34:29.094974
\.


--
-- TOC entry 4889 (class 0 OID 25032)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, password_hash, role) FROM stdin;
1	user	$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC	ROLE_USER
2	admin	$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC	ROLE_ADMIN
3	nick	$2a$10$yJ7EzieP5d6OvY4a6kAHbuJiUPGLAR6.zhtSkAyM1gtrm.5EA9owS	ROLE_USER
4	ana	$2a$10$MX1EDaiTj8savbB7ieNQ3.Ipb4OhxQN/xO7PuG7jYu4.RyFvohKy.	ROLE_USER
5	bob	$2a$10$MIT6wZO0KZgCRptZFJXgmOo7m2pXr35YLR.aYjwFoZasRlALJktXy	ROLE_USER
6	skip	$2a$10$oeFzhwQJtBweqvAULfinDuWu8GMwo7p6KTHsTmG1imaXDVrBIrdtK	ROLE_USER
7	jack	$2a$10$9Uiuqj8YNUaU55BWMwgOSONHHGcRvW4sqpLpn2ITGHXL/nmwfkx0a	ROLE_USER
8	scott	$2a$10$qbXY.YhT4ERONUexErItC.Tdiwv7PAUpI4w1wPoam2Z//NmLchaKK	ROLE_USER
\.


--
-- TOC entry 4918 (class 0 OID 0)
-- Dependencies: 217
-- Name: accounts_account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.accounts_account_id_seq', 6, true);


--
-- TOC entry 4919 (class 0 OID 0)
-- Dependencies: 221
-- Name: budgets_budget_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.budgets_budget_id_seq', 5, true);


--
-- TOC entry 4920 (class 0 OID 0)
-- Dependencies: 223
-- Name: goals_goal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.goals_goal_id_seq', 1, false);


--
-- TOC entry 4921 (class 0 OID 0)
-- Dependencies: 219
-- Name: transactions_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_transaction_id_seq', 58, true);


--
-- TOC entry 4922 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 8, true);


--
-- TOC entry 4732 (class 2606 OID 25050)
-- Name: accounts accounts_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_email_key UNIQUE (email);


--
-- TOC entry 4734 (class 2606 OID 25048)
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (account_id);


--
-- TOC entry 4738 (class 2606 OID 25083)
-- Name: budgets budgets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_pkey PRIMARY KEY (budget_id);


--
-- TOC entry 4740 (class 2606 OID 25100)
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (goal_id);


--
-- TOC entry 4736 (class 2606 OID 25068)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- TOC entry 4728 (class 2606 OID 25037)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4730 (class 2606 OID 25039)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4741 (class 2606 OID 25051)
-- Name: accounts accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- TOC entry 4743 (class 2606 OID 25084)
-- Name: budgets budgets_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id) ON DELETE CASCADE;


--
-- TOC entry 4744 (class 2606 OID 25101)
-- Name: goals goals_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id) ON DELETE CASCADE;


--
-- TOC entry 4742 (class 2606 OID 25069)
-- Name: transactions transactions_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(account_id) ON DELETE CASCADE;


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE accounts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.accounts TO spotowner3;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.accounts TO frank_the_dog;


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 217
-- Name: SEQUENCE accounts_account_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.accounts_account_id_seq TO spotowner3;
GRANT SELECT,USAGE ON SEQUENCE public.accounts_account_id_seq TO frank_the_dog;


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE budgets; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.budgets TO spotowner3;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.budgets TO frank_the_dog;


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 221
-- Name: SEQUENCE budgets_budget_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.budgets_budget_id_seq TO spotowner3;
GRANT SELECT,USAGE ON SEQUENCE public.budgets_budget_id_seq TO frank_the_dog;


--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE goals; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.goals TO spotowner3;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.goals TO frank_the_dog;


--
-- TOC entry 4911 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE goals_goal_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.goals_goal_id_seq TO spotowner3;
GRANT SELECT,USAGE ON SEQUENCE public.goals_goal_id_seq TO frank_the_dog;


--
-- TOC entry 4912 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.transactions TO spotowner3;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.transactions TO frank_the_dog;


--
-- TOC entry 4914 (class 0 OID 0)
-- Dependencies: 219
-- Name: SEQUENCE transactions_transaction_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.transactions_transaction_id_seq TO spotowner3;
GRANT SELECT,USAGE ON SEQUENCE public.transactions_transaction_id_seq TO frank_the_dog;


--
-- TOC entry 4915 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO spotowner3;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO frank_the_dog;


--
-- TOC entry 4917 (class 0 OID 0)
-- Dependencies: 215
-- Name: SEQUENCE users_user_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.users_user_id_seq TO spotowner3;
GRANT SELECT,USAGE ON SEQUENCE public.users_user_id_seq TO frank_the_dog;


-- Completed on 2025-01-23 17:29:09

--
-- PostgreSQL database dump complete
--

