--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;


--
-- Data for Name: publications; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY publications (id, title, authors, details, pub_date, poster, "time") FROM stdin;
3	Lectures on Modules and Rings	Lam, Tsit-Yuen	No. 189. Springer	1999-01-01	ryan	2014-12-31 10:56:39.510932-05
4	Rings and Categories of Modules	Anderson, Frank W.; Fuller, Kent R. 	Vol. 13. Springer	1992-01-01	ryan	2014-12-31 13:00:41.60458-05
5	A first course in noncommutative rings	Lam, Tsi-Yuen.	Vol. 131. Springer	2001-01-01	ryan	2014-12-31 13:23:21.700357-05
6	PUBLICATION NEEDED	 (NONE)	 No citation yet exists: please add one.	1805-08-04	rschwiebert	2015-01-01 14:48:02.77944-05
7	 Basic algebra. I. 	Jacobson, Nathan	Second edition. W. H. Freeman and Company, New York	1985-01-01	rschwiebert	2015-01-07 17:14:37.285456-05
8	Algebra: a graduate course.	Isaacs, I. Martin	Brooks/Cole Publishing Company	1994-01-01	rschwiebert	2015-01-07 19:58:49.72867-05
9	Exercises in classical ring theory	Lam, T.Y.	Problem Books in Mathematics. Springer-Verlag	2003-01-01	rschwiebert	2015-01-13 14:18:57.280279-05
10	NONE NEEDED	 	 	0001-01-01	rschwiebert	2015-02-03 19:32:43.193215-05
\.


--
-- Name: publications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('publications_id_seq', 10, true);



--
-- Data for Name: citations; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY citations (id, publication_id, location, poster, "time") FROM stdin;
5	4	Theorem 13.7 p 154	ryan	2014-12-31 13:18:56.870355-05
7	5	Theorem 3.5 p 33	ryan	2014-12-31 13:29:47.289311-05
8	6	 CITATION NEEDED	rschwiebert	2015-01-01 14:48:46.600243-05
9	7	p 453	rschwiebert	2015-01-07 17:14:57.344613-05
10	7	p 452	rschwiebert	2015-01-07 17:17:05.006989-05
11	8	Theorem 13.14 p 185	rschwiebert	2015-01-07 20:05:23.389568-05
12	3	Theorem 7.52  p 262 	rschwiebert	2015-01-13 13:05:12.728953-05
13	9	Exercise 12.18 p 198	rschwiebert	2015-01-13 14:20:04.729501-05
14	4	Corollary 21.9 p 258	rschwiebert	2015-02-01 20:41:57.253698-05
15	10	N/A	rschwiebert	2015-02-03 19:33:17.197177-05
\.


--
-- Name: citations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('citations_id_seq', 15, true);


--
-- Data for Name: comm_properties; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY comm_properties ("property_ID", name, definition, poster) FROM stdin;
1	Artinian	Descending chain condition on ideals	rschwiebert
2	Noetherian	Ascending chain condition on ideals	rschwiebert
3	field	Nonzero elements invertible	rschwiebert
4	local	Has a unique maximal ideal	rschwiebert
5	domain	no nonzero zero divisors	rschwiebert
6	reduced	no nonzero nilpotent elements	rschwiebert
7	Dedekind domain	A domain whose ideals are projective modules	rschwiebert
8	Prufer domain	A domain whose finitely generated ideals are projective modules	rschwiebert
9	Euclidean domain	A domain which has a Euclidean valuation	rschwiebert
10	principal ideal domain	A domain whose ideals are principal	rschwiebert
11	principal ideal ring	All ideals are principal	rschwiebert
12	Bezout domain	A domain whose finitely generated ideals are principal	rschwiebert
13	unique factorization domain	A domain in which every nonzero nonunit is a product of irreducible elements, unique up to equivalence	rschwiebert
14	von Neumann regular	For all a, there exists x such that a^2x=a	rschwiebert
15	semisimple	The ring is a semisimple module	rschwiebert
16	regular local	Noetherian local ring where the minimal number of generators for the maximal ideal is equal to its Krull dimension	rschwiebert
17	regular	Noetherian ring whose localizations at primes are regular local rings	rschwiebert
18	Cohen-Macaulay	Ring whose localizations at primes all have depth equal to their Krull dimension	rschwiebert
19	normal	Ring whose localizations at primes all are normal domains	rschwiebert
20	Gorenstein	Ring whose localizations at primes all are Noetherian and have finite injective dimension	rschwiebert
21	Frobenius	Noetherian and self-injective ring	rschwiebert
22	valuation	Ideals of the ring are linearlly ordered	rschwiebert
24	Mori domain	A domain satisfying the ACC on divisorial ideals	rschwiebert
25	GCD domain	A domain having a gcd for every pair of elements	rschwiebert
26	atomic domain	A domain in which nonzero nonunits can be written as a finite product of irreducible elements.	rschwiebert
27	ACC principal	Ascending chain condition on principal ideals	rschwiebert
28	semilocal	Finitely many maximal ideals	rschwiebert
29	Jacobson	Prime ideals are intersections of maximal ideals	rschwiebert
30	semiprimitive	Jacobson radical zero	rschwiebert
31	perfect field	A field in which the Frobenius endomorphism is onto	rschwiebert
32	algebraically closed field	Every nonconstant polynomial over the field has a root in the field 	rschwiebert
33	Euclidean field	An ordered field for which every positive element is the square of another element	rschwiebert
34	quadratically closed field	Every element is a square of another element	rschwiebert
35	ordered field	the field is totally ordered with an order compatible with the ring operations	rschwiebert
36	Pythagorean field	The sum of two squares is a square	rschwiebert
37	characteristic 0 field	The sum of any positive number of 1's is always nonzero.	rschwiebert
38	finite	finitely many elements	rschwiebert
39	Schreier domain	normal domain in which every element is primal	rschwiebert
40	normal domain	domain that is integrally closed in its field of fractions	rschwiebert
41	serial	The ring is a direct 	rschwiebert
42	strongly pi regular	DCC on ideals of the form (x)>(x^2)>(x^3)>...	rschwiebert
43	semiprimary	R/rad(R) is semisimple and rad(R) is nilpotent	rschwiebert
44	Bezout ring	Finitely generated ideals are principal	rschwiebert
45	semiregular	R/rad(R) is von Neumann regular, and rad(R) is nil	rschwiebert
46	rad-nil	Nil(R)=J.rad(R)	rschwiebert
47	continuous		rschwiebert
48	dual	ann(ann(I))=I for every ideal I	rschwiebert
49	pseudo Frobenius		rschwiebert
50	coherent	every finitely generated ideal is finitely presented	rschwiebert
51	semiperfect	R is semilocal and lift/rad	rschwiebert
52	perfect	R is semilocal and rad(R) is T-nilpotent	rschwiebert
53	self-injective	R is injective as an R module	rschwiebert
54	stable range 1	If xa+b=1, there is a y such that a+yb is a unit	rschwiebert
55	finitely pseudo Frobenius		rschwiebert
56	clean		rschwiebert
57	distributive	lattice of ideals is distributive (also called "arithmetical ring")	rschwiebert
58	connected	The only idempotents are 0 and 1	rschwiebert
59	Kasch	Simple modules embed into the ring as ideals	rschwiebert
60	local complete intersection ring	Noetherian local ring whose completion is the quotient of a regular local ring by an ideal generated by a regular sequence	rschwiebert
61	Krull domain	localizations at height 1 primes are all discrete valuation rings	rschwiebert
\.


--
-- Data for Name: comm_equivalents; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY comm_equivalents (id, "property_ID", equivalent, kwds, source, poster) FROM stdin;
1	1	Descending chain condition on ideals	internal, ideals, chain condition	(Definition)	\N
2	1	Minimum condition on ideals	internal, ideals	Anderson/Fuller Rings and categories of modules p 127 Prop 10.10	\N
3	1	Every quotient by an ideal is finitely cogenerated	internal, ideals	Anderson/Fuller Rings and categories of modules p 127 Prop 10.10	\N
4	1	Every finitely generated module is Artinian	modules,	Anderson/Fuller Rings and categories of modules p 130 Prop 10.18	\N
5	2	Ascending chain condition on ideals	internal, ideals, chain condition	(Definition)	\N
6	2	Ascending chain condition on finitely generated ideals	internal, ideals, chain condition	obvious	\N
7	2	Maximum condition on ideals	internal, ideals	Anderson/Fuller Rings and categories of modules p 127 Prop 10.9	\N
8	2	Every direct sum of injective modules is injective	homological	Anderson/Fuller Rings and categories of modules p 209 Prop 18.13	\N
9	2	All ideals are finitely generated	internal, ideals	Anderson/Fuller Rings and categories of modules p 127 Prop 10.9	\N
10	2	Every finitely generated module is Noetherian	modules,	Anderson/Fuller Rings and categories of modules p 130 Prop 10.19	\N
11	1	Every direct product of projective modules is projective	homological	T.Y. Lam Lectures on modules and rings p 161 Ex 2	\N
12	52	the ring is semilocal and the Jacobson radical is T-nilpotent	Jacobson radical	(Definition)	\N
13	52	Descending chain condition on finitely generated ideals	internal, ideals, chain condition	T.Y. Lam First course in noncommutative rings p 345	\N
14	52	Descending chain condition on principal ideals	internal, ideals, chain condition	T.Y. Lam First course in noncommutative rings p 344 Thm 23.20	\N
15	52	Every module has a projective cover	homological, modules	T.Y. Lam First course in noncommutative rings pg 354 Them 24.18	\N
16	52	Every flat module is projective	homological, modules	T.Y. Lam First course in noncommutativerings p 357 Thm 24.25	\N
17	51	Every finitely generated module has a projective cover	homological, modules	T.Y. Lam First course in noncommutative rings p 353 Thm 24.16	\N
18	51	Every cyclic module has a projective cover	homological, modules	T.Y. Lam First course in noncommutative rings p 353 Thm 24.16	\N
19	51	R is semilocal and idempotents lift mod the Jacobson radical	internal, Jacobson radical	(Definition)	\N
20	52	Every module satisfies ACC on cyclic submodules	modules, chain condition	T.Y. Lam First course in noncommutative rings p 345 Thm 23.20	\N
21	52	Every module satisfies DCC on cyclic submodules	modules, chain condition	T.Y. Lam First course in noncommutative rings p 345 Thm 24.20	\N
22	14	For all a, there exists x such that a^2x=a	internal,	(Definition)	\N
23	14	Every principal ideal is a direct summand	internal, ideals	T.Y. Lam First course in noncommutative rings p 61 Thm 4.23	\N
24	14	Every finitely generated ideal is a direct summand	internal, ideals	T.Y. Lam First course in noncommutative rings p 61 Thm 4.23	\N
25	14	the ring is reduced and has Krull dimension 0	internal, Krull dimension	T.Y. Lam First course in noncommutative rings p 65 Ex 4.15	\N
26	14	localizations at maximal ideals are all fields	max local, 	T.Y. Lam First course in noncommutative rings p 65 Ex 4.15	\N
27	14	all modules are flat	homological, modules	T.Y. Lam Lectures on modules and rings p 128 Thm 4.21	\N
28	14	Every cyclic module is flat	homological, modules	T.Y. Lam Lectures on modules and rings p 128 Thm 4.21	\N
29	14	All simple modules are injective	homological, modules	T.Y. Lam Lectures on modules and rings p 9.7 Cor 3.73	\N
30	14	All modules are principally injective	homological, modules	T.Y. Lam Lectures on modules and rings p 9.7 Cor 3.73	\N
31	14	All ideals are semiprime/all quotients are reduced rings	internal, ideals, quotients	obvious	\N
32	14	All quotients are semiprimitive	quotients	T.Y. Lam Lectures on modules and rings p 99 Thm 3.75	\N
33	14	All modules have Jacobson radical zero	modules, radical	T.Y. Lam Lectures on modules and rings p 99 Thm 3.75	\N
34	2	prime ideals are finitely generated	internal, primes	I. S. Cohen  Commutative rings with restricted minimum condition (1950) Thm 2	\N
35	59	simple modules embed as ideals	modules, ideals	(Definition)	\N
36	59	Every maximal ideal is the annihilator of a single element	internal, ideal, annihilator	T.Y. Lam Lectures on Modules and Rings p 281 Cor 8.28	\N
37	59	All maximal ideals have nonzero annihilator	ideals, annihilators	T.Y. Lam Lectures on Modules and Rings p 281 Cor 8.28	\N
38	59	For each maximal ideal M, ann(ann(M))=M	ideals, annihilators	T.Y. Lam Lectures on Modules and Rings p 281 Cor 8.28	\N
39	21	The ring is Noetherian on a side and self-injective on a side	chain condition	T.Y. Lam Lectures on Modules and Rings p 409 Thm 15.1	\N
40	21	The ring is Noetherian and dual	chain condition, annihilator	T.Y. Lam Lectures on Modules and Rings p 409 Thm 15.1	\N
41	21	projective modules are injective	homological, modules	C. Faith Algebra II: Ring theory p 209	\N
42	21	injective modules are projective	homological, modules	C. Faith Algebra II: Ring theory p 209	\N
43	21	The ring is Artinian with a square-free socle	internal, chain condition	T.Y. Lam Lectures on modules and rings p 418 Thm 15.27	\N
44	15	The ring is a semisimple module	internal	(Definition)	\N
45	15	All modules are semisimple	modules	 	\N
46	15	All modules are projective	homological, modules	 	\N
47	15	All modules are injective	homological, modules	 	\N
\.


--
-- Name: comm_equivalents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('comm_equivalents_id_seq', 48, false);


--
-- Name: comm_invariance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('comm_invariance_id_seq', 2, true);


--
-- Data for Name: properties; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY properties ("property_ID", name, definition, poster, comm_version_id) FROM stdin;
7	simple	Only ideals are the two trivial ideals	rschwiebert	\N
10	prime	The product of nonzero right ideals is nonzero	rschwiebert	\N
11	semiprime	No nonzero nilpotent right ideals	rschwiebert	\N
13	strongly regular	von Neumann regular and reduced	rschwiebert	\N
15	unit regular	For every x, there exists a unit u such that x=xux	rschwiebert	\N
24	Ore domain (right)	Domain satisfying right Ore condition	rschwiebert	\N
25	Ore domain (left)	Domain satisfying left Ore condition	rschwiebert	\N
26	hereditary (right)	All right ideals are projective	rschwiebert	\N
27	hereditary (left)	All left ideals are projective	rschwiebert	\N
28	semihereditary (right)	All finitely generated right ideals are projective	rschwiebert	\N
29	semihereditary (left)	All finitely generated left ideals are projective	rschwiebert	\N
30	Rickart (right)	For any x in R, the right annihilator of x is a summand of R	rschwiebert	\N
31	Rickart (left)	For any x in R, the left annihilator of x is a suammand of R	rschwiebert	\N
32	Baer	For any subset X of R, the right annihilator of X is a summand of R	rschwiebert	\N
34	nonsingular (right)	The right singular ideal is zero	rschwiebert	\N
35	nonsingular (left)	The left singular ideal is zero	rschwiebert	\N
38	V ring (right)	The Jacobson radical of every right module is zero	rschwiebert	\N
39	V ring (left)	The Jacobson radical of every left module is zero	rschwiebert	\N
45	quasi-Frobenius	Noetherian and self-injective	rschwiebert	\N
60	lift/rad	Idempotents of R/rad(R) lift to idempotents in R	rschwiebert	\N
61	Dedekind finite	xy=1 implies yx=1	rschwiebert	\N
62	stably finite	Every matrix ring of R is Dedekind finite	rschwiebert	\N
64	IBN	If R^n is isomorphic to R^m, then n=m	rschwiebert	\N
65	cohopfian (right)	For every x with right annihilator zero, x is a unit	rschwiebert	\N
66	cohopfian (left)	For every x with left annihilator zero, x isa unit	rschwiebert	\N
67	duo (right)	All right ideals are two-sided ideals	rschwiebert	\N
68	duo (left)	All left ideals are two-sided ideals	rschwiebert	\N
69	finite uniform dimension (right)	R has finite uniform dimension as a right R module	rschwiebert	\N
70	finite uniform dimension (left)	R has finite uniform dimension as a left module	rschwiebert	\N
71	Goldie (right)	R has finite right uniform dimension and  ACC on right annihilators	rschwiebert	\N
72	Goldie (left)	R has finite left uniform dimension and ACC on left annihilators	rschwiebert	\N
73	coherent (right)	Every finitely generated right ideal is finitely presented	rschwiebert	50
63	finite	R has only finitely many elements	rschwiebert	38
59	perfect (right)	R is semilocal and rad(R) is right T-nilpotent	rschwiebert	52
58	perfect (left)	R is semilocal and rad(R) is left T-nilpotent	rschwiebert	52
57	semiperfect	R is semilocal and lift/rad	rschwiebert	51
56	semilocal	R/rad(R) is Artinian	rschwiebert	28
55	local	R/rad(R) is a division ring	rschwiebert	4
54	semiprimary	R is semilocal and rad(R) is nilpotent	rschwiebert	43
43	serial (left)	R is a direct sum of left ideals whose submodules are linearly ordered	rschwiebert	41
42	serial (right)	R is a direct sum of right ideals whose submodules are linearly ordered	rschwiebert	41
41	valuation ring (left)	The left ideals of R are linearly ordered	rschwiebert	22
40	valuation ring (right)	The right ideals of R are linearly ordered	rschwiebert	22
33	domain	No nonzero zero divisors	rschwiebert	5
23	Bezout domain (left)	Left Bezout domain	rschwiebert	12
22	Bezout domain (right)	Right Bezout domain	rschwiebert	12
21	Bezout (left)	Finitely generated left ideals are cyclic	rschwiebert	44
20	Bezout (right)	Finitely generated right ideals are cyclic	rschwiebert	44
19	principal ideal ring (left)	All left ideals are principal	rschwiebert	11
18	principal ideal ring (right)	All right ideals are cyclic	rschwiebert	11
17	principal ideal domain (left)	Domain which is a principal left ideal ring	rschwiebert	10
16	principal ideal domain (right)	Domain which is a principal right ideal ring	rschwiebert	10
14	reduced	No nonzero nilpotent elements	rschwiebert	6
12	von Neumann regular	For every x, there exists y such that x=xyx	rschwiebert	14
6	division ring	all nonzero elements are units	rschwiebert	3
75	ACC principal (right)	Ascending chain condition on principal right ideals	rschwiebert	\N
76	ACC principal (left)	Ascending chain condition on principal left ideals	rschwiebert	\N
77	ACC annihilator (right)	Ascending chain condition on right annihilators=Descending chain condition on left annihilators	rschwiebert	\N
78	ACC annihilator (left)	Ascending chain condition on left annihilators	rschwiebert	\N
79	DCC annihilator (right)	Descending chain condition on right annihilators=Ascending chain condition on left annihilators	rschwiebert	\N
80	DCC annihilator (left)	Descending chain condition on left annihilators	rschwiebert	\N
83	strongly pi regular	For all x, xR>x^2R>x^3R>... terminates	rschwiebert	\N
84	pi regular	For all a in R there exists an x in R and a natural number n such that (a^n)x(a^n)=a	rschwiebert	\N
85	exchange	If a+b=1, there exists r and s such that ar and bs are idempotents and ar+bs=1	rschwiebert	\N
86	I_0	Every right ideal not contained in rad(R) contains a nonzero idempotent	rschwiebert	\N
3	Artinian (left)	Descending chain condition on left ideals	rschwiebert	1
9	semiprimitive	Jacobson radical zero	rschwiebert	\N
2	Artinian (right)	Descending chain condition on right ideals	rschwiebert	1
37	primitive (left)	There exists a faithful simple left R module	rschwiebert	\N
36	primitive (right)	There exists a faithful simple right R module	rschwiebert	\N
8	semisimple	semiprimitive and Artinian	rschwiebert	\N
1	commutative	xy=yx for all x and y in the ring	rschwiebert	\N
87	Zorn	R is I_0 and rad(R) is a nil ideal	rschwiebert	\N
89	polynomial identity		rschwiebert	\N
91	stable range 1	If xa+b=1, there is a y such that a+yb is a unit	rschwiebert	\N
94	free ideal ring (left)	All left ideals are free modules and of unique rank	rschwiebert	\N
95	free ideal ring (right)	All right ideals are free modules and of unique rank	rschwiebert	\N
96	semi free ideal ring	All finitely generate right ideals are free and of unique rank	rschwiebert	\N
97	fully semiprime	all proper ideals are semiprime	rschwiebert	\N
98	fully prime	all proper ideals are prime	rschwiebert	\N
99	Ore ring (right)	Satisfies right Ore conditions	rschwiebert	\N
100	Ore ring (left)	Satisfies left Ore conditions	rschwiebert	\N
101	Abelian	All idempotents are central	rschwiebert	\N
102	principally injective (right)	homomorphisms from principal right ideals of the ring into the ring extend to endomorphisms of the ring	rschwiebert	\N
103	principally injective (left)	homomorphisms from principal left ideals of the ring into the ring extend to endomorphisms of the ring	rschwiebert	\N
105	nilpotent radical	Has nilpotent Jacobson radical	rschwiebert	\N
106	quasi-duo (right)	maximal right ideals are two-sided	rschwiebert	\N
107	quasi-duo (left)	maximal left ideals are two-sided	rschwiebert	\N
108	orthogonally finite	families of orthogonal idempotents are all finite	rschwiebert	\N
109	nil radical	Has nil Jacobson radical	rschwiebert	\N
110	T-nilpotent radical (right)	Has right T-nilpotent Jacobson radical	rschwiebert	\N
111	T-nilpotent radical (left)	Has left T-nilpotent Jacobson radical	rschwiebert	\N
112	simple socle (right)	The right socle is a minimal right ideal	rschwiebert	\N
113	simple socle (left)	The left socle is a minimal left ideal	rschwiebert	\N
114	finitely generated socle (right)	Finitely generated right socle	rschwiebert	\N
115	finitely generated socle (left)	Finitely generated left socle	rschwiebert	\N
116	nonzero socle (right)	Nonzero right socle	rschwiebert	\N
117	nonzero socle (left)	Nonzero left socle	rschwiebert	\N
118	essential socle (right)	Essential right socle	rschwiebert	\N
119	essential socle (left)	Essential left socle	rschwiebert	\N
120	cogenerator ring (right)	The ring cogenerates its category of right modules	rschwiebert	\N
121	cogenerator ring (left)	The ring cogenerates its category of left modules	rschwiebert	\N
122	finitely cogenerated (right)	The ring is finitely cogenerated as a right module	rschwiebert	\N
123	finitely cogenerated (left)	The ring is finitely cogenerated as a left module	rschwiebert	\N
126	uniform (right)	All nonzero right ideals essential	rschwiebert	\N
127	uniform (left)	All nonzero left ideals essential	rschwiebert	\N
128	2-primal	All minimal prime ideals are completely prime	rschwiebert	\N
129	reversible	ab=0 implies ba=0	rschwiebert	\N
130	symmetric	abc=0 implies acb=0	rschwiebert	\N
131	primary	R semiprimary and R/rad(R) simple	rschwiebert	\N
132	top simple	R/rad(R) simple	rschwiebert	\N
133	top simple Artinian	R/rad(R) simple Artinian	rschwiebert	\N
134	top regular	R/rad(R) von Neumann regular	rschwiebert	\N
135	simple Artinian	R is simple and Artinian	rschwiebert	\N
125	distributive (left)	Latice of left ideals is a distributive lattice	rschwiebert	57
124	distributive (right)	Lattice of right ideals is a distributive lattice	rschwiebert	57
93	continuous (left)	DEFINE	rschwiebert	47
92	continuous (right)	DEFINE	rschwiebert	47
90	clean	Every element is the sum of a unit and an idempotent	rschwiebert	56
88	semiregular	R is lift/rad and R/rad(R) is von Neumann regular	rschwiebert	45
82	dual (left)	For every left ideal B, l.ann(r.ann(B))=B	rschwiebert	48
81	dual (right)	For every right ideal B, r.ann(l.ann(B))=B	rschwiebert	48
74	coherent (left)	Every finitely generated left ideal is finitely presented	rschwiebert	50
53	Kasch (left)	Every simple left module is isomorphic to a minimal left ideal of R	rschwiebert	59
52	Kasch (right)	Every simple right module is isomorphic to a minimal right ideal of R	rschwiebert	59
51	self-injective (left)	R is injective as a left module	rschwiebert	53
50	self-injective (right)	R is injective as a right module	rschwiebert	53
49	finitely pseudo-Frobenius (left)	Every finitely generated faithful left module is a generator for the category of R modules	rschwiebert	55
48	finitely pseudo-Frobenius (right)	Every finitely generated faithful right module is a generator for the category of R modules	rschwiebert	55
47	pseudo-Frobenius (left)	R is left self-injective and finitely cogenerated as a left module	rschwiebert	49
46	pseudo-Frobenius (right)	R is right self-injective and finitely cogenerated as a right module	rschwiebert	49
44	Frobenius	R is quasi-Frobenius and the right socle is isomorphic to R/rad(R)	rschwiebert	21
5	Noetherian (left)	Ascending chain condition on left ideals	rschwiebert	2
4	Noetherian (right)	Ascending chain condition on right ideals	rschwiebert	2
104	connected	The only idempotents are 0 and 1	rschwiebert	58
\.


--
-- Data for Name: theorems; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY theorems (theorem_id, alias, statement, link, poster, "time", characterizes_id, comm_characterizes_id) FROM stdin;
1	Artin - Wedderburn theorem	A semisimple ring is a finite direct product of full matrix rings over division rings		rschwiebert	2014-12-31 13:20:12.842644-05	\N	\N
2	Wedderburn's little theorem	A finite division ring is a field	https://en.wikipedia.org/wiki/Wedderburn%27s_little_theorem	rschwiebert	2015-01-07 17:15:16.032752-05	\N	\N
3	Frobenius' theorem	The only finite dimensional associative division algebras over the real numbers are the reals, the complex numbers, and the quaternions.	https://en.wikipedia.org/wiki/Frobenius_theorem_(real_division_algebras)	rschwiebert	2015-01-07 17:17:15.821537-05	\N	\N
4	Jacobson density theorem	Let U be a simple right R module, and D be the ring of endomorphisms of U. If A is any D linear operator and X is any finite subset of R, there exists r in R such that xr=xA for all x in X.	https://en.wikipedia.org/wiki/Jacobson_density_theorem	rschwiebert	2015-01-07 20:05:35.978287-05	\N	\N
5		For a right self-injective ring, T.F.A.E. : von Neumann regular, right semihereditary, right Rickart, right Nonsingular, Baer		rschwiebert	2015-01-13 13:05:26.753591-05	\N	\N
6		2-primal implies Dedekind finite		rschwiebert	2015-01-13 14:20:16.795623-05	\N	\N
7	Artinian, Noetherian, semisimple, semiprimitive, primitive are Morita invariant	If R and S are Morita equivalent rings, then R is semisimple, left artinian, left noetherian, primitive or a ring with zero radical iff S is. (Left can be replaced with right everywhere.)		rschwiebert	2015-02-01 20:44:45.023209-05	\N	\N
8	OBVIOUS	This is straightforward		rschwiebert	2015-02-03 19:33:59.272666-05	\N	\N
\.


--
-- Data for Name: comm_logic; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY comm_logic ("logic_ID", entry_type, cond_1, cond_2, cond_3, cond_4, conc, option, citation, poster, readable, theorem_id) FROM stdin;
3	2	3	38	\N	\N	31	on		rschwiebert	field and finite implies perfect field	\N
4	1	1	\N	\N	\N	18	on		rschwiebert	Artinian implies Cohen-Macaulay	\N
6	1	1	\N	\N	\N	43	on		rschwiebert	Artinian implies semiprimary	\N
7	1	26	\N	\N	\N	5	on		rschwiebert	atomic domain implies domain	\N
9	1	12	\N	\N	\N	25	on		rschwiebert	Bezout domain implies GCD domain	\N
11	1	37	\N	\N	\N	31	on		rschwiebert	characteristic 0 field implies perfect field	\N
12	1	47	\N	\N	\N	45	on		rschwiebert	continuous implies semiregular	\N
14	1	7	\N	\N	\N	40	off		rschwiebert	Dedekind domain implies normal domain	\N
15	1	7	\N	\N	\N	2	on		rschwiebert	Dedekind domain implies Noetherian	\N
17	1	48	\N	\N	\N	28	on		rschwiebert	dual implies semilocal	\N
18	1	48	\N	\N	\N	47	on		rschwiebert	dual implies continuous	\N
20	1	33	\N	\N	\N	36	on		rschwiebert	Euclidean field implies Pythagorean field	\N
22	1	3	\N	\N	\N	22	on		rschwiebert	field implies valuation	\N
23	1	3	\N	\N	\N	9	on		rschwiebert	field implies Euclidean domain	\N
25	1	3	\N	\N	\N	16	on		rschwiebert	field implies regular local	\N
26	1	21	\N	\N	\N	20	on		rschwiebert	Frobenius implies Gorenstein	\N
28	1	21	\N	\N	\N	49	on		rschwiebert	Frobenius implies pseudo Frobenius	\N
30	1	20	\N	\N	\N	18	on		rschwiebert	Gorenstein implies Cohen-Macaulay	\N
31	1	2	\N	\N	\N	50	on		rschwiebert	Noetherian implies coherent	\N
33	1	40	\N	\N	\N	5	on		rschwiebert	normal domain implies domain	\N
35	1	52	\N	\N	\N	51	on		rschwiebert	perfect implies semiperfect	\N
36	1	31	\N	\N	\N	3	on		rschwiebert	perfect field implies field	\N
38	1	10	\N	\N	\N	13	on		rschwiebert	principal ideal domain implies unique factorization domain	\N
40	1	10	\N	\N	\N	11	on		rschwiebert	principal ideal domain implies principal ideal ring	\N
42	1	10	\N	\N	\N	2	on		rschwiebert	principal ideal domain implies Noetherian	\N
43	1	8	\N	\N	\N	5	on		rschwiebert	Prufer domain implies domain	\N
45	1	49	\N	\N	\N	48	on		rschwiebert	pseudo Frobenius implies dual	\N
47	1	34	\N	\N	\N	36	on		rschwiebert	quadratically closed field implies Pythagorean field	\N
49	1	16	\N	\N	\N	20	off		rschwiebert	regular local implies Gorenstein	\N
50	1	16	\N	\N	\N	17	on		rschwiebert	regular local implies regular	\N
52	1	53	\N	\N	\N	54	on		rschwiebert	self-injective implies stable range 1	\N
53	1	53	\N	\N	\N	47	on		rschwiebert	self-injective implies continuous	\N
55	1	28	\N	\N	\N	54	on		rschwiebert	semilocal implies stable range 1	\N
57	1	51	\N	\N	\N	28	on		rschwiebert	semiperfect implies semilocal	\N
58	1	43	\N	\N	\N	52	on		rschwiebert	semiprimary implies perfect	\N
60	1	45	\N	\N	\N	56	on		rschwiebert	semiregular implies clean	\N
61	1	15	\N	\N	\N	11	on		rschwiebert	semisimple implies principal ideal ring	\N
63	1	15	\N	\N	\N	41	on		rschwiebert	semisimple implies serial	\N
64	1	15	\N	\N	\N	21	on		rschwiebert	semisimple implies Frobenius	\N
66	1	42	\N	\N	\N	54	on		rschwiebert	strongly pi regular implies stable range 1	\N
68	1	13	\N	\N	\N	25	on		rschwiebert	unique factorization domain implies GCD domain	\N
70	1	22	\N	\N	\N	4	on		rschwiebert	valuation implies local	\N
71	1	22	\N	\N	\N	44	on		rschwiebert	valuation implies Bezout ring	\N
73	1	14	\N	\N	\N	30	on		rschwiebert	von Neumann regular implies semiprimitive	\N
75	1	14	\N	\N	\N	42	on		rschwiebert	von Neumann regular implies strongly pi regular	\N
76	1	29	\N	\N	\N	46	on		rschwiebert	Jacobson implies rad-nil	\N
78	1	19	\N	\N	\N	6	on		rschwiebert	normal implies reduced	\N
80	1	17	\N	\N	\N	20	on		rschwiebert	regular implies Gorenstein	\N
81	2	12	27	\N	\N	10	on		rschwiebert	Bezout domain and ACC principal implies principal ideal domain	\N
83	1	14	\N	\N	\N	19	on	localizations at primes are fields	rschwiebert	von Neumann regular implies normal	\N
85	1	8	\N	\N	\N	40	on		rschwiebert	Prufer domain implies normal domain	\N
86	1	8	\N	\N	\N	57	on		rschwiebert	Prufer domain implies distributive	\N
87	2	5	57	\N	\N	8	on		rschwiebert	domain and distributive implies Prufer domain	\N
89	2	1	58	\N	\N	4	on		rschwiebert	Artinian and connected implies local	\N
90	2	1	41	\N	\N	21	on		rschwiebert	Artinian and serial implies Frobenius	\N
92	2	4	12	\N	\N	22	on	P.M. Cohn Bezout rings and their subrings	rschwiebert	local and Bezout domain implies valuation	\N
93	2	27	44	\N	\N	2	on	ACC f.g. ideals clearly implies ACC on all ideals	rschwiebert	ACC principal and Bezout ring implies Noetherian	\N
94	2	11	43	\N	\N	41	on		rschwiebert	principal ideal ring and semiprimary implies serial	\N
95	3	4	11	43	\N	22	on		rschwiebert	local and principal ideal ring and semiprimary implies valuation	\N
98	2	2	48	\N	\N	21	on	T.Y. Lam, Lectures on Modules and Rings 409	rschwiebert	Noetherian and dual implies Frobenius	\N
99	1	4	\N	\N	\N	58	on		rschwiebert	local implies connected	\N
100	1	5	\N	\N	\N	58	on	x^2-x=0 implies x=0,1	rschwiebert	domain implies connected	\N
101	2	38	5	\N	\N	3	on	Wedderburn's little theorem	rschwiebert	finite and domain implies field	\N
103	2	50	52	\N	\N	1	on	T.Y. Lam Lectures on Rings and Modules pg 161 Ex #2	rschwiebert	coherent and perfect implies Artinian	\N
105	2	45	46	\N	\N	29	on	primes are maximal	rschwiebert	semiregular and rad-nil implies Jacobson	\N
106	1	29	\N	\N	\N	46	on	obvious	rschwiebert	Jacobson implies rad-nil	\N
107	1	30	\N	\N	\N	46	on	nilradical is containedin the Jacobson radical	rschwiebert	semiprimitive implies rad-nil	\N
1	2	27	5	\N	\N	26	on		rschwiebert	ACC principal and domain implies atomic domain	\N
2	1	32	\N	\N	\N	34	on		rschwiebert	algebraically closed field implies quadratically closed field	\N
5	1	1	\N	\N	\N	2	on		rschwiebert	Artinian implies Noetherian	\N
8	1	12	\N	\N	\N	8	on		rschwiebert	Bezout domain implies Prufer domain	\N
10	1	12	\N	\N	\N	44	on		rschwiebert	Bezout domain implies Bezout ring	\N
13	1	7	\N	\N	\N	8	on		rschwiebert	Dedekind domain implies Prufer domain	\N
16	1	5	\N	\N	\N	6	on		rschwiebert	domain implies reduced	\N
19	1	9	\N	\N	\N	10	on		rschwiebert	Euclidean domain implies principal ideal domain	\N
21	1	33	\N	\N	\N	35	on		rschwiebert	Euclidean field implies ordered field	\N
24	1	3	\N	\N	\N	15	on		rschwiebert	field implies semisimple	\N
27	1	21	\N	\N	\N	1	on		rschwiebert	Frobenius implies Artinian	\N
29	1	25	\N	\N	\N	39	on		rschwiebert	GCD domain implies Schreier domain	\N
32	1	2	\N	\N	\N	27	on		rschwiebert	Noetherian implies ACC principal	\N
34	1	35	\N	\N	\N	37	on		rschwiebert	ordered field implies characteristic 0 field	\N
37	1	10	\N	\N	\N	12	on		rschwiebert	principal ideal domain implies Bezout domain	\N
39	1	10	\N	\N	\N	7	on		rschwiebert	principal ideal domain implies Dedekind domain	\N
41	1	10	\N	\N	\N	44	on		rschwiebert	principal ideal domain implies Bezout ring	\N
44	1	49	\N	\N	\N	51	on		rschwiebert	pseudo Frobenius implies semiperfect	\N
46	1	49	\N	\N	\N	53	on		rschwiebert	pseudo Frobenius implies self-injective	\N
48	1	16	\N	\N	\N	13	on		rschwiebert	regular local implies unique factorization domain	\N
51	1	39	\N	\N	\N	40	on		rschwiebert	Schreier domain implies normal domain	\N
54	1	53	\N	\N	\N	55	on		rschwiebert	self-injective implies finitely pseudo Frobenius	\N
56	1	51	\N	\N	\N	45	on		rschwiebert	semiperfect implies semiregular	\N
59	1	30	\N	\N	\N	6	on		rschwiebert	semiprimitive implies reduced	\N
62	1	15	\N	\N	\N	14	on		rschwiebert	semisimple implies von Neumann regular	\N
65	1	41	\N	\N	\N	51	on		rschwiebert	serial implies semiperfect	\N
67	1	42	\N	\N	\N	45	on		rschwiebert	strongly pi regular implies semiregular	\N
69	1	13	\N	\N	\N	27	on		rschwiebert	unique factorization domain implies ACC principal	\N
72	1	14	\N	\N	\N	44	on		rschwiebert	von Neumann regular implies Bezout ring	\N
74	1	14	\N	\N	\N	50	on		rschwiebert	von Neumann regular implies coherent	\N
77	1	40	\N	\N	\N	19	on		rschwiebert	normal domain implies normal	\N
79	2	27	5	\N	\N	26	on	P.M. Cohn Bezout rings and their subrings	rschwiebert	ACC principal and domain implies atomic domain	\N
82	2	39	26	\N	\N	13	on		rschwiebert	Schreier domain and atomic domain implies unique factorization domain	\N
84	1	8	\N	\N	\N	50	on	(Chase's Theorem) Lam, Lectures on Modules and rings pg 146	rschwiebert	Prufer domain implies coherent	\N
88	2	39	26	\N	\N	13	on	P.M. Cohn Bezout rings and their subrings Thm 2.3	rschwiebert	Schreier domain and atomic domain implies unique factorization domain	\N
91	2	8	39	\N	\N	12	on	P.M. Cohn Bezout rings and their subrings Thm 2.8	rschwiebert	Prufer domain and Schreier domain implies Bezout domain	\N
96	1	36	\N	\N	\N	3	on	obvious	rschwiebert	Pythagorean field implies field	\N
97	2	2	53	\N	\N	21	on	T.Y. Lam, Lectures on Modules and Rings 409	rschwiebert	Noetherian and self-injective implies Frobenius	\N
102	2	41	58	\N	\N	22	on	obvious	rschwiebert	serial and connected implies valuation	\N
104	2	30	7	\N	\N	29	on	nonzero primes are maximal, and the zero prime is an intersection of maximals	rschwiebert	semiprimitive and Dedekind domain implies Jacobson	\N
108	1	52	\N	\N	\N	42	on		rschwiebert	perfect implies strongly pi regular	\N
109	1	22	\N	\N	\N	41	on	obvious	rschwiebert	valuation implies serial	\N
110	1	43	\N	\N	\N	45	on	obvious	rschwiebert	semiprimary implies semiregular	\N
111	1	60	\N	\N	\N	20	on	CITATION NEEDED	rschwiebert	local complete intersection ring implies Gorenstein	\N
112	1	16	\N	\N	\N	60	on	CITATION NEEDED	rschwiebert	regular local implies local complete intersection ring	\N
113	1	7	\N	\N	\N	61	on	CITATION NEEDED	rschwiebert	Dedekind domain implies Krull domain	\N
114	1	61	\N	\N	\N	40	on	CITATION NEEDED	rschwiebert	Krull domain implies normal domain	\N
115	1	61	\N	\N	\N	24	on	CITATION NEEDED	rschwiebert	Krull domain implies Mori domain	\N
116	1	24	\N	\N	\N	5	on	CITATION NEEDED	rschwiebert	Mori domain implies domain	\N
\.


--
-- Name: comm_logic_logic_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('"comm_logic_logic_ID_seq"', 117, false);


--
-- Name: comm_properties_property_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('"comm_properties_property_ID_seq"', 62, false);


--
-- Data for Name: metaproperty; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY metaproperty (type_id, description) FROM stdin;
1	Morita invariant
2	passes to matrix rings
3	passes to subrings
4	passes to quotient rings
5	stable under finite products
6	stable under products
7	Passes to eRe for any idempotent e
8	Passes to eRe for any full idempotent e
9	passes to localizations
\.


--
-- Data for Name: rings; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY rings ("ring_ID", name, description, kwds, old_reference, notes, poster) FROM stdin;
1	Integers	{...-3, -2, -1, 0, 1, 2, 3,...}	equivalence relation		\N	rschwiebert
2	Rational numbers	Field of fractions of the integers [1]	fraction field		smallest ordered field	rschwiebert
3	Real numbers	Let X be the set of all Cauchy sequences from the rationals [2]. Two sequences are equivalent if they converge to the same point. The real numbers are the equivalence classes.	equivalence relation,		largest Archimedian field	rschwiebert
4	Complex numbers	With real numbers [3], R[x]/(x^2+1) OR the set of real matrices of form [[a,b],[-b,a]] with determinant >0. OR the real Clifford algebra for signature (-)	algebraic closure, quotient, Cayley-Dickson		\N	rschwiebert
5	Quaternions	Set of complex matrices [[a,b],[-b*,a*]] with positive real determinant, real clifford algebra for real space of signature (-,-)	Cayley-Dickson,		\N	rschwiebert
6	Integer polynomial ring: Z[x]	The polynomial ring Z[x] over the integers (1)	polynomial,		All prime ideals are 1-or-2 generated, but (3,x,y) is not. 	rschwiebert
7	Polynomial ring over a field: F[x]	The polynomial ring F[x] over a field F	polynomial,		\N	rschwiebert
8	Z/(n), n prime	The ring quotient of the integers (1) by an ideal (n) where n is a prime number.	quotient,		\N	rschwiebert
9	Z/(n), n squarefree	Quotient ring of the integers (1) by an ideal (n) where n is a squarefree number.	quotient,		\N	rschwiebert
10	Z/(n), n a prime power	Quotient ring of the integers (1) by an ideal (n) where n=p^k for some prime number p, natural number k.	quotient,		\N	rschwiebert
11	M_n(F_q)	The ring of n x n matrices with entries from a finite field F, n a natural number.	matrix,		\N	rschwiebert
12	Matrix ring over a field: M_n(F)	The ring of n x n matrices with entries from a field F, n a natural number greater than 1	matrix,		\N	rschwiebert
13	T_n(F_q)	The ring of n x n matrices over a finite field F whose entries below the diagonal are all zero.	matrix,		\N	rschwiebert
14	Upper triangular matrix ring over a field: T_n(F)	The ring of n x n matrices over a field F whose entries below the diagonal are zero.	matrix,		\N	rschwiebert
15	Full linear ring of a countable dimensional right vector space	Let V be a countable dimensional right vector space over a division ring D. R=End(V_D).	endomorphism,		\N	rschwiebert
16	T_2(F_2)	2 x 2 ring of upper triangular matrices over the field of two elements.	matrix,		Lattice of right ideals isomorphic to the M_3 diamond lattice	rschwiebert
17	Field of constructible numbers	Quadratic closure of the rational numbers [2] inside the real numbers [3]. Characterized by ruler-and-compass construction			\N	rschwiebert
18	Field of algebraic numbers	The algebraic closure of the rationals			\N	rschwiebert
19	Right-not-left Noetherian triangular ring	Triangular ring [[Z,Q],[0,Q]] where Z is a commutative Noetherian domain not equal to its field of fractions Q. 	triangular ring	Lam FCNR p 20	\N	rschwiebert
20	Right-not-left Artinian triangular ring	Triangular ring [[Q,R],[0,R]] where R:Q is an infinite degree field extension.	triangular ring	Lam LMR p 20-21	\N	rschwiebert
21	Left-not-right Noetherian domain	Skew polynomials k[x;s] for a division ring k with endomorphism s which isn't an automorphism. The skew is given by xa=xs(a).	skew polynomial ring	Lam FCNR 21	\N	rschwiebert
22	Dieudonne's left-not-right Noetherian ring	Z<x,y>/(y^2,yx) where Z is the integers.	quotient, free algebra	Lam FCNR 21	\N	rschwiebert
23	F_2[x,y]/(x,y)^2	The quotient ring F_2[x,y]/(x,y)^2 for the field F_2 of two elements.	polynomial, quotient	 	Lattice of proper ideals is the diamond lattice. All ideals principal except for maximal ideal. Zero Krull dimension	rschwiebert
24	Reversible non-symmetric ring	For field k, k<x,y,z>/I where I=(FxF)^2+(FyF)^2+(FzF)^2 + FxyzF + FyzxF + FzxyF	free algebra, quotient	Marks, G. Reversible and symmetric rings (2001)	\N	rschwiebert
25	F_2[Q_8]	Group ring of the quaternion group Q_8 with the field of two elements F_2.	group ring	Marks, G. Reversible and Symmetric rings (2001)	\N	rschwiebert
26	Non-symmetric 2-primal ring	Consider the semigroup S={a,b} with a^2=ab=a,b^2=ba=b. Make the semigroup ring T=F_2[S]. Make the Dorroh extension T'=Z(+)T. T' is the ring.	semigroup ring, Dorroh extension	Marks, G. Reversible and Symmetric rings (2001)	\N	rschwiebert
27	k[[x]]	Ring of formal power series over a field k	power series,		\N	rschwiebert
28	Non-Artinian simple ring	Let k be any simple ring of characteristic 0, and let d be a non-inner derivation on k. the differential polynomial ring R=k[x;d].	differential polynomial,	Lam, T.Y. FCINR 42	\N	rschwiebert
29	Osofsky's 32 element ring	Let A=Z/(4) and B=(2)/(4) be that ideal in $A$. R is the triangular ring [[A,B],[0,A]]	triangular ring,	Lam, T.Y. Lectures on Modules and Rings p 79	\N	rschwiebert
30	Right-not-left nonsingular ring	Triangular ring [[Z,Z/(2)],[0,Z/(2)]]	triangular ring	Lam, T.Y. Lectures on modules and rings pg 248	\N	rschwiebert
31	Bergman's primitive finite uniform dimension ring			Chatters & Hajarnavis Rings With Chain Conditions p 27-30	\N	rschwiebert
32	Z[x]/(x^2-1)	The quotient Z[x]/(x^2-1) over the integers Z.	quotient,		\N	rschwiebert
33	Algebraic integers	The integral closure of the integers in the complex numbers.	integral closure,		\N	rschwiebert
34	Z[(1+sqrt(-19))/2]	subring of C generated by Z and (1+sqrt(-19))/2	subring,		Not a Euclidean domain	rschwiebert
35	Dedekind finite, not stably finite ring	Let k be a field and X={s,t,u,v,w,x,y,z} be indeterminates. Let R be the free algebra over k and X modulo relations which make the matrix equation AB=I_2 hold, where A=[[s,t],[u,v]] and B=[[w,x],[y,z]].	free algebra, quotient,	Lam, T.Y. Lectures on modules and rings p19 ex 18.	\N	rschwiebert
36	Z+xQ[x]	The subring of Q[x] generated by the ideal (x) and the subring Z.	Subring, polynomial		\N	rschwiebert
37	ring of holomorphic functions on C	The ring of all holomorphic functions on the complex numbers	functions,	T.Y. Lam, Exercises in classical ring theory	Not a UFD	rschwiebert
38	left-not-right simple socle ring	Let s:F->F be a field automorphism such that [F:s(F)]>1. F[x,s] is the skew polynomial ring where xa=s(a)x for all a in F. The ring is F[x;s]/(x^2).	Skew polynomial, quotient		Composition length different on both sides	rschwiebert
39	Chase's left-not-right semihereditary ring	Let S be von Neumann regular which has an ideal I which is not a direct summand of S_S.Let R be S/I. Form the triangular ring T=[[R,R],[0,S]]. T is the ring.	triangular ring,	T.Y. Lam, Lectures on modules and rings p 47-48	\N	rschwiebert
40	right-not-left coherent ring	Let s be a field endomorphism from K to K such that the image L has infinite index in K. Define multiplication on R=KxK by (x,y)(x',y')=(xx',s(x)y'+yx'). R is the ring	trivial extension	T.Y. Lam, Lectures on modules and rings p 139	\N	rschwiebert
41	right-not-left Kasch ring	Let k be a division ring, and R be the ring of matrices of the form [[a,0,b,c],[0,a,0,d],[0,0,a,0],[0,0,0,e]]	matrix ring, subring,	T.Y. Lam, Lectures on modules and rings p 281-282	\N	rschwiebert
42	local right-not-left Kasch ring	Let k be a field. Let S be the power series ring over k in two noncommuting variables x,y. The ring is R=S/(y^2,yx)	power series, quotient	T.Y. Lam. Exercises in modules and rings p 211 ex 8.13	\N	rschwiebert
50	R[x,y,z]/(x^2,y^2, xz,yz,z^2-xy)	polynomial ring over the real numbers mod the ideal generated by x^2, y^2, xz,yz,z^2-xy	polynomial, quotient	wikipedia	Krull dimension 0	\N
49	R[x]/(x^2)	The quotient of the real polynomial ring R[x] by the ideal generated by x^2	polynomial, quotient	rschwiebert	Krull dimension 0	\N
48	F_p(x)	ring of rational polynomials over the finite field of p elements	rational polynomials, 	wikipedia	Is a field that isn't perfect	\N
47	F[x^{1/2},x^{1/4},x^{1/8},...]/(x)	For a field F, the quotient polynomial ring F[x^{1/2},x^{1/4},x^{1/8},...]/(x)	polynomial, quotient	 	Local with an idempotent maximal ideal	\N
46	Varadarajan's left-not-right coHopfian ring	The ring is [[F_2,F_2],[0,Z_(2)]] where F_2 is given the natural right Z_(2) module structure by localizing Z at the prime ideal (2)	triangular ring,	Varadarajan Hopfian and co-Hopfian objects (1992)		rschwiebert
45	non-Artinian simple domain	Let s be a field automorphism of infinite order of the field k. Let R be the skew polynomial ring k[x,x^{-1};s]	skew polynomial, automorphism	T.Y. Lam First course in noncommutative rings p 45		rschwiebert
44	Bass's right-not-left perfect ring	Let S be the subset of infinite matrices over a field k which are nonzero only on finitely many entries above the diagonal. R is the subring of the matrix ring generated by S and the "infinite" identity matrix.	subring, infinite matrix, 	T.Y. Lam First course in noncommutative rings p 345-346		rschwiebert
43	Kasch not semilocal ring	Let M be the direct sum of Z/p_iZ where p_i is the i'th prime. The ring R is the trivial extension of M by Z: ZxM with the multiplication operation (n,a)(m,b)=(nm,nb+ma)	trivial extension,	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18		rschwiebert
51	Interval monoid ring	Let the interval I=[0,1] in the real numbers be a monoid under addition, where a+b:=0 if a+b >1. The ring is the monoid ring of I over a field F.	monoid ring	Norton, M. C.  Univeristy of Warwick Doctoral Thesis (1975) example 3.2.2 p 112		rschwiebert
52	Countably infinite boolean ring	The ring is countably infinite product of copies of the field of two elements.	\N			rschwiebert
\.


--
-- Data for Name: comm_property_metaproperty; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY comm_property_metaproperty (id, has_metaproperty, note, "ring_ID", type_id, "property_ID", theorem_id) FROM stdin;
1	t		\N	9	11	\N
2	f		49	4	5	\N
\.


--
-- Data for Name: comm_ring_property; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY comm_ring_property (id, "ring_ID", "property_ID", has_property, reason, source, poster, "time") FROM stdin;
1	1	1	0			ConvertScript	2014-03-28 14:22:32-04
2	1	2	1			ConvertScript	2014-03-28 14:22:32-04
3	1	27	1	logic_id 168		ConvertScript	2014-03-28 14:22:33-04
4	1	21	0	logic_id=74		ConvertScript	2014-03-28 14:22:33-04
5	1	14	0	logic_id=86		ConvertScript	2014-03-28 14:22:33-04
6	1	10	1			ConvertScript	2014-03-28 14:22:33-04
7	1	12	1	logic_id=101		ConvertScript	2014-03-28 14:22:33-04
8	1	11	1	logic_id=103		ConvertScript	2014-03-28 14:22:33-04
9	1	5	1	logic_id=410		ConvertScript	2014-03-28 14:22:33-04
10	1	6	1	logic_id=464		ConvertScript	2014-03-28 14:22:33-04
11	1	15	0	logic_id=38		ConvertScript	2014-03-28 14:22:33-04
12	1	3	0	logic_id=18		ConvertScript	2014-03-28 14:22:33-04
13	1	30	1	Intersection of all maximal ideals is zero.		ConvertScript	2014-03-28 14:22:34-04
14	1	28	0	logic_id=258		ConvertScript	2014-03-28 14:22:34-04
15	1	4	0	logic_id=330		ConvertScript	2014-03-28 14:22:34-04
16	1	22	0	logic_id=45		ConvertScript	2014-03-28 14:22:34-04
17	2	1	1			ConvertScript	2014-03-29 15:36:54-04
18	2	2	1			ConvertScript	2014-03-29 15:36:55-04
19	2	27	1	logic_id 168		ConvertScript	2014-03-29 15:36:55-04
20	2	28	1	logic_id 111		ConvertScript	2014-03-29 15:36:55-04
21	2	3	1			ConvertScript	2014-03-29 15:36:55-04
22	2	15	1	logic_id=19		ConvertScript	2014-03-29 15:36:55-04
23	2	22	1	logic_id=21		ConvertScript	2014-03-29 15:36:56-04
24	2	10	1	logic_id=22		ConvertScript	2014-03-29 15:36:56-04
25	2	6	1	logic_id=26		ConvertScript	2014-03-29 15:36:56-04
26	2	11	1	logic_id=35		ConvertScript	2014-03-29 15:36:56-04
27	2	21	1	logic_id=40		ConvertScript	2014-03-29 15:36:56-04
28	2	4	1	logic_id=45		ConvertScript	2014-03-29 15:36:56-04
29	2	14	1	logic_id=56		ConvertScript	2014-03-29 15:36:56-04
30	2	30	1	logic_id=72		ConvertScript	2014-03-29 15:36:56-04
31	2	12	1	logic_id=101		ConvertScript	2014-03-29 15:36:56-04
32	2	5	1	logic_id=408		ConvertScript	2014-03-29 15:36:56-04
33	3	1	1			ConvertScript	2014-03-29 15:36:56-04
34	3	2	1			ConvertScript	2014-03-29 15:36:56-04
35	3	27	1	logic_id 168		ConvertScript	2014-03-29 15:36:56-04
36	3	28	1	logic_id 111		ConvertScript	2014-03-29 15:36:56-04
37	3	3	1			ConvertScript	2014-03-29 15:36:57-04
38	3	15	1	logic_id=19		ConvertScript	2014-03-29 15:36:57-04
39	3	22	1	logic_id=21		ConvertScript	2014-03-29 15:36:57-04
40	3	10	1	logic_id=22		ConvertScript	2014-03-29 15:36:57-04
41	3	6	1	logic_id=26		ConvertScript	2014-03-29 15:36:57-04
42	3	11	1	logic_id=35		ConvertScript	2014-03-29 15:36:57-04
43	3	21	1	logic_id=40		ConvertScript	2014-03-29 15:36:57-04
44	3	4	1	logic_id=45		ConvertScript	2014-03-29 15:36:57-04
45	3	14	1	logic_id=56		ConvertScript	2014-03-29 15:36:57-04
46	3	30	1	logic_id=72		ConvertScript	2014-03-29 15:36:57-04
47	3	12	1	logic_id=101		ConvertScript	2014-03-29 15:36:57-04
48	3	5	1	logic_id=408		ConvertScript	2014-03-29 15:36:57-04
49	4	1	1			ConvertScript	2014-03-29 15:36:57-04
50	4	2	1			ConvertScript	2014-03-29 15:36:57-04
51	4	27	1	logic_id 168		ConvertScript	2014-03-29 15:36:57-04
52	4	28	1	logic_id 111		ConvertScript	2014-03-29 15:36:57-04
53	4	3	1			ConvertScript	2014-03-29 15:36:57-04
54	4	15	1	logic_id=19		ConvertScript	2014-03-29 15:36:57-04
55	4	22	1	logic_id=21		ConvertScript	2014-03-29 15:36:57-04
56	4	10	1	logic_id=22		ConvertScript	2014-03-29 15:36:57-04
57	4	6	1	logic_id=26		ConvertScript	2014-03-29 15:36:57-04
58	4	11	1	logic_id=35		ConvertScript	2014-03-29 15:36:57-04
59	4	21	1	logic_id=40		ConvertScript	2014-03-29 15:36:57-04
60	4	4	1	logic_id=45		ConvertScript	2014-03-29 15:36:57-04
61	4	14	1	logic_id=56		ConvertScript	2014-03-29 15:36:57-04
62	4	30	1	logic_id=72		ConvertScript	2014-03-29 15:36:57-04
63	4	12	1	logic_id=101		ConvertScript	2014-03-29 15:36:58-04
64	4	5	1	logic_id=408		ConvertScript	2014-03-29 15:36:58-04
65	6	10	0			ConvertScript	2014-03-29 15:36:58-04
66	6	5	1			ConvertScript	2014-03-29 15:36:58-04
67	6	1	0	symmetry		ConvertScript	2014-03-29 15:36:58-04
68	6	2	1	symmetry		ConvertScript	2014-03-29 15:36:58-04
69	6	27	1	logic_id 168		ConvertScript	2014-03-29 15:36:58-04
70	6	6	1	logic_id 241		ConvertScript	2014-03-29 15:36:58-04
71	6	3	0	logic_id=22		ConvertScript	2014-03-29 15:36:58-04
72	6	14	0	logic_id=362		ConvertScript	2014-03-29 15:36:58-04
73	6	12	0	logic_id=427		ConvertScript	2014-03-29 15:36:58-04
74	6	21	0	logic_id=74		ConvertScript	2014-03-29 15:36:58-04
75	6	15	0	logic_id=37		ConvertScript	2014-03-29 15:36:58-04
76	6	30	1			ConvertScript	2014-03-29 15:36:58-04
77	6	28	0	There are infinitely many maximal ideals.		ConvertScript	2014-03-29 15:36:58-04
78	6	4	0	logic_id=330		ConvertScript	2014-03-29 15:36:58-04
79	6	22	0	logic_id=45		ConvertScript	2014-03-29 15:36:58-04
80	6	11	0	logic_id=507		ConvertScript	2014-03-29 15:36:58-04
81	7	10	1			ConvertScript	2014-03-29 15:36:58-04
82	7	5	1			ConvertScript	2014-03-29 15:36:59-04
83	7	12	1	logic_id 101		ConvertScript	2014-03-29 15:36:59-04
84	7	11	1	logic_id 103		ConvertScript	2014-03-29 15:36:59-04
85	7	2	1	logic_id 69		ConvertScript	2014-03-29 15:36:59-04
86	7	27	1	logic_id 168		ConvertScript	2014-03-29 15:36:59-04
87	7	6	1	logic_id 239		ConvertScript	2014-03-29 15:36:59-04
88	7	1	0	logic_id=315		ConvertScript	2014-03-29 15:36:59-04
89	7	3	0	logic_id=17		ConvertScript	2014-03-29 15:36:59-04
90	7	21	0	logic_id=74		ConvertScript	2014-03-29 15:36:59-04
91	7	14	0	logic_id=86		ConvertScript	2014-03-29 15:36:59-04
92	7	15	0	logic_id=38		ConvertScript	2014-03-29 15:36:59-04
93	8	3	1			ConvertScript	2014-03-29 15:36:59-04
94	8	15	1	logic_id 19		ConvertScript	2014-03-29 15:36:59-04
95	8	22	1	logic_id 21		ConvertScript	2014-03-29 15:36:59-04
96	8	10	1	logic_id 22		ConvertScript	2014-03-29 15:36:59-04
97	8	6	1	logic_id 26		ConvertScript	2014-03-29 15:36:59-04
98	8	11	1	logic_id 35		ConvertScript	2014-03-29 15:36:59-04
99	8	21	1	logic_id 40		ConvertScript	2014-03-29 15:36:59-04
100	8	4	1	logic_id 45		ConvertScript	2014-03-29 15:36:59-04
101	8	14	1	logic_id 56		ConvertScript	2014-03-29 15:36:59-04
102	8	2	1	logic_id 69		ConvertScript	2014-03-29 15:36:59-04
103	8	30	1	logic_id 72		ConvertScript	2014-03-29 15:36:59-04
104	8	12	1	logic_id 101		ConvertScript	2014-03-29 15:36:59-04
105	8	1	1	logic_id 107		ConvertScript	2014-03-29 15:36:59-04
106	8	28	1	logic_id 111		ConvertScript	2014-03-29 15:36:59-04
107	8	27	1	logic_id 168		ConvertScript	2014-03-29 15:36:59-04
108	8	5	1	logic_id 408		ConvertScript	2014-03-29 15:36:59-04
109	9	15	1			ConvertScript	2014-03-29 15:37:00-04
110	9	11	1	logic_id 35		ConvertScript	2014-03-29 15:37:00-04
111	9	21	1	logic_id 40		ConvertScript	2014-03-29 15:37:00-04
112	9	14	1	logic_id 56		ConvertScript	2014-03-29 15:37:00-04
113	9	2	1	logic_id 69		ConvertScript	2014-03-29 15:37:00-04
114	9	30	1	logic_id 72		ConvertScript	2014-03-29 15:37:00-04
115	9	1	1	logic_id 107		ConvertScript	2014-03-29 15:37:00-04
116	9	28	1	logic_id 111		ConvertScript	2014-03-29 15:37:00-04
117	9	27	1	logic_id 168		ConvertScript	2014-03-29 15:37:00-04
118	9	6	1	logic_id 239		ConvertScript	2014-03-29 15:37:00-04
119	9	5	0	logic_id=423		ConvertScript	2014-03-29 15:37:00-04
120	9	3	0	logic_id=17		ConvertScript	2014-03-29 15:37:00-04
121	9	4	0	logic_id=330		ConvertScript	2014-03-29 15:37:00-04
122	9	22	0	logic_id=45		ConvertScript	2014-03-29 15:37:00-04
123	9	12	0	logic_id=120		ConvertScript	2014-03-29 15:37:00-04
124	9	10	0	logic_id=101		ConvertScript	2014-03-29 15:37:00-04
125	10	6	0			ConvertScript	2014-03-29 15:37:00-04
126	10	22	1			ConvertScript	2014-03-29 15:37:00-04
127	10	21	1			ConvertScript	2014-03-29 15:37:00-04
128	10	4	1			ConvertScript	2014-03-29 15:37:00-04
129	10	1	1	logic_id 107		ConvertScript	2014-03-29 15:37:00-04
130	10	28	1	logic_id 111		ConvertScript	2014-03-29 15:37:00-04
131	10	2	1	logic_id 11		ConvertScript	2014-03-29 15:37:00-04
132	10	27	1	logic_id 168		ConvertScript	2014-03-29 15:37:00-04
133	10	11	1	logic_id 275		ConvertScript	2014-03-29 15:37:00-04
134	10	14	0	logic_id=233		ConvertScript	2014-03-29 15:37:00-04
135	10	30	0	logic_id=289		ConvertScript	2014-03-29 15:37:00-04
136	10	5	0	logic_id=423		ConvertScript	2014-03-29 15:37:00-04
137	10	3	0	logic_id=18		ConvertScript	2014-03-29 15:37:00-04
138	10	15	0	logic_id=34		ConvertScript	2014-03-29 15:37:00-04
139	10	12	0	logic_id=120		ConvertScript	2014-03-29 15:37:00-04
140	10	10	0	logic_id=101		ConvertScript	2014-03-29 15:37:00-04
141	17	3	1			ConvertScript	2014-03-29 15:37:01-04
142	17	15	1	logic_id 19		ConvertScript	2014-03-29 15:37:01-04
143	17	22	1	logic_id 21		ConvertScript	2014-03-29 15:37:01-04
144	17	10	1	logic_id 22		ConvertScript	2014-03-29 15:37:01-04
145	17	6	1	logic_id 26		ConvertScript	2014-03-29 15:37:01-04
146	17	11	1	logic_id 35		ConvertScript	2014-03-29 15:37:01-04
147	17	21	1	logic_id 40		ConvertScript	2014-03-29 15:37:01-04
148	17	4	1	logic_id 45		ConvertScript	2014-03-29 15:37:01-04
149	17	14	1	logic_id 56		ConvertScript	2014-03-29 15:37:01-04
150	17	2	1	logic_id 69		ConvertScript	2014-03-29 15:37:01-04
151	17	30	1	logic_id 72		ConvertScript	2014-03-29 15:37:01-04
152	17	12	1	logic_id 101		ConvertScript	2014-03-29 15:37:01-04
153	17	1	1	logic_id 107		ConvertScript	2014-03-29 15:37:01-04
154	17	28	1	logic_id 111		ConvertScript	2014-03-29 15:37:01-04
155	17	27	1	logic_id 168		ConvertScript	2014-03-29 15:37:01-04
156	17	5	1	logic_id 408		ConvertScript	2014-03-29 15:37:01-04
157	18	3	1			ConvertScript	2014-03-29 15:37:01-04
158	18	15	1	logic_id 19		ConvertScript	2014-03-29 15:37:01-04
159	18	22	1	logic_id 21		ConvertScript	2014-03-29 15:37:01-04
160	18	10	1	logic_id 22		ConvertScript	2014-03-29 15:37:01-04
161	18	6	1	logic_id 26		ConvertScript	2014-03-29 15:37:01-04
162	18	11	1	logic_id 35		ConvertScript	2014-03-29 15:37:01-04
163	18	21	1	logic_id 40		ConvertScript	2014-03-29 15:37:01-04
164	18	4	1	logic_id 45		ConvertScript	2014-03-29 15:37:01-04
165	18	14	1	logic_id 56		ConvertScript	2014-03-29 15:37:01-04
166	18	2	1	logic_id 69		ConvertScript	2014-03-29 15:37:01-04
167	18	30	1	logic_id 72		ConvertScript	2014-03-29 15:37:01-04
168	18	12	1	logic_id 101		ConvertScript	2014-03-29 15:37:01-04
169	18	1	1	logic_id 107		ConvertScript	2014-03-29 15:37:01-04
170	18	28	1	logic_id 111		ConvertScript	2014-03-29 15:37:01-04
171	18	27	1	logic_id 168		ConvertScript	2014-03-29 15:37:01-04
172	18	5	1	logic_id 408		ConvertScript	2014-03-29 15:37:02-04
173	27	10	1		Ideals are of the form (x^i)	ConvertScript	2014-03-29 15:37:02-04
174	27	4	1		unique maximal ideal (x)	ConvertScript	2014-03-29 15:37:02-04
175	27	12	1	logic_id 101		ConvertScript	2014-03-29 15:37:02-04
176	27	11	1	logic_id 103		ConvertScript	2014-03-29 15:37:02-04
177	27	28	1	logic_id 111		ConvertScript	2014-03-29 15:37:02-04
178	27	5	1	logic_id 408		ConvertScript	2014-03-29 15:37:02-04
179	27	2	1	logic_id 69		ConvertScript	2014-03-29 15:37:02-04
180	27	27	1	logic_id 168		ConvertScript	2014-03-29 15:37:02-04
181	27	6	1	logic_id 239		ConvertScript	2014-03-29 15:37:02-04
182	27	30	0	logic_id=221		ConvertScript	2014-03-29 15:37:02-04
183	27	14	0	logic_id=448		ConvertScript	2014-03-29 15:37:02-04
184	27	1	0	logic_id=12		ConvertScript	2014-03-29 15:37:02-04
185	27	3	0	logic_id=17		ConvertScript	2014-03-29 15:37:02-04
186	27	15	0	logic_id=37		ConvertScript	2014-03-29 15:37:02-04
187	27	21	0	logic_id=74		ConvertScript	2014-03-29 15:37:02-04
188	27	22	1	symmetry		ConvertScript	2014-03-29 15:37:02-04
189	33	2	0		The sequence of ideals (2^(1/2^n)) does not stabilize	ConvertScript	2014-03-29 15:37:02-04
190	33	12	1		Wikipedia	ConvertScript	2014-03-29 15:37:02-04
191	33	5	1	logic_id 408		ConvertScript	2014-03-29 15:37:02-04
192	33	6	1	logic_id 239		ConvertScript	2014-03-29 15:37:02-04
193	33	1	0	logic_id=11		ConvertScript	2014-03-29 15:37:02-04
194	33	11	0	logic_id=69		ConvertScript	2014-03-29 15:37:02-04
195	33	10	0	logic_id=103		ConvertScript	2014-03-29 15:37:02-04
196	33	3	0	logic_id=22		ConvertScript	2014-03-29 15:37:02-04
197	33	15	0	logic_id=32		ConvertScript	2014-03-29 15:37:02-04
198	33	21	0	logic_id=74		ConvertScript	2014-03-29 15:37:02-04
199	33	14	0	logic_id=362		ConvertScript	2014-03-29 15:37:03-04
200	33	28	0		T.Y. Lam Exercises in classical ring theory p 286	ConvertScript	2014-03-29 15:37:03-04
201	33	27	0	logic_id=515		ConvertScript	2014-03-29 15:37:03-04
202	33	4	0	logic_id=443		ConvertScript	2014-03-29 15:37:03-04
203	33	22	0	logic_id=45		ConvertScript	2014-03-29 15:37:03-04
204	34	10	1		Has a Dedekind-Hasse norm that allows you to prove this	ConvertScript	2014-03-29 15:37:03-04
205	34	12	1	logic_id 101		ConvertScript	2014-03-29 15:37:03-04
206	34	11	1	logic_id 103		ConvertScript	2014-03-29 15:37:03-04
207	34	5	1	logic_id 408		ConvertScript	2014-03-29 15:37:03-04
208	34	2	1	logic_id 69		ConvertScript	2014-03-29 15:37:03-04
209	34	27	1	logic_id 168		ConvertScript	2014-03-29 15:37:03-04
210	34	6	1	logic_id 239		ConvertScript	2014-03-29 15:37:03-04
211	34	3	0	obvious	rschwiebert	ConvertScript	2014-03-29 15:37:03-04
212	34	14	0	logic_id=362		ConvertScript	2014-03-29 15:37:03-04
213	34	1	0	logic_id=315		ConvertScript	2014-03-29 15:37:03-04
214	34	15	0	logic_id=37		ConvertScript	2014-03-29 15:37:03-04
215	34	21	0	logic_id=74		ConvertScript	2014-03-29 15:37:03-04
216	36	2	0		This ring does not even satisfy ACC on principal ideals	ConvertScript	2014-03-29 15:37:03-04
217	36	10	0		This ring isn't Noetherian	ConvertScript	2014-03-29 15:37:03-04
218	36	27	0		(x)<(x/2)<(x/4)<...<(x/2^n)<... is a strictly ascending chain.	ConvertScript	2014-03-29 15:37:03-04
219	36	5	1	logic_id 408		ConvertScript	2014-03-29 15:37:03-04
220	36	6	1	logic_id 241		ConvertScript	2014-03-29 15:37:03-04
221	36	1	0	logic_id=11		ConvertScript	2014-03-29 15:37:03-04
222	36	3	0	logic_id=22		ConvertScript	2014-03-29 15:37:03-04
223	36	11	0	logic_id=69		ConvertScript	2014-03-29 15:37:03-04
224	36	14	0	logic_id=362		ConvertScript	2014-03-29 15:37:03-04
225	36	15	0	logic_id=32		ConvertScript	2014-03-29 15:37:03-04
226	36	21	0	logic_id=74		ConvertScript	2014-03-29 15:37:03-04
227	23	4	1	The unique maximal ideal is (x,y), which is nilpotent	obvious	ConvertScript	2014-03-29 15:37:04-04
228	23	11	0	symmetry		ConvertScript	2014-03-29 15:37:04-04
229	23	28	1	logic_id=111		ConvertScript	2014-03-29 15:37:04-04
230	23	22	0	logic_id=434		ConvertScript	2014-03-29 15:37:04-04
231	23	10	0	logic_id=103		ConvertScript	2014-03-29 15:37:04-04
232	23	15	0	logic_id=36		ConvertScript	2014-03-29 15:37:04-04
233	23	3	0	logic_id=23		ConvertScript	2014-03-29 15:37:04-04
234	23	1	1	logic_id=499		ConvertScript	2014-03-29 15:37:04-04
235	23	2	1	logic_id=11		ConvertScript	2014-03-29 15:37:04-04
236	23	27	1	logic_id=168		ConvertScript	2014-03-29 15:37:04-04
237	23	14	0	logic_id=255		ConvertScript	2014-03-29 15:37:04-04
238	23	5	0	logic_id=468		ConvertScript	2014-03-29 15:37:04-04
239	23	30	0	logic_id=332		ConvertScript	2014-03-29 15:37:04-04
240	23	12	0	logic_id=427		ConvertScript	2014-03-29 15:37:04-04
241	23	6	0	logic_id=53		ConvertScript	2014-03-29 15:37:04-04
242	32	5	0	(1+x)(1-x)=0	obvious	ConvertScript	2014-03-29 15:37:04-04
243	32	4	0	1-x and 1+x are contained in different maximal ideals	obvious	ConvertScript	2014-03-29 15:37:04-04
244	32	6	1	(x^1-1) is the intersection of two prime ideals, (or alternatively an easy computation)	obvious	ConvertScript	2014-03-29 15:37:04-04
245	32	2	1	symmetry		ConvertScript	2014-03-29 15:37:04-04
246	32	27	1	logic_id=168		ConvertScript	2014-03-29 15:37:04-04
247	32	12	0	logic_id=120		ConvertScript	2014-03-29 15:37:04-04
248	32	10	0	logic_id=101		ConvertScript	2014-03-29 15:37:04-04
249	32	22	0	logic_id=45		ConvertScript	2014-03-29 15:37:04-04
250	32	3	0	logic_id=23		ConvertScript	2014-03-29 15:37:04-04
251	32	14	0	logic_id=362		ConvertScript	2014-03-29 15:37:04-04
252	32	21	0	logic_id=74		ConvertScript	2014-03-29 15:37:04-04
253	32	15	0	logic_id=42		ConvertScript	2014-03-29 15:37:04-04
254	32	1	0	logic_id=317		ConvertScript	2014-03-29 15:37:04-04
255	37	28	0		T.Y. Lam Exercises in classical ring theory p 286	ConvertScript	2014-03-29 15:37:04-04
256	37	12	1	symmetry		ConvertScript	2014-03-29 15:37:04-04
257	37	5	1	logic_id=408		ConvertScript	2014-03-29 15:37:04-04
258	37	6	1	logic_id=464		ConvertScript	2014-03-29 15:37:04-04
259	37	4	0	logic_id=77		ConvertScript	2014-03-29 15:37:04-04
260	37	1	0	logic_id=484		ConvertScript	2014-03-29 15:37:04-04
261	37	15	0	logic_id=41		ConvertScript	2014-03-29 15:37:04-04
262	37	22	0	logic_id=44		ConvertScript	2014-03-29 15:37:04-04
263	37	21	0	logic_id=74		ConvertScript	2014-03-29 15:37:04-04
264	37	14	0	logic_id=89		ConvertScript	2014-03-29 15:37:05-04
265	37	3	0	logic_id=17		ConvertScript	2014-03-29 15:37:05-04
266	37	11	0	Not a UFD implies not a PID		ConvertScript	2014-03-29 15:37:05-04
267	37	10	0	logic_id=103		ConvertScript	2014-03-29 15:37:05-04
268	37	2	0	logic_id=275		ConvertScript	2014-03-29 15:37:05-04
269	37	27	0	logic_id=515		ConvertScript	2014-03-29 15:37:05-04
270	2	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:14-04
271	3	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:14-04
272	4	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:14-04
273	8	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:15-04
274	9	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:15-04
275	10	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:15-04
276	17	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:15-04
277	18	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:15-04
278	23	18	1	logic_id=4		FwdLogicScript	2014-04-29 03:48:15-04
279	2	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
280	3	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
281	4	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
282	8	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
283	9	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
284	10	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
285	17	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
286	18	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
287	23	43	1	logic_id=6		FwdLogicScript	2014-04-29 03:48:15-04
288	1	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
289	2	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
290	3	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
291	4	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
292	7	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
293	8	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
294	17	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
295	18	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
296	27	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
297	33	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
298	34	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
299	37	8	1	logic_id=8		FwdLogicScript	2014-04-29 03:48:16-04
300	1	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:16-04
301	2	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:16-04
302	3	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
303	4	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
304	7	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
305	8	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
306	17	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
307	18	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
308	27	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
309	33	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
310	34	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
311	37	25	1	logic_id=9		FwdLogicScript	2014-04-29 03:48:17-04
312	1	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
313	2	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
314	3	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
315	4	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
316	7	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
317	8	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
318	17	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:17-04
319	18	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:18-04
320	27	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:18-04
321	33	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:18-04
322	34	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:18-04
323	37	44	1	logic_id=10		FwdLogicScript	2014-04-29 03:48:18-04
324	2	9	1	logic_id=23		FwdLogicScript	2014-04-29 03:48:19-04
325	3	9	1	logic_id=23		FwdLogicScript	2014-04-29 03:48:19-04
326	4	9	1	logic_id=23		FwdLogicScript	2014-04-29 03:48:19-04
327	8	9	1	logic_id=23		FwdLogicScript	2014-04-29 03:48:19-04
328	17	9	1	logic_id=23		FwdLogicScript	2014-04-29 03:48:19-04
329	18	9	1	logic_id=23		FwdLogicScript	2014-04-29 03:48:19-04
330	2	16	1	logic_id=25		FwdLogicScript	2014-04-29 03:48:20-04
331	3	16	1	logic_id=25		FwdLogicScript	2014-04-29 03:48:20-04
332	4	16	1	logic_id=25		FwdLogicScript	2014-04-29 03:48:20-04
333	8	16	1	logic_id=25		FwdLogicScript	2014-04-29 03:48:20-04
334	17	16	1	logic_id=25		FwdLogicScript	2014-04-29 03:48:20-04
335	18	16	1	logic_id=25		FwdLogicScript	2014-04-29 03:48:20-04
336	2	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
337	3	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
338	4	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
339	8	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
340	9	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
341	10	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
342	17	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
343	18	20	1	logic_id=26		FwdLogicScript	2014-04-29 03:48:20-04
344	2	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
345	3	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
346	4	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
347	8	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
348	9	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
349	10	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
350	17	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
351	18	49	1	logic_id=28		FwdLogicScript	2014-04-29 03:48:21-04
352	1	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
353	2	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
354	3	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
355	4	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
356	7	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
357	8	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
358	17	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
359	18	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
360	27	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
361	33	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
362	34	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
363	37	39	1	logic_id=29		FwdLogicScript	2014-04-29 03:48:21-04
364	1	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
365	2	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
366	3	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
367	4	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
368	6	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
369	7	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
370	8	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
371	9	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
372	10	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
373	17	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
374	18	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
375	23	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
376	27	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
377	32	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
378	34	50	1	logic_id=31		FwdLogicScript	2014-04-29 03:48:22-04
379	1	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
380	2	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
381	3	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
382	4	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
383	7	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
384	8	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
385	17	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
386	18	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
387	27	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
388	34	13	1	logic_id=38		FwdLogicScript	2014-04-29 03:48:23-04
389	1	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
390	2	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
391	3	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
392	4	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
393	7	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
394	8	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
395	17	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:23-04
396	18	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:24-04
397	27	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:24-04
398	34	7	1	logic_id=39		FwdLogicScript	2014-04-29 03:48:24-04
399	2	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
400	3	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
401	4	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
402	8	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
403	9	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
404	10	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
405	17	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
406	18	51	1	logic_id=44		FwdLogicScript	2014-04-29 03:48:25-04
407	2	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
408	3	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
409	4	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
410	8	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
411	9	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
412	10	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
413	17	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
414	18	48	1	logic_id=45		FwdLogicScript	2014-04-29 03:48:25-04
415	2	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:25-04
416	3	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
417	4	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
418	8	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
419	9	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
420	10	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
421	17	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
422	18	53	1	logic_id=46		FwdLogicScript	2014-04-29 03:48:26-04
423	2	17	1	logic_id=50		FwdLogicScript	2014-04-29 03:48:26-04
424	3	17	1	logic_id=50		FwdLogicScript	2014-04-29 03:48:26-04
425	4	17	1	logic_id=50		FwdLogicScript	2014-04-29 03:48:26-04
426	8	17	1	logic_id=50		FwdLogicScript	2014-04-29 03:48:26-04
427	17	17	1	logic_id=50		FwdLogicScript	2014-04-29 03:48:26-04
428	18	17	1	logic_id=50		FwdLogicScript	2014-04-29 03:48:26-04
429	1	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
430	2	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
431	3	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
432	4	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
433	7	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
434	8	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
435	17	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
436	18	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:26-04
437	27	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:27-04
438	33	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:27-04
439	34	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:27-04
440	37	40	1	logic_id=51		FwdLogicScript	2014-04-29 03:48:27-04
441	2	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
442	3	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
443	4	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
444	8	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
445	9	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
446	10	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
447	17	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
448	18	54	1	logic_id=52		FwdLogicScript	2014-04-29 03:48:27-04
449	2	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
450	3	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
451	4	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
452	8	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
453	9	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
454	10	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
455	17	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
456	18	47	1	logic_id=53		FwdLogicScript	2014-04-29 03:48:27-04
457	2	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
458	3	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
459	4	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
460	8	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
461	9	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
462	10	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
463	17	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:27-04
464	18	55	1	logic_id=54		FwdLogicScript	2014-04-29 03:48:28-04
465	23	54	1	logic_id=55		FwdLogicScript	2014-04-29 03:48:28-04
466	27	54	1	logic_id=55		FwdLogicScript	2014-04-29 03:48:28-04
467	2	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
468	3	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
469	4	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
470	8	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
471	9	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
472	10	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
473	17	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
474	18	45	1	logic_id=56		FwdLogicScript	2014-04-29 03:48:28-04
475	2	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:28-04
476	3	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:28-04
477	4	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:28-04
478	8	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:28-04
479	9	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:29-04
480	10	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:29-04
481	17	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:29-04
482	18	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:29-04
483	23	52	1	logic_id=58		FwdLogicScript	2014-04-29 03:48:29-04
484	2	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
485	3	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
486	4	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
487	8	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
488	9	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
489	10	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
490	17	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
491	18	56	1	logic_id=60		FwdLogicScript	2014-04-29 03:48:29-04
492	2	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
493	3	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
494	4	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
495	8	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
496	9	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
497	17	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
498	18	41	1	logic_id=63		FwdLogicScript	2014-04-29 03:48:30-04
499	10	44	1	logic_id=71		FwdLogicScript	2014-04-29 03:48:31-04
500	9	44	1	logic_id=72		FwdLogicScript	2014-04-29 03:48:32-04
501	2	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
502	3	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
503	4	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
504	8	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
505	9	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
506	17	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
507	18	42	1	logic_id=75		FwdLogicScript	2014-04-29 03:48:32-04
508	1	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
509	2	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
510	3	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
511	4	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
512	7	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
513	8	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
514	17	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
515	18	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
516	27	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
517	33	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
518	34	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
519	37	19	1	logic_id=77		FwdLogicScript	2014-04-29 03:48:33-04
520	1	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
521	2	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
522	3	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
523	4	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
524	6	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
525	7	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
526	8	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
527	17	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
528	18	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
529	27	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
530	34	26	1	logic_id=1		FwdLogicScript	2014-04-29 03:48:34-04
531	23	51	1	logic_id=35		FwdLogicScript	2014-04-29 04:42:32-04
532	23	45	1	logic_id=56		FwdLogicScript	2014-04-29 04:42:37-04
533	23	56	1	logic_id=60		FwdLogicScript	2014-04-29 04:42:38-04
534	10	19	0	logic_id=78		BkwdLogicScript	2014-04-29 04:44:44-04
535	23	19	0	logic_id=78		BkwdLogicScript	2014-04-29 04:44:44-04
536	10	40	0	logic_id=77		BkwdLogicScript	2014-04-29 04:44:44-04
537	23	40	0	logic_id=77		BkwdLogicScript	2014-04-29 04:44:44-04
538	33	13	0	logic_id=69		BkwdLogicScript	2014-04-29 04:44:48-04
539	36	13	0	logic_id=69		BkwdLogicScript	2014-04-29 04:44:48-04
540	37	13	0	logic_id=69		BkwdLogicScript	2014-04-29 04:44:48-04
541	1	51	0	logic_id=57		BkwdLogicScript	2014-04-29 04:44:52-04
542	6	51	0	logic_id=57		BkwdLogicScript	2014-04-29 04:44:52-04
543	33	51	0	logic_id=57		BkwdLogicScript	2014-04-29 04:44:53-04
544	37	51	0	logic_id=57		BkwdLogicScript	2014-04-29 04:44:53-04
545	10	39	0	logic_id=51		BkwdLogicScript	2014-04-29 04:44:54-04
546	23	39	0	logic_id=51		BkwdLogicScript	2014-04-29 04:44:54-04
547	33	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:44:56-04
548	36	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:44:56-04
549	37	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:44:56-04
550	1	49	0	logic_id=44		BkwdLogicScript	2014-04-29 04:44:57-04
551	6	49	0	logic_id=44		BkwdLogicScript	2014-04-29 04:44:57-04
552	33	49	0	logic_id=44		BkwdLogicScript	2014-04-29 04:44:58-04
553	37	49	0	logic_id=44		BkwdLogicScript	2014-04-29 04:44:58-04
554	9	8	0	logic_id=43		BkwdLogicScript	2014-04-29 04:44:58-04
555	10	8	0	logic_id=43		BkwdLogicScript	2014-04-29 04:44:58-04
556	23	8	0	logic_id=43		BkwdLogicScript	2014-04-29 04:44:58-04
557	32	8	0	logic_id=43		BkwdLogicScript	2014-04-29 04:44:59-04
558	1	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
559	6	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
560	7	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
561	9	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
562	10	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
563	23	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
564	27	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
565	32	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
566	33	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
567	34	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
568	36	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
569	37	31	0	logic_id=36		BkwdLogicScript	2014-04-29 04:45:01-04
570	1	52	0	logic_id=35		BkwdLogicScript	2014-04-29 04:45:02-04
571	6	52	0	logic_id=35		BkwdLogicScript	2014-04-29 04:45:02-04
572	33	52	0	logic_id=35		BkwdLogicScript	2014-04-29 04:45:02-04
573	37	52	0	logic_id=35		BkwdLogicScript	2014-04-29 04:45:02-04
574	9	40	0	logic_id=33		BkwdLogicScript	2014-04-29 04:45:02-04
575	32	40	0	logic_id=33		BkwdLogicScript	2014-04-29 04:45:03-04
576	10	25	0	logic_id=29		BkwdLogicScript	2014-04-29 04:45:03-04
577	23	25	0	logic_id=29		BkwdLogicScript	2014-04-29 04:45:04-04
578	6	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
579	9	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
580	10	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
581	23	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
582	32	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
583	33	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
584	36	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:07-04
585	37	9	0	logic_id=19		BkwdLogicScript	2014-04-29 04:45:08-04
586	1	48	0	logic_id=17		BkwdLogicScript	2014-04-29 04:45:08-04
587	6	48	0	logic_id=17		BkwdLogicScript	2014-04-29 04:45:08-04
588	33	48	0	logic_id=17		BkwdLogicScript	2014-04-29 04:45:08-04
589	37	48	0	logic_id=17		BkwdLogicScript	2014-04-29 04:45:09-04
590	33	7	0	logic_id=15		BkwdLogicScript	2014-04-29 04:45:09-04
591	36	7	0	logic_id=15		BkwdLogicScript	2014-04-29 04:45:09-04
592	37	7	0	logic_id=15		BkwdLogicScript	2014-04-29 04:45:09-04
593	9	7	0	logic_id=14		BkwdLogicScript	2014-04-29 04:45:10-04
594	10	7	0	logic_id=14		BkwdLogicScript	2014-04-29 04:45:10-04
595	23	7	0	logic_id=14		BkwdLogicScript	2014-04-29 04:45:10-04
596	32	7	0	logic_id=14		BkwdLogicScript	2014-04-29 04:45:10-04
597	1	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
598	6	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
599	7	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
600	9	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
601	10	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
602	23	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
603	27	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
604	32	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
605	33	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
606	34	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
607	36	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
608	37	37	0	logic_id=11		BkwdLogicScript	2014-04-29 04:45:11-04
609	9	26	0	logic_id=7		BkwdLogicScript	2014-04-29 04:45:12-04
610	10	26	0	logic_id=7		BkwdLogicScript	2014-04-29 04:45:12-04
611	23	26	0	logic_id=7		BkwdLogicScript	2014-04-29 04:45:13-04
612	32	26	0	logic_id=7		BkwdLogicScript	2014-04-29 04:45:13-04
613	10	13	0	logic_id=68		BkwdLogicScript	2014-04-29 04:47:13-04
614	23	13	0	logic_id=68		BkwdLogicScript	2014-04-29 04:47:13-04
615	1	41	0	logic_id=65		BkwdLogicScript	2014-04-29 04:47:14-04
616	6	41	0	logic_id=65		BkwdLogicScript	2014-04-29 04:47:14-04
617	33	41	0	logic_id=65		BkwdLogicScript	2014-04-29 04:47:15-04
618	37	41	0	logic_id=65		BkwdLogicScript	2014-04-29 04:47:15-04
619	1	43	0	logic_id=58		BkwdLogicScript	2014-04-29 04:47:17-04
620	6	43	0	logic_id=58		BkwdLogicScript	2014-04-29 04:47:18-04
621	33	43	0	logic_id=58		BkwdLogicScript	2014-04-29 04:47:18-04
622	37	43	0	logic_id=58		BkwdLogicScript	2014-04-29 04:47:18-04
623	9	39	0	logic_id=51		BkwdLogicScript	2014-04-29 04:47:20-04
624	32	39	0	logic_id=51		BkwdLogicScript	2014-04-29 04:47:20-04
625	10	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:47:21-04
626	23	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:47:21-04
627	1	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
628	6	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
629	7	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
630	9	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
631	10	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
632	23	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
633	27	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:26-04
634	32	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:27-04
635	33	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:27-04
636	34	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:27-04
637	36	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:27-04
638	37	35	0	logic_id=34		BkwdLogicScript	2014-04-29 04:47:27-04
639	9	25	0	logic_id=29		BkwdLogicScript	2014-04-29 04:47:28-04
640	32	25	0	logic_id=29		BkwdLogicScript	2014-04-29 04:47:28-04
641	1	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:31-04
642	6	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
643	7	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
644	9	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
645	10	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
646	23	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
647	27	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
648	32	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
649	33	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
650	34	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
651	36	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
652	37	33	0	logic_id=21		BkwdLogicScript	2014-04-29 04:47:32-04
653	9	13	0	logic_id=68		BkwdLogicScript	2014-04-29 04:48:37-04
654	32	13	0	logic_id=68		BkwdLogicScript	2014-04-29 04:48:37-04
655	9	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:48:44-04
656	32	16	0	logic_id=48		BkwdLogicScript	2014-04-29 04:48:44-04
657	34	9	0			rschwiebert	2014-05-05 04:11:04-04
658	9	19	1	logic_id=83		FwdLogicScript	2014-05-05 04:25:49-04
659	33	50	1	logic_id=84		FwdLogicScript	2014-05-05 04:25:49-04
660	37	50	1	logic_id=84		FwdLogicScript	2014-05-05 04:25:49-04
661	1	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
662	2	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
663	3	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
664	4	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
665	7	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
666	8	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
667	17	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
668	18	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
669	27	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
670	33	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
671	34	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
672	37	57	1	logic_id=86		FwdLogicScript	2014-05-05 04:25:50-04
673	10	41	1	logic_id=94		FwdLogicScript	2014-05-05 04:25:57-04
674	9	58	0	logic_id=89		BkwdLogicScript	2014-05-05 04:26:58-04
675	33	26	0	logic_id=88		BkwdLogicScript	2014-05-05 04:26:59-04
676	37	26	0	logic_id=88		BkwdLogicScript	2014-05-05 04:26:59-04
677	1	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:24-04
678	6	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:24-04
679	7	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:24-04
680	9	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:24-04
681	10	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:24-04
682	23	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:24-04
683	27	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:25-04
684	32	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:25-04
685	33	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:25-04
686	34	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:25-04
687	36	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:25-04
688	37	36	0	logic_id=96		BkwdLogicScript	2014-05-05 04:44:25-04
689	1	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:37-04
690	6	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:37-04
691	7	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:37-04
692	9	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:37-04
693	10	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:37-04
694	23	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
695	27	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
696	32	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
697	33	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
698	34	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
699	36	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
700	37	34	0	logic_id=47		BkwdLogicScript	2014-05-05 04:44:38-04
701	1	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:55-04
702	6	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
703	7	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
704	9	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
705	10	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
706	23	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
707	27	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
708	32	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
709	33	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
710	34	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
711	36	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
712	37	32	0	logic_id=2		BkwdLogicScript	2014-05-05 04:44:56-04
713	2	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
714	3	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
715	4	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
716	8	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
717	10	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
718	17	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
719	18	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
720	23	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
721	27	58	1	logic_id=99		FwdLogicScript	2014-05-05 13:41:19-04
722	1	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:20-04
723	6	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:20-04
724	7	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:20-04
725	33	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:20-04
726	34	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:20-04
727	36	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:20-04
728	37	58	1	logic_id=100		FwdLogicScript	2014-05-05 13:41:21-04
729	7	48	0	logic_id=98		BkwdLogicScript	2014-05-05 13:41:30-04
730	27	48	0	logic_id=98		BkwdLogicScript	2014-05-05 13:41:31-04
731	32	48	0	logic_id=98		BkwdLogicScript	2014-05-05 13:41:31-04
732	34	48	0	logic_id=98		BkwdLogicScript	2014-05-05 13:41:31-04
733	1	53	0	logic_id=97		BkwdLogicScript	2014-05-05 13:41:31-04
734	6	53	0	logic_id=97		BkwdLogicScript	2014-05-05 13:41:32-04
735	7	53	0	logic_id=97		BkwdLogicScript	2014-05-05 13:41:32-04
736	27	53	0	logic_id=97		BkwdLogicScript	2014-05-05 13:41:32-04
737	32	53	0	logic_id=97		BkwdLogicScript	2014-05-05 13:41:32-04
738	34	53	0	logic_id=97		BkwdLogicScript	2014-05-05 13:41:32-04
739	7	49	0	logic_id=46		BkwdLogicScript	2014-05-05 13:41:55-04
740	27	49	0	logic_id=46		BkwdLogicScript	2014-05-05 13:41:55-04
741	32	49	0	logic_id=46		BkwdLogicScript	2014-05-05 13:41:55-04
742	34	49	0	logic_id=46		BkwdLogicScript	2014-05-05 13:41:55-04
743	23	41	0	logic_id=102		BkwdLogicScript	2014-05-05 14:24:50-04
744	1	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:50-04
745	6	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:50-04
746	7	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:50-04
747	27	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:51-04
748	33	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:51-04
749	34	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:51-04
750	36	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:51-04
751	37	38	0	logic_id=101		BkwdLogicScript	2014-05-05 14:24:51-04
752	7	52	0	logic_id=103		BkwdLogicScript	2014-05-06 01:36:44-04
753	27	52	0	logic_id=103		BkwdLogicScript	2014-05-06 01:36:44-04
754	32	52	0	logic_id=103		BkwdLogicScript	2014-05-06 01:36:44-04
755	34	52	0	logic_id=103		BkwdLogicScript	2014-05-06 01:36:45-04
756	7	43	0	logic_id=58		BkwdLogicScript	2014-05-06 01:37:05-04
757	27	43	0	logic_id=58		BkwdLogicScript	2014-05-06 01:37:05-04
758	32	43	0	logic_id=58		BkwdLogicScript	2014-05-06 01:37:05-04
759	34	43	0	logic_id=58		BkwdLogicScript	2014-05-06 01:37:05-04
760	2	35	1	obvious		rschwiebert	2014-05-06 04:33:40-04
761	2	33	0	2 does not have a square root in Q		rschwiebert	2014-05-06 04:35:17-04
762	2	36	0	2^2+1^2=5 does not have a square root in Q		rschwiebert	2014-05-06 04:36:46-04
763	2	37	1	logic_id=34		FwdLogicScript	2014-05-06 04:38:12-04
764	2	31	1	logic_id=11		FwdLogicScript	2014-05-06 04:40:06-04
765	2	34	0	logic_id=47		BkwdLogicScript	2014-05-06 04:41:14-04
766	2	32	0	logic_id=2		BkwdLogicScript	2014-05-06 04:41:33-04
767	2	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:28-04
768	3	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:28-04
769	4	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:28-04
770	8	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:29-04
771	9	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:29-04
772	10	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:29-04
773	17	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:29-04
774	18	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:29-04
775	23	29	1	logic_id=105		FwdLogicScript	2014-05-06 14:36:29-04
776	2	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
777	3	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
778	4	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
779	8	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
780	9	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
781	10	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
782	17	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
783	18	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
784	23	46	1	logic_id=106		FwdLogicScript	2014-05-06 14:36:29-04
785	1	46	1	logic_id=107		FwdLogicScript	2014-05-06 14:36:29-04
786	6	46	1	logic_id=107		FwdLogicScript	2014-05-06 14:36:29-04
787	1	29	1	logic_id=104		FwdLogicScript	2014-05-06 14:36:38-04
788	3	33	1	obvious		rschwiebert	2014-05-07 13:44:53-04
789	3	34	0	negatives are not squares		rschwiebert	2014-05-07 13:45:58-04
790	4	32	1	Fundamental theorem of algebra		rschwiebert	2014-05-07 13:47:40-04
791	4	38	0	obvious		rschwiebert	2014-05-07 13:48:37-04
792	2	38	0	obvious		rschwiebert	2014-05-07 13:50:17-04
793	3	38	0	obvious		rschwiebert	2014-05-07 13:50:52-04
794	4	34	1	logic_id=2		FwdLogicScript	2014-05-07 13:51:06-04
795	3	36	1	logic_id=20		FwdLogicScript	2014-05-07 13:51:10-04
796	3	35	1	logic_id=21		FwdLogicScript	2014-05-07 13:51:10-04
797	3	37	1	logic_id=34		FwdLogicScript	2014-05-07 13:51:14-04
798	4	36	1	logic_id=47		FwdLogicScript	2014-05-07 13:51:18-04
799	3	32	0	logic_id=2		BkwdLogicScript	2014-05-07 14:06:34-04
800	3	31	1	logic_id=11		FwdLogicScript	2014-05-07 14:22:35-04
801	4	37	1	obvious		rschwiebert	2014-05-07 14:27:26-04
802	4	35	0	The complex numbers do not have a compatible order		rschwiebert	2014-05-07 14:28:41-04
803	6	8	0			rschwiebert	2014-05-07 14:34:59-04
804	4	31	1	logic_id=11		FwdLogicScript	2014-05-08 00:30:42-04
805	6	57	0	logic_id=87		BkwdLogicScript	2014-05-08 00:31:18-04
806	4	33	0	logic_id=21		BkwdLogicScript	2014-05-08 00:31:51-04
807	6	7	0	logic_id=13		BkwdLogicScript	2014-05-08 00:31:55-04
808	7	30	1	ring has infinitely many primes, and is a UFD, so nothing is in the intersection of all primes (=nonzero maximals)		rschwiebert	2014-05-08 01:12:51-04
809	8	38	1	obvious		rschwiebert	2014-05-08 01:14:14-04
810	8	37	0	obvious		rschwiebert	2014-05-08 01:15:02-04
811	9	38	1	obvious		rschwiebert	2014-05-08 01:16:40-04
812	10	38	1	obvious		rschwiebert	2014-05-08 01:17:29-04
813	17	38	0	obvious		rschwiebert	2014-05-08 01:32:57-04
814	17	34	1	obvious		rschwiebert	2014-05-08 01:35:46-04
815	17	32	0	There exist nonconstructable numbers algebraic over Q		rschwiebert	2014-05-08 01:38:05-04
816	23	38	1	the ring has 8elements		rschwiebert	2014-05-08 01:40:29-04
817	23	21	0	It is local and Artinian, but does not have a simple socle.		rschwiebert	2014-05-08 01:45:52-04
818	23	57	0	The lattice of proper ideals is precisely the diamond lattice		rschwiebert	2014-05-08 01:46:28-04
819	27	46	0	The radical is (x) but this is not nil.		rschwiebert	2014-05-08 01:50:06-04
820	32	58	1	Easy to compute.		rschwiebert	2014-05-08 01:53:47-04
821	17	36	1	logic_id=47		FwdLogicScript	2014-05-08 02:36:11-04
822	7	46	1	logic_id=107		FwdLogicScript	2014-05-08 02:36:33-04
823	8	31	1	logic_id=3		FwdLogicScript	2014-05-08 02:36:35-04
824	7	29	1	logic_id=104		FwdLogicScript	2014-05-08 02:36:50-04
825	32	41	0	logic_id=102		BkwdLogicScript	2014-05-08 03:03:53-04
826	23	48	0	logic_id=98		BkwdLogicScript	2014-05-08 03:03:57-04
827	23	53	0	logic_id=97		BkwdLogicScript	2014-05-08 03:03:59-04
828	27	29	0	logic_id=106		BkwdLogicScript	2014-05-08 03:04:10-04
832	23	49	0	logic_id=46		BkwdLogicScript	2014-05-08 03:04:37-04
833	8	35	0	logic_id=34		BkwdLogicScript	2014-05-08 03:04:43-04
834	8	33	0	logic_id=21		BkwdLogicScript	2014-05-08 03:04:49-04
837	10	42	1	logic_id=108		FwdLogicScript	2014-05-08 04:54:42-04
838	23	42	1	logic_id=108		FwdLogicScript	2014-05-08 04:54:42-04
839	27	41	1	logic_id=109		FwdLogicScript	2014-05-08 14:27:18-04
840	27	51	1	logic_id=65		FwdLogicScript	2014-05-08 14:28:06-04
841	27	45	1	logic_id=56		FwdLogicScript	2014-05-08 14:28:49-04
842	27	56	1	logic_id=60		FwdLogicScript	2014-05-08 14:28:50-04
843	27	42	0	The chain of (x^k) does not terminate.		rschwiebert	2014-05-09 13:18:31-04
844	36	25	1	wikipedia		rschwiebert	2014-05-09 13:51:04-04
845	36	39	1	logic_id=29		FwdLogicScript	2014-05-09 14:32:10-04
846	36	40	1	logic_id=51		FwdLogicScript	2014-05-09 14:32:19-04
847	36	19	1	logic_id=77		FwdLogicScript	2014-05-09 14:32:31-04
848	36	26	0	logic_id=88		BkwdLogicScript	2014-05-10 03:54:09-04
849	47	4	1	The unique maximal ideal is (x^{1/2},x^{1/4},x^{1/8},...) which is the nil ideal also	rschwiebert	ConvertScript	2014-05-27 03:41:22-04
850	47	27	0	symmetry		ConvertScript	2014-05-27 03:41:23-04
851	47	28	1	logic_id=111		ConvertScript	2014-05-27 03:41:23-04
852	47	2	0	logic_id=168		ConvertScript	2014-05-27 03:41:23-04
853	47	30	0	logic_id=221		ConvertScript	2014-05-27 03:41:23-04
854	47	14	0	logic_id=448		ConvertScript	2014-05-27 03:41:23-04
855	47	1	0	logic_id=11		ConvertScript	2014-05-27 03:41:23-04
856	47	11	0	logic_id=69		ConvertScript	2014-05-27 03:41:23-04
857	47	10	0	logic_id=103		ConvertScript	2014-05-27 03:41:23-04
858	47	3	0	logic_id=17		ConvertScript	2014-05-27 03:41:23-04
859	47	15	0	logic_id=35		ConvertScript	2014-05-27 03:41:23-04
860	47	21	0	logic_id=74		ConvertScript	2014-05-27 03:41:23-04
861	47	54	1	logic_id=55		FwdLogicScript	2014-05-27 03:41:57-04
862	47	58	1	logic_id=99		FwdLogicScript	2014-05-27 03:42:03-04
863	47	7	0	logic_id=15		BkwdLogicScript	2014-05-27 03:43:03-04
864	47	9	0	logic_id=19		BkwdLogicScript	2014-05-27 03:43:03-04
865	47	31	0	logic_id=36		BkwdLogicScript	2014-05-27 03:43:04-04
866	47	13	0	logic_id=69		BkwdLogicScript	2014-05-27 03:43:04-04
867	47	36	0	logic_id=96		BkwdLogicScript	2014-05-27 03:43:05-04
868	47	37	0	logic_id=11		BkwdLogicScript	2014-05-27 03:43:12-04
869	47	33	0	logic_id=20		BkwdLogicScript	2014-05-27 03:43:12-04
870	47	35	0	logic_id=34		BkwdLogicScript	2014-05-27 03:43:12-04
871	47	34	0	logic_id=47		BkwdLogicScript	2014-05-27 03:43:13-04
872	47	16	0	logic_id=48		BkwdLogicScript	2014-05-27 03:43:13-04
873	47	32	0	logic_id=2		BkwdLogicScript	2014-05-27 03:43:21-04
874	43	28	0	R/J(R) is isomorphic to Z, and Z, which is not Artinian	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	ConvertScript	2014-05-27 03:44:08-04
875	43	4	0	logic_id=77		ConvertScript	2014-05-27 03:44:08-04
876	43	1	0	logic_id=12		ConvertScript	2014-05-27 03:44:08-04
877	43	15	0	logic_id=41		ConvertScript	2014-05-27 03:44:08-04
878	43	22	0	logic_id=44		ConvertScript	2014-05-27 03:44:08-04
879	43	21	0	logic_id=74		ConvertScript	2014-05-27 03:44:08-04
880	43	3	0	logic_id=17		ConvertScript	2014-05-27 03:44:08-04
881	43	5	0	logic_id=314		ConvertScript	2014-05-27 03:44:08-04
882	43	12	0	logic_id=120		ConvertScript	2014-05-27 03:44:08-04
883	43	10	0	logic_id=216		ConvertScript	2014-05-27 03:44:08-04
884	43	26	0	logic_id=7		BkwdLogicScript	2014-05-27 03:45:05-04
885	43	48	0	logic_id=17		BkwdLogicScript	2014-05-27 03:45:05-04
886	43	9	0	logic_id=19		BkwdLogicScript	2014-05-27 03:45:05-04
887	43	40	0	logic_id=33		BkwdLogicScript	2014-05-27 03:45:06-04
888	43	31	0	logic_id=36		BkwdLogicScript	2014-05-27 03:45:06-04
889	43	8	0	logic_id=43		BkwdLogicScript	2014-05-27 03:45:06-04
890	43	49	0	logic_id=45		BkwdLogicScript	2014-05-27 03:45:06-04
891	43	39	0	logic_id=51		BkwdLogicScript	2014-05-27 03:45:07-04
892	43	51	0	logic_id=57		BkwdLogicScript	2014-05-27 03:45:07-04
893	43	41	0	logic_id=65		BkwdLogicScript	2014-05-27 03:45:07-04
894	43	36	0	logic_id=96		BkwdLogicScript	2014-05-27 03:45:08-04
895	43	37	0	logic_id=11		BkwdLogicScript	2014-05-27 03:45:16-04
896	43	7	0	logic_id=13		BkwdLogicScript	2014-05-27 03:45:17-04
897	43	33	0	logic_id=20		BkwdLogicScript	2014-05-27 03:45:17-04
898	43	25	0	logic_id=29		BkwdLogicScript	2014-05-27 03:45:17-04
899	43	35	0	logic_id=34		BkwdLogicScript	2014-05-27 03:45:17-04
900	43	52	0	logic_id=35		BkwdLogicScript	2014-05-27 03:45:17-04
901	43	34	0	logic_id=47		BkwdLogicScript	2014-05-27 03:45:18-04
902	43	43	0	logic_id=58		BkwdLogicScript	2014-05-27 03:45:18-04
903	43	13	0	logic_id=68		BkwdLogicScript	2014-05-27 03:45:19-04
904	43	32	0	logic_id=2		BkwdLogicScript	2014-05-27 03:45:27-04
905	43	16	0	logic_id=48		BkwdLogicScript	2014-05-27 03:45:29-04
906	43	59	1	By construction, simple submodules embed into the ring	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	\N	2014-05-27 03:53:31-04
907	48	3	1	By definition it is the field of fractions for F_p[x]	rschwiebert	ConvertScript	2014-05-29 13:36:53-04
908	48	15	1	logic_id=19		ConvertScript	2014-05-29 13:36:54-04
909	48	22	1	logic_id=21		ConvertScript	2014-05-29 13:36:54-04
910	48	10	1	logic_id=22		ConvertScript	2014-05-29 13:36:54-04
911	48	6	1	logic_id=26		ConvertScript	2014-05-29 13:36:54-04
912	48	11	1	logic_id=35		ConvertScript	2014-05-29 13:36:54-04
913	48	21	1	logic_id=40		ConvertScript	2014-05-29 13:36:54-04
914	48	4	1	logic_id=45		ConvertScript	2014-05-29 13:36:54-04
915	48	14	1	logic_id=56		ConvertScript	2014-05-29 13:36:54-04
916	48	2	1	logic_id=69		ConvertScript	2014-05-29 13:36:54-04
917	48	30	1	logic_id=72		ConvertScript	2014-05-29 13:36:54-04
918	48	12	1	logic_id=101		ConvertScript	2014-05-29 13:36:54-04
919	48	1	1	logic_id=107		ConvertScript	2014-05-29 13:36:54-04
920	48	28	1	logic_id=111		ConvertScript	2014-05-29 13:36:54-04
921	48	5	1	logic_id=408		ConvertScript	2014-05-29 13:36:54-04
922	48	27	1	logic_id=168		ConvertScript	2014-05-29 13:36:54-04
923	48	18	1	logic_id=4		FwdLogicScript	2014-05-29 13:37:25-04
924	48	43	1	logic_id=6		FwdLogicScript	2014-05-29 13:37:25-04
925	48	8	1	logic_id=8		FwdLogicScript	2014-05-29 13:37:26-04
926	48	25	1	logic_id=9		FwdLogicScript	2014-05-29 13:37:26-04
927	48	44	1	logic_id=10		FwdLogicScript	2014-05-29 13:37:27-04
928	48	9	1	logic_id=23		FwdLogicScript	2014-05-29 13:37:29-04
929	48	16	1	logic_id=25		FwdLogicScript	2014-05-29 13:37:30-04
930	48	20	1	logic_id=26		FwdLogicScript	2014-05-29 13:37:30-04
931	48	49	1	logic_id=28		FwdLogicScript	2014-05-29 13:37:30-04
932	48	39	1	logic_id=29		FwdLogicScript	2014-05-29 13:37:31-04
933	48	50	1	logic_id=31		FwdLogicScript	2014-05-29 13:37:31-04
934	48	13	1	logic_id=38		FwdLogicScript	2014-05-29 13:37:33-04
935	48	7	1	logic_id=39		FwdLogicScript	2014-05-29 13:37:34-04
936	48	51	1	logic_id=44		FwdLogicScript	2014-05-29 13:37:35-04
937	48	48	1	logic_id=45		FwdLogicScript	2014-05-29 13:37:35-04
938	48	53	1	logic_id=46		FwdLogicScript	2014-05-29 13:37:35-04
939	48	17	1	logic_id=50		FwdLogicScript	2014-05-29 13:37:36-04
940	48	40	1	logic_id=51		FwdLogicScript	2014-05-29 13:37:36-04
941	48	54	1	logic_id=52		FwdLogicScript	2014-05-29 13:37:37-04
942	48	47	1	logic_id=53		FwdLogicScript	2014-05-29 13:37:37-04
943	48	55	1	logic_id=54		FwdLogicScript	2014-05-29 13:37:40-04
944	48	45	1	logic_id=56		FwdLogicScript	2014-05-29 13:37:40-04
945	48	52	1	logic_id=58		FwdLogicScript	2014-05-29 13:37:41-04
946	48	56	1	logic_id=60		FwdLogicScript	2014-05-29 13:37:41-04
947	48	41	1	logic_id=63		FwdLogicScript	2014-05-29 13:37:42-04
948	48	42	1	logic_id=75		FwdLogicScript	2014-05-29 13:37:44-04
949	48	19	1	logic_id=77		FwdLogicScript	2014-05-29 13:37:45-04
950	48	57	1	logic_id=86		FwdLogicScript	2014-05-29 13:37:46-04
951	48	58	1	logic_id=99		FwdLogicScript	2014-05-29 13:37:46-04
952	48	46	1	logic_id=107		FwdLogicScript	2014-05-29 13:37:47-04
953	48	26	1	logic_id=1		FwdLogicScript	2014-05-29 13:37:48-04
954	48	29	1	logic_id=104		FwdLogicScript	2014-05-29 13:37:56-04
955	23	20	0	 	NEEDS CITATION	\N	2014-05-31 14:42:51-04
956	49	4	1	Radical is (x) which is maximal	rschwiebert	ConvertScript	2014-05-31 19:58:41-04
957	49	28	1	logic_id=111		ConvertScript	2014-05-31 19:58:42-04
958	49	27	1	logic_id=180		ConvertScript	2014-05-31 19:58:42-04
959	49	1	1	symmetry		ConvertScript	2014-05-31 19:58:42-04
960	49	2	1	symmetry		ConvertScript	2014-05-31 19:58:42-04
961	49	22	1	Has exactly three ideals	rschwiebert	ConvertScript	2014-05-31 19:58:42-04
962	49	6	0	logic_id=53		ConvertScript	2014-05-31 19:58:42-04
963	49	30	0	logic_id=80		ConvertScript	2014-05-31 19:58:42-04
964	49	14	0	logic_id=257		ConvertScript	2014-05-31 19:58:42-04
965	49	5	0	logic_id=423		ConvertScript	2014-05-31 19:58:42-04
966	49	10	0	logic_id=216		ConvertScript	2014-05-31 19:58:43-04
967	49	12	0	logic_id=427		ConvertScript	2014-05-31 19:58:43-04
968	49	3	0	logic_id=17		ConvertScript	2014-05-31 19:58:43-04
969	49	15	0	logic_id=34		ConvertScript	2014-05-31 19:58:43-04
970	49	11	1	logic_id=275		ConvertScript	2014-05-31 19:58:43-04
971	49	21	1	logic_id=245		ConvertScript	2014-05-31 19:58:43-04
972	49	18	1	logic_id=4		FwdLogicScript	2014-05-31 19:58:54-04
973	49	43	1	logic_id=6		FwdLogicScript	2014-05-31 19:58:54-04
974	49	20	1	logic_id=26		FwdLogicScript	2014-05-31 19:58:59-04
975	49	49	1	logic_id=28		FwdLogicScript	2014-05-31 19:59:00-04
976	49	50	1	logic_id=31		FwdLogicScript	2014-05-31 19:59:00-04
977	49	51	1	logic_id=44		FwdLogicScript	2014-05-31 19:59:04-04
978	49	48	1	logic_id=45		FwdLogicScript	2014-05-31 19:59:05-04
979	49	53	1	logic_id=46		FwdLogicScript	2014-05-31 19:59:05-04
980	49	54	1	logic_id=52		FwdLogicScript	2014-05-31 19:59:06-04
981	49	47	1	logic_id=53		FwdLogicScript	2014-05-31 19:59:07-04
982	49	55	1	logic_id=54		FwdLogicScript	2014-05-31 19:59:07-04
983	49	45	1	logic_id=56		FwdLogicScript	2014-05-31 19:59:07-04
984	49	52	1	logic_id=58		FwdLogicScript	2014-05-31 19:59:08-04
985	49	56	1	logic_id=60		FwdLogicScript	2014-05-31 19:59:09-04
986	49	44	1	logic_id=71		FwdLogicScript	2014-05-31 19:59:12-04
987	49	58	1	logic_id=99		FwdLogicScript	2014-05-31 19:59:15-04
988	49	42	1	logic_id=108		FwdLogicScript	2014-05-31 19:59:17-04
989	49	41	1	logic_id=109		FwdLogicScript	2014-05-31 19:59:18-04
990	49	26	0	logic_id=7		BkwdLogicScript	2014-05-31 20:02:33-04
991	49	9	0	logic_id=19		BkwdLogicScript	2014-05-31 20:02:34-04
992	49	40	0	logic_id=33		BkwdLogicScript	2014-05-31 20:02:34-04
993	49	31	0	logic_id=36		BkwdLogicScript	2014-05-31 20:02:35-04
994	49	8	0	logic_id=43		BkwdLogicScript	2014-05-31 20:02:35-04
995	49	39	0	logic_id=51		BkwdLogicScript	2014-05-31 20:02:36-04
996	49	19	0	logic_id=78		BkwdLogicScript	2014-05-31 20:02:37-04
997	49	36	0	logic_id=96		BkwdLogicScript	2014-05-31 20:02:38-04
998	49	61	0	logic_id=114		BkwdLogicScript	2014-05-31 20:02:38-04
999	49	24	0	logic_id=116		BkwdLogicScript	2014-05-31 20:02:38-04
1000	49	37	0	logic_id=11		BkwdLogicScript	2014-05-31 20:05:26-04
1001	49	7	0	logic_id=13		BkwdLogicScript	2014-05-31 20:05:27-04
1002	49	33	0	logic_id=20		BkwdLogicScript	2014-05-31 20:05:27-04
1003	49	25	0	logic_id=29		BkwdLogicScript	2014-05-31 20:05:27-04
1004	49	35	0	logic_id=34		BkwdLogicScript	2014-05-31 20:05:27-04
1005	49	34	0	logic_id=47		BkwdLogicScript	2014-05-31 20:05:28-04
1006	49	13	0	logic_id=68		BkwdLogicScript	2014-05-31 20:05:29-04
1007	49	32	0	logic_id=2		BkwdLogicScript	2014-05-31 20:05:52-04
1008	49	16	0	logic_id=48		BkwdLogicScript	2014-05-31 20:05:54-04
1009	50	4	1	Nilradical (x,y,z) is maximal	obvious	\N	2014-05-31 22:28:46-04
1010	50	60	0	NEEDS CITATION	wikipedia	\N	2014-05-31 22:29:44-04
1011	50	20	1	NEEDS CITATION	wikipedia	\N	2014-05-31 22:30:16-04
1012	50	4	1	Nilradical (x,y,z) is maximal	obvious	ConvertScript	2014-06-02 13:15:55-04
1013	50	1	1	has finite R dimension	rschwiebert	ConvertScript	2014-06-02 13:15:56-04
1014	50	2	1	logic_id=11		ConvertScript	2014-06-02 13:15:56-04
1015	50	28	1	logic_id=111		ConvertScript	2014-06-02 13:15:56-04
1016	50	27	1	logic_id=168		ConvertScript	2014-06-02 13:15:56-04
1017	50	22	0	(x) and (y) cannot be arranged in a chain	rschwiebert	ConvertScript	2014-06-02 13:15:56-04
1018	50	3	0	logic_id=20		ConvertScript	2014-06-02 13:15:56-04
1019	50	5	0	logic_id=314		ConvertScript	2014-06-02 13:15:56-04
1020	50	30	0	logic_id=330		ConvertScript	2014-06-02 13:15:56-04
1021	50	14	0	logic_id=362		ConvertScript	2014-06-02 13:15:57-04
1022	50	11	0	logic_id=393		ConvertScript	2014-06-02 13:15:57-04
1023	50	12	0	logic_id=519		ConvertScript	2014-06-02 13:15:57-04
1024	50	15	0	logic_id=35		ConvertScript	2014-06-02 13:15:57-04
1025	50	6	0	logic_id=53		ConvertScript	2014-06-02 13:15:57-04
1026	50	10	0	logic_id=101		ConvertScript	2014-06-02 13:15:57-04
1027	50	18	1	logic_id=4		FwdLogicScript	2014-06-02 13:16:39-04
1028	50	43	1	logic_id=6		FwdLogicScript	2014-06-02 13:16:40-04
1029	50	50	1	logic_id=31		FwdLogicScript	2014-06-02 13:16:45-04
1030	50	54	1	logic_id=55		FwdLogicScript	2014-06-02 13:16:50-04
1031	50	52	1	logic_id=58		FwdLogicScript	2014-06-02 13:16:51-04
1032	50	58	1	logic_id=99		FwdLogicScript	2014-06-02 13:16:56-04
1033	50	42	1	logic_id=108		FwdLogicScript	2014-06-02 13:16:57-04
1034	50	45	1	logic_id=110		FwdLogicScript	2014-06-02 13:16:58-04
1035	50	51	1	logic_id=35		FwdLogicScript	2014-06-02 13:17:50-04
1036	50	56	1	logic_id=60		FwdLogicScript	2014-06-02 13:17:57-04
1037	50	26	0	logic_id=7		BkwdLogicScript	2014-06-02 13:19:20-04
1038	50	9	0	logic_id=19		BkwdLogicScript	2014-06-02 13:19:22-04
1039	50	40	0	logic_id=33		BkwdLogicScript	2014-06-02 13:19:23-04
1040	50	31	0	logic_id=36		BkwdLogicScript	2014-06-02 13:19:23-04
1041	50	8	0	logic_id=43		BkwdLogicScript	2014-06-02 13:19:25-04
1042	50	39	0	logic_id=51		BkwdLogicScript	2014-06-02 13:19:26-04
1043	50	19	0	logic_id=78		BkwdLogicScript	2014-06-02 13:19:27-04
1044	50	36	0	logic_id=96		BkwdLogicScript	2014-06-02 13:19:30-04
1045	50	41	0	logic_id=102		BkwdLogicScript	2014-06-02 13:19:31-04
1046	50	16	0	logic_id=112		BkwdLogicScript	2014-06-02 13:19:32-04
1047	50	61	0	logic_id=114		BkwdLogicScript	2014-06-02 13:19:33-04
1048	50	24	0	logic_id=116		BkwdLogicScript	2014-06-02 13:19:33-04
1049	50	37	0	logic_id=11		BkwdLogicScript	2014-06-02 13:19:56-04
1050	50	7	0	logic_id=13		BkwdLogicScript	2014-06-02 13:19:56-04
1051	50	33	0	logic_id=20		BkwdLogicScript	2014-06-02 13:19:57-04
1052	50	25	0	logic_id=29		BkwdLogicScript	2014-06-02 13:19:57-04
1053	50	35	0	logic_id=34		BkwdLogicScript	2014-06-02 13:19:59-04
1054	50	34	0	logic_id=47		BkwdLogicScript	2014-06-02 13:20:00-04
1055	50	13	0	logic_id=68		BkwdLogicScript	2014-06-02 13:20:02-04
1056	50	32	0	logic_id=2		BkwdLogicScript	2014-06-02 13:27:47-04
1057	51	11	0	logic_id=251		ConvertScript	2015-01-15 12:34:42.195889-05
1058	51	1	0	logic_id=11		ConvertScript	2015-01-15 12:34:42.38994-05
1059	51	2	0	logic_id=384		ConvertScript	2015-01-15 12:34:42.395559-05
1060	51	12	0	logic_id=427		ConvertScript	2015-01-15 12:34:42.40527-05
1061	51	10	0	logic_id=216		ConvertScript	2015-01-15 12:34:42.436448-05
1062	51	5	0	logic_id=423		ConvertScript	2015-01-15 12:34:42.442356-05
1063	51	3	0	logic_id=17		ConvertScript	2015-01-15 12:34:42.495473-05
1064	51	15	0	logic_id=40		ConvertScript	2015-01-15 12:34:42.500603-05
1065	51	21	0	logic_id=74		ConvertScript	2015-01-15 12:34:42.533612-05
1066	51	26	0	logic_id=7		BkwdLogicScript	2015-01-15 12:36:06.163411-05
1067	51	7	0	logic_id=15		BkwdLogicScript	2015-01-15 12:36:06.214421-05
1068	51	40	0	logic_id=33		BkwdLogicScript	2015-01-15 12:36:06.258311-05
1069	51	31	0	logic_id=36		BkwdLogicScript	2015-01-15 12:36:06.26856-05
1070	51	8	0	logic_id=43		BkwdLogicScript	2015-01-15 12:36:06.307857-05
1071	51	9	0	logic_id=19		BkwdLogicScript	2015-01-15 12:36:06.492999-05
1072	51	39	0	logic_id=51		BkwdLogicScript	2015-01-15 12:36:06.550326-05
1073	51	36	0	logic_id=96		BkwdLogicScript	2015-01-15 12:36:06.611086-05
1074	51	61	0	logic_id=114		BkwdLogicScript	2015-01-15 12:36:06.638061-05
1075	51	24	0	logic_id=116		BkwdLogicScript	2015-01-15 12:36:06.662584-05
1076	51	37	0	logic_id=11		BkwdLogicScript	2015-01-15 12:36:13.89999-05
1077	51	33	0	logic_id=20		BkwdLogicScript	2015-01-15 12:36:13.935881-05
1078	51	34	0	logic_id=47		BkwdLogicScript	2015-01-15 12:36:14.000156-05
1079	51	32	0	logic_id=2		BkwdLogicScript	2015-01-15 12:36:14.1186-05
1080	51	25	0	logic_id=29		BkwdLogicScript	2015-01-15 12:36:14.193489-05
1081	51	35	0	logic_id=34		BkwdLogicScript	2015-01-15 12:36:14.203162-05
1082	51	13	0	logic_id=68		BkwdLogicScript	2015-01-15 12:36:18.542219-05
1083	51	16	0	logic_id=48		BkwdLogicScript	2015-01-15 12:36:18.741927-05
1084	51	48	1	symmetry		ConvertScript	2015-01-19 11:52:39.71717-05
1085	51	28	1	logic_id=17		FwdLogicScript	2015-01-19 12:51:25.444615-05
1086	51	47	1	logic_id=18		FwdLogicScript	2015-01-19 12:51:25.500225-05
1087	51	54	1	logic_id=55		FwdLogicScript	2015-01-19 12:51:26.106976-05
1088	52	2	0	the rings in the product can be used to build an increasing sequence of ideals	rschwiebert	\N	2015-02-01 20:38:13.382253-05
\.


--
-- Name: comm_ring_property_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('comm_ring_property_id_seq', 1088, true);







--
-- Data for Name: faq; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY faq (id, question, answer) FROM stdin;
\.


--
-- Name: faq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('faq_id_seq', 1, false);


--
-- Data for Name: glossary; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY glossary (id, term, definition) FROM stdin;
\.


--
-- Name: glossary_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('glossary_id_seq', 1, false);


--
-- Data for Name: glossary_reference; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY glossary_reference (id, glossary_id, citation_id) FROM stdin;
\.


--
-- Name: glossary_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('glossary_reference_id_seq', 1, false);


--
-- Data for Name: keywords; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY keywords (id, name) FROM stdin;
1	rational polynomial
2	polynomial
3	quotient ring
4	triangular ring
5	localization
6	skew polynomial ring
7	subring
8	infinite matrix ring
9	trivial extension
10	monoid ring
11	direct product
12	power series ring
13	Laurent series ring
14	Laurent polynomials
15	matrix ring
16	ring of functions
\.


--
-- Name: keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('keywords_id_seq', 16, true);


--
-- Data for Name: logic; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY logic ("logic_ID", entry_type, cond_1, cond_2, cond_3, cond_4, conc, option, citation, poster, readable, theorem_id) FROM stdin;
1	1	1	\N	\N	\N	62	on	\N	rschwiebert	commutative implies stably finite	\N
3	1	1	\N	\N	\N	68	on	\N	rschwiebert	commutative implies left duo	\N
5	1	1	\N	\N	\N	99	on	\N	rschwiebert	commutative implies right Ore ring	\N
6	1	1	\N	\N	\N	101	on	\N	rschwiebert	commutative implies Abelian	\N
8	1	5	\N	\N	\N	72	on	\N	rschwiebert	left Noetherian implies left Goldie	\N
10	1	2	\N	\N	\N	54	on	\N	rschwiebert	right Artinian implies semiprimary	\N
11	1	3	\N	\N	\N	5	on	\N	rschwiebert	left Artinian implies left Noetherian	\N
13	1	50	\N	\N	\N	102	on	\N	rschwiebert	right self-injective implies right principally injective	\N
15	1	51	\N	\N	\N	103	on	\N	rschwiebert	left self-injective implies left principally injective	\N
17	1	6	\N	\N	\N	135	on	Obvious	rschwiebert	division ring implies simple Artinian	\N
18	1	6	\N	\N	\N	13	on	\N	rschwiebert	division ring implies strongly regular	\N
20	1	6	\N	\N	\N	40	on	\N	rschwiebert	division ring implies right valuation ring	\N
22	1	6	\N	\N	\N	17	on	\N	rschwiebert	division ring implies left principal ideal domain	\N
24	1	7	\N	\N	\N	37	on	\N	rschwiebert	simple implies left primitive	\N
25	1	7	\N	\N	\N	36	on	\N	rschwiebert	simple implies right primitive	\N
27	1	13	\N	\N	\N	15	on	\N	rschwiebert	strongly regular implies unit regular	\N
30	1	13	\N	\N	\N	67	on	\N	rschwiebert	strongly regular implies right duo	\N
31	1	13	\N	\N	\N	68	on	\N	rschwiebert	strongly regular implies left duo	\N
33	1	8	\N	\N	\N	26	on	\N	rschwiebert	semisimple implies right hereditary	\N
34	1	8	\N	\N	\N	32	on	\N	rschwiebert	semisimple implies Baer	\N
36	1	8	\N	\N	\N	18	on	\N	rschwiebert	semisimple implies right principal ideal ring	\N
38	1	8	\N	\N	\N	39	on	\N	rschwiebert	semisimple implies left V ring	\N
39	1	8	\N	\N	\N	38	on	\N	rschwiebert	semisimple implies right V ring	\N
41	1	8	\N	\N	\N	43	on	\N	rschwiebert	semisimple implies left serial	\N
42	1	8	\N	\N	\N	42	on	\N	rschwiebert	semisimple implies right serial	\N
44	1	41	\N	\N	\N	43	on	\N	rschwiebert	left valuation ring implies left serial	\N
46	1	40	\N	\N	\N	20	on	\N	rschwiebert	right valuation ring implies right Bezout	\N
48	1	40	\N	\N	\N	55	on	\N	rschwiebert	right valuation ring implies local	\N
49	1	37	\N	\N	\N	9	on	\N	rschwiebert	left primitive implies semiprimitive	\N
51	1	36	\N	\N	\N	9	on	\N	rschwiebert	right primitive implies semiprimitive	\N
53	1	14	\N	\N	\N	11	on	\N	rschwiebert	reduced implies semiprime	\N
54	1	14	\N	\N	\N	35	on	\N	rschwiebert	reduced implies left nonsingular	\N
56	1	15	\N	\N	\N	12	on	\N	rschwiebert	unit regular implies von Neumann regular	\N
58	1	15	\N	\N	\N	65	on	\N	rschwiebert	unit regular implies right cohopfian	\N
59	1	15	\N	\N	\N	91	on	\N	rschwiebert	unit regular implies stable range 1	\N
61	1	83	\N	\N	\N	66	on	\N	rschwiebert	strongly pi regular implies left cohopfian	\N
63	1	83	\N	\N	\N	91	on	NEEDS CITATION	rschwiebert	strongly pi regular implies stable range 1	\N
65	1	26	\N	\N	\N	28	on	\N	rschwiebert	right hereditary implies right semihereditary	\N
66	1	32	\N	\N	\N	31	on	\N	rschwiebert	Baer implies left Rickart	\N
68	1	19	\N	\N	\N	21	on	\N	rschwiebert	left principal ideal ring implies left Bezout	\N
70	1	18	\N	\N	\N	20	on	\N	rschwiebert	right principal ideal ring implies right Bezout	\N
72	1	39	\N	\N	\N	9	on	\N	rschwiebert	left V ring implies semiprimitive	\N
73	1	38	\N	\N	\N	9	on	\N	rschwiebert	right V ring implies semiprimitive	\N
75	1	43	\N	\N	\N	57	on	\N	rschwiebert	left serial implies semiperfect	\N
76	1	42	\N	\N	\N	57	on	\N	rschwiebert	right serial implies semiperfect	\N
78	1	55	\N	\N	\N	107	on	\N	rschwiebert	local implies left quasi-duo	\N
79	1	55	\N	\N	\N	106	on	\N	rschwiebert	local implies right quasi-duo	\N
82	1	12	\N	\N	\N	29	on	\N	rschwiebert	von Neumann regular implies left semihereditary	\N
84	1	12	\N	\N	\N	21	on	\N	rschwiebert	von Neumann regular implies left Bezout	\N
86	1	12	\N	\N	\N	103	on	\N	rschwiebert	von Neumann regular implies left principally injective	\N
88	1	12	\N	\N	\N	90	on	\N	rschwiebert	von Neumann regular implies clean	\N
89	1	12	\N	\N	\N	84	on	\N	rschwiebert	von Neumann regular implies pi regular	\N
91	1	65	\N	\N	\N	61	on	\N	rschwiebert	right cohopfian implies Dedekind finite	\N
93	1	84	\N	\N	\N	85	on	\N	rschwiebert	pi regular implies exchange	\N
94	1	84	\N	\N	\N	87	on	\N	rschwiebert	pi regular implies Zorn	\N
97	1	28	\N	\N	\N	30	on	\N	rschwiebert	right semihereditary implies right Rickart	\N
98	1	28	\N	\N	\N	73	on	(Chase's Theorem) Lam, Lectures on Modules and rings pg 146	rschwiebert	right semihereditary implies right coherent	\N
99	1	31	\N	\N	\N	35	on	\N	rschwiebert	left Rickart implies left nonsingular	\N
100	1	30	\N	\N	\N	34	on	\N	rschwiebert	right Rickart implies right nonsingular	\N
103	1	17	\N	\N	\N	19	on	\N	rschwiebert	left principal ideal domain implies left principal ideal ring	\N
106	1	16	\N	\N	\N	18	on	\N	rschwiebert	right principal ideal domain implies right principal ideal ring	\N
108	1	45	\N	\N	\N	2	on	\N	rschwiebert	quasi-Frobenius implies right Artinian	\N
109	1	45	\N	\N	\N	47	on	\N	rschwiebert	quasi-Frobenius implies left pseudo-Frobenius	\N
111	1	57	\N	\N	\N	56	on	\N	rschwiebert	semiperfect implies semilocal	\N
113	1	57	\N	\N	\N	90	on	\N	rschwiebert	semiperfect implies clean	\N
114	1	90	\N	\N	\N	85	on	\N	rschwiebert	clean implies exchange	\N
116	1	62	\N	\N	\N	64	on	\N	rschwiebert	stably finite implies IBN	\N
117	1	85	\N	\N	\N	86	on	\N	rschwiebert	exchange implies I_0	\N
118	1	87	\N	\N	\N	86	on	\N	rschwiebert	Zorn implies I_0	\N
120	1	23	\N	\N	\N	25	on	\N	rschwiebert	left Bezout domain implies left Ore domain	\N
123	1	22	\N	\N	\N	24	on	\N	rschwiebert	right Bezout domain implies right Ore domain	\N
126	1	47	\N	\N	\N	51	on	\N	rschwiebert	left pseudo-Frobenius implies left self-injective	\N
128	1	47	\N	\N	\N	52	on	NEEDS CITATION	rschwiebert	left pseudo-Frobenius implies right Kasch	\N
130	1	46	\N	\N	\N	48	on	\N	rschwiebert	right pseudo-Frobenius implies right finitely pseudo-Frobenius	\N
132	1	46	\N	\N	\N	81	on	\N	rschwiebert	right pseudo-Frobenius implies right dual	\N
134	1	46	\N	\N	\N	57	on	Lam, T.Y. Lectures on Modules and rings 514	rschwiebert	right pseudo-Frobenius implies semiperfect	\N
135	1	56	\N	\N	\N	91	on	\N	rschwiebert	semilocal implies stable range 1	\N
136	1	88	\N	\N	\N	85	on	\N	rschwiebert	semiregular implies exchange	\N
137	1	88	\N	\N	\N	60	on	\N	rschwiebert	semiregular implies lift/rad	\N
139	1	54	\N	\N	\N	59	on	\N	rschwiebert	semiprimary implies right perfect	\N
141	1	5	\N	\N	\N	74	on	\N	rschwiebert	left Noetherian implies left coherent	\N
142	1	81	\N	\N	\N	52	on	\N	rschwiebert	right dual implies right Kasch	\N
144	1	58	\N	\N	\N	83	on	\N	rschwiebert	left perfect implies strongly pi regular	\N
146	1	59	\N	\N	\N	83	on	\N	rschwiebert	right perfect implies strongly pi regular	\N
147	1	59	\N	\N	\N	57	on	\N	rschwiebert	right perfect implies semiperfect	\N
149	1	72	\N	\N	\N	79	on	\N	rschwiebert	left Goldie implies right DCC annihilator	\N
151	1	71	\N	\N	\N	77	on	\N	rschwiebert	right Goldie implies right ACC annihilator	\N
153	1	69	\N	\N	\N	62	on	\N	rschwiebert	right finite uniform dimension implies stably finite	\N
154	1	55	\N	\N	\N	104	on	\N	rschwiebert	local implies connected	\N
156	1	68	\N	\N	\N	107	on	\N	rschwiebert	left duo implies left quasi-duo	\N
157	1	33	\N	\N	\N	104	on	\N	rschwiebert	domain implies connected	\N
160	1	110	\N	\N	\N	109	on	\N	rschwiebert	right T-nilpotent radical implies nil radical	\N
162	1	105	\N	\N	\N	111	on	\N	rschwiebert	nilpotent radical implies left T-nilpotent radical	\N
164	1	54	\N	\N	\N	105	on	\N	rschwiebert	semiprimary implies nilpotent radical	\N
166	1	58	\N	\N	\N	111	on	\N	rschwiebert	left perfect implies left T-nilpotent radical	\N
168	1	5	\N	\N	\N	76	on	\N	rschwiebert	left Noetherian implies left ACC principal	\N
170	1	70	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	left finite uniform dimension implies orthogonally finite	\N
171	1	76	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	left ACC principal implies orthogonally finite	\N
173	1	77	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	right ACC annihilator implies orthogonally finite	\N
176	1	3	\N	\N	\N	77	on	Lam, T.Y. LMR 229	rschwiebert	left Artinian implies right ACC annihilator	\N
179	1	59	\N	\N	\N	75	on	\N	rschwiebert	right perfect implies right ACC principal	\N
180	1	58	\N	\N	\N	76	on	\N	rschwiebert	left perfect implies left ACC principal	\N
182	1	104	\N	\N	\N	101	on	\N	rschwiebert	connected implies Abelian	\N
188	1	113	\N	\N	\N	117	on	Obvious	rschwiebert	left simple socle implies left nonzero socle	\N
189	1	118	\N	\N	\N	116	on	Obvious	rschwiebert	right essential socle implies right nonzero socle	\N
191	1	112	\N	\N	\N	114	on	Obvious	rschwiebert	right simple socle implies right finitely generated socle	\N
193	1	120	\N	\N	\N	52	on	LAM-LMR 510	rschwiebert	right cogenerator ring implies right Kasch	\N
195	1	46	\N	\N	\N	120	on	LAM-LMR 514	rschwiebert	right pseudo-Frobenius implies right cogenerator ring	\N
197	1	46	\N	\N	\N	122	on	LAM-LMR 514	rschwiebert	right pseudo-Frobenius implies right finitely cogenerated	\N
198	1	47	\N	\N	\N	123	on	LAM-LMR 514	rschwiebert	left pseudo-Frobenius implies left finitely cogenerated	\N
200	1	47	\N	\N	\N	119	on	LAM-LMR 514	rschwiebert	left pseudo-Frobenius implies left essential socle	\N
201	1	1	\N	\N	\N	130	on	Obvious	rschwiebert	commutative implies symmetric	\N
206	1	70	\N	\N	\N	115	on	Obvious	rschwiebert	left finite uniform dimension implies left finitely generated socle	\N
210	1	58	\N	\N	\N	118	on	LAM-LMR 540	rschwiebert	left perfect implies right essential socle	\N
214	1	94	\N	\N	\N	96	on	\N	rschwiebert	left free ideal ring implies semi free ideal ring	\N
216	1	17	\N	\N	\N	94	on	Obvious	rschwiebert	left principal ideal domain implies left free ideal ring	\N
217	1	95	\N	\N	\N	26	on	Obvious	rschwiebert	right free ideal ring implies right hereditary	\N
219	1	96	\N	\N	\N	28	on	Obvious	rschwiebert	semi free ideal ring implies right semihereditary	\N
221	1	9	\N	\N	\N	105	on	\N	rschwiebert	semiprimitive implies nilpotent radical	\N
222	1	126	\N	\N	\N	104	on	\N	rschwiebert	right uniform implies connected	\N
224	1	127	\N	\N	\N	104	on	\N	rschwiebert	left uniform implies connected	\N
226	1	40	\N	\N	\N	126	on	\N	rschwiebert	right valuation ring implies right uniform	\N
227	1	41	\N	\N	\N	127	on	\N	rschwiebert	left valuation ring implies left uniform	\N
229	1	125	\N	\N	\N	101	on	Puninski "Serial Rings" 134	rschwiebert	left distributive implies Abelian	\N
231	2	1	37	\N	\N	6	on	\N	rschwiebert	commutative and left primitive implies division ring	\N
232	2	1	36	\N	\N	6	on	\N	rschwiebert	commutative and right primitive implies division ring	\N
233	2	1	12	\N	\N	13	on	\N	rschwiebert	commutative and von Neumann regular implies strongly regular	\N
235	2	1	12	\N	\N	38	on	\N	rschwiebert	commutative and von Neumann regular implies right V ring	\N
237	2	1	38	\N	\N	12	on	\N	rschwiebert	commutative and right V ring implies von Neumann regular	\N
238	2	1	39	\N	\N	12	on	\N	rschwiebert	commutative and left V ring implies von Neumann regular	\N
240	2	1	35	\N	\N	14	on	\N	rschwiebert	commutative and left nonsingular implies reduced	\N
242	2	1	10	\N	\N	24	on	\N	rschwiebert	commutative and prime implies right Ore domain	\N
244	2	1	84	\N	\N	83	on	\N	rschwiebert	commutative and pi regular implies strongly pi regular	\N
246	2	1	97	\N	\N	12	on	\N	rschwiebert	commutative and fully semiprime implies von Neumann regular	\N
248	2	1	16	\N	\N	17	on	\N	rschwiebert	commutative and right principal ideal domain implies left principal ideal domain	\N
251	2	1	19	\N	\N	18	on	\N	rschwiebert	commutative and left principal ideal ring implies right principal ideal ring	\N
252	2	1	96	\N	\N	22	on	\N	rschwiebert	commutative and semi free ideal ring implies right Bezout domain	\N
254	2	101	85	\N	\N	90	on	\N	rschwiebert	Abelian and exchange implies clean	\N
256	2	14	12	\N	\N	13	on	\N	rschwiebert	reduced and von Neumann regular implies strongly regular	\N
257	2	101	12	\N	\N	14	on	\N	rschwiebert	Abelian and von Neumann regular implies reduced	\N
52	1	36	\N	\N	\N	10	on	\N	rschwiebert	right primitive implies prime	\N
259	2	56	110	\N	\N	59	on	\N	rschwiebert	semilocal and right T-nilpotent radical implies right perfect	\N
261	2	4	12	\N	\N	8	on	\N	rschwiebert	right Noetherian and von Neumann regular implies semisimple	\N
263	1	52	\N	\N	\N	116	on	Obvious	rschwiebert	right Kasch implies right nonzero socle	\N
265	2	4	51	\N	\N	45	on	\N	rschwiebert	right Noetherian and left self-injective implies quasi-Frobenius	\N
267	2	4	102	\N	\N	3	on	NEEDS CITATION	rschwiebert	right Noetherian and right principally injective implies left Artinian	\N
269	2	4	84	\N	\N	2	on	NEEDS CITATION	rschwiebert	right Noetherian and pi regular implies right Artinian	\N
270	2	4	86	\N	\N	57	on	NEEDS CITATION	rschwiebert	right Noetherian and I_0 implies semiperfect	\N
273	2	5	109	\N	\N	105	on	Levitsky's theorem. Lam, T.Y. First course in noncommutative rings p 165	rschwiebert	left Noetherian and nil radical implies nilpotent radical	\N
274	2	5	12	\N	\N	8	on	\N	rschwiebert	left Noetherian and von Neumann regular implies semisimple	\N
275	2	76	21	\N	\N	19	on	\N	rschwiebert	left ACC principal and left Bezout implies left principal ideal ring	\N
276	1	53	\N	\N	\N	117	on	Obvious	rschwiebert	left Kasch implies left nonzero socle	\N
278	2	5	50	\N	\N	45	on	\N	rschwiebert	left Noetherian and right self-injective implies quasi-Frobenius	\N
280	2	5	103	\N	\N	2	on	NEEDS CITATION	rschwiebert	left Noetherian and left principally injective implies right Artinian	\N
282	2	5	84	\N	\N	3	on	NEEDS CITATION	rschwiebert	left Noetherian and pi regular implies left Artinian	\N
283	2	5	86	\N	\N	57	on	NEEDS CITATION	rschwiebert	left Noetherian and I_0 implies semiperfect	\N
285	2	51	50	\N	\N	65	on	NEEDS CITATION	rschwiebert	left self-injective and right self-injective implies right cohopfian	\N
287	2	51	35	\N	\N	12	on	\N	rschwiebert	left self-injective and left nonsingular implies von Neumann regular	\N
289	2	51	9	\N	\N	12	on	\N	rschwiebert	left self-injective and semiprimitive implies von Neumann regular	\N
290	2	51	14	\N	\N	13	on	\N	rschwiebert	left self-injective and reduced implies strongly regular	\N
292	2	51	39	\N	\N	12	on	\N	rschwiebert	left self-injective and left V ring implies von Neumann regular	\N
294	2	51	53	\N	\N	47	on	\N	rschwiebert	left self-injective and left Kasch implies left pseudo-Frobenius	\N
296	2	51	70	\N	\N	57	on	\N	rschwiebert	left self-injective and left finite uniform dimension implies semiperfect	\N
298	2	56	60	\N	\N	57	on	\N	rschwiebert	semilocal and lift/rad implies semiperfect	\N
300	2	102	61	\N	\N	65	on	\N	rschwiebert	right principally injective and Dedekind finite implies right cohopfian	\N
302	2	50	26	\N	\N	8	on	\N	rschwiebert	right self-injective and right hereditary implies semisimple	\N
305	2	50	9	\N	\N	12	on	\N	rschwiebert	right self-injective and semiprimitive implies von Neumann regular	\N
307	2	50	36	\N	\N	12	on	\N	rschwiebert	right self-injective and right primitive implies von Neumann regular	\N
309	2	50	39	\N	\N	12	on	\N	rschwiebert	right self-injective and left V ring implies von Neumann regular	\N
311	2	50	56	\N	\N	57	on	\N	rschwiebert	right self-injective and semilocal implies semiperfect	\N
313	2	50	61	\N	\N	91	on	NEEDS CITATION	rschwiebert	right self-injective and Dedekind finite implies stable range 1	\N
315	2	3	10	\N	\N	7	on	\N	rschwiebert	left Artinian and prime implies simple	\N
316	2	3	10	\N	\N	135	on	\N	rschwiebert	left Artinian and prime implies simple Artinian	\N
319	2	54	26	\N	\N	27	on	Lam, T.Y. Lectures on modules and rings p 188 (Auslander's Thm)	rschwiebert	semiprimary and right hereditary implies left hereditary	\N
320	2	3	48	\N	\N	45	on	\N	rschwiebert	left Artinian and right finitely pseudo-Frobenius implies quasi-Frobenius	\N
321	2	54	55	\N	\N	53	on	Lam, T.Y. Lectures on Modules and Rings p281	rschwiebert	semiprimary and local implies left Kasch	\N
323	2	2	10	\N	\N	7	on	\N	rschwiebert	right Artinian and prime implies simple	\N
324	2	2	10	\N	\N	135	on	\N	rschwiebert	right Artinian and prime implies simple Artinian	\N
327	2	54	29	\N	\N	27	on	Lam, T.Y. Lectures on modules and rings p 188 (Auslander's Thm)	rschwiebert	semiprimary and left semihereditary implies left hereditary	\N
328	2	2	49	\N	\N	45	on	\N	rschwiebert	right Artinian and left finitely pseudo-Frobenius implies quasi-Frobenius	\N
329	2	54	55	\N	\N	52	on	Lam, T.Y. Lectures on Modules and Rings p281	rschwiebert	semiprimary and local implies right Kasch	\N
331	2	9	56	\N	\N	8	on	\N	rschwiebert	semiprimitive and semilocal implies semisimple	\N
332	2	9	134	\N	\N	12	on	Obvious	rschwiebert	semiprimitive and top regular implies von Neumann regular	\N
335	2	120	53	\N	\N	46	on	LAM-LMR 514	rschwiebert	right cogenerator ring and left Kasch implies right pseudo-Frobenius	\N
336	2	51	53	\N	\N	47	on	LAM-LMR 514	rschwiebert	left self-injective and left Kasch implies left pseudo-Frobenius	\N
338	2	121	52	\N	\N	47	on	LAM-LMR 514	rschwiebert	left cogenerator ring and right Kasch implies left pseudo-Frobenius	\N
340	2	115	119	\N	\N	70	on	???	rschwiebert	left finitely generated socle and left essential socle implies left finite uniform dimension	\N
342	2	11	123	\N	\N	8	on	LAM-LMR 538	rschwiebert	semiprime and left finitely cogenerated implies semisimple	\N
344	2	120	104	\N	\N	50	on	LAM-LMR 538	rschwiebert	right cogenerator ring and connected implies right self-injective	\N
346	2	121	104	\N	\N	51	on	LAM-LMR 538	rschwiebert	left cogenerator ring and connected implies left self-injective	\N
348	2	121	33	\N	\N	6	on	LAM-LMR 538	rschwiebert	left cogenerator ring and domain implies division ring	\N
350	2	11	117	\N	\N	116	on	T.Y. Lam First course in noncommutative rings p 174 Lemma 11.9	rschwiebert	semiprime and left nonzero socle implies right nonzero socle	\N
352	2	10	116	\N	\N	37	on	T.Y. Lam First course in noncommutative rings p 174-175 Lemma 11.11	rschwiebert	prime and right nonzero socle implies left primitive	\N
353	2	10	117	\N	\N	36	on	T.Y. Lam First course in noncommutative rings p 174-175 Lemma 11.11	rschwiebert	prime and left nonzero socle implies right primitive	\N
354	2	10	117	\N	\N	37	on	T.Y. Lam First course in noncommutative rings p 174-175 Lemma 11.11	rschwiebert	prime and left nonzero socle implies left primitive	\N
356	2	5	96	\N	\N	94	on	Obvious	rschwiebert	left Noetherian and semi free ideal ring implies left free ideal ring	\N
357	2	104	88	\N	\N	55	off	\N	rschwiebert	connected and semiregular implies local	\N
359	2	11	71	\N	\N	99	on	Lam-LMR 324	rschwiebert	semiprime and right Goldie implies right Ore ring	\N
361	2	11	72	\N	\N	100	on	Lam-LMR 324	rschwiebert	semiprime and left Goldie implies left Ore ring	\N
362	2	12	104	\N	\N	6	on	\N	rschwiebert	von Neumann regular and connected implies division ring	\N
365	2	125	35	\N	\N	14	on	Tuganbaev Semidistributive modules and rings 165	rschwiebert	left distributive and left nonsingular implies reduced	\N
366	2	124	14	\N	\N	34	on	Tuganbaev Semidistributive modules and rings 165	rschwiebert	right distributive and reduced implies right nonsingular	\N
368	2	12	124	\N	\N	13	on	Tuganbaev Semidistributive modules and rings 60	rschwiebert	von Neumann regular and right distributive implies strongly regular	\N
369	2	12	125	\N	\N	13	on	Tuganbaev Semidistributive modules and rings 60	rschwiebert	von Neumann regular and left distributive implies strongly regular	\N
371	2	125	10	\N	\N	127	on	Tuganbaev Semidistributive modules and rings 110	rschwiebert	left distributive and prime implies left uniform	\N
372	2	1	33	\N	\N	126	on	\N	rschwiebert	commutative and domain implies right uniform	\N
373	2	124	59	\N	\N	54	on	Tuganbaev Semidistributive modules and rings 156	rschwiebert	right distributive and right perfect implies semiprimary	\N
375	2	124	58	\N	\N	54	on	Tuganbaev Semidistributive modules and rings 156	rschwiebert	right distributive and left perfect implies semiprimary	\N
376	2	125	58	\N	\N	54	on	Tuganbaev Semidistributive modules and rings 156	rschwiebert	left distributive and left perfect implies semiprimary	\N
378	2	21	107	\N	\N	125	on	Tuganbaev Left and right distributive rings (1995) Theorem 2	rschwiebert	left Bezout and left quasi-duo implies left distributive	\N
379	2	112	118	\N	\N	126	on	\N	rschwiebert	right simple socle and right essential socle implies right uniform	\N
381	3	1	2	42	\N	45	on	\N	rschwiebert	commutative and right Artinian and right serial implies quasi-Frobenius	\N
383	3	4	81	82	\N	45	on	LAM-LMR 409	rschwiebert	right Noetherian and right dual and left dual implies quasi-Frobenius	\N
385	3	50	56	118	\N	46	on	LAM-LMR 514	rschwiebert	right self-injective and semilocal and right essential socle implies right pseudo-Frobenius	\N
387	3	4	120	121	\N	45	on	LAM-LMR 511	rschwiebert	right Noetherian and right cogenerator ring and left cogenerator ring implies quasi-Frobenius	\N
389	3	11	34	69	\N	71	on	Lam-LMR 324	rschwiebert	semiprime and right nonsingular and right finite uniform dimension implies right Goldie	\N
392	3	55	54	18	\N	40	on	\N	rschwiebert	local and semiprimary and right principal ideal ring implies right valuation ring	\N
393	3	55	54	19	\N	41	on	\N	rschwiebert	local and semiprimary and left principal ideal ring implies left valuation ring	\N
396	4	1	55	2	112	45	on	\N	rschwiebert	commutative and local and right Artinian and right simple socle implies quasi-Frobenius	\N
398	4	1	118	112	50	55	on	LAM-LMR 538	rschwiebert	commutative and right essential socle and right simple socle and right self-injective implies local	\N
400	1	14	\N	\N	\N	130	on	Marks, G. Reversible and symmetric rings (2001)	rschwiebert	reduced implies symmetric	\N
401	1	130	\N	\N	\N	129	on	Marks, G. Reversible and symmetric rings (2001)	rschwiebert	symmetric implies reversible	\N
402	1	129	\N	\N	\N	128	on	Marks, G. Reversible and symmetric rings (2001)	rschwiebert	reversible implies 2-primal	\N
404	1	68	\N	\N	\N	128	on	Marks, G. Reversible and symmetric rings (2001)	rschwiebert	left duo implies 2-primal	\N
407	2	1	84	\N	\N	88	on	Lam, T.Y. FCNR p 65	rschwiebert	commutative and pi regular implies semiregular	\N
408	1	24	\N	\N	\N	33	on	Obvious	rschwiebert	right Ore domain implies domain	\N
410	1	25	\N	\N	\N	33	on	Obvious	rschwiebert	left Ore domain implies domain	\N
411	1	25	\N	\N	\N	72	on	Lam, T.Y. LMR p 329	rschwiebert	left Ore domain implies left Goldie	\N
413	2	133	105	\N	\N	131	on	Obvious	rschwiebert	top simple Artinian and nilpotent radical implies primary	\N
415	2	27	70	\N	\N	5	on	Lam, T.Y. LMR p 266	rschwiebert	left hereditary and left finite uniform dimension implies left Noetherian	\N
417	2	70	33	\N	\N	25	on	Lam, T.Y. LMR p 266	rschwiebert	left finite uniform dimension and domain implies left Ore domain	\N
418	1	92	\N	\N	\N	88	on	Tuganbaev,A.  Semiregular Pi Regular Rings 2.26	rschwiebert	right continuous implies semiregular	\N
419	1	92	\N	\N	\N	90	on	\N	rschwiebert	right continuous implies clean	\N
421	1	93	\N	\N	\N	90	on	\N	rschwiebert	left continuous implies clean	\N
422	1	10	\N	\N	\N	11	on	Obvious	rschwiebert	prime implies semiprime	\N
423	1	33	\N	\N	\N	10	on	Obvious	rschwiebert	domain implies prime	\N
425	1	25	\N	\N	\N	100	on	Obvious	rschwiebert	left Ore domain implies left Ore ring	\N
427	1	23	\N	\N	\N	96	on	Left ideals will be free rank 1	rschwiebert	left Bezout domain implies semi free ideal ring	\N
429	1	13	\N	\N	\N	124	on	Tuganbaev Semidistributive Modules and Rings Thm 3.30	rschwiebert	strongly regular implies right distributive	\N
431	2	12	124	\N	\N	13	on	Tuganbaev Semidistributive Modules and Rings Thm 3.30	rschwiebert	von Neumann regular and right distributive implies strongly regular	\N
433	1	40	\N	\N	\N	124	on	Chain lattice obviously distributive	rschwiebert	right valuation ring implies right distributive	\N
434	1	41	\N	\N	\N	125	on	Chain lattice obviously distributive	rschwiebert	left valuation ring implies left distributive	\N
435	1	104	\N	\N	\N	108	on	Obvious	rschwiebert	connected implies orthogonally finite	\N
437	2	1	54	\N	\N	53	on	Lam, T.Y. Lectures on Modules and Rings p189	rschwiebert	commutative and semiprimary implies left Kasch	\N
438	2	1	54	\N	\N	52	on	Lam, T.Y. Lectures on Modules and Rings p189	rschwiebert	commutative and semiprimary implies right Kasch	\N
439	1	135	\N	\N	\N	7	on	Obvious	rschwiebert	simple Artinian implies simple	\N
440	1	135	\N	\N	\N	131	on	Obvious	rschwiebert	simple Artinian implies primary	\N
441	1	131	\N	\N	\N	54	on	Obvious	rschwiebert	primary implies semiprimary	\N
443	1	55	\N	\N	\N	133	on	Obvious	rschwiebert	local implies top simple Artinian	\N
444	1	133	\N	\N	\N	132	on	Obvious	rschwiebert	top simple Artinian implies top simple	\N
446	1	56	\N	\N	\N	134	on	Obvious	rschwiebert	semilocal implies top regular	\N
447	1	88	\N	\N	\N	134	on	Obvious	rschwiebert	semiregular implies top regular	\N
450	2	69	29	\N	\N	28	on	Lam, T.Y. Lectures on Modules and Rings p 268	rschwiebert	right finite uniform dimension and left semihereditary implies right semihereditary	\N
452	2	70	29	\N	\N	28	on	Lam, T.Y. Lectures on Modules and Rings p 268	rschwiebert	left finite uniform dimension and left semihereditary implies right semihereditary	\N
453	2	4	28	\N	\N	26	on	Obvious	rschwiebert	right Noetherian and right semihereditary implies right hereditary	\N
454	2	5	29	\N	\N	27	on	Obvious	rschwiebert	left Noetherian and left semihereditary implies left hereditary	\N
456	1	131	\N	\N	\N	53	on	Lam, T.Y. Lectures on modules and rings p 189	rschwiebert	primary implies left Kasch	\N
458	2	25	94	\N	\N	17	on	Lam, T.Y. Lectures on modules and rings p 319 ex 26	rschwiebert	left Ore domain and left free ideal ring implies left principal ideal domain	\N
460	1	77	\N	\N	\N	80	on	Lam. T.Y. Lectures on modules and rings p 230	rschwiebert	right ACC annihilator implies left DCC annihilator	\N
461	1	80	\N	\N	\N	77	on	Lam. T.Y. Lectures on modules and rings p 230	rschwiebert	left DCC annihilator implies right ACC annihilator	\N
462	1	78	\N	\N	\N	79	on	Lam. T.Y. Lectures on modules and rings p 230	rschwiebert	left ACC annihilator implies right DCC annihilator	\N
463	1	79	\N	\N	\N	78	on	Lam. T.Y. Lectures on modules and rings p 230	rschwiebert	right DCC annihilator implies left ACC annihilator	\N
464	1	33	\N	\N	\N	14	on	obvious	rschwiebert	domain implies reduced	\N
465	1	33	\N	\N	\N	32	on	obvious	rschwiebert	domain implies Baer	\N
467	2	33	65	\N	\N	6	on	obvious	rschwiebert	domain and right cohopfian implies division ring	\N
469	2	104	86	\N	\N	55	on	obvious	rschwiebert	connected and I_0 implies local	\N
470	2	1	132	\N	\N	55	on	obvious	rschwiebert	commutative and top simple implies local	\N
472	1	2	\N	\N	\N	78	on	Lam, T.Y. LMR 229	rschwiebert	right Artinian implies left ACC annihilator	\N
474	1	3	\N	\N	\N	80	on	obvious	rschwiebert	left Artinian implies left DCC annihilator	\N
475	1	71	\N	\N	\N	80	on	\N	rschwiebert	right Goldie implies left DCC annihilator	\N
476	1	72	\N	\N	\N	78	on	\N	rschwiebert	left Goldie implies left ACC annihilator	\N
478	2	1	96	\N	\N	23	off	\N	rschwiebert	commutative and semi free ideal ring implies left Bezout domain	\N
480	2	70	86	\N	\N	57	on	\N	rschwiebert	left finite uniform dimension and I_0 implies semiperfect	\N
482	2	1	33	\N	\N	127	off	\N	rschwiebert	commutative and domain implies left uniform	\N
484	3	1	3	104	\N	55	off	\N	rschwiebert	commutative and left Artinian and connected implies local	\N
486	3	4	82	81	\N	45	off	Lam LMR 409	rschwiebert	right Noetherian and left dual and right dual implies quasi-Frobenius	\N
488	3	50	56	119	\N	46	on	Lam LMR 514	rschwiebert	right self-injective and semilocal and left essential socle implies right pseudo-Frobenius	\N
490	3	58	121	120	\N	45	on	Lam LMR 540	rschwiebert	left perfect and left cogenerator ring and right cogenerator ring implies quasi-Frobenius	\N
492	3	1	54	19	\N	43	off	\N	rschwiebert	commutative and semiprimary and left principal ideal ring implies left serial	\N
494	4	1	55	3	113	45	off	\N	rschwiebert	commutative and local and left Artinian and left simple socle implies quasi-Frobenius	\N
496	4	1	119	113	51	55	off	Lam LMR 538	rschwiebert	commutative and left essential socle and left simple socle and left self-injective implies local	\N
498	1	63	\N	\N	\N	2	on	obvious	rschwiebert	finite implies right Artinian	\N
499	1	63	\N	\N	\N	3	on	obvious	rschwiebert	finite implies left Artinian	\N
501	2	3	41	\N	\N	113	on	obvious	rschwiebert	left Artinian and left valuation ring implies left simple socle	\N
502	1	98	\N	\N	\N	10	on	obvious	rschwiebert	fully prime implies prime	\N
504	1	7	\N	\N	\N	98	on	obvious	rschwiebert	simple implies fully prime	\N
505	1	98	\N	\N	\N	97	on	obvious	rschwiebert	fully prime implies fully semiprime	\N
507	2	33	19	\N	\N	17	on	obvious	rschwiebert	domain and left principal ideal ring implies left principal ideal domain	\N
509	2	96	25	\N	\N	23	on	P.M. Cohn Free ideal rings and localization in general rings p 121	rschwiebert	semi free ideal ring and left Ore domain implies left Bezout domain	\N
511	3	57	109	48	\N	50	on	C.Faith FPF Ring Theory p I.5	rschwiebert	semiperfect and nil radical and right finitely pseudo-Frobenius implies right self-injective	\N
0	1	2	\N	\N	\N	79	on	Lam, T.Y. LMR 229	rschwiebert	right Artinian implies right DCC annihilator	\N
2	1	1	\N	\N	\N	67	on	\N	rschwiebert	commutative implies right duo	\N
4	1	1	\N	\N	\N	100	on	\N	rschwiebert	commutative implies left Ore ring	\N
7	1	4	\N	\N	\N	71	on	\N	rschwiebert	right Noetherian implies right Goldie	\N
9	1	2	\N	\N	\N	4	on	\N	rschwiebert	right Artinian implies right Noetherian	\N
12	1	3	\N	\N	\N	54	on	\N	rschwiebert	left Artinian implies semiprimary	\N
14	1	50	\N	\N	\N	92	on	\N	rschwiebert	right self-injective implies right continuous	\N
16	1	51	\N	\N	\N	93	on	\N	rschwiebert	left self-injective implies left continuous	\N
19	1	135	\N	\N	\N	8	on	Obvious	rschwiebert	simple Artinian implies semisimple	\N
21	1	6	\N	\N	\N	41	on	\N	rschwiebert	division ring implies left valuation ring	\N
23	1	6	\N	\N	\N	16	on	\N	rschwiebert	division ring implies right principal ideal domain	\N
26	1	13	\N	\N	\N	14	on	\N	rschwiebert	strongly regular implies reduced	\N
28	1	13	\N	\N	\N	83	on	\N	rschwiebert	strongly regular implies strongly pi regular	\N
32	1	8	\N	\N	\N	27	on	\N	rschwiebert	semisimple implies left hereditary	\N
35	1	8	\N	\N	\N	19	on	\N	rschwiebert	semisimple implies left principal ideal ring	\N
37	1	8	\N	\N	\N	15	on	\N	rschwiebert	semisimple implies unit regular	\N
40	1	8	\N	\N	\N	44	on	\N	rschwiebert	semisimple implies Frobenius	\N
43	1	41	\N	\N	\N	21	on	\N	rschwiebert	left valuation ring implies left Bezout	\N
45	1	41	\N	\N	\N	55	on	\N	rschwiebert	left valuation ring implies local	\N
47	1	40	\N	\N	\N	42	on	\N	rschwiebert	right valuation ring implies right serial	\N
50	1	37	\N	\N	\N	10	on	\N	rschwiebert	left primitive implies prime	\N
55	1	14	\N	\N	\N	34	on	\N	rschwiebert	reduced implies right nonsingular	\N
57	1	15	\N	\N	\N	66	on	\N	rschwiebert	unit regular implies left cohopfian	\N
60	1	83	\N	\N	\N	84	on	\N	rschwiebert	strongly pi regular implies pi regular	\N
62	1	83	\N	\N	\N	65	on	\N	rschwiebert	strongly pi regular implies right cohopfian	\N
64	1	27	\N	\N	\N	29	on	\N	rschwiebert	left hereditary implies left semihereditary	\N
67	1	32	\N	\N	\N	30	on	\N	rschwiebert	Baer implies right Rickart	\N
69	1	19	\N	\N	\N	5	on	\N	rschwiebert	left principal ideal ring implies left Noetherian	\N
71	1	18	\N	\N	\N	4	on	\N	rschwiebert	right principal ideal ring implies right Noetherian	\N
74	1	44	\N	\N	\N	45	on	\N	rschwiebert	Frobenius implies quasi-Frobenius	\N
77	1	55	\N	\N	\N	57	on	\N	rschwiebert	local implies semiperfect	\N
80	1	9	\N	\N	\N	11	on	\N	rschwiebert	semiprimitive implies semiprime	\N
83	1	12	\N	\N	\N	28	on	\N	rschwiebert	von Neumann regular implies right semihereditary	\N
85	1	12	\N	\N	\N	20	on	\N	rschwiebert	von Neumann regular implies right Bezout	\N
87	1	12	\N	\N	\N	102	on	\N	rschwiebert	von Neumann regular implies right principally injective	\N
90	1	66	\N	\N	\N	61	on	\N	rschwiebert	left cohopfian implies Dedekind finite	\N
92	1	91	\N	\N	\N	62	on	\N	rschwiebert	stable range 1 implies stably finite	\N
95	1	29	\N	\N	\N	31	on	\N	rschwiebert	left semihereditary implies left Rickart	\N
96	1	29	\N	\N	\N	74	on	(Chase's Theorem) Lam, Lectures on Modules and rings pg 146	rschwiebert	left semihereditary implies left coherent	\N
101	1	17	\N	\N	\N	23	on	\N	rschwiebert	left principal ideal domain implies left Bezout domain	\N
104	1	16	\N	\N	\N	22	on	\N	rschwiebert	right principal ideal domain implies right Bezout domain	\N
107	1	45	\N	\N	\N	3	on	\N	rschwiebert	quasi-Frobenius implies left Artinian	\N
110	1	45	\N	\N	\N	46	on	\N	rschwiebert	quasi-Frobenius implies right pseudo-Frobenius	\N
112	1	57	\N	\N	\N	88	on	\N	rschwiebert	semiperfect implies semiregular	\N
115	1	62	\N	\N	\N	61	on	\N	rschwiebert	stably finite implies Dedekind finite	\N
119	1	23	\N	\N	\N	21	on	\N	rschwiebert	left Bezout domain implies left Bezout	\N
122	1	22	\N	\N	\N	20	on	\N	rschwiebert	right Bezout domain implies right Bezout	\N
125	1	47	\N	\N	\N	49	on	\N	rschwiebert	left pseudo-Frobenius implies left finitely pseudo-Frobenius	\N
127	1	47	\N	\N	\N	82	on	\N	rschwiebert	left pseudo-Frobenius implies left dual	\N
129	1	47	\N	\N	\N	57	on	NEEDS CITATION	rschwiebert	left pseudo-Frobenius implies semiperfect	\N
131	1	46	\N	\N	\N	50	on	\N	rschwiebert	right pseudo-Frobenius implies right self-injective	\N
133	1	46	\N	\N	\N	53	on	Lam, T.Y. Lectures on Modules and rings 514	rschwiebert	right pseudo-Frobenius implies left Kasch	\N
138	1	54	\N	\N	\N	58	on	\N	rschwiebert	semiprimary implies left perfect	\N
140	1	4	\N	\N	\N	73	on	\N	rschwiebert	right Noetherian implies right coherent	\N
143	1	82	\N	\N	\N	53	on	\N	rschwiebert	left dual implies left Kasch	\N
145	1	58	\N	\N	\N	57	on	\N	rschwiebert	left perfect implies semiperfect	\N
148	1	72	\N	\N	\N	70	on	\N	rschwiebert	left Goldie implies left finite uniform dimension	\N
150	1	71	\N	\N	\N	69	on	\N	rschwiebert	right Goldie implies right finite uniform dimension	\N
513	2	12	91	\N	\N	15	on	K. Goodearl Von Neumann Regular rings p 41	rschwiebert	von Neumann regular and stable range 1 implies unit regular	\N
515	2	76	21	\N	\N	5	on	obvious	rschwiebert	left ACC principal and left Bezout implies left Noetherian	\N
518	2	55	22	\N	\N	40	on	P.M. Cohn Bezout rings and their subrings	rschwiebert	local and right Bezout domain implies right valuation ring	\N
520	2	104	43	\N	\N	41	on	The ring is directly indecomposable, so only one uniserial factor exists	rschwiebert	connected and left serial implies left valuation ring	\N
521	2	104	42	\N	\N	40	on	The ring is directly indecomposable, so only one uniserial factor exists	rschwiebert	connected and right serial implies right valuation ring	\N
152	1	70	\N	\N	\N	62	on	\N	rschwiebert	left finite uniform dimension implies stably finite	\N
155	1	67	\N	\N	\N	106	on	\N	rschwiebert	right duo implies right quasi-duo	\N
159	1	109	\N	\N	\N	60	on	\N	rschwiebert	nil radical implies lift/rad	\N
161	1	111	\N	\N	\N	109	on	\N	rschwiebert	left T-nilpotent radical implies nil radical	\N
163	1	105	\N	\N	\N	110	on	\N	rschwiebert	nilpotent radical implies right T-nilpotent radical	\N
165	1	59	\N	\N	\N	110	on	\N	rschwiebert	right perfect implies right T-nilpotent radical	\N
167	1	4	\N	\N	\N	75	on	\N	rschwiebert	right Noetherian implies right ACC principal	\N
169	1	69	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	right finite uniform dimension implies orthogonally finite	\N
172	1	75	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	right ACC principal implies orthogonally finite	\N
174	1	79	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	right DCC annihilator implies orthogonally finite	\N
181	1	108	\N	\N	\N	61	on	\N	rschwiebert	orthogonally finite implies Dedekind finite	\N
187	1	112	\N	\N	\N	116	on	Obvious	rschwiebert	right simple socle implies right nonzero socle	\N
190	1	119	\N	\N	\N	117	on	Obvious	rschwiebert	left essential socle implies left nonzero socle	\N
192	1	113	\N	\N	\N	115	on	Obvious	rschwiebert	left simple socle implies left finitely generated socle	\N
194	1	121	\N	\N	\N	53	on	LAM-LMR 510	rschwiebert	left cogenerator ring implies left Kasch	\N
196	1	47	\N	\N	\N	121	on	LAM-LMR 514	rschwiebert	left pseudo-Frobenius implies left cogenerator ring	\N
199	1	46	\N	\N	\N	118	on	LAM-LMR 514	rschwiebert	right pseudo-Frobenius implies right essential socle	\N
205	1	69	\N	\N	\N	114	on	Obvious	rschwiebert	right finite uniform dimension implies right finitely generated socle	\N
209	1	59	\N	\N	\N	119	on	LAM-LMR 540	rschwiebert	right perfect implies left essential socle	\N
213	1	95	\N	\N	\N	96	on	\N	rschwiebert	right free ideal ring implies semi free ideal ring	\N
215	1	16	\N	\N	\N	95	on	Obvious	rschwiebert	right principal ideal domain implies right free ideal ring	\N
517	1	128	\N	\N	\N	61	on	T.Y. Lam Exercises in classical ring theory p 198	rschwiebert	2-primal implies Dedekind finite	6
218	1	94	\N	\N	\N	27	on	Obvious	rschwiebert	left free ideal ring implies left hereditary	\N
220	1	96	\N	\N	\N	29	on	Obvious	rschwiebert	semi free ideal ring implies left semihereditary	\N
223	1	126	\N	\N	\N	69	on	\N	rschwiebert	right uniform implies right finite uniform dimension	\N
225	1	127	\N	\N	\N	70	on	\N	rschwiebert	left uniform implies left finite uniform dimension	\N
228	1	124	\N	\N	\N	101	on	Puninski "Serial Rings" 134	rschwiebert	right distributive implies Abelian	\N
230	2	63	33	\N	\N	1	on	Wedderburn's Little Theorem (Lam, T.Y. First course in noncommutativerings pg 203	rschwiebert	finite and domain implies commutative	\N
234	2	1	12	\N	\N	39	on	\N	rschwiebert	commutative and von Neumann regular implies left V ring	\N
236	2	1	12	\N	\N	97	on	\N	rschwiebert	commutative and von Neumann regular implies fully semiprime	\N
239	2	1	34	\N	\N	14	on	\N	rschwiebert	commutative and right nonsingular implies reduced	\N
241	2	1	11	\N	\N	14	on	\N	rschwiebert	commutative and semiprime implies reduced	\N
243	2	1	10	\N	\N	25	on	\N	rschwiebert	commutative and prime implies left Ore domain	\N
245	2	1	45	\N	\N	44	on	\N	rschwiebert	commutative and quasi-Frobenius implies Frobenius	\N
247	2	1	98	\N	\N	6	on	\N	rschwiebert	commutative and fully prime implies division ring	\N
249	2	1	18	\N	\N	19	on	\N	rschwiebert	commutative and right principal ideal ring implies left principal ideal ring	\N
250	2	1	17	\N	\N	16	on	\N	rschwiebert	commutative and left principal ideal domain implies right principal ideal domain	\N
253	2	1	95	\N	\N	16	on	\N	rschwiebert	commutative and right free ideal ring implies right principal ideal domain	\N
255	2	101	12	\N	\N	13	on	\N	rschwiebert	Abelian and von Neumann regular implies strongly regular	\N
258	2	56	105	\N	\N	54	on	\N	rschwiebert	semilocal and nilpotent radical implies semiprimary	\N
260	2	56	111	\N	\N	58	on	\N	rschwiebert	semilocal and left T-nilpotent radical implies left perfect	\N
262	2	75	20	\N	\N	18	on	\N	rschwiebert	right ACC principal and right Bezout implies right principal ideal ring	\N
264	2	4	50	\N	\N	45	on	\N	rschwiebert	right Noetherian and right self-injective implies quasi-Frobenius	\N
266	2	4	103	\N	\N	66	on	NEEDS CITATION	rschwiebert	right Noetherian and left principally injective implies left cohopfian	\N
268	2	4	102	\N	\N	2	on	NEEDS CITATION	rschwiebert	right Noetherian and right principally injective implies right Artinian	\N
271	2	4	11	\N	\N	34	on	\N	rschwiebert	right Noetherian and semiprime implies right nonsingular	\N
272	2	4	109	\N	\N	105	on	Levitsky's theorem. Lam, T.Y. First course in noncommutative rings p 165	rschwiebert	right Noetherian and nil radical implies nilpotent radical	\N
277	2	5	51	\N	\N	45	on	\N	rschwiebert	left Noetherian and left self-injective implies quasi-Frobenius	\N
279	2	5	102	\N	\N	65	on	NEEDS CITATION	rschwiebert	left Noetherian and right principally injective implies right cohopfian	\N
281	2	5	103	\N	\N	3	on	NEEDS CITATION	rschwiebert	left Noetherian and left principally injective implies left Artinian	\N
284	2	5	11	\N	\N	35	on	\N	rschwiebert	left Noetherian and semiprime implies left nonsingular	\N
286	2	51	27	\N	\N	8	on	\N	rschwiebert	left self-injective and left hereditary implies semisimple	\N
288	2	51	32	\N	\N	12	on	\N	rschwiebert	left self-injective and Baer implies von Neumann regular	\N
291	2	51	37	\N	\N	12	on	\N	rschwiebert	left self-injective and left primitive implies von Neumann regular	\N
293	2	51	38	\N	\N	12	on	\N	rschwiebert	left self-injective and right V ring implies von Neumann regular	\N
295	2	51	56	\N	\N	57	on	\N	rschwiebert	left self-injective and semilocal implies semiperfect	\N
297	2	51	61	\N	\N	91	on	NEEDS CITATION	rschwiebert	left self-injective and Dedekind finite implies stable range 1	\N
299	2	69	86	\N	\N	57	on	NEEDS CITATION	rschwiebert	right finite uniform dimension and I_0 implies semiperfect	\N
301	2	50	51	\N	\N	66	on	NEEDS CITATION	rschwiebert	right self-injective and left self-injective implies left cohopfian	\N
306	2	50	14	\N	\N	13	on	\N	rschwiebert	right self-injective and reduced implies strongly regular	\N
308	2	50	38	\N	\N	12	on	\N	rschwiebert	right self-injective and right V ring implies von Neumann regular	\N
310	2	50	52	\N	\N	46	on	\N	rschwiebert	right self-injective and right Kasch implies right pseudo-Frobenius	\N
312	2	50	69	\N	\N	57	on	\N	rschwiebert	right self-injective and right finite uniform dimension implies semiperfect	\N
314	2	116	33	\N	\N	6	on	Obvious	rschwiebert	right nonzero socle and domain implies division ring	\N
317	2	3	11	\N	\N	8	on	\N	rschwiebert	left Artinian and semiprime implies semisimple	\N
318	2	54	27	\N	\N	26	on	Lam, T.Y. Lectures on modules and rings p 188 (Auslander's Thm)	rschwiebert	semiprimary and left hereditary implies right hereditary	\N
322	2	117	33	\N	\N	6	on	Obvious	rschwiebert	left nonzero socle and domain implies division ring	\N
325	2	2	11	\N	\N	8	on	\N	rschwiebert	right Artinian and semiprime implies semisimple	\N
326	2	54	28	\N	\N	26	on	Lam, T.Y. Lectures on modules and rings p 188 (Auslander's Thm)	rschwiebert	semiprimary and right semihereditary implies right hereditary	\N
330	2	9	55	\N	\N	6	on	\N	rschwiebert	semiprimitive and local implies division ring	\N
333	2	50	52	\N	\N	46	on	LAM-LMR 514	rschwiebert	right self-injective and right Kasch implies right pseudo-Frobenius	\N
334	2	50	122	\N	\N	46	on	LAM-LMR 514	rschwiebert	right self-injective and right finitely cogenerated implies right pseudo-Frobenius	\N
337	2	51	123	\N	\N	47	on	LAM-LMR 514	rschwiebert	left self-injective and left finitely cogenerated implies left pseudo-Frobenius	\N
339	2	114	118	\N	\N	69	on	???	rschwiebert	right finitely generated socle and right essential socle implies right finite uniform dimension	\N
341	2	11	122	\N	\N	8	on	LAM-LMR 538	rschwiebert	semiprime and right finitely cogenerated implies semisimple	\N
343	2	120	104	\N	\N	55	on	LAM-LMR 538	rschwiebert	right cogenerator ring and connected implies local	\N
345	2	121	104	\N	\N	55	on	LAM-LMR 538	rschwiebert	left cogenerator ring and connected implies local	\N
347	2	120	33	\N	\N	6	on	LAM-LMR 538	rschwiebert	right cogenerator ring and domain implies division ring	\N
349	2	11	116	\N	\N	117	on	T.Y. Lam First course in noncommutative rings p 174 Lemma 11.9	rschwiebert	semiprime and right nonzero socle implies left nonzero socle	\N
351	2	10	116	\N	\N	36	on	T.Y. Lam First course in noncommutative rings p 174-175 Lemma 11.11	rschwiebert	prime and right nonzero socle implies right primitive	\N
355	2	4	96	\N	\N	95	on	Obvious	rschwiebert	right Noetherian and semi free ideal ring implies right free ideal ring	\N
358	2	11	71	\N	\N	34	on	Lam-LMR 324	rschwiebert	semiprime and right Goldie implies right nonsingular	\N
360	2	11	72	\N	\N	35	on	Lam-LMR 324	rschwiebert	semiprime and left Goldie implies left nonsingular	\N
363	2	86	109	\N	\N	87	on	Definition	rschwiebert	I_0 and nil radical implies Zorn	\N
364	2	124	34	\N	\N	14	on	Tuganbaev Semidistributive modules and rings 165	rschwiebert	right distributive and right nonsingular implies reduced	\N
367	2	125	14	\N	\N	35	on	Tuganbaev Semidistributive modules and rings 165	rschwiebert	left distributive and reduced implies left nonsingular	\N
370	2	124	10	\N	\N	126	on	Tuganbaev Semidistributive modules and rings 110	rschwiebert	right distributive and prime implies right uniform	\N
374	2	125	59	\N	\N	54	on	Tuganbaev Semidistributive modules and rings 156	rschwiebert	left distributive and right perfect implies semiprimary	\N
377	2	20	106	\N	\N	124	on	Tuganbaev Left and right distributive rings (1995) Theorem 2	rschwiebert	right Bezout and right quasi-duo implies right distributive	\N
380	2	113	119	\N	\N	127	on	\N	rschwiebert	left simple socle and left essential socle implies left uniform	\N
382	3	1	2	104	\N	55	on	\N	rschwiebert	commutative and right Artinian and connected implies local	\N
384	3	5	81	82	\N	45	on	LAM-LMR 409	rschwiebert	left Noetherian and right dual and left dual implies quasi-Frobenius	\N
386	3	51	56	118	\N	47	on	LAM-LMR 514	rschwiebert	left self-injective and semilocal and right essential socle implies left pseudo-Frobenius	\N
388	3	5	121	120	\N	45	on	LAM-LMR 511	rschwiebert	left Noetherian and left cogenerator ring and right cogenerator ring implies quasi-Frobenius	\N
390	3	59	120	121	\N	45	on	LAM-LMR 540	rschwiebert	right perfect and right cogenerator ring and left cogenerator ring implies quasi-Frobenius	\N
391	3	58	120	121	\N	45	on	LAM-LMR 540	rschwiebert	left perfect and right cogenerator ring and left cogenerator ring implies quasi-Frobenius	\N
394	3	1	54	18	\N	42	on	\N	rschwiebert	commutative and semiprimary and right principal ideal ring implies right serial	\N
395	3	11	35	70	\N	72	on	Lam-LMR 324	rschwiebert	semiprime and left nonsingular and left finite uniform dimension implies left Goldie	\N
397	4	1	55	2	45	112	on	\N	rschwiebert	commutative and local and right Artinian and quasi-Frobenius implies right simple socle	\N
399	4	1	118	112	50	120	on	LAM-LMR 538	rschwiebert	commutative and right essential socle and right simple socle and right self-injective implies right cogenerator ring	\N
403	1	67	\N	\N	\N	128	on	Marks, G. Reversible and symmetric rings (2001)	rschwiebert	right duo implies 2-primal	\N
409	1	24	\N	\N	\N	71	on	Lam, T.Y. LMR p 329	rschwiebert	right Ore domain implies right Goldie	\N
412	2	134	60	\N	\N	88	on	Obvious	rschwiebert	top regular and lift/rad implies semiregular	\N
414	2	26	69	\N	\N	4	on	Lam, T.Y. LMR p 266	rschwiebert	right hereditary and right finite uniform dimension implies right Noetherian	\N
416	2	69	33	\N	\N	24	on	Lam, T.Y. LMR p 266	rschwiebert	right finite uniform dimension and domain implies right Ore domain	\N
420	1	93	\N	\N	\N	88	on	Tuganbaev,A.  Semiregular Pi Regular Rings 2.26	rschwiebert	left continuous implies semiregular	\N
424	1	24	\N	\N	\N	99	on	Obvious	rschwiebert	right Ore domain implies right Ore ring	\N
426	1	22	\N	\N	\N	96	on	Right ideals will be free rank 1	rschwiebert	right Bezout domain implies semi free ideal ring	\N
428	2	11	105	\N	\N	9	on	Obvious	rschwiebert	semiprime and nilpotent radical implies semiprimitive	\N
430	1	13	\N	\N	\N	125	on	Tuganbaev Semidistributive Modules and Rings Thm 3.30	rschwiebert	strongly regular implies left distributive	\N
432	2	12	125	\N	\N	13	on	Tuganbaev Semidistributive Modules and Rings Thm 3.30	rschwiebert	von Neumann regular and left distributive implies strongly regular	\N
436	2	63	33	\N	\N	6	on	Wedderburn's Little Theorem (Lam, T.Y. First course in noncommutativerings pg 203	rschwiebert	finite and domain implies division ring	\N
442	1	131	\N	\N	\N	133	on	Obvious	rschwiebert	primary implies top simple Artinian	\N
445	1	133	\N	\N	\N	56	on	Obvious	rschwiebert	top simple Artinian implies semilocal	\N
448	1	12	\N	\N	\N	9	on	\N	rschwiebert	von Neumann regular implies semiprimitive	\N
449	2	69	28	\N	\N	29	on	Lam, T.Y. Lectures on Modules and Rings p 268	rschwiebert	right finite uniform dimension and right semihereditary implies left semihereditary	\N
451	2	70	28	\N	\N	29	on	Lam, T.Y. Lectures on Modules and Rings p 268	rschwiebert	left finite uniform dimension and right semihereditary implies left semihereditary	\N
455	1	131	\N	\N	\N	52	on	Lam, T.Y. Lectures on modules and rings p 189	rschwiebert	primary implies right Kasch	\N
457	2	24	95	\N	\N	16	on	Lam, T.Y. Lectures on modules and rings p 319 ex 26	rschwiebert	right Ore domain and right free ideal ring implies right principal ideal domain	\N
459	3	1	33	26	\N	4	on	commutative hereditary domain=Dedekind domain, which is Noetherian	rschwiebert	commutative and domain and right hereditary implies right Noetherian	\N
466	2	33	83	\N	\N	6	off		rschwiebert	domain and strongly pi regular implies division ring	\N
468	2	33	66	\N	\N	6	on	obvious	rschwiebert	domain and left cohopfian implies division ring	\N
471	1	1	\N	\N	\N	89	on	xy-yx=0	rschwiebert	commutative implies polynomial identity	\N
473	1	80	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	left DCC annihilator implies orthogonally finite	\N
477	1	78	\N	\N	\N	108	on	Lam, T.Y. LMR 229-231	rschwiebert	left ACC annihilator implies orthogonally finite	\N
479	2	1	94	\N	\N	17	off	\N	rschwiebert	commutative and left free ideal ring implies left principal ideal domain	\N
481	2	103	61	\N	\N	66	on	\N	rschwiebert	left principally injective and Dedekind finite implies left cohopfian	\N
483	3	1	3	43	\N	45	off	\N	rschwiebert	commutative and left Artinian and left serial implies quasi-Frobenius	\N
485	3	5	82	81	\N	45	off	Lam LMR 409	rschwiebert	left Noetherian and left dual and right dual implies quasi-Frobenius	\N
487	3	51	56	119	\N	47	on	Lam LMR 514	rschwiebert	left self-injective and semilocal and left essential socle implies left pseudo-Frobenius	\N
489	3	5	121	120	\N	45	off	Lam LMR 511	rschwiebert	left Noetherian and left cogenerator ring and right cogenerator ring implies quasi-Frobenius	\N
491	3	59	121	120	\N	45	on	Lam LMR 540	rschwiebert	right perfect and left cogenerator ring and right cogenerator ring implies quasi-Frobenius	\N
493	3	1	33	27	\N	5	off	\N	rschwiebert	commutative and domain and left hereditary implies left Noetherian	\N
495	4	1	55	3	45	113	off	\N	rschwiebert	commutative and local and left Artinian and quasi-Frobenius implies left simple socle	\N
497	4	1	119	113	51	121	off	Lam LMR 538	rschwiebert	commutative and left essential socle and left simple socle and left self-injective implies left cogenerator ring	\N
500	2	2	40	\N	\N	112	on	obvious	rschwiebert	right Artinian and right valuation ring implies right simple socle	\N
503	1	97	\N	\N	\N	11	on	obvious	rschwiebert	fully semiprime implies semiprime	\N
506	2	33	18	\N	\N	16	on	obvious	rschwiebert	domain and right principal ideal ring implies right principal ideal domain	\N
508	2	96	24	\N	\N	22	on	P.M. Cohn Free ideal rings and localization in general rings p 121	rschwiebert	semi free ideal ring and right Ore domain implies right Bezout domain	\N
510	1	96	\N	\N	\N	33	on	P.M. Cohn Free ideal rings and localization in general rings p 121	rschwiebert	semi free ideal ring implies domain	\N
512	3	57	109	49	\N	51	on	C.Faith FPF Ring Theory p I.5	rschwiebert	semiperfect and nil radical and left finitely pseudo-Frobenius implies left self-injective	\N
514	2	75	20	\N	\N	4	on	obvious	rschwiebert	right ACC principal and right Bezout implies right Noetherian	\N
516	1	101	\N	\N	\N	61	on	ab=1 implies ba is central, so a=aba=baa and 1=ba	rschwiebert	Abelian implies Dedekind finite	\N
519	2	55	23	\N	\N	41	on	P.M. Cohn Bezout rings and their subrings	rschwiebert	local and left Bezout domain implies left valuation ring	\N
523	2	32	51	\N	\N	12	on	T.Y. Lam Lectures on modules and rings p262 Thm 7.52	rschwiebert	Baer and left self-injective implies von Neumann regular	5
522	2	32	50	\N	\N	12	on	T.Y. Lam Lectures on modules and rings p262 Thm 7.52	rschwiebert	Baer and right self-injective implies von Neumann regular	5
304	2	50	32	\N	\N	12	on		rschwiebert	right self-injective and Baer implies von Neumann regular	5
303	2	50	34	\N	\N	12	on		rschwiebert	right self-injective and right nonsingular implies von Neumann regular	5
\.


--
-- Name: logic_logic_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('"logic_logic_ID_seq"', 524, false);


--
-- Name: properties_property_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('"properties_property_ID_seq"', 136, false);


--
-- Data for Name: property_metaproperty; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY property_metaproperty (id, has_metaproperty, note, "ring_ID", type_id, "property_ID", theorem_id) FROM stdin;
1	f	 	49	4	33	\N
2	t		\N	6	14	\N
4	f		52	6	5	\N
3	t		\N	5	5	\N
6	t		\N	1	5	7
7	t		\N	1	4	7
8	t		\N	5	4	\N
9	f		52	6	4	\N
10	t		\N	1	3	7
11	t		\N	5	3	\N
12	f		52	6	3	\N
13	t		\N	1	2	7
14	t		\N	5	2	\N
15	f		52	6	2	\N
16	t		\N	1	9	7
17	t		\N	1	37	7
18	t		\N	1	36	7
19	t		\N	1	8	7
20	f	For n>1, the matrix ring is not commutative	12	1	1	\N
21	f	For n>1, the matrix ring is not commutative	12	2	1	\N
22	t		\N	3	1	8
23	t		\N	5	1	8
24	t		\N	6	1	8
25	t		\N	7	1	8
26	t		\N	8	1	8
27	t		\N	4	1	8
28	t		\N	9	1	8
29	f	Z is connected but this quotient is not.	9	4	104	\N
30	t	This will produce only R or {0}	\N	7	104	8
31	t	This will produce only R or {0}	\N	8	104	8
32	f	F is connected but the matrix ring is not	12	2	104	\N
33	f	The matrix ring is Morita equivalent to the field, but not connected	12	1	104	\N
35	f	This ring is a direct product of fields, but is not connected	9	5	104	\N
36	f	a product of fields, but many idempotents	52	6	104	\N
37	t		\N	3	104	8
38	f	The integers are a non-Artinian subring	2	3	3	\N
\.



--
-- Data for Name: ring_property; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY ring_property (id, "ring_ID", "property_ID", has_property, reason, source, poster, "time") FROM stdin;
1	1	1	1			rschwiebert	\N
2	1	2	0			rschwiebert	\N
3	1	3	0			rschwiebert	\N
4	1	4	1			rschwiebert	\N
5	1	5	1			rschwiebert	\N
6	2	1	1			rschwiebert	\N
7	2	2	1			rschwiebert	\N
8	2	3	1			rschwiebert	\N
9	2	4	1			rschwiebert	\N
10	2	5	1			rschwiebert	\N
11	3	1	1			rschwiebert	\N
12	3	2	1			rschwiebert	\N
13	3	3	1			rschwiebert	\N
14	3	4	1			rschwiebert	\N
15	3	5	1			rschwiebert	\N
16	4	1	1			rschwiebert	\N
17	4	2	1			rschwiebert	\N
18	4	3	1			rschwiebert	\N
19	4	4	1			rschwiebert	\N
20	4	5	1			rschwiebert	\N
21	5	1	0			rschwiebert	\N
22	5	2	1			rschwiebert	\N
23	5	3	1			rschwiebert	\N
24	5	4	1			rschwiebert	\N
25	5	5	1			rschwiebert	\N
26	6	1	1			rschwiebert	\N
27	6	2	0			rschwiebert	\N
28	6	4	1			rschwiebert	\N
29	6	7	0			rschwiebert	\N
30	6	16	0			rschwiebert	\N
31	6	17	0			rschwiebert	\N
32	6	33	1			rschwiebert	\N
33	7	1	1			rschwiebert	\N
34	7	2	0			rschwiebert	\N
35	7	4	1			rschwiebert	\N
36	7	7	0			rschwiebert	\N
37	7	16	1			rschwiebert	\N
38	7	17	1			rschwiebert	\N
39	7	33	1			rschwiebert	\N
40	8	1	1			rschwiebert	\N
41	8	6	1			rschwiebert	\N
42	8	63	1			rschwiebert	\N
43	9	1	1			rschwiebert	\N
44	9	7	0			rschwiebert	\N
45	9	8	1			rschwiebert	\N
46	9	63	1			rschwiebert	\N
47	10	1	1			rschwiebert	\N
48	10	14	0			rschwiebert	\N
49	10	40	1			rschwiebert	\N
50	10	41	1			rschwiebert	\N
51	10	44	1			rschwiebert	\N
52	10	55	1			rschwiebert	\N
53	10	63	1			rschwiebert	\N
54	11	1	0			rschwiebert	\N
55	11	7	1			rschwiebert	\N
56	11	10	1			rschwiebert	\N
57	11	63	1			rschwiebert	\N
58	12	1	0			rschwiebert	\N
59	12	7	1			rschwiebert	\N
60	12	10	1			rschwiebert	\N
61	12	63	0			rschwiebert	\N
62	13	1	0			rschwiebert	\N
63	13	9	0			rschwiebert	\N
64	13	42	1			rschwiebert	\N
65	13	43	1			rschwiebert	\N
66	13	63	1			rschwiebert	\N
67	14	1	0			rschwiebert	\N
68	14	2	1			rschwiebert	\N
69	14	3	1			rschwiebert	\N
70	14	9	0			rschwiebert	\N
71	14	40	0			rschwiebert	\N
72	14	41	0			rschwiebert	\N
73	14	42	1			rschwiebert	\N
74	14	43	1			rschwiebert	\N
75	14	63	0			rschwiebert	\N
76	15	1	0			rschwiebert	\N
77	15	2	0			rschwiebert	\N
78	15	3	0			rschwiebert	\N
79	15	4	0			rschwiebert	\N
80	15	5	0			rschwiebert	\N
81	15	6	0			rschwiebert	\N
82	15	7	0			rschwiebert	\N
83	15	8	0			rschwiebert	\N
84	15	9	1			rschwiebert	\N
85	15	10	1			rschwiebert	\N
86	15	11	1			rschwiebert	\N
87	15	12	1			rschwiebert	\N
88	15	13	0			rschwiebert	\N
89	15	14	0			rschwiebert	\N
90	15	15	0			rschwiebert	\N
91	15	16	0			rschwiebert	\N
92	15	17	0			rschwiebert	\N
93	15	18	0			rschwiebert	\N
94	15	19	0			rschwiebert	\N
95	15	20	1			rschwiebert	\N
96	15	21	1			rschwiebert	\N
97	15	22	0			rschwiebert	\N
98	15	23	0			rschwiebert	\N
99	15	24	0			rschwiebert	\N
100	15	25	0			rschwiebert	\N
101	15	28	1			rschwiebert	\N
102	15	29	1			rschwiebert	\N
103	15	30	1			rschwiebert	\N
104	15	31	1			rschwiebert	\N
105	15	33	0			rschwiebert	\N
106	15	34	1			rschwiebert	\N
107	15	35	1			rschwiebert	\N
108	15	37	1			rschwiebert	\N
109	15	39	0			rschwiebert	\N
110	15	40	0			rschwiebert	\N
111	15	41	0			rschwiebert	\N
112	15	42	0			rschwiebert	\N
113	15	43	0			rschwiebert	\N
114	15	44	0			rschwiebert	\N
115	15	45	0			rschwiebert	\N
116	15	47	0			rschwiebert	\N
117	15	50	1			rschwiebert	\N
118	15	51	0			rschwiebert	\N
119	15	52	0			rschwiebert	\N
120	15	53	0			rschwiebert	\N
121	15	54	0			rschwiebert	\N
122	15	55	0			rschwiebert	\N
123	15	56	0			rschwiebert	\N
124	15	57	0			rschwiebert	\N
125	15	58	0			rschwiebert	\N
126	15	59	0			rschwiebert	\N
127	15	60	1			rschwiebert	\N
128	15	61	0			rschwiebert	\N
129	15	62	0			rschwiebert	\N
130	15	63	0			rschwiebert	\N
131	15	64	0			rschwiebert	\N
132	15	65	0			rschwiebert	\N
133	15	66	0			rschwiebert	\N
134	15	67	0			rschwiebert	\N
135	15	68	0			rschwiebert	\N
136	15	69	0			rschwiebert	\N
137	15	70	0			rschwiebert	\N
138	15	71	0			rschwiebert	\N
139	15	72	0			rschwiebert	\N
140	15	73	1			rschwiebert	\N
141	15	74	1			rschwiebert	\N
142	15	75	0			rschwiebert	\N
143	15	76	0			rschwiebert	\N
144	15	84	1			rschwiebert	\N
145	15	86	1			rschwiebert	\N
146	15	87	1			rschwiebert	\N
147	15	88	1			rschwiebert	\N
148	15	97	1			rschwiebert	\N
149	15	98	1			rschwiebert	\N
150	15	101	0			rschwiebert	\N
151	15	102	1			rschwiebert	\N
152	15	103	1			rschwiebert	\N
153	15	104	0			rschwiebert	\N
154	15	105	1			rschwiebert	\N
155	15	106	0			rschwiebert	\N
156	15	107	0			rschwiebert	\N
157	15	108	0			rschwiebert	\N
158	15	109	1			rschwiebert	\N
159	15	110	1			rschwiebert	\N
160	15	111	1			rschwiebert	\N
161	15	112	0			rschwiebert	\N
162	15	113	0			rschwiebert	\N
163	17	1	1			rschwiebert	\N
164	17	6	1			rschwiebert	\N
165	18	1	1			rschwiebert	\N
166	18	6	1			rschwiebert	\N
167	22	1	0		xy is not 0 but yx=0	rschwiebert	\N
168	22	4	0		Lam FCNR 21	rschwiebert	\N
169	22	5	1		Lam FCNR 21	rschwiebert	\N
170	22	54	0		Radical is Z[x]y, but R/J(R)=Z[x] is not Artinian	rschwiebert	\N
171	22	105	1		Radical is Z[x]y, which has square zero.	rschwiebert	\N
172	24	2	1		13-dimensional k-algebra	rschwiebert	\N
173	24	3	1		13-dimensional k-algebra	rschwiebert	\N
174	24	55	1		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
175	24	67	0		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
176	24	68	0		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
177	24	129	1		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
178	24	130	0		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
179	25	8	0		By Maschke's theorem, not semisimple	rschwiebert	\N
180	25	63	1		obvious	rschwiebert	\N
181	25	67	1		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
182	25	68	1		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
183	25	129	1		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
184	25	130	0		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
185	26	128	1		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
186	26	130	0		Marks, G. Reversible and Symmetric rings (2001)	rschwiebert	\N
187	27	1	1		obvious	rschwiebert	\N
188	27	16	1		Ideals are of the form (x^i)	rschwiebert	\N
189	27	17	1		Ideals are of the form (x^i)	rschwiebert	\N
190	27	55	1		unique maximal ideal (x)	rschwiebert	\N
191	27	109	0		Domains do not have nonzero nil ideals, and (x) is nonzero.	rschwiebert	\N
192	28	2	0		Lam, T.Y. FCINR 42	rschwiebert	\N
193	28	3	0		Lam, T.Y. FCINR 42	rschwiebert	\N
194	28	7	1		Lam, T.Y. FCINR 42	rschwiebert	\N
195	29	1	0		Obvious	rschwiebert	\N
196	29	9	0		Lam, T.Y. Lectures on modules and rings p 80. rad(R) is [[B,B][0,B]]	rschwiebert	\N
197	29	34	0		Lam, T.Y. Lectures on modules and rings p 248. Both singular ideals equal to rad(R)	rschwiebert	\N
198	29	35	0		Lam, T.Y. Lectures on modules and rings p 248. Both singular ideals equal to rad(R)	rschwiebert	\N
199	29	52	1		Lam, T.Y. Lectures on modules and rings p 285. 	rschwiebert	\N
200	29	53	1		Lam, T.Y. Lectures on modules and rings p 285. 	rschwiebert	\N
201	29	63	1		Has 32 elements	rschwiebert	\N
202	30	1	0		obvious	rschwiebert	\N
203	30	4	1		Lam, T.Y. Lectures on modules and rings pg 248	rschwiebert	\N
204	30	5	1		Lam, T.Y. Lectures on modules and rings pg 248	rschwiebert	\N
205	30	34	1		Lam, T.Y. Lectures on modules and rings pg 248	rschwiebert	\N
206	30	35	0		Lam, T.Y. Lectures on modules and rings pg 248	rschwiebert	\N
207	31	33	0		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
208	31	34	0		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
209	31	35	0		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
210	31	36	1		Chatters & Hajarnavis Rings With Chain Conditions p 27-30	rschwiebert	\N
211	31	37	1		Chatters & Hajarnavis Rings With Chain Conditions p 27-30	rschwiebert	\N
212	31	69	1		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
213	31	70	1		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
214	31	71	0		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
215	31	72	0		Lam, T.Y. Lectures on modules and rings p 330	rschwiebert	\N
216	33	1	1		subring of C	rschwiebert	\N
217	33	4	0		The sequence of ideals (2^(1/2^n)) does not stabilize	rschwiebert	\N
218	33	5	0		The sequence of ideals (2^(1/2^n)) does not stabilize	rschwiebert	\N
219	33	22	1		Wikipedia	rschwiebert	\N
220	33	23	1		Wikipedia	rschwiebert	\N
221	34	1	1		subring of C	rschwiebert	\N
222	34	16	1		Has a Dedekind-Hasse norm that allows you to prove this	rschwiebert	\N
223	34	17	1		Has a Dedekind-Hasse norm that allows you to prove this	rschwiebert	\N
224	35	1	0		commutative rings are stably finite, which this ring is not	rschwiebert	\N
225	35	33	1		Lam, T.Y. Lectures on modules and rings p 19 ex 18.	rschwiebert	\N
226	35	61	1		It is a domain	rschwiebert	\N
227	35	62	0		The matrices A and B satisfy AB=I_2 but BA=/=I_2	rschwiebert	\N
228	36	1	1		Obvious	rschwiebert	\N
229	36	4	0		This ring does not even satisfy ACC on principal ideals	rschwiebert	\N
1512	1	78	1	symmetry		SymmScript	\N
230	36	5	0		This ring does not even satisfy ACC on principal ideals	rschwiebert	\N
231	36	16	0		This ring isn't Noetherian	rschwiebert	\N
232	36	17	0		This ring isn't Noetherian	rschwiebert	\N
233	36	24	1		Is a commutative domain	rschwiebert	\N
234	36	25	1		Is a commutative domain	rschwiebert	\N
235	36	75	0		(x)<(x/2)<(x/4)<...<(x/2^n)<... is a strictly ascending chain.	rschwiebert	\N
236	36	76	0		(x)<(x/2)<(x/4)<...<(x/2^n)<... is a strictly ascending chain.	rschwiebert	\N
237	6	3	0	symmetry		SymmScript	\N
238	6	5	1	symmetry		SymmScript	\N
239	2	79	1	logic_id 0		FwdLogicScript	\N
240	3	79	1	logic_id 0		FwdLogicScript	\N
241	4	79	1	logic_id 0		FwdLogicScript	\N
242	5	79	1	logic_id 0		FwdLogicScript	\N
243	14	79	1	logic_id 0		FwdLogicScript	\N
244	24	79	1	logic_id 0		FwdLogicScript	\N
245	1	62	1	logic_id 1		FwdLogicScript	\N
246	2	62	1	logic_id 1		FwdLogicScript	\N
247	3	62	1	logic_id 1		FwdLogicScript	\N
248	4	62	1	logic_id 1		FwdLogicScript	\N
249	6	62	1	logic_id 1		FwdLogicScript	\N
250	7	62	1	logic_id 1		FwdLogicScript	\N
251	8	62	1	logic_id 1		FwdLogicScript	\N
252	9	62	1	logic_id 1		FwdLogicScript	\N
253	10	62	1	logic_id 1		FwdLogicScript	\N
254	17	62	1	logic_id 1		FwdLogicScript	\N
255	18	62	1	logic_id 1		FwdLogicScript	\N
256	27	62	1	logic_id 1		FwdLogicScript	\N
257	33	62	1	logic_id 1		FwdLogicScript	\N
258	34	62	1	logic_id 1		FwdLogicScript	\N
259	36	62	1	logic_id 1		FwdLogicScript	\N
260	1	67	1	logic_id 2		FwdLogicScript	\N
261	2	67	1	logic_id 2		FwdLogicScript	\N
262	3	67	1	logic_id 2		FwdLogicScript	\N
263	4	67	1	logic_id 2		FwdLogicScript	\N
264	6	67	1	logic_id 2		FwdLogicScript	\N
265	7	67	1	logic_id 2		FwdLogicScript	\N
266	8	67	1	logic_id 2		FwdLogicScript	\N
267	9	67	1	logic_id 2		FwdLogicScript	\N
268	10	67	1	logic_id 2		FwdLogicScript	\N
269	17	67	1	logic_id 2		FwdLogicScript	\N
270	18	67	1	logic_id 2		FwdLogicScript	\N
271	27	67	1	logic_id 2		FwdLogicScript	\N
272	33	67	1	logic_id 2		FwdLogicScript	\N
273	34	67	1	logic_id 2		FwdLogicScript	\N
274	36	67	1	logic_id 2		FwdLogicScript	\N
275	1	68	1	logic_id 3		FwdLogicScript	\N
276	2	68	1	logic_id 3		FwdLogicScript	\N
277	3	68	1	logic_id 3		FwdLogicScript	\N
278	4	68	1	logic_id 3		FwdLogicScript	\N
279	6	68	1	logic_id 3		FwdLogicScript	\N
280	7	68	1	logic_id 3		FwdLogicScript	\N
281	8	68	1	logic_id 3		FwdLogicScript	\N
282	9	68	1	logic_id 3		FwdLogicScript	\N
283	10	68	1	logic_id 3		FwdLogicScript	\N
284	17	68	1	logic_id 3		FwdLogicScript	\N
285	18	68	1	logic_id 3		FwdLogicScript	\N
286	27	68	1	logic_id 3		FwdLogicScript	\N
287	33	68	1	logic_id 3		FwdLogicScript	\N
288	34	68	1	logic_id 3		FwdLogicScript	\N
289	36	68	1	logic_id 3		FwdLogicScript	\N
290	1	100	1	logic_id 4		FwdLogicScript	\N
291	2	100	1	logic_id 4		FwdLogicScript	\N
292	3	100	1	logic_id 4		FwdLogicScript	\N
293	4	100	1	logic_id 4		FwdLogicScript	\N
294	6	100	1	logic_id 4		FwdLogicScript	\N
295	7	100	1	logic_id 4		FwdLogicScript	\N
296	8	100	1	logic_id 4		FwdLogicScript	\N
297	9	100	1	logic_id 4		FwdLogicScript	\N
298	10	100	1	logic_id 4		FwdLogicScript	\N
299	17	100	1	logic_id 4		FwdLogicScript	\N
300	18	100	1	logic_id 4		FwdLogicScript	\N
301	27	100	1	logic_id 4		FwdLogicScript	\N
302	33	100	1	logic_id 4		FwdLogicScript	\N
303	34	100	1	logic_id 4		FwdLogicScript	\N
304	36	100	1	logic_id 4		FwdLogicScript	\N
305	1	99	1	logic_id 5		FwdLogicScript	\N
306	2	99	1	logic_id 5		FwdLogicScript	\N
307	3	99	1	logic_id 5		FwdLogicScript	\N
308	4	99	1	logic_id 5		FwdLogicScript	\N
309	6	99	1	logic_id 5		FwdLogicScript	\N
310	7	99	1	logic_id 5		FwdLogicScript	\N
311	8	99	1	logic_id 5		FwdLogicScript	\N
312	9	99	1	logic_id 5		FwdLogicScript	\N
313	10	99	1	logic_id 5		FwdLogicScript	\N
314	17	99	1	logic_id 5		FwdLogicScript	\N
315	18	99	1	logic_id 5		FwdLogicScript	\N
316	27	99	1	logic_id 5		FwdLogicScript	\N
317	33	99	1	logic_id 5		FwdLogicScript	\N
318	34	99	1	logic_id 5		FwdLogicScript	\N
319	36	99	1	logic_id 5		FwdLogicScript	\N
320	1	101	1	logic_id 6		FwdLogicScript	\N
321	2	101	1	logic_id 6		FwdLogicScript	\N
322	3	101	1	logic_id 6		FwdLogicScript	\N
323	4	101	1	logic_id 6		FwdLogicScript	\N
324	6	101	1	logic_id 6		FwdLogicScript	\N
325	7	101	1	logic_id 6		FwdLogicScript	\N
326	8	101	1	logic_id 6		FwdLogicScript	\N
327	9	101	1	logic_id 6		FwdLogicScript	\N
328	10	101	1	logic_id 6		FwdLogicScript	\N
329	17	101	1	logic_id 6		FwdLogicScript	\N
330	18	101	1	logic_id 6		FwdLogicScript	\N
331	27	101	1	logic_id 6		FwdLogicScript	\N
332	33	101	1	logic_id 6		FwdLogicScript	\N
333	34	101	1	logic_id 6		FwdLogicScript	\N
334	36	101	1	logic_id 6		FwdLogicScript	\N
335	1	71	1	logic_id 7		FwdLogicScript	\N
336	2	71	1	logic_id 7		FwdLogicScript	\N
337	3	71	1	logic_id 7		FwdLogicScript	\N
338	4	71	1	logic_id 7		FwdLogicScript	\N
339	5	71	1	logic_id 7		FwdLogicScript	\N
340	6	71	1	logic_id 7		FwdLogicScript	\N
341	7	71	1	logic_id 7		FwdLogicScript	\N
342	30	71	1	logic_id 7		FwdLogicScript	\N
343	1	72	1	logic_id 8		FwdLogicScript	\N
344	2	72	1	logic_id 8		FwdLogicScript	\N
345	3	72	1	logic_id 8		FwdLogicScript	\N
346	4	72	1	logic_id 8		FwdLogicScript	\N
347	5	72	1	logic_id 8		FwdLogicScript	\N
348	6	72	1	logic_id 8		FwdLogicScript	\N
349	22	72	1	logic_id 8		FwdLogicScript	\N
350	30	72	1	logic_id 8		FwdLogicScript	\N
351	14	4	1	logic_id 9		FwdLogicScript	\N
352	24	4	1	logic_id 9		FwdLogicScript	\N
353	2	54	1	logic_id 10		FwdLogicScript	\N
354	3	54	1	logic_id 10		FwdLogicScript	\N
355	4	54	1	logic_id 10		FwdLogicScript	\N
356	5	54	1	logic_id 10		FwdLogicScript	\N
357	14	54	1	logic_id 10		FwdLogicScript	\N
358	24	54	1	logic_id 10		FwdLogicScript	\N
359	14	5	1	logic_id 11		FwdLogicScript	\N
360	24	5	1	logic_id 11		FwdLogicScript	\N
361	15	92	1	logic_id 14		FwdLogicScript	\N
362	8	135	1	logic_id 17		FwdLogicScript	\N
363	17	135	1	logic_id 17		FwdLogicScript	\N
364	18	135	1	logic_id 17		FwdLogicScript	\N
365	8	13	1	logic_id 18		FwdLogicScript	\N
366	17	13	1	logic_id 18		FwdLogicScript	\N
367	18	13	1	logic_id 18		FwdLogicScript	\N
368	8	8	1	logic_id 19		FwdLogicScript	\N
369	17	8	1	logic_id 19		FwdLogicScript	\N
370	18	8	1	logic_id 19		FwdLogicScript	\N
371	8	40	1	logic_id 20		FwdLogicScript	\N
372	17	40	1	logic_id 20		FwdLogicScript	\N
373	18	40	1	logic_id 20		FwdLogicScript	\N
374	8	41	1	logic_id 21		FwdLogicScript	\N
375	17	41	1	logic_id 21		FwdLogicScript	\N
376	18	41	1	logic_id 21		FwdLogicScript	\N
377	8	17	1	logic_id 22		FwdLogicScript	\N
378	17	17	1	logic_id 22		FwdLogicScript	\N
379	18	17	1	logic_id 22		FwdLogicScript	\N
380	8	16	1	logic_id 23		FwdLogicScript	\N
381	17	16	1	logic_id 23		FwdLogicScript	\N
382	18	16	1	logic_id 23		FwdLogicScript	\N
383	11	37	1	logic_id 24		FwdLogicScript	\N
384	12	37	1	logic_id 24		FwdLogicScript	\N
385	28	37	1	logic_id 24		FwdLogicScript	\N
386	11	36	1	logic_id 25		FwdLogicScript	\N
387	12	36	1	logic_id 25		FwdLogicScript	\N
388	28	36	1	logic_id 25		FwdLogicScript	\N
389	8	14	1	logic_id 26		FwdLogicScript	\N
390	17	14	1	logic_id 26		FwdLogicScript	\N
391	18	14	1	logic_id 26		FwdLogicScript	\N
392	8	15	1	logic_id 27		FwdLogicScript	\N
393	17	15	1	logic_id 27		FwdLogicScript	\N
394	18	15	1	logic_id 27		FwdLogicScript	\N
395	8	83	1	logic_id 28		FwdLogicScript	\N
396	17	83	1	logic_id 28		FwdLogicScript	\N
397	18	83	1	logic_id 28		FwdLogicScript	\N
398	8	27	1	logic_id 32		FwdLogicScript	\N
399	9	27	1	logic_id 32		FwdLogicScript	\N
400	17	27	1	logic_id 32		FwdLogicScript	\N
401	18	27	1	logic_id 32		FwdLogicScript	\N
402	8	26	1	logic_id 33		FwdLogicScript	\N
403	9	26	1	logic_id 33		FwdLogicScript	\N
404	17	26	1	logic_id 33		FwdLogicScript	\N
405	18	26	1	logic_id 33		FwdLogicScript	\N
406	8	32	1	logic_id 34		FwdLogicScript	\N
407	9	32	1	logic_id 34		FwdLogicScript	\N
408	17	32	1	logic_id 34		FwdLogicScript	\N
409	18	32	1	logic_id 34		FwdLogicScript	\N
410	8	19	1	logic_id 35		FwdLogicScript	\N
411	9	19	1	logic_id 35		FwdLogicScript	\N
412	17	19	1	logic_id 35		FwdLogicScript	\N
413	18	19	1	logic_id 35		FwdLogicScript	\N
414	8	18	1	logic_id 36		FwdLogicScript	\N
415	9	18	1	logic_id 36		FwdLogicScript	\N
416	17	18	1	logic_id 36		FwdLogicScript	\N
417	18	18	1	logic_id 36		FwdLogicScript	\N
418	9	15	1	logic_id 37		FwdLogicScript	\N
419	8	39	1	logic_id 38		FwdLogicScript	\N
420	9	39	1	logic_id 38		FwdLogicScript	\N
421	17	39	1	logic_id 38		FwdLogicScript	\N
422	18	39	1	logic_id 38		FwdLogicScript	\N
423	8	38	1	logic_id 39		FwdLogicScript	\N
424	9	38	1	logic_id 39		FwdLogicScript	\N
425	17	38	1	logic_id 39		FwdLogicScript	\N
426	18	38	1	logic_id 39		FwdLogicScript	\N
427	8	44	1	logic_id 40		FwdLogicScript	\N
428	9	44	1	logic_id 40		FwdLogicScript	\N
429	17	44	1	logic_id 40		FwdLogicScript	\N
430	18	44	1	logic_id 40		FwdLogicScript	\N
431	8	43	1	logic_id 41		FwdLogicScript	\N
432	9	43	1	logic_id 41		FwdLogicScript	\N
433	17	43	1	logic_id 41		FwdLogicScript	\N
434	18	43	1	logic_id 41		FwdLogicScript	\N
435	8	42	1	logic_id 42		FwdLogicScript	\N
436	9	42	1	logic_id 42		FwdLogicScript	\N
437	17	42	1	logic_id 42		FwdLogicScript	\N
438	18	42	1	logic_id 42		FwdLogicScript	\N
439	8	21	1	logic_id 43		FwdLogicScript	\N
440	10	21	1	logic_id 43		FwdLogicScript	\N
441	17	21	1	logic_id 43		FwdLogicScript	\N
442	18	21	1	logic_id 43		FwdLogicScript	\N
443	10	43	1	logic_id 44		FwdLogicScript	\N
444	8	55	1	logic_id 45		FwdLogicScript	\N
445	17	55	1	logic_id 45		FwdLogicScript	\N
446	18	55	1	logic_id 45		FwdLogicScript	\N
447	8	20	1	logic_id 46		FwdLogicScript	\N
448	10	20	1	logic_id 46		FwdLogicScript	\N
449	17	20	1	logic_id 46		FwdLogicScript	\N
450	18	20	1	logic_id 46		FwdLogicScript	\N
451	10	42	1	logic_id 47		FwdLogicScript	\N
452	11	9	1	logic_id 49		FwdLogicScript	\N
453	12	9	1	logic_id 49		FwdLogicScript	\N
454	28	9	1	logic_id 49		FwdLogicScript	\N
455	31	9	1	logic_id 49		FwdLogicScript	\N
456	28	10	1	logic_id 50		FwdLogicScript	\N
457	31	10	1	logic_id 50		FwdLogicScript	\N
458	8	11	1	logic_id 53		FwdLogicScript	\N
459	17	11	1	logic_id 53		FwdLogicScript	\N
460	18	11	1	logic_id 53		FwdLogicScript	\N
461	8	35	1	logic_id 54		FwdLogicScript	\N
462	17	35	1	logic_id 54		FwdLogicScript	\N
463	18	35	1	logic_id 54		FwdLogicScript	\N
464	8	34	1	logic_id 55		FwdLogicScript	\N
465	17	34	1	logic_id 55		FwdLogicScript	\N
466	18	34	1	logic_id 55		FwdLogicScript	\N
467	8	12	1	logic_id 56		FwdLogicScript	\N
468	9	12	1	logic_id 56		FwdLogicScript	\N
469	17	12	1	logic_id 56		FwdLogicScript	\N
470	18	12	1	logic_id 56		FwdLogicScript	\N
471	8	66	1	logic_id 57		FwdLogicScript	\N
472	9	66	1	logic_id 57		FwdLogicScript	\N
473	17	66	1	logic_id 57		FwdLogicScript	\N
474	18	66	1	logic_id 57		FwdLogicScript	\N
475	8	65	1	logic_id 58		FwdLogicScript	\N
476	9	65	1	logic_id 58		FwdLogicScript	\N
477	17	65	1	logic_id 58		FwdLogicScript	\N
478	18	65	1	logic_id 58		FwdLogicScript	\N
479	8	91	1	logic_id 59		FwdLogicScript	\N
480	9	91	1	logic_id 59		FwdLogicScript	\N
481	17	91	1	logic_id 59		FwdLogicScript	\N
482	18	91	1	logic_id 59		FwdLogicScript	\N
483	8	84	1	logic_id 60		FwdLogicScript	\N
484	17	84	1	logic_id 60		FwdLogicScript	\N
485	18	84	1	logic_id 60		FwdLogicScript	\N
486	8	29	1	logic_id 64		FwdLogicScript	\N
487	9	29	1	logic_id 64		FwdLogicScript	\N
488	17	29	1	logic_id 64		FwdLogicScript	\N
489	18	29	1	logic_id 64		FwdLogicScript	\N
490	8	28	1	logic_id 65		FwdLogicScript	\N
491	9	28	1	logic_id 65		FwdLogicScript	\N
492	17	28	1	logic_id 65		FwdLogicScript	\N
493	18	28	1	logic_id 65		FwdLogicScript	\N
494	8	31	1	logic_id 66		FwdLogicScript	\N
495	9	31	1	logic_id 66		FwdLogicScript	\N
496	17	31	1	logic_id 66		FwdLogicScript	\N
497	18	31	1	logic_id 66		FwdLogicScript	\N
498	8	30	1	logic_id 67		FwdLogicScript	\N
499	9	30	1	logic_id 67		FwdLogicScript	\N
500	17	30	1	logic_id 67		FwdLogicScript	\N
501	18	30	1	logic_id 67		FwdLogicScript	\N
502	9	21	1	logic_id 68		FwdLogicScript	\N
503	8	5	1	logic_id 69		FwdLogicScript	\N
504	9	5	1	logic_id 69		FwdLogicScript	\N
505	17	5	1	logic_id 69		FwdLogicScript	\N
506	18	5	1	logic_id 69		FwdLogicScript	\N
507	9	20	1	logic_id 70		FwdLogicScript	\N
508	8	4	1	logic_id 71		FwdLogicScript	\N
509	9	4	1	logic_id 71		FwdLogicScript	\N
510	17	4	1	logic_id 71		FwdLogicScript	\N
511	18	4	1	logic_id 71		FwdLogicScript	\N
512	8	9	1	logic_id 72		FwdLogicScript	\N
513	9	9	1	logic_id 72		FwdLogicScript	\N
514	17	9	1	logic_id 72		FwdLogicScript	\N
515	18	9	1	logic_id 72		FwdLogicScript	\N
516	8	45	1	logic_id 74		FwdLogicScript	\N
517	9	45	1	logic_id 74		FwdLogicScript	\N
518	10	45	1	logic_id 74		FwdLogicScript	\N
519	17	45	1	logic_id 74		FwdLogicScript	\N
520	18	45	1	logic_id 74		FwdLogicScript	\N
521	8	57	1	logic_id 75		FwdLogicScript	\N
522	9	57	1	logic_id 75		FwdLogicScript	\N
523	10	57	1	logic_id 75		FwdLogicScript	\N
524	13	57	1	logic_id 75		FwdLogicScript	\N
525	14	57	1	logic_id 75		FwdLogicScript	\N
526	17	57	1	logic_id 75		FwdLogicScript	\N
527	18	57	1	logic_id 75		FwdLogicScript	\N
528	24	57	1	logic_id 77		FwdLogicScript	\N
529	27	57	1	logic_id 77		FwdLogicScript	\N
530	8	107	1	logic_id 78		FwdLogicScript	\N
531	10	107	1	logic_id 78		FwdLogicScript	\N
532	17	107	1	logic_id 78		FwdLogicScript	\N
533	18	107	1	logic_id 78		FwdLogicScript	\N
534	24	107	1	logic_id 78		FwdLogicScript	\N
535	27	107	1	logic_id 78		FwdLogicScript	\N
536	8	106	1	logic_id 79		FwdLogicScript	\N
537	10	106	1	logic_id 79		FwdLogicScript	\N
538	17	106	1	logic_id 79		FwdLogicScript	\N
539	18	106	1	logic_id 79		FwdLogicScript	\N
540	24	106	1	logic_id 79		FwdLogicScript	\N
541	27	106	1	logic_id 79		FwdLogicScript	\N
542	9	11	1	logic_id 80		FwdLogicScript	\N
543	11	11	1	logic_id 80		FwdLogicScript	\N
544	12	11	1	logic_id 80		FwdLogicScript	\N
545	28	11	1	logic_id 80		FwdLogicScript	\N
546	31	11	1	logic_id 80		FwdLogicScript	\N
547	8	103	1	logic_id 86		FwdLogicScript	\N
548	9	103	1	logic_id 86		FwdLogicScript	\N
549	17	103	1	logic_id 86		FwdLogicScript	\N
550	18	103	1	logic_id 86		FwdLogicScript	\N
551	8	102	1	logic_id 87		FwdLogicScript	\N
552	9	102	1	logic_id 87		FwdLogicScript	\N
553	17	102	1	logic_id 87		FwdLogicScript	\N
554	18	102	1	logic_id 87		FwdLogicScript	\N
555	8	90	1	logic_id 88		FwdLogicScript	\N
556	9	90	1	logic_id 88		FwdLogicScript	\N
557	15	90	1	logic_id 88		FwdLogicScript	\N
558	17	90	1	logic_id 88		FwdLogicScript	\N
559	18	90	1	logic_id 88		FwdLogicScript	\N
560	9	84	1	logic_id 89		FwdLogicScript	\N
561	8	61	1	logic_id 90		FwdLogicScript	\N
562	9	61	1	logic_id 90		FwdLogicScript	\N
563	17	61	1	logic_id 90		FwdLogicScript	\N
564	18	61	1	logic_id 90		FwdLogicScript	\N
565	8	85	1	logic_id 93		FwdLogicScript	\N
566	9	85	1	logic_id 93		FwdLogicScript	\N
567	15	85	1	logic_id 93		FwdLogicScript	\N
568	17	85	1	logic_id 93		FwdLogicScript	\N
569	18	85	1	logic_id 93		FwdLogicScript	\N
570	8	87	1	logic_id 94		FwdLogicScript	\N
571	9	87	1	logic_id 94		FwdLogicScript	\N
572	17	87	1	logic_id 94		FwdLogicScript	\N
573	18	87	1	logic_id 94		FwdLogicScript	\N
574	8	74	1	logic_id 96		FwdLogicScript	\N
575	9	74	1	logic_id 96		FwdLogicScript	\N
576	17	74	1	logic_id 96		FwdLogicScript	\N
577	18	74	1	logic_id 96		FwdLogicScript	\N
578	8	73	1	logic_id 98		FwdLogicScript	\N
579	9	73	1	logic_id 98		FwdLogicScript	\N
580	17	73	1	logic_id 98		FwdLogicScript	\N
581	18	73	1	logic_id 98		FwdLogicScript	\N
582	9	35	1	logic_id 99		FwdLogicScript	\N
583	9	34	1	logic_id 100		FwdLogicScript	\N
584	7	23	1	logic_id 101		FwdLogicScript	\N
585	8	23	1	logic_id 101		FwdLogicScript	\N
586	17	23	1	logic_id 101		FwdLogicScript	\N
587	18	23	1	logic_id 101		FwdLogicScript	\N
588	27	23	1	logic_id 101		FwdLogicScript	\N
589	34	23	1	logic_id 101		FwdLogicScript	\N
590	7	19	1	logic_id 103		FwdLogicScript	\N
591	27	19	1	logic_id 103		FwdLogicScript	\N
592	34	19	1	logic_id 103		FwdLogicScript	\N
593	7	22	1	logic_id 104		FwdLogicScript	\N
594	8	22	1	logic_id 104		FwdLogicScript	\N
595	17	22	1	logic_id 104		FwdLogicScript	\N
596	18	22	1	logic_id 104		FwdLogicScript	\N
597	27	22	1	logic_id 104		FwdLogicScript	\N
598	34	22	1	logic_id 104		FwdLogicScript	\N
599	7	18	1	logic_id 106		FwdLogicScript	\N
600	27	18	1	logic_id 106		FwdLogicScript	\N
601	34	18	1	logic_id 106		FwdLogicScript	\N
602	8	3	1	logic_id 107		FwdLogicScript	\N
603	9	3	1	logic_id 107		FwdLogicScript	\N
604	10	3	1	logic_id 107		FwdLogicScript	\N
605	17	3	1	logic_id 107		FwdLogicScript	\N
606	18	3	1	logic_id 107		FwdLogicScript	\N
607	8	2	1	logic_id 108		FwdLogicScript	\N
608	9	2	1	logic_id 108		FwdLogicScript	\N
609	10	2	1	logic_id 108		FwdLogicScript	\N
610	17	2	1	logic_id 108		FwdLogicScript	\N
611	18	2	1	logic_id 108		FwdLogicScript	\N
612	8	47	1	logic_id 109		FwdLogicScript	\N
613	9	47	1	logic_id 109		FwdLogicScript	\N
614	10	47	1	logic_id 109		FwdLogicScript	\N
615	17	47	1	logic_id 109		FwdLogicScript	\N
616	18	47	1	logic_id 109		FwdLogicScript	\N
617	8	46	1	logic_id 110		FwdLogicScript	\N
618	9	46	1	logic_id 110		FwdLogicScript	\N
619	10	46	1	logic_id 110		FwdLogicScript	\N
620	17	46	1	logic_id 110		FwdLogicScript	\N
621	18	46	1	logic_id 110		FwdLogicScript	\N
622	8	56	1	logic_id 111		FwdLogicScript	\N
623	9	56	1	logic_id 111		FwdLogicScript	\N
624	10	56	1	logic_id 111		FwdLogicScript	\N
625	13	56	1	logic_id 111		FwdLogicScript	\N
626	14	56	1	logic_id 111		FwdLogicScript	\N
627	17	56	1	logic_id 111		FwdLogicScript	\N
628	18	56	1	logic_id 111		FwdLogicScript	\N
629	24	56	1	logic_id 111		FwdLogicScript	\N
630	27	56	1	logic_id 111		FwdLogicScript	\N
631	8	88	1	logic_id 112		FwdLogicScript	\N
632	9	88	1	logic_id 112		FwdLogicScript	\N
633	10	88	1	logic_id 112		FwdLogicScript	\N
634	13	88	1	logic_id 112		FwdLogicScript	\N
635	14	88	1	logic_id 112		FwdLogicScript	\N
636	17	88	1	logic_id 112		FwdLogicScript	\N
637	18	88	1	logic_id 112		FwdLogicScript	\N
638	24	88	1	logic_id 112		FwdLogicScript	\N
639	27	88	1	logic_id 112		FwdLogicScript	\N
640	10	90	1	logic_id 113		FwdLogicScript	\N
641	13	90	1	logic_id 113		FwdLogicScript	\N
642	14	90	1	logic_id 113		FwdLogicScript	\N
643	24	90	1	logic_id 113		FwdLogicScript	\N
644	27	90	1	logic_id 113		FwdLogicScript	\N
645	10	85	1	logic_id 114		FwdLogicScript	\N
646	13	85	1	logic_id 114		FwdLogicScript	\N
647	14	85	1	logic_id 114		FwdLogicScript	\N
648	24	85	1	logic_id 114		FwdLogicScript	\N
649	27	85	1	logic_id 114		FwdLogicScript	\N
650	1	61	1	logic_id 115		FwdLogicScript	\N
651	2	61	1	logic_id 115		FwdLogicScript	\N
652	3	61	1	logic_id 115		FwdLogicScript	\N
653	4	61	1	logic_id 115		FwdLogicScript	\N
654	6	61	1	logic_id 115		FwdLogicScript	\N
655	7	61	1	logic_id 115		FwdLogicScript	\N
656	10	61	1	logic_id 115		FwdLogicScript	\N
657	27	61	1	logic_id 115		FwdLogicScript	\N
658	33	61	1	logic_id 115		FwdLogicScript	\N
659	34	61	1	logic_id 115		FwdLogicScript	\N
660	36	61	1	logic_id 115		FwdLogicScript	\N
661	1	64	1	logic_id 116		FwdLogicScript	\N
662	2	64	1	logic_id 116		FwdLogicScript	\N
663	3	64	1	logic_id 116		FwdLogicScript	\N
664	4	64	1	logic_id 116		FwdLogicScript	\N
665	6	64	1	logic_id 116		FwdLogicScript	\N
666	7	64	1	logic_id 116		FwdLogicScript	\N
667	8	64	1	logic_id 116		FwdLogicScript	\N
668	9	64	1	logic_id 116		FwdLogicScript	\N
669	10	64	1	logic_id 116		FwdLogicScript	\N
670	17	64	1	logic_id 116		FwdLogicScript	\N
671	18	64	1	logic_id 116		FwdLogicScript	\N
672	27	64	1	logic_id 116		FwdLogicScript	\N
673	33	64	1	logic_id 116		FwdLogicScript	\N
674	34	64	1	logic_id 116		FwdLogicScript	\N
675	36	64	1	logic_id 116		FwdLogicScript	\N
676	8	86	1	logic_id 117		FwdLogicScript	\N
677	9	86	1	logic_id 117		FwdLogicScript	\N
678	10	86	1	logic_id 117		FwdLogicScript	\N
679	13	86	1	logic_id 117		FwdLogicScript	\N
680	14	86	1	logic_id 117		FwdLogicScript	\N
681	17	86	1	logic_id 117		FwdLogicScript	\N
682	18	86	1	logic_id 117		FwdLogicScript	\N
683	24	86	1	logic_id 117		FwdLogicScript	\N
684	27	86	1	logic_id 117		FwdLogicScript	\N
685	7	21	1	logic_id 119		FwdLogicScript	\N
686	27	21	1	logic_id 119		FwdLogicScript	\N
687	33	21	1	logic_id 119		FwdLogicScript	\N
688	34	21	1	logic_id 119		FwdLogicScript	\N
689	7	25	1	logic_id 120		FwdLogicScript	\N
690	8	25	1	logic_id 120		FwdLogicScript	\N
691	17	25	1	logic_id 120		FwdLogicScript	\N
692	18	25	1	logic_id 120		FwdLogicScript	\N
693	27	25	1	logic_id 120		FwdLogicScript	\N
694	33	25	1	logic_id 120		FwdLogicScript	\N
695	34	25	1	logic_id 120		FwdLogicScript	\N
696	7	20	1	logic_id 122		FwdLogicScript	\N
697	27	20	1	logic_id 122		FwdLogicScript	\N
698	33	20	1	logic_id 122		FwdLogicScript	\N
699	34	20	1	logic_id 122		FwdLogicScript	\N
700	7	24	1	logic_id 123		FwdLogicScript	\N
701	8	24	1	logic_id 123		FwdLogicScript	\N
702	17	24	1	logic_id 123		FwdLogicScript	\N
703	18	24	1	logic_id 123		FwdLogicScript	\N
704	27	24	1	logic_id 123		FwdLogicScript	\N
705	33	24	1	logic_id 123		FwdLogicScript	\N
706	34	24	1	logic_id 123		FwdLogicScript	\N
707	8	49	1	logic_id 125		FwdLogicScript	\N
708	9	49	1	logic_id 125		FwdLogicScript	\N
709	10	49	1	logic_id 125		FwdLogicScript	\N
710	17	49	1	logic_id 125		FwdLogicScript	\N
711	18	49	1	logic_id 125		FwdLogicScript	\N
712	8	51	1	logic_id 126		FwdLogicScript	\N
713	9	51	1	logic_id 126		FwdLogicScript	\N
714	10	51	1	logic_id 126		FwdLogicScript	\N
715	17	51	1	logic_id 126		FwdLogicScript	\N
716	18	51	1	logic_id 126		FwdLogicScript	\N
717	8	82	1	logic_id 127		FwdLogicScript	\N
718	9	82	1	logic_id 127		FwdLogicScript	\N
719	10	82	1	logic_id 127		FwdLogicScript	\N
720	17	82	1	logic_id 127		FwdLogicScript	\N
721	18	82	1	logic_id 127		FwdLogicScript	\N
722	8	52	1	logic_id 128		FwdLogicScript	\N
723	9	52	1	logic_id 128		FwdLogicScript	\N
724	10	52	1	logic_id 128		FwdLogicScript	\N
725	17	52	1	logic_id 128		FwdLogicScript	\N
726	18	52	1	logic_id 128		FwdLogicScript	\N
727	8	48	1	logic_id 130		FwdLogicScript	\N
728	9	48	1	logic_id 130		FwdLogicScript	\N
729	10	48	1	logic_id 130		FwdLogicScript	\N
730	17	48	1	logic_id 130		FwdLogicScript	\N
731	18	48	1	logic_id 130		FwdLogicScript	\N
732	8	50	1	logic_id 131		FwdLogicScript	\N
733	9	50	1	logic_id 131		FwdLogicScript	\N
734	10	50	1	logic_id 131		FwdLogicScript	\N
735	17	50	1	logic_id 131		FwdLogicScript	\N
736	18	50	1	logic_id 131		FwdLogicScript	\N
737	8	81	1	logic_id 132		FwdLogicScript	\N
738	9	81	1	logic_id 132		FwdLogicScript	\N
739	10	81	1	logic_id 132		FwdLogicScript	\N
740	17	81	1	logic_id 132		FwdLogicScript	\N
741	18	81	1	logic_id 132		FwdLogicScript	\N
742	8	53	1	logic_id 133		FwdLogicScript	\N
743	9	53	1	logic_id 133		FwdLogicScript	\N
744	10	53	1	logic_id 133		FwdLogicScript	\N
745	17	53	1	logic_id 133		FwdLogicScript	\N
746	18	53	1	logic_id 133		FwdLogicScript	\N
747	10	91	1	logic_id 135		FwdLogicScript	\N
748	13	91	1	logic_id 135		FwdLogicScript	\N
749	14	91	1	logic_id 135		FwdLogicScript	\N
750	24	91	1	logic_id 135		FwdLogicScript	\N
751	27	91	1	logic_id 135		FwdLogicScript	\N
752	8	60	1	logic_id 137		FwdLogicScript	\N
753	9	60	1	logic_id 137		FwdLogicScript	\N
754	10	60	1	logic_id 137		FwdLogicScript	\N
755	13	60	1	logic_id 137		FwdLogicScript	\N
756	14	60	1	logic_id 137		FwdLogicScript	\N
757	17	60	1	logic_id 137		FwdLogicScript	\N
758	18	60	1	logic_id 137		FwdLogicScript	\N
759	24	60	1	logic_id 137		FwdLogicScript	\N
760	27	60	1	logic_id 137		FwdLogicScript	\N
761	2	58	1	logic_id 138		FwdLogicScript	\N
762	3	58	1	logic_id 138		FwdLogicScript	\N
763	4	58	1	logic_id 138		FwdLogicScript	\N
764	5	58	1	logic_id 138		FwdLogicScript	\N
765	14	58	1	logic_id 138		FwdLogicScript	\N
766	24	58	1	logic_id 138		FwdLogicScript	\N
767	2	59	1	logic_id 139		FwdLogicScript	\N
768	3	59	1	logic_id 139		FwdLogicScript	\N
769	4	59	1	logic_id 139		FwdLogicScript	\N
770	5	59	1	logic_id 139		FwdLogicScript	\N
771	14	59	1	logic_id 139		FwdLogicScript	\N
772	24	59	1	logic_id 139		FwdLogicScript	\N
773	1	73	1	logic_id 140		FwdLogicScript	\N
774	2	73	1	logic_id 140		FwdLogicScript	\N
775	3	73	1	logic_id 140		FwdLogicScript	\N
776	4	73	1	logic_id 140		FwdLogicScript	\N
777	5	73	1	logic_id 140		FwdLogicScript	\N
778	6	73	1	logic_id 140		FwdLogicScript	\N
779	7	73	1	logic_id 140		FwdLogicScript	\N
780	14	73	1	logic_id 140		FwdLogicScript	\N
781	24	73	1	logic_id 140		FwdLogicScript	\N
782	30	73	1	logic_id 140		FwdLogicScript	\N
783	1	74	1	logic_id 141		FwdLogicScript	\N
784	2	74	1	logic_id 141		FwdLogicScript	\N
785	3	74	1	logic_id 141		FwdLogicScript	\N
786	4	74	1	logic_id 141		FwdLogicScript	\N
787	5	74	1	logic_id 141		FwdLogicScript	\N
788	6	74	1	logic_id 141		FwdLogicScript	\N
789	14	74	1	logic_id 141		FwdLogicScript	\N
790	22	74	1	logic_id 141		FwdLogicScript	\N
791	24	74	1	logic_id 141		FwdLogicScript	\N
792	30	74	1	logic_id 141		FwdLogicScript	\N
793	2	83	1	logic_id 144		FwdLogicScript	\N
794	3	83	1	logic_id 144		FwdLogicScript	\N
795	4	83	1	logic_id 144		FwdLogicScript	\N
796	5	83	1	logic_id 144		FwdLogicScript	\N
797	14	83	1	logic_id 144		FwdLogicScript	\N
798	24	83	1	logic_id 144		FwdLogicScript	\N
799	2	57	1	logic_id 145		FwdLogicScript	\N
800	3	57	1	logic_id 145		FwdLogicScript	\N
801	4	57	1	logic_id 145		FwdLogicScript	\N
802	5	57	1	logic_id 145		FwdLogicScript	\N
803	1	70	1	logic_id 148		FwdLogicScript	\N
804	2	70	1	logic_id 148		FwdLogicScript	\N
805	3	70	1	logic_id 148		FwdLogicScript	\N
806	4	70	1	logic_id 148		FwdLogicScript	\N
807	5	70	1	logic_id 148		FwdLogicScript	\N
808	6	70	1	logic_id 148		FwdLogicScript	\N
809	22	70	1	logic_id 148		FwdLogicScript	\N
810	30	70	1	logic_id 148		FwdLogicScript	\N
811	1	79	1	logic_id 149		FwdLogicScript	\N
812	6	79	1	logic_id 149		FwdLogicScript	\N
813	22	79	1	logic_id 149		FwdLogicScript	\N
814	30	79	1	logic_id 149		FwdLogicScript	\N
815	1	69	1	logic_id 150		FwdLogicScript	\N
816	2	69	1	logic_id 150		FwdLogicScript	\N
817	3	69	1	logic_id 150		FwdLogicScript	\N
818	4	69	1	logic_id 150		FwdLogicScript	\N
819	5	69	1	logic_id 150		FwdLogicScript	\N
820	6	69	1	logic_id 150		FwdLogicScript	\N
821	7	69	1	logic_id 150		FwdLogicScript	\N
822	30	69	1	logic_id 150		FwdLogicScript	\N
823	1	77	1	logic_id 151		FwdLogicScript	\N
824	2	77	1	logic_id 151		FwdLogicScript	\N
825	3	77	1	logic_id 151		FwdLogicScript	\N
826	4	77	1	logic_id 151		FwdLogicScript	\N
827	5	77	1	logic_id 151		FwdLogicScript	\N
828	6	77	1	logic_id 151		FwdLogicScript	\N
829	7	77	1	logic_id 151		FwdLogicScript	\N
830	30	77	1	logic_id 151		FwdLogicScript	\N
831	5	62	1	logic_id 152		FwdLogicScript	\N
832	22	62	1	logic_id 152		FwdLogicScript	\N
833	30	62	1	logic_id 152		FwdLogicScript	\N
834	31	62	1	logic_id 152		FwdLogicScript	\N
835	8	104	1	logic_id 154		FwdLogicScript	\N
836	10	104	1	logic_id 154		FwdLogicScript	\N
837	17	104	1	logic_id 154		FwdLogicScript	\N
838	18	104	1	logic_id 154		FwdLogicScript	\N
839	24	104	1	logic_id 154		FwdLogicScript	\N
840	27	104	1	logic_id 154		FwdLogicScript	\N
841	1	106	1	logic_id 155		FwdLogicScript	\N
842	2	106	1	logic_id 155		FwdLogicScript	\N
843	3	106	1	logic_id 155		FwdLogicScript	\N
844	4	106	1	logic_id 155		FwdLogicScript	\N
845	6	106	1	logic_id 155		FwdLogicScript	\N
846	7	106	1	logic_id 155		FwdLogicScript	\N
847	9	106	1	logic_id 155		FwdLogicScript	\N
848	25	106	1	logic_id 155		FwdLogicScript	\N
849	33	106	1	logic_id 155		FwdLogicScript	\N
850	34	106	1	logic_id 155		FwdLogicScript	\N
851	36	106	1	logic_id 155		FwdLogicScript	\N
852	1	107	1	logic_id 156		FwdLogicScript	\N
853	2	107	1	logic_id 156		FwdLogicScript	\N
854	3	107	1	logic_id 156		FwdLogicScript	\N
855	4	107	1	logic_id 156		FwdLogicScript	\N
856	6	107	1	logic_id 156		FwdLogicScript	\N
857	7	107	1	logic_id 156		FwdLogicScript	\N
858	9	107	1	logic_id 156		FwdLogicScript	\N
859	25	107	1	logic_id 156		FwdLogicScript	\N
860	33	107	1	logic_id 156		FwdLogicScript	\N
861	34	107	1	logic_id 156		FwdLogicScript	\N
862	36	107	1	logic_id 156		FwdLogicScript	\N
863	6	104	1	logic_id 157		FwdLogicScript	\N
864	7	104	1	logic_id 157		FwdLogicScript	\N
865	35	104	1	logic_id 157		FwdLogicScript	\N
866	22	111	1	logic_id 162		FwdLogicScript	\N
867	22	110	1	logic_id 163		FwdLogicScript	\N
868	2	105	1	logic_id 164		FwdLogicScript	\N
869	3	105	1	logic_id 164		FwdLogicScript	\N
870	4	105	1	logic_id 164		FwdLogicScript	\N
871	5	105	1	logic_id 164		FwdLogicScript	\N
872	14	105	1	logic_id 164		FwdLogicScript	\N
873	24	105	1	logic_id 164		FwdLogicScript	\N
874	2	110	1	logic_id 165		FwdLogicScript	\N
875	3	110	1	logic_id 165		FwdLogicScript	\N
876	4	110	1	logic_id 165		FwdLogicScript	\N
877	5	110	1	logic_id 165		FwdLogicScript	\N
878	14	110	1	logic_id 165		FwdLogicScript	\N
879	24	110	1	logic_id 165		FwdLogicScript	\N
880	2	111	1	logic_id 166		FwdLogicScript	\N
881	3	111	1	logic_id 166		FwdLogicScript	\N
882	4	111	1	logic_id 166		FwdLogicScript	\N
883	5	111	1	logic_id 166		FwdLogicScript	\N
884	14	111	1	logic_id 166		FwdLogicScript	\N
885	24	111	1	logic_id 166		FwdLogicScript	\N
886	1	75	1	logic_id 167		FwdLogicScript	\N
887	2	75	1	logic_id 167		FwdLogicScript	\N
888	3	75	1	logic_id 167		FwdLogicScript	\N
889	4	75	1	logic_id 167		FwdLogicScript	\N
890	5	75	1	logic_id 167		FwdLogicScript	\N
891	6	75	1	logic_id 167		FwdLogicScript	\N
892	7	75	1	logic_id 167		FwdLogicScript	\N
893	8	75	1	logic_id 167		FwdLogicScript	\N
894	9	75	1	logic_id 167		FwdLogicScript	\N
895	14	75	1	logic_id 167		FwdLogicScript	\N
896	17	75	1	logic_id 167		FwdLogicScript	\N
897	18	75	1	logic_id 167		FwdLogicScript	\N
898	24	75	1	logic_id 167		FwdLogicScript	\N
899	30	75	1	logic_id 167		FwdLogicScript	\N
900	1	76	1	logic_id 168		FwdLogicScript	\N
901	2	76	1	logic_id 168		FwdLogicScript	\N
902	3	76	1	logic_id 168		FwdLogicScript	\N
903	4	76	1	logic_id 168		FwdLogicScript	\N
904	5	76	1	logic_id 168		FwdLogicScript	\N
905	6	76	1	logic_id 168		FwdLogicScript	\N
906	8	76	1	logic_id 168		FwdLogicScript	\N
907	9	76	1	logic_id 168		FwdLogicScript	\N
908	14	76	1	logic_id 168		FwdLogicScript	\N
909	17	76	1	logic_id 168		FwdLogicScript	\N
910	18	76	1	logic_id 168		FwdLogicScript	\N
911	22	76	1	logic_id 168		FwdLogicScript	\N
912	24	76	1	logic_id 168		FwdLogicScript	\N
913	30	76	1	logic_id 168		FwdLogicScript	\N
914	1	108	1	logic_id 169		FwdLogicScript	\N
915	2	108	1	logic_id 169		FwdLogicScript	\N
916	3	108	1	logic_id 169		FwdLogicScript	\N
917	4	108	1	logic_id 169		FwdLogicScript	\N
918	5	108	1	logic_id 169		FwdLogicScript	\N
919	6	108	1	logic_id 169		FwdLogicScript	\N
920	7	108	1	logic_id 169		FwdLogicScript	\N
921	30	108	1	logic_id 169		FwdLogicScript	\N
922	31	108	1	logic_id 169		FwdLogicScript	\N
923	22	108	1	logic_id 170		FwdLogicScript	\N
924	8	108	1	logic_id 171		FwdLogicScript	\N
925	9	108	1	logic_id 171		FwdLogicScript	\N
926	14	108	1	logic_id 171		FwdLogicScript	\N
927	17	108	1	logic_id 171		FwdLogicScript	\N
928	18	108	1	logic_id 171		FwdLogicScript	\N
929	24	108	1	logic_id 171		FwdLogicScript	\N
930	8	77	1	logic_id 176		FwdLogicScript	\N
931	9	77	1	logic_id 176		FwdLogicScript	\N
932	10	77	1	logic_id 176		FwdLogicScript	\N
933	14	77	1	logic_id 176		FwdLogicScript	\N
934	17	77	1	logic_id 176		FwdLogicScript	\N
935	18	77	1	logic_id 176		FwdLogicScript	\N
936	24	77	1	logic_id 176		FwdLogicScript	\N
937	5	61	1	logic_id 181		FwdLogicScript	\N
938	14	61	1	logic_id 181		FwdLogicScript	\N
939	22	61	1	logic_id 181		FwdLogicScript	\N
940	24	61	1	logic_id 181		FwdLogicScript	\N
941	30	61	1	logic_id 181		FwdLogicScript	\N
942	31	61	1	logic_id 181		FwdLogicScript	\N
943	24	101	1	logic_id 182		FwdLogicScript	\N
944	35	101	1	logic_id 182		FwdLogicScript	\N
945	8	120	1	logic_id 195		FwdLogicScript	\N
946	9	120	1	logic_id 195		FwdLogicScript	\N
947	10	120	1	logic_id 195		FwdLogicScript	\N
948	17	120	1	logic_id 195		FwdLogicScript	\N
949	18	120	1	logic_id 195		FwdLogicScript	\N
950	8	121	1	logic_id 196		FwdLogicScript	\N
951	9	121	1	logic_id 196		FwdLogicScript	\N
952	10	121	1	logic_id 196		FwdLogicScript	\N
953	17	121	1	logic_id 196		FwdLogicScript	\N
954	18	121	1	logic_id 196		FwdLogicScript	\N
955	8	122	1	logic_id 197		FwdLogicScript	\N
956	9	122	1	logic_id 197		FwdLogicScript	\N
957	10	122	1	logic_id 197		FwdLogicScript	\N
958	17	122	1	logic_id 197		FwdLogicScript	\N
959	18	122	1	logic_id 197		FwdLogicScript	\N
960	8	123	1	logic_id 198		FwdLogicScript	\N
961	9	123	1	logic_id 198		FwdLogicScript	\N
962	10	123	1	logic_id 198		FwdLogicScript	\N
963	17	123	1	logic_id 198		FwdLogicScript	\N
964	18	123	1	logic_id 198		FwdLogicScript	\N
965	8	118	1	logic_id 199		FwdLogicScript	\N
966	9	118	1	logic_id 199		FwdLogicScript	\N
967	10	118	1	logic_id 199		FwdLogicScript	\N
968	17	118	1	logic_id 199		FwdLogicScript	\N
969	18	118	1	logic_id 199		FwdLogicScript	\N
970	8	119	1	logic_id 200		FwdLogicScript	\N
971	9	119	1	logic_id 200		FwdLogicScript	\N
972	10	119	1	logic_id 200		FwdLogicScript	\N
973	17	119	1	logic_id 200		FwdLogicScript	\N
974	18	119	1	logic_id 200		FwdLogicScript	\N
975	1	130	1	logic_id 201		FwdLogicScript	\N
976	2	130	1	logic_id 201		FwdLogicScript	\N
977	3	130	1	logic_id 201		FwdLogicScript	\N
978	4	130	1	logic_id 201		FwdLogicScript	\N
979	6	130	1	logic_id 201		FwdLogicScript	\N
980	7	130	1	logic_id 201		FwdLogicScript	\N
981	8	130	1	logic_id 201		FwdLogicScript	\N
982	9	130	1	logic_id 201		FwdLogicScript	\N
983	10	130	1	logic_id 201		FwdLogicScript	\N
984	17	130	1	logic_id 201		FwdLogicScript	\N
985	18	130	1	logic_id 201		FwdLogicScript	\N
986	27	130	1	logic_id 201		FwdLogicScript	\N
987	33	130	1	logic_id 201		FwdLogicScript	\N
988	34	130	1	logic_id 201		FwdLogicScript	\N
989	36	130	1	logic_id 201		FwdLogicScript	\N
990	1	114	1	logic_id 205		FwdLogicScript	\N
991	2	114	1	logic_id 205		FwdLogicScript	\N
992	3	114	1	logic_id 205		FwdLogicScript	\N
993	4	114	1	logic_id 205		FwdLogicScript	\N
994	5	114	1	logic_id 205		FwdLogicScript	\N
995	6	114	1	logic_id 205		FwdLogicScript	\N
996	7	114	1	logic_id 205		FwdLogicScript	\N
997	30	114	1	logic_id 205		FwdLogicScript	\N
998	31	114	1	logic_id 205		FwdLogicScript	\N
999	1	115	1	logic_id 206		FwdLogicScript	\N
1000	2	115	1	logic_id 206		FwdLogicScript	\N
1001	3	115	1	logic_id 206		FwdLogicScript	\N
1002	4	115	1	logic_id 206		FwdLogicScript	\N
1003	5	115	1	logic_id 206		FwdLogicScript	\N
1004	6	115	1	logic_id 206		FwdLogicScript	\N
1005	22	115	1	logic_id 206		FwdLogicScript	\N
1006	30	115	1	logic_id 206		FwdLogicScript	\N
1007	31	115	1	logic_id 206		FwdLogicScript	\N
1008	2	119	1	logic_id 209		FwdLogicScript	\N
1009	3	119	1	logic_id 209		FwdLogicScript	\N
1010	4	119	1	logic_id 209		FwdLogicScript	\N
1011	5	119	1	logic_id 209		FwdLogicScript	\N
1012	14	119	1	logic_id 209		FwdLogicScript	\N
1013	24	119	1	logic_id 209		FwdLogicScript	\N
1014	2	118	1	logic_id 210		FwdLogicScript	\N
1015	3	118	1	logic_id 210		FwdLogicScript	\N
1016	4	118	1	logic_id 210		FwdLogicScript	\N
1017	5	118	1	logic_id 210		FwdLogicScript	\N
1018	14	118	1	logic_id 210		FwdLogicScript	\N
1019	24	118	1	logic_id 210		FwdLogicScript	\N
1020	7	95	1	logic_id 215		FwdLogicScript	\N
1021	8	95	1	logic_id 215		FwdLogicScript	\N
1022	17	95	1	logic_id 215		FwdLogicScript	\N
1023	18	95	1	logic_id 215		FwdLogicScript	\N
1024	27	95	1	logic_id 215		FwdLogicScript	\N
1025	34	95	1	logic_id 215		FwdLogicScript	\N
1026	7	94	1	logic_id 216		FwdLogicScript	\N
1027	8	94	1	logic_id 216		FwdLogicScript	\N
1028	17	94	1	logic_id 216		FwdLogicScript	\N
1029	18	94	1	logic_id 216		FwdLogicScript	\N
1030	27	94	1	logic_id 216		FwdLogicScript	\N
1031	34	94	1	logic_id 216		FwdLogicScript	\N
1032	7	26	1	logic_id 217		FwdLogicScript	\N
1033	27	26	1	logic_id 217		FwdLogicScript	\N
1034	34	26	1	logic_id 217		FwdLogicScript	\N
1035	7	27	1	logic_id 218		FwdLogicScript	\N
1036	27	27	1	logic_id 218		FwdLogicScript	\N
1037	34	27	1	logic_id 218		FwdLogicScript	\N
1038	8	105	1	logic_id 221		FwdLogicScript	\N
1039	9	105	1	logic_id 221		FwdLogicScript	\N
1040	11	105	1	logic_id 221		FwdLogicScript	\N
1041	12	105	1	logic_id 221		FwdLogicScript	\N
1042	17	105	1	logic_id 221		FwdLogicScript	\N
1043	18	105	1	logic_id 221		FwdLogicScript	\N
1044	28	105	1	logic_id 221		FwdLogicScript	\N
1045	31	105	1	logic_id 221		FwdLogicScript	\N
1046	8	126	1	logic_id 226		FwdLogicScript	\N
1047	10	126	1	logic_id 226		FwdLogicScript	\N
1048	17	126	1	logic_id 226		FwdLogicScript	\N
1049	18	126	1	logic_id 226		FwdLogicScript	\N
1050	8	127	1	logic_id 227		FwdLogicScript	\N
1051	10	127	1	logic_id 227		FwdLogicScript	\N
1052	17	127	1	logic_id 227		FwdLogicScript	\N
1053	18	127	1	logic_id 227		FwdLogicScript	\N
1054	9	13	1	logic_id 233		FwdLogicScript	\N
1055	8	97	1	logic_id 236		FwdLogicScript	\N
1056	9	97	1	logic_id 236		FwdLogicScript	\N
1057	17	97	1	logic_id 236		FwdLogicScript	\N
1058	18	97	1	logic_id 236		FwdLogicScript	\N
1059	9	14	1	logic_id 239		FwdLogicScript	\N
1060	9	83	1	logic_id 244		FwdLogicScript	\N
1061	8	54	1	logic_id 258		FwdLogicScript	\N
1062	9	54	1	logic_id 258		FwdLogicScript	\N
1063	17	54	1	logic_id 258		FwdLogicScript	\N
1064	18	54	1	logic_id 258		FwdLogicScript	\N
1065	8	116	1	logic_id 263		FwdLogicScript	\N
1066	9	116	1	logic_id 263		FwdLogicScript	\N
1067	10	116	1	logic_id 263		FwdLogicScript	\N
1068	17	116	1	logic_id 263		FwdLogicScript	\N
1069	18	116	1	logic_id 263		FwdLogicScript	\N
1070	29	116	1	logic_id 263		FwdLogicScript	\N
1071	8	117	1	logic_id 276		FwdLogicScript	\N
1072	9	117	1	logic_id 276		FwdLogicScript	\N
1073	10	117	1	logic_id 276		FwdLogicScript	\N
1074	17	117	1	logic_id 276		FwdLogicScript	\N
1075	18	117	1	logic_id 276		FwdLogicScript	\N
1076	29	117	1	logic_id 276		FwdLogicScript	\N
1077	10	65	1	logic_id 285		FwdLogicScript	\N
1078	10	66	1	logic_id 301		FwdLogicScript	\N
1079	24	53	1	logic_id 321		FwdLogicScript	\N
1080	24	52	1	logic_id 329		FwdLogicScript	\N
1081	6	126	1	logic_id 372		FwdLogicScript	\N
1082	7	126	1	logic_id 372		FwdLogicScript	\N
1083	7	124	1	logic_id 377		FwdLogicScript	\N
1084	8	124	1	logic_id 377		FwdLogicScript	\N
1085	9	124	1	logic_id 377		FwdLogicScript	\N
1086	10	124	1	logic_id 377		FwdLogicScript	\N
1087	17	124	1	logic_id 377		FwdLogicScript	\N
1088	18	124	1	logic_id 377		FwdLogicScript	\N
1089	27	124	1	logic_id 377		FwdLogicScript	\N
1090	33	124	1	logic_id 377		FwdLogicScript	\N
1091	34	124	1	logic_id 377		FwdLogicScript	\N
1092	7	125	1	logic_id 378		FwdLogicScript	\N
1093	8	125	1	logic_id 378		FwdLogicScript	\N
1094	9	125	1	logic_id 378		FwdLogicScript	\N
1095	10	125	1	logic_id 378		FwdLogicScript	\N
1096	17	125	1	logic_id 378		FwdLogicScript	\N
1097	18	125	1	logic_id 378		FwdLogicScript	\N
1098	27	125	1	logic_id 378		FwdLogicScript	\N
1099	33	125	1	logic_id 378		FwdLogicScript	\N
1100	34	125	1	logic_id 378		FwdLogicScript	\N
1101	8	112	1	logic_id 397		FwdLogicScript	\N
1102	10	112	1	logic_id 397		FwdLogicScript	\N
1103	17	112	1	logic_id 397		FwdLogicScript	\N
1104	18	112	1	logic_id 397		FwdLogicScript	\N
1105	1	129	1	logic_id 401		FwdLogicScript	\N
1106	2	129	1	logic_id 401		FwdLogicScript	\N
1107	3	129	1	logic_id 401		FwdLogicScript	\N
1108	4	129	1	logic_id 401		FwdLogicScript	\N
1109	6	129	1	logic_id 401		FwdLogicScript	\N
1110	7	129	1	logic_id 401		FwdLogicScript	\N
1111	8	129	1	logic_id 401		FwdLogicScript	\N
1112	9	129	1	logic_id 401		FwdLogicScript	\N
1113	10	129	1	logic_id 401		FwdLogicScript	\N
1114	17	129	1	logic_id 401		FwdLogicScript	\N
1115	18	129	1	logic_id 401		FwdLogicScript	\N
1116	27	129	1	logic_id 401		FwdLogicScript	\N
1117	33	129	1	logic_id 401		FwdLogicScript	\N
1118	34	129	1	logic_id 401		FwdLogicScript	\N
1119	36	129	1	logic_id 401		FwdLogicScript	\N
1120	1	128	1	logic_id 402		FwdLogicScript	\N
1121	2	128	1	logic_id 402		FwdLogicScript	\N
1122	3	128	1	logic_id 402		FwdLogicScript	\N
1123	4	128	1	logic_id 402		FwdLogicScript	\N
1124	6	128	1	logic_id 402		FwdLogicScript	\N
1125	7	128	1	logic_id 402		FwdLogicScript	\N
1126	8	128	1	logic_id 402		FwdLogicScript	\N
1127	9	128	1	logic_id 402		FwdLogicScript	\N
1128	10	128	1	logic_id 402		FwdLogicScript	\N
1129	17	128	1	logic_id 402		FwdLogicScript	\N
1130	18	128	1	logic_id 402		FwdLogicScript	\N
1131	24	128	1	logic_id 402		FwdLogicScript	\N
1132	25	128	1	logic_id 402		FwdLogicScript	\N
1133	27	128	1	logic_id 402		FwdLogicScript	\N
1134	33	128	1	logic_id 402		FwdLogicScript	\N
1135	34	128	1	logic_id 402		FwdLogicScript	\N
1136	36	128	1	logic_id 402		FwdLogicScript	\N
1137	8	33	1	logic_id 408		FwdLogicScript	\N
1138	17	33	1	logic_id 408		FwdLogicScript	\N
1139	18	33	1	logic_id 408		FwdLogicScript	\N
1140	27	33	1	logic_id 408		FwdLogicScript	\N
1141	33	33	1	logic_id 408		FwdLogicScript	\N
1142	34	33	1	logic_id 408		FwdLogicScript	\N
1143	36	33	1	logic_id 408		FwdLogicScript	\N
1144	8	71	1	logic_id 409		FwdLogicScript	\N
1145	17	71	1	logic_id 409		FwdLogicScript	\N
1146	18	71	1	logic_id 409		FwdLogicScript	\N
1147	27	71	1	logic_id 409		FwdLogicScript	\N
1148	33	71	1	logic_id 409		FwdLogicScript	\N
1149	34	71	1	logic_id 409		FwdLogicScript	\N
1150	36	71	1	logic_id 409		FwdLogicScript	\N
1151	7	72	1	logic_id 411		FwdLogicScript	\N
1152	8	72	1	logic_id 411		FwdLogicScript	\N
1153	17	72	1	logic_id 411		FwdLogicScript	\N
1154	18	72	1	logic_id 411		FwdLogicScript	\N
1155	27	72	1	logic_id 411		FwdLogicScript	\N
1156	33	72	1	logic_id 411		FwdLogicScript	\N
1157	34	72	1	logic_id 411		FwdLogicScript	\N
1158	36	72	1	logic_id 411		FwdLogicScript	\N
1159	6	24	1	logic_id 416		FwdLogicScript	\N
1160	6	25	1	logic_id 417		FwdLogicScript	\N
1161	6	10	1	logic_id 423		FwdLogicScript	\N
1162	7	10	1	logic_id 423		FwdLogicScript	\N
1163	8	10	1	logic_id 423		FwdLogicScript	\N
1164	17	10	1	logic_id 423		FwdLogicScript	\N
1165	18	10	1	logic_id 423		FwdLogicScript	\N
1166	27	10	1	logic_id 423		FwdLogicScript	\N
1167	33	10	1	logic_id 423		FwdLogicScript	\N
1168	34	10	1	logic_id 423		FwdLogicScript	\N
1169	35	10	1	logic_id 423		FwdLogicScript	\N
1170	36	10	1	logic_id 423		FwdLogicScript	\N
1171	7	96	1	logic_id 426		FwdLogicScript	\N
1172	8	96	1	logic_id 426		FwdLogicScript	\N
1173	17	96	1	logic_id 426		FwdLogicScript	\N
1174	18	96	1	logic_id 426		FwdLogicScript	\N
1175	27	96	1	logic_id 426		FwdLogicScript	\N
1176	33	96	1	logic_id 426		FwdLogicScript	\N
1177	34	96	1	logic_id 426		FwdLogicScript	\N
1178	10	108	1	logic_id 435		FwdLogicScript	\N
1179	27	108	1	logic_id 435		FwdLogicScript	\N
1180	35	108	1	logic_id 435		FwdLogicScript	\N
1181	2	53	1	logic_id 437		FwdLogicScript	\N
1182	3	53	1	logic_id 437		FwdLogicScript	\N
1183	4	53	1	logic_id 437		FwdLogicScript	\N
1184	2	52	1	logic_id 438		FwdLogicScript	\N
1185	3	52	1	logic_id 438		FwdLogicScript	\N
1186	4	52	1	logic_id 438		FwdLogicScript	\N
1187	8	7	1	logic_id 439		FwdLogicScript	\N
1188	17	7	1	logic_id 439		FwdLogicScript	\N
1189	18	7	1	logic_id 439		FwdLogicScript	\N
1190	8	131	1	logic_id 440		FwdLogicScript	\N
1191	17	131	1	logic_id 440		FwdLogicScript	\N
1192	18	131	1	logic_id 440		FwdLogicScript	\N
1193	8	133	1	logic_id 442		FwdLogicScript	\N
1194	17	133	1	logic_id 442		FwdLogicScript	\N
1195	18	133	1	logic_id 442		FwdLogicScript	\N
1196	10	133	1	logic_id 443		FwdLogicScript	\N
1197	24	133	1	logic_id 443		FwdLogicScript	\N
1198	27	133	1	logic_id 443		FwdLogicScript	\N
1199	8	132	1	logic_id 444		FwdLogicScript	\N
1200	10	132	1	logic_id 444		FwdLogicScript	\N
1201	17	132	1	logic_id 444		FwdLogicScript	\N
1202	18	132	1	logic_id 444		FwdLogicScript	\N
1203	24	132	1	logic_id 444		FwdLogicScript	\N
1204	27	132	1	logic_id 444		FwdLogicScript	\N
1205	8	134	1	logic_id 446		FwdLogicScript	\N
1206	9	134	1	logic_id 446		FwdLogicScript	\N
1207	10	134	1	logic_id 446		FwdLogicScript	\N
1208	13	134	1	logic_id 446		FwdLogicScript	\N
1209	14	134	1	logic_id 446		FwdLogicScript	\N
1210	17	134	1	logic_id 446		FwdLogicScript	\N
1211	18	134	1	logic_id 446		FwdLogicScript	\N
1212	24	134	1	logic_id 446		FwdLogicScript	\N
1213	27	134	1	logic_id 446		FwdLogicScript	\N
1214	15	134	1	logic_id 447		FwdLogicScript	\N
1215	27	4	1	logic_id 459		FwdLogicScript	\N
1216	34	4	1	logic_id 459		FwdLogicScript	\N
1217	8	79	1	logic_id 0		FwdLogicScript	\N
1218	9	79	1	logic_id 0		FwdLogicScript	\N
1219	10	79	1	logic_id 0		FwdLogicScript	\N
1220	17	79	1	logic_id 0		FwdLogicScript	\N
1221	18	79	1	logic_id 0		FwdLogicScript	\N
1222	9	71	1	logic_id 7		FwdLogicScript	\N
1223	14	71	1	logic_id 7		FwdLogicScript	\N
1224	24	71	1	logic_id 7		FwdLogicScript	\N
1225	9	72	1	logic_id 8		FwdLogicScript	\N
1226	14	72	1	logic_id 8		FwdLogicScript	\N
1227	24	72	1	logic_id 8		FwdLogicScript	\N
1228	10	4	1	logic_id 9		FwdLogicScript	\N
1229	10	54	1	logic_id 10		FwdLogicScript	\N
1230	10	5	1	logic_id 11		FwdLogicScript	\N
1231	10	102	1	logic_id 13		FwdLogicScript	\N
1232	8	92	1	logic_id 14		FwdLogicScript	\N
1233	9	92	1	logic_id 14		FwdLogicScript	\N
1234	10	92	1	logic_id 14		FwdLogicScript	\N
1235	17	92	1	logic_id 14		FwdLogicScript	\N
1236	18	92	1	logic_id 14		FwdLogicScript	\N
1237	10	103	1	logic_id 15		FwdLogicScript	\N
1238	8	93	1	logic_id 16		FwdLogicScript	\N
1239	9	93	1	logic_id 16		FwdLogicScript	\N
1240	10	93	1	logic_id 16		FwdLogicScript	\N
1241	17	93	1	logic_id 16		FwdLogicScript	\N
1242	18	93	1	logic_id 16		FwdLogicScript	\N
1243	8	37	1	logic_id 24		FwdLogicScript	\N
1244	17	37	1	logic_id 24		FwdLogicScript	\N
1245	18	37	1	logic_id 24		FwdLogicScript	\N
1246	8	36	1	logic_id 25		FwdLogicScript	\N
1247	17	36	1	logic_id 25		FwdLogicScript	\N
1248	18	36	1	logic_id 25		FwdLogicScript	\N
1249	2	84	1	logic_id 60		FwdLogicScript	\N
1250	3	84	1	logic_id 60		FwdLogicScript	\N
1251	4	84	1	logic_id 60		FwdLogicScript	\N
1252	5	84	1	logic_id 60		FwdLogicScript	\N
1253	14	84	1	logic_id 60		FwdLogicScript	\N
1254	24	84	1	logic_id 60		FwdLogicScript	\N
1255	2	66	1	logic_id 61		FwdLogicScript	\N
1256	3	66	1	logic_id 61		FwdLogicScript	\N
1257	4	66	1	logic_id 61		FwdLogicScript	\N
1258	5	66	1	logic_id 61		FwdLogicScript	\N
1259	14	66	1	logic_id 61		FwdLogicScript	\N
1260	24	66	1	logic_id 61		FwdLogicScript	\N
1261	2	65	1	logic_id 62		FwdLogicScript	\N
1262	3	65	1	logic_id 62		FwdLogicScript	\N
1263	4	65	1	logic_id 62		FwdLogicScript	\N
1264	5	65	1	logic_id 62		FwdLogicScript	\N
1265	14	65	1	logic_id 62		FwdLogicScript	\N
1266	24	65	1	logic_id 62		FwdLogicScript	\N
1267	2	91	1	logic_id 63		FwdLogicScript	\N
1268	3	91	1	logic_id 63		FwdLogicScript	\N
1269	4	91	1	logic_id 63		FwdLogicScript	\N
1270	5	91	1	logic_id 63		FwdLogicScript	\N
1271	7	29	1	logic_id 64		FwdLogicScript	\N
1272	27	29	1	logic_id 64		FwdLogicScript	\N
1273	34	29	1	logic_id 64		FwdLogicScript	\N
1274	7	28	1	logic_id 65		FwdLogicScript	\N
1275	27	28	1	logic_id 65		FwdLogicScript	\N
1276	34	28	1	logic_id 65		FwdLogicScript	\N
1277	7	5	1	logic_id 69		FwdLogicScript	\N
1278	27	5	1	logic_id 69		FwdLogicScript	\N
1279	34	5	1	logic_id 69		FwdLogicScript	\N
1280	13	62	1	logic_id 92		FwdLogicScript	\N
1281	14	62	1	logic_id 92		FwdLogicScript	\N
1282	24	62	1	logic_id 92		FwdLogicScript	\N
1283	2	85	1	logic_id 93		FwdLogicScript	\N
1284	3	85	1	logic_id 93		FwdLogicScript	\N
1285	4	85	1	logic_id 93		FwdLogicScript	\N
1286	5	85	1	logic_id 93		FwdLogicScript	\N
1287	2	87	1	logic_id 94		FwdLogicScript	\N
1288	3	87	1	logic_id 94		FwdLogicScript	\N
1289	4	87	1	logic_id 94		FwdLogicScript	\N
1290	5	87	1	logic_id 94		FwdLogicScript	\N
1291	14	87	1	logic_id 94		FwdLogicScript	\N
1292	24	87	1	logic_id 94		FwdLogicScript	\N
1293	7	31	1	logic_id 95		FwdLogicScript	\N
1294	27	31	1	logic_id 95		FwdLogicScript	\N
1295	34	31	1	logic_id 95		FwdLogicScript	\N
1296	7	74	1	logic_id 96		FwdLogicScript	\N
1297	27	74	1	logic_id 96		FwdLogicScript	\N
1298	34	74	1	logic_id 96		FwdLogicScript	\N
1299	7	30	1	logic_id 97		FwdLogicScript	\N
1300	27	30	1	logic_id 97		FwdLogicScript	\N
1301	34	30	1	logic_id 97		FwdLogicScript	\N
1302	27	73	1	logic_id 98		FwdLogicScript	\N
1303	34	73	1	logic_id 98		FwdLogicScript	\N
1304	7	35	1	logic_id 99		FwdLogicScript	\N
1305	27	35	1	logic_id 99		FwdLogicScript	\N
1306	34	35	1	logic_id 99		FwdLogicScript	\N
1307	7	34	1	logic_id 100		FwdLogicScript	\N
1308	27	34	1	logic_id 100		FwdLogicScript	\N
1309	34	34	1	logic_id 100		FwdLogicScript	\N
1310	2	56	1	logic_id 111		FwdLogicScript	\N
1311	3	56	1	logic_id 111		FwdLogicScript	\N
1312	4	56	1	logic_id 111		FwdLogicScript	\N
1313	5	56	1	logic_id 111		FwdLogicScript	\N
1314	2	88	1	logic_id 112		FwdLogicScript	\N
1315	3	88	1	logic_id 112		FwdLogicScript	\N
1316	4	88	1	logic_id 112		FwdLogicScript	\N
1317	5	88	1	logic_id 112		FwdLogicScript	\N
1318	2	90	1	logic_id 113		FwdLogicScript	\N
1319	3	90	1	logic_id 113		FwdLogicScript	\N
1320	4	90	1	logic_id 113		FwdLogicScript	\N
1321	5	90	1	logic_id 113		FwdLogicScript	\N
1322	13	61	1	logic_id 115		FwdLogicScript	\N
1323	5	64	1	logic_id 116		FwdLogicScript	\N
1324	13	64	1	logic_id 116		FwdLogicScript	\N
1325	14	64	1	logic_id 116		FwdLogicScript	\N
1326	22	64	1	logic_id 116		FwdLogicScript	\N
1327	24	64	1	logic_id 116		FwdLogicScript	\N
1328	30	64	1	logic_id 116		FwdLogicScript	\N
1329	31	64	1	logic_id 116		FwdLogicScript	\N
1330	2	86	1	logic_id 117		FwdLogicScript	\N
1331	3	86	1	logic_id 117		FwdLogicScript	\N
1332	4	86	1	logic_id 117		FwdLogicScript	\N
1333	5	86	1	logic_id 117		FwdLogicScript	\N
1334	2	60	1	logic_id 137		FwdLogicScript	\N
1335	3	60	1	logic_id 137		FwdLogicScript	\N
1336	4	60	1	logic_id 137		FwdLogicScript	\N
1337	5	60	1	logic_id 137		FwdLogicScript	\N
1338	8	58	1	logic_id 138		FwdLogicScript	\N
1339	9	58	1	logic_id 138		FwdLogicScript	\N
1340	10	58	1	logic_id 138		FwdLogicScript	\N
1341	17	58	1	logic_id 138		FwdLogicScript	\N
1342	18	58	1	logic_id 138		FwdLogicScript	\N
1343	8	59	1	logic_id 139		FwdLogicScript	\N
1344	9	59	1	logic_id 139		FwdLogicScript	\N
1345	10	59	1	logic_id 139		FwdLogicScript	\N
1346	17	59	1	logic_id 139		FwdLogicScript	\N
1347	18	59	1	logic_id 139		FwdLogicScript	\N
1348	10	73	1	logic_id 140		FwdLogicScript	\N
1349	10	74	1	logic_id 141		FwdLogicScript	\N
1350	10	83	1	logic_id 144		FwdLogicScript	\N
1351	7	70	1	logic_id 148		FwdLogicScript	\N
1352	8	70	1	logic_id 148		FwdLogicScript	\N
1353	9	70	1	logic_id 148		FwdLogicScript	\N
1354	14	70	1	logic_id 148		FwdLogicScript	\N
1355	17	70	1	logic_id 148		FwdLogicScript	\N
1356	18	70	1	logic_id 148		FwdLogicScript	\N
1357	24	70	1	logic_id 148		FwdLogicScript	\N
1358	27	70	1	logic_id 148		FwdLogicScript	\N
1359	33	70	1	logic_id 148		FwdLogicScript	\N
1360	34	70	1	logic_id 148		FwdLogicScript	\N
1361	36	70	1	logic_id 148		FwdLogicScript	\N
1362	7	79	1	logic_id 149		FwdLogicScript	\N
1363	27	79	1	logic_id 149		FwdLogicScript	\N
1364	33	79	1	logic_id 149		FwdLogicScript	\N
1365	34	79	1	logic_id 149		FwdLogicScript	\N
1366	36	79	1	logic_id 149		FwdLogicScript	\N
1367	8	69	1	logic_id 150		FwdLogicScript	\N
1368	9	69	1	logic_id 150		FwdLogicScript	\N
1369	14	69	1	logic_id 150		FwdLogicScript	\N
1370	17	69	1	logic_id 150		FwdLogicScript	\N
1371	18	69	1	logic_id 150		FwdLogicScript	\N
1372	24	69	1	logic_id 150		FwdLogicScript	\N
1373	27	69	1	logic_id 150		FwdLogicScript	\N
1374	33	69	1	logic_id 150		FwdLogicScript	\N
1375	34	69	1	logic_id 150		FwdLogicScript	\N
1376	36	69	1	logic_id 150		FwdLogicScript	\N
1377	27	77	1	logic_id 151		FwdLogicScript	\N
1378	33	77	1	logic_id 151		FwdLogicScript	\N
1379	34	77	1	logic_id 151		FwdLogicScript	\N
1380	36	77	1	logic_id 151		FwdLogicScript	\N
1381	33	104	1	logic_id 157		FwdLogicScript	\N
1382	34	104	1	logic_id 157		FwdLogicScript	\N
1383	36	104	1	logic_id 157		FwdLogicScript	\N
1384	2	109	1	logic_id 160		FwdLogicScript	\N
1385	3	109	1	logic_id 160		FwdLogicScript	\N
1386	4	109	1	logic_id 160		FwdLogicScript	\N
1387	5	109	1	logic_id 160		FwdLogicScript	\N
1388	14	109	1	logic_id 160		FwdLogicScript	\N
1389	22	109	1	logic_id 160		FwdLogicScript	\N
1390	24	109	1	logic_id 160		FwdLogicScript	\N
1391	8	111	1	logic_id 162		FwdLogicScript	\N
1392	9	111	1	logic_id 162		FwdLogicScript	\N
1393	11	111	1	logic_id 162		FwdLogicScript	\N
1394	12	111	1	logic_id 162		FwdLogicScript	\N
1395	17	111	1	logic_id 162		FwdLogicScript	\N
1396	18	111	1	logic_id 162		FwdLogicScript	\N
1397	28	111	1	logic_id 162		FwdLogicScript	\N
1398	31	111	1	logic_id 162		FwdLogicScript	\N
1399	8	110	1	logic_id 163		FwdLogicScript	\N
1400	9	110	1	logic_id 163		FwdLogicScript	\N
1401	11	110	1	logic_id 163		FwdLogicScript	\N
1402	12	110	1	logic_id 163		FwdLogicScript	\N
1403	17	110	1	logic_id 163		FwdLogicScript	\N
1404	18	110	1	logic_id 163		FwdLogicScript	\N
1405	28	110	1	logic_id 163		FwdLogicScript	\N
1406	31	110	1	logic_id 163		FwdLogicScript	\N
1407	10	105	1	logic_id 164		FwdLogicScript	\N
1408	10	110	1	logic_id 165		FwdLogicScript	\N
1409	10	111	1	logic_id 166		FwdLogicScript	\N
1410	10	75	1	logic_id 167		FwdLogicScript	\N
1411	27	75	1	logic_id 167		FwdLogicScript	\N
1412	34	75	1	logic_id 167		FwdLogicScript	\N
1413	7	76	1	logic_id 168		FwdLogicScript	\N
1414	10	76	1	logic_id 168		FwdLogicScript	\N
1415	27	76	1	logic_id 168		FwdLogicScript	\N
1416	34	76	1	logic_id 168		FwdLogicScript	\N
1417	33	108	1	logic_id 169		FwdLogicScript	\N
1418	34	108	1	logic_id 169		FwdLogicScript	\N
1419	36	108	1	logic_id 169		FwdLogicScript	\N
1420	2	116	1	logic_id 189		FwdLogicScript	\N
1421	3	116	1	logic_id 189		FwdLogicScript	\N
1422	4	116	1	logic_id 189		FwdLogicScript	\N
1423	5	116	1	logic_id 189		FwdLogicScript	\N
1424	14	116	1	logic_id 189		FwdLogicScript	\N
1425	24	116	1	logic_id 189		FwdLogicScript	\N
1426	2	117	1	logic_id 190		FwdLogicScript	\N
1427	3	117	1	logic_id 190		FwdLogicScript	\N
1428	4	117	1	logic_id 190		FwdLogicScript	\N
1429	5	117	1	logic_id 190		FwdLogicScript	\N
1430	14	117	1	logic_id 190		FwdLogicScript	\N
1431	24	117	1	logic_id 190		FwdLogicScript	\N
1432	8	114	1	logic_id 191		FwdLogicScript	\N
1433	10	114	1	logic_id 191		FwdLogicScript	\N
1434	17	114	1	logic_id 191		FwdLogicScript	\N
1435	18	114	1	logic_id 191		FwdLogicScript	\N
1436	9	114	1	logic_id 205		FwdLogicScript	\N
1437	14	114	1	logic_id 205		FwdLogicScript	\N
1438	24	114	1	logic_id 205		FwdLogicScript	\N
1439	27	114	1	logic_id 205		FwdLogicScript	\N
1440	33	114	1	logic_id 205		FwdLogicScript	\N
1441	34	114	1	logic_id 205		FwdLogicScript	\N
1442	36	114	1	logic_id 205		FwdLogicScript	\N
1443	7	115	1	logic_id 206		FwdLogicScript	\N
1444	8	115	1	logic_id 206		FwdLogicScript	\N
1445	9	115	1	logic_id 206		FwdLogicScript	\N
1446	14	115	1	logic_id 206		FwdLogicScript	\N
1447	17	115	1	logic_id 206		FwdLogicScript	\N
1448	18	115	1	logic_id 206		FwdLogicScript	\N
1449	24	115	1	logic_id 206		FwdLogicScript	\N
1450	27	115	1	logic_id 206		FwdLogicScript	\N
1451	33	115	1	logic_id 206		FwdLogicScript	\N
1452	34	115	1	logic_id 206		FwdLogicScript	\N
1453	36	115	1	logic_id 206		FwdLogicScript	\N
1454	33	28	1	logic_id 219		FwdLogicScript	\N
1455	33	29	1	logic_id 220		FwdLogicScript	\N
1456	10	69	1	logic_id 223		FwdLogicScript	\N
1457	10	70	1	logic_id 225		FwdLogicScript	\N
1458	7	14	1	logic_id 239		FwdLogicScript	\N
1459	27	14	1	logic_id 239		FwdLogicScript	\N
1460	34	14	1	logic_id 239		FwdLogicScript	\N
1461	10	18	1	logic_id 262		FwdLogicScript	\N
1462	10	19	1	logic_id 275		FwdLogicScript	\N
1463	27	126	1	logic_id 370		FwdLogicScript	\N
1464	33	126	1	logic_id 370		FwdLogicScript	\N
1465	34	126	1	logic_id 370		FwdLogicScript	\N
1466	7	127	1	logic_id 371		FwdLogicScript	\N
1467	27	127	1	logic_id 371		FwdLogicScript	\N
1468	33	127	1	logic_id 371		FwdLogicScript	\N
1469	34	127	1	logic_id 371		FwdLogicScript	\N
1470	36	126	1	logic_id 372		FwdLogicScript	\N
1471	10	131	1	logic_id 413		FwdLogicScript	\N
1472	24	131	1	logic_id 413		FwdLogicScript	\N
1473	6	11	1	logic_id 422		FwdLogicScript	\N
1474	7	11	1	logic_id 422		FwdLogicScript	\N
1475	27	11	1	logic_id 422		FwdLogicScript	\N
1476	33	11	1	logic_id 422		FwdLogicScript	\N
1477	34	11	1	logic_id 422		FwdLogicScript	\N
1478	35	11	1	logic_id 422		FwdLogicScript	\N
1479	36	11	1	logic_id 422		FwdLogicScript	\N
1480	2	134	1	logic_id 446		FwdLogicScript	\N
1481	3	134	1	logic_id 446		FwdLogicScript	\N
1482	4	134	1	logic_id 446		FwdLogicScript	\N
1483	5	134	1	logic_id 446		FwdLogicScript	\N
1484	10	71	1	logic_id 7		FwdLogicScript	\N
1485	10	72	1	logic_id 8		FwdLogicScript	\N
1486	10	84	1	logic_id 60		FwdLogicScript	\N
1487	10	87	1	logic_id 94		FwdLogicScript	\N
1488	33	31	1	logic_id 95		FwdLogicScript	\N
1489	33	74	1	logic_id 96		FwdLogicScript	\N
1490	33	30	1	logic_id 97		FwdLogicScript	\N
1491	33	73	1	logic_id 98		FwdLogicScript	\N
1492	33	35	1	logic_id 99		FwdLogicScript	\N
1493	33	34	1	logic_id 100		FwdLogicScript	\N
1494	22	60	1	logic_id 159		FwdLogicScript	\N
1495	8	109	1	logic_id 160		FwdLogicScript	\N
1496	9	109	1	logic_id 160		FwdLogicScript	\N
1497	10	109	1	logic_id 160		FwdLogicScript	\N
1498	11	109	1	logic_id 160		FwdLogicScript	\N
1499	12	109	1	logic_id 160		FwdLogicScript	\N
1500	17	109	1	logic_id 160		FwdLogicScript	\N
1501	18	109	1	logic_id 160		FwdLogicScript	\N
1502	28	109	1	logic_id 160		FwdLogicScript	\N
1503	31	109	1	logic_id 160		FwdLogicScript	\N
1504	10	115	1	logic_id 206		FwdLogicScript	\N
1505	33	14	1	logic_id 239		FwdLogicScript	\N
1506	6	14	1	logic_id 241		FwdLogicScript	\N
1507	36	14	1	logic_id 241		FwdLogicScript	\N
1508	6	34	1	logic_id 271		FwdLogicScript	\N
1509	6	35	1	logic_id 284		FwdLogicScript	\N
1510	36	34	1	logic_id 358		FwdLogicScript	\N
1511	36	35	1	logic_id 360		FwdLogicScript	\N
1513	1	80	1	symmetry		SymmScript	\N
1514	6	78	1	symmetry		SymmScript	\N
1515	6	80	1	symmetry		SymmScript	\N
1516	6	127	1	symmetry		SymmScript	\N
1517	33	78	1	symmetry		SymmScript	\N
1518	33	80	1	symmetry		SymmScript	\N
1519	11	60	1	logic_id 159		FwdLogicScript	\N
1520	12	60	1	logic_id 159		FwdLogicScript	\N
1521	28	60	1	logic_id 159		FwdLogicScript	\N
1522	31	60	1	logic_id 159		FwdLogicScript	\N
1523	2	80	1	logic_id 460		FwdLogicScript	\N
1524	3	80	1	logic_id 460		FwdLogicScript	\N
1525	4	80	1	logic_id 460		FwdLogicScript	\N
1526	5	80	1	logic_id 460		FwdLogicScript	\N
1527	7	80	1	logic_id 460		FwdLogicScript	\N
1528	8	80	1	logic_id 460		FwdLogicScript	\N
1529	9	80	1	logic_id 460		FwdLogicScript	\N
1530	10	80	1	logic_id 460		FwdLogicScript	\N
1531	14	80	1	logic_id 460		FwdLogicScript	\N
1532	17	80	1	logic_id 460		FwdLogicScript	\N
1533	18	80	1	logic_id 460		FwdLogicScript	\N
1534	24	80	1	logic_id 460		FwdLogicScript	\N
1535	27	80	1	logic_id 460		FwdLogicScript	\N
1536	30	80	1	logic_id 460		FwdLogicScript	\N
1537	34	80	1	logic_id 460		FwdLogicScript	\N
1538	36	80	1	logic_id 460		FwdLogicScript	\N
1539	2	78	1	logic_id 463		FwdLogicScript	\N
1540	3	78	1	logic_id 463		FwdLogicScript	\N
1541	4	78	1	logic_id 463		FwdLogicScript	\N
1542	5	78	1	logic_id 463		FwdLogicScript	\N
1543	7	78	1	logic_id 463		FwdLogicScript	\N
1544	8	78	1	logic_id 463		FwdLogicScript	\N
1545	9	78	1	logic_id 463		FwdLogicScript	\N
1546	10	78	1	logic_id 463		FwdLogicScript	\N
1547	14	78	1	logic_id 463		FwdLogicScript	\N
1548	17	78	1	logic_id 463		FwdLogicScript	\N
1549	18	78	1	logic_id 463		FwdLogicScript	\N
1550	22	78	1	logic_id 463		FwdLogicScript	\N
1551	24	78	1	logic_id 463		FwdLogicScript	\N
1552	27	78	1	logic_id 463		FwdLogicScript	\N
1553	30	78	1	logic_id 463		FwdLogicScript	\N
1554	34	78	1	logic_id 463		FwdLogicScript	\N
1555	36	78	1	logic_id 463		FwdLogicScript	\N
1556	24	1	0	logic_id=2		BkwdLogicScript	\N
1557	31	4	0	logic_id=7		BkwdLogicScript	\N
1558	31	5	0	logic_id=8		BkwdLogicScript	\N
1559	22	2	0	logic_id=9		BkwdLogicScript	\N
1560	33	2	0	logic_id=9		BkwdLogicScript	\N
1561	36	2	0	logic_id=9		BkwdLogicScript	\N
1562	31	2	0	logic_id=9		BkwdLogicScript	\N
1563	33	3	0	logic_id=11		BkwdLogicScript	\N
1564	36	3	0	logic_id=11		BkwdLogicScript	\N
1565	31	3	0	logic_id=11		BkwdLogicScript	\N
1566	22	3	0	logic_id=12		BkwdLogicScript	\N
1567	15	135	0	logic_id=19		BkwdLogicScript	\N
1568	25	135	0	logic_id=19		BkwdLogicScript	\N
1569	14	6	0	logic_id=20		BkwdLogicScript	\N
1570	6	6	0	logic_id=22		BkwdLogicScript	\N
1571	36	6	0	logic_id=22		BkwdLogicScript	\N
1572	10	13	0	logic_id=26		BkwdLogicScript	\N
1573	24	13	0	logic_id=30		BkwdLogicScript	\N
1574	13	37	0	logic_id=49		BkwdLogicScript	\N
1575	14	37	0	logic_id=49		BkwdLogicScript	\N
1576	29	37	0	logic_id=49		BkwdLogicScript	\N
1577	13	36	0	logic_id=51		BkwdLogicScript	\N
1578	14	36	0	logic_id=51		BkwdLogicScript	\N
1579	29	36	0	logic_id=51		BkwdLogicScript	\N
1580	29	14	0	logic_id=54		BkwdLogicScript	\N
1581	30	14	0	logic_id=54		BkwdLogicScript	\N
1582	31	14	0	logic_id=54		BkwdLogicScript	\N
1583	15	83	0	logic_id=61		BkwdLogicScript	\N
1584	33	19	0	logic_id=69		BkwdLogicScript	\N
1585	36	19	0	logic_id=69		BkwdLogicScript	\N
1586	31	19	0	logic_id=69		BkwdLogicScript	\N
1587	22	18	0	logic_id=71		BkwdLogicScript	\N
1588	33	18	0	logic_id=71		BkwdLogicScript	\N
1589	36	18	0	logic_id=71		BkwdLogicScript	\N
1590	31	18	0	logic_id=71		BkwdLogicScript	\N
1591	13	39	0	logic_id=72		BkwdLogicScript	\N
1592	14	39	0	logic_id=72		BkwdLogicScript	\N
1593	29	39	0	logic_id=72		BkwdLogicScript	\N
1594	13	38	0	logic_id=73		BkwdLogicScript	\N
1595	14	38	0	logic_id=73		BkwdLogicScript	\N
1596	29	38	0	logic_id=73		BkwdLogicScript	\N
1597	15	91	0	logic_id=92		BkwdLogicScript	\N
1598	35	91	0	logic_id=92		BkwdLogicScript	\N
1599	29	31	0	logic_id=99		BkwdLogicScript	\N
1600	30	31	0	logic_id=99		BkwdLogicScript	\N
1601	31	31	0	logic_id=99		BkwdLogicScript	\N
1602	29	30	0	logic_id=100		BkwdLogicScript	\N
1603	31	30	0	logic_id=100		BkwdLogicScript	\N
1604	33	17	0	logic_id=103		BkwdLogicScript	\N
1605	31	17	0	logic_id=103		BkwdLogicScript	\N
1606	22	16	0	logic_id=106		BkwdLogicScript	\N
1607	33	16	0	logic_id=106		BkwdLogicScript	\N
1608	31	16	0	logic_id=106		BkwdLogicScript	\N
1609	1	45	0	logic_id=107		BkwdLogicScript	\N
1610	28	45	0	logic_id=107		BkwdLogicScript	\N
1611	6	45	0	logic_id=107		BkwdLogicScript	\N
1612	33	45	0	logic_id=107		BkwdLogicScript	\N
1613	36	45	0	logic_id=107		BkwdLogicScript	\N
1614	31	45	0	logic_id=107		BkwdLogicScript	\N
1615	22	45	0	logic_id=107		BkwdLogicScript	\N
1616	7	45	0	logic_id=108		BkwdLogicScript	\N
1617	15	46	0	logic_id=133		BkwdLogicScript	\N
1618	35	56	0	logic_id=135		BkwdLogicScript	\N
1619	15	81	0	logic_id=142		BkwdLogicScript	\N
1620	15	82	0	logic_id=143		BkwdLogicScript	\N
1621	35	70	0	logic_id=152		BkwdLogicScript	\N
1622	35	69	0	logic_id=153		BkwdLogicScript	\N
1623	27	110	0	logic_id=160		BkwdLogicScript	\N
1624	27	111	0	logic_id=161		BkwdLogicScript	\N
1625	27	105	0	logic_id=162		BkwdLogicScript	\N
1626	27	54	0	logic_id=164		BkwdLogicScript	\N
1627	27	59	0	logic_id=165		BkwdLogicScript	\N
1628	27	58	0	logic_id=166		BkwdLogicScript	\N
1629	15	77	0	logic_id=173		BkwdLogicScript	\N
1630	15	79	0	logic_id=174		BkwdLogicScript	\N
1631	36	59	0	logic_id=179		BkwdLogicScript	\N
1632	36	58	0	logic_id=180		BkwdLogicScript	\N
1633	15	120	0	logic_id=193		BkwdLogicScript	\N
1634	15	121	0	logic_id=194		BkwdLogicScript	\N
1635	25	1	0	logic_id=201		BkwdLogicScript	\N
1636	26	1	0	logic_id=201		BkwdLogicScript	\N
1637	27	9	0	logic_id=221		BkwdLogicScript	\N
1638	15	126	0	logic_id=222		BkwdLogicScript	\N
1639	35	126	0	logic_id=223		BkwdLogicScript	\N
1640	15	127	0	logic_id=224		BkwdLogicScript	\N
1641	35	127	0	logic_id=225		BkwdLogicScript	\N
1642	35	40	0	logic_id=226		BkwdLogicScript	\N
1643	35	41	0	logic_id=227		BkwdLogicScript	\N
1644	15	124	0	logic_id=228		BkwdLogicScript	\N
1645	15	125	0	logic_id=229		BkwdLogicScript	\N
1646	11	33	0	logic_id=230		BkwdLogicScript	\N
1647	13	33	0	logic_id=230		BkwdLogicScript	\N
1648	29	33	0	logic_id=230		BkwdLogicScript	\N
1649	35	63	0	logic_id=230		BkwdLogicScript	\N
1650	25	33	0	logic_id=230		BkwdLogicScript	\N
1651	6	37	0	logic_id=231		BkwdLogicScript	\N
1652	36	37	0	logic_id=231		BkwdLogicScript	\N
1653	6	36	0	logic_id=232		BkwdLogicScript	\N
1654	36	36	0	logic_id=232		BkwdLogicScript	\N
1655	10	12	0	logic_id=233		BkwdLogicScript	\N
1656	10	38	0	logic_id=237		BkwdLogicScript	\N
1657	10	39	0	logic_id=238		BkwdLogicScript	\N
1658	10	34	0	logic_id=239		BkwdLogicScript	\N
1659	10	35	0	logic_id=240		BkwdLogicScript	\N
1660	10	11	0	logic_id=241		BkwdLogicScript	\N
1661	31	1	0	logic_id=241		BkwdLogicScript	\N
1662	10	97	0	logic_id=246		BkwdLogicScript	\N
1663	6	98	0	logic_id=247		BkwdLogicScript	\N
1664	36	98	0	logic_id=247		BkwdLogicScript	\N
1665	6	95	0	logic_id=253		BkwdLogicScript	\N
1666	36	95	0	logic_id=253		BkwdLogicScript	\N
1667	33	95	0	logic_id=253		BkwdLogicScript	\N
1668	24	12	0	logic_id=255		BkwdLogicScript	\N
1669	22	56	0	logic_id=258		BkwdLogicScript	\N
1670	1	50	0	logic_id=264		BkwdLogicScript	\N
1671	6	50	0	logic_id=264		BkwdLogicScript	\N
1672	7	50	0	logic_id=264		BkwdLogicScript	\N
1673	1	51	0	logic_id=265		BkwdLogicScript	\N
1674	6	51	0	logic_id=265		BkwdLogicScript	\N
1675	7	51	0	logic_id=265		BkwdLogicScript	\N
1676	1	102	0	logic_id=267		BkwdLogicScript	\N
1677	6	102	0	logic_id=267		BkwdLogicScript	\N
1678	7	102	0	logic_id=268		BkwdLogicScript	\N
1679	1	84	0	logic_id=269		BkwdLogicScript	\N
1680	6	84	0	logic_id=269		BkwdLogicScript	\N
1681	7	84	0	logic_id=269		BkwdLogicScript	\N
1682	22	51	0	logic_id=277		BkwdLogicScript	\N
1683	22	50	0	logic_id=278		BkwdLogicScript	\N
1684	1	103	0	logic_id=280		BkwdLogicScript	\N
1685	6	103	0	logic_id=280		BkwdLogicScript	\N
1686	7	103	0	logic_id=280		BkwdLogicScript	\N
1687	22	103	0	logic_id=280		BkwdLogicScript	\N
1688	22	84	0	logic_id=282		BkwdLogicScript	\N
1689	30	11	0	logic_id=284		BkwdLogicScript	\N
1690	10	32	0	logic_id=288		BkwdLogicScript	\N
1691	10	9	0	logic_id=289		BkwdLogicScript	\N
1692	10	37	0	logic_id=291		BkwdLogicScript	\N
1693	35	51	0	logic_id=297		BkwdLogicScript	\N
1694	15	26	0	logic_id=302		BkwdLogicScript	\N
1695	10	36	0	logic_id=307		BkwdLogicScript	\N
1696	35	50	0	logic_id=313		BkwdLogicScript	\N
1697	14	33	0	logic_id=314		BkwdLogicScript	\N
1698	6	116	0	logic_id=314		BkwdLogicScript	\N
1699	36	116	0	logic_id=314		BkwdLogicScript	\N
1700	7	3	0	logic_id=315		BkwdLogicScript	\N
1701	9	10	0	logic_id=315		BkwdLogicScript	\N
1702	6	117	0	logic_id=322		BkwdLogicScript	\N
1703	36	117	0	logic_id=322		BkwdLogicScript	\N
1704	24	9	0	logic_id=332		BkwdLogicScript	\N
1705	15	122	0	logic_id=334		BkwdLogicScript	\N
1706	15	123	0	logic_id=342		BkwdLogicScript	\N
1707	6	120	0	logic_id=344		BkwdLogicScript	\N
1708	7	120	0	logic_id=344		BkwdLogicScript	\N
1709	35	120	0	logic_id=344		BkwdLogicScript	\N
1710	6	121	0	logic_id=346		BkwdLogicScript	\N
1711	7	121	0	logic_id=346		BkwdLogicScript	\N
1712	35	121	0	logic_id=346		BkwdLogicScript	\N
1713	36	120	0	logic_id=347		BkwdLogicScript	\N
1714	36	121	0	logic_id=348		BkwdLogicScript	\N
1715	14	10	0	logic_id=351		BkwdLogicScript	\N
1716	29	10	0	logic_id=351		BkwdLogicScript	\N
1717	10	10	0	logic_id=351		BkwdLogicScript	\N
1718	6	96	0	logic_id=355		BkwdLogicScript	\N
1719	6	12	0	logic_id=362		BkwdLogicScript	\N
1720	36	12	0	logic_id=362		BkwdLogicScript	\N
1721	30	124	0	logic_id=364		BkwdLogicScript	\N
1722	35	124	0	logic_id=370		BkwdLogicScript	\N
1723	35	125	0	logic_id=371		BkwdLogicScript	\N
1724	24	14	0	logic_id=400		BkwdLogicScript	\N
1725	25	14	0	logic_id=400		BkwdLogicScript	\N
1726	26	14	0	logic_id=400		BkwdLogicScript	\N
1727	31	24	0	logic_id=408		BkwdLogicScript	\N
1728	11	24	0	logic_id=408		BkwdLogicScript	\N
1729	13	24	0	logic_id=408		BkwdLogicScript	\N
1730	29	24	0	logic_id=408		BkwdLogicScript	\N
1731	25	24	0	logic_id=408		BkwdLogicScript	\N
1732	14	24	0	logic_id=408		BkwdLogicScript	\N
1733	31	25	0	logic_id=410		BkwdLogicScript	\N
1734	11	25	0	logic_id=410		BkwdLogicScript	\N
1735	13	25	0	logic_id=410		BkwdLogicScript	\N
1736	29	25	0	logic_id=410		BkwdLogicScript	\N
1737	25	25	0	logic_id=410		BkwdLogicScript	\N
1738	14	25	0	logic_id=410		BkwdLogicScript	\N
1739	33	26	0	logic_id=414		BkwdLogicScript	\N
1740	36	26	0	logic_id=414		BkwdLogicScript	\N
1741	31	26	0	logic_id=414		BkwdLogicScript	\N
1742	33	27	0	logic_id=415		BkwdLogicScript	\N
1743	36	27	0	logic_id=415		BkwdLogicScript	\N
1744	31	27	0	logic_id=415		BkwdLogicScript	\N
1745	30	10	0	logic_id=422		BkwdLogicScript	\N
1746	9	33	0	logic_id=423		BkwdLogicScript	\N
1747	10	33	0	logic_id=423		BkwdLogicScript	\N
1748	30	33	0	logic_id=423		BkwdLogicScript	\N
1749	6	22	0	logic_id=426		BkwdLogicScript	\N
1750	6	23	0	logic_id=427		BkwdLogicScript	\N
1751	14	11	0	logic_id=428		BkwdLogicScript	\N
1752	24	11	0	logic_id=428		BkwdLogicScript	\N
1753	30	13	0	logic_id=429		BkwdLogicScript	\N
1754	35	13	0	logic_id=429		BkwdLogicScript	\N
1755	30	40	0	logic_id=433		BkwdLogicScript	\N
1756	6	63	0	logic_id=436		BkwdLogicScript	\N
1757	36	63	0	logic_id=436		BkwdLogicScript	\N
1758	6	135	0	logic_id=439		BkwdLogicScript	\N
1759	7	135	0	logic_id=439		BkwdLogicScript	\N
1760	9	135	0	logic_id=439		BkwdLogicScript	\N
1761	15	131	0	logic_id=441		BkwdLogicScript	\N
1762	22	131	0	logic_id=441		BkwdLogicScript	\N
1763	27	131	0	logic_id=441		BkwdLogicScript	\N
1764	15	133	0	logic_id=445		BkwdLogicScript	\N
1765	35	133	0	logic_id=445		BkwdLogicScript	\N
1766	22	133	0	logic_id=445		BkwdLogicScript	\N
1767	13	12	0	logic_id=448		BkwdLogicScript	\N
1768	14	12	0	logic_id=448		BkwdLogicScript	\N
1769	29	12	0	logic_id=448		BkwdLogicScript	\N
1770	27	12	0	logic_id=448		BkwdLogicScript	\N
1771	6	94	0	logic_id=458		BkwdLogicScript	\N
1772	36	94	0	logic_id=458		BkwdLogicScript	\N
1773	33	94	0	logic_id=458		BkwdLogicScript	\N
1774	15	80	0	logic_id=461		BkwdLogicScript	\N
1775	15	78	0	logic_id=462		BkwdLogicScript	\N
1776	27	2	0	logic_id=10		BkwdLogicScript	\N
1777	27	3	0	logic_id=12		BkwdLogicScript	\N
1778	25	6	0	logic_id=17		BkwdLogicScript	\N
1779	7	6	0	logic_id=17		BkwdLogicScript	\N
1780	9	6	0	logic_id=17		BkwdLogicScript	\N
1781	10	6	0	logic_id=18		BkwdLogicScript	\N
1782	24	6	0	logic_id=18		BkwdLogicScript	\N
1783	30	6	0	logic_id=18		BkwdLogicScript	\N
1784	35	6	0	logic_id=18		BkwdLogicScript	\N
1785	33	6	0	logic_id=22		BkwdLogicScript	\N
1786	31	6	0	logic_id=22		BkwdLogicScript	\N
1787	22	6	0	logic_id=23		BkwdLogicScript	\N
1788	13	7	0	logic_id=24		BkwdLogicScript	\N
1789	14	7	0	logic_id=24		BkwdLogicScript	\N
1790	29	7	0	logic_id=24		BkwdLogicScript	\N
1791	36	7	0	logic_id=24		BkwdLogicScript	\N
1792	10	7	0	logic_id=24		BkwdLogicScript	\N
1793	29	13	0	logic_id=26		BkwdLogicScript	\N
1794	31	13	0	logic_id=26		BkwdLogicScript	\N
1795	25	13	0	logic_id=26		BkwdLogicScript	\N
1796	26	13	0	logic_id=26		BkwdLogicScript	\N
1797	33	8	0	logic_id=32		BkwdLogicScript	\N
1798	36	8	0	logic_id=32		BkwdLogicScript	\N
1799	31	8	0	logic_id=32		BkwdLogicScript	\N
1800	10	8	0	logic_id=34		BkwdLogicScript	\N
1801	22	8	0	logic_id=36		BkwdLogicScript	\N
1802	13	8	0	logic_id=38		BkwdLogicScript	\N
1803	14	8	0	logic_id=38		BkwdLogicScript	\N
1804	29	8	0	logic_id=38		BkwdLogicScript	\N
1805	27	37	0	logic_id=49		BkwdLogicScript	\N
1806	24	37	0	logic_id=49		BkwdLogicScript	\N
1807	9	37	0	logic_id=50		BkwdLogicScript	\N
1808	30	37	0	logic_id=50		BkwdLogicScript	\N
1809	27	36	0	logic_id=51		BkwdLogicScript	\N
1810	24	36	0	logic_id=51		BkwdLogicScript	\N
1811	9	36	0	logic_id=52		BkwdLogicScript	\N
1812	30	36	0	logic_id=52		BkwdLogicScript	\N
1813	14	14	0	logic_id=53		BkwdLogicScript	\N
1814	10	15	0	logic_id=56		BkwdLogicScript	\N
1815	24	15	0	logic_id=56		BkwdLogicScript	\N
1816	6	15	0	logic_id=56		BkwdLogicScript	\N
1817	36	15	0	logic_id=56		BkwdLogicScript	\N
1818	13	15	0	logic_id=56		BkwdLogicScript	\N
1819	14	15	0	logic_id=56		BkwdLogicScript	\N
1820	29	15	0	logic_id=56		BkwdLogicScript	\N
1821	27	15	0	logic_id=56		BkwdLogicScript	\N
1822	35	15	0	logic_id=59		BkwdLogicScript	\N
1823	1	83	0	logic_id=60		BkwdLogicScript	\N
1824	6	83	0	logic_id=60		BkwdLogicScript	\N
1825	7	83	0	logic_id=60		BkwdLogicScript	\N
1826	22	83	0	logic_id=60		BkwdLogicScript	\N
1827	35	83	0	logic_id=63		BkwdLogicScript	\N
1828	29	32	0	logic_id=66		BkwdLogicScript	\N
1829	30	32	0	logic_id=66		BkwdLogicScript	\N
1830	31	32	0	logic_id=66		BkwdLogicScript	\N
1831	27	39	0	logic_id=72		BkwdLogicScript	\N
1832	24	39	0	logic_id=72		BkwdLogicScript	\N
1833	27	38	0	logic_id=73		BkwdLogicScript	\N
1834	24	38	0	logic_id=73		BkwdLogicScript	\N
1835	1	44	0	logic_id=74		BkwdLogicScript	\N
1836	28	44	0	logic_id=74		BkwdLogicScript	\N
1837	6	44	0	logic_id=74		BkwdLogicScript	\N
1838	33	44	0	logic_id=74		BkwdLogicScript	\N
1839	36	44	0	logic_id=74		BkwdLogicScript	\N
1840	31	44	0	logic_id=74		BkwdLogicScript	\N
1841	22	44	0	logic_id=74		BkwdLogicScript	\N
1842	7	44	0	logic_id=74		BkwdLogicScript	\N
1843	30	9	0	logic_id=80		BkwdLogicScript	\N
1844	1	12	0	logic_id=86		BkwdLogicScript	\N
1845	7	12	0	logic_id=86		BkwdLogicScript	\N
1846	22	12	0	logic_id=86		BkwdLogicScript	\N
1847	29	29	0	logic_id=95		BkwdLogicScript	\N
1848	30	29	0	logic_id=95		BkwdLogicScript	\N
1849	31	29	0	logic_id=95		BkwdLogicScript	\N
1850	29	28	0	logic_id=97		BkwdLogicScript	\N
1851	31	28	0	logic_id=97		BkwdLogicScript	\N
1852	10	31	0	logic_id=99		BkwdLogicScript	\N
1853	10	30	0	logic_id=100		BkwdLogicScript	\N
1854	27	45	0	logic_id=107		BkwdLogicScript	\N
1855	35	57	0	logic_id=111		BkwdLogicScript	\N
1856	22	57	0	logic_id=111		BkwdLogicScript	\N
1857	31	23	0	logic_id=120		BkwdLogicScript	\N
1858	11	23	0	logic_id=120		BkwdLogicScript	\N
1859	13	23	0	logic_id=120		BkwdLogicScript	\N
1860	29	23	0	logic_id=120		BkwdLogicScript	\N
1861	25	23	0	logic_id=120		BkwdLogicScript	\N
1862	14	23	0	logic_id=120		BkwdLogicScript	\N
1863	31	22	0	logic_id=123		BkwdLogicScript	\N
1864	11	22	0	logic_id=123		BkwdLogicScript	\N
1865	13	22	0	logic_id=123		BkwdLogicScript	\N
1866	29	22	0	logic_id=123		BkwdLogicScript	\N
1867	25	22	0	logic_id=123		BkwdLogicScript	\N
1868	14	22	0	logic_id=123		BkwdLogicScript	\N
1869	1	47	0	logic_id=126		BkwdLogicScript	\N
1870	6	47	0	logic_id=126		BkwdLogicScript	\N
1871	7	47	0	logic_id=126		BkwdLogicScript	\N
1872	22	47	0	logic_id=126		BkwdLogicScript	\N
1873	35	47	0	logic_id=126		BkwdLogicScript	\N
1874	1	46	0	logic_id=131		BkwdLogicScript	\N
1875	6	46	0	logic_id=131		BkwdLogicScript	\N
1876	7	46	0	logic_id=131		BkwdLogicScript	\N
1877	22	46	0	logic_id=131		BkwdLogicScript	\N
1878	35	46	0	logic_id=131		BkwdLogicScript	\N
1879	36	54	0	logic_id=138		BkwdLogicScript	\N
1880	1	58	0	logic_id=144		BkwdLogicScript	\N
1881	6	58	0	logic_id=144		BkwdLogicScript	\N
1882	7	58	0	logic_id=144		BkwdLogicScript	\N
1883	22	58	0	logic_id=144		BkwdLogicScript	\N
1884	35	58	0	logic_id=144		BkwdLogicScript	\N
1885	1	59	0	logic_id=146		BkwdLogicScript	\N
1886	6	59	0	logic_id=146		BkwdLogicScript	\N
1887	7	59	0	logic_id=146		BkwdLogicScript	\N
1888	22	59	0	logic_id=146		BkwdLogicScript	\N
1889	35	59	0	logic_id=146		BkwdLogicScript	\N
1890	35	72	0	logic_id=148		BkwdLogicScript	\N
1891	35	71	0	logic_id=150		BkwdLogicScript	\N
1892	6	112	0	logic_id=187		BkwdLogicScript	\N
1893	36	112	0	logic_id=187		BkwdLogicScript	\N
1894	6	113	0	logic_id=188		BkwdLogicScript	\N
1895	36	113	0	logic_id=188		BkwdLogicScript	\N
1896	6	118	0	logic_id=189		BkwdLogicScript	\N
1897	36	118	0	logic_id=189		BkwdLogicScript	\N
1898	6	119	0	logic_id=190		BkwdLogicScript	\N
1899	36	119	0	logic_id=190		BkwdLogicScript	\N
1900	36	46	0	logic_id=195		BkwdLogicScript	\N
1901	36	47	0	logic_id=196		BkwdLogicScript	\N
1902	15	95	0	logic_id=217		BkwdLogicScript	\N
1903	31	95	0	logic_id=217		BkwdLogicScript	\N
1904	31	94	0	logic_id=218		BkwdLogicScript	\N
1905	29	96	0	logic_id=219		BkwdLogicScript	\N
1906	31	96	0	logic_id=219		BkwdLogicScript	\N
1907	30	96	0	logic_id=220		BkwdLogicScript	\N
1908	7	37	0	logic_id=231		BkwdLogicScript	\N
1909	33	37	0	logic_id=231		BkwdLogicScript	\N
1910	7	36	0	logic_id=232		BkwdLogicScript	\N
1911	33	36	0	logic_id=232		BkwdLogicScript	\N
1912	6	38	0	logic_id=237		BkwdLogicScript	\N
1913	36	38	0	logic_id=237		BkwdLogicScript	\N
1914	1	38	0	logic_id=237		BkwdLogicScript	\N
1915	7	38	0	logic_id=237		BkwdLogicScript	\N
1916	6	39	0	logic_id=238		BkwdLogicScript	\N
1917	36	39	0	logic_id=238		BkwdLogicScript	\N
1918	1	39	0	logic_id=238		BkwdLogicScript	\N
1919	7	39	0	logic_id=238		BkwdLogicScript	\N
1920	6	97	0	logic_id=246		BkwdLogicScript	\N
1921	36	97	0	logic_id=246		BkwdLogicScript	\N
1922	27	97	0	logic_id=246		BkwdLogicScript	\N
1923	1	97	0	logic_id=246		BkwdLogicScript	\N
1924	7	97	0	logic_id=246		BkwdLogicScript	\N
1925	7	98	0	logic_id=247		BkwdLogicScript	\N
1926	9	98	0	logic_id=247		BkwdLogicScript	\N
1927	10	98	0	logic_id=247		BkwdLogicScript	\N
1928	33	98	0	logic_id=247		BkwdLogicScript	\N
1929	35	12	0	logic_id=255		BkwdLogicScript	\N
1930	6	52	0	logic_id=263		BkwdLogicScript	\N
1931	36	52	0	logic_id=263		BkwdLogicScript	\N
1932	27	50	0	logic_id=264		BkwdLogicScript	\N
1933	27	51	0	logic_id=265		BkwdLogicScript	\N
1934	27	102	0	logic_id=267		BkwdLogicScript	\N
1935	27	84	0	logic_id=269		BkwdLogicScript	\N
1936	6	53	0	logic_id=276		BkwdLogicScript	\N
1937	36	53	0	logic_id=276		BkwdLogicScript	\N
1938	27	103	0	logic_id=280		BkwdLogicScript	\N
1939	22	86	0	logic_id=283		BkwdLogicScript	\N
1940	10	27	0	logic_id=286		BkwdLogicScript	\N
1941	36	51	0	logic_id=287		BkwdLogicScript	\N
1942	10	26	0	logic_id=302		BkwdLogicScript	\N
1943	36	50	0	logic_id=303		BkwdLogicScript	\N
1944	7	116	0	logic_id=314		BkwdLogicScript	\N
1945	24	33	0	logic_id=314		BkwdLogicScript	\N
1946	35	116	0	logic_id=314		BkwdLogicScript	\N
1947	33	116	0	logic_id=314		BkwdLogicScript	\N
1948	7	117	0	logic_id=322		BkwdLogicScript	\N
1949	35	117	0	logic_id=322		BkwdLogicScript	\N
1950	33	117	0	logic_id=322		BkwdLogicScript	\N
1951	33	54	0	logic_id=326		BkwdLogicScript	\N
1952	10	28	0	logic_id=326		BkwdLogicScript	\N
1953	10	29	0	logic_id=327		BkwdLogicScript	\N
1954	9	55	0	logic_id=330		BkwdLogicScript	\N
1955	31	55	0	logic_id=330		BkwdLogicScript	\N
1956	31	56	0	logic_id=331		BkwdLogicScript	\N
1957	33	122	0	logic_id=341		BkwdLogicScript	\N
1958	36	122	0	logic_id=341		BkwdLogicScript	\N
1959	31	122	0	logic_id=341		BkwdLogicScript	\N
1960	33	123	0	logic_id=342		BkwdLogicScript	\N
1961	36	123	0	logic_id=342		BkwdLogicScript	\N
1962	31	123	0	logic_id=342		BkwdLogicScript	\N
1963	9	104	0	logic_id=343		BkwdLogicScript	\N
1964	27	120	0	logic_id=344		BkwdLogicScript	\N
1965	27	121	0	logic_id=346		BkwdLogicScript	\N
1966	33	120	0	logic_id=347		BkwdLogicScript	\N
1967	33	121	0	logic_id=348		BkwdLogicScript	\N
1968	27	116	0	logic_id=351		BkwdLogicScript	\N
1969	24	10	0	logic_id=351		BkwdLogicScript	\N
1970	27	117	0	logic_id=353		BkwdLogicScript	\N
1971	33	12	0	logic_id=362		BkwdLogicScript	\N
1972	33	59	0	logic_id=373		BkwdLogicScript	\N
1973	33	58	0	logic_id=375		BkwdLogicScript	\N
1974	9	112	0	logic_id=398		BkwdLogicScript	\N
1975	9	24	0	logic_id=408		BkwdLogicScript	\N
1976	10	24	0	logic_id=408		BkwdLogicScript	\N
1977	30	24	0	logic_id=408		BkwdLogicScript	\N
1978	24	24	0	logic_id=408		BkwdLogicScript	\N
1979	35	24	0	logic_id=409		BkwdLogicScript	\N
1980	9	25	0	logic_id=410		BkwdLogicScript	\N
1981	10	25	0	logic_id=410		BkwdLogicScript	\N
1982	30	25	0	logic_id=410		BkwdLogicScript	\N
1983	24	25	0	logic_id=410		BkwdLogicScript	\N
1984	35	25	0	logic_id=411		BkwdLogicScript	\N
1985	30	22	0	logic_id=426		BkwdLogicScript	\N
1986	30	23	0	logic_id=427		BkwdLogicScript	\N
1987	7	63	0	logic_id=436		BkwdLogicScript	\N
1988	33	63	0	logic_id=436		BkwdLogicScript	\N
1989	6	54	0	logic_id=437		BkwdLogicScript	\N
1990	13	135	0	logic_id=439		BkwdLogicScript	\N
1991	14	135	0	logic_id=439		BkwdLogicScript	\N
1992	29	135	0	logic_id=439		BkwdLogicScript	\N
1993	36	135	0	logic_id=439		BkwdLogicScript	\N
1994	10	135	0	logic_id=439		BkwdLogicScript	\N
1995	22	135	0	logic_id=440		BkwdLogicScript	\N
1996	27	135	0	logic_id=440		BkwdLogicScript	\N
1997	36	131	0	logic_id=441		BkwdLogicScript	\N
1998	33	131	0	logic_id=441		BkwdLogicScript	\N
1999	6	131	0	logic_id=441		BkwdLogicScript	\N
2000	35	131	0	logic_id=442		BkwdLogicScript	\N
2001	35	55	0	logic_id=443		BkwdLogicScript	\N
2002	22	55	0	logic_id=443		BkwdLogicScript	\N
2003	31	133	0	logic_id=445		BkwdLogicScript	\N
2004	30	12	0	logic_id=448		BkwdLogicScript	\N
2005	30	28	0	logic_id=449		BkwdLogicScript	\N
2006	35	14	1	logic_id=464		FwdLogicScript	\N
2007	6	32	1	logic_id=465		FwdLogicScript	\N
2008	7	32	1	logic_id=465		FwdLogicScript	\N
2009	27	32	1	logic_id=465		FwdLogicScript	\N
2010	33	32	1	logic_id=465		FwdLogicScript	\N
2011	34	32	1	logic_id=465		FwdLogicScript	\N
2012	35	32	1	logic_id=465		FwdLogicScript	\N
2013	36	32	1	logic_id=465		FwdLogicScript	\N
2014	1	17	1			rschwiebert	\N
2015	35	35	1	logic_id=54		FwdLogicScript	\N
2016	35	34	1	logic_id=55		FwdLogicScript	\N
2017	6	31	1	logic_id=66		FwdLogicScript	\N
2018	35	31	1	logic_id=66		FwdLogicScript	\N
2019	36	31	1	logic_id=66		FwdLogicScript	\N
2020	6	30	1	logic_id=67		FwdLogicScript	\N
2021	35	30	1	logic_id=67		FwdLogicScript	\N
2022	36	30	1	logic_id=67		FwdLogicScript	\N
2023	1	23	1	logic_id=101		FwdLogicScript	\N
2024	1	19	1	logic_id=103		FwdLogicScript	\N
2025	1	21	1	logic_id=119		FwdLogicScript	\N
2026	1	25	1	logic_id=120		FwdLogicScript	\N
2027	1	94	1	logic_id=216		FwdLogicScript	\N
2028	1	27	1	logic_id=218		FwdLogicScript	\N
2029	1	16	1	logic_id=250		FwdLogicScript	\N
2030	1	18	1	logic_id=251		FwdLogicScript	\N
2031	1	125	1	logic_id=378		FwdLogicScript	\N
2032	35	130	1	logic_id=400		FwdLogicScript	\N
2033	35	129	1	logic_id=401		FwdLogicScript	\N
2034	35	128	1	logic_id=402		FwdLogicScript	\N
2035	1	33	1	logic_id=410		FwdLogicScript	\N
2036	1	24	1	logic_id=416		FwdLogicScript	\N
2037	1	10	1	logic_id=423		FwdLogicScript	\N
2038	1	96	1	logic_id=427		FwdLogicScript	\N
2039	1	14	1	logic_id=464		FwdLogicScript	\N
2040	1	32	1	logic_id=465		FwdLogicScript	\N
2041	1	11	1	logic_id=53		FwdLogicScript	\N
2042	1	35	1	logic_id=54		FwdLogicScript	\N
2043	1	34	1	logic_id=55		FwdLogicScript	\N
2044	1	29	1	logic_id=64		FwdLogicScript	\N
2045	1	31	1	logic_id=66		FwdLogicScript	\N
2046	1	30	1	logic_id=67		FwdLogicScript	\N
2047	1	20	1	logic_id=70		FwdLogicScript	\N
2048	1	22	1	logic_id=104		FwdLogicScript	\N
2049	1	104	1	logic_id=157		FwdLogicScript	\N
2050	1	95	1	logic_id=215		FwdLogicScript	\N
2051	1	26	1	logic_id=217		FwdLogicScript	\N
2052	1	28	1	logic_id=219		FwdLogicScript	\N
2053	1	127	1	logic_id=371		FwdLogicScript	\N
2054	1	126	1	logic_id=372		FwdLogicScript	\N
2055	1	124	1	logic_id=377		FwdLogicScript	\N
2056	35	4	0	logic_id=7		BkwdLogicScript	\N
2057	35	5	0	logic_id=8		BkwdLogicScript	\N
2058	35	2	0	logic_id=9		BkwdLogicScript	\N
2059	35	3	0	logic_id=11		BkwdLogicScript	\N
2060	13	6	0	logic_id=17		BkwdLogicScript	\N
2061	29	6	0	logic_id=17		BkwdLogicScript	\N
2062	27	6	0	logic_id=17		BkwdLogicScript	\N
2063	26	6	0	logic_id=18		BkwdLogicScript	\N
2064	33	135	0	logic_id=19		BkwdLogicScript	\N
2065	31	135	0	logic_id=19		BkwdLogicScript	\N
2066	27	7	0	logic_id=24		BkwdLogicScript	\N
2067	24	7	0	logic_id=24		BkwdLogicScript	\N
2068	30	7	0	logic_id=24		BkwdLogicScript	\N
2069	33	7	0	logic_id=24		BkwdLogicScript	\N
2070	14	13	0	logic_id=26		BkwdLogicScript	\N
2071	6	13	0	logic_id=27		BkwdLogicScript	\N
2072	36	13	0	logic_id=27		BkwdLogicScript	\N
2073	13	13	0	logic_id=27		BkwdLogicScript	\N
2074	27	13	0	logic_id=27		BkwdLogicScript	\N
2075	1	13	0	logic_id=28		BkwdLogicScript	\N
2076	7	13	0	logic_id=28		BkwdLogicScript	\N
2077	22	13	0	logic_id=28		BkwdLogicScript	\N
2078	30	8	0	logic_id=34		BkwdLogicScript	\N
2079	24	8	0	logic_id=37		BkwdLogicScript	\N
2080	6	8	0	logic_id=37		BkwdLogicScript	\N
2081	27	8	0	logic_id=37		BkwdLogicScript	\N
2082	35	8	0	logic_id=37		BkwdLogicScript	\N
2083	1	8	0	logic_id=38		BkwdLogicScript	\N
2084	7	8	0	logic_id=38		BkwdLogicScript	\N
2085	28	8	0	logic_id=40		BkwdLogicScript	\N
2086	9	41	0	logic_id=45		BkwdLogicScript	\N
2087	31	41	0	logic_id=45		BkwdLogicScript	\N
2088	22	41	0	logic_id=45		BkwdLogicScript	\N
2089	9	40	0	logic_id=48		BkwdLogicScript	\N
2090	31	40	0	logic_id=48		BkwdLogicScript	\N
2091	22	40	0	logic_id=48		BkwdLogicScript	\N
2092	1	15	0	logic_id=56		BkwdLogicScript	\N
2093	7	15	0	logic_id=56		BkwdLogicScript	\N
2094	22	15	0	logic_id=56		BkwdLogicScript	\N
2095	33	15	0	logic_id=56		BkwdLogicScript	\N
2096	30	15	0	logic_id=56		BkwdLogicScript	\N
2097	27	83	0	logic_id=60		BkwdLogicScript	\N
2098	29	27	0	logic_id=64		BkwdLogicScript	\N
2099	30	27	0	logic_id=64		BkwdLogicScript	\N
2100	29	26	0	logic_id=65		BkwdLogicScript	\N
2101	30	26	0	logic_id=65		BkwdLogicScript	\N
2102	35	19	0	logic_id=69		BkwdLogicScript	\N
2103	35	18	0	logic_id=71		BkwdLogicScript	\N
2104	30	39	0	logic_id=72		BkwdLogicScript	\N
2105	30	38	0	logic_id=73		BkwdLogicScript	\N
2106	27	44	0	logic_id=74		BkwdLogicScript	\N
2107	35	43	0	logic_id=75		BkwdLogicScript	\N
2108	22	43	0	logic_id=75		BkwdLogicScript	\N
2109	35	42	0	logic_id=76		BkwdLogicScript	\N
2110	22	42	0	logic_id=76		BkwdLogicScript	\N
2111	31	12	0	logic_id=82		BkwdLogicScript	\N
2112	11	17	0	logic_id=101		BkwdLogicScript	\N
2113	13	17	0	logic_id=101		BkwdLogicScript	\N
2114	29	17	0	logic_id=101		BkwdLogicScript	\N
2115	25	17	0	logic_id=101		BkwdLogicScript	\N
2116	14	17	0	logic_id=101		BkwdLogicScript	\N
2117	30	17	0	logic_id=101		BkwdLogicScript	\N
2118	35	17	0	logic_id=103		BkwdLogicScript	\N
2119	11	16	0	logic_id=104		BkwdLogicScript	\N
2120	13	16	0	logic_id=104		BkwdLogicScript	\N
2121	29	16	0	logic_id=104		BkwdLogicScript	\N
2122	25	16	0	logic_id=104		BkwdLogicScript	\N
2123	14	16	0	logic_id=104		BkwdLogicScript	\N
2124	30	16	0	logic_id=104		BkwdLogicScript	\N
2125	35	16	0	logic_id=106		BkwdLogicScript	\N
2126	35	45	0	logic_id=107		BkwdLogicScript	\N
2127	31	57	0	logic_id=111		BkwdLogicScript	\N
2128	22	85	0	logic_id=117		BkwdLogicScript	\N
2129	22	87	0	logic_id=118		BkwdLogicScript	\N
2130	9	23	0	logic_id=120		BkwdLogicScript	\N
2131	10	23	0	logic_id=120		BkwdLogicScript	\N
2132	24	23	0	logic_id=120		BkwdLogicScript	\N
2133	35	23	0	logic_id=120		BkwdLogicScript	\N
2134	9	22	0	logic_id=123		BkwdLogicScript	\N
2135	10	22	0	logic_id=123		BkwdLogicScript	\N
2136	24	22	0	logic_id=123		BkwdLogicScript	\N
2137	35	22	0	logic_id=123		BkwdLogicScript	\N
2138	27	47	0	logic_id=126		BkwdLogicScript	\N
2139	31	47	0	logic_id=129		BkwdLogicScript	\N
2140	27	46	0	logic_id=131		BkwdLogicScript	\N
2141	31	46	0	logic_id=134		BkwdLogicScript	\N
2142	22	88	0	logic_id=136		BkwdLogicScript	\N
2143	1	54	0	logic_id=138		BkwdLogicScript	\N
2144	7	54	0	logic_id=138		BkwdLogicScript	\N
2145	35	54	0	logic_id=138		BkwdLogicScript	\N
2146	6	81	0	logic_id=142		BkwdLogicScript	\N
2147	36	81	0	logic_id=142		BkwdLogicScript	\N
2148	6	82	0	logic_id=143		BkwdLogicScript	\N
2149	36	82	0	logic_id=143		BkwdLogicScript	\N
2150	31	58	0	logic_id=145		BkwdLogicScript	\N
2151	31	59	0	logic_id=147		BkwdLogicScript	\N
2152	7	112	0	logic_id=187		BkwdLogicScript	\N
2153	35	112	0	logic_id=187		BkwdLogicScript	\N
2154	33	112	0	logic_id=187		BkwdLogicScript	\N
2155	27	112	0	logic_id=187		BkwdLogicScript	\N
2156	7	113	0	logic_id=188		BkwdLogicScript	\N
2157	35	113	0	logic_id=188		BkwdLogicScript	\N
2158	33	113	0	logic_id=188		BkwdLogicScript	\N
2159	27	113	0	logic_id=188		BkwdLogicScript	\N
2160	7	118	0	logic_id=189		BkwdLogicScript	\N
2161	35	118	0	logic_id=189		BkwdLogicScript	\N
2162	33	118	0	logic_id=189		BkwdLogicScript	\N
2163	27	118	0	logic_id=189		BkwdLogicScript	\N
2164	7	119	0	logic_id=190		BkwdLogicScript	\N
2165	35	119	0	logic_id=190		BkwdLogicScript	\N
2166	33	119	0	logic_id=190		BkwdLogicScript	\N
2167	27	119	0	logic_id=190		BkwdLogicScript	\N
2168	33	46	0	logic_id=195		BkwdLogicScript	\N
2169	33	47	0	logic_id=196		BkwdLogicScript	\N
2170	29	95	0	logic_id=213		BkwdLogicScript	\N
2171	30	95	0	logic_id=213		BkwdLogicScript	\N
2172	29	94	0	logic_id=214		BkwdLogicScript	\N
2173	30	94	0	logic_id=214		BkwdLogicScript	\N
2174	10	95	0	logic_id=217		BkwdLogicScript	\N
2175	10	94	0	logic_id=218		BkwdLogicScript	\N
2176	10	96	0	logic_id=219		BkwdLogicScript	\N
2177	9	126	0	logic_id=222		BkwdLogicScript	\N
2178	9	127	0	logic_id=224		BkwdLogicScript	\N
2179	33	38	0	logic_id=237		BkwdLogicScript	\N
2180	33	39	0	logic_id=238		BkwdLogicScript	\N
2181	33	97	0	logic_id=246		BkwdLogicScript	\N
2182	27	98	0	logic_id=247		BkwdLogicScript	\N
2183	9	96	0	logic_id=252		BkwdLogicScript	\N
2184	7	52	0	logic_id=263		BkwdLogicScript	\N
2185	35	52	0	logic_id=263		BkwdLogicScript	\N
2186	33	52	0	logic_id=263		BkwdLogicScript	\N
2187	27	52	0	logic_id=263		BkwdLogicScript	\N
2188	7	53	0	logic_id=276		BkwdLogicScript	\N
2189	35	53	0	logic_id=276		BkwdLogicScript	\N
2190	33	53	0	logic_id=276		BkwdLogicScript	\N
2191	27	53	0	logic_id=276		BkwdLogicScript	\N
2192	33	51	0	logic_id=287		BkwdLogicScript	\N
2193	31	51	0	logic_id=289		BkwdLogicScript	\N
2194	31	86	0	logic_id=299		BkwdLogicScript	\N
2195	33	50	0	logic_id=303		BkwdLogicScript	\N
2196	30	50	0	logic_id=303		BkwdLogicScript	\N
2197	31	50	0	logic_id=305		BkwdLogicScript	\N
2198	28	56	0	logic_id=331		BkwdLogicScript	\N
2199	31	134	0	logic_id=332		BkwdLogicScript	\N
2200	6	122	0	logic_id=341		BkwdLogicScript	\N
2201	27	122	0	logic_id=341		BkwdLogicScript	\N
2202	35	122	0	logic_id=341		BkwdLogicScript	\N
2203	1	122	0	logic_id=341		BkwdLogicScript	\N
2204	7	122	0	logic_id=341		BkwdLogicScript	\N
2205	28	122	0	logic_id=341		BkwdLogicScript	\N
2206	6	123	0	logic_id=342		BkwdLogicScript	\N
2207	27	123	0	logic_id=342		BkwdLogicScript	\N
2208	35	123	0	logic_id=342		BkwdLogicScript	\N
2209	1	123	0	logic_id=342		BkwdLogicScript	\N
2210	7	123	0	logic_id=342		BkwdLogicScript	\N
2211	28	123	0	logic_id=342		BkwdLogicScript	\N
2212	1	120	0	logic_id=344		BkwdLogicScript	\N
2213	1	121	0	logic_id=346		BkwdLogicScript	\N
2214	35	88	0	logic_id=357		BkwdLogicScript	\N
2215	9	113	0	logic_id=380		BkwdLogicScript	\N
2216	22	134	0	logic_id=412		BkwdLogicScript	\N
2217	22	92	0	logic_id=418		BkwdLogicScript	\N
2218	35	92	0	logic_id=418		BkwdLogicScript	\N
2219	22	93	0	logic_id=420		BkwdLogicScript	\N
2220	35	93	0	logic_id=420		BkwdLogicScript	\N
2221	27	63	0	logic_id=436		BkwdLogicScript	\N
2222	24	135	0	logic_id=439		BkwdLogicScript	\N
2223	30	135	0	logic_id=439		BkwdLogicScript	\N
2224	35	135	0	logic_id=440		BkwdLogicScript	\N
2225	1	131	0	logic_id=441		BkwdLogicScript	\N
2226	7	131	0	logic_id=441		BkwdLogicScript	\N
2227	31	131	0	logic_id=442		BkwdLogicScript	\N
2228	28	133	0	logic_id=445		BkwdLogicScript	\N
2229	31	88	0	logic_id=447		BkwdLogicScript	\N
2230	26	33	0	logic_id=464		BkwdLogicScript	\N
2231	1	6	0	logic_id=18		BkwdLogicScript	\N
2232	1	135	0	logic_id=19		BkwdLogicScript	\N
2233	28	135	0	logic_id=19		BkwdLogicScript	\N
2234	11	6	0	logic_id=22		BkwdLogicScript	\N
2235	33	13	0	logic_id=27		BkwdLogicScript	\N
2236	31	15	0	logic_id=56		BkwdLogicScript	\N
2237	35	44	0	logic_id=74		BkwdLogicScript	\N
2238	31	43	0	logic_id=75		BkwdLogicScript	\N
2239	31	42	0	logic_id=76		BkwdLogicScript	\N
2240	9	17	0	logic_id=101		BkwdLogicScript	\N
2241	10	17	0	logic_id=101		BkwdLogicScript	\N
2242	24	17	0	logic_id=101		BkwdLogicScript	\N
2243	9	16	0	logic_id=104		BkwdLogicScript	\N
2244	10	16	0	logic_id=104		BkwdLogicScript	\N
2245	24	16	0	logic_id=104		BkwdLogicScript	\N
2246	28	57	0	logic_id=111		BkwdLogicScript	\N
2247	22	90	0	logic_id=114		BkwdLogicScript	\N
2248	31	85	0	logic_id=117		BkwdLogicScript	\N
2249	31	87	0	logic_id=118		BkwdLogicScript	\N
2250	28	47	0	logic_id=129		BkwdLogicScript	\N
2251	30	46	0	logic_id=131		BkwdLogicScript	\N
2252	28	46	0	logic_id=134		BkwdLogicScript	\N
2253	31	54	0	logic_id=138		BkwdLogicScript	\N
2254	7	81	0	logic_id=142		BkwdLogicScript	\N
2255	35	81	0	logic_id=142		BkwdLogicScript	\N
2256	33	81	0	logic_id=142		BkwdLogicScript	\N
2257	27	81	0	logic_id=142		BkwdLogicScript	\N
2258	7	82	0	logic_id=143		BkwdLogicScript	\N
2259	35	82	0	logic_id=143		BkwdLogicScript	\N
2260	33	82	0	logic_id=143		BkwdLogicScript	\N
2261	27	82	0	logic_id=143		BkwdLogicScript	\N
2262	28	58	0	logic_id=145		BkwdLogicScript	\N
2263	28	59	0	logic_id=147		BkwdLogicScript	\N
2264	9	95	0	logic_id=213		BkwdLogicScript	\N
2265	9	94	0	logic_id=214		BkwdLogicScript	\N
2266	1	37	0	logic_id=231		BkwdLogicScript	\N
2267	1	36	0	logic_id=232		BkwdLogicScript	\N
2268	1	98	0	logic_id=247		BkwdLogicScript	\N
2269	1	116	0	logic_id=314		BkwdLogicScript	\N
2270	1	117	0	logic_id=322		BkwdLogicScript	\N
2271	11	55	0	logic_id=330		BkwdLogicScript	\N
2272	26	24	0	logic_id=408		BkwdLogicScript	\N
2273	26	25	0	logic_id=410		BkwdLogicScript	\N
2274	31	92	0	logic_id=418		BkwdLogicScript	\N
2275	31	93	0	logic_id=420		BkwdLogicScript	\N
2276	1	63	0	logic_id=436		BkwdLogicScript	\N
2277	28	131	0	logic_id=442		BkwdLogicScript	\N
2278	28	55	0	logic_id=443		BkwdLogicScript	\N
2279	28	6	0	logic_id=17		BkwdLogicScript	\N
2280	1	7	0	logic_id=24		BkwdLogicScript	\N
2281	11	41	0	logic_id=45		BkwdLogicScript	\N
2282	28	41	0	logic_id=45		BkwdLogicScript	\N
2283	11	40	0	logic_id=48		BkwdLogicScript	\N
2284	28	40	0	logic_id=48		BkwdLogicScript	\N
2285	28	43	0	logic_id=75		BkwdLogicScript	\N
2286	28	42	0	logic_id=76		BkwdLogicScript	\N
2287	31	84	0	logic_id=93		BkwdLogicScript	\N
2288	30	45	0	logic_id=110		BkwdLogicScript	\N
2289	31	90	0	logic_id=114		BkwdLogicScript	\N
2290	26	23	0	logic_id=120		BkwdLogicScript	\N
2291	26	22	0	logic_id=123		BkwdLogicScript	\N
2292	28	54	0	logic_id=138		BkwdLogicScript	\N
2293	1	112	0	logic_id=187		BkwdLogicScript	\N
2294	1	113	0	logic_id=188		BkwdLogicScript	\N
2295	1	118	0	logic_id=189		BkwdLogicScript	\N
2296	1	119	0	logic_id=190		BkwdLogicScript	\N
2297	28	1	0	logic_id=231		BkwdLogicScript	\N
2298	1	52	0	logic_id=263		BkwdLogicScript	\N
2299	30	51	0	logic_id=265		BkwdLogicScript	\N
2300	1	53	0	logic_id=276		BkwdLogicScript	\N
2301	31	83	0	logic_id=60		BkwdLogicScript	\N
2302	30	44	0	logic_id=74		BkwdLogicScript	\N
2303	26	17	0	logic_id=101		BkwdLogicScript	\N
2304	26	16	0	logic_id=104		BkwdLogicScript	\N
2305	30	47	0	logic_id=126		BkwdLogicScript	\N
2306	1	81	0	logic_id=142		BkwdLogicScript	\N
2307	1	82	0	logic_id=143		BkwdLogicScript	\N
2308	1	9	1	Intersection of all maximal ideals is zero.		rschwiebert	2014-02-23 15:35:51-05
2309	1	105	1	logic_id=221		FwdLogicScript	2014-02-23 15:38:17-05
2310	1	56	0	logic_id=258		BkwdLogicScript	2014-02-23 15:39:41-05
2311	1	55	0	logic_id=330		BkwdLogicScript	2014-02-23 15:40:10-05
2312	1	134	0	logic_id=332		BkwdLogicScript	2014-02-23 15:40:11-05
2313	1	88	0	logic_id=357		BkwdLogicScript	2014-02-23 15:40:22-05
2314	1	133	0	logic_id=413		BkwdLogicScript	2014-02-23 15:40:39-05
2315	1	92	0	logic_id=418		BkwdLogicScript	2014-02-23 15:40:40-05
2316	1	93	0	logic_id=420		BkwdLogicScript	2014-02-23 15:40:41-05
2317	36	83	0	logic_id=466		BkwdLogicScript	2014-02-23 15:40:52-05
2318	33	83	0	logic_id=466		BkwdLogicScript	2014-02-23 15:40:52-05
2319	1	111	1	logic_id=162		FwdLogicScript	2014-02-23 15:41:10-05
2320	1	110	1	logic_id=163		FwdLogicScript	2014-02-23 15:41:11-05
2321	1	41	0	logic_id=45		BkwdLogicScript	2014-02-23 15:42:06-05
2322	1	40	0	logic_id=48		BkwdLogicScript	2014-02-23 15:42:06-05
2323	1	57	0	logic_id=111		BkwdLogicScript	2014-02-23 15:42:17-05
2324	36	84	0	logic_id=244		BkwdLogicScript	2014-02-23 15:42:42-05
2325	33	84	0	logic_id=244		BkwdLogicScript	2014-02-23 15:42:43-05
2326	1	86	0	logic_id=270		BkwdLogicScript	2014-02-23 15:42:56-05
2327	1	109	1	logic_id=160		FwdLogicScript	2014-02-23 16:07:14-05
2328	1	43	0	logic_id=75		BkwdLogicScript	2014-02-23 16:08:07-05
2329	1	42	0	logic_id=76		BkwdLogicScript	2014-02-23 16:08:08-05
2330	1	85	0	logic_id=117		BkwdLogicScript	2014-02-23 16:08:14-05
2331	1	87	0	logic_id=118		BkwdLogicScript	2014-02-23 16:08:14-05
2332	1	60	1	logic_id=159		FwdLogicScript	2014-02-23 16:10:57-05
2333	1	90	0	logic_id=114		BkwdLogicScript	2014-02-23 16:11:57-05
2334	1	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2335	2	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2336	3	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2337	4	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2338	6	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2339	7	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2340	8	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2341	9	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2342	10	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2343	17	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2344	18	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2345	27	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2346	33	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2347	34	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2348	36	89	1	logic_id=471		FwdLogicScript	2014-02-23 19:38:35-05
2349	6	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:39-05
2350	36	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:39-05
2351	7	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:39-05
2352	35	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:39-05
2353	33	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:39-05
2354	27	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:40-05
2355	1	65	0	logic_id=467		BkwdLogicScript	2014-02-23 19:40:40-05
2356	6	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:40-05
2357	36	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:40-05
2358	7	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:40-05
2359	35	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:40-05
2360	33	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:41-05
2361	27	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:41-05
2362	1	66	0	logic_id=468		BkwdLogicScript	2014-02-23 19:40:41-05
2363	35	86	0	logic_id=469		BkwdLogicScript	2014-02-23 19:40:41-05
2364	9	132	0	logic_id=470		BkwdLogicScript	2014-02-23 19:40:41-05
2365	1	132	0	logic_id=470		BkwdLogicScript	2014-02-23 19:40:41-05
2366	35	85	0	logic_id=117		BkwdLogicScript	2014-02-23 19:42:16-05
2367	35	87	0	logic_id=118		BkwdLogicScript	2014-02-23 19:42:16-05
2368	9	133	0	logic_id=444		BkwdLogicScript	2014-02-23 19:42:28-05
2369	36	102	0	logic_id=300		BkwdLogicScript	2014-02-23 19:42:52-05
2370	35	102	0	logic_id=300		BkwdLogicScript	2014-02-23 19:42:52-05
2371	33	102	0	logic_id=300		BkwdLogicScript	2014-02-23 19:42:52-05
2372	2	6	1			rschwiebert	2014-02-23 23:20:31-05
2373	3	6	1			rschwiebert	2014-02-23 23:21:44-05
2374	4	6	1			rschwiebert	2014-02-23 23:23:33-05
2375	5	6	1			rschwiebert	2014-02-23 23:23:54-05
2376	2	135	1	logic_id=17		FwdLogicScript	2014-02-23 23:25:31-05
2377	3	135	1	logic_id=17		FwdLogicScript	2014-02-23 23:25:31-05
2378	4	135	1	logic_id=17		FwdLogicScript	2014-02-23 23:25:31-05
2379	5	135	1	logic_id=17		FwdLogicScript	2014-02-23 23:25:31-05
2380	2	13	1	logic_id=18		FwdLogicScript	2014-02-23 23:25:31-05
2381	3	13	1	logic_id=18		FwdLogicScript	2014-02-23 23:25:31-05
2382	4	13	1	logic_id=18		FwdLogicScript	2014-02-23 23:25:32-05
2383	5	13	1	logic_id=18		FwdLogicScript	2014-02-23 23:25:32-05
2384	2	8	1	logic_id=19		FwdLogicScript	2014-02-23 23:25:32-05
2385	3	8	1	logic_id=19		FwdLogicScript	2014-02-23 23:25:32-05
2386	4	8	1	logic_id=19		FwdLogicScript	2014-02-23 23:25:32-05
2387	5	8	1	logic_id=19		FwdLogicScript	2014-02-23 23:25:32-05
2388	2	40	1	logic_id=20		FwdLogicScript	2014-02-23 23:25:32-05
2389	3	40	1	logic_id=20		FwdLogicScript	2014-02-23 23:25:32-05
2390	4	40	1	logic_id=20		FwdLogicScript	2014-02-23 23:25:32-05
2391	5	40	1	logic_id=20		FwdLogicScript	2014-02-23 23:25:32-05
2392	2	41	1	logic_id=21		FwdLogicScript	2014-02-23 23:25:32-05
2393	3	41	1	logic_id=21		FwdLogicScript	2014-02-23 23:25:33-05
2394	4	41	1	logic_id=21		FwdLogicScript	2014-02-23 23:25:33-05
2395	5	41	1	logic_id=21		FwdLogicScript	2014-02-23 23:25:33-05
2396	2	17	1	logic_id=22		FwdLogicScript	2014-02-23 23:25:33-05
2397	3	17	1	logic_id=22		FwdLogicScript	2014-02-23 23:25:33-05
2398	4	17	1	logic_id=22		FwdLogicScript	2014-02-23 23:25:33-05
2399	5	17	1	logic_id=22		FwdLogicScript	2014-02-23 23:25:33-05
2400	2	16	1	logic_id=23		FwdLogicScript	2014-02-23 23:25:33-05
2401	3	16	1	logic_id=23		FwdLogicScript	2014-02-23 23:25:33-05
2402	4	16	1	logic_id=23		FwdLogicScript	2014-02-23 23:25:33-05
2403	5	16	1	logic_id=23		FwdLogicScript	2014-02-23 23:25:33-05
2404	2	14	1	logic_id=26		FwdLogicScript	2014-02-23 23:25:34-05
2405	3	14	1	logic_id=26		FwdLogicScript	2014-02-23 23:25:34-05
2406	4	14	1	logic_id=26		FwdLogicScript	2014-02-23 23:25:34-05
2407	5	14	1	logic_id=26		FwdLogicScript	2014-02-23 23:25:34-05
2408	2	15	1	logic_id=27		FwdLogicScript	2014-02-23 23:25:34-05
2409	3	15	1	logic_id=27		FwdLogicScript	2014-02-23 23:25:34-05
2410	4	15	1	logic_id=27		FwdLogicScript	2014-02-23 23:25:34-05
2411	5	15	1	logic_id=27		FwdLogicScript	2014-02-23 23:25:34-05
2412	5	67	1	logic_id=30		FwdLogicScript	2014-02-23 23:25:34-05
2413	5	68	1	logic_id=31		FwdLogicScript	2014-02-23 23:25:34-05
2414	2	27	1	logic_id=32		FwdLogicScript	2014-02-23 23:25:35-05
2415	3	27	1	logic_id=32		FwdLogicScript	2014-02-23 23:25:35-05
2416	4	27	1	logic_id=32		FwdLogicScript	2014-02-23 23:25:35-05
2417	5	27	1	logic_id=32		FwdLogicScript	2014-02-23 23:25:35-05
2418	2	26	1	logic_id=33		FwdLogicScript	2014-02-23 23:25:35-05
2419	3	26	1	logic_id=33		FwdLogicScript	2014-02-23 23:25:35-05
2420	4	26	1	logic_id=33		FwdLogicScript	2014-02-23 23:25:35-05
2421	5	26	1	logic_id=33		FwdLogicScript	2014-02-23 23:25:35-05
2422	2	32	1	logic_id=34		FwdLogicScript	2014-02-23 23:25:35-05
2423	3	32	1	logic_id=34		FwdLogicScript	2014-02-23 23:25:35-05
2424	4	32	1	logic_id=34		FwdLogicScript	2014-02-23 23:25:35-05
2425	5	32	1	logic_id=34		FwdLogicScript	2014-02-23 23:25:35-05
2426	2	19	1	logic_id=35		FwdLogicScript	2014-02-23 23:25:35-05
2427	3	19	1	logic_id=35		FwdLogicScript	2014-02-23 23:25:35-05
2428	4	19	1	logic_id=35		FwdLogicScript	2014-02-23 23:25:35-05
2429	5	19	1	logic_id=35		FwdLogicScript	2014-02-23 23:25:35-05
2430	2	18	1	logic_id=36		FwdLogicScript	2014-02-23 23:25:36-05
2431	3	18	1	logic_id=36		FwdLogicScript	2014-02-23 23:25:36-05
2432	4	18	1	logic_id=36		FwdLogicScript	2014-02-23 23:25:36-05
2433	5	18	1	logic_id=36		FwdLogicScript	2014-02-23 23:25:36-05
2434	2	39	1	logic_id=38		FwdLogicScript	2014-02-23 23:25:36-05
2435	3	39	1	logic_id=38		FwdLogicScript	2014-02-23 23:25:36-05
2436	4	39	1	logic_id=38		FwdLogicScript	2014-02-23 23:25:36-05
2437	5	39	1	logic_id=38		FwdLogicScript	2014-02-23 23:25:36-05
2438	2	38	1	logic_id=39		FwdLogicScript	2014-02-23 23:25:36-05
2439	3	38	1	logic_id=39		FwdLogicScript	2014-02-23 23:25:36-05
2440	4	38	1	logic_id=39		FwdLogicScript	2014-02-23 23:25:36-05
2441	5	38	1	logic_id=39		FwdLogicScript	2014-02-23 23:25:36-05
2442	2	44	1	logic_id=40		FwdLogicScript	2014-02-23 23:25:36-05
2443	3	44	1	logic_id=40		FwdLogicScript	2014-02-23 23:25:36-05
2444	4	44	1	logic_id=40		FwdLogicScript	2014-02-23 23:25:36-05
2445	5	44	1	logic_id=40		FwdLogicScript	2014-02-23 23:25:36-05
2446	2	43	1	logic_id=41		FwdLogicScript	2014-02-23 23:25:37-05
2447	3	43	1	logic_id=41		FwdLogicScript	2014-02-23 23:25:37-05
2448	4	43	1	logic_id=41		FwdLogicScript	2014-02-23 23:25:37-05
2449	5	43	1	logic_id=41		FwdLogicScript	2014-02-23 23:25:37-05
2450	2	42	1	logic_id=42		FwdLogicScript	2014-02-23 23:25:37-05
2451	3	42	1	logic_id=42		FwdLogicScript	2014-02-23 23:25:37-05
2452	4	42	1	logic_id=42		FwdLogicScript	2014-02-23 23:25:37-05
2453	5	42	1	logic_id=42		FwdLogicScript	2014-02-23 23:25:37-05
2454	2	21	1	logic_id=43		FwdLogicScript	2014-02-23 23:25:37-05
2455	3	21	1	logic_id=43		FwdLogicScript	2014-02-23 23:25:37-05
2456	4	21	1	logic_id=43		FwdLogicScript	2014-02-23 23:25:37-05
2457	5	21	1	logic_id=43		FwdLogicScript	2014-02-23 23:25:37-05
2458	2	55	1	logic_id=45		FwdLogicScript	2014-02-23 23:25:37-05
2459	3	55	1	logic_id=45		FwdLogicScript	2014-02-23 23:25:37-05
2460	4	55	1	logic_id=45		FwdLogicScript	2014-02-23 23:25:37-05
2461	5	55	1	logic_id=45		FwdLogicScript	2014-02-23 23:25:37-05
2462	2	20	1	logic_id=46		FwdLogicScript	2014-02-23 23:25:38-05
2463	3	20	1	logic_id=46		FwdLogicScript	2014-02-23 23:25:38-05
2464	4	20	1	logic_id=46		FwdLogicScript	2014-02-23 23:25:38-05
2465	5	20	1	logic_id=46		FwdLogicScript	2014-02-23 23:25:38-05
2466	2	11	1	logic_id=53		FwdLogicScript	2014-02-23 23:25:39-05
2467	3	11	1	logic_id=53		FwdLogicScript	2014-02-23 23:25:39-05
2468	4	11	1	logic_id=53		FwdLogicScript	2014-02-23 23:25:39-05
2469	5	11	1	logic_id=53		FwdLogicScript	2014-02-23 23:25:39-05
2470	2	35	1	logic_id=54		FwdLogicScript	2014-02-23 23:25:39-05
2471	3	35	1	logic_id=54		FwdLogicScript	2014-02-23 23:25:39-05
2472	4	35	1	logic_id=54		FwdLogicScript	2014-02-23 23:25:39-05
2473	5	35	1	logic_id=54		FwdLogicScript	2014-02-23 23:25:39-05
2474	2	34	1	logic_id=55		FwdLogicScript	2014-02-23 23:25:39-05
2475	3	34	1	logic_id=55		FwdLogicScript	2014-02-23 23:25:39-05
2476	4	34	1	logic_id=55		FwdLogicScript	2014-02-23 23:25:39-05
2477	5	34	1	logic_id=55		FwdLogicScript	2014-02-23 23:25:39-05
2478	2	12	1	logic_id=56		FwdLogicScript	2014-02-23 23:25:40-05
2479	3	12	1	logic_id=56		FwdLogicScript	2014-02-23 23:25:40-05
2480	4	12	1	logic_id=56		FwdLogicScript	2014-02-23 23:25:40-05
2481	5	12	1	logic_id=56		FwdLogicScript	2014-02-23 23:25:40-05
2482	2	29	1	logic_id=64		FwdLogicScript	2014-02-23 23:25:41-05
2483	3	29	1	logic_id=64		FwdLogicScript	2014-02-23 23:25:41-05
2484	4	29	1	logic_id=64		FwdLogicScript	2014-02-23 23:25:41-05
2485	5	29	1	logic_id=64		FwdLogicScript	2014-02-23 23:25:41-05
2486	2	28	1	logic_id=65		FwdLogicScript	2014-02-23 23:25:41-05
2487	3	28	1	logic_id=65		FwdLogicScript	2014-02-23 23:25:41-05
2488	4	28	1	logic_id=65		FwdLogicScript	2014-02-23 23:25:41-05
2489	5	28	1	logic_id=65		FwdLogicScript	2014-02-23 23:25:41-05
2490	2	31	1	logic_id=66		FwdLogicScript	2014-02-23 23:25:41-05
2491	3	31	1	logic_id=66		FwdLogicScript	2014-02-23 23:25:41-05
2492	4	31	1	logic_id=66		FwdLogicScript	2014-02-23 23:25:41-05
2493	5	31	1	logic_id=66		FwdLogicScript	2014-02-23 23:25:41-05
2494	2	30	1	logic_id=67		FwdLogicScript	2014-02-23 23:25:42-05
2495	3	30	1	logic_id=67		FwdLogicScript	2014-02-23 23:25:42-05
2496	4	30	1	logic_id=67		FwdLogicScript	2014-02-23 23:25:42-05
2497	5	30	1	logic_id=67		FwdLogicScript	2014-02-23 23:25:42-05
2498	2	9	1	logic_id=72		FwdLogicScript	2014-02-23 23:25:43-05
2499	3	9	1	logic_id=72		FwdLogicScript	2014-02-23 23:25:43-05
2500	4	9	1	logic_id=72		FwdLogicScript	2014-02-23 23:25:43-05
2501	5	9	1	logic_id=72		FwdLogicScript	2014-02-23 23:25:43-05
2502	2	45	1	logic_id=74		FwdLogicScript	2014-02-23 23:25:43-05
2503	3	45	1	logic_id=74		FwdLogicScript	2014-02-23 23:25:43-05
2504	4	45	1	logic_id=74		FwdLogicScript	2014-02-23 23:25:43-05
2505	5	45	1	logic_id=74		FwdLogicScript	2014-02-23 23:25:43-05
2506	5	107	1	logic_id=78		FwdLogicScript	2014-02-23 23:25:44-05
2507	5	106	1	logic_id=79		FwdLogicScript	2014-02-23 23:25:44-05
2508	2	103	1	logic_id=86		FwdLogicScript	2014-02-23 23:25:45-05
2509	3	103	1	logic_id=86		FwdLogicScript	2014-02-23 23:25:45-05
2510	4	103	1	logic_id=86		FwdLogicScript	2014-02-23 23:25:45-05
2511	5	103	1	logic_id=86		FwdLogicScript	2014-02-23 23:25:45-05
2512	2	102	1	logic_id=87		FwdLogicScript	2014-02-23 23:25:45-05
2513	3	102	1	logic_id=87		FwdLogicScript	2014-02-23 23:25:46-05
2514	4	102	1	logic_id=87		FwdLogicScript	2014-02-23 23:25:46-05
2515	5	102	1	logic_id=87		FwdLogicScript	2014-02-23 23:25:46-05
2516	2	23	1	logic_id=101		FwdLogicScript	2014-02-23 23:25:48-05
2517	3	23	1	logic_id=101		FwdLogicScript	2014-02-23 23:25:48-05
2518	4	23	1	logic_id=101		FwdLogicScript	2014-02-23 23:25:48-05
2519	5	23	1	logic_id=101		FwdLogicScript	2014-02-23 23:25:48-05
2520	2	22	1	logic_id=104		FwdLogicScript	2014-02-23 23:25:49-05
2521	3	22	1	logic_id=104		FwdLogicScript	2014-02-23 23:25:49-05
2522	4	22	1	logic_id=104		FwdLogicScript	2014-02-23 23:25:49-05
2523	5	22	1	logic_id=104		FwdLogicScript	2014-02-23 23:25:49-05
2524	2	47	1	logic_id=109		FwdLogicScript	2014-02-23 23:25:50-05
2525	3	47	1	logic_id=109		FwdLogicScript	2014-02-23 23:25:50-05
2526	4	47	1	logic_id=109		FwdLogicScript	2014-02-23 23:25:50-05
2527	5	47	1	logic_id=109		FwdLogicScript	2014-02-23 23:25:50-05
2528	2	46	1	logic_id=110		FwdLogicScript	2014-02-23 23:25:50-05
2529	3	46	1	logic_id=110		FwdLogicScript	2014-02-23 23:25:50-05
2530	4	46	1	logic_id=110		FwdLogicScript	2014-02-23 23:25:50-05
2531	5	46	1	logic_id=110		FwdLogicScript	2014-02-23 23:25:50-05
2532	2	25	1	logic_id=120		FwdLogicScript	2014-02-23 23:25:52-05
2533	3	25	1	logic_id=120		FwdLogicScript	2014-02-23 23:25:52-05
2534	4	25	1	logic_id=120		FwdLogicScript	2014-02-23 23:25:52-05
2535	5	25	1	logic_id=120		FwdLogicScript	2014-02-23 23:25:52-05
2536	2	24	1	logic_id=123		FwdLogicScript	2014-02-23 23:25:52-05
2537	3	24	1	logic_id=123		FwdLogicScript	2014-02-23 23:25:52-05
2538	4	24	1	logic_id=123		FwdLogicScript	2014-02-23 23:25:52-05
2539	5	24	1	logic_id=123		FwdLogicScript	2014-02-23 23:25:52-05
2540	2	49	1	logic_id=125		FwdLogicScript	2014-02-23 23:25:53-05
2541	3	49	1	logic_id=125		FwdLogicScript	2014-02-23 23:25:53-05
2542	4	49	1	logic_id=125		FwdLogicScript	2014-02-23 23:25:53-05
2543	5	49	1	logic_id=125		FwdLogicScript	2014-02-23 23:25:53-05
2544	2	51	1	logic_id=126		FwdLogicScript	2014-02-23 23:25:53-05
2545	3	51	1	logic_id=126		FwdLogicScript	2014-02-23 23:25:53-05
2546	4	51	1	logic_id=126		FwdLogicScript	2014-02-23 23:25:53-05
2547	5	51	1	logic_id=126		FwdLogicScript	2014-02-23 23:25:53-05
2548	2	82	1	logic_id=127		FwdLogicScript	2014-02-23 23:25:53-05
2549	3	82	1	logic_id=127		FwdLogicScript	2014-02-23 23:25:53-05
2550	4	82	1	logic_id=127		FwdLogicScript	2014-02-23 23:25:53-05
2551	5	82	1	logic_id=127		FwdLogicScript	2014-02-23 23:25:53-05
2552	5	52	1	logic_id=128		FwdLogicScript	2014-02-23 23:25:53-05
2553	2	48	1	logic_id=130		FwdLogicScript	2014-02-23 23:25:53-05
2554	3	48	1	logic_id=130		FwdLogicScript	2014-02-23 23:25:54-05
2555	4	48	1	logic_id=130		FwdLogicScript	2014-02-23 23:25:54-05
2556	5	48	1	logic_id=130		FwdLogicScript	2014-02-23 23:25:54-05
2557	2	50	1	logic_id=131		FwdLogicScript	2014-02-23 23:25:54-05
2558	3	50	1	logic_id=131		FwdLogicScript	2014-02-23 23:25:54-05
2559	4	50	1	logic_id=131		FwdLogicScript	2014-02-23 23:25:54-05
2560	5	50	1	logic_id=131		FwdLogicScript	2014-02-23 23:25:54-05
2561	2	81	1	logic_id=132		FwdLogicScript	2014-02-23 23:25:54-05
2562	3	81	1	logic_id=132		FwdLogicScript	2014-02-23 23:25:54-05
2563	4	81	1	logic_id=132		FwdLogicScript	2014-02-23 23:25:54-05
2564	5	81	1	logic_id=132		FwdLogicScript	2014-02-23 23:25:54-05
2565	5	53	1	logic_id=133		FwdLogicScript	2014-02-23 23:25:55-05
2566	5	130	1	logic_id=400		FwdLogicScript	2014-02-23 23:25:57-05
2567	5	129	1	logic_id=401		FwdLogicScript	2014-02-23 23:25:57-05
2568	5	128	1	logic_id=402		FwdLogicScript	2014-02-23 23:25:58-05
2569	2	33	1	logic_id=408		FwdLogicScript	2014-02-23 23:25:59-05
2570	3	33	1	logic_id=408		FwdLogicScript	2014-02-23 23:26:00-05
2571	4	33	1	logic_id=408		FwdLogicScript	2014-02-23 23:26:00-05
2572	5	33	1	logic_id=408		FwdLogicScript	2014-02-23 23:26:00-05
2573	2	104	1	logic_id=154		FwdLogicScript	2014-02-23 23:26:00-05
2574	3	104	1	logic_id=154		FwdLogicScript	2014-02-23 23:26:00-05
2575	4	104	1	logic_id=154		FwdLogicScript	2014-02-23 23:26:00-05
2576	5	104	1	logic_id=154		FwdLogicScript	2014-02-23 23:26:00-05
2577	2	10	1	logic_id=423		FwdLogicScript	2014-02-23 23:26:04-05
2578	3	10	1	logic_id=423		FwdLogicScript	2014-02-23 23:26:04-05
2579	4	10	1	logic_id=423		FwdLogicScript	2014-02-23 23:26:04-05
2580	5	10	1	logic_id=423		FwdLogicScript	2014-02-23 23:26:04-05
2581	5	99	1	logic_id=424		FwdLogicScript	2014-02-23 23:26:04-05
2582	5	100	1	logic_id=425		FwdLogicScript	2014-02-23 23:26:05-05
2583	2	96	1	logic_id=426		FwdLogicScript	2014-02-23 23:26:05-05
2584	3	96	1	logic_id=426		FwdLogicScript	2014-02-23 23:26:05-05
2585	4	96	1	logic_id=426		FwdLogicScript	2014-02-23 23:26:05-05
2586	5	96	1	logic_id=426		FwdLogicScript	2014-02-23 23:26:05-05
2587	2	124	1	logic_id=429		FwdLogicScript	2014-02-23 23:26:06-05
2588	3	124	1	logic_id=429		FwdLogicScript	2014-02-23 23:26:06-05
2589	4	124	1	logic_id=429		FwdLogicScript	2014-02-23 23:26:06-05
2590	5	124	1	logic_id=429		FwdLogicScript	2014-02-23 23:26:06-05
2591	2	125	1	logic_id=430		FwdLogicScript	2014-02-23 23:26:06-05
2592	3	125	1	logic_id=430		FwdLogicScript	2014-02-23 23:26:07-05
2593	4	125	1	logic_id=430		FwdLogicScript	2014-02-23 23:26:07-05
2594	5	125	1	logic_id=430		FwdLogicScript	2014-02-23 23:26:07-05
2595	5	101	1	logic_id=182		FwdLogicScript	2014-02-23 23:26:08-05
2596	2	7	1	logic_id=439		FwdLogicScript	2014-02-23 23:26:09-05
2597	3	7	1	logic_id=439		FwdLogicScript	2014-02-23 23:26:09-05
2598	4	7	1	logic_id=439		FwdLogicScript	2014-02-23 23:26:09-05
2599	5	7	1	logic_id=439		FwdLogicScript	2014-02-23 23:26:09-05
2600	2	131	1	logic_id=440		FwdLogicScript	2014-02-23 23:26:09-05
2601	3	131	1	logic_id=440		FwdLogicScript	2014-02-23 23:26:09-05
2602	4	131	1	logic_id=440		FwdLogicScript	2014-02-23 23:26:09-05
2603	5	131	1	logic_id=440		FwdLogicScript	2014-02-23 23:26:09-05
2604	2	133	1	logic_id=442		FwdLogicScript	2014-02-23 23:26:09-05
2605	3	133	1	logic_id=442		FwdLogicScript	2014-02-23 23:26:09-05
2606	4	133	1	logic_id=442		FwdLogicScript	2014-02-23 23:26:09-05
2607	5	133	1	logic_id=442		FwdLogicScript	2014-02-23 23:26:09-05
2608	2	132	1	logic_id=444		FwdLogicScript	2014-02-23 23:26:09-05
2609	3	132	1	logic_id=444		FwdLogicScript	2014-02-23 23:26:09-05
2610	4	132	1	logic_id=444		FwdLogicScript	2014-02-23 23:26:09-05
2611	5	132	1	logic_id=444		FwdLogicScript	2014-02-23 23:26:09-05
2612	2	120	1	logic_id=195		FwdLogicScript	2014-02-23 23:26:11-05
2613	3	120	1	logic_id=195		FwdLogicScript	2014-02-23 23:26:11-05
2614	4	120	1	logic_id=195		FwdLogicScript	2014-02-23 23:26:11-05
2615	5	120	1	logic_id=195		FwdLogicScript	2014-02-23 23:26:11-05
2616	2	121	1	logic_id=196		FwdLogicScript	2014-02-23 23:26:11-05
2617	3	121	1	logic_id=196		FwdLogicScript	2014-02-23 23:26:11-05
2618	4	121	1	logic_id=196		FwdLogicScript	2014-02-23 23:26:11-05
2619	5	121	1	logic_id=196		FwdLogicScript	2014-02-23 23:26:11-05
2620	2	122	1	logic_id=197		FwdLogicScript	2014-02-23 23:26:11-05
2621	3	122	1	logic_id=197		FwdLogicScript	2014-02-23 23:26:11-05
2622	4	122	1	logic_id=197		FwdLogicScript	2014-02-23 23:26:11-05
2623	5	122	1	logic_id=197		FwdLogicScript	2014-02-23 23:26:11-05
2624	2	123	1	logic_id=198		FwdLogicScript	2014-02-23 23:26:11-05
2625	3	123	1	logic_id=198		FwdLogicScript	2014-02-23 23:26:11-05
2626	4	123	1	logic_id=198		FwdLogicScript	2014-02-23 23:26:11-05
2627	5	123	1	logic_id=198		FwdLogicScript	2014-02-23 23:26:11-05
2628	2	95	1	logic_id=215		FwdLogicScript	2014-02-23 23:26:15-05
2629	3	95	1	logic_id=215		FwdLogicScript	2014-02-23 23:26:15-05
2630	4	95	1	logic_id=215		FwdLogicScript	2014-02-23 23:26:15-05
2631	5	95	1	logic_id=215		FwdLogicScript	2014-02-23 23:26:15-05
2632	2	94	1	logic_id=216		FwdLogicScript	2014-02-23 23:26:15-05
2633	3	94	1	logic_id=216		FwdLogicScript	2014-02-23 23:26:15-05
2634	4	94	1	logic_id=216		FwdLogicScript	2014-02-23 23:26:15-05
2635	5	94	1	logic_id=216		FwdLogicScript	2014-02-23 23:26:15-05
2636	2	126	1	logic_id=226		FwdLogicScript	2014-02-23 23:26:16-05
2637	3	126	1	logic_id=226		FwdLogicScript	2014-02-23 23:26:16-05
2638	4	126	1	logic_id=226		FwdLogicScript	2014-02-23 23:26:16-05
2639	5	126	1	logic_id=226		FwdLogicScript	2014-02-23 23:26:16-05
2640	2	127	1	logic_id=227		FwdLogicScript	2014-02-23 23:26:17-05
2641	3	127	1	logic_id=227		FwdLogicScript	2014-02-23 23:26:17-05
2642	4	127	1	logic_id=227		FwdLogicScript	2014-02-23 23:26:17-05
2643	5	127	1	logic_id=227		FwdLogicScript	2014-02-23 23:26:17-05
2644	2	36	1	logic_id=351		FwdLogicScript	2014-02-23 23:26:32-05
2645	3	36	1	logic_id=351		FwdLogicScript	2014-02-23 23:26:32-05
2646	4	36	1	logic_id=351		FwdLogicScript	2014-02-23 23:26:32-05
2647	5	36	1	logic_id=351		FwdLogicScript	2014-02-23 23:26:32-05
2648	2	37	1	logic_id=352		FwdLogicScript	2014-02-23 23:26:32-05
2649	3	37	1	logic_id=352		FwdLogicScript	2014-02-23 23:26:32-05
2650	4	37	1	logic_id=352		FwdLogicScript	2014-02-23 23:26:32-05
2651	5	37	1	logic_id=352		FwdLogicScript	2014-02-23 23:26:32-05
2652	2	97	1	logic_id=236		FwdLogicScript	2014-02-23 23:26:41-05
2653	3	97	1	logic_id=236		FwdLogicScript	2014-02-23 23:26:41-05
2654	4	97	1	logic_id=236		FwdLogicScript	2014-02-23 23:26:41-05
2655	2	112	1	logic_id=397		FwdLogicScript	2014-02-23 23:26:47-05
2656	3	112	1	logic_id=397		FwdLogicScript	2014-02-23 23:26:47-05
2657	4	112	1	logic_id=397		FwdLogicScript	2014-02-23 23:26:47-05
2658	2	92	1	logic_id=14		FwdLogicScript	2014-02-23 23:26:50-05
2659	3	92	1	logic_id=14		FwdLogicScript	2014-02-23 23:26:50-05
2660	4	92	1	logic_id=14		FwdLogicScript	2014-02-23 23:26:50-05
2661	5	92	1	logic_id=14		FwdLogicScript	2014-02-23 23:26:50-05
2662	2	93	1	logic_id=16		FwdLogicScript	2014-02-23 23:26:50-05
2663	3	93	1	logic_id=16		FwdLogicScript	2014-02-23 23:26:50-05
2664	4	93	1	logic_id=16		FwdLogicScript	2014-02-23 23:26:50-05
2665	5	93	1	logic_id=16		FwdLogicScript	2014-02-23 23:26:51-05
2666	35	84	0	logic_id=93		BkwdLogicScript	2014-02-24 00:32:13-05
2667	35	90	0	logic_id=114		BkwdLogicScript	2014-02-24 00:32:18-05
2668	9	131	0	logic_id=442		BkwdLogicScript	2014-02-24 00:32:34-05
2669	5	63	0	logic_id=230		BkwdLogicScript	2014-02-24 00:34:04-05
2670	33	103	0	symmetry		SymmScript	2014-02-24 00:46:52-05
2880	16	63	1	It has eight elements	obvious	rschwiebert	2014-03-02 16:14:16-05
2881	16	1	0	obvious	obvious	rschwiebert	2014-03-02 16:15:14-05
2882	16	9	0	The Jacobson radical is the set of strictly upper triangular matrices	obvious	rschwiebert	2014-03-02 16:16:01-05
2883	16	42	1	[[a,b],[0,0]] and [[0,0],[0,c]] are uniserial submodules	rschwiebert	rschwiebert	2014-03-02 16:17:50-05
2884	16	43	1	[[a,0],[0,0]] and [[0,b],[0,c]] are uniserial submodules	rschwiebert	rschwiebert	2014-03-02 16:18:34-05
2885	19	4	1	Given in Lam FC p 20	Given in Lam FC p 20	rschwiebert	2014-03-02 16:25:40-05
2886	19	5	0	Given in Lam FC p 20	Given in Lam FC p 20	rschwiebert	2014-03-02 16:26:01-05
2887	19	2	0	Given in Lam FC p 20	Given in Lam FC p 20	rschwiebert	2014-03-02 16:26:43-05
2888	19	9	0	Strictly upper triangular matrices are in the Jacobson radical	rschwiebert	rschwiebert	2014-03-02 16:29:37-05
2889	19	14	0	Strictly upper triangular matrices in this ring are nilpotent	rschwiebert	rschwiebert	2014-03-02 16:30:26-05
2890	20	2	1	Given in Lam FC p 20	Lam FC p 20	\N	2014-03-02 16:37:28-05
2891	20	5	0	Given in Lam FC p 20	Lam FC p 20	\N	2014-03-02 16:38:27-05
2892	20	14	0	Strictly upper triangular matrices are nilpotent	obvious	\N	2014-03-02 16:39:17-05
2893	20	9	0	The Jacobson radical contains the strictly upper triangular matrices	obvious	\N	2014-03-02 16:40:08-05
2894	21	33	1	Given in Lam FC p 21	Lam FC p 21	\N	2014-03-02 16:41:39-05
2895	21	17	1	Given in Lam FC p 21	Lam FC p 21	\N	2014-03-02 16:42:59-05
2896	21	4	0	Given in Lam FC p 21	Lam FC p 21	\N	2014-03-02 16:43:56-05
2897	23	1	1	Quotient of a commutative polynomial ring	obvious	\N	2014-03-02 16:46:49-05
2898	23	63	1	{1,x,y,xy} is a basis, so it has 16 elements	obvious	\N	2014-03-02 16:48:12-05
2899	23	124	0	Its lattice of ideals contains the diamond lattice	obvious	\N	2014-03-02 16:49:13-05
2900	23	18	0	Its maximal ideal (x,y) is not principal	obvious	\N	2014-03-02 16:51:11-05
2901	23	55	1	The unique maximal ideal is (x,y), which is nilpotent	obvious	\N	2014-03-02 16:52:08-05
2902	32	1	1	obvious	obvious	\N	2014-03-02 16:56:01-05
2903	32	4	1	Quotient of the noetherian ring Z[x]	obvious	\N	2014-03-02 16:56:51-05
2904	32	33	0	(1+x)(1-x)=0	obvious	\N	2014-03-02 16:57:41-05
2905	32	104	1	Hand computation shows no nontrivial idempotents	obvious	\N	2014-03-02 16:58:36-05
2906	32	55	0	1-x and 1+x are contained in different maximal ideals	obvious	\N	2014-03-02 17:00:38-05
2907	32	14	1	(x^1-1) is the intersection of two prime ideals, (or alternatively an easy computation)	obvious	\N	2014-03-02 17:02:02-05
2908	32	5	1	symmetry		SymmScript	2014-03-02 17:55:56-05
2909	2	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2910	3	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2911	4	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2912	8	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2913	10	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2914	17	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2915	18	113	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2916	23	19	0	symmetry		SymmScript	2014-03-02 17:55:57-05
2917	23	125	0	symmetry		SymmScript	2014-03-02 17:55:57-05
2918	36	103	0	symmetry		SymmScript	2014-03-02 17:55:57-05
2919	36	127	1	symmetry		SymmScript	2014-03-02 17:55:57-05
2920	20	79	1	logic_id=0		FwdLogicScript	2014-03-02 17:56:58-05
2921	23	62	1	logic_id=1		FwdLogicScript	2014-03-02 17:56:59-05
2922	32	62	1	logic_id=1		FwdLogicScript	2014-03-02 17:56:59-05
2923	23	67	1	logic_id=2		FwdLogicScript	2014-03-02 17:56:59-05
2924	32	67	1	logic_id=2		FwdLogicScript	2014-03-02 17:56:59-05
2925	23	68	1	logic_id=3		FwdLogicScript	2014-03-02 17:56:59-05
2926	32	68	1	logic_id=3		FwdLogicScript	2014-03-02 17:56:59-05
2927	23	100	1	logic_id=4		FwdLogicScript	2014-03-02 17:56:59-05
2928	32	100	1	logic_id=4		FwdLogicScript	2014-03-02 17:56:59-05
2929	23	99	1	logic_id=5		FwdLogicScript	2014-03-02 17:56:59-05
2930	32	99	1	logic_id=5		FwdLogicScript	2014-03-02 17:56:59-05
2931	23	101	1	logic_id=6		FwdLogicScript	2014-03-02 17:57:00-05
2932	32	101	1	logic_id=6		FwdLogicScript	2014-03-02 17:57:00-05
2933	19	71	1	logic_id=7		FwdLogicScript	2014-03-02 17:57:00-05
2934	32	71	1	logic_id=7		FwdLogicScript	2014-03-02 17:57:00-05
2935	32	72	1	logic_id=8		FwdLogicScript	2014-03-02 17:57:00-05
2936	20	4	1	logic_id=9		FwdLogicScript	2014-03-02 17:57:01-05
2937	20	54	1	logic_id=10		FwdLogicScript	2014-03-02 17:57:01-05
2938	32	11	1	logic_id=53		FwdLogicScript	2014-03-02 17:57:06-05
2939	32	35	1	logic_id=54		FwdLogicScript	2014-03-02 17:57:06-05
2940	32	34	1	logic_id=55		FwdLogicScript	2014-03-02 17:57:06-05
2941	16	57	1	logic_id=75		FwdLogicScript	2014-03-02 17:57:09-05
2942	23	57	1	logic_id=77		FwdLogicScript	2014-03-02 17:57:09-05
2943	23	107	1	logic_id=78		FwdLogicScript	2014-03-02 17:57:10-05
2944	23	106	1	logic_id=79		FwdLogicScript	2014-03-02 17:57:10-05
2945	21	23	1	logic_id=101		FwdLogicScript	2014-03-02 17:57:13-05
2946	21	19	1	logic_id=103		FwdLogicScript	2014-03-02 17:57:13-05
2947	16	56	1	logic_id=111		FwdLogicScript	2014-03-02 17:57:15-05
2948	23	56	1	logic_id=111		FwdLogicScript	2014-03-02 17:57:15-05
2949	16	88	1	logic_id=112		FwdLogicScript	2014-03-02 17:57:15-05
2950	23	88	1	logic_id=112		FwdLogicScript	2014-03-02 17:57:15-05
2951	16	90	1	logic_id=113		FwdLogicScript	2014-03-02 17:57:15-05
2952	23	90	1	logic_id=113		FwdLogicScript	2014-03-02 17:57:15-05
2953	16	85	1	logic_id=114		FwdLogicScript	2014-03-02 17:57:16-05
2954	23	85	1	logic_id=114		FwdLogicScript	2014-03-02 17:57:16-05
2955	23	61	1	logic_id=115		FwdLogicScript	2014-03-02 17:57:16-05
2956	32	61	1	logic_id=115		FwdLogicScript	2014-03-02 17:57:16-05
2957	23	64	1	logic_id=116		FwdLogicScript	2014-03-02 17:57:16-05
2958	32	64	1	logic_id=116		FwdLogicScript	2014-03-02 17:57:17-05
2959	16	86	1	logic_id=117		FwdLogicScript	2014-03-02 17:57:17-05
2960	23	86	1	logic_id=117		FwdLogicScript	2014-03-02 17:57:18-05
2961	21	21	1	logic_id=119		FwdLogicScript	2014-03-02 17:57:18-05
2962	21	25	1	logic_id=120		FwdLogicScript	2014-03-02 17:57:18-05
2963	16	91	1	logic_id=135		FwdLogicScript	2014-03-02 17:57:20-05
2964	23	91	1	logic_id=135		FwdLogicScript	2014-03-02 17:57:20-05
2965	16	60	1	logic_id=137		FwdLogicScript	2014-03-02 17:57:20-05
2966	23	60	1	logic_id=137		FwdLogicScript	2014-03-02 17:57:21-05
2967	20	58	1	logic_id=138		FwdLogicScript	2014-03-02 17:57:21-05
2968	20	59	1	logic_id=139		FwdLogicScript	2014-03-02 17:57:21-05
2969	19	73	1	logic_id=140		FwdLogicScript	2014-03-02 17:57:21-05
2970	20	73	1	logic_id=140		FwdLogicScript	2014-03-02 17:57:21-05
2971	32	73	1	logic_id=140		FwdLogicScript	2014-03-02 17:57:22-05
2972	32	74	1	logic_id=141		FwdLogicScript	2014-03-02 17:57:22-05
2973	20	83	1	logic_id=144		FwdLogicScript	2014-03-02 17:57:22-05
2974	32	130	1	logic_id=400		FwdLogicScript	2014-03-02 17:57:23-05
2975	20	57	1	logic_id=145		FwdLogicScript	2014-03-02 17:57:23-05
2976	32	129	1	logic_id=401		FwdLogicScript	2014-03-02 17:57:23-05
2977	32	128	1	logic_id=402		FwdLogicScript	2014-03-02 17:57:24-05
2978	23	128	1	logic_id=403		FwdLogicScript	2014-03-02 17:57:24-05
2979	32	70	1	logic_id=148		FwdLogicScript	2014-03-02 17:57:25-05
2980	32	79	1	logic_id=149		FwdLogicScript	2014-03-02 17:57:26-05
2981	19	69	1	logic_id=150		FwdLogicScript	2014-03-02 17:57:26-05
2982	32	69	1	logic_id=150		FwdLogicScript	2014-03-02 17:57:26-05
2983	19	77	1	logic_id=151		FwdLogicScript	2014-03-02 17:57:27-05
2984	32	77	1	logic_id=151		FwdLogicScript	2014-03-02 17:57:27-05
2985	19	62	1	logic_id=153		FwdLogicScript	2014-03-02 17:57:28-05
2986	23	104	1	logic_id=154		FwdLogicScript	2014-03-02 17:57:28-05
2987	32	106	1	logic_id=155		FwdLogicScript	2014-03-02 17:57:29-05
2988	21	72	1	logic_id=411		FwdLogicScript	2014-03-02 17:57:29-05
2989	32	107	1	logic_id=156		FwdLogicScript	2014-03-02 17:57:29-05
2990	21	104	1	logic_id=157		FwdLogicScript	2014-03-02 17:57:30-05
2991	20	105	1	logic_id=164		FwdLogicScript	2014-03-02 17:57:31-05
2992	20	110	1	logic_id=165		FwdLogicScript	2014-03-02 17:57:32-05
2993	20	111	1	logic_id=166		FwdLogicScript	2014-03-02 17:57:32-05
2994	19	75	1	logic_id=167		FwdLogicScript	2014-03-02 17:57:33-05
2995	20	75	1	logic_id=167		FwdLogicScript	2014-03-02 17:57:33-05
2996	32	75	1	logic_id=167		FwdLogicScript	2014-03-02 17:57:33-05
2997	21	10	1	logic_id=423		FwdLogicScript	2014-03-02 17:57:33-05
2998	32	76	1	logic_id=168		FwdLogicScript	2014-03-02 17:57:33-05
2999	19	108	1	logic_id=169		FwdLogicScript	2014-03-02 17:57:34-05
3000	32	108	1	logic_id=169		FwdLogicScript	2014-03-02 17:57:34-05
3001	21	100	1	logic_id=425		FwdLogicScript	2014-03-02 17:57:34-05
3002	21	96	1	logic_id=427		FwdLogicScript	2014-03-02 17:57:35-05
3003	20	108	1	logic_id=172		FwdLogicScript	2014-03-02 17:57:35-05
3004	21	108	1	logic_id=435		FwdLogicScript	2014-03-02 17:57:37-05
3005	23	108	1	logic_id=435		FwdLogicScript	2014-03-02 17:57:38-05
3006	20	76	1	logic_id=180		FwdLogicScript	2014-03-02 17:57:38-05
3007	19	61	1	logic_id=181		FwdLogicScript	2014-03-02 17:57:38-05
3008	20	61	1	logic_id=181		FwdLogicScript	2014-03-02 17:57:38-05
3009	21	61	1	logic_id=181		FwdLogicScript	2014-03-02 17:57:38-05
3010	21	101	1	logic_id=182		FwdLogicScript	2014-03-02 17:57:39-05
3011	23	133	1	logic_id=443		FwdLogicScript	2014-03-02 17:57:40-05
3012	23	132	1	logic_id=444		FwdLogicScript	2014-03-02 17:57:40-05
3013	16	134	1	logic_id=446		FwdLogicScript	2014-03-02 17:57:41-05
3014	23	134	1	logic_id=446		FwdLogicScript	2014-03-02 17:57:41-05
3015	23	130	1	logic_id=201		FwdLogicScript	2014-03-02 17:57:43-05
3016	19	80	1	logic_id=460		FwdLogicScript	2014-03-02 17:57:44-05
3017	32	80	1	logic_id=460		FwdLogicScript	2014-03-02 17:57:44-05
3018	19	114	1	logic_id=205		FwdLogicScript	2014-03-02 17:57:44-05
3019	32	114	1	logic_id=205		FwdLogicScript	2014-03-02 17:57:44-05
3020	32	115	1	logic_id=206		FwdLogicScript	2014-03-02 17:57:45-05
3021	20	78	1	logic_id=463		FwdLogicScript	2014-03-02 17:57:45-05
3022	32	78	1	logic_id=463		FwdLogicScript	2014-03-02 17:57:46-05
3023	21	14	1	logic_id=464		FwdLogicScript	2014-03-02 17:57:46-05
3024	20	119	1	logic_id=209		FwdLogicScript	2014-03-02 17:57:46-05
3025	21	32	1	logic_id=465		FwdLogicScript	2014-03-02 17:57:46-05
3026	20	118	1	logic_id=210		FwdLogicScript	2014-03-02 17:57:47-05
3027	23	89	1	logic_id=471		FwdLogicScript	2014-03-02 17:57:48-05
3028	32	89	1	logic_id=471		FwdLogicScript	2014-03-02 17:57:48-05
3029	21	94	1	logic_id=216		FwdLogicScript	2014-03-02 17:57:48-05
3030	21	27	1	logic_id=218		FwdLogicScript	2014-03-02 17:57:49-05
3031	21	28	1	logic_id=219		FwdLogicScript	2014-03-02 17:57:49-05
3032	21	29	1	logic_id=220		FwdLogicScript	2014-03-02 17:57:50-05
3033	21	78	1	logic_id=476		FwdLogicScript	2014-03-02 17:57:50-05
3034	20	71	1	logic_id=7		FwdLogicScript	2014-03-02 18:04:35-05
3035	21	11	1	logic_id=53		FwdLogicScript	2014-03-02 18:04:40-05
3036	21	35	1	logic_id=54		FwdLogicScript	2014-03-02 18:04:41-05
3037	21	34	1	logic_id=55		FwdLogicScript	2014-03-02 18:04:41-05
3038	20	84	1	logic_id=60		FwdLogicScript	2014-03-02 18:04:41-05
3039	20	66	1	logic_id=61		FwdLogicScript	2014-03-02 18:04:42-05
3040	20	65	1	logic_id=62		FwdLogicScript	2014-03-02 18:04:42-05
3041	20	91	1	logic_id=63		FwdLogicScript	2014-03-02 18:04:42-05
3042	21	31	1	logic_id=66		FwdLogicScript	2014-03-02 18:04:43-05
3043	21	30	1	logic_id=67		FwdLogicScript	2014-03-02 18:04:43-05
3044	21	5	1	logic_id=69		FwdLogicScript	2014-03-02 18:04:43-05
3045	16	62	1	logic_id=92		FwdLogicScript	2014-03-02 18:04:46-05
3046	20	62	1	logic_id=92		FwdLogicScript	2014-03-02 18:04:46-05
3047	20	85	1	logic_id=93		FwdLogicScript	2014-03-02 18:04:46-05
3048	20	87	1	logic_id=94		FwdLogicScript	2014-03-02 18:04:46-05
3049	21	74	1	logic_id=96		FwdLogicScript	2014-03-02 18:04:47-05
3050	21	73	1	logic_id=98		FwdLogicScript	2014-03-02 18:04:47-05
3051	20	56	1	logic_id=111		FwdLogicScript	2014-03-02 18:04:49-05
3052	20	88	1	logic_id=112		FwdLogicScript	2014-03-02 18:04:49-05
3053	20	90	1	logic_id=113		FwdLogicScript	2014-03-02 18:04:49-05
3054	16	61	1	logic_id=115		FwdLogicScript	2014-03-02 18:04:50-05
3055	16	64	1	logic_id=116		FwdLogicScript	2014-03-02 18:04:50-05
3056	19	64	1	logic_id=116		FwdLogicScript	2014-03-02 18:04:50-05
3057	20	64	1	logic_id=116		FwdLogicScript	2014-03-02 18:04:50-05
3058	20	86	1	logic_id=117		FwdLogicScript	2014-03-02 18:04:50-05
3059	20	60	1	logic_id=137		FwdLogicScript	2014-03-02 18:04:53-05
3060	21	130	1	logic_id=400		FwdLogicScript	2014-03-02 18:04:54-05
3061	21	129	1	logic_id=401		FwdLogicScript	2014-03-02 18:04:54-05
3062	23	129	1	logic_id=401		FwdLogicScript	2014-03-02 18:04:54-05
3063	21	128	1	logic_id=402		FwdLogicScript	2014-03-02 18:04:55-05
3064	21	70	1	logic_id=148		FwdLogicScript	2014-03-02 18:04:56-05
3065	21	79	1	logic_id=149		FwdLogicScript	2014-03-02 18:04:56-05
3066	20	69	1	logic_id=150		FwdLogicScript	2014-03-02 18:04:56-05
3067	20	77	1	logic_id=151		FwdLogicScript	2014-03-02 18:04:57-05
3068	21	62	1	logic_id=152		FwdLogicScript	2014-03-02 18:04:57-05
3069	20	109	1	logic_id=160		FwdLogicScript	2014-03-02 18:04:59-05
3070	21	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:05:01-05
3071	20	116	1	logic_id=189		FwdLogicScript	2014-03-02 18:05:06-05
3072	20	117	1	logic_id=190		FwdLogicScript	2014-03-02 18:05:06-05
3073	20	134	1	logic_id=446		FwdLogicScript	2014-03-02 18:05:06-05
3074	20	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:05:08-05
3075	20	114	1	logic_id=205		FwdLogicScript	2014-03-02 18:05:09-05
3076	21	115	1	logic_id=206		FwdLogicScript	2014-03-02 18:05:09-05
3077	21	64	1	logic_id=116		FwdLogicScript	2014-03-02 18:07:06-05
3078	19	33	0	logic_id=464		BkwdLogicScript	2014-03-02 18:13:03-05
3079	20	33	0	logic_id=464		BkwdLogicScript	2014-03-02 18:13:03-05
3080	16	12	0	logic_id=448		BkwdLogicScript	2014-03-02 18:13:12-05
3081	19	12	0	logic_id=448		BkwdLogicScript	2014-03-02 18:13:12-05
3082	20	12	0	logic_id=448		BkwdLogicScript	2014-03-02 18:13:12-05
3083	23	41	0	logic_id=434		BkwdLogicScript	2014-03-02 18:13:22-05
3084	23	40	0	logic_id=433		BkwdLogicScript	2014-03-02 18:13:22-05
3085	23	13	0	logic_id=430		BkwdLogicScript	2014-03-02 18:13:23-05
3086	19	25	0	logic_id=410		BkwdLogicScript	2014-03-02 18:13:35-05
3087	20	25	0	logic_id=410		BkwdLogicScript	2014-03-02 18:13:35-05
3088	32	25	0	logic_id=410		BkwdLogicScript	2014-03-02 18:13:36-05
3089	19	24	0	logic_id=408		BkwdLogicScript	2014-03-02 18:13:37-05
3090	20	24	0	logic_id=408		BkwdLogicScript	2014-03-02 18:13:37-05
3091	32	24	0	logic_id=408		BkwdLogicScript	2014-03-02 18:13:38-05
3092	19	22	0	logic_id=123		BkwdLogicScript	2014-03-02 18:13:53-05
3093	20	22	0	logic_id=123		BkwdLogicScript	2014-03-02 18:13:53-05
3094	32	22	0	logic_id=123		BkwdLogicScript	2014-03-02 18:13:53-05
3095	19	23	0	logic_id=120		BkwdLogicScript	2014-03-02 18:13:54-05
3096	20	23	0	logic_id=120		BkwdLogicScript	2014-03-02 18:13:54-05
3097	32	23	0	logic_id=120		BkwdLogicScript	2014-03-02 18:13:55-05
3098	19	45	0	logic_id=108		BkwdLogicScript	2014-03-02 18:14:00-05
3099	23	16	0	logic_id=106		BkwdLogicScript	2014-03-02 18:14:01-05
3100	19	16	0	logic_id=104		BkwdLogicScript	2014-03-02 18:14:02-05
3101	20	16	0	logic_id=104		BkwdLogicScript	2014-03-02 18:14:02-05
3102	32	16	0	logic_id=104		BkwdLogicScript	2014-03-02 18:14:02-05
3103	23	17	0	logic_id=103		BkwdLogicScript	2014-03-02 18:14:03-05
3104	19	17	0	logic_id=101		BkwdLogicScript	2014-03-02 18:14:03-05
3105	20	17	0	logic_id=101		BkwdLogicScript	2014-03-02 18:14:03-05
3106	32	17	0	logic_id=101		BkwdLogicScript	2014-03-02 18:14:04-05
3107	19	44	0	logic_id=74		BkwdLogicScript	2014-03-02 18:14:14-05
3108	16	38	0	logic_id=73		BkwdLogicScript	2014-03-02 18:14:15-05
3109	19	38	0	logic_id=73		BkwdLogicScript	2014-03-02 18:14:15-05
3110	20	38	0	logic_id=73		BkwdLogicScript	2014-03-02 18:14:15-05
3111	16	39	0	logic_id=72		BkwdLogicScript	2014-03-02 18:14:16-05
3112	19	39	0	logic_id=72		BkwdLogicScript	2014-03-02 18:14:16-05
3113	20	39	0	logic_id=72		BkwdLogicScript	2014-03-02 18:14:16-05
3114	21	18	0	logic_id=71		BkwdLogicScript	2014-03-02 18:14:16-05
3115	19	19	0	logic_id=69		BkwdLogicScript	2014-03-02 18:14:17-05
3116	20	19	0	logic_id=69		BkwdLogicScript	2014-03-02 18:14:17-05
3117	16	15	0	logic_id=56		BkwdLogicScript	2014-03-02 18:14:23-05
3118	19	15	0	logic_id=56		BkwdLogicScript	2014-03-02 18:14:23-05
3119	20	15	0	logic_id=56		BkwdLogicScript	2014-03-02 18:14:23-05
3120	16	36	0	logic_id=51		BkwdLogicScript	2014-03-02 18:14:26-05
3121	19	36	0	logic_id=51		BkwdLogicScript	2014-03-02 18:14:26-05
3122	20	36	0	logic_id=51		BkwdLogicScript	2014-03-02 18:14:26-05
3123	16	37	0	logic_id=49		BkwdLogicScript	2014-03-02 18:14:27-05
3124	19	37	0	logic_id=49		BkwdLogicScript	2014-03-02 18:14:27-05
3125	20	37	0	logic_id=49		BkwdLogicScript	2014-03-02 18:14:27-05
3126	32	40	0	logic_id=48		BkwdLogicScript	2014-03-02 18:14:28-05
3127	32	41	0	logic_id=45		BkwdLogicScript	2014-03-02 18:14:29-05
3128	19	8	0	logic_id=40		BkwdLogicScript	2014-03-02 18:14:32-05
3129	16	8	0	logic_id=39		BkwdLogicScript	2014-03-02 18:14:33-05
3130	20	8	0	logic_id=39		BkwdLogicScript	2014-03-02 18:14:33-05
3131	21	8	0	logic_id=36		BkwdLogicScript	2014-03-02 18:14:35-05
3132	23	8	0	logic_id=36		BkwdLogicScript	2014-03-02 18:14:35-05
3133	16	13	0	logic_id=27		BkwdLogicScript	2014-03-02 18:14:39-05
3134	19	13	0	logic_id=27		BkwdLogicScript	2014-03-02 18:14:39-05
3135	20	13	0	logic_id=27		BkwdLogicScript	2014-03-02 18:14:39-05
3136	16	7	0	logic_id=25		BkwdLogicScript	2014-03-02 18:14:41-05
3137	19	7	0	logic_id=25		BkwdLogicScript	2014-03-02 18:14:41-05
3138	20	7	0	logic_id=25		BkwdLogicScript	2014-03-02 18:14:41-05
3139	19	6	0	logic_id=23		BkwdLogicScript	2014-03-02 18:14:42-05
3140	20	6	0	logic_id=23		BkwdLogicScript	2014-03-02 18:14:43-05
3141	23	6	0	logic_id=23		BkwdLogicScript	2014-03-02 18:14:43-05
3142	32	6	0	logic_id=23		BkwdLogicScript	2014-03-02 18:14:43-05
3143	16	135	0	logic_id=19		BkwdLogicScript	2014-03-02 18:14:46-05
3144	19	135	0	logic_id=19		BkwdLogicScript	2014-03-02 18:14:46-05
3145	20	135	0	logic_id=19		BkwdLogicScript	2014-03-02 18:14:46-05
3146	21	135	0	logic_id=19		BkwdLogicScript	2014-03-02 18:14:46-05
3147	23	135	0	logic_id=19		BkwdLogicScript	2014-03-02 18:14:46-05
3148	16	6	0	logic_id=18		BkwdLogicScript	2014-03-02 18:14:47-05
3149	21	6	0	logic_id=17		BkwdLogicScript	2014-03-02 18:14:48-05
3150	19	3	0	logic_id=11		BkwdLogicScript	2014-03-02 18:14:51-05
3151	20	3	0	logic_id=11		BkwdLogicScript	2014-03-02 18:14:52-05
3152	21	2	0	logic_id=9		BkwdLogicScript	2014-03-02 18:14:53-05
3153	21	45	0	logic_id=108		BkwdLogicScript	2014-03-02 18:18:13-05
3154	20	45	0	logic_id=107		BkwdLogicScript	2014-03-02 18:18:14-05
3155	21	16	0	logic_id=106		BkwdLogicScript	2014-03-02 18:18:14-05
3156	20	44	0	logic_id=74		BkwdLogicScript	2014-03-02 18:18:27-05
3157	21	44	0	logic_id=74		BkwdLogicScript	2014-03-02 18:18:27-05
3158	11	2	1	logic_id=498		FwdLogicScript	2014-03-02 18:53:30-05
3159	13	2	1	logic_id=498		FwdLogicScript	2014-03-02 18:53:31-05
3160	16	2	1	logic_id=498		FwdLogicScript	2014-03-02 18:53:31-05
3161	23	2	1	logic_id=498		FwdLogicScript	2014-03-02 18:53:31-05
3162	25	2	1	logic_id=498		FwdLogicScript	2014-03-02 18:53:31-05
3163	29	2	1	logic_id=498		FwdLogicScript	2014-03-02 18:53:31-05
3164	11	3	1	logic_id=499		FwdLogicScript	2014-03-02 18:53:31-05
3165	13	3	1	logic_id=499		FwdLogicScript	2014-03-02 18:53:31-05
3166	16	3	1	logic_id=499		FwdLogicScript	2014-03-02 18:53:31-05
3167	23	3	1	logic_id=499		FwdLogicScript	2014-03-02 18:53:31-05
3168	25	3	1	logic_id=499		FwdLogicScript	2014-03-02 18:53:31-05
3169	29	3	1	logic_id=499		FwdLogicScript	2014-03-02 18:53:31-05
3170	11	135	1	logic_id=316		FwdLogicScript	2014-03-02 18:53:42-05
3171	11	8	1	logic_id=317		FwdLogicScript	2014-03-02 18:53:42-05
3172	19	63	0	logic_id=499		BkwdLogicScript	2014-03-02 18:56:08-05
3173	20	63	0	logic_id=499		BkwdLogicScript	2014-03-02 18:56:09-05
3174	22	63	0	logic_id=499		BkwdLogicScript	2014-03-02 18:56:09-05
3175	28	63	0	logic_id=499		BkwdLogicScript	2014-03-02 18:56:09-05
3176	31	63	0	logic_id=499		BkwdLogicScript	2014-03-02 18:56:09-05
3177	21	63	0	logic_id=498		BkwdLogicScript	2014-03-02 18:56:10-05
3178	11	79	1	logic_id=0		FwdLogicScript	2014-03-02 18:58:28-05
3179	13	79	1	logic_id=0		FwdLogicScript	2014-03-02 18:58:28-05
3180	16	79	1	logic_id=0		FwdLogicScript	2014-03-02 18:58:28-05
3181	23	79	1	logic_id=0		FwdLogicScript	2014-03-02 18:58:28-05
3182	25	79	1	logic_id=0		FwdLogicScript	2014-03-02 18:58:28-05
3183	29	79	1	logic_id=0		FwdLogicScript	2014-03-02 18:58:28-05
3184	11	4	1	logic_id=9		FwdLogicScript	2014-03-02 18:58:30-05
3185	13	4	1	logic_id=9		FwdLogicScript	2014-03-02 18:58:30-05
3186	16	4	1	logic_id=9		FwdLogicScript	2014-03-02 18:58:30-05
3187	23	4	1	logic_id=9		FwdLogicScript	2014-03-02 18:58:30-05
3188	25	4	1	logic_id=9		FwdLogicScript	2014-03-02 18:58:30-05
3189	29	4	1	logic_id=9		FwdLogicScript	2014-03-02 18:58:30-05
3190	11	54	1	logic_id=10		FwdLogicScript	2014-03-02 18:58:31-05
3191	13	54	1	logic_id=10		FwdLogicScript	2014-03-02 18:58:31-05
3192	16	54	1	logic_id=10		FwdLogicScript	2014-03-02 18:58:31-05
3193	23	54	1	logic_id=10		FwdLogicScript	2014-03-02 18:58:31-05
3194	25	54	1	logic_id=10		FwdLogicScript	2014-03-02 18:58:31-05
3195	29	54	1	logic_id=10		FwdLogicScript	2014-03-02 18:58:31-05
3196	11	5	1	logic_id=11		FwdLogicScript	2014-03-02 18:58:31-05
3197	13	5	1	logic_id=11		FwdLogicScript	2014-03-02 18:58:31-05
3198	16	5	1	logic_id=11		FwdLogicScript	2014-03-02 18:58:31-05
3199	23	5	1	logic_id=11		FwdLogicScript	2014-03-02 18:58:31-05
3200	25	5	1	logic_id=11		FwdLogicScript	2014-03-02 18:58:31-05
3201	29	5	1	logic_id=11		FwdLogicScript	2014-03-02 18:58:31-05
3202	11	27	1	logic_id=32		FwdLogicScript	2014-03-02 18:58:34-05
3203	11	26	1	logic_id=33		FwdLogicScript	2014-03-02 18:58:34-05
3204	11	32	1	logic_id=34		FwdLogicScript	2014-03-02 18:58:34-05
3205	11	19	1	logic_id=35		FwdLogicScript	2014-03-02 18:58:34-05
3206	11	18	1	logic_id=36		FwdLogicScript	2014-03-02 18:58:34-05
3207	11	15	1	logic_id=37		FwdLogicScript	2014-03-02 18:58:35-05
3208	11	39	1	logic_id=38		FwdLogicScript	2014-03-02 18:58:35-05
3209	11	38	1	logic_id=39		FwdLogicScript	2014-03-02 18:58:36-05
3210	11	44	1	logic_id=40		FwdLogicScript	2014-03-02 18:58:36-05
3211	11	43	1	logic_id=41		FwdLogicScript	2014-03-02 18:58:36-05
3212	11	42	1	logic_id=42		FwdLogicScript	2014-03-02 18:58:36-05
3213	11	12	1	logic_id=56		FwdLogicScript	2014-03-02 18:58:39-05
3214	11	66	1	logic_id=57		FwdLogicScript	2014-03-02 18:58:39-05
3215	11	65	1	logic_id=58		FwdLogicScript	2014-03-02 18:58:39-05
3216	11	91	1	logic_id=59		FwdLogicScript	2014-03-02 18:58:39-05
3217	11	29	1	logic_id=64		FwdLogicScript	2014-03-02 18:58:40-05
3218	11	28	1	logic_id=65		FwdLogicScript	2014-03-02 18:58:41-05
3219	11	31	1	logic_id=66		FwdLogicScript	2014-03-02 18:58:41-05
3220	11	30	1	logic_id=67		FwdLogicScript	2014-03-02 18:58:41-05
3221	11	21	1	logic_id=68		FwdLogicScript	2014-03-02 18:58:41-05
3222	11	20	1	logic_id=70		FwdLogicScript	2014-03-02 18:58:41-05
3223	11	45	1	logic_id=74		FwdLogicScript	2014-03-02 18:58:42-05
3224	11	57	1	logic_id=75		FwdLogicScript	2014-03-02 18:58:42-05
3225	11	103	1	logic_id=86		FwdLogicScript	2014-03-02 18:58:43-05
3226	11	102	1	logic_id=87		FwdLogicScript	2014-03-02 18:58:44-05
3227	11	90	1	logic_id=88		FwdLogicScript	2014-03-02 18:58:44-05
3228	11	84	1	logic_id=89		FwdLogicScript	2014-03-02 18:58:44-05
3229	11	61	1	logic_id=90		FwdLogicScript	2014-03-02 18:58:44-05
3230	11	62	1	logic_id=92		FwdLogicScript	2014-03-02 18:58:45-05
3231	11	85	1	logic_id=93		FwdLogicScript	2014-03-02 18:58:45-05
3232	11	87	1	logic_id=94		FwdLogicScript	2014-03-02 18:58:45-05
3233	11	74	1	logic_id=96		FwdLogicScript	2014-03-02 18:58:45-05
3234	11	73	1	logic_id=98		FwdLogicScript	2014-03-02 18:58:46-05
3235	11	35	1	logic_id=99		FwdLogicScript	2014-03-02 18:58:46-05
3236	11	34	1	logic_id=100		FwdLogicScript	2014-03-02 18:58:46-05
3237	11	47	1	logic_id=109		FwdLogicScript	2014-03-02 18:58:47-05
3238	11	46	1	logic_id=110		FwdLogicScript	2014-03-02 18:58:47-05
3239	11	56	1	logic_id=111		FwdLogicScript	2014-03-02 18:58:48-05
3240	11	88	1	logic_id=112		FwdLogicScript	2014-03-02 18:58:48-05
3241	11	64	1	logic_id=116		FwdLogicScript	2014-03-02 18:58:49-05
3242	11	86	1	logic_id=117		FwdLogicScript	2014-03-02 18:58:49-05
3243	11	49	1	logic_id=125		FwdLogicScript	2014-03-02 18:58:51-05
3244	11	51	1	logic_id=126		FwdLogicScript	2014-03-02 18:58:51-05
3245	11	82	1	logic_id=127		FwdLogicScript	2014-03-02 18:58:51-05
3246	11	52	1	logic_id=128		FwdLogicScript	2014-03-02 18:58:51-05
3247	11	48	1	logic_id=130		FwdLogicScript	2014-03-02 18:58:52-05
3248	11	50	1	logic_id=131		FwdLogicScript	2014-03-02 18:58:52-05
3249	11	81	1	logic_id=132		FwdLogicScript	2014-03-02 18:58:52-05
3250	11	53	1	logic_id=133		FwdLogicScript	2014-03-02 18:58:52-05
3251	11	58	1	logic_id=138		FwdLogicScript	2014-03-02 18:58:53-05
3252	13	58	1	logic_id=138		FwdLogicScript	2014-03-02 18:58:53-05
3253	16	58	1	logic_id=138		FwdLogicScript	2014-03-02 18:58:53-05
3254	23	58	1	logic_id=138		FwdLogicScript	2014-03-02 18:58:53-05
3255	25	58	1	logic_id=138		FwdLogicScript	2014-03-02 18:58:53-05
3256	29	58	1	logic_id=138		FwdLogicScript	2014-03-02 18:58:53-05
3257	11	59	1	logic_id=139		FwdLogicScript	2014-03-02 18:58:53-05
3258	13	59	1	logic_id=139		FwdLogicScript	2014-03-02 18:58:53-05
3259	16	59	1	logic_id=139		FwdLogicScript	2014-03-02 18:58:53-05
3260	23	59	1	logic_id=139		FwdLogicScript	2014-03-02 18:58:53-05
3261	25	59	1	logic_id=139		FwdLogicScript	2014-03-02 18:58:53-05
3262	29	59	1	logic_id=139		FwdLogicScript	2014-03-02 18:58:53-05
3263	13	73	1	logic_id=140		FwdLogicScript	2014-03-02 18:58:54-05
3264	16	73	1	logic_id=140		FwdLogicScript	2014-03-02 18:58:54-05
3265	23	73	1	logic_id=140		FwdLogicScript	2014-03-02 18:58:54-05
3266	25	73	1	logic_id=140		FwdLogicScript	2014-03-02 18:58:54-05
3267	29	73	1	logic_id=140		FwdLogicScript	2014-03-02 18:58:54-05
3268	13	74	1	logic_id=141		FwdLogicScript	2014-03-02 18:58:54-05
3269	16	74	1	logic_id=141		FwdLogicScript	2014-03-02 18:58:54-05
3270	23	74	1	logic_id=141		FwdLogicScript	2014-03-02 18:58:54-05
3271	25	74	1	logic_id=141		FwdLogicScript	2014-03-02 18:58:54-05
3272	29	74	1	logic_id=141		FwdLogicScript	2014-03-02 18:58:54-05
3273	11	83	1	logic_id=144		FwdLogicScript	2014-03-02 18:58:55-05
3274	13	83	1	logic_id=144		FwdLogicScript	2014-03-02 18:58:55-05
3275	16	83	1	logic_id=144		FwdLogicScript	2014-03-02 18:58:55-05
3276	23	83	1	logic_id=144		FwdLogicScript	2014-03-02 18:58:55-05
3277	25	83	1	logic_id=144		FwdLogicScript	2014-03-02 18:58:55-05
3278	29	83	1	logic_id=144		FwdLogicScript	2014-03-02 18:58:55-05
3279	25	57	1	logic_id=145		FwdLogicScript	2014-03-02 18:58:55-05
3280	29	57	1	logic_id=145		FwdLogicScript	2014-03-02 18:58:55-05
3281	13	105	1	logic_id=164		FwdLogicScript	2014-03-02 18:59:01-05
3282	16	105	1	logic_id=164		FwdLogicScript	2014-03-02 18:59:01-05
3283	23	105	1	logic_id=164		FwdLogicScript	2014-03-02 18:59:01-05
3284	25	105	1	logic_id=164		FwdLogicScript	2014-03-02 18:59:01-05
3285	29	105	1	logic_id=164		FwdLogicScript	2014-03-02 18:59:01-05
3286	13	110	1	logic_id=165		FwdLogicScript	2014-03-02 18:59:01-05
3287	16	110	1	logic_id=165		FwdLogicScript	2014-03-02 18:59:01-05
3288	23	110	1	logic_id=165		FwdLogicScript	2014-03-02 18:59:01-05
3289	25	110	1	logic_id=165		FwdLogicScript	2014-03-02 18:59:01-05
3290	29	110	1	logic_id=165		FwdLogicScript	2014-03-02 18:59:01-05
3291	13	111	1	logic_id=166		FwdLogicScript	2014-03-02 18:59:02-05
3292	16	111	1	logic_id=166		FwdLogicScript	2014-03-02 18:59:02-05
3293	23	111	1	logic_id=166		FwdLogicScript	2014-03-02 18:59:02-05
3294	25	111	1	logic_id=166		FwdLogicScript	2014-03-02 18:59:02-05
3295	29	111	1	logic_id=166		FwdLogicScript	2014-03-02 18:59:02-05
3296	11	75	1	logic_id=167		FwdLogicScript	2014-03-02 18:59:02-05
3297	13	75	1	logic_id=167		FwdLogicScript	2014-03-02 18:59:02-05
3298	16	75	1	logic_id=167		FwdLogicScript	2014-03-02 18:59:02-05
3299	23	75	1	logic_id=167		FwdLogicScript	2014-03-02 18:59:02-05
3300	25	75	1	logic_id=167		FwdLogicScript	2014-03-02 18:59:02-05
3301	29	75	1	logic_id=167		FwdLogicScript	2014-03-02 18:59:02-05
3302	11	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:59:03-05
3303	13	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:59:03-05
3304	16	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:59:03-05
3305	23	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:59:03-05
3306	25	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:59:03-05
3307	29	76	1	logic_id=168		FwdLogicScript	2014-03-02 18:59:03-05
3308	11	108	1	logic_id=171		FwdLogicScript	2014-03-02 18:59:04-05
3309	13	108	1	logic_id=171		FwdLogicScript	2014-03-02 18:59:04-05
3310	16	108	1	logic_id=171		FwdLogicScript	2014-03-02 18:59:04-05
3311	25	108	1	logic_id=171		FwdLogicScript	2014-03-02 18:59:04-05
3312	29	108	1	logic_id=171		FwdLogicScript	2014-03-02 18:59:04-05
3313	11	77	1	logic_id=176		FwdLogicScript	2014-03-02 18:59:06-05
3314	13	77	1	logic_id=176		FwdLogicScript	2014-03-02 18:59:06-05
3315	16	77	1	logic_id=176		FwdLogicScript	2014-03-02 18:59:06-05
3316	23	77	1	logic_id=176		FwdLogicScript	2014-03-02 18:59:06-05
3317	25	77	1	logic_id=176		FwdLogicScript	2014-03-02 18:59:06-05
3318	29	77	1	logic_id=176		FwdLogicScript	2014-03-02 18:59:06-05
3319	25	61	1	logic_id=181		FwdLogicScript	2014-03-02 18:59:07-05
3320	29	61	1	logic_id=181		FwdLogicScript	2014-03-02 18:59:07-05
3321	11	131	1	logic_id=440		FwdLogicScript	2014-03-02 18:59:07-05
3322	11	133	1	logic_id=442		FwdLogicScript	2014-03-02 18:59:08-05
3323	11	132	1	logic_id=444		FwdLogicScript	2014-03-02 18:59:08-05
3324	11	134	1	logic_id=446		FwdLogicScript	2014-03-02 18:59:09-05
3325	11	120	1	logic_id=195		FwdLogicScript	2014-03-02 18:59:10-05
3326	11	121	1	logic_id=196		FwdLogicScript	2014-03-02 18:59:10-05
3327	11	122	1	logic_id=197		FwdLogicScript	2014-03-02 18:59:10-05
3328	11	123	1	logic_id=198		FwdLogicScript	2014-03-02 18:59:11-05
3329	11	118	1	logic_id=199		FwdLogicScript	2014-03-02 18:59:11-05
3330	11	119	1	logic_id=200		FwdLogicScript	2014-03-02 18:59:11-05
3331	11	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:59:12-05
3332	13	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:59:12-05
3333	16	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:59:12-05
3334	23	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:59:12-05
3335	25	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:59:12-05
3336	29	80	1	logic_id=460		FwdLogicScript	2014-03-02 18:59:12-05
3337	11	78	1	logic_id=463		FwdLogicScript	2014-03-02 18:59:13-05
3338	13	78	1	logic_id=463		FwdLogicScript	2014-03-02 18:59:14-05
3339	16	78	1	logic_id=463		FwdLogicScript	2014-03-02 18:59:14-05
3340	23	78	1	logic_id=463		FwdLogicScript	2014-03-02 18:59:14-05
3341	25	78	1	logic_id=463		FwdLogicScript	2014-03-02 18:59:14-05
3342	29	78	1	logic_id=463		FwdLogicScript	2014-03-02 18:59:14-05
3343	13	119	1	logic_id=209		FwdLogicScript	2014-03-02 18:59:14-05
3344	16	119	1	logic_id=209		FwdLogicScript	2014-03-02 18:59:14-05
3345	23	119	1	logic_id=209		FwdLogicScript	2014-03-02 18:59:14-05
3346	25	119	1	logic_id=209		FwdLogicScript	2014-03-02 18:59:14-05
3347	29	119	1	logic_id=209		FwdLogicScript	2014-03-02 18:59:14-05
3348	13	118	1	logic_id=210		FwdLogicScript	2014-03-02 18:59:15-05
3349	16	118	1	logic_id=210		FwdLogicScript	2014-03-02 18:59:15-05
3350	23	118	1	logic_id=210		FwdLogicScript	2014-03-02 18:59:15-05
3351	25	118	1	logic_id=210		FwdLogicScript	2014-03-02 18:59:15-05
3352	29	118	1	logic_id=210		FwdLogicScript	2014-03-02 18:59:15-05
3353	23	53	1	logic_id=321		FwdLogicScript	2014-03-02 18:59:31-05
3354	23	52	1	logic_id=329		FwdLogicScript	2014-03-02 18:59:33-05
3355	23	131	1	logic_id=413		FwdLogicScript	2014-03-02 18:59:42-05
3356	11	71	1	logic_id=7		FwdLogicScript	2014-03-02 19:04:23-05
3357	13	71	1	logic_id=7		FwdLogicScript	2014-03-02 19:04:23-05
3358	16	71	1	logic_id=7		FwdLogicScript	2014-03-02 19:04:23-05
3359	23	71	1	logic_id=7		FwdLogicScript	2014-03-02 19:04:24-05
3360	25	71	1	logic_id=7		FwdLogicScript	2014-03-02 19:04:24-05
3361	29	71	1	logic_id=7		FwdLogicScript	2014-03-02 19:04:24-05
3362	11	116	1	logic_id=263		FwdLogicScript	2014-03-02 19:04:24-05
3363	23	116	1	logic_id=263		FwdLogicScript	2014-03-02 19:04:24-05
3364	11	72	1	logic_id=8		FwdLogicScript	2014-03-02 19:04:24-05
3365	13	72	1	logic_id=8		FwdLogicScript	2014-03-02 19:04:24-05
3366	16	72	1	logic_id=8		FwdLogicScript	2014-03-02 19:04:24-05
3367	23	72	1	logic_id=8		FwdLogicScript	2014-03-02 19:04:24-05
3368	25	72	1	logic_id=8		FwdLogicScript	2014-03-02 19:04:24-05
3369	29	72	1	logic_id=8		FwdLogicScript	2014-03-02 19:04:24-05
3370	11	92	1	logic_id=14		FwdLogicScript	2014-03-02 19:04:25-05
3371	11	93	1	logic_id=16		FwdLogicScript	2014-03-02 19:04:25-05
3372	11	117	1	logic_id=276		FwdLogicScript	2014-03-02 19:04:26-05
3373	23	117	1	logic_id=276		FwdLogicScript	2014-03-02 19:04:26-05
3374	13	84	1	logic_id=60		FwdLogicScript	2014-03-02 19:04:31-05
3375	16	84	1	logic_id=60		FwdLogicScript	2014-03-02 19:04:31-05
3376	23	84	1	logic_id=60		FwdLogicScript	2014-03-02 19:04:31-05
3377	25	84	1	logic_id=60		FwdLogicScript	2014-03-02 19:04:31-05
3378	29	84	1	logic_id=60		FwdLogicScript	2014-03-02 19:04:31-05
3379	13	66	1	logic_id=61		FwdLogicScript	2014-03-02 19:04:31-05
3380	16	66	1	logic_id=61		FwdLogicScript	2014-03-02 19:04:31-05
3381	23	66	1	logic_id=61		FwdLogicScript	2014-03-02 19:04:31-05
3382	25	66	1	logic_id=61		FwdLogicScript	2014-03-02 19:04:31-05
3383	29	66	1	logic_id=61		FwdLogicScript	2014-03-02 19:04:31-05
3384	13	65	1	logic_id=62		FwdLogicScript	2014-03-02 19:04:31-05
3385	16	65	1	logic_id=62		FwdLogicScript	2014-03-02 19:04:31-05
3386	23	65	1	logic_id=62		FwdLogicScript	2014-03-02 19:04:31-05
3387	25	65	1	logic_id=62		FwdLogicScript	2014-03-02 19:04:31-05
3388	29	65	1	logic_id=62		FwdLogicScript	2014-03-02 19:04:32-05
3389	25	91	1	logic_id=63		FwdLogicScript	2014-03-02 19:04:32-05
3390	29	91	1	logic_id=63		FwdLogicScript	2014-03-02 19:04:32-05
3391	25	62	1	logic_id=92		FwdLogicScript	2014-03-02 19:04:36-05
3392	29	62	1	logic_id=92		FwdLogicScript	2014-03-02 19:04:36-05
3393	25	85	1	logic_id=93		FwdLogicScript	2014-03-02 19:04:37-05
3394	29	85	1	logic_id=93		FwdLogicScript	2014-03-02 19:04:37-05
3395	13	87	1	logic_id=94		FwdLogicScript	2014-03-02 19:04:37-05
3396	16	87	1	logic_id=94		FwdLogicScript	2014-03-02 19:04:37-05
3397	23	87	1	logic_id=94		FwdLogicScript	2014-03-02 19:04:37-05
3398	25	87	1	logic_id=94		FwdLogicScript	2014-03-02 19:04:37-05
3399	29	87	1	logic_id=94		FwdLogicScript	2014-03-02 19:04:37-05
3400	25	56	1	logic_id=111		FwdLogicScript	2014-03-02 19:04:40-05
3401	29	56	1	logic_id=111		FwdLogicScript	2014-03-02 19:04:40-05
3402	25	88	1	logic_id=112		FwdLogicScript	2014-03-02 19:04:41-05
3403	29	88	1	logic_id=112		FwdLogicScript	2014-03-02 19:04:41-05
3404	25	90	1	logic_id=113		FwdLogicScript	2014-03-02 19:04:41-05
3405	29	90	1	logic_id=113		FwdLogicScript	2014-03-02 19:04:41-05
3406	25	64	1	logic_id=116		FwdLogicScript	2014-03-02 19:04:42-05
3407	29	64	1	logic_id=116		FwdLogicScript	2014-03-02 19:04:42-05
3408	25	86	1	logic_id=117		FwdLogicScript	2014-03-02 19:04:43-05
3409	29	86	1	logic_id=117		FwdLogicScript	2014-03-02 19:04:43-05
3410	25	60	1	logic_id=137		FwdLogicScript	2014-03-02 19:04:45-05
3411	29	60	1	logic_id=137		FwdLogicScript	2014-03-02 19:04:45-05
3412	11	70	1	logic_id=148		FwdLogicScript	2014-03-02 19:04:48-05
3413	13	70	1	logic_id=148		FwdLogicScript	2014-03-02 19:04:49-05
3414	16	70	1	logic_id=148		FwdLogicScript	2014-03-02 19:04:49-05
3415	23	70	1	logic_id=148		FwdLogicScript	2014-03-02 19:04:49-05
3416	25	70	1	logic_id=148		FwdLogicScript	2014-03-02 19:04:49-05
3417	29	70	1	logic_id=148		FwdLogicScript	2014-03-02 19:04:49-05
3418	11	69	1	logic_id=150		FwdLogicScript	2014-03-02 19:04:50-05
3419	13	69	1	logic_id=150		FwdLogicScript	2014-03-02 19:04:50-05
3420	16	69	1	logic_id=150		FwdLogicScript	2014-03-02 19:04:50-05
3421	23	69	1	logic_id=150		FwdLogicScript	2014-03-02 19:04:50-05
3422	25	69	1	logic_id=150		FwdLogicScript	2014-03-02 19:04:50-05
3423	29	69	1	logic_id=150		FwdLogicScript	2014-03-02 19:04:50-05
3424	13	109	1	logic_id=160		FwdLogicScript	2014-03-02 19:04:52-05
3425	16	109	1	logic_id=160		FwdLogicScript	2014-03-02 19:04:52-05
3426	23	109	1	logic_id=160		FwdLogicScript	2014-03-02 19:04:52-05
3427	25	109	1	logic_id=160		FwdLogicScript	2014-03-02 19:04:52-05
3428	29	109	1	logic_id=160		FwdLogicScript	2014-03-02 19:04:52-05
3429	13	116	1	logic_id=189		FwdLogicScript	2014-03-02 19:05:00-05
3430	16	116	1	logic_id=189		FwdLogicScript	2014-03-02 19:05:00-05
3431	25	116	1	logic_id=189		FwdLogicScript	2014-03-02 19:05:01-05
3432	13	117	1	logic_id=190		FwdLogicScript	2014-03-02 19:05:01-05
3433	16	117	1	logic_id=190		FwdLogicScript	2014-03-02 19:05:01-05
3434	25	117	1	logic_id=190		FwdLogicScript	2014-03-02 19:05:01-05
3435	25	134	1	logic_id=446		FwdLogicScript	2014-03-02 19:05:01-05
3436	29	134	1	logic_id=446		FwdLogicScript	2014-03-02 19:05:01-05
3437	11	114	1	logic_id=205		FwdLogicScript	2014-03-02 19:05:04-05
3438	13	114	1	logic_id=205		FwdLogicScript	2014-03-02 19:05:04-05
3439	16	114	1	logic_id=205		FwdLogicScript	2014-03-02 19:05:04-05
3440	23	114	1	logic_id=205		FwdLogicScript	2014-03-02 19:05:04-05
3441	25	114	1	logic_id=205		FwdLogicScript	2014-03-02 19:05:04-05
3442	29	114	1	logic_id=205		FwdLogicScript	2014-03-02 19:05:04-05
3443	11	115	1	logic_id=206		FwdLogicScript	2014-03-02 19:05:04-05
3444	13	115	1	logic_id=206		FwdLogicScript	2014-03-02 19:05:04-05
3445	16	115	1	logic_id=206		FwdLogicScript	2014-03-02 19:05:04-05
3446	23	115	1	logic_id=206		FwdLogicScript	2014-03-02 19:05:04-05
3447	25	115	1	logic_id=206		FwdLogicScript	2014-03-02 19:05:04-05
3448	29	115	1	logic_id=206		FwdLogicScript	2014-03-02 19:05:04-05
3449	11	99	1	logic_id=359		FwdLogicScript	2014-03-02 19:05:29-05
3450	11	100	1	logic_id=361		FwdLogicScript	2014-03-02 19:05:30-05
3451	13	26	1	Lam LMR pg 50	Lam LMR pg 50	\N	2014-03-02 19:13:20-05
3452	13	27	1	Lam LMR pg 50	Lam LMR pg 50	\N	2014-03-02 19:13:41-05
3453	14	26	1	Lam LMR pg 50	Lam LMR pg 50	\N	2014-03-02 19:14:07-05
3454	14	27	1	Lam LMR pg 50	Lam LMR pg 50	\N	2014-03-02 19:14:23-05
3455	16	26	1	Lam LMR pg 50	Lam LMR pg 50	\N	2014-03-02 19:15:36-05
3456	16	27	1	Lam LMR pg 50	Lam LMR pg 50	\N	2014-03-02 19:15:54-05
3457	13	29	1	logic_id=64		FwdLogicScript	2014-03-02 19:16:31-05
3458	14	29	1	logic_id=64		FwdLogicScript	2014-03-02 19:16:31-05
3459	16	29	1	logic_id=64		FwdLogicScript	2014-03-02 19:16:31-05
3460	13	28	1	logic_id=65		FwdLogicScript	2014-03-02 19:16:31-05
3461	14	28	1	logic_id=65		FwdLogicScript	2014-03-02 19:16:31-05
3462	16	28	1	logic_id=65		FwdLogicScript	2014-03-02 19:16:31-05
3463	13	31	1	logic_id=95		FwdLogicScript	2014-03-02 19:16:36-05
3464	14	31	1	logic_id=95		FwdLogicScript	2014-03-02 19:16:36-05
3465	16	31	1	logic_id=95		FwdLogicScript	2014-03-02 19:16:36-05
3466	13	30	1	logic_id=97		FwdLogicScript	2014-03-02 19:16:36-05
3467	14	30	1	logic_id=97		FwdLogicScript	2014-03-02 19:16:36-05
3468	16	30	1	logic_id=97		FwdLogicScript	2014-03-02 19:16:36-05
3469	13	35	1	logic_id=99		FwdLogicScript	2014-03-02 19:16:37-05
3470	14	35	1	logic_id=99		FwdLogicScript	2014-03-02 19:16:37-05
3471	16	35	1	logic_id=99		FwdLogicScript	2014-03-02 19:16:37-05
3472	13	34	1	logic_id=100		FwdLogicScript	2014-03-02 19:16:37-05
3473	14	34	1	logic_id=100		FwdLogicScript	2014-03-02 19:16:37-05
3474	16	34	1	logic_id=100		FwdLogicScript	2014-03-02 19:16:38-05
3475	16	33	0	logic_id=230		BkwdLogicScript	2014-03-04 14:12:05-05
3476	16	51	0	logic_id=286		BkwdLogicScript	2014-03-04 14:12:07-05
3477	16	50	0	logic_id=302		BkwdLogicScript	2014-03-04 14:12:08-05
3478	16	10	0	logic_id=315		BkwdLogicScript	2014-03-04 14:12:08-05
3479	16	11	0	logic_id=317		BkwdLogicScript	2014-03-04 14:12:08-05
3480	16	24	0	logic_id=408		BkwdLogicScript	2014-03-04 14:12:10-05
3481	16	25	0	logic_id=410		BkwdLogicScript	2014-03-04 14:12:10-05
3482	32	2	0	logic_id=382		BkwdLogicScript	2014-03-04 14:13:54-05
3483	23	12	0	logic_id=255		BkwdLogicScript	2014-03-04 14:13:56-05
3484	23	95	0	logic_id=253		BkwdLogicScript	2014-03-04 14:13:58-05
3485	32	95	0	logic_id=253		BkwdLogicScript	2014-03-04 14:13:58-05
3486	32	96	0	logic_id=252		BkwdLogicScript	2014-03-04 14:13:59-05
3487	21	1	0	logic_id=251		BkwdLogicScript	2014-03-04 14:14:00-05
3488	23	98	0	logic_id=247		BkwdLogicScript	2014-03-04 14:14:04-05
3489	32	98	0	logic_id=247		BkwdLogicScript	2014-03-04 14:14:04-05
3490	23	97	0	logic_id=246		BkwdLogicScript	2014-03-04 14:14:05-05
3491	32	10	0	logic_id=243		BkwdLogicScript	2014-03-04 14:14:08-05
3492	23	39	0	logic_id=238		BkwdLogicScript	2014-03-04 14:14:13-05
3493	23	38	0	logic_id=237		BkwdLogicScript	2014-03-04 14:14:14-05
3494	23	36	0	logic_id=232		BkwdLogicScript	2014-03-04 14:14:20-05
3495	32	36	0	logic_id=232		BkwdLogicScript	2014-03-04 14:14:21-05
3496	23	37	0	logic_id=231		BkwdLogicScript	2014-03-04 14:14:22-05
3497	32	37	0	logic_id=231		BkwdLogicScript	2014-03-04 14:14:22-05
3498	35	103	0	logic_id=481		BkwdLogicScript	2014-03-04 14:14:24-05
3499	32	132	0	logic_id=470		BkwdLogicScript	2014-03-04 14:14:26-05
3500	11	104	0	logic_id=469		BkwdLogicScript	2014-03-04 14:14:26-05
3501	32	86	0	logic_id=469		BkwdLogicScript	2014-03-04 14:14:27-05
3502	21	66	0	logic_id=468		BkwdLogicScript	2014-03-04 14:14:28-05
3503	23	33	0	logic_id=468		BkwdLogicScript	2014-03-04 14:14:28-05
3504	21	65	0	logic_id=467		BkwdLogicScript	2014-03-04 14:14:35-05
3505	13	11	0	logic_id=428		BkwdLogicScript	2014-03-04 14:14:46-05
3506	20	11	0	logic_id=428		BkwdLogicScript	2014-03-04 14:14:47-05
3507	29	11	0	logic_id=428		BkwdLogicScript	2014-03-04 14:14:48-05
3508	23	21	0	logic_id=378		BkwdLogicScript	2014-03-04 14:14:55-05
3509	23	20	0	logic_id=377		BkwdLogicScript	2014-03-04 14:14:56-05
3510	14	125	0	logic_id=365		BkwdLogicScript	2014-03-04 14:15:05-05
3511	14	124	0	logic_id=364		BkwdLogicScript	2014-03-04 14:15:06-05
3512	21	12	0	logic_id=362		BkwdLogicScript	2014-03-04 14:15:08-05
3513	32	12	0	logic_id=362		BkwdLogicScript	2014-03-04 14:15:09-05
3514	23	96	0	logic_id=355		BkwdLogicScript	2014-03-04 14:15:12-05
3515	13	10	0	logic_id=354		BkwdLogicScript	2014-03-04 14:15:13-05
3516	20	10	0	logic_id=354		BkwdLogicScript	2014-03-04 14:15:13-05
3517	23	10	0	logic_id=354		BkwdLogicScript	2014-03-04 14:15:13-05
3518	21	121	0	logic_id=348		BkwdLogicScript	2014-03-04 14:15:19-05
3519	21	120	0	logic_id=347		BkwdLogicScript	2014-03-04 14:15:21-05
3520	32	121	0	logic_id=345		BkwdLogicScript	2014-03-04 14:15:24-05
3521	32	120	0	logic_id=343		BkwdLogicScript	2014-03-04 14:15:27-05
3522	21	123	0	logic_id=342		BkwdLogicScript	2014-03-04 14:15:28-05
3523	21	122	0	logic_id=341		BkwdLogicScript	2014-03-04 14:15:29-05
3524	23	9	0	logic_id=332		BkwdLogicScript	2014-03-04 14:15:38-05
3525	25	9	0	logic_id=331		BkwdLogicScript	2014-03-04 14:15:40-05
3526	20	49	0	logic_id=328		BkwdLogicScript	2014-03-04 14:15:44-05
3527	23	11	0	logic_id=325		BkwdLogicScript	2014-03-04 14:15:47-05
3528	25	11	0	logic_id=325		BkwdLogicScript	2014-03-04 14:15:48-05
3529	25	10	0	logic_id=324		BkwdLogicScript	2014-03-04 14:15:50-05
3530	21	117	0	logic_id=322		BkwdLogicScript	2014-03-04 14:15:54-05
3531	21	3	0	logic_id=317		BkwdLogicScript	2014-03-04 14:15:59-05
3532	21	116	0	logic_id=314		BkwdLogicScript	2014-03-04 14:16:04-05
3533	21	50	0	logic_id=304		BkwdLogicScript	2014-03-04 14:16:14-05
3534	13	50	0	logic_id=303		BkwdLogicScript	2014-03-04 14:16:15-05
3535	14	50	0	logic_id=303		BkwdLogicScript	2014-03-04 14:16:15-05
3536	32	50	0	logic_id=303		BkwdLogicScript	2014-03-04 14:16:16-05
3537	21	102	0	logic_id=300		BkwdLogicScript	2014-03-04 14:16:19-05
3538	21	51	0	logic_id=288		BkwdLogicScript	2014-03-04 14:16:32-05
3539	13	51	0	logic_id=287		BkwdLogicScript	2014-03-04 14:16:34-05
3540	14	51	0	logic_id=287		BkwdLogicScript	2014-03-04 14:16:34-05
3541	32	51	0	logic_id=287		BkwdLogicScript	2014-03-04 14:16:35-05
3542	21	84	0	logic_id=282		BkwdLogicScript	2014-03-04 14:16:39-05
3543	21	103	0	logic_id=281		BkwdLogicScript	2014-03-04 14:16:40-05
3544	32	103	0	logic_id=280		BkwdLogicScript	2014-03-04 14:16:41-05
3545	25	12	0	logic_id=274		BkwdLogicScript	2014-03-04 14:16:47-05
3546	19	84	0	logic_id=269		BkwdLogicScript	2014-03-04 14:16:51-05
3547	32	84	0	logic_id=269		BkwdLogicScript	2014-03-04 14:16:52-05
3548	19	102	0	logic_id=268		BkwdLogicScript	2014-03-04 14:16:53-05
3549	32	102	0	logic_id=268		BkwdLogicScript	2014-03-04 14:16:53-05
3550	20	102	0	logic_id=267		BkwdLogicScript	2014-03-04 14:16:54-05
3551	19	51	0	logic_id=265		BkwdLogicScript	2014-03-04 14:16:57-05
3552	20	51	0	logic_id=265		BkwdLogicScript	2014-03-04 14:16:57-05
3553	19	50	0	logic_id=264		BkwdLogicScript	2014-03-04 14:16:58-05
3554	20	50	0	logic_id=264		BkwdLogicScript	2014-03-04 14:16:59-05
3555	32	63	0	logic_id=498		BkwdLogicScript	2014-03-04 14:17:12-05
3556	11	127	0	logic_id=224		BkwdLogicScript	2014-03-04 14:17:16-05
3557	11	126	0	logic_id=222		BkwdLogicScript	2014-03-04 14:17:18-05
3558	23	94	0	logic_id=214		BkwdLogicScript	2014-03-04 14:17:27-05
3559	32	94	0	logic_id=214		BkwdLogicScript	2014-03-04 14:17:28-05
3560	21	47	0	logic_id=198		BkwdLogicScript	2014-03-04 14:17:39-05
3561	21	46	0	logic_id=197		BkwdLogicScript	2014-03-04 14:17:40-05
3562	32	47	0	logic_id=196		BkwdLogicScript	2014-03-04 14:17:41-05
3563	32	46	0	logic_id=195		BkwdLogicScript	2014-03-04 14:17:42-05
3564	21	119	0	logic_id=190		BkwdLogicScript	2014-03-04 14:17:47-05
3565	21	118	0	logic_id=189		BkwdLogicScript	2014-03-04 14:17:49-05
3566	32	133	0	logic_id=444		BkwdLogicScript	2014-03-04 14:17:50-05
3567	21	113	0	logic_id=188		BkwdLogicScript	2014-03-04 14:17:50-05
3568	21	112	0	logic_id=187		BkwdLogicScript	2014-03-04 14:17:52-05
3569	32	131	0	logic_id=442		BkwdLogicScript	2014-03-04 14:17:53-05
3570	32	135	0	logic_id=440		BkwdLogicScript	2014-03-04 14:17:55-05
3571	23	23	0	logic_id=427		BkwdLogicScript	2014-03-04 14:18:03-05
3572	23	22	0	logic_id=426		BkwdLogicScript	2014-03-04 14:18:05-05
3573	23	25	0	logic_id=410		BkwdLogicScript	2014-03-04 14:18:19-05
3574	23	24	0	logic_id=408		BkwdLogicScript	2014-03-04 14:18:22-05
3575	13	46	0	logic_id=131		BkwdLogicScript	2014-03-04 14:18:38-05
3576	14	46	0	logic_id=131		BkwdLogicScript	2014-03-04 14:18:38-05
3577	16	46	0	logic_id=131		BkwdLogicScript	2014-03-04 14:18:39-05
3578	19	46	0	logic_id=131		BkwdLogicScript	2014-03-04 14:18:39-05
3579	20	46	0	logic_id=131		BkwdLogicScript	2014-03-04 14:18:39-05
3580	13	47	0	logic_id=126		BkwdLogicScript	2014-03-04 14:18:43-05
3581	14	47	0	logic_id=126		BkwdLogicScript	2014-03-04 14:18:43-05
3582	16	47	0	logic_id=126		BkwdLogicScript	2014-03-04 14:18:43-05
3583	19	47	0	logic_id=126		BkwdLogicScript	2014-03-04 14:18:43-05
3584	20	47	0	logic_id=126		BkwdLogicScript	2014-03-04 14:18:43-05
3585	16	22	0	logic_id=123		BkwdLogicScript	2014-03-04 14:18:45-05
3586	16	23	0	logic_id=120		BkwdLogicScript	2014-03-04 14:18:46-05
3587	32	87	0	logic_id=118		BkwdLogicScript	2014-03-04 14:18:48-05
3588	32	85	0	logic_id=117		BkwdLogicScript	2014-03-04 14:18:49-05
3589	32	90	0	logic_id=114		BkwdLogicScript	2014-03-04 14:18:51-05
3590	32	57	0	logic_id=113		BkwdLogicScript	2014-03-04 14:18:51-05
3591	13	45	0	logic_id=110		BkwdLogicScript	2014-03-04 14:18:53-05
3592	14	45	0	logic_id=110		BkwdLogicScript	2014-03-04 14:18:53-05
3593	16	45	0	logic_id=110		BkwdLogicScript	2014-03-04 14:18:53-05
3594	32	45	0	logic_id=110		BkwdLogicScript	2014-03-04 14:18:54-05
3595	16	16	0	logic_id=104		BkwdLogicScript	2014-03-04 14:18:58-05
3596	16	17	0	logic_id=101		BkwdLogicScript	2014-03-04 14:19:01-05
3597	32	42	0	logic_id=76		BkwdLogicScript	2014-03-04 14:19:16-05
3598	32	43	0	logic_id=75		BkwdLogicScript	2014-03-04 14:19:17-05
3599	13	44	0	logic_id=74		BkwdLogicScript	2014-03-04 14:19:17-05
3600	14	44	0	logic_id=74		BkwdLogicScript	2014-03-04 14:19:17-05
3601	16	44	0	logic_id=74		BkwdLogicScript	2014-03-04 14:19:17-05
3602	32	44	0	logic_id=74		BkwdLogicScript	2014-03-04 14:19:18-05
3603	25	38	0	logic_id=73		BkwdLogicScript	2014-03-04 14:19:19-05
3604	25	39	0	logic_id=72		BkwdLogicScript	2014-03-04 14:19:20-05
3605	21	83	0	logic_id=62		BkwdLogicScript	2014-03-04 14:19:27-05
3606	19	83	0	logic_id=60		BkwdLogicScript	2014-03-04 14:19:29-05
3607	32	83	0	logic_id=60		BkwdLogicScript	2014-03-04 14:19:30-05
3608	21	15	0	logic_id=58		BkwdLogicScript	2014-03-04 14:19:31-05
3609	23	15	0	logic_id=56		BkwdLogicScript	2014-03-04 14:19:34-05
3610	25	15	0	logic_id=56		BkwdLogicScript	2014-03-04 14:19:34-05
3611	32	15	0	logic_id=56		BkwdLogicScript	2014-03-04 14:19:34-05
3612	13	14	0	logic_id=53		BkwdLogicScript	2014-03-04 14:19:37-05
3613	16	14	0	logic_id=53		BkwdLogicScript	2014-03-04 14:19:37-05
3614	23	14	0	logic_id=53		BkwdLogicScript	2014-03-04 14:19:37-05
3615	25	36	0	logic_id=52		BkwdLogicScript	2014-03-04 14:19:38-05
3616	25	37	0	logic_id=50		BkwdLogicScript	2014-03-04 14:19:40-05
3617	32	8	0	logic_id=42		BkwdLogicScript	2014-03-04 14:19:46-05
3618	21	13	0	logic_id=28		BkwdLogicScript	2014-03-04 14:19:56-05
3619	32	13	0	logic_id=28		BkwdLogicScript	2014-03-04 14:19:56-05
3620	23	7	0	logic_id=25		BkwdLogicScript	2014-03-04 14:19:59-05
3621	25	7	0	logic_id=25		BkwdLogicScript	2014-03-04 14:19:59-05
3622	32	7	0	logic_id=25		BkwdLogicScript	2014-03-04 14:19:59-05
3623	21	53	0	logic_id=276		BkwdLogicScript	2014-03-04 14:20:04-05
3624	21	52	0	logic_id=263		BkwdLogicScript	2014-03-04 14:20:16-05
3625	32	97	0	logic_id=246		BkwdLogicScript	2014-03-04 14:46:02-05
3626	23	35	0	logic_id=240		BkwdLogicScript	2014-03-04 14:46:08-05
3627	23	34	0	logic_id=239		BkwdLogicScript	2014-03-04 14:46:09-05
3628	32	39	0	logic_id=238		BkwdLogicScript	2014-03-04 14:46:10-05
3629	32	38	0	logic_id=237		BkwdLogicScript	2014-03-04 14:46:11-05
3630	11	113	0	logic_id=380		BkwdLogicScript	2014-03-04 14:46:42-05
3631	11	112	0	logic_id=379		BkwdLogicScript	2014-03-04 14:46:43-05
3632	11	125	0	logic_id=371		BkwdLogicScript	2014-03-04 14:46:47-05
3633	11	124	0	logic_id=370		BkwdLogicScript	2014-03-04 14:46:48-05
3634	13	125	0	logic_id=365		BkwdLogicScript	2014-03-04 14:46:52-05
3635	16	125	0	logic_id=365		BkwdLogicScript	2014-03-04 14:46:53-05
3636	13	124	0	logic_id=364		BkwdLogicScript	2014-03-04 14:46:54-05
3637	16	124	0	logic_id=364		BkwdLogicScript	2014-03-04 14:46:54-05
3638	32	123	0	logic_id=342		BkwdLogicScript	2014-03-04 14:47:12-05
3639	32	122	0	logic_id=341		BkwdLogicScript	2014-03-04 14:47:13-05
3640	13	49	0	logic_id=328		BkwdLogicScript	2014-03-04 14:47:25-05
3641	14	49	0	logic_id=328		BkwdLogicScript	2014-03-04 14:47:25-05
3642	16	49	0	logic_id=328		BkwdLogicScript	2014-03-04 14:47:25-05
3643	13	48	0	logic_id=320		BkwdLogicScript	2014-03-04 14:47:34-05
3644	14	48	0	logic_id=320		BkwdLogicScript	2014-03-04 14:47:34-05
3645	16	48	0	logic_id=320		BkwdLogicScript	2014-03-04 14:47:34-05
3646	32	3	0	logic_id=317		BkwdLogicScript	2014-03-04 14:47:37-05
3647	21	58	0	logic_id=210		BkwdLogicScript	2014-03-04 14:48:40-05
3648	21	59	0	logic_id=209		BkwdLogicScript	2014-03-04 14:48:41-05
3649	21	131	0	logic_id=456		BkwdLogicScript	2014-03-04 14:48:46-05
3650	13	41	0	logic_id=434		BkwdLogicScript	2014-03-04 14:49:02-05
3651	16	41	0	logic_id=434		BkwdLogicScript	2014-03-04 14:49:02-05
3652	13	40	0	logic_id=433		BkwdLogicScript	2014-03-04 14:49:03-05
3653	16	40	0	logic_id=433		BkwdLogicScript	2014-03-04 14:49:03-05
3654	11	13	0	logic_id=430		BkwdLogicScript	2014-03-04 14:49:04-05
3655	32	93	0	logic_id=421		BkwdLogicScript	2014-03-04 14:49:11-05
3656	32	92	0	logic_id=419		BkwdLogicScript	2014-03-04 14:49:13-05
3657	32	59	0	logic_id=147		BkwdLogicScript	2014-03-04 14:49:23-05
3658	19	59	0	logic_id=146		BkwdLogicScript	2014-03-04 14:49:24-05
3659	32	58	0	logic_id=145		BkwdLogicScript	2014-03-04 14:49:25-05
3660	19	58	0	logic_id=144		BkwdLogicScript	2014-03-04 14:49:26-05
3661	21	82	0	logic_id=143		BkwdLogicScript	2014-03-04 14:49:26-05
3662	21	81	0	logic_id=142		BkwdLogicScript	2014-03-04 14:49:27-05
3663	19	54	0	logic_id=139		BkwdLogicScript	2014-03-04 14:49:28-05
3664	21	54	0	logic_id=139		BkwdLogicScript	2014-03-04 14:49:28-05
3665	32	54	0	logic_id=139		BkwdLogicScript	2014-03-04 14:49:29-05
3666	32	88	0	logic_id=136		BkwdLogicScript	2014-03-04 14:49:31-05
3667	23	30	0	logic_id=100		BkwdLogicScript	2014-03-04 14:49:50-05
3668	23	31	0	logic_id=99		BkwdLogicScript	2014-03-04 14:49:51-05
3669	23	28	0	logic_id=97		BkwdLogicScript	2014-03-04 14:49:51-05
3670	23	29	0	logic_id=95		BkwdLogicScript	2014-03-04 14:49:52-05
3671	23	32	0	logic_id=67		BkwdLogicScript	2014-03-04 14:50:06-05
3672	23	26	0	logic_id=65		BkwdLogicScript	2014-03-04 14:50:07-05
3673	23	27	0	logic_id=64		BkwdLogicScript	2014-03-04 14:50:07-05
3674	11	101	0	logic_id=255		BkwdLogicScript	2014-03-04 14:53:07-05
3675	11	14	0	logic_id=256		BkwdLogicScript	2014-03-04 14:53:07-05
3676	11	106	0	logic_id=377		BkwdLogicScript	2014-03-04 14:53:09-05
3677	11	107	0	logic_id=378		BkwdLogicScript	2014-03-04 14:53:09-05
3678	19	131	0	logic_id=441		BkwdLogicScript	2014-03-04 14:54:35-05
3679	11	68	0	logic_id=156		BkwdLogicScript	2014-03-05 14:08:54-05
3680	11	67	0	logic_id=155		BkwdLogicScript	2014-03-05 14:08:56-05
3681	13	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:25:59-05
3682	14	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:25:59-05
3683	16	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:25:59-05
3684	20	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:25:59-05
3685	24	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:25:59-05
3686	25	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:26:00-05
3687	29	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:26:00-05
3688	30	97	0	logic_id=503		BkwdLogicScript	2014-03-05 14:26:00-05
3689	13	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3690	14	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3691	16	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3692	20	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3693	24	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3694	25	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3695	29	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3696	30	98	0	logic_id=502		BkwdLogicScript	2014-03-05 14:26:00-05
3697	2	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3698	3	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3699	4	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3700	5	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3701	8	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3702	11	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3703	12	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3704	17	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3705	18	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3706	28	98	1	logic_id=504		FwdLogicScript	2014-03-05 14:38:54-05
3707	5	112	1	logic_id=500		FwdLogicScript	2014-03-05 14:39:26-05
3708	5	113	1	logic_id=501		FwdLogicScript	2014-03-05 14:39:26-05
3709	5	97	1	logic_id=505		FwdLogicScript	2014-03-05 14:45:19-05
3710	11	97	1	logic_id=505		FwdLogicScript	2014-03-05 14:45:19-05
3711	12	97	1	logic_id=505		FwdLogicScript	2014-03-05 14:45:19-05
3712	28	97	1	logic_id=505		FwdLogicScript	2014-03-05 14:45:19-05
3713	12	3	1			rschwiebert	2014-03-06 05:41:54-05
3714	12	5	1	logic_id=11		FwdLogicScript	2014-03-06 05:45:56-05
3715	12	54	1	logic_id=12		FwdLogicScript	2014-03-06 05:45:56-05
3716	12	58	1	logic_id=138		FwdLogicScript	2014-03-06 05:46:20-05
3717	12	59	1	logic_id=139		FwdLogicScript	2014-03-06 05:46:20-05
3718	12	74	1	logic_id=141		FwdLogicScript	2014-03-06 05:46:20-05
3719	12	83	1	logic_id=144		FwdLogicScript	2014-03-06 05:46:21-05
3720	12	57	1	logic_id=145		FwdLogicScript	2014-03-06 05:46:21-05
3721	12	76	1	logic_id=168		FwdLogicScript	2014-03-06 05:46:28-05
3722	12	108	1	logic_id=171		FwdLogicScript	2014-03-06 05:46:30-05
3723	12	77	1	logic_id=176		FwdLogicScript	2014-03-06 05:46:31-05
3724	12	75	1	logic_id=179		FwdLogicScript	2014-03-06 05:46:31-05
3725	12	61	1	logic_id=181		FwdLogicScript	2014-03-06 05:46:32-05
3726	12	80	1	logic_id=460		FwdLogicScript	2014-03-06 05:46:36-05
3727	12	119	1	logic_id=209		FwdLogicScript	2014-03-06 05:46:38-05
3728	12	118	1	logic_id=210		FwdLogicScript	2014-03-06 05:46:38-05
3729	12	35	1	logic_id=284		FwdLogicScript	2014-03-06 05:46:47-05
3730	12	135	1	logic_id=316		FwdLogicScript	2014-03-06 05:46:52-05
3731	12	8	1	logic_id=317		FwdLogicScript	2014-03-06 05:46:52-05
3732	12	72	1	logic_id=8		FwdLogicScript	2014-03-06 14:24:34-05
3733	12	27	1	logic_id=32		FwdLogicScript	2014-03-06 14:24:39-05
3734	12	26	1	logic_id=33		FwdLogicScript	2014-03-06 14:24:39-05
3735	12	32	1	logic_id=34		FwdLogicScript	2014-03-06 14:24:40-05
3736	12	19	1	logic_id=35		FwdLogicScript	2014-03-06 14:24:40-05
3737	12	18	1	logic_id=36		FwdLogicScript	2014-03-06 14:24:41-05
3738	12	15	1	logic_id=37		FwdLogicScript	2014-03-06 14:24:41-05
3739	12	39	1	logic_id=38		FwdLogicScript	2014-03-06 14:24:42-05
3740	12	38	1	logic_id=39		FwdLogicScript	2014-03-06 14:24:42-05
3741	12	44	1	logic_id=40		FwdLogicScript	2014-03-06 14:24:42-05
3742	12	43	1	logic_id=41		FwdLogicScript	2014-03-06 14:24:43-05
3743	12	42	1	logic_id=42		FwdLogicScript	2014-03-06 14:24:43-05
3744	12	12	1	logic_id=56		FwdLogicScript	2014-03-06 14:24:46-05
3745	12	66	1	logic_id=57		FwdLogicScript	2014-03-06 14:24:46-05
3746	12	65	1	logic_id=58		FwdLogicScript	2014-03-06 14:24:46-05
3747	12	91	1	logic_id=59		FwdLogicScript	2014-03-06 14:24:46-05
3748	12	84	1	logic_id=60		FwdLogicScript	2014-03-06 14:24:47-05
3749	12	29	1	logic_id=64		FwdLogicScript	2014-03-06 14:24:48-05
3750	12	28	1	logic_id=65		FwdLogicScript	2014-03-06 14:24:48-05
3751	12	31	1	logic_id=66		FwdLogicScript	2014-03-06 14:24:48-05
3752	12	30	1	logic_id=67		FwdLogicScript	2014-03-06 14:24:49-05
3753	12	21	1	logic_id=68		FwdLogicScript	2014-03-06 14:24:49-05
3754	12	20	1	logic_id=70		FwdLogicScript	2014-03-06 14:24:50-05
3755	12	4	1	logic_id=71		FwdLogicScript	2014-03-06 14:24:50-05
3756	12	45	1	logic_id=74		FwdLogicScript	2014-03-06 14:24:51-05
3757	12	103	1	logic_id=86		FwdLogicScript	2014-03-06 14:24:53-05
3758	12	102	1	logic_id=87		FwdLogicScript	2014-03-06 14:24:53-05
3759	12	90	1	logic_id=88		FwdLogicScript	2014-03-06 14:24:53-05
3760	12	62	1	logic_id=92		FwdLogicScript	2014-03-06 14:24:54-05
3761	12	85	1	logic_id=93		FwdLogicScript	2014-03-06 14:24:54-05
3762	12	87	1	logic_id=94		FwdLogicScript	2014-03-06 14:24:55-05
3763	12	73	1	logic_id=98		FwdLogicScript	2014-03-06 14:24:56-05
3764	12	34	1	logic_id=100		FwdLogicScript	2014-03-06 14:24:57-05
3765	12	2	1	logic_id=108		FwdLogicScript	2014-03-06 14:24:58-05
3766	12	47	1	logic_id=109		FwdLogicScript	2014-03-06 14:24:58-05
3767	12	46	1	logic_id=110		FwdLogicScript	2014-03-06 14:24:58-05
3768	12	56	1	logic_id=111		FwdLogicScript	2014-03-06 14:24:59-05
3769	12	88	1	logic_id=112		FwdLogicScript	2014-03-06 14:24:59-05
3770	12	64	1	logic_id=116		FwdLogicScript	2014-03-06 14:25:00-05
3771	12	86	1	logic_id=117		FwdLogicScript	2014-03-06 14:25:00-05
3772	12	49	1	logic_id=125		FwdLogicScript	2014-03-06 14:25:02-05
3773	12	51	1	logic_id=126		FwdLogicScript	2014-03-06 14:25:02-05
3774	12	82	1	logic_id=127		FwdLogicScript	2014-03-06 14:25:02-05
3775	12	52	1	logic_id=128		FwdLogicScript	2014-03-06 14:25:03-05
3776	12	48	1	logic_id=130		FwdLogicScript	2014-03-06 14:25:03-05
3777	12	50	1	logic_id=131		FwdLogicScript	2014-03-06 14:25:03-05
3778	12	81	1	logic_id=132		FwdLogicScript	2014-03-06 14:25:03-05
3779	12	53	1	logic_id=133		FwdLogicScript	2014-03-06 14:25:04-05
3780	12	70	1	logic_id=148		FwdLogicScript	2014-03-06 14:25:11-05
3781	12	79	1	logic_id=149		FwdLogicScript	2014-03-06 14:25:12-05
3782	12	131	1	logic_id=440		FwdLogicScript	2014-03-06 14:25:22-05
3783	12	133	1	logic_id=442		FwdLogicScript	2014-03-06 14:25:22-05
3784	12	132	1	logic_id=444		FwdLogicScript	2014-03-06 14:25:23-05
3785	12	116	1	logic_id=189		FwdLogicScript	2014-03-06 14:25:23-05
3786	12	117	1	logic_id=190		FwdLogicScript	2014-03-06 14:25:24-05
3787	12	134	1	logic_id=446		FwdLogicScript	2014-03-06 14:25:24-05
3788	12	120	1	logic_id=195		FwdLogicScript	2014-03-06 14:25:25-05
3789	12	121	1	logic_id=196		FwdLogicScript	2014-03-06 14:25:26-05
3790	12	122	1	logic_id=197		FwdLogicScript	2014-03-06 14:25:26-05
3791	12	123	1	logic_id=198		FwdLogicScript	2014-03-06 14:25:26-05
3792	12	115	1	logic_id=206		FwdLogicScript	2014-03-06 14:25:28-05
3793	12	78	1	logic_id=463		FwdLogicScript	2014-03-06 14:25:28-05
3794	12	100	1	logic_id=361		FwdLogicScript	2014-03-06 14:25:55-05
3795	6	9	1			rschwiebert	2014-03-06 14:31:25-05
3796	12	71	1	logic_id=7		FwdLogicScript	2014-03-06 14:33:02-05
3797	12	92	1	logic_id=14		FwdLogicScript	2014-03-06 14:33:04-05
3798	12	93	1	logic_id=16		FwdLogicScript	2014-03-06 14:33:04-05
3799	12	69	1	logic_id=150		FwdLogicScript	2014-03-06 14:33:27-05
3800	12	114	1	logic_id=205		FwdLogicScript	2014-03-06 14:33:41-05
3801	6	105	1	logic_id=221		FwdLogicScript	2014-03-06 14:33:46-05
3802	12	99	1	logic_id=359		FwdLogicScript	2014-03-06 14:34:07-05
3803	6	56	0	There are infinitely many maximal ideals.		rschwiebert	2014-03-06 14:39:12-05
3804	6	111	1	logic_id=162		FwdLogicScript	2014-03-06 14:39:52-05
3805	6	110	1	logic_id=163		FwdLogicScript	2014-03-06 14:39:53-05
3806	6	109	1	logic_id=160		FwdLogicScript	2014-03-06 14:53:53-05
3807	6	133	0	logic_id=413		BkwdLogicScript	2014-03-06 14:56:15-05
3808	6	134	0	logic_id=332		BkwdLogicScript	2014-03-06 14:56:52-05
3809	6	55	0	logic_id=330		BkwdLogicScript	2014-03-06 14:56:55-05
3810	6	88	0	logic_id=447		BkwdLogicScript	2014-03-06 14:58:23-05
3811	6	93	0	logic_id=420		BkwdLogicScript	2014-03-06 14:58:42-05
3812	6	92	0	logic_id=418		BkwdLogicScript	2014-03-06 14:58:44-05
3813	6	57	0	logic_id=112		BkwdLogicScript	2014-03-06 14:59:10-05
3814	6	42	0	logic_id=76		BkwdLogicScript	2014-03-06 14:59:28-05
3815	6	43	0	logic_id=75		BkwdLogicScript	2014-03-06 14:59:29-05
3816	6	40	0	logic_id=48		BkwdLogicScript	2014-03-06 14:59:44-05
3817	6	41	0	logic_id=45		BkwdLogicScript	2014-03-06 14:59:45-05
3818	6	26	0	A hereditary ring is a UFD iff it's a PID, but this is a UFD that isn't a PID	R.B. Ash A course in Algebraic Number theory, p 24	rschwiebert	\N
3819	6	27	0	symmetry		SymmScript	2014-03-07 03:42:47-05
3820	6	86	0	logic_id=270		BkwdLogicScript	2014-03-07 03:43:28-05
3821	6	28	0	logic_id=453		BkwdLogicScript	2014-03-07 03:43:33-05
3822	6	29	0	logic_id=454		BkwdLogicScript	2014-03-07 03:43:33-05
3823	6	132	0	logic_id=470		BkwdLogicScript	2014-03-07 03:43:34-05
3824	6	85	0	logic_id=117		BkwdLogicScript	2014-03-07 03:43:52-05
3825	6	87	0	logic_id=118		BkwdLogicScript	2014-03-07 03:43:52-05
3826	6	90	0	logic_id=114		BkwdLogicScript	2014-03-07 03:44:14-05
3827	6	18	0	logic_id=506		BkwdLogicScript	2014-03-07 03:52:08-05
3828	6	19	0	logic_id=507		BkwdLogicScript	2014-03-07 03:52:08-05
3829	6	20	0	logic_id=262		BkwdLogicScript	2014-03-07 03:52:28-05
3830	6	21	0	logic_id=275		BkwdLogicScript	2014-03-07 03:52:28-05
3831	6	60	1	logic_id=159		FwdLogicScript	2014-03-07 03:54:28-05
3832	11	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:24-05
3833	13	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:24-05
3834	14	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:24-05
3835	15	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:24-05
3836	16	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:24-05
3837	19	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:24-05
3838	20	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:25-05
3839	24	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:25-05
3840	25	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:25-05
3841	26	96	0	logic_id=510		BkwdLogicScript	2014-03-07 05:10:25-05
3842	11	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:40-05
3843	13	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3844	14	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3845	15	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3846	16	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3847	19	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3848	20	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3849	24	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3850	25	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3851	26	94	0	logic_id=214		BkwdLogicScript	2014-03-07 05:10:41-05
3852	11	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3853	13	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3854	14	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3855	16	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3856	19	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3857	20	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3858	24	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3859	25	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:42-05
3860	26	95	0	logic_id=213		BkwdLogicScript	2014-03-07 05:10:43-05
3861	27	40	1	nontrivial ideals are of the form (x^n)		rschwiebert	\N
3862	27	41	1	symmetry		SymmScript	2014-03-07 05:32:51-05
3863	27	43	1	logic_id=44		FwdLogicScript	2014-03-09 17:17:52-04
3864	27	42	1	logic_id=47		FwdLogicScript	2014-03-09 17:17:53-04
3865	20	48	0	logic_id=511		BkwdLogicScript	2014-03-09 17:19:22-04
3866	2	63	0	obvious		rschwiebert	\N
3867	3	63	0	obvious		rschwiebert	\N
3868	4	63	0	obvious		rschwiebert	\N
3869	17	63	0	obvious		rschwiebert	\N
3870	18	63	0	obvious		rschwiebert	\N
3871	33	56	0		T.Y. Lam Exercises in classical ring theory p 286	rschwiebert	\N
3872	33	91	1		T.Y. Lam Exercises in classical ring theory p 286	rschwiebert	\N
3873	37	22	1		T.Y. Lam Exercises in classical ring theory p 286	rschwiebert	\N
3874	37	91	1		T.Y. Lam Exercises in classical ring theory p 286	rschwiebert	\N
3875	37	1	1	obvious		rschwiebert	\N
3876	37	56	0		T.Y. Lam Exercises in classical ring theory p 286	\N	\N
3877	37	23	1	symmetry		SymmScript	2014-03-13 03:50:58-04
3878	1	91	0	Use a=5 and b=13	rschwiebert	rschwiebert	\N
3879	37	62	1	logic_id=1		FwdLogicScript	2014-03-13 13:11:45-04
3880	37	67	1	logic_id=2		FwdLogicScript	2014-03-13 13:11:45-04
3881	37	68	1	logic_id=3		FwdLogicScript	2014-03-13 13:11:46-04
3882	37	100	1	logic_id=4		FwdLogicScript	2014-03-13 13:11:46-04
3883	37	99	1	logic_id=5		FwdLogicScript	2014-03-13 13:11:46-04
3884	37	101	1	logic_id=6		FwdLogicScript	2014-03-13 13:11:46-04
3885	37	61	1	logic_id=115		FwdLogicScript	2014-03-13 13:11:53-04
3886	37	64	1	logic_id=116		FwdLogicScript	2014-03-13 13:11:53-04
3887	37	21	1	logic_id=119		FwdLogicScript	2014-03-13 13:11:54-04
3888	37	25	1	logic_id=120		FwdLogicScript	2014-03-13 13:11:54-04
3889	37	20	1	logic_id=122		FwdLogicScript	2014-03-13 13:11:54-04
3890	37	24	1	logic_id=123		FwdLogicScript	2014-03-13 13:11:54-04
3891	37	128	1	logic_id=403		FwdLogicScript	2014-03-13 13:11:56-04
3892	37	33	1	logic_id=408		FwdLogicScript	2014-03-13 13:11:57-04
3893	37	71	1	logic_id=409		FwdLogicScript	2014-03-13 13:11:57-04
3894	37	106	1	logic_id=155		FwdLogicScript	2014-03-13 13:11:57-04
3895	37	72	1	logic_id=411		FwdLogicScript	2014-03-13 13:11:57-04
3896	37	107	1	logic_id=156		FwdLogicScript	2014-03-13 13:11:58-04
3897	37	104	1	logic_id=157		FwdLogicScript	2014-03-13 13:11:58-04
3898	37	10	1	logic_id=423		FwdLogicScript	2014-03-13 13:11:59-04
3899	37	96	1	logic_id=426		FwdLogicScript	2014-03-13 13:11:59-04
3900	37	108	1	logic_id=435		FwdLogicScript	2014-03-13 13:12:00-04
3901	37	130	1	logic_id=201		FwdLogicScript	2014-03-13 13:12:03-04
3902	37	14	1	logic_id=464		FwdLogicScript	2014-03-13 13:12:03-04
3903	37	32	1	logic_id=465		FwdLogicScript	2014-03-13 13:12:03-04
3904	37	89	1	logic_id=471		FwdLogicScript	2014-03-13 13:12:04-04
3905	37	28	1	logic_id=219		FwdLogicScript	2014-03-13 13:12:04-04
3906	37	80	1	logic_id=475		FwdLogicScript	2014-03-13 13:12:04-04
3907	37	29	1	logic_id=220		FwdLogicScript	2014-03-13 13:12:04-04
3908	37	78	1	logic_id=476		FwdLogicScript	2014-03-13 13:12:04-04
3909	37	126	1	logic_id=372		FwdLogicScript	2014-03-13 13:12:18-04
3910	37	124	1	logic_id=377		FwdLogicScript	2014-03-13 13:12:19-04
3911	37	125	1	logic_id=378		FwdLogicScript	2014-03-13 13:12:19-04
3912	37	11	1	logic_id=53		FwdLogicScript	2014-03-13 13:27:28-04
3913	37	35	1	logic_id=54		FwdLogicScript	2014-03-13 13:27:28-04
3914	37	34	1	logic_id=55		FwdLogicScript	2014-03-13 13:27:28-04
3915	37	31	1	logic_id=66		FwdLogicScript	2014-03-13 13:27:29-04
3916	37	30	1	logic_id=67		FwdLogicScript	2014-03-13 13:27:29-04
3917	37	74	1	logic_id=96		FwdLogicScript	2014-03-13 13:27:31-04
3918	37	73	1	logic_id=98		FwdLogicScript	2014-03-13 13:27:32-04
3919	37	129	1	logic_id=401		FwdLogicScript	2014-03-13 13:27:35-04
3920	37	70	1	logic_id=148		FwdLogicScript	2014-03-13 13:27:36-04
3921	37	79	1	logic_id=149		FwdLogicScript	2014-03-13 13:27:36-04
3922	37	69	1	logic_id=150		FwdLogicScript	2014-03-13 13:27:36-04
3923	37	77	1	logic_id=151		FwdLogicScript	2014-03-13 13:27:37-04
3924	37	114	1	logic_id=205		FwdLogicScript	2014-03-13 13:27:43-04
3925	37	115	1	logic_id=206		FwdLogicScript	2014-03-13 13:27:43-04
3926	37	127	1	logic_id=371		FwdLogicScript	2014-03-13 13:27:59-04
3927	37	57	0	logic_id=111		BkwdLogicScript	2014-03-13 13:32:15-04
3928	37	47	0	logic_id=129		BkwdLogicScript	2014-03-13 13:32:15-04
3929	37	46	0	logic_id=134		BkwdLogicScript	2014-03-13 13:32:15-04
3930	37	58	0	logic_id=145		BkwdLogicScript	2014-03-13 13:32:16-04
3931	37	59	0	logic_id=147		BkwdLogicScript	2014-03-13 13:32:16-04
3932	37	51	0	logic_id=296		BkwdLogicScript	2014-03-13 13:32:18-04
3933	37	86	0	logic_id=299		BkwdLogicScript	2014-03-13 13:32:18-04
3934	37	50	0	logic_id=312		BkwdLogicScript	2014-03-13 13:32:18-04
3935	37	120	0	logic_id=344		BkwdLogicScript	2014-03-13 13:32:19-04
3936	37	121	0	logic_id=346		BkwdLogicScript	2014-03-13 13:32:19-04
3937	37	133	0	logic_id=445		BkwdLogicScript	2014-03-13 13:32:21-04
3938	37	43	0	logic_id=75		BkwdLogicScript	2014-03-13 13:32:23-04
3939	37	42	0	logic_id=76		BkwdLogicScript	2014-03-13 13:32:23-04
3940	37	55	0	logic_id=77		BkwdLogicScript	2014-03-13 13:32:23-04
3941	37	45	0	logic_id=109		BkwdLogicScript	2014-03-13 13:32:24-04
3942	37	85	0	logic_id=117		BkwdLogicScript	2014-03-13 13:32:24-04
3943	37	87	0	logic_id=118		BkwdLogicScript	2014-03-13 13:32:24-04
3944	37	88	0	logic_id=136		BkwdLogicScript	2014-03-13 13:32:24-04
3945	37	54	0	logic_id=138		BkwdLogicScript	2014-03-13 13:32:24-04
3946	37	2	0	logic_id=382		BkwdLogicScript	2014-03-13 13:32:29-04
3947	37	84	0	logic_id=407		BkwdLogicScript	2014-03-13 13:32:30-04
3948	37	92	0	logic_id=418		BkwdLogicScript	2014-03-13 13:32:30-04
3949	37	93	0	logic_id=420		BkwdLogicScript	2014-03-13 13:32:30-04
3950	37	131	0	logic_id=441		BkwdLogicScript	2014-03-13 13:32:31-04
3951	37	132	0	logic_id=470		BkwdLogicScript	2014-03-13 13:32:31-04
3952	37	3	0	logic_id=484		BkwdLogicScript	2014-03-13 13:32:32-04
3953	37	63	0	logic_id=498		BkwdLogicScript	2014-03-13 13:32:32-04
3954	37	8	0	logic_id=41		BkwdLogicScript	2014-03-13 14:04:04-04
3955	37	41	0	logic_id=44		BkwdLogicScript	2014-03-13 14:04:04-04
3956	37	40	0	logic_id=47		BkwdLogicScript	2014-03-13 14:04:04-04
3957	37	83	0	logic_id=60		BkwdLogicScript	2014-03-13 14:04:05-04
3958	37	44	0	logic_id=74		BkwdLogicScript	2014-03-13 14:04:05-04
3959	37	12	0	logic_id=89		BkwdLogicScript	2014-03-13 14:04:05-04
3960	37	90	0	logic_id=114		BkwdLogicScript	2014-03-13 14:04:06-04
3961	37	38	0	logic_id=237		BkwdLogicScript	2014-03-13 14:04:08-04
3962	37	39	0	logic_id=238		BkwdLogicScript	2014-03-13 14:04:08-04
3963	37	97	0	logic_id=246		BkwdLogicScript	2014-03-13 14:04:08-04
3964	37	122	0	logic_id=341		BkwdLogicScript	2014-03-13 14:04:12-04
3965	37	123	0	logic_id=342		BkwdLogicScript	2014-03-13 14:04:12-04
3966	37	135	0	logic_id=440		BkwdLogicScript	2014-03-13 14:04:16-04
3967	37	98	0	logic_id=505		BkwdLogicScript	2014-03-13 14:04:19-04
3968	37	6	0	logic_id=17		BkwdLogicScript	2014-03-13 14:04:20-04
3969	37	13	0	logic_id=28		BkwdLogicScript	2014-03-13 14:04:20-04
3970	37	15	0	logic_id=56		BkwdLogicScript	2014-03-13 14:04:21-04
3971	37	37	0	logic_id=231		BkwdLogicScript	2014-03-13 14:04:25-04
3972	37	36	0	logic_id=232		BkwdLogicScript	2014-03-13 14:04:25-04
3973	37	116	0	logic_id=314		BkwdLogicScript	2014-03-13 14:04:28-04
3974	37	117	0	logic_id=322		BkwdLogicScript	2014-03-13 14:04:28-04
3975	37	65	0	logic_id=467		BkwdLogicScript	2014-03-13 14:04:32-04
3976	37	66	0	logic_id=468		BkwdLogicScript	2014-03-13 14:04:33-04
3977	37	103	0	logic_id=481		BkwdLogicScript	2014-03-13 14:04:33-04
3978	37	7	0	logic_id=504		BkwdLogicScript	2014-03-13 14:04:34-04
3979	37	112	0	logic_id=187		BkwdLogicScript	2014-03-13 14:06:15-04
3980	37	113	0	logic_id=188		BkwdLogicScript	2014-03-13 14:06:15-04
3981	37	118	0	logic_id=189		BkwdLogicScript	2014-03-13 14:06:15-04
3982	37	119	0	logic_id=190		BkwdLogicScript	2014-03-13 14:06:15-04
3983	37	52	0	logic_id=263		BkwdLogicScript	2014-03-13 14:06:18-04
3984	37	53	0	logic_id=276		BkwdLogicScript	2014-03-13 14:06:18-04
3985	37	102	0	logic_id=300		BkwdLogicScript	2014-03-13 14:06:20-04
3986	37	81	0	logic_id=142		BkwdLogicScript	2014-03-13 14:06:31-04
3987	37	82	0	logic_id=143		BkwdLogicScript	2014-03-13 14:06:31-04
3988	37	19	0	Not a UFD implies not a PID		rschwiebert	\N
3989	37	18	0	symmetry		SymmScript	2014-03-13 14:41:10-04
3990	37	17	0	logic_id=103		BkwdLogicScript	2014-03-13 14:41:30-04
3991	37	16	0	logic_id=106		BkwdLogicScript	2014-03-13 14:41:30-04
3992	37	95	0	logic_id=253		BkwdLogicScript	2014-03-13 14:41:34-04
3993	37	4	0	logic_id=262		BkwdLogicScript	2014-03-13 14:41:34-04
3994	37	5	0	logic_id=275		BkwdLogicScript	2014-03-13 14:41:35-04
3995	37	26	0	logic_id=414		BkwdLogicScript	2014-03-14 02:10:27-04
3996	37	27	0	logic_id=415		BkwdLogicScript	2014-03-14 02:10:27-04
3997	37	94	0	logic_id=458		BkwdLogicScript	2014-03-14 02:10:28-04
3998	37	75	0	logic_id=514		BkwdLogicScript	2014-03-14 02:10:30-04
3999	37	76	0	logic_id=515		BkwdLogicScript	2014-03-14 02:10:30-04
4000	29	67	0	Right ideal generated by [[0,0],[0,1]] is not a left ideal	rschwiebert	rschwiebert	\N
4001	29	68	0	Left ideal generated by [[1,0],[0,0]] is not a right ideal	rschwiebert	rschwiebert	\N
4002	29	106	1	R/rad(R) is a product of fields	rschwiebert	rschwiebert	\N
4003	29	107	1	R/rad(R) is a product of fields	rschwiebert	rschwiebert	\N
4004	29	104	0	[[1,0],[0,0]] is idempotent	rschwiebert	rschwiebert	\N
4005	29	55	0	logic_id=154		BkwdLogicScript	2014-03-19 14:23:10-04
4006	29	126	0	logic_id=222		BkwdLogicScript	2014-03-19 14:23:11-04
4007	29	127	0	logic_id=224		BkwdLogicScript	2014-03-19 14:23:11-04
4008	29	40	0	logic_id=226		BkwdLogicScript	2014-03-19 14:23:11-04
4009	29	41	0	logic_id=227		BkwdLogicScript	2014-03-19 14:23:11-04
4010	29	112	0	logic_id=379		BkwdLogicScript	2014-03-19 14:23:15-04
4011	29	113	0	logic_id=380		BkwdLogicScript	2014-03-19 14:23:16-04
4012	29	129	0	Use the two matrices [[0,2],[0,2]] and [[1,2],[0,2]]	rschwiebert	rschwiebert	\N
4013	29	130	0	logic_id=401		BkwdLogicScript	2014-03-20 02:54:57-04
4014	29	132	0	R/rad(R) is isomorphic to F2xF2	rschwiebert	rschwiebert	\N
4015	29	133	0	logic_id=444		BkwdLogicScript	2014-03-20 03:09:17-04
4016	29	131	0	logic_id=442		BkwdLogicScript	2014-03-20 03:09:40-04
4017	34	6	0	obvious	rschwiebert	rschwiebert	\N
4018	34	37	0	logic_id=231		BkwdLogicScript	2014-03-20 04:08:03-04
4019	34	36	0	logic_id=232		BkwdLogicScript	2014-03-20 04:08:04-04
4020	34	98	0	logic_id=247		BkwdLogicScript	2014-03-20 04:08:04-04
4021	34	116	0	logic_id=314		BkwdLogicScript	2014-03-20 04:08:05-04
4022	34	117	0	logic_id=322		BkwdLogicScript	2014-03-20 04:08:05-04
4023	34	120	0	logic_id=347		BkwdLogicScript	2014-03-20 04:08:06-04
4024	34	121	0	logic_id=348		BkwdLogicScript	2014-03-20 04:08:06-04
4025	34	12	0	logic_id=362		BkwdLogicScript	2014-03-20 04:08:06-04
4026	34	63	0	logic_id=436		BkwdLogicScript	2014-03-20 04:08:07-04
4027	34	83	0	logic_id=466		BkwdLogicScript	2014-03-20 04:08:07-04
4028	34	65	0	logic_id=467		BkwdLogicScript	2014-03-20 04:08:08-04
4029	34	66	0	logic_id=468		BkwdLogicScript	2014-03-20 04:08:08-04
4030	34	103	0	logic_id=481		BkwdLogicScript	2014-03-20 04:08:08-04
4031	34	7	0	logic_id=504		BkwdLogicScript	2014-03-20 04:08:08-04
4032	34	51	0	logic_id=15		BkwdLogicScript	2014-03-20 04:08:25-04
4033	34	13	0	logic_id=28		BkwdLogicScript	2014-03-20 04:08:25-04
4034	34	15	0	logic_id=56		BkwdLogicScript	2014-03-20 04:08:26-04
4035	34	47	0	logic_id=126		BkwdLogicScript	2014-03-20 04:08:27-04
4036	34	58	0	logic_id=144		BkwdLogicScript	2014-03-20 04:08:27-04
4037	34	59	0	logic_id=146		BkwdLogicScript	2014-03-20 04:08:28-04
4038	34	112	0	logic_id=187		BkwdLogicScript	2014-03-20 04:08:28-04
4039	34	113	0	logic_id=188		BkwdLogicScript	2014-03-20 04:08:28-04
4040	34	118	0	logic_id=189		BkwdLogicScript	2014-03-20 04:08:28-04
4041	34	119	0	logic_id=190		BkwdLogicScript	2014-03-20 04:08:28-04
4042	34	46	0	logic_id=195		BkwdLogicScript	2014-03-20 04:08:28-04
4043	34	38	0	logic_id=237		BkwdLogicScript	2014-03-20 04:08:29-04
4044	34	39	0	logic_id=238		BkwdLogicScript	2014-03-20 04:08:29-04
4045	34	84	0	logic_id=244		BkwdLogicScript	2014-03-20 04:08:30-04
4046	34	97	0	logic_id=246		BkwdLogicScript	2014-03-20 04:08:30-04
4047	34	52	0	logic_id=263		BkwdLogicScript	2014-03-20 04:08:30-04
4048	34	53	0	logic_id=276		BkwdLogicScript	2014-03-20 04:08:30-04
4049	34	102	0	logic_id=279		BkwdLogicScript	2014-03-20 04:08:30-04
4050	34	50	0	logic_id=303		BkwdLogicScript	2014-03-20 04:08:31-04
4051	34	3	0	logic_id=315		BkwdLogicScript	2014-03-20 04:08:32-04
4052	34	2	0	logic_id=323		BkwdLogicScript	2014-03-20 04:08:32-04
4053	34	54	0	logic_id=437		BkwdLogicScript	2014-03-20 04:08:34-04
4054	34	135	0	logic_id=439		BkwdLogicScript	2014-03-20 04:08:34-04
4055	34	131	0	logic_id=441		BkwdLogicScript	2014-03-20 04:08:34-04
4056	34	8	0	logic_id=37		BkwdLogicScript	2014-03-20 04:08:45-04
4057	34	45	0	logic_id=107		BkwdLogicScript	2014-03-20 04:08:47-04
4058	34	81	0	logic_id=142		BkwdLogicScript	2014-03-20 04:08:47-04
4059	34	82	0	logic_id=143		BkwdLogicScript	2014-03-20 04:08:48-04
4060	34	122	0	logic_id=341		BkwdLogicScript	2014-03-20 04:08:53-04
4061	34	123	0	logic_id=342		BkwdLogicScript	2014-03-20 04:08:53-04
4062	34	44	0	logic_id=74		BkwdLogicScript	2014-03-20 04:09:05-04
4063	12	6	0	obvious	rschwiebert	rschwiebert	\N
4064	12	33	0	logic_id=314		BkwdLogicScript	2014-03-20 14:31:10-04
4065	12	55	0	logic_id=330		BkwdLogicScript	2014-03-20 14:31:11-04
4066	12	104	0	logic_id=343		BkwdLogicScript	2014-03-20 14:31:11-04
4067	12	24	0	logic_id=408		BkwdLogicScript	2014-03-20 14:31:13-04
4068	12	25	0	logic_id=410		BkwdLogicScript	2014-03-20 14:31:13-04
4069	12	96	0	logic_id=510		BkwdLogicScript	2014-03-20 14:31:15-04
4070	12	41	0	logic_id=45		BkwdLogicScript	2014-03-20 14:31:40-04
4071	12	40	0	logic_id=48		BkwdLogicScript	2014-03-20 14:31:40-04
4072	12	23	0	logic_id=120		BkwdLogicScript	2014-03-20 14:31:41-04
4073	12	22	0	logic_id=123		BkwdLogicScript	2014-03-20 14:31:41-04
4074	12	95	0	logic_id=213		BkwdLogicScript	2014-03-20 14:31:42-04
4075	12	94	0	logic_id=214		BkwdLogicScript	2014-03-20 14:31:43-04
4076	12	16	0	logic_id=215		BkwdLogicScript	2014-03-20 14:31:43-04
4077	12	17	0	logic_id=216		BkwdLogicScript	2014-03-20 14:31:43-04
4078	12	126	0	logic_id=222		BkwdLogicScript	2014-03-20 14:31:43-04
4079	12	127	0	logic_id=224		BkwdLogicScript	2014-03-20 14:31:43-04
4080	12	124	0	logic_id=370		BkwdLogicScript	2014-03-20 14:31:46-04
4081	12	125	0	logic_id=371		BkwdLogicScript	2014-03-20 14:31:46-04
4082	12	106	0	logic_id=377		BkwdLogicScript	2014-03-20 14:31:46-04
4083	12	107	0	logic_id=378		BkwdLogicScript	2014-03-20 14:31:46-04
4084	12	112	0	logic_id=379		BkwdLogicScript	2014-03-20 14:31:46-04
4085	12	113	0	logic_id=380		BkwdLogicScript	2014-03-20 14:31:46-04
4086	12	13	0	logic_id=429		BkwdLogicScript	2014-03-20 14:31:47-04
4087	12	67	0	logic_id=155		BkwdLogicScript	2014-03-20 14:32:08-04
4088	12	68	0	logic_id=156		BkwdLogicScript	2014-03-20 14:32:08-04
4089	12	101	0	logic_id=255		BkwdLogicScript	2014-03-20 14:32:09-04
4090	12	14	0	logic_id=256		BkwdLogicScript	2014-03-20 14:32:10-04
4091	26	61	1	logic_id=517		FwdLogicScript	2014-03-28 02:29:14-04
4092	20	21	0	logic_id=515		BkwdLogicScript	2014-03-28 02:37:27-04
4093	33	76	0	logic_id=515		BkwdLogicScript	2014-03-28 02:37:28-04
4094	33	75	0	logic_id=514		BkwdLogicScript	2014-03-28 02:37:33-04
4095	33	133	0	logic_id=445		BkwdLogicScript	2014-03-28 02:39:28-04
4096	33	55	0	logic_id=443		BkwdLogicScript	2014-03-28 02:39:34-04
4097	33	57	0	logic_id=111		BkwdLogicScript	2014-03-28 02:40:38-04
4098	33	42	0	logic_id=76		BkwdLogicScript	2014-03-28 02:41:04-04
4099	33	43	0	logic_id=75		BkwdLogicScript	2014-03-28 02:41:06-04
4100	33	40	0	logic_id=48		BkwdLogicScript	2014-03-28 02:41:51-04
4101	33	41	0	logic_id=45		BkwdLogicScript	2014-03-28 02:41:56-04
4102	20	41	0	logic_id=43		BkwdLogicScript	2014-03-28 02:41:59-04
4103	15	128	0	logic_id=517		BkwdLogicScript	2014-03-28 02:42:55-04
4104	33	86	0	logic_id=480		BkwdLogicScript	2014-03-28 04:19:23-04
4105	33	132	0	logic_id=470		BkwdLogicScript	2014-03-28 04:19:24-04
4106	15	129	0	logic_id=402		BkwdLogicScript	2014-03-28 04:22:37-04
4107	15	130	0	logic_id=401		BkwdLogicScript	2014-03-28 04:22:39-04
4108	33	87	0	logic_id=118		BkwdLogicScript	2014-03-28 04:22:54-04
4109	33	85	0	logic_id=117		BkwdLogicScript	2014-03-28 04:22:55-04
4110	33	90	0	logic_id=114		BkwdLogicScript	2014-03-28 04:22:56-04
4111	33	93	0	logic_id=421		BkwdLogicScript	2014-03-28 04:28:50-04
4112	33	92	0	logic_id=419		BkwdLogicScript	2014-03-28 04:28:52-04
4113	33	88	0	logic_id=136		BkwdLogicScript	2014-03-28 04:29:09-04
4114	23	113	0	Socle has composition length 3		rschwiebert	2014-05-09 14:36:31-04
4115	23	112	0	Socle has composition length 3		rschwiebert	2014-05-09 14:36:48-04
4116	19	26	1		T.Y. Lam Lectures on Modules and Rings p46	rschwiebert	2014-05-10 15:22:39-04
4117	19	29	1		T.Y. Lam Lectures on Modules and Rings p46	rschwiebert	2014-05-10 15:23:20-04
4118	19	27	0		T.Y. Lam Lectures on Modules and Rings p46	rschwiebert	2014-05-10 15:23:46-04
4133	19	28	1	logic_id=65		FwdLogicScript	2014-05-10 15:47:03-04
4134	19	31	1	logic_id=95		FwdLogicScript	2014-05-10 15:47:11-04
4135	19	74	1	logic_id=96		FwdLogicScript	2014-05-10 15:47:11-04
4136	19	30	1	logic_id=97		FwdLogicScript	2014-05-10 15:47:12-04
4137	19	35	1	logic_id=99		FwdLogicScript	2014-05-10 15:47:12-04
4138	19	34	1	logic_id=100		FwdLogicScript	2014-05-10 15:47:13-04
4139	19	1	0	logic_id=239		BkwdLogicScript	2014-05-10 16:00:19-04
4140	19	124	0	logic_id=364		BkwdLogicScript	2014-05-10 16:00:24-04
4141	19	125	0	logic_id=365		BkwdLogicScript	2014-05-10 16:00:24-04
4142	19	40	0	logic_id=433		BkwdLogicScript	2014-05-10 16:00:26-04
4143	19	41	0	logic_id=434		BkwdLogicScript	2014-05-10 16:00:26-04
4144	38	113	1	obvious		rschwiebert	2014-05-11 04:15:26-04
4145	38	55	1	(x) is the unique maximal ideal		rschwiebert	2014-05-11 04:16:09-04
4146	38	112	0	right socle has composition length n		rschwiebert	2014-05-11 04:17:03-04
4147	38	3	1	Left composition length 2		rschwiebert	2014-05-11 05:03:31-04
4148	38	2	1	Left composition length n+1		rschwiebert	2014-05-11 05:03:58-04
4149	38	79	1	logic_id=0		FwdLogicScript	2014-05-11 05:05:01-04
4150	38	4	1	logic_id=9		FwdLogicScript	2014-05-11 05:05:05-04
4151	38	54	1	logic_id=10		FwdLogicScript	2014-05-11 05:05:06-04
4152	38	5	1	logic_id=11		FwdLogicScript	2014-05-11 05:05:06-04
4153	38	57	1	logic_id=77		FwdLogicScript	2014-05-11 05:05:24-04
4154	38	107	1	logic_id=78		FwdLogicScript	2014-05-11 05:05:24-04
4155	38	106	1	logic_id=79		FwdLogicScript	2014-05-11 05:05:24-04
4156	38	56	1	logic_id=111		FwdLogicScript	2014-05-11 05:05:32-04
4157	38	88	1	logic_id=112		FwdLogicScript	2014-05-11 05:05:33-04
4158	38	90	1	logic_id=113		FwdLogicScript	2014-05-11 05:05:33-04
4159	38	85	1	logic_id=114		FwdLogicScript	2014-05-11 05:05:34-04
4160	38	86	1	logic_id=117		FwdLogicScript	2014-05-11 05:05:35-04
4161	38	91	1	logic_id=135		FwdLogicScript	2014-05-11 05:05:39-04
4162	38	60	1	logic_id=137		FwdLogicScript	2014-05-11 05:05:40-04
4163	38	58	1	logic_id=138		FwdLogicScript	2014-05-11 05:05:40-04
4164	38	59	1	logic_id=139		FwdLogicScript	2014-05-11 05:05:41-04
4165	38	73	1	logic_id=140		FwdLogicScript	2014-05-11 05:05:41-04
4166	38	74	1	logic_id=141		FwdLogicScript	2014-05-11 05:05:42-04
4167	38	83	1	logic_id=144		FwdLogicScript	2014-05-11 05:05:43-04
4168	38	104	1	logic_id=154		FwdLogicScript	2014-05-11 05:05:50-04
4169	38	105	1	logic_id=164		FwdLogicScript	2014-05-11 05:05:54-04
4170	38	110	1	logic_id=165		FwdLogicScript	2014-05-11 05:05:55-04
4171	38	111	1	logic_id=166		FwdLogicScript	2014-05-11 05:05:55-04
4172	38	75	1	logic_id=167		FwdLogicScript	2014-05-11 05:05:56-04
4173	38	76	1	logic_id=168		FwdLogicScript	2014-05-11 05:05:57-04
4174	38	108	1	logic_id=171		FwdLogicScript	2014-05-11 05:05:59-04
4175	38	77	1	logic_id=176		FwdLogicScript	2014-05-11 05:06:02-04
4176	38	61	1	logic_id=181		FwdLogicScript	2014-05-11 05:06:03-04
4177	38	101	1	logic_id=182		FwdLogicScript	2014-05-11 05:06:04-04
4178	38	133	1	logic_id=443		FwdLogicScript	2014-05-11 05:06:05-04
4179	38	117	1	logic_id=188		FwdLogicScript	2014-05-11 05:06:06-04
4180	38	132	1	logic_id=444		FwdLogicScript	2014-05-11 05:06:06-04
4181	38	134	1	logic_id=446		FwdLogicScript	2014-05-11 05:06:08-04
4182	38	115	1	logic_id=192		FwdLogicScript	2014-05-11 05:06:08-04
4183	38	80	1	logic_id=460		FwdLogicScript	2014-05-11 05:06:12-04
4184	38	78	1	logic_id=463		FwdLogicScript	2014-05-11 05:06:14-04
4185	38	119	1	logic_id=209		FwdLogicScript	2014-05-11 05:06:15-04
4186	38	118	1	logic_id=210		FwdLogicScript	2014-05-11 05:06:16-04
4187	38	53	1	logic_id=321		FwdLogicScript	2014-05-11 05:07:11-04
4188	38	52	1	logic_id=329		FwdLogicScript	2014-05-11 05:07:17-04
4189	38	70	1	logic_id=340		FwdLogicScript	2014-05-11 05:07:23-04
4190	38	127	1	logic_id=380		FwdLogicScript	2014-05-11 05:07:47-04
4191	38	131	1	logic_id=413		FwdLogicScript	2014-05-11 05:07:49-04
4192	38	71	1	logic_id=7		FwdLogicScript	2014-05-11 05:08:50-04
4193	38	116	1	logic_id=263		FwdLogicScript	2014-05-11 05:08:51-04
4194	38	72	1	logic_id=8		FwdLogicScript	2014-05-11 05:08:51-04
4195	38	84	1	logic_id=60		FwdLogicScript	2014-05-11 05:09:06-04
4196	38	66	1	logic_id=61		FwdLogicScript	2014-05-11 05:09:06-04
4197	38	65	1	logic_id=62		FwdLogicScript	2014-05-11 05:09:07-04
4198	38	62	1	logic_id=92		FwdLogicScript	2014-05-11 05:09:15-04
4199	38	87	1	logic_id=94		FwdLogicScript	2014-05-11 05:09:16-04
4200	38	64	1	logic_id=116		FwdLogicScript	2014-05-11 05:09:23-04
4201	38	69	1	logic_id=150		FwdLogicScript	2014-05-11 05:09:35-04
4202	38	109	1	logic_id=160		FwdLogicScript	2014-05-11 05:09:39-04
4203	38	114	1	logic_id=205		FwdLogicScript	2014-05-11 05:09:58-04
4204	38	40	0	logic_id=500		BkwdLogicScript	2014-05-11 05:12:40-04
4237	38	126	0	right uniform dimension is greater than 1		rschwiebert	2014-05-11 14:36:15-04
4238	38	63	0	For the endomorphism used in the construction to be nonsurjective, the field used must be infinite.		rschwiebert	2014-05-11 14:38:49-04
4239	38	6	0	logic_id=20		BkwdLogicScript	2014-05-11 15:20:31-04
4240	38	33	0	logic_id=314		BkwdLogicScript	2014-05-11 15:20:36-04
4241	38	9	0	logic_id=330		BkwdLogicScript	2014-05-11 15:20:37-04
4242	38	12	0	logic_id=362		BkwdLogicScript	2014-05-11 15:20:37-04
4243	38	18	0	logic_id=392		BkwdLogicScript	2014-05-11 15:20:38-04
4244	38	24	0	logic_id=408		BkwdLogicScript	2014-05-11 15:20:39-04
4245	38	25	0	logic_id=410		BkwdLogicScript	2014-05-11 15:20:39-04
4246	38	11	0	logic_id=428		BkwdLogicScript	2014-05-11 15:20:39-04
4247	38	97	0	logic_id=503		BkwdLogicScript	2014-05-11 15:20:41-04
4248	38	98	0	logic_id=505		BkwdLogicScript	2014-05-11 15:20:41-04
4249	38	96	0	logic_id=510		BkwdLogicScript	2014-05-11 15:20:41-04
4250	38	22	0	logic_id=518		BkwdLogicScript	2014-05-11 15:20:41-04
4251	38	8	0	logic_id=36		BkwdLogicScript	2014-05-11 15:20:50-04
4252	38	37	0	logic_id=49		BkwdLogicScript	2014-05-11 15:20:50-04
4253	38	36	0	logic_id=51		BkwdLogicScript	2014-05-11 15:20:50-04
4254	38	14	0	logic_id=53		BkwdLogicScript	2014-05-11 15:20:50-04
4255	38	15	0	logic_id=56		BkwdLogicScript	2014-05-11 15:20:50-04
4256	38	39	0	logic_id=72		BkwdLogicScript	2014-05-11 15:20:51-04
4257	38	38	0	logic_id=73		BkwdLogicScript	2014-05-11 15:20:51-04
4258	38	16	0	logic_id=104		BkwdLogicScript	2014-05-11 15:20:51-04
4259	38	23	0	logic_id=120		BkwdLogicScript	2014-05-11 15:20:52-04
4260	38	95	0	logic_id=213		BkwdLogicScript	2014-05-11 15:20:53-04
4261	38	94	0	logic_id=214		BkwdLogicScript	2014-05-11 15:20:53-04
4262	38	17	0	logic_id=216		BkwdLogicScript	2014-05-11 15:20:53-04
4263	38	20	0	logic_id=262		BkwdLogicScript	2014-05-11 15:20:55-04
4264	38	10	0	logic_id=351		BkwdLogicScript	2014-05-11 15:20:57-04
4265	38	7	0	logic_id=504		BkwdLogicScript	2014-05-11 15:21:00-04
4266	38	135	0	logic_id=19		BkwdLogicScript	2014-05-11 15:21:10-04
4267	38	13	0	logic_id=26		BkwdLogicScript	2014-05-11 15:21:10-04
4268	38	41	1	The ring has exactly three left ideals.		rschwiebert	2014-05-11 15:46:25-04
4269	38	21	1	logic_id=43		FwdLogicScript	2014-05-11 15:46:54-04
4270	38	43	1	logic_id=44		FwdLogicScript	2014-05-11 15:46:54-04
4271	38	125	1	logic_id=434		FwdLogicScript	2014-05-11 15:47:40-04
4272	38	19	1	logic_id=275		FwdLogicScript	2014-05-11 15:48:17-04
4273	38	34	0	The element x is a nonzero singular element		rschwiebert	2014-05-11 16:05:19-04
4274	38	35	0	The element x is a nonzero singular element		rschwiebert	2014-05-11 16:05:33-04
4275	38	31	0	logic_id=99		BkwdLogicScript	2014-05-11 18:32:19-04
4276	38	30	0	logic_id=100		BkwdLogicScript	2014-05-11 18:32:19-04
4277	38	1	0	logic_id=251		BkwdLogicScript	2014-05-11 18:32:23-04
4278	38	32	0	logic_id=66		BkwdLogicScript	2014-05-11 18:32:38-04
4279	38	29	0	logic_id=95		BkwdLogicScript	2014-05-11 18:32:39-04
4280	38	28	0	logic_id=97		BkwdLogicScript	2014-05-11 18:32:39-04
4281	38	27	0	logic_id=64		BkwdLogicScript	2014-05-11 18:33:05-04
4282	38	26	0	logic_id=65		BkwdLogicScript	2014-05-11 18:33:05-04
4283	38	82	1	Easy to verify that the left dual condition holds for the three left ideals.		rschwiebert	2014-05-11 18:43:56-04
4284	38	81	0	Given a simple right ideal T, r(l(T))=xR, so the right dual condition is not satisfied.		rschwiebert	2014-05-11 18:45:04-04
4285	38	46	0	logic_id=132		BkwdLogicScript	2014-05-11 18:50:05-04
4286	38	50	0	logic_id=310		BkwdLogicScript	2014-05-11 18:50:09-04
4287	38	120	0	logic_id=335		BkwdLogicScript	2014-05-11 18:50:10-04
4288	38	48	0	logic_id=511		BkwdLogicScript	2014-05-11 18:50:15-04
4289	38	45	0	logic_id=110		BkwdLogicScript	2014-05-11 18:50:18-04
4290	38	51	0	logic_id=265		BkwdLogicScript	2014-05-11 18:50:21-04
4291	38	49	0	logic_id=328		BkwdLogicScript	2014-05-11 18:50:23-04
4292	38	121	0	logic_id=346		BkwdLogicScript	2014-05-11 18:50:24-04
4293	38	44	0	logic_id=74		BkwdLogicScript	2014-05-11 20:40:29-04
4294	38	47	0	logic_id=125		BkwdLogicScript	2014-05-11 20:40:31-04
4295	38	124	0	Let s(a) and s(b) be linearly independent. Then s(a)R+s(b)R, s(a)R,s(b)R, s(a+b)R, (0) form the diamond lattice in the set of right ideals.		rschwiebert	2014-05-12 03:31:49-04
4296	38	42	0	logic_id=521		BkwdLogicScript	2014-05-12 03:49:16-04
4297	39	29	1		T.Y.Lam Lectures on modules and rings p 46-47	rschwiebert	2014-05-13 02:17:33-04
4298	39	28	0		T.Y.Lam Lectures on modules and rings p 46-47	rschwiebert	2014-05-13 02:17:50-04
4299	40	73	1		T.Y.Lam Lectures on modules and rings p 139	rschwiebert	2014-05-13 02:22:38-04
4300	40	74	0		T.Y.Lam Lectures on modules and rings p 139	rschwiebert	2014-05-13 02:22:51-04
4301	40	2	1		T.Y.Lam Lectures on modules and rings p 139	rschwiebert	2014-05-13 02:23:37-04
4302	40	40	1		T.Y.Lam Lectures on modules and rings p 139	rschwiebert	2014-05-13 02:24:01-04
4303	40	112	1		T.Y.Lam Lectures on modules and rings p 139	rschwiebert	2014-05-13 02:24:38-04
4304	40	55	1		T.Y.Lam Lectures on modules and rings p 139	rschwiebert	2014-05-13 02:26:26-04
4305	40	79	1	logic_id=0		FwdLogicScript	2014-05-13 02:53:19-04
4306	40	4	1	logic_id=9		FwdLogicScript	2014-05-13 02:53:22-04
4307	40	54	1	logic_id=10		FwdLogicScript	2014-05-13 02:53:23-04
4308	40	20	1	logic_id=46		FwdLogicScript	2014-05-13 02:53:33-04
4309	40	42	1	logic_id=47		FwdLogicScript	2014-05-13 02:53:33-04
4310	40	57	1	logic_id=76		FwdLogicScript	2014-05-13 02:53:42-04
4311	40	107	1	logic_id=78		FwdLogicScript	2014-05-13 02:53:43-04
4312	40	106	1	logic_id=79		FwdLogicScript	2014-05-13 02:53:43-04
4313	40	56	1	logic_id=111		FwdLogicScript	2014-05-13 02:53:52-04
4314	40	88	1	logic_id=112		FwdLogicScript	2014-05-13 02:53:53-04
4315	40	90	1	logic_id=113		FwdLogicScript	2014-05-13 02:53:54-04
4316	40	85	1	logic_id=114		FwdLogicScript	2014-05-13 02:53:54-04
4317	40	86	1	logic_id=117		FwdLogicScript	2014-05-13 02:53:56-04
4318	40	91	1	logic_id=135		FwdLogicScript	2014-05-13 02:54:00-04
4319	40	60	1	logic_id=137		FwdLogicScript	2014-05-13 02:54:01-04
4320	40	58	1	logic_id=138		FwdLogicScript	2014-05-13 02:54:02-04
4321	40	59	1	logic_id=139		FwdLogicScript	2014-05-13 02:54:02-04
4322	40	83	1	logic_id=144		FwdLogicScript	2014-05-13 02:54:05-04
4323	40	104	1	logic_id=154		FwdLogicScript	2014-05-13 02:54:12-04
4324	40	105	1	logic_id=164		FwdLogicScript	2014-05-13 02:54:16-04
4325	40	110	1	logic_id=165		FwdLogicScript	2014-05-13 02:54:17-04
4326	40	111	1	logic_id=166		FwdLogicScript	2014-05-13 02:54:18-04
4327	40	75	1	logic_id=167		FwdLogicScript	2014-05-13 02:54:19-04
4328	40	108	1	logic_id=172		FwdLogicScript	2014-05-13 02:54:23-04
4329	40	124	1	logic_id=433		FwdLogicScript	2014-05-13 02:54:24-04
4330	40	76	1	logic_id=180		FwdLogicScript	2014-05-13 02:54:26-04
4331	40	61	1	logic_id=181		FwdLogicScript	2014-05-13 02:54:27-04
4332	40	101	1	logic_id=182		FwdLogicScript	2014-05-13 02:54:27-04
4333	40	116	1	logic_id=187		FwdLogicScript	2014-05-13 02:54:28-04
4334	40	133	1	logic_id=443		FwdLogicScript	2014-05-13 02:54:29-04
4335	40	132	1	logic_id=444		FwdLogicScript	2014-05-13 02:54:30-04
4336	40	134	1	logic_id=446		FwdLogicScript	2014-05-13 02:54:31-04
4337	40	114	1	logic_id=191		FwdLogicScript	2014-05-13 02:54:31-04
4338	40	78	1	logic_id=463		FwdLogicScript	2014-05-13 02:54:38-04
4339	40	119	1	logic_id=209		FwdLogicScript	2014-05-13 02:54:39-04
4340	40	118	1	logic_id=210		FwdLogicScript	2014-05-13 02:54:40-04
4341	40	126	1	logic_id=226		FwdLogicScript	2014-05-13 02:54:47-04
4342	40	18	1	logic_id=262		FwdLogicScript	2014-05-13 02:54:57-04
4343	40	53	1	logic_id=321		FwdLogicScript	2014-05-13 02:55:38-04
4344	40	52	1	logic_id=329		FwdLogicScript	2014-05-13 02:55:44-04
4345	40	69	1	logic_id=339		FwdLogicScript	2014-05-13 02:55:50-04
4346	40	131	1	logic_id=413		FwdLogicScript	2014-05-13 02:56:19-04
4347	39	31	1	logic_id=95		FwdLogicScript	2014-05-13 02:57:50-04
4348	39	74	1	logic_id=96		FwdLogicScript	2014-05-13 02:57:51-04
4349	39	35	1	logic_id=99		FwdLogicScript	2014-05-13 02:57:52-04
4350	40	71	1	logic_id=7		FwdLogicScript	2014-05-13 03:01:44-04
4351	40	117	1	logic_id=276		FwdLogicScript	2014-05-13 03:01:49-04
4352	40	84	1	logic_id=60		FwdLogicScript	2014-05-13 03:02:00-04
4353	40	66	1	logic_id=61		FwdLogicScript	2014-05-13 03:02:00-04
4354	40	65	1	logic_id=62		FwdLogicScript	2014-05-13 03:02:00-04
4355	40	62	1	logic_id=92		FwdLogicScript	2014-05-13 03:02:09-04
4356	40	87	1	logic_id=94		FwdLogicScript	2014-05-13 03:02:10-04
4357	40	64	1	logic_id=116		FwdLogicScript	2014-05-13 03:02:17-04
4358	40	77	1	logic_id=151		FwdLogicScript	2014-05-13 03:02:31-04
4359	40	109	1	logic_id=160		FwdLogicScript	2014-05-13 03:02:35-04
4360	40	80	1	logic_id=460		FwdLogicScript	2014-05-13 03:02:58-04
4361	40	29	0	logic_id=96		BkwdLogicScript	2014-05-13 03:18:35-04
4362	40	5	0	logic_id=141		BkwdLogicScript	2014-05-13 03:18:35-04
4363	40	96	0	logic_id=220		BkwdLogicScript	2014-05-13 03:18:36-04
4364	40	22	0	logic_id=426		BkwdLogicScript	2014-05-13 03:18:39-04
4365	40	23	0	logic_id=427		BkwdLogicScript	2014-05-13 03:18:39-04
4366	40	28	0	logic_id=449		BkwdLogicScript	2014-05-13 03:18:39-04
4367	40	21	0	logic_id=515		BkwdLogicScript	2014-05-13 03:18:41-04
4368	39	26	0	logic_id=65		BkwdLogicScript	2014-05-13 03:18:42-04
4369	39	12	0	logic_id=83		BkwdLogicScript	2014-05-13 03:18:42-04
4370	39	95	0	logic_id=217		BkwdLogicScript	2014-05-13 03:18:44-04
4371	39	96	0	logic_id=219		BkwdLogicScript	2014-05-13 03:18:44-04
4372	39	51	0	logic_id=287		BkwdLogicScript	2014-05-13 03:18:45-04
4373	39	22	0	logic_id=426		BkwdLogicScript	2014-05-13 03:18:47-04
4374	39	23	0	logic_id=427		BkwdLogicScript	2014-05-13 03:18:48-04
4375	39	69	0	logic_id=450		BkwdLogicScript	2014-05-13 03:18:48-04
4376	39	70	0	logic_id=452		BkwdLogicScript	2014-05-13 03:18:48-04
4377	40	3	0	logic_id=11		BkwdLogicScript	2014-05-13 03:19:24-04
4378	40	41	0	logic_id=43		BkwdLogicScript	2014-05-13 03:19:25-04
4379	40	27	0	logic_id=64		BkwdLogicScript	2014-05-13 03:19:25-04
4380	40	26	0	logic_id=65		BkwdLogicScript	2014-05-13 03:19:25-04
4381	40	19	0	logic_id=68		BkwdLogicScript	2014-05-13 03:19:25-04
4382	40	12	0	logic_id=82		BkwdLogicScript	2014-05-13 03:19:26-04
4383	40	17	0	logic_id=101		BkwdLogicScript	2014-05-13 03:19:26-04
4384	40	16	0	logic_id=104		BkwdLogicScript	2014-05-13 03:19:26-04
4385	40	45	0	logic_id=107		BkwdLogicScript	2014-05-13 03:19:26-04
4386	40	95	0	logic_id=213		BkwdLogicScript	2014-05-13 03:19:28-04
4387	40	94	0	logic_id=214		BkwdLogicScript	2014-05-13 03:19:28-04
4388	40	1	0	logic_id=249		BkwdLogicScript	2014-05-13 03:19:29-04
4389	40	50	0	logic_id=264		BkwdLogicScript	2014-05-13 03:19:30-04
4390	40	51	0	logic_id=265		BkwdLogicScript	2014-05-13 03:19:30-04
4391	40	102	0	logic_id=267		BkwdLogicScript	2014-05-13 03:19:30-04
4392	40	49	0	logic_id=328		BkwdLogicScript	2014-05-13 03:19:32-04
4393	40	9	0	logic_id=332		BkwdLogicScript	2014-05-13 03:19:32-04
4394	40	120	0	logic_id=344		BkwdLogicScript	2014-05-13 03:19:32-04
4395	40	121	0	logic_id=346		BkwdLogicScript	2014-05-13 03:19:32-04
4396	40	11	0	logic_id=428		BkwdLogicScript	2014-05-13 03:19:34-04
4397	40	63	0	logic_id=499		BkwdLogicScript	2014-05-13 03:19:36-04
4398	40	97	0	logic_id=503		BkwdLogicScript	2014-05-13 03:19:36-04
4399	40	98	0	logic_id=505		BkwdLogicScript	2014-05-13 03:19:36-04
4400	40	33	0	logic_id=506		BkwdLogicScript	2014-05-13 03:19:36-04
4401	40	48	0	logic_id=511		BkwdLogicScript	2014-05-13 03:19:37-04
4402	40	43	0	logic_id=520		BkwdLogicScript	2014-05-13 03:19:37-04
4403	39	8	0	logic_id=33		BkwdLogicScript	2014-05-13 03:19:38-04
4404	39	15	0	logic_id=56		BkwdLogicScript	2014-05-13 03:19:38-04
4405	39	17	0	logic_id=101		BkwdLogicScript	2014-05-13 03:19:39-04
4406	39	16	0	logic_id=104		BkwdLogicScript	2014-05-13 03:19:39-04
4407	39	47	0	logic_id=126		BkwdLogicScript	2014-05-13 03:19:39-04
4408	39	72	0	logic_id=148		BkwdLogicScript	2014-05-13 03:19:40-04
4409	39	71	0	logic_id=150		BkwdLogicScript	2014-05-13 03:19:40-04
4410	39	94	0	logic_id=214		BkwdLogicScript	2014-05-13 03:19:41-04
4411	39	126	0	logic_id=223		BkwdLogicScript	2014-05-13 03:19:41-04
4412	39	127	0	logic_id=225		BkwdLogicScript	2014-05-13 03:19:41-04
4413	39	40	0	logic_id=226		BkwdLogicScript	2014-05-13 03:19:41-04
4414	39	41	0	logic_id=227		BkwdLogicScript	2014-05-13 03:19:41-04
4415	39	24	0	logic_id=409		BkwdLogicScript	2014-05-13 03:19:45-04
4416	39	25	0	logic_id=411		BkwdLogicScript	2014-05-13 03:19:45-04
4417	40	6	0	logic_id=21		BkwdLogicScript	2014-05-13 03:19:59-04
4418	40	8	0	logic_id=32		BkwdLogicScript	2014-05-13 03:19:59-04
4419	40	37	0	logic_id=49		BkwdLogicScript	2014-05-13 03:20:00-04
4420	40	36	0	logic_id=51		BkwdLogicScript	2014-05-13 03:20:00-04
4421	40	14	0	logic_id=53		BkwdLogicScript	2014-05-13 03:20:00-04
4422	40	15	0	logic_id=56		BkwdLogicScript	2014-05-13 03:20:00-04
4423	40	39	0	logic_id=72		BkwdLogicScript	2014-05-13 03:20:00-04
4424	40	38	0	logic_id=73		BkwdLogicScript	2014-05-13 03:20:00-04
4425	40	44	0	logic_id=74		BkwdLogicScript	2014-05-13 03:20:01-04
4426	40	47	0	logic_id=125		BkwdLogicScript	2014-05-13 03:20:01-04
4427	40	46	0	logic_id=130		BkwdLogicScript	2014-05-13 03:20:01-04
4428	40	10	0	logic_id=351		BkwdLogicScript	2014-05-13 03:20:07-04
4429	40	34	0	logic_id=364		BkwdLogicScript	2014-05-13 03:20:07-04
4430	40	24	0	logic_id=408		BkwdLogicScript	2014-05-13 03:20:08-04
4431	40	25	0	logic_id=410		BkwdLogicScript	2014-05-13 03:20:09-04
4432	40	7	0	logic_id=504		BkwdLogicScript	2014-05-13 03:20:11-04
4433	39	4	0	logic_id=7		BkwdLogicScript	2014-05-13 03:20:12-04
4434	39	5	0	logic_id=8		BkwdLogicScript	2014-05-13 03:20:12-04
4435	39	2	0	logic_id=9		BkwdLogicScript	2014-05-13 03:20:12-04
4436	39	3	0	logic_id=11		BkwdLogicScript	2014-05-13 03:20:12-04
4437	39	135	0	logic_id=19		BkwdLogicScript	2014-05-13 03:20:12-04
4438	39	6	0	logic_id=20		BkwdLogicScript	2014-05-13 03:20:12-04
4439	39	13	0	logic_id=27		BkwdLogicScript	2014-05-13 03:20:12-04
4440	39	19	0	logic_id=69		BkwdLogicScript	2014-05-13 03:20:13-04
4441	39	18	0	logic_id=71		BkwdLogicScript	2014-05-13 03:20:13-04
4442	39	45	0	logic_id=107		BkwdLogicScript	2014-05-13 03:20:14-04
4443	39	63	0	logic_id=498		BkwdLogicScript	2014-05-13 03:20:23-04
4444	40	135	0	logic_id=19		BkwdLogicScript	2014-05-13 03:21:53-04
4445	40	13	0	logic_id=26		BkwdLogicScript	2014-05-13 03:21:54-04
4446	40	30	0	logic_id=100		BkwdLogicScript	2014-05-13 03:21:55-04
4447	39	44	0	logic_id=74		BkwdLogicScript	2014-05-13 03:22:08-04
4448	40	32	0	logic_id=67		BkwdLogicScript	2014-05-13 03:22:42-04
4449	40	67	1	Has exactly three right ideals, and they must all be ideals.		rschwiebert	2014-05-13 03:47:58-04
4450	40	128	1	logic_id=403		FwdLogicScript	2014-05-13 03:48:58-04
4451	39	88	1	T/J(T) is isomorphic to RxS, which is von Neumann regular, and J(T) is nilpotent.		rschwiebert	2014-05-13 04:06:50-04
4452	39	56	0	T/J(T) is isomorphic to RxS, which is von Neumann regular but not semisimple		rschwiebert	2014-05-13 04:07:34-04
4453	39	105	1	The radical [[0R],[0,0]] has square zero.		rschwiebert	2014-05-13 04:09:59-04
4454	39	85	1	logic_id=136		FwdLogicScript	2014-05-13 04:11:15-04
4455	39	60	1	logic_id=137		FwdLogicScript	2014-05-13 04:11:15-04
4456	39	111	1	logic_id=162		FwdLogicScript	2014-05-13 04:11:27-04
4457	39	110	1	logic_id=163		FwdLogicScript	2014-05-13 04:11:28-04
4458	39	134	1	logic_id=447		FwdLogicScript	2014-05-13 04:11:42-04
4459	39	86	1	logic_id=117		FwdLogicScript	2014-05-13 04:15:07-04
4460	39	109	1	logic_id=160		FwdLogicScript	2014-05-13 04:15:25-04
4461	39	87	1	logic_id=363		FwdLogicScript	2014-05-13 04:17:19-04
4462	39	57	0	logic_id=111		BkwdLogicScript	2014-05-13 04:44:30-04
4463	39	46	0	logic_id=134		BkwdLogicScript	2014-05-13 04:44:31-04
4464	39	58	0	logic_id=145		BkwdLogicScript	2014-05-13 04:44:31-04
4465	39	59	0	logic_id=147		BkwdLogicScript	2014-05-13 04:44:31-04
4466	39	9	0	logic_id=332		BkwdLogicScript	2014-05-13 04:44:36-04
4467	39	11	0	logic_id=428		BkwdLogicScript	2014-05-13 04:44:39-04
4468	39	133	0	logic_id=445		BkwdLogicScript	2014-05-13 04:44:40-04
4469	39	97	0	logic_id=503		BkwdLogicScript	2014-05-13 04:44:42-04
4470	39	98	0	logic_id=505		BkwdLogicScript	2014-05-13 04:44:42-04
4471	39	37	0	logic_id=49		BkwdLogicScript	2014-05-13 04:50:09-04
4472	39	36	0	logic_id=51		BkwdLogicScript	2014-05-13 04:50:09-04
4473	39	14	0	logic_id=53		BkwdLogicScript	2014-05-13 04:50:09-04
4474	39	39	0	logic_id=72		BkwdLogicScript	2014-05-13 04:50:10-04
4475	39	38	0	logic_id=73		BkwdLogicScript	2014-05-13 04:50:10-04
4476	39	43	0	logic_id=75		BkwdLogicScript	2014-05-13 04:50:10-04
4477	39	42	0	logic_id=76		BkwdLogicScript	2014-05-13 04:50:10-04
4478	39	55	0	logic_id=77		BkwdLogicScript	2014-05-13 04:50:10-04
4479	39	54	0	logic_id=138		BkwdLogicScript	2014-05-13 04:50:12-04
4480	39	1	0	logic_id=240		BkwdLogicScript	2014-05-13 04:50:14-04
4481	39	104	0	logic_id=357		BkwdLogicScript	2014-05-13 04:50:19-04
4482	39	125	0	logic_id=365		BkwdLogicScript	2014-05-13 04:50:20-04
4483	39	10	0	logic_id=422		BkwdLogicScript	2014-05-13 04:50:22-04
4484	39	33	0	logic_id=423		BkwdLogicScript	2014-05-13 04:50:22-04
4485	39	131	0	logic_id=441		BkwdLogicScript	2014-05-13 04:50:23-04
4486	39	7	0	logic_id=504		BkwdLogicScript	2014-05-13 04:50:25-04
4487	16	52	0		T.Y. Lam Lectuers on modules and rings p 281	rschwiebert	2014-05-13 13:25:04-04
4488	16	53	0		T.Y. Lam Lectuers on modules and rings p 281	rschwiebert	2014-05-13 13:25:31-04
4489	13	53	0	Maximal left ideal consisting of matrices with zero bottom row has right annihilator zero.		rschwiebert	2014-05-13 13:50:18-04
4490	13	52	0	Maximal right ideal consisting of matrices with zero left column has left annihilator zero.		rschwiebert	2014-05-13 13:51:12-04
4491	14	52	0	Maximal right ideal consisting of matrices with zero left column has left annihilator zero.		rschwiebert	2014-05-13 14:20:37-04
4492	14	53	0	Maximal left ideal consisting of matrices with zero bottom row has right annihilator zero.		rschwiebert	2014-05-13 14:21:19-04
4493	19	53	0	Maximal left ideal consisting of matrices with zero bottom row has right annihilator zero.		rschwiebert	2014-05-13 14:28:47-04
4494	19	52	0	Maximal right ideal consisting of matrices [[(2),Q],[0,Q]] has left annihilator zero.		rschwiebert	2014-05-13 14:32:15-04
4495	20	52	0	Maximal right ideal consisting of matrices with zero left column has left annihilator zero.		rschwiebert	2014-05-13 14:35:13-04
4496	20	53	0	Maximal left ideal consisting of matrices with zero bottom row has right annihilator zero.		rschwiebert	2014-05-13 14:35:43-04
4497	30	53	0	Maximal left ideal consisting of matrices with zero bottom row has right annihilator zero.		rschwiebert	2014-05-13 14:39:08-04
4498	30	52	0	Maximal right ideal consisting of matrices [[(2),Z/(2)],[0,Z/(2)]] has left annihilator zero.		rschwiebert	2014-05-13 14:39:58-04
4499	41	53	0		T.Y. Lam Lectures on modules and rings p 281-282	rschwiebert	2014-05-15 03:50:14-04
4500	41	52	1		T.Y. Lam Lectures on modules and rings p 281-282	rschwiebert	2014-05-15 03:50:47-04
4501	41	55	0	The ring modulo its radical is isomorphic to kxk		rschwiebert	2014-05-15 03:51:35-04
4502	41	3	1	The ring is a finite dimensional module over k		rschwiebert	2014-05-15 03:52:49-04
4503	41	2	1	The ring is a finite dimensional module over k		rschwiebert	2014-05-15 03:53:07-04
4504	29	103	0		T.Y. Lam Exercises in rings and modules p 212-213	rschwiebert	2014-05-15 04:35:03-04
4505	29	102	0		T.Y. Lam Exercises in rings and modules p 212-213	rschwiebert	2014-05-15 04:35:32-04
4506	42	52	1		T.Y. Lam Exercises in rings and modules p 211	rschwiebert	2014-05-15 04:59:46-04
4507	42	53	0		T.Y. Lam Exercises in rings and modules p 211	rschwiebert	2014-05-15 05:00:00-04
4508	42	55	1		T.Y. Lam Exercises in rings and modules p 211	rschwiebert	2014-05-15 05:00:23-04
4509	41	79	1	logic_id=0		FwdLogicScript	2014-05-15 05:00:53-04
4510	41	116	1	logic_id=263		FwdLogicScript	2014-05-15 05:00:59-04
4511	42	116	1	logic_id=263		FwdLogicScript	2014-05-15 05:00:59-04
4512	41	4	1	logic_id=9		FwdLogicScript	2014-05-15 05:01:01-04
4513	41	54	1	logic_id=10		FwdLogicScript	2014-05-15 05:01:02-04
4514	41	5	1	logic_id=11		FwdLogicScript	2014-05-15 05:01:02-04
4515	42	57	1	logic_id=77		FwdLogicScript	2014-05-15 05:01:34-04
4516	42	107	1	logic_id=78		FwdLogicScript	2014-05-15 05:01:35-04
4517	42	106	1	logic_id=79		FwdLogicScript	2014-05-15 05:01:35-04
4518	42	56	1	logic_id=111		FwdLogicScript	2014-05-15 05:01:51-04
4519	42	88	1	logic_id=112		FwdLogicScript	2014-05-15 05:01:52-04
4520	42	90	1	logic_id=113		FwdLogicScript	2014-05-15 05:01:53-04
4521	42	85	1	logic_id=114		FwdLogicScript	2014-05-15 05:01:54-04
4522	42	86	1	logic_id=117		FwdLogicScript	2014-05-15 05:01:57-04
4523	42	91	1	logic_id=135		FwdLogicScript	2014-05-15 05:02:04-04
4524	42	60	1	logic_id=137		FwdLogicScript	2014-05-15 05:02:05-04
4525	41	58	1	logic_id=138		FwdLogicScript	2014-05-15 05:02:06-04
4526	41	59	1	logic_id=139		FwdLogicScript	2014-05-15 05:02:06-04
4527	41	73	1	logic_id=140		FwdLogicScript	2014-05-15 05:02:07-04
4528	41	74	1	logic_id=141		FwdLogicScript	2014-05-15 05:02:08-04
4529	41	83	1	logic_id=144		FwdLogicScript	2014-05-15 05:02:09-04
4530	41	57	1	logic_id=145		FwdLogicScript	2014-05-15 05:02:10-04
4531	42	104	1	logic_id=154		FwdLogicScript	2014-05-15 05:02:19-04
4532	41	105	1	logic_id=164		FwdLogicScript	2014-05-15 05:02:26-04
4533	41	110	1	logic_id=165		FwdLogicScript	2014-05-15 05:02:27-04
4534	41	111	1	logic_id=166		FwdLogicScript	2014-05-15 05:02:28-04
4535	41	75	1	logic_id=167		FwdLogicScript	2014-05-15 05:02:29-04
4536	41	76	1	logic_id=168		FwdLogicScript	2014-05-15 05:02:30-04
4537	41	108	1	logic_id=171		FwdLogicScript	2014-05-15 05:02:34-04
4538	41	77	1	logic_id=176		FwdLogicScript	2014-05-15 05:02:38-04
4539	42	108	1	logic_id=435		FwdLogicScript	2014-05-15 05:02:40-04
4540	41	61	1	logic_id=181		FwdLogicScript	2014-05-15 05:02:41-04
4541	42	61	1	logic_id=181		FwdLogicScript	2014-05-15 05:02:41-04
4542	42	101	1	logic_id=182		FwdLogicScript	2014-05-15 05:02:42-04
4543	42	133	1	logic_id=443		FwdLogicScript	2014-05-15 05:02:44-04
4544	42	132	1	logic_id=444		FwdLogicScript	2014-05-15 05:02:45-04
4545	42	134	1	logic_id=446		FwdLogicScript	2014-05-15 05:02:47-04
4546	41	80	1	logic_id=460		FwdLogicScript	2014-05-15 05:02:54-04
4547	41	78	1	logic_id=463		FwdLogicScript	2014-05-15 05:02:58-04
4548	41	119	1	logic_id=209		FwdLogicScript	2014-05-15 05:02:59-04
4549	41	118	1	logic_id=210		FwdLogicScript	2014-05-15 05:03:00-04
4550	23	45	0	logic_id=397		BkwdLogicScript	2014-05-15 05:06:27-04
4551	23	42	0	logic_id=381		BkwdLogicScript	2014-05-15 05:06:56-04
4552	20	1	0	logic_id=438		BkwdLogicScript	2014-05-15 05:07:53-04
4553	41	1	0	logic_id=437		BkwdLogicScript	2014-05-15 05:07:55-04
4554	13	55	0	logic_id=329		BkwdLogicScript	2014-05-15 05:08:58-04
4555	14	55	0	logic_id=329		BkwdLogicScript	2014-05-15 05:08:59-04
4556	16	55	0	logic_id=329		BkwdLogicScript	2014-05-15 05:08:59-04
4557	20	55	0	logic_id=329		BkwdLogicScript	2014-05-15 05:08:59-04
4558	23	49	0	logic_id=328		BkwdLogicScript	2014-05-15 05:09:00-04
4559	42	54	0	logic_id=321		BkwdLogicScript	2014-05-15 05:09:09-04
4560	23	48	0	logic_id=320		BkwdLogicScript	2014-05-15 05:09:09-04
4561	23	50	0	logic_id=278		BkwdLogicScript	2014-05-15 05:09:54-04
4562	23	51	0	logic_id=277		BkwdLogicScript	2014-05-15 05:09:56-04
4563	13	104	0	logic_id=521		BkwdLogicScript	2014-05-15 05:10:06-04
4564	14	104	0	logic_id=521		BkwdLogicScript	2014-05-15 05:10:06-04
4565	16	104	0	logic_id=521		BkwdLogicScript	2014-05-15 05:10:06-04
4566	23	43	0	logic_id=520		BkwdLogicScript	2014-05-15 05:10:09-04
4567	42	105	0	logic_id=258		BkwdLogicScript	2014-05-15 05:10:20-04
4568	13	127	0	logic_id=224		BkwdLogicScript	2014-05-15 05:10:34-04
4569	14	127	0	logic_id=224		BkwdLogicScript	2014-05-15 05:10:35-04
4570	16	127	0	logic_id=224		BkwdLogicScript	2014-05-15 05:10:35-04
4571	13	126	0	logic_id=222		BkwdLogicScript	2014-05-15 05:10:36-04
4572	14	126	0	logic_id=222		BkwdLogicScript	2014-05-15 05:10:36-04
4573	16	126	0	logic_id=222		BkwdLogicScript	2014-05-15 05:10:36-04
4574	42	9	0	logic_id=221		BkwdLogicScript	2014-05-15 05:10:38-04
4575	13	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:54-04
4576	14	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:54-04
4577	16	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:54-04
4578	20	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:54-04
4579	30	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:55-04
4580	41	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:55-04
4581	42	131	0	logic_id=456		BkwdLogicScript	2014-05-15 05:10:55-04
4582	13	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:01-04
4583	14	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:01-04
4584	16	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:01-04
4585	19	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:01-04
4586	20	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:01-04
4587	30	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:01-04
4588	41	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:02-04
4589	42	121	0	logic_id=194		BkwdLogicScript	2014-05-15 05:11:02-04
4590	13	120	0	logic_id=193		BkwdLogicScript	2014-05-15 05:11:02-04
4591	14	120	0	logic_id=193		BkwdLogicScript	2014-05-15 05:11:02-04
4592	16	120	0	logic_id=193		BkwdLogicScript	2014-05-15 05:11:02-04
4593	19	120	0	logic_id=193		BkwdLogicScript	2014-05-15 05:11:02-04
4594	20	120	0	logic_id=193		BkwdLogicScript	2014-05-15 05:11:02-04
4595	30	120	0	logic_id=193		BkwdLogicScript	2014-05-15 05:11:03-04
4596	42	12	0	logic_id=448		BkwdLogicScript	2014-05-15 05:11:04-04
4597	41	135	0	logic_id=440		BkwdLogicScript	2014-05-15 05:11:13-04
4598	42	135	0	logic_id=440		BkwdLogicScript	2014-05-15 05:11:13-04
4599	13	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:48-04
4600	14	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:48-04
4601	16	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:48-04
4602	19	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:48-04
4603	20	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:48-04
4604	30	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:48-04
4605	41	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:49-04
4606	42	82	0	logic_id=143		BkwdLogicScript	2014-05-15 05:11:49-04
4607	13	81	0	logic_id=142		BkwdLogicScript	2014-05-15 05:11:49-04
4608	14	81	0	logic_id=142		BkwdLogicScript	2014-05-15 05:11:49-04
4609	16	81	0	logic_id=142		BkwdLogicScript	2014-05-15 05:11:49-04
4610	19	81	0	logic_id=142		BkwdLogicScript	2014-05-15 05:11:49-04
4611	20	81	0	logic_id=142		BkwdLogicScript	2014-05-15 05:11:49-04
4612	30	81	0	logic_id=142		BkwdLogicScript	2014-05-15 05:11:50-04
4613	41	46	0	logic_id=133		BkwdLogicScript	2014-05-15 05:11:55-04
4614	42	46	0	logic_id=133		BkwdLogicScript	2014-05-15 05:11:55-04
4615	23	46	0	logic_id=131		BkwdLogicScript	2014-05-15 05:11:57-04
4616	41	47	0	logic_id=127		BkwdLogicScript	2014-05-15 05:12:00-04
4617	42	47	0	logic_id=127		BkwdLogicScript	2014-05-15 05:12:00-04
4618	23	47	0	logic_id=126		BkwdLogicScript	2014-05-15 05:12:01-04
4619	41	45	0	logic_id=110		BkwdLogicScript	2014-05-15 05:12:10-04
4620	42	45	0	logic_id=110		BkwdLogicScript	2014-05-15 05:12:10-04
4621	23	44	0	logic_id=74		BkwdLogicScript	2014-05-15 05:12:31-04
4622	41	44	0	logic_id=74		BkwdLogicScript	2014-05-15 05:12:31-04
4623	42	44	0	logic_id=74		BkwdLogicScript	2014-05-15 05:12:31-04
4624	42	38	0	logic_id=73		BkwdLogicScript	2014-05-15 05:12:32-04
4625	42	39	0	logic_id=72		BkwdLogicScript	2014-05-15 05:12:33-04
4626	42	15	0	logic_id=56		BkwdLogicScript	2014-05-15 05:12:42-04
4627	42	36	0	logic_id=51		BkwdLogicScript	2014-05-15 05:12:46-04
4628	42	37	0	logic_id=49		BkwdLogicScript	2014-05-15 05:12:48-04
4629	20	40	0	logic_id=48		BkwdLogicScript	2014-05-15 05:12:48-04
4630	41	40	0	logic_id=48		BkwdLogicScript	2014-05-15 05:12:49-04
4631	41	41	0	logic_id=45		BkwdLogicScript	2014-05-15 05:12:51-04
4632	41	8	0	logic_id=40		BkwdLogicScript	2014-05-15 05:12:55-04
4633	42	8	0	logic_id=40		BkwdLogicScript	2014-05-15 05:12:55-04
4634	42	13	0	logic_id=27		BkwdLogicScript	2014-05-15 05:13:05-04
4635	42	7	0	logic_id=25		BkwdLogicScript	2014-05-15 05:13:07-04
4636	41	6	0	logic_id=21		BkwdLogicScript	2014-05-15 05:13:12-04
4637	42	6	0	logic_id=18		BkwdLogicScript	2014-05-15 05:13:16-04
4638	29	51	0	logic_id=15		BkwdLogicScript	2014-05-15 05:13:19-04
4639	29	50	0	logic_id=13		BkwdLogicScript	2014-05-15 05:13:20-04
4640	42	3	0	logic_id=12		BkwdLogicScript	2014-05-15 05:13:22-04
4641	42	2	0	logic_id=10		BkwdLogicScript	2014-05-15 05:13:23-04
4642	41	71	1	logic_id=7		FwdLogicScript	2014-05-15 13:12:10-04
4643	41	72	1	logic_id=8		FwdLogicScript	2014-05-15 13:12:11-04
4644	41	84	1	logic_id=60		FwdLogicScript	2014-05-15 13:12:38-04
4645	41	66	1	logic_id=61		FwdLogicScript	2014-05-15 13:12:39-04
4646	41	65	1	logic_id=62		FwdLogicScript	2014-05-15 13:12:39-04
4647	41	91	1	logic_id=63		FwdLogicScript	2014-05-15 13:12:40-04
4648	41	62	1	logic_id=92		FwdLogicScript	2014-05-15 13:12:57-04
4649	42	62	1	logic_id=92		FwdLogicScript	2014-05-15 13:12:57-04
4650	41	85	1	logic_id=93		FwdLogicScript	2014-05-15 13:12:58-04
4651	41	87	1	logic_id=94		FwdLogicScript	2014-05-15 13:12:59-04
4652	41	56	1	logic_id=111		FwdLogicScript	2014-05-15 13:13:09-04
4653	41	88	1	logic_id=112		FwdLogicScript	2014-05-15 13:13:10-04
4654	41	90	1	logic_id=113		FwdLogicScript	2014-05-15 13:13:11-04
4655	41	64	1	logic_id=116		FwdLogicScript	2014-05-15 13:13:15-04
4656	42	64	1	logic_id=116		FwdLogicScript	2014-05-15 13:13:15-04
4657	41	86	1	logic_id=117		FwdLogicScript	2014-05-15 13:13:17-04
4658	41	60	1	logic_id=137		FwdLogicScript	2014-05-15 13:13:28-04
4659	41	70	1	logic_id=148		FwdLogicScript	2014-05-15 13:13:43-04
4660	41	69	1	logic_id=150		FwdLogicScript	2014-05-15 13:13:45-04
4661	41	109	1	logic_id=160		FwdLogicScript	2014-05-15 13:13:54-04
4662	41	117	1	logic_id=190		FwdLogicScript	2014-05-15 13:14:19-04
4663	41	134	1	logic_id=446		FwdLogicScript	2014-05-15 13:14:20-04
4664	41	114	1	logic_id=205		FwdLogicScript	2014-05-15 13:14:33-04
4665	41	115	1	logic_id=206		FwdLogicScript	2014-05-15 13:14:37-04
4666	29	48	0	logic_id=511		BkwdLogicScript	2014-05-15 13:33:50-04
4667	41	50	0	logic_id=488		BkwdLogicScript	2014-05-15 13:33:57-04
4668	41	51	0	logic_id=487		BkwdLogicScript	2014-05-15 13:33:59-04
4669	29	49	0	logic_id=512		BkwdLogicScript	2014-05-15 13:34:25-04
4670	41	49	0	logic_id=512		BkwdLogicScript	2014-05-15 13:34:26-04
4671	20	104	0	logic_id=469		BkwdLogicScript	2014-05-15 13:35:10-04
4672	41	104	0	logic_id=469		BkwdLogicScript	2014-05-15 13:35:11-04
4673	41	33	0	logic_id=468		BkwdLogicScript	2014-05-15 13:35:13-04
4674	13	133	0	logic_id=413		BkwdLogicScript	2014-05-15 13:35:39-04
4675	14	133	0	logic_id=413		BkwdLogicScript	2014-05-15 13:35:39-04
4676	16	133	0	logic_id=413		BkwdLogicScript	2014-05-15 13:35:39-04
4677	20	133	0	logic_id=413		BkwdLogicScript	2014-05-15 13:35:39-04
4678	41	133	0	logic_id=413		BkwdLogicScript	2014-05-15 13:35:40-04
4679	13	113	0	logic_id=380		BkwdLogicScript	2014-05-15 13:35:42-04
4680	14	113	0	logic_id=380		BkwdLogicScript	2014-05-15 13:35:42-04
4681	16	113	0	logic_id=380		BkwdLogicScript	2014-05-15 13:35:42-04
4682	13	112	0	logic_id=379		BkwdLogicScript	2014-05-15 13:35:43-04
4683	14	112	0	logic_id=379		BkwdLogicScript	2014-05-15 13:35:43-04
4684	16	112	0	logic_id=379		BkwdLogicScript	2014-05-15 13:35:43-04
4685	42	10	0	logic_id=352		BkwdLogicScript	2014-05-15 13:36:11-04
4686	23	121	0	logic_id=346		BkwdLogicScript	2014-05-15 13:36:18-04
4687	23	120	0	logic_id=344		BkwdLogicScript	2014-05-15 13:36:20-04
4688	42	50	0	logic_id=333		BkwdLogicScript	2014-05-15 13:36:35-04
4689	41	9	0	logic_id=331		BkwdLogicScript	2014-05-15 13:36:38-04
4690	41	11	0	logic_id=325		BkwdLogicScript	2014-05-15 13:36:47-04
4691	41	10	0	logic_id=324		BkwdLogicScript	2014-05-15 13:36:49-04
4692	41	48	0	logic_id=320		BkwdLogicScript	2014-05-15 13:36:54-04
4693	42	33	0	logic_id=314		BkwdLogicScript	2014-05-15 13:37:04-04
4694	41	12	0	logic_id=274		BkwdLogicScript	2014-05-15 13:37:48-04
4695	41	96	0	logic_id=510		BkwdLogicScript	2014-05-15 13:38:19-04
4696	42	96	0	logic_id=510		BkwdLogicScript	2014-05-15 13:38:19-04
4697	41	97	0	logic_id=503		BkwdLogicScript	2014-05-15 13:38:23-04
4698	41	98	0	logic_id=502		BkwdLogicScript	2014-05-15 13:38:24-04
4699	42	98	0	logic_id=502		BkwdLogicScript	2014-05-15 13:38:24-04
4700	42	63	0	logic_id=499		BkwdLogicScript	2014-05-15 13:38:25-04
4701	20	127	0	logic_id=224		BkwdLogicScript	2014-05-15 13:38:30-04
4702	41	127	0	logic_id=224		BkwdLogicScript	2014-05-15 13:38:30-04
4703	20	126	0	logic_id=222		BkwdLogicScript	2014-05-15 13:38:31-04
4704	41	126	0	logic_id=222		BkwdLogicScript	2014-05-15 13:38:31-04
4705	41	94	0	logic_id=214		BkwdLogicScript	2014-05-15 13:38:41-04
4706	42	94	0	logic_id=214		BkwdLogicScript	2014-05-15 13:38:41-04
4707	41	95	0	logic_id=213		BkwdLogicScript	2014-05-15 13:38:42-04
4708	42	95	0	logic_id=213		BkwdLogicScript	2014-05-15 13:38:42-04
4709	41	23	0	logic_id=427		BkwdLogicScript	2014-05-15 13:39:15-04
4710	42	23	0	logic_id=427		BkwdLogicScript	2014-05-15 13:39:16-04
4711	41	22	0	logic_id=426		BkwdLogicScript	2014-05-15 13:39:17-04
4712	42	22	0	logic_id=426		BkwdLogicScript	2014-05-15 13:39:17-04
4713	41	25	0	logic_id=410		BkwdLogicScript	2014-05-15 13:39:30-04
4714	42	25	0	logic_id=410		BkwdLogicScript	2014-05-15 13:39:30-04
4715	41	24	0	logic_id=408		BkwdLogicScript	2014-05-15 13:39:33-04
4716	42	24	0	logic_id=408		BkwdLogicScript	2014-05-15 13:39:33-04
4717	29	46	0	logic_id=131		BkwdLogicScript	2014-05-15 13:39:48-04
4718	29	47	0	logic_id=126		BkwdLogicScript	2014-05-15 13:39:52-04
4719	29	45	0	logic_id=110		BkwdLogicScript	2014-05-15 13:40:02-04
4720	41	16	0	logic_id=104		BkwdLogicScript	2014-05-15 13:40:08-04
4721	42	16	0	logic_id=104		BkwdLogicScript	2014-05-15 13:40:08-04
4722	41	17	0	logic_id=101		BkwdLogicScript	2014-05-15 13:40:10-04
4723	42	17	0	logic_id=101		BkwdLogicScript	2014-05-15 13:40:10-04
4724	29	44	0	logic_id=74		BkwdLogicScript	2014-05-15 13:40:26-04
4725	41	38	0	logic_id=73		BkwdLogicScript	2014-05-15 13:40:27-04
4726	41	39	0	logic_id=72		BkwdLogicScript	2014-05-15 13:40:28-04
4727	41	15	0	logic_id=56		BkwdLogicScript	2014-05-15 13:40:39-04
4728	41	14	0	logic_id=53		BkwdLogicScript	2014-05-15 13:40:41-04
4729	41	36	0	logic_id=52		BkwdLogicScript	2014-05-15 13:40:42-04
4730	41	37	0	logic_id=50		BkwdLogicScript	2014-05-15 13:40:44-04
4731	41	13	0	logic_id=27		BkwdLogicScript	2014-05-15 13:41:04-04
4732	41	7	0	logic_id=25		BkwdLogicScript	2014-05-15 13:41:06-04
4733	20	113	0	logic_id=380		BkwdLogicScript	2014-05-15 13:45:10-04
4734	41	113	0	logic_id=380		BkwdLogicScript	2014-05-15 13:45:11-04
4735	20	112	0	logic_id=379		BkwdLogicScript	2014-05-15 13:45:12-04
4736	41	112	0	logic_id=379		BkwdLogicScript	2014-05-15 13:45:12-04
4737	42	120	0	logic_id=344		BkwdLogicScript	2014-05-15 13:45:49-04
4738	29	121	0	logic_id=338		BkwdLogicScript	2014-05-15 13:45:55-04
4739	29	120	0	logic_id=335		BkwdLogicScript	2014-05-15 13:46:00-04
4740	43	1	1	obvious	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	rschwiebert	2014-05-16 03:04:53-04
4741	43	52	1	By construction, all simple modules embed into M	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	rschwiebert	2014-05-16 03:06:35-04
4742	43	53	1	By construction, all simple modules embed into M	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	rschwiebert	2014-05-16 03:06:45-04
4743	43	56	0	R/J(R) is isomorphic to Z, and Z, which is not Artinian	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	rschwiebert	2014-05-16 03:08:21-04
4744	43	105	1	J(R)=M has square zero.	T.Y. Lam. Exercises in modules and rings p 214 ex 8.18	rschwiebert	2014-05-16 03:22:16-04
4745	43	62	1	logic_id=1		FwdLogicScript	2014-05-16 03:27:34-04
4746	43	67	1	logic_id=2		FwdLogicScript	2014-05-16 03:27:34-04
4747	43	68	1	logic_id=3		FwdLogicScript	2014-05-16 03:27:35-04
4748	43	100	1	logic_id=4		FwdLogicScript	2014-05-16 03:27:36-04
4749	43	99	1	logic_id=5		FwdLogicScript	2014-05-16 03:27:37-04
4750	43	101	1	logic_id=6		FwdLogicScript	2014-05-16 03:27:39-04
4751	43	116	1	logic_id=263		FwdLogicScript	2014-05-16 03:27:41-04
4752	43	117	1	logic_id=276		FwdLogicScript	2014-05-16 03:27:50-04
4753	43	61	1	logic_id=115		FwdLogicScript	2014-05-16 03:28:40-04
4754	43	64	1	logic_id=116		FwdLogicScript	2014-05-16 03:28:41-04
4755	43	128	1	logic_id=403		FwdLogicScript	2014-05-16 03:29:08-04
4756	43	106	1	logic_id=155		FwdLogicScript	2014-05-16 03:29:16-04
4757	43	107	1	logic_id=156		FwdLogicScript	2014-05-16 03:29:17-04
4758	43	111	1	logic_id=162		FwdLogicScript	2014-05-16 03:29:21-04
4759	43	110	1	logic_id=163		FwdLogicScript	2014-05-16 03:29:22-04
4760	43	130	1	logic_id=201		FwdLogicScript	2014-05-16 03:29:53-04
4761	43	89	1	logic_id=471		FwdLogicScript	2014-05-16 03:30:04-04
4762	43	129	1	logic_id=401		FwdLogicScript	2014-05-16 03:38:19-04
4763	43	109	1	logic_id=160		FwdLogicScript	2014-05-16 03:38:34-04
4764	43	60	1	logic_id=159		FwdLogicScript	2014-05-16 13:04:28-04
4765	43	57	0	logic_id=111		BkwdLogicScript	2014-05-16 13:07:59-04
4766	43	47	0	logic_id=129		BkwdLogicScript	2014-05-16 13:07:59-04
4767	43	46	0	logic_id=134		BkwdLogicScript	2014-05-16 13:07:59-04
4768	43	58	0	logic_id=145		BkwdLogicScript	2014-05-16 13:07:59-04
4769	43	59	0	logic_id=147		BkwdLogicScript	2014-05-16 13:08:00-04
4770	43	51	0	logic_id=294		BkwdLogicScript	2014-05-16 13:08:01-04
4771	43	50	0	logic_id=310		BkwdLogicScript	2014-05-16 13:08:02-04
4772	43	120	0	logic_id=335		BkwdLogicScript	2014-05-16 13:08:02-04
4773	43	121	0	logic_id=338		BkwdLogicScript	2014-05-16 13:08:02-04
4774	43	133	0	logic_id=445		BkwdLogicScript	2014-05-16 13:08:04-04
4775	43	43	0	logic_id=75		BkwdLogicScript	2014-05-16 13:08:15-04
4776	43	42	0	logic_id=76		BkwdLogicScript	2014-05-16 13:08:15-04
4777	43	55	0	logic_id=77		BkwdLogicScript	2014-05-16 13:08:15-04
4778	43	45	0	logic_id=109		BkwdLogicScript	2014-05-16 13:08:16-04
4779	43	54	0	logic_id=138		BkwdLogicScript	2014-05-16 13:08:16-04
4780	43	131	0	logic_id=441		BkwdLogicScript	2014-05-16 13:08:21-04
4781	43	132	0	logic_id=470		BkwdLogicScript	2014-05-16 13:08:22-04
4782	43	2	0	logic_id=10		BkwdLogicScript	2014-05-16 13:08:39-04
4783	43	3	0	logic_id=12		BkwdLogicScript	2014-05-16 13:08:40-04
4784	43	8	0	logic_id=41		BkwdLogicScript	2014-05-16 13:08:40-04
4785	43	41	0	logic_id=44		BkwdLogicScript	2014-05-16 13:08:40-04
4786	43	40	0	logic_id=47		BkwdLogicScript	2014-05-16 13:08:40-04
4787	43	44	0	logic_id=74		BkwdLogicScript	2014-05-16 13:08:41-04
4788	43	135	0	logic_id=440		BkwdLogicScript	2014-05-16 13:08:47-04
4789	43	63	0	logic_id=498		BkwdLogicScript	2014-05-16 13:08:49-04
4790	43	6	0	logic_id=17		BkwdLogicScript	2014-05-16 13:09:22-04
4791	43	37	0	logic_id=231		BkwdLogicScript	2014-05-16 13:09:26-04
4792	43	36	0	logic_id=232		BkwdLogicScript	2014-05-16 13:09:26-04
4793	43	98	0	logic_id=247		BkwdLogicScript	2014-05-16 13:09:26-04
4794	43	33	0	logic_id=314		BkwdLogicScript	2014-05-16 13:09:28-04
4795	43	10	0	logic_id=351		BkwdLogicScript	2014-05-16 13:09:29-04
4796	43	24	0	logic_id=408		BkwdLogicScript	2014-05-16 13:09:31-04
4797	43	25	0	logic_id=410		BkwdLogicScript	2014-05-16 13:09:31-04
4798	43	7	0	logic_id=504		BkwdLogicScript	2014-05-16 13:09:34-04
4799	43	96	0	logic_id=510		BkwdLogicScript	2014-05-16 13:09:34-04
4800	43	23	0	logic_id=120		BkwdLogicScript	2014-05-16 13:09:46-04
4801	43	22	0	logic_id=123		BkwdLogicScript	2014-05-16 13:09:46-04
4802	43	95	0	logic_id=213		BkwdLogicScript	2014-05-16 13:09:47-04
4803	43	94	0	logic_id=214		BkwdLogicScript	2014-05-16 13:09:47-04
4804	43	16	0	logic_id=215		BkwdLogicScript	2014-05-16 13:09:47-04
4805	43	17	0	logic_id=216		BkwdLogicScript	2014-05-16 13:09:47-04
4806	44	59	1		T.Y. Lam. First course in noncommutative rings p 345	rschwiebert	2014-05-16 13:32:19-04
4807	44	55	1		T.Y. Lam. First course in noncommutative rings p 345-346	rschwiebert	2014-05-16 13:33:55-04
4808	44	58	0		T.Y. Lam. First course in noncommutative rings p 345-346	rschwiebert	2014-05-16 13:34:17-04
4809	44	57	1	logic_id=77		FwdLogicScript	2014-05-16 13:36:44-04
4810	44	107	1	logic_id=78		FwdLogicScript	2014-05-16 13:36:44-04
4811	44	106	1	logic_id=79		FwdLogicScript	2014-05-16 13:36:44-04
4812	44	56	1	logic_id=111		FwdLogicScript	2014-05-16 13:36:54-04
4813	44	88	1	logic_id=112		FwdLogicScript	2014-05-16 13:36:54-04
4814	44	90	1	logic_id=113		FwdLogicScript	2014-05-16 13:36:55-04
4815	44	85	1	logic_id=114		FwdLogicScript	2014-05-16 13:36:56-04
4816	44	86	1	logic_id=117		FwdLogicScript	2014-05-16 13:36:57-04
4817	44	91	1	logic_id=135		FwdLogicScript	2014-05-16 13:37:02-04
4818	44	60	1	logic_id=137		FwdLogicScript	2014-05-16 13:37:03-04
4819	44	83	1	logic_id=146		FwdLogicScript	2014-05-16 13:37:08-04
4820	44	104	1	logic_id=154		FwdLogicScript	2014-05-16 13:37:13-04
4821	44	110	1	logic_id=165		FwdLogicScript	2014-05-16 13:37:18-04
4822	44	75	1	logic_id=179		FwdLogicScript	2014-05-16 13:37:25-04
4823	44	108	1	logic_id=435		FwdLogicScript	2014-05-16 13:37:26-04
4824	44	61	1	logic_id=181		FwdLogicScript	2014-05-16 13:37:27-04
4825	44	101	1	logic_id=182		FwdLogicScript	2014-05-16 13:37:28-04
4826	44	133	1	logic_id=443		FwdLogicScript	2014-05-16 13:37:29-04
4827	44	132	1	logic_id=444		FwdLogicScript	2014-05-16 13:37:30-04
4828	44	134	1	logic_id=446		FwdLogicScript	2014-05-16 13:37:31-04
4829	44	119	1	logic_id=209		FwdLogicScript	2014-05-16 13:37:40-04
4830	39	30	0	T has a principal nonprojective right ideal.	T.Y. Lam Lectures on modules and rings p 261	rschwiebert	2014-05-16 13:52:18-04
4831	22	34	0		T.Y. Lam Lectures on modules and rings p 249	rschwiebert	2014-05-16 14:00:16-04
4832	22	35	1		T.Y. Lam Lectures on modules and rings p 249	rschwiebert	2014-05-16 14:00:36-04
4833	22	11	0		T.Y. Lam Lectures on modules and rings p 329	rschwiebert	2014-05-16 14:02:32-04
4834	22	69	0	\\\\sum x^iyZ is an infinite direct sum of right ideals in the ring.	T.Y. Lam Lectures on modules and rings p 329	rschwiebert	2014-05-16 14:04:05-04
4835	44	84	1	logic_id=60		FwdLogicScript	2014-05-16 14:06:09-04
4836	44	66	1	logic_id=61		FwdLogicScript	2014-05-16 14:06:09-04
4837	44	65	1	logic_id=62		FwdLogicScript	2014-05-16 14:06:10-04
4838	44	62	1	logic_id=92		FwdLogicScript	2014-05-16 14:06:24-04
4839	44	87	1	logic_id=94		FwdLogicScript	2014-05-16 14:06:25-04
4840	44	64	1	logic_id=116		FwdLogicScript	2014-05-16 14:06:37-04
4841	44	109	1	logic_id=160		FwdLogicScript	2014-05-16 14:07:04-04
4842	44	117	1	logic_id=190		FwdLogicScript	2014-05-16 14:07:27-04
4843	44	111	0	logic_id=260		BkwdLogicScript	2014-05-16 14:21:34-04
4844	22	97	0	logic_id=503		BkwdLogicScript	2014-05-16 14:21:44-04
4845	22	126	0	logic_id=223		BkwdLogicScript	2014-05-16 14:21:51-04
4846	22	10	0	logic_id=422		BkwdLogicScript	2014-05-16 14:22:41-04
4847	44	105	0	logic_id=162		BkwdLogicScript	2014-05-16 14:22:46-04
4848	22	71	0	logic_id=150		BkwdLogicScript	2014-05-16 14:22:54-04
4849	44	54	0	logic_id=138		BkwdLogicScript	2014-05-16 14:23:04-04
4850	22	30	0	logic_id=100		BkwdLogicScript	2014-05-16 14:23:29-04
4851	22	28	0	logic_id=97		BkwdLogicScript	2014-05-16 14:23:31-04
4852	22	9	0	logic_id=80		BkwdLogicScript	2014-05-16 14:23:41-04
4853	22	38	0	logic_id=73		BkwdLogicScript	2014-05-16 14:23:46-04
4854	22	39	0	logic_id=72		BkwdLogicScript	2014-05-16 14:23:47-04
4855	22	32	0	logic_id=67		BkwdLogicScript	2014-05-16 14:23:50-04
4856	39	32	0	logic_id=67		BkwdLogicScript	2014-05-16 14:23:50-04
4857	22	26	0	logic_id=65		BkwdLogicScript	2014-05-16 14:23:51-04
4858	22	14	0	logic_id=55		BkwdLogicScript	2014-05-16 14:23:58-04
4859	22	36	0	logic_id=52		BkwdLogicScript	2014-05-16 14:23:59-04
4860	22	37	0	logic_id=50		BkwdLogicScript	2014-05-16 14:24:01-04
4861	22	7	0	logic_id=25		BkwdLogicScript	2014-05-16 14:24:21-04
4862	44	3	0	logic_id=12		BkwdLogicScript	2014-05-16 14:24:35-04
4863	44	2	0	logic_id=10		BkwdLogicScript	2014-05-16 14:24:37-04
4864	22	29	0	logic_id=452		BkwdLogicScript	2014-05-16 14:26:13-04
4865	44	125	0	logic_id=374		BkwdLogicScript	2014-05-16 14:26:37-04
4866	44	124	0	logic_id=373		BkwdLogicScript	2014-05-16 14:26:38-04
4867	22	125	0	logic_id=365		BkwdLogicScript	2014-05-16 14:26:46-04
4868	44	5	0	logic_id=282		BkwdLogicScript	2014-05-16 14:28:20-04
4869	44	4	0	logic_id=272		BkwdLogicScript	2014-05-16 14:28:29-04
4870	44	20	0	logic_id=514		BkwdLogicScript	2014-05-16 14:28:48-04
4871	22	98	0	logic_id=505		BkwdLogicScript	2014-05-16 14:28:55-04
4872	44	63	0	logic_id=499		BkwdLogicScript	2014-05-16 14:28:59-04
4873	44	9	0	logic_id=221		BkwdLogicScript	2014-05-16 14:29:06-04
4874	22	96	0	logic_id=220		BkwdLogicScript	2014-05-16 14:29:07-04
4875	22	95	0	logic_id=217		BkwdLogicScript	2014-05-16 14:29:10-04
4876	22	94	0	logic_id=214		BkwdLogicScript	2014-05-16 14:29:14-04
4877	22	33	0	logic_id=465		BkwdLogicScript	2014-05-16 14:29:17-04
4878	44	12	0	logic_id=448		BkwdLogicScript	2014-05-16 14:29:31-04
4879	44	131	0	logic_id=441		BkwdLogicScript	2014-05-16 14:29:39-04
4880	44	135	0	logic_id=440		BkwdLogicScript	2014-05-16 14:29:41-04
4881	44	41	0	logic_id=434		BkwdLogicScript	2014-05-16 14:29:45-04
4882	44	40	0	logic_id=433		BkwdLogicScript	2014-05-16 14:29:46-04
4883	44	13	0	logic_id=430		BkwdLogicScript	2014-05-16 14:29:47-04
4884	22	23	0	logic_id=427		BkwdLogicScript	2014-05-16 14:29:49-04
4885	22	22	0	logic_id=426		BkwdLogicScript	2014-05-16 14:29:51-04
4886	22	25	0	logic_id=410		BkwdLogicScript	2014-05-16 14:30:04-04
4887	22	24	0	logic_id=409		BkwdLogicScript	2014-05-16 14:30:06-04
4888	44	22	0	logic_id=122		BkwdLogicScript	2014-05-16 14:30:30-04
4889	44	45	0	logic_id=108		BkwdLogicScript	2014-05-16 14:30:39-04
4890	44	16	0	logic_id=104		BkwdLogicScript	2014-05-16 14:30:42-04
4891	22	17	0	logic_id=101		BkwdLogicScript	2014-05-16 14:30:44-04
4892	44	44	0	logic_id=74		BkwdLogicScript	2014-05-16 14:31:01-04
4893	44	38	0	logic_id=73		BkwdLogicScript	2014-05-16 14:31:02-04
4894	44	39	0	logic_id=72		BkwdLogicScript	2014-05-16 14:31:03-04
4895	44	18	0	logic_id=71		BkwdLogicScript	2014-05-16 14:31:03-04
4896	44	19	0	logic_id=69		BkwdLogicScript	2014-05-16 14:31:05-04
4897	22	27	0	logic_id=64		BkwdLogicScript	2014-05-16 14:31:08-04
4898	44	15	0	logic_id=56		BkwdLogicScript	2014-05-16 14:31:14-04
4899	44	36	0	logic_id=51		BkwdLogicScript	2014-05-16 14:31:17-04
4900	44	37	0	logic_id=49		BkwdLogicScript	2014-05-16 14:31:19-04
4901	44	8	0	logic_id=40		BkwdLogicScript	2014-05-16 14:31:26-04
4902	44	7	0	logic_id=25		BkwdLogicScript	2014-05-16 14:31:38-04
4903	44	6	0	logic_id=23		BkwdLogicScript	2014-05-16 14:31:40-04
4904	21	24	0	Since s is not onto, we can show the right uniform dimension is not 1.	T.Y. Lam Lectures on modules and rings p 308	rschwiebert	2014-05-16 14:43:15-04
4905	44	33	0	logic_id=468		BkwdLogicScript	2014-05-17 04:04:54-04
4906	21	69	0	logic_id=416		BkwdLogicScript	2014-05-17 04:05:10-04
4907	44	21	0	logic_id=378		BkwdLogicScript	2014-05-17 04:05:17-04
4908	44	10	0	logic_id=354		BkwdLogicScript	2014-05-17 04:05:35-04
4909	44	42	0	logic_id=521		BkwdLogicScript	2014-05-17 04:07:07-04
4910	44	43	0	logic_id=520		BkwdLogicScript	2014-05-17 04:07:09-04
4911	44	23	0	logic_id=519		BkwdLogicScript	2014-05-17 04:07:12-04
4912	44	96	0	logic_id=510		BkwdLogicScript	2014-05-17 04:07:23-04
4913	44	98	0	logic_id=502		BkwdLogicScript	2014-05-17 04:07:27-04
4914	21	126	0	logic_id=223		BkwdLogicScript	2014-05-17 04:07:32-04
4915	44	94	0	logic_id=214		BkwdLogicScript	2014-05-17 04:07:40-04
4916	44	95	0	logic_id=213		BkwdLogicScript	2014-05-17 04:07:41-04
4917	44	25	0	logic_id=410		BkwdLogicScript	2014-05-17 04:08:21-04
4918	44	24	0	logic_id=408		BkwdLogicScript	2014-05-17 04:08:24-04
4919	21	71	0	logic_id=150		BkwdLogicScript	2014-05-17 04:08:25-04
4920	21	22	0	logic_id=123		BkwdLogicScript	2014-05-17 04:08:43-04
4921	44	17	0	logic_id=103		BkwdLogicScript	2014-05-17 04:08:55-04
4922	21	124	0	logic_id=370		BkwdLogicScript	2014-05-17 04:14:13-04
4923	21	40	0	logic_id=226		BkwdLogicScript	2014-05-17 04:16:18-04
4924	21	42	0	logic_id=521		BkwdLogicScript	2014-05-17 04:30:16-04
4925	15	116	1	Right socle is set of linear transformations of finite rank.		rschwiebert	2014-05-18 01:31:50-04
4926	15	117	1	logic_id=349		FwdLogicScript	2014-05-18 01:35:27-04
4927	15	36	1	logic_id=351		FwdLogicScript	2014-05-18 01:35:29-04
4928	45	33	1		T.Y. Lam First course in noncommutative rings p 45	rschwiebert	2014-05-18 02:32:18-04
4929	45	7	1		T.Y. Lam First course in noncommutative rings p 45	rschwiebert	2014-05-18 02:32:36-04
4930	45	6	0		T.Y. Lam First course in noncommutative rings p 45	rschwiebert	2014-05-18 02:33:52-04
4931	45	37	1	logic_id=24		FwdLogicScript	2014-05-18 02:34:44-04
4932	45	36	1	logic_id=25		FwdLogicScript	2014-05-18 02:34:45-04
4933	45	9	1	logic_id=49		FwdLogicScript	2014-05-18 02:34:52-04
4934	45	10	1	logic_id=50		FwdLogicScript	2014-05-18 02:34:52-04
4935	45	11	1	logic_id=80		FwdLogicScript	2014-05-18 02:35:05-04
4936	45	104	1	logic_id=157		FwdLogicScript	2014-05-18 02:35:39-04
4937	45	108	1	logic_id=435		FwdLogicScript	2014-05-18 02:35:53-04
4938	45	61	1	logic_id=181		FwdLogicScript	2014-05-18 02:35:54-04
4939	45	101	1	logic_id=182		FwdLogicScript	2014-05-18 02:35:55-04
4940	45	14	1	logic_id=464		FwdLogicScript	2014-05-18 02:36:08-04
4941	45	32	1	logic_id=465		FwdLogicScript	2014-05-18 02:36:09-04
4942	45	105	1	logic_id=221		FwdLogicScript	2014-05-18 02:36:16-04
4943	45	98	1	logic_id=504		FwdLogicScript	2014-05-18 02:36:21-04
4944	45	97	1	logic_id=505		FwdLogicScript	2014-05-18 02:36:22-04
4945	45	35	1	logic_id=54		FwdLogicScript	2014-05-18 02:45:39-04
4946	45	34	1	logic_id=55		FwdLogicScript	2014-05-18 02:45:39-04
4947	45	31	1	logic_id=66		FwdLogicScript	2014-05-18 02:45:44-04
4948	45	30	1	logic_id=67		FwdLogicScript	2014-05-18 02:45:44-04
4949	45	130	1	logic_id=400		FwdLogicScript	2014-05-18 02:46:18-04
4950	45	129	1	logic_id=401		FwdLogicScript	2014-05-18 02:46:19-04
4951	45	128	1	logic_id=402		FwdLogicScript	2014-05-18 02:46:20-04
4952	45	111	1	logic_id=162		FwdLogicScript	2014-05-18 02:46:30-04
4953	45	110	1	logic_id=163		FwdLogicScript	2014-05-18 02:46:31-04
4954	21	20	0	It is a domain that is not right Bezout.		rschwiebert	2014-05-18 02:53:47-04
4955	21	99	0	It is a domain that is not right Ore.		rschwiebert	2014-05-18 21:59:42-04
4956	46	66	1	Straightforward calculation that left regular elements are units.	Varadarajan Hopfian and co-Hopfian objects (1992)	rschwiebert	2014-05-18 22:10:51-04
4957	46	65	0	[[1,1],[0,2]] is right regular but not a unit.	Varadarajan Hopfian and co-Hopfian objects (1992)	rschwiebert	2014-05-18 22:11:48-04
4958	46	61	1	logic_id=90		FwdLogicScript	2014-05-18 22:13:49-04
4959	45	109	1	logic_id=160		FwdLogicScript	2014-05-18 22:14:32-04
4960	45	60	1	logic_id=159		FwdLogicScript	2014-05-18 22:47:09-04
4961	45	1	0	logic_id=247		BkwdLogicScript	2014-05-18 22:51:40-04
4962	45	63	0	logic_id=230		BkwdLogicScript	2014-05-18 22:52:05-04
4963	45	66	0	logic_id=468		BkwdLogicScript	2014-05-18 22:52:10-04
4964	45	65	0	logic_id=467		BkwdLogicScript	2014-05-18 22:52:12-04
4965	45	12	0	logic_id=362		BkwdLogicScript	2014-05-18 22:52:52-04
4966	45	121	0	logic_id=348		BkwdLogicScript	2014-05-18 22:53:06-04
4967	45	120	0	logic_id=347		BkwdLogicScript	2014-05-18 22:53:07-04
4968	45	134	0	logic_id=332		BkwdLogicScript	2014-05-18 22:53:26-04
4969	45	55	0	logic_id=330		BkwdLogicScript	2014-05-18 22:53:30-04
4970	45	117	0	logic_id=322		BkwdLogicScript	2014-05-18 22:53:40-04
4971	45	116	0	logic_id=314		BkwdLogicScript	2014-05-18 22:53:50-04
4972	45	50	0	logic_id=307		BkwdLogicScript	2014-05-18 22:53:58-04
4973	45	102	0	logic_id=300		BkwdLogicScript	2014-05-18 22:54:06-04
4974	46	102	0	logic_id=300		BkwdLogicScript	2014-05-18 22:54:07-04
4975	45	51	0	logic_id=291		BkwdLogicScript	2014-05-18 22:54:16-04
4976	45	47	0	logic_id=196		BkwdLogicScript	2014-05-18 22:55:34-04
4977	45	46	0	logic_id=195		BkwdLogicScript	2014-05-18 22:55:36-04
4978	45	88	0	logic_id=447		BkwdLogicScript	2014-05-18 22:55:39-04
4979	45	56	0	logic_id=446		BkwdLogicScript	2014-05-18 22:55:40-04
4980	45	119	0	logic_id=190		BkwdLogicScript	2014-05-18 22:55:41-04
4981	45	133	0	logic_id=445		BkwdLogicScript	2014-05-18 22:55:42-04
4982	45	118	0	logic_id=189		BkwdLogicScript	2014-05-18 22:55:43-04
4983	45	113	0	logic_id=188		BkwdLogicScript	2014-05-18 22:55:44-04
4984	45	112	0	logic_id=187		BkwdLogicScript	2014-05-18 22:55:46-04
4985	45	131	0	logic_id=442		BkwdLogicScript	2014-05-18 22:55:47-04
4986	45	135	0	logic_id=440		BkwdLogicScript	2014-05-18 22:55:49-04
4987	45	93	0	logic_id=420		BkwdLogicScript	2014-05-18 22:56:06-04
4988	45	92	0	logic_id=418		BkwdLogicScript	2014-05-18 22:56:08-04
4989	45	57	0	logic_id=112		BkwdLogicScript	2014-05-18 22:56:43-04
4990	45	45	0	logic_id=110		BkwdLogicScript	2014-05-18 22:56:45-04
4991	46	12	0	logic_id=87		BkwdLogicScript	2014-05-18 22:56:59-04
4992	45	42	0	logic_id=76		BkwdLogicScript	2014-05-18 22:57:06-04
4993	45	43	0	logic_id=75		BkwdLogicScript	2014-05-18 22:57:06-04
4994	45	44	0	logic_id=74		BkwdLogicScript	2014-05-18 22:57:07-04
4995	45	83	0	logic_id=62		BkwdLogicScript	2014-05-18 22:57:16-04
4996	46	83	0	logic_id=62		BkwdLogicScript	2014-05-18 22:57:16-04
4997	45	15	0	logic_id=58		BkwdLogicScript	2014-05-18 22:57:19-04
4998	46	15	0	logic_id=58		BkwdLogicScript	2014-05-18 22:57:19-04
4999	45	40	0	logic_id=48		BkwdLogicScript	2014-05-18 22:57:27-04
5000	45	41	0	logic_id=45		BkwdLogicScript	2014-05-18 22:57:30-04
5001	45	8	0	logic_id=42		BkwdLogicScript	2014-05-18 22:57:32-04
5002	46	8	0	logic_id=37		BkwdLogicScript	2014-05-18 22:57:37-04
5003	45	13	0	logic_id=28		BkwdLogicScript	2014-05-18 22:57:43-04
5004	46	13	0	logic_id=28		BkwdLogicScript	2014-05-18 22:57:43-04
5005	45	53	0	logic_id=276		BkwdLogicScript	2014-05-18 22:57:51-04
5006	46	135	0	logic_id=19		BkwdLogicScript	2014-05-18 22:57:54-04
5007	46	6	0	logic_id=18		BkwdLogicScript	2014-05-18 22:57:55-04
5008	46	50	0	logic_id=13		BkwdLogicScript	2014-05-18 22:57:59-04
5009	45	52	0	logic_id=263		BkwdLogicScript	2014-05-18 22:58:04-04
5010	45	103	0	logic_id=481		BkwdLogicScript	2014-05-18 22:59:28-04
5011	45	86	0	logic_id=469		BkwdLogicScript	2014-05-18 22:59:32-04
5012	46	33	0	logic_id=468		BkwdLogicScript	2014-05-18 22:59:34-04
5013	45	123	0	logic_id=342		BkwdLogicScript	2014-05-18 23:00:37-04
5014	45	122	0	logic_id=341		BkwdLogicScript	2014-05-18 23:00:39-04
5015	45	2	0	logic_id=325		BkwdLogicScript	2014-05-18 23:00:58-04
5016	45	3	0	logic_id=317		BkwdLogicScript	2014-05-18 23:01:10-04
5017	46	96	0	logic_id=510		BkwdLogicScript	2014-05-18 23:02:28-04
5018	46	94	0	logic_id=214		BkwdLogicScript	2014-05-18 23:02:48-04
5019	46	95	0	logic_id=213		BkwdLogicScript	2014-05-18 23:02:49-04
5020	45	58	0	logic_id=210		BkwdLogicScript	2014-05-18 23:02:50-04
5021	45	59	0	logic_id=209		BkwdLogicScript	2014-05-18 23:02:51-04
5022	46	23	0	logic_id=427		BkwdLogicScript	2014-05-18 23:03:22-04
5023	46	22	0	logic_id=426		BkwdLogicScript	2014-05-18 23:03:24-04
5024	46	25	0	logic_id=410		BkwdLogicScript	2014-05-18 23:03:37-04
5025	46	24	0	logic_id=408		BkwdLogicScript	2014-05-18 23:03:40-04
5026	46	59	0	logic_id=146		BkwdLogicScript	2014-05-18 23:03:44-04
5027	46	58	0	logic_id=144		BkwdLogicScript	2014-05-18 23:03:47-04
5028	45	82	0	logic_id=143		BkwdLogicScript	2014-05-18 23:03:48-04
5029	45	81	0	logic_id=142		BkwdLogicScript	2014-05-18 23:03:49-04
5030	45	54	0	logic_id=139		BkwdLogicScript	2014-05-18 23:03:51-04
5031	46	54	0	logic_id=139		BkwdLogicScript	2014-05-18 23:03:51-04
5032	46	46	0	logic_id=131		BkwdLogicScript	2014-05-18 23:03:57-04
5033	45	87	0	logic_id=118		BkwdLogicScript	2014-05-18 23:04:06-04
5034	45	85	0	logic_id=117		BkwdLogicScript	2014-05-18 23:04:07-04
5035	45	90	0	logic_id=114		BkwdLogicScript	2014-05-18 23:04:08-04
5036	46	45	0	logic_id=110		BkwdLogicScript	2014-05-18 23:04:11-04
5037	46	16	0	logic_id=104		BkwdLogicScript	2014-05-18 23:04:16-04
5038	46	17	0	logic_id=101		BkwdLogicScript	2014-05-18 23:04:18-04
5039	45	84	0	logic_id=94		BkwdLogicScript	2014-05-18 23:04:22-04
5040	46	44	0	logic_id=74		BkwdLogicScript	2014-05-18 23:04:34-04
5041	46	3	0	logic_id=12		BkwdLogicScript	2014-05-18 23:05:25-04
5042	46	2	0	logic_id=10		BkwdLogicScript	2014-05-18 23:05:27-04
5043	46	63	0	logic_id=499		BkwdLogicScript	2014-05-19 01:40:06-04
5044	46	131	0	logic_id=441		BkwdLogicScript	2014-05-19 01:40:44-04
5045	47	1	1	obvious	 	\N	2014-05-27 01:32:37-04
5046	47	109	1	The radical is (x^{1/2},x^{1/4},x^{1/8},...), which is maximal and generated by nil elements	rschwiebert	\N	2014-05-27 01:46:33-04
5047	47	55	1	The unique maximal ideal is (x^{1/2},x^{1/4},x^{1/8},...) which is the nil ideal also	rschwiebert	\N	2014-05-27 01:47:16-04
5048	47	105	0	x^{1/2^k} has nilpotency index 2^k, so there are elements of arbitrarily high nilpotency index	rschwiebert	\N	2014-05-27 01:48:37-04
5049	47	75	0	(x)<(x^{1/2})<(x^{1/4})<...	rschwiebert	\N	2014-05-27 02:34:32-04
5050	47	76	0	symmetry		SymmScript	2014-05-27 02:35:53-04
5051	47	62	1	logic_id=1		FwdLogicScript	2014-05-27 02:37:25-04
5052	47	67	1	logic_id=2		FwdLogicScript	2014-05-27 02:37:25-04
5053	47	68	1	logic_id=3		FwdLogicScript	2014-05-27 02:37:26-04
5054	47	100	1	logic_id=4		FwdLogicScript	2014-05-27 02:37:26-04
5055	47	99	1	logic_id=5		FwdLogicScript	2014-05-27 02:37:27-04
5056	47	101	1	logic_id=6		FwdLogicScript	2014-05-27 02:37:27-04
5057	47	57	1	logic_id=77		FwdLogicScript	2014-05-27 02:37:48-04
5058	47	107	1	logic_id=78		FwdLogicScript	2014-05-27 02:37:48-04
5059	47	106	1	logic_id=79		FwdLogicScript	2014-05-27 02:37:48-04
5060	47	56	1	logic_id=111		FwdLogicScript	2014-05-27 02:37:57-04
5061	47	88	1	logic_id=112		FwdLogicScript	2014-05-27 02:37:58-04
5062	47	90	1	logic_id=113		FwdLogicScript	2014-05-27 02:37:58-04
5063	47	85	1	logic_id=114		FwdLogicScript	2014-05-27 02:37:58-04
5064	47	61	1	logic_id=115		FwdLogicScript	2014-05-27 02:37:59-04
5065	47	64	1	logic_id=116		FwdLogicScript	2014-05-27 02:38:00-04
5066	47	86	1	logic_id=117		FwdLogicScript	2014-05-27 02:38:00-04
5067	47	91	1	logic_id=135		FwdLogicScript	2014-05-27 02:38:04-04
5068	47	60	1	logic_id=137		FwdLogicScript	2014-05-27 02:38:05-04
5069	47	128	1	logic_id=403		FwdLogicScript	2014-05-27 02:38:10-04
5070	47	104	1	logic_id=154		FwdLogicScript	2014-05-27 02:38:14-04
5071	47	108	1	logic_id=435		FwdLogicScript	2014-05-27 02:38:26-04
5072	47	133	1	logic_id=443		FwdLogicScript	2014-05-27 02:38:29-04
5073	47	132	1	logic_id=444		FwdLogicScript	2014-05-27 02:38:29-04
5074	47	134	1	logic_id=446		FwdLogicScript	2014-05-27 02:38:31-04
5075	47	130	1	logic_id=201		FwdLogicScript	2014-05-27 02:38:35-04
5076	47	89	1	logic_id=471		FwdLogicScript	2014-05-27 02:38:40-04
5077	47	87	1	logic_id=363		FwdLogicScript	2014-05-27 02:40:02-04
5078	47	129	1	logic_id=401		FwdLogicScript	2014-05-27 02:58:30-04
5079	47	54	0	logic_id=164		BkwdLogicScript	2014-05-27 03:10:45-04
5080	47	4	0	logic_id=167		BkwdLogicScript	2014-05-27 03:10:46-04
5081	47	5	0	logic_id=168		BkwdLogicScript	2014-05-27 03:10:46-04
5082	47	59	0	logic_id=179		BkwdLogicScript	2014-05-27 03:10:46-04
5083	47	58	0	logic_id=180		BkwdLogicScript	2014-05-27 03:10:46-04
5084	47	9	0	logic_id=221		BkwdLogicScript	2014-05-27 03:10:47-04
5085	47	110	0	logic_id=259		BkwdLogicScript	2014-05-27 03:10:47-04
5086	47	111	0	logic_id=260		BkwdLogicScript	2014-05-27 03:10:47-04
5087	47	131	0	logic_id=441		BkwdLogicScript	2014-05-27 03:10:50-04
5088	47	12	0	logic_id=448		BkwdLogicScript	2014-05-27 03:10:50-04
5089	47	2	0	logic_id=9		BkwdLogicScript	2014-05-27 03:11:09-04
5090	47	3	0	logic_id=11		BkwdLogicScript	2014-05-27 03:11:10-04
5091	47	37	0	logic_id=49		BkwdLogicScript	2014-05-27 03:11:10-04
5092	47	36	0	logic_id=51		BkwdLogicScript	2014-05-27 03:11:10-04
5093	47	15	0	logic_id=56		BkwdLogicScript	2014-05-27 03:11:10-04
5094	47	19	0	logic_id=69		BkwdLogicScript	2014-05-27 03:11:11-04
5095	47	18	0	logic_id=71		BkwdLogicScript	2014-05-27 03:11:11-04
5096	47	39	0	logic_id=72		BkwdLogicScript	2014-05-27 03:11:11-04
5097	47	38	0	logic_id=73		BkwdLogicScript	2014-05-27 03:11:11-04
5098	47	17	0	logic_id=103		BkwdLogicScript	2014-05-27 03:11:11-04
5099	47	16	0	logic_id=106		BkwdLogicScript	2014-05-27 03:11:11-04
5100	47	45	0	logic_id=107		BkwdLogicScript	2014-05-27 03:11:12-04
5101	47	97	0	logic_id=246		BkwdLogicScript	2014-05-27 03:11:13-04
5102	47	95	0	logic_id=253		BkwdLogicScript	2014-05-27 03:11:14-04
5103	47	135	0	logic_id=440		BkwdLogicScript	2014-05-27 03:11:18-04
5104	47	94	0	logic_id=479		BkwdLogicScript	2014-05-27 03:11:18-04
5105	47	63	0	logic_id=498		BkwdLogicScript	2014-05-27 03:11:19-04
5106	47	98	0	logic_id=505		BkwdLogicScript	2014-05-27 03:11:19-04
5107	47	6	0	logic_id=17		BkwdLogicScript	2014-05-27 03:11:21-04
5108	47	7	0	logic_id=24		BkwdLogicScript	2014-05-27 03:11:21-04
5109	47	13	0	logic_id=27		BkwdLogicScript	2014-05-27 03:11:21-04
5110	47	8	0	logic_id=35		BkwdLogicScript	2014-05-27 03:11:21-04
5111	47	44	0	logic_id=74		BkwdLogicScript	2014-05-27 03:11:22-04
5112	38	68	1	Exactly three left ideals, two trivial, one unique maximal	rschwiebert	\N	2014-05-28 14:27:59-04
5113	38	67	0	The simple submodules of the right socle are not two-sided ideals	rschwiebert	\N	2014-05-28 14:28:34-04
5114	47	79	0	ann(x^{1/2^k}) forms a strictly descending chain	rschwiebert	\N	2014-05-28 14:32:54-04
5115	47	80	0	symmetry		SymmScript	2014-05-28 14:33:31-04
5116	48	1	1	Obvious	rschwiebert	\N	2014-05-29 13:19:58-04
5117	48	6	1	By definition it is the field of fractions for F_p[x]	rschwiebert	\N	2014-05-29 13:20:43-04
5118	48	62	1	logic_id=1		FwdLogicScript	2014-05-29 13:24:20-04
5119	48	67	1	logic_id=2		FwdLogicScript	2014-05-29 13:24:22-04
5120	48	68	1	logic_id=3		FwdLogicScript	2014-05-29 13:24:22-04
5121	48	100	1	logic_id=4		FwdLogicScript	2014-05-29 13:24:23-04
5122	48	99	1	logic_id=5		FwdLogicScript	2014-05-29 13:24:24-04
5123	48	101	1	logic_id=6		FwdLogicScript	2014-05-29 13:24:25-04
5124	48	135	1	logic_id=17		FwdLogicScript	2014-05-29 13:24:32-04
5125	48	13	1	logic_id=18		FwdLogicScript	2014-05-29 13:24:34-04
5126	48	8	1	logic_id=19		FwdLogicScript	2014-05-29 13:24:35-04
5127	48	40	1	logic_id=20		FwdLogicScript	2014-05-29 13:24:37-04
5128	48	41	1	logic_id=21		FwdLogicScript	2014-05-29 13:24:39-04
5129	48	17	1	logic_id=22		FwdLogicScript	2014-05-29 13:24:40-04
5130	48	16	1	logic_id=23		FwdLogicScript	2014-05-29 13:24:42-04
5131	48	14	1	logic_id=26		FwdLogicScript	2014-05-29 13:24:43-04
5132	48	15	1	logic_id=27		FwdLogicScript	2014-05-29 13:24:44-04
5133	48	83	1	logic_id=28		FwdLogicScript	2014-05-29 13:24:45-04
5134	48	27	1	logic_id=32		FwdLogicScript	2014-05-29 13:24:46-04
5135	48	26	1	logic_id=33		FwdLogicScript	2014-05-29 13:24:47-04
5136	48	32	1	logic_id=34		FwdLogicScript	2014-05-29 13:24:48-04
5137	48	19	1	logic_id=35		FwdLogicScript	2014-05-29 13:24:48-04
5138	48	18	1	logic_id=36		FwdLogicScript	2014-05-29 13:24:49-04
5139	48	39	1	logic_id=38		FwdLogicScript	2014-05-29 13:24:50-04
5140	48	38	1	logic_id=39		FwdLogicScript	2014-05-29 13:24:51-04
5141	48	44	1	logic_id=40		FwdLogicScript	2014-05-29 13:24:52-04
5142	48	43	1	logic_id=41		FwdLogicScript	2014-05-29 13:24:53-04
5143	48	42	1	logic_id=42		FwdLogicScript	2014-05-29 13:24:53-04
5144	48	21	1	logic_id=43		FwdLogicScript	2014-05-29 13:24:54-04
5145	48	55	1	logic_id=45		FwdLogicScript	2014-05-29 13:24:55-04
5146	48	20	1	logic_id=46		FwdLogicScript	2014-05-29 13:24:56-04
5147	48	11	1	logic_id=53		FwdLogicScript	2014-05-29 13:24:58-04
5148	48	35	1	logic_id=54		FwdLogicScript	2014-05-29 13:24:59-04
5149	48	34	1	logic_id=55		FwdLogicScript	2014-05-29 13:25:00-04
5150	48	12	1	logic_id=56		FwdLogicScript	2014-05-29 13:25:01-04
5151	48	66	1	logic_id=57		FwdLogicScript	2014-05-29 13:25:01-04
5152	48	65	1	logic_id=58		FwdLogicScript	2014-05-29 13:25:02-04
5153	48	91	1	logic_id=59		FwdLogicScript	2014-05-29 13:25:02-04
5154	48	84	1	logic_id=60		FwdLogicScript	2014-05-29 13:25:03-04
5155	48	29	1	logic_id=64		FwdLogicScript	2014-05-29 13:25:05-04
5156	48	28	1	logic_id=65		FwdLogicScript	2014-05-29 13:25:06-04
5157	48	31	1	logic_id=66		FwdLogicScript	2014-05-29 13:25:06-04
5158	48	30	1	logic_id=67		FwdLogicScript	2014-05-29 13:25:07-04
5159	48	5	1	logic_id=69		FwdLogicScript	2014-05-29 13:25:08-04
5160	48	4	1	logic_id=71		FwdLogicScript	2014-05-29 13:25:08-04
5161	48	9	1	logic_id=72		FwdLogicScript	2014-05-29 13:25:09-04
5162	48	45	1	logic_id=74		FwdLogicScript	2014-05-29 13:25:10-04
5163	48	57	1	logic_id=75		FwdLogicScript	2014-05-29 13:25:11-04
5164	48	107	1	logic_id=78		FwdLogicScript	2014-05-29 13:25:13-04
5165	48	106	1	logic_id=79		FwdLogicScript	2014-05-29 13:25:13-04
5166	48	103	1	logic_id=86		FwdLogicScript	2014-05-29 13:25:16-04
5167	48	102	1	logic_id=87		FwdLogicScript	2014-05-29 13:25:16-04
5168	48	90	1	logic_id=88		FwdLogicScript	2014-05-29 13:25:17-04
5169	48	61	1	logic_id=90		FwdLogicScript	2014-05-29 13:25:18-04
5170	48	85	1	logic_id=93		FwdLogicScript	2014-05-29 13:25:19-04
5171	48	87	1	logic_id=94		FwdLogicScript	2014-05-29 13:25:20-04
5172	48	74	1	logic_id=96		FwdLogicScript	2014-05-29 13:25:21-04
5173	48	73	1	logic_id=98		FwdLogicScript	2014-05-29 13:25:22-04
5174	48	23	1	logic_id=101		FwdLogicScript	2014-05-29 13:25:24-04
5175	48	22	1	logic_id=104		FwdLogicScript	2014-05-29 13:25:25-04
5176	48	3	1	logic_id=107		FwdLogicScript	2014-05-29 13:25:26-04
5177	48	2	1	logic_id=108		FwdLogicScript	2014-05-29 13:25:26-04
5178	48	47	1	logic_id=109		FwdLogicScript	2014-05-29 13:25:27-04
5179	48	46	1	logic_id=110		FwdLogicScript	2014-05-29 13:25:27-04
5180	48	56	1	logic_id=111		FwdLogicScript	2014-05-29 13:25:28-04
5181	48	88	1	logic_id=112		FwdLogicScript	2014-05-29 13:25:29-04
5182	48	64	1	logic_id=116		FwdLogicScript	2014-05-29 13:25:31-04
5183	48	86	1	logic_id=117		FwdLogicScript	2014-05-29 13:25:32-04
5184	48	25	1	logic_id=120		FwdLogicScript	2014-05-29 13:25:33-04
5185	48	24	1	logic_id=123		FwdLogicScript	2014-05-29 13:25:34-04
5186	48	49	1	logic_id=125		FwdLogicScript	2014-05-29 13:25:34-04
5187	48	51	1	logic_id=126		FwdLogicScript	2014-05-29 13:25:34-04
5188	48	82	1	logic_id=127		FwdLogicScript	2014-05-29 13:25:35-04
5189	48	52	1	logic_id=128		FwdLogicScript	2014-05-29 13:25:35-04
5190	48	48	1	logic_id=130		FwdLogicScript	2014-05-29 13:25:36-04
5191	48	50	1	logic_id=131		FwdLogicScript	2014-05-29 13:25:36-04
5192	48	81	1	logic_id=132		FwdLogicScript	2014-05-29 13:25:37-04
5193	48	53	1	logic_id=133		FwdLogicScript	2014-05-29 13:25:37-04
5194	48	60	1	logic_id=137		FwdLogicScript	2014-05-29 13:25:39-04
5195	48	130	1	logic_id=400		FwdLogicScript	2014-05-29 13:25:44-04
5196	48	129	1	logic_id=401		FwdLogicScript	2014-05-29 13:25:44-04
5197	48	128	1	logic_id=402		FwdLogicScript	2014-05-29 13:25:46-04
5198	48	33	1	logic_id=408		FwdLogicScript	2014-05-29 13:25:51-04
5199	48	71	1	logic_id=409		FwdLogicScript	2014-05-29 13:25:52-04
5200	48	104	1	logic_id=154		FwdLogicScript	2014-05-29 13:25:52-04
5201	48	72	1	logic_id=411		FwdLogicScript	2014-05-29 13:25:54-04
5202	48	75	1	logic_id=167		FwdLogicScript	2014-05-29 13:26:01-04
5203	48	10	1	logic_id=423		FwdLogicScript	2014-05-29 13:26:02-04
5204	48	76	1	logic_id=168		FwdLogicScript	2014-05-29 13:26:03-04
5205	48	96	1	logic_id=426		FwdLogicScript	2014-05-29 13:26:05-04
5206	48	108	1	logic_id=171		FwdLogicScript	2014-05-29 13:26:06-04
5207	48	124	1	logic_id=429		FwdLogicScript	2014-05-29 13:26:08-04
5208	48	125	1	logic_id=430		FwdLogicScript	2014-05-29 13:26:10-04
5209	48	77	1	logic_id=176		FwdLogicScript	2014-05-29 13:26:10-04
5210	48	7	1	logic_id=439		FwdLogicScript	2014-05-29 13:26:15-04
5211	48	131	1	logic_id=440		FwdLogicScript	2014-05-29 13:26:16-04
5212	48	54	1	logic_id=441		FwdLogicScript	2014-05-29 13:26:17-04
5213	48	133	1	logic_id=442		FwdLogicScript	2014-05-29 13:26:18-04
5214	48	132	1	logic_id=444		FwdLogicScript	2014-05-29 13:26:20-04
5215	48	134	1	logic_id=446		FwdLogicScript	2014-05-29 13:26:22-04
5216	48	120	1	logic_id=195		FwdLogicScript	2014-05-29 13:26:25-04
5217	48	121	1	logic_id=196		FwdLogicScript	2014-05-29 13:26:25-04
5218	48	122	1	logic_id=197		FwdLogicScript	2014-05-29 13:26:26-04
5219	48	123	1	logic_id=198		FwdLogicScript	2014-05-29 13:26:26-04
5220	48	118	1	logic_id=199		FwdLogicScript	2014-05-29 13:26:27-04
5221	48	119	1	logic_id=200		FwdLogicScript	2014-05-29 13:26:27-04
5222	48	80	1	logic_id=460		FwdLogicScript	2014-05-29 13:26:29-04
5223	48	95	1	logic_id=215		FwdLogicScript	2014-05-29 13:26:35-04
5224	48	89	1	logic_id=471		FwdLogicScript	2014-05-29 13:26:36-04
5225	48	94	1	logic_id=216		FwdLogicScript	2014-05-29 13:26:37-04
5226	48	78	1	logic_id=472		FwdLogicScript	2014-05-29 13:26:38-04
5227	48	105	1	logic_id=221		FwdLogicScript	2014-05-29 13:26:42-04
5228	48	126	1	logic_id=226		FwdLogicScript	2014-05-29 13:26:44-04
5229	48	127	1	logic_id=227		FwdLogicScript	2014-05-29 13:26:44-04
5230	48	98	1	logic_id=504		FwdLogicScript	2014-05-29 13:26:47-04
5231	48	97	1	logic_id=505		FwdLogicScript	2014-05-29 13:26:47-04
5232	48	112	1	logic_id=500		FwdLogicScript	2014-05-29 13:29:16-04
5233	48	113	1	logic_id=501		FwdLogicScript	2014-05-29 13:29:18-04
5234	48	79	1	logic_id=0		FwdLogicScript	2014-05-29 13:30:07-04
5235	48	116	1	logic_id=263		FwdLogicScript	2014-05-29 13:30:13-04
5236	48	92	1	logic_id=14		FwdLogicScript	2014-05-29 13:30:17-04
5237	48	93	1	logic_id=16		FwdLogicScript	2014-05-29 13:30:18-04
5238	48	117	1	logic_id=276		FwdLogicScript	2014-05-29 13:30:20-04
5239	48	37	1	logic_id=24		FwdLogicScript	2014-05-29 13:30:22-04
5240	48	36	1	logic_id=25		FwdLogicScript	2014-05-29 13:30:24-04
5241	48	58	1	logic_id=138		FwdLogicScript	2014-05-29 13:31:08-04
5242	48	59	1	logic_id=139		FwdLogicScript	2014-05-29 13:31:09-04
5243	48	70	1	logic_id=148		FwdLogicScript	2014-05-29 13:31:16-04
5244	48	69	1	logic_id=150		FwdLogicScript	2014-05-29 13:31:18-04
5245	48	111	1	logic_id=162		FwdLogicScript	2014-05-29 13:31:25-04
5246	48	110	1	logic_id=163		FwdLogicScript	2014-05-29 13:31:26-04
5247	48	114	1	logic_id=191		FwdLogicScript	2014-05-29 13:31:45-04
5248	48	115	1	logic_id=192		FwdLogicScript	2014-05-29 13:31:46-04
5249	49	1	1	Obvious	rschwiebert	\N	2014-05-31 15:22:45-04
5250	49	55	1	Radical is (x) which is maximal	rschwiebert	\N	2014-05-31 15:23:18-04
5251	49	105	1	Radical is (x)	rschwiebert	\N	2014-05-31 15:23:43-04
5252	49	2	1	It has R dimension 2q	rschwiebert	\N	2014-05-31 15:24:22-04
5253	49	79	1	logic_id=0		FwdLogicScript	2014-05-31 15:26:04-04
5254	49	62	1	logic_id=1		FwdLogicScript	2014-05-31 15:26:05-04
5255	49	67	1	logic_id=2		FwdLogicScript	2014-05-31 15:26:05-04
5256	49	68	1	logic_id=3		FwdLogicScript	2014-05-31 15:26:06-04
5257	49	100	1	logic_id=4		FwdLogicScript	2014-05-31 15:26:06-04
5258	49	99	1	logic_id=5		FwdLogicScript	2014-05-31 15:26:07-04
5259	49	101	1	logic_id=6		FwdLogicScript	2014-05-31 15:26:08-04
5260	49	4	1	logic_id=9		FwdLogicScript	2014-05-31 15:26:10-04
5261	49	54	1	logic_id=10		FwdLogicScript	2014-05-31 15:26:10-04
5262	49	57	1	logic_id=77		FwdLogicScript	2014-05-31 15:26:33-04
5263	49	107	1	logic_id=78		FwdLogicScript	2014-05-31 15:26:33-04
5264	49	106	1	logic_id=79		FwdLogicScript	2014-05-31 15:26:33-04
5265	49	56	1	logic_id=111		FwdLogicScript	2014-05-31 15:26:43-04
5266	49	88	1	logic_id=112		FwdLogicScript	2014-05-31 15:26:43-04
5267	49	90	1	logic_id=113		FwdLogicScript	2014-05-31 15:26:44-04
5268	49	85	1	logic_id=114		FwdLogicScript	2014-05-31 15:26:44-04
5269	49	61	1	logic_id=115		FwdLogicScript	2014-05-31 15:26:45-04
5270	49	64	1	logic_id=116		FwdLogicScript	2014-05-31 15:26:45-04
5271	49	86	1	logic_id=117		FwdLogicScript	2014-05-31 15:26:46-04
5272	49	91	1	logic_id=135		FwdLogicScript	2014-05-31 15:26:51-04
5273	49	60	1	logic_id=137		FwdLogicScript	2014-05-31 15:26:52-04
5274	49	58	1	logic_id=138		FwdLogicScript	2014-05-31 15:26:52-04
5275	49	59	1	logic_id=139		FwdLogicScript	2014-05-31 15:26:53-04
5276	49	73	1	logic_id=140		FwdLogicScript	2014-05-31 15:26:53-04
5277	49	83	1	logic_id=144		FwdLogicScript	2014-05-31 15:26:55-04
5278	49	128	1	logic_id=403		FwdLogicScript	2014-05-31 15:26:58-04
5279	49	104	1	logic_id=154		FwdLogicScript	2014-05-31 15:27:02-04
5280	49	111	1	logic_id=162		FwdLogicScript	2014-05-31 15:27:05-04
5281	49	110	1	logic_id=163		FwdLogicScript	2014-05-31 15:27:06-04
5282	49	75	1	logic_id=167		FwdLogicScript	2014-05-31 15:27:09-04
5283	49	108	1	logic_id=172		FwdLogicScript	2014-05-31 15:27:13-04
5284	49	76	1	logic_id=180		FwdLogicScript	2014-05-31 15:27:16-04
5285	49	133	1	logic_id=443		FwdLogicScript	2014-05-31 15:27:19-04
5286	49	132	1	logic_id=444		FwdLogicScript	2014-05-31 15:27:20-04
5287	49	134	1	logic_id=446		FwdLogicScript	2014-05-31 15:27:21-04
5288	49	130	1	logic_id=201		FwdLogicScript	2014-05-31 15:27:26-04
5289	49	78	1	logic_id=463		FwdLogicScript	2014-05-31 15:27:29-04
5290	49	119	1	logic_id=209		FwdLogicScript	2014-05-31 15:27:29-04
5291	49	118	1	logic_id=210		FwdLogicScript	2014-05-31 15:27:30-04
5292	49	89	1	logic_id=471		FwdLogicScript	2014-05-31 15:27:32-04
5293	49	53	1	logic_id=321		FwdLogicScript	2014-05-31 15:28:39-04
5294	49	52	1	logic_id=329		FwdLogicScript	2014-05-31 15:28:47-04
5295	49	131	1	logic_id=413		FwdLogicScript	2014-05-31 15:29:29-04
5296	49	3	1	symmetry		SymmScript	2014-05-31 15:32:05-04
5297	49	5	1	symmetry		SymmScript	2014-05-31 15:32:06-04
5298	49	74	1	symmetry		SymmScript	2014-05-31 15:32:06-04
5299	49	77	1	symmetry		SymmScript	2014-05-31 15:32:06-04
5300	49	80	1	symmetry		SymmScript	2014-05-31 15:32:06-04
5301	49	71	1	logic_id=7		FwdLogicScript	2014-05-31 15:34:39-04
5302	49	116	1	logic_id=263		FwdLogicScript	2014-05-31 15:34:40-04
5303	49	72	1	logic_id=8		FwdLogicScript	2014-05-31 15:34:40-04
5304	49	117	1	logic_id=276		FwdLogicScript	2014-05-31 15:34:45-04
5305	49	84	1	logic_id=60		FwdLogicScript	2014-05-31 15:34:56-04
5306	49	66	1	logic_id=61		FwdLogicScript	2014-05-31 15:34:57-04
5307	49	65	1	logic_id=62		FwdLogicScript	2014-05-31 15:34:57-04
5308	49	87	1	logic_id=94		FwdLogicScript	2014-05-31 15:35:07-04
5309	49	129	1	logic_id=401		FwdLogicScript	2014-05-31 15:35:25-04
5310	49	70	1	logic_id=148		FwdLogicScript	2014-05-31 15:35:27-04
5311	49	69	1	logic_id=150		FwdLogicScript	2014-05-31 15:35:28-04
5312	49	109	1	logic_id=160		FwdLogicScript	2014-05-31 15:35:33-04
5313	49	114	1	logic_id=205		FwdLogicScript	2014-05-31 15:35:55-04
5314	49	115	1	logic_id=206		FwdLogicScript	2014-05-31 15:35:56-04
5315	49	40	1	Has exactly three ideals	rschwiebert	\N	2014-05-31 16:01:38-04
5316	49	41	1	Has exactly three ideals	rschwiebert	\N	2014-05-31 16:02:02-04
5317	49	34	0	ann((x))=(x) which is essential in R	rschwiebert	\N	2014-05-31 18:40:10-04
5318	49	35	0	ann((x))=(x) which is essential in R	rschwiebert	\N	2014-05-31 18:40:49-04
5319	49	112	1	(x) is the unique nontrivial ideal	rschwiebert	\N	2014-05-31 18:41:30-04
5320	49	113	1	(x) is the unique nontrivial ideal	rschwiebert	\N	2014-05-31 19:10:21-04
5321	49	11	0	(x)^2=(0)	rschwiebert	\N	2014-05-31 19:12:17-04
5322	49	14	0	logic_id=53		BkwdLogicScript	2014-05-31 19:13:55-04
5323	49	9	0	logic_id=80		BkwdLogicScript	2014-05-31 19:13:56-04
5324	49	31	0	logic_id=99		BkwdLogicScript	2014-05-31 19:13:56-04
5325	49	30	0	logic_id=100		BkwdLogicScript	2014-05-31 19:13:56-04
5326	49	12	0	logic_id=257		BkwdLogicScript	2014-05-31 19:13:58-04
5327	49	10	0	logic_id=422		BkwdLogicScript	2014-05-31 19:14:02-04
5328	49	33	0	logic_id=423		BkwdLogicScript	2014-05-31 19:14:02-04
5329	49	98	0	logic_id=502		BkwdLogicScript	2014-05-31 19:14:03-04
5330	49	97	0	logic_id=503		BkwdLogicScript	2014-05-31 19:14:03-04
5331	49	7	0	logic_id=504		BkwdLogicScript	2014-05-31 19:14:03-04
5332	49	96	0	logic_id=510		BkwdLogicScript	2014-05-31 19:14:03-04
5333	49	13	0	logic_id=26		BkwdLogicScript	2014-05-31 19:14:04-04
5334	49	37	0	logic_id=49		BkwdLogicScript	2014-05-31 19:14:05-04
5335	49	36	0	logic_id=51		BkwdLogicScript	2014-05-31 19:14:05-04
5336	49	15	0	logic_id=56		BkwdLogicScript	2014-05-31 19:14:06-04
5337	49	32	0	logic_id=66		BkwdLogicScript	2014-05-31 19:14:07-04
5338	49	39	0	logic_id=72		BkwdLogicScript	2014-05-31 19:14:07-04
5339	49	38	0	logic_id=73		BkwdLogicScript	2014-05-31 19:14:07-04
5340	49	29	0	logic_id=95		BkwdLogicScript	2014-05-31 19:14:08-04
5341	49	28	0	logic_id=97		BkwdLogicScript	2014-05-31 19:14:08-04
5342	49	95	0	logic_id=213		BkwdLogicScript	2014-05-31 19:14:10-04
5343	49	94	0	logic_id=214		BkwdLogicScript	2014-05-31 19:14:11-04
5344	49	16	0	logic_id=215		BkwdLogicScript	2014-05-31 19:14:11-04
5345	49	17	0	logic_id=216		BkwdLogicScript	2014-05-31 19:14:11-04
5346	49	24	0	logic_id=408		BkwdLogicScript	2014-05-31 19:14:15-04
5347	49	25	0	logic_id=410		BkwdLogicScript	2014-05-31 19:14:16-04
5348	49	22	0	logic_id=426		BkwdLogicScript	2014-05-31 19:14:16-04
5349	49	23	0	logic_id=427		BkwdLogicScript	2014-05-31 19:14:16-04
5350	49	135	0	logic_id=439		BkwdLogicScript	2014-05-31 19:14:17-04
5351	49	6	0	logic_id=17		BkwdLogicScript	2014-05-31 19:14:21-04
5352	49	8	0	logic_id=34		BkwdLogicScript	2014-05-31 19:14:22-04
5353	49	27	0	logic_id=64		BkwdLogicScript	2014-05-31 19:14:23-04
5354	49	26	0	logic_id=65		BkwdLogicScript	2014-05-31 19:14:23-04
5355	49	21	1	logic_id=43		FwdLogicScript	2014-05-31 19:15:56-04
5356	49	43	1	logic_id=44		FwdLogicScript	2014-05-31 19:15:56-04
5357	49	20	1	logic_id=46		FwdLogicScript	2014-05-31 19:15:57-04
5358	49	42	1	logic_id=47		FwdLogicScript	2014-05-31 19:15:58-04
5359	49	124	1	logic_id=433		FwdLogicScript	2014-05-31 19:17:20-04
5360	49	125	1	logic_id=434		FwdLogicScript	2014-05-31 19:17:20-04
5361	49	126	1	logic_id=226		FwdLogicScript	2014-05-31 19:17:48-04
5362	49	127	1	logic_id=227		FwdLogicScript	2014-05-31 19:17:50-04
5363	49	18	1	logic_id=262		FwdLogicScript	2014-05-31 19:18:04-04
5364	49	19	1	logic_id=275		FwdLogicScript	2014-05-31 19:18:24-04
5365	49	45	1	logic_id=381		FwdLogicScript	2014-05-31 19:21:28-04
5366	49	47	1	logic_id=109		FwdLogicScript	2014-05-31 19:32:00-04
5367	49	46	1	logic_id=110		FwdLogicScript	2014-05-31 19:32:02-04
5368	49	49	1	logic_id=125		FwdLogicScript	2014-05-31 19:32:09-04
5369	49	51	1	logic_id=126		FwdLogicScript	2014-05-31 19:32:09-04
5370	49	82	1	logic_id=127		FwdLogicScript	2014-05-31 19:32:10-04
5371	49	48	1	logic_id=130		FwdLogicScript	2014-05-31 19:32:11-04
5372	49	50	1	logic_id=131		FwdLogicScript	2014-05-31 19:32:12-04
5373	49	81	1	logic_id=132		FwdLogicScript	2014-05-31 19:32:12-04
5374	49	120	1	logic_id=195		FwdLogicScript	2014-05-31 19:33:01-04
5375	49	121	1	logic_id=196		FwdLogicScript	2014-05-31 19:33:01-04
5376	49	122	1	logic_id=197		FwdLogicScript	2014-05-31 19:33:02-04
5377	49	123	1	logic_id=198		FwdLogicScript	2014-05-31 19:33:02-04
5378	49	44	1	logic_id=245		FwdLogicScript	2014-05-31 19:36:11-04
5379	50	55	1	Nilradical (x,y,z) is maximal	obvious	\N	2014-05-31 22:31:45-04
5380	50	105	1	(x,y,z)^4=0	obvious	\N	2014-05-31 22:33:54-04
5381	50	2	1	has finite R dimension	wikipedia	\N	2014-06-01 13:23:13-04
5382	50	3	1	has finite R dimension	rschwiebert	\N	2014-06-01 13:24:27-04
5383	50	79	1	logic_id=0		FwdLogicScript	2014-06-01 14:01:57-04
5384	50	4	1	logic_id=9		FwdLogicScript	2014-06-01 14:02:03-04
5385	50	54	1	logic_id=10		FwdLogicScript	2014-06-01 14:02:03-04
5386	50	5	1	logic_id=11		FwdLogicScript	2014-06-01 14:02:04-04
5387	50	57	1	logic_id=77		FwdLogicScript	2014-06-01 14:02:27-04
5388	50	107	1	logic_id=78		FwdLogicScript	2014-06-01 14:02:27-04
5389	50	106	1	logic_id=79		FwdLogicScript	2014-06-01 14:02:27-04
5390	50	56	1	logic_id=111		FwdLogicScript	2014-06-01 14:02:37-04
5391	50	88	1	logic_id=112		FwdLogicScript	2014-06-01 14:02:37-04
5392	50	90	1	logic_id=113		FwdLogicScript	2014-06-01 14:02:37-04
5393	50	85	1	logic_id=114		FwdLogicScript	2014-06-01 14:02:38-04
5394	50	86	1	logic_id=117		FwdLogicScript	2014-06-01 14:02:40-04
5395	50	91	1	logic_id=135		FwdLogicScript	2014-06-01 14:02:44-04
5396	50	60	1	logic_id=137		FwdLogicScript	2014-06-01 14:02:45-04
5397	50	58	1	logic_id=138		FwdLogicScript	2014-06-01 14:02:46-04
5398	50	59	1	logic_id=139		FwdLogicScript	2014-06-01 14:02:46-04
5399	50	73	1	logic_id=140		FwdLogicScript	2014-06-01 14:02:47-04
5400	50	74	1	logic_id=141		FwdLogicScript	2014-06-01 14:02:47-04
5401	50	83	1	logic_id=144		FwdLogicScript	2014-06-01 14:02:48-04
5402	50	104	1	logic_id=154		FwdLogicScript	2014-06-01 14:02:55-04
5403	50	111	1	logic_id=162		FwdLogicScript	2014-06-01 14:02:58-04
5404	50	110	1	logic_id=163		FwdLogicScript	2014-06-01 14:02:59-04
5405	50	75	1	logic_id=167		FwdLogicScript	2014-06-01 14:03:01-04
5406	50	76	1	logic_id=168		FwdLogicScript	2014-06-01 14:03:02-04
5407	50	108	1	logic_id=171		FwdLogicScript	2014-06-01 14:03:04-04
5408	50	77	1	logic_id=176		FwdLogicScript	2014-06-01 14:03:07-04
5409	50	61	1	logic_id=181		FwdLogicScript	2014-06-01 14:03:09-04
5410	50	101	1	logic_id=182		FwdLogicScript	2014-06-01 14:03:09-04
5411	50	133	1	logic_id=443		FwdLogicScript	2014-06-01 14:03:11-04
5412	50	132	1	logic_id=444		FwdLogicScript	2014-06-01 14:03:12-04
5413	50	134	1	logic_id=446		FwdLogicScript	2014-06-01 14:03:14-04
5414	50	80	1	logic_id=460		FwdLogicScript	2014-06-01 14:03:18-04
5415	50	78	1	logic_id=463		FwdLogicScript	2014-06-01 14:03:21-04
5416	50	119	1	logic_id=209		FwdLogicScript	2014-06-01 14:03:22-04
5417	50	118	1	logic_id=210		FwdLogicScript	2014-06-01 14:03:22-04
5418	50	53	1	logic_id=321		FwdLogicScript	2014-06-01 14:04:22-04
5419	50	52	1	logic_id=329		FwdLogicScript	2014-06-01 14:04:28-04
5420	50	131	1	logic_id=413		FwdLogicScript	2014-06-01 14:05:05-04
5421	50	71	1	logic_id=7		FwdLogicScript	2014-06-01 14:06:14-04
5422	50	116	1	logic_id=263		FwdLogicScript	2014-06-01 14:06:15-04
5423	50	72	1	logic_id=8		FwdLogicScript	2014-06-01 14:06:15-04
5424	50	117	1	logic_id=276		FwdLogicScript	2014-06-01 14:06:21-04
5425	50	84	1	logic_id=60		FwdLogicScript	2014-06-01 14:06:32-04
5426	50	66	1	logic_id=61		FwdLogicScript	2014-06-01 14:06:33-04
5427	50	65	1	logic_id=62		FwdLogicScript	2014-06-01 14:06:33-04
5428	50	62	1	logic_id=92		FwdLogicScript	2014-06-01 14:06:42-04
5429	50	87	1	logic_id=94		FwdLogicScript	2014-06-01 14:06:43-04
5430	50	64	1	logic_id=116		FwdLogicScript	2014-06-01 14:06:51-04
5431	50	70	1	logic_id=148		FwdLogicScript	2014-06-01 14:07:03-04
5432	50	69	1	logic_id=150		FwdLogicScript	2014-06-01 14:07:04-04
5433	50	109	1	logic_id=160		FwdLogicScript	2014-06-01 14:07:10-04
5434	50	114	1	logic_id=205		FwdLogicScript	2014-06-01 14:07:35-04
5435	50	115	1	logic_id=206		FwdLogicScript	2014-06-01 14:07:36-04
5436	50	1	1	obvious	rschwiebert	\N	2014-06-01 14:39:07-04
5437	50	67	1	logic_id=2		FwdLogicScript	2014-06-01 14:39:24-04
5438	50	68	1	logic_id=3		FwdLogicScript	2014-06-01 14:39:25-04
5439	50	100	1	logic_id=4		FwdLogicScript	2014-06-01 14:39:25-04
5440	50	99	1	logic_id=5		FwdLogicScript	2014-06-01 14:39:26-04
5441	50	128	1	logic_id=403		FwdLogicScript	2014-06-01 14:40:20-04
5442	50	130	1	logic_id=201		FwdLogicScript	2014-06-01 14:40:52-04
5443	50	89	1	logic_id=471		FwdLogicScript	2014-06-01 14:40:58-04
5444	50	129	1	logic_id=401		FwdLogicScript	2014-06-01 14:45:24-04
5445	50	40	0	(x) and (y) cannot be arranged in a chain	rschwiebert	\N	2014-06-01 15:39:11-04
5446	50	41	0	(x) and (y) cannot be arranged in a chain	rschwiebert	\N	2014-06-01 15:39:40-04
5447	50	6	0	logic_id=20		BkwdLogicScript	2014-06-01 15:43:16-04
5448	50	37	0	logic_id=231		BkwdLogicScript	2014-06-01 15:43:20-04
5449	50	36	0	logic_id=232		BkwdLogicScript	2014-06-01 15:43:20-04
5450	50	98	0	logic_id=247		BkwdLogicScript	2014-06-01 15:43:21-04
5451	50	33	0	logic_id=314		BkwdLogicScript	2014-06-01 15:43:22-04
5452	50	9	0	logic_id=330		BkwdLogicScript	2014-06-01 15:43:23-04
5453	50	10	0	logic_id=351		BkwdLogicScript	2014-06-01 15:43:23-04
5454	50	12	0	logic_id=362		BkwdLogicScript	2014-06-01 15:43:24-04
5455	50	18	0	logic_id=392		BkwdLogicScript	2014-06-01 15:43:24-04
5456	50	19	0	logic_id=393		BkwdLogicScript	2014-06-01 15:43:25-04
5457	50	24	0	logic_id=408		BkwdLogicScript	2014-06-01 15:43:25-04
5458	50	25	0	logic_id=410		BkwdLogicScript	2014-06-01 15:43:25-04
5459	50	11	0	logic_id=428		BkwdLogicScript	2014-06-01 15:43:26-04
5460	50	97	0	logic_id=503		BkwdLogicScript	2014-06-01 15:43:27-04
5461	50	7	0	logic_id=504		BkwdLogicScript	2014-06-01 15:43:27-04
5462	50	96	0	logic_id=510		BkwdLogicScript	2014-06-01 15:43:27-04
5463	50	22	0	logic_id=518		BkwdLogicScript	2014-06-01 15:43:28-04
5464	50	23	0	logic_id=519		BkwdLogicScript	2014-06-01 15:43:28-04
5465	50	43	0	logic_id=520		BkwdLogicScript	2014-06-01 15:43:28-04
5466	50	42	0	logic_id=521		BkwdLogicScript	2014-06-01 15:43:28-04
5467	50	8	0	logic_id=35		BkwdLogicScript	2014-06-02 01:26:28-04
5468	50	14	0	logic_id=53		BkwdLogicScript	2014-06-02 01:26:30-04
5469	50	15	0	logic_id=56		BkwdLogicScript	2014-06-02 01:26:30-04
5470	50	39	0	logic_id=72		BkwdLogicScript	2014-06-02 01:26:30-04
5471	50	38	0	logic_id=73		BkwdLogicScript	2014-06-02 01:26:30-04
5472	50	17	0	logic_id=101		BkwdLogicScript	2014-06-02 01:26:31-04
5473	50	16	0	logic_id=104		BkwdLogicScript	2014-06-02 01:26:31-04
5474	50	95	0	logic_id=213		BkwdLogicScript	2014-06-02 01:26:32-04
5475	50	94	0	logic_id=214		BkwdLogicScript	2014-06-02 01:26:32-04
5476	50	34	0	logic_id=239		BkwdLogicScript	2014-06-02 01:26:33-04
5477	50	35	0	logic_id=240		BkwdLogicScript	2014-06-02 01:26:33-04
5478	50	20	0	logic_id=262		BkwdLogicScript	2014-06-02 01:26:34-04
5479	50	21	0	logic_id=275		BkwdLogicScript	2014-06-02 01:26:34-04
5480	50	135	0	logic_id=439		BkwdLogicScript	2014-06-02 01:26:37-04
5481	50	13	0	logic_id=26		BkwdLogicScript	2014-06-02 01:27:02-04
5482	50	31	0	logic_id=99		BkwdLogicScript	2014-06-02 01:27:04-04
5483	50	30	0	logic_id=100		BkwdLogicScript	2014-06-02 01:27:04-04
5484	50	32	0	logic_id=66		BkwdLogicScript	2014-06-02 01:28:49-04
5485	50	29	0	logic_id=95		BkwdLogicScript	2014-06-02 01:28:49-04
5486	50	28	0	logic_id=97		BkwdLogicScript	2014-06-02 01:28:50-04
5487	50	27	0	logic_id=64		BkwdLogicScript	2014-06-02 01:29:09-04
5488	50	26	0	logic_id=65		BkwdLogicScript	2014-06-02 01:29:09-04
5489	49	102	1	logic_id=13		FwdLogicScript	2014-12-27 09:35:16.462691-05
5490	49	92	1	logic_id=14		FwdLogicScript	2014-12-27 09:35:16.536757-05
5491	49	103	1	logic_id=15		FwdLogicScript	2014-12-27 09:35:16.606045-05
5492	49	93	1	logic_id=16		FwdLogicScript	2014-12-27 09:35:16.657952-05
5493	48	109	1	logic_id=160		FwdLogicScript	2014-12-27 09:35:26.682856-05
5494	38	128	1	logic_id=404		FwdLogicScript	2014-12-27 09:35:31.714651-05
5495	47	71	0	logic_id=475		BkwdLogicScript	2014-12-27 09:52:39.742065-05
5496	47	78	0	logic_id=462		BkwdLogicScript	2014-12-27 09:52:41.075077-05
5497	47	77	0	logic_id=460		BkwdLogicScript	2014-12-27 09:52:41.275693-05
5498	47	24	0	logic_id=409		BkwdLogicScript	2014-12-27 09:52:45.829089-05
5499	47	72	0	logic_id=149		BkwdLogicScript	2014-12-27 09:52:55.325256-05
5500	47	22	0	logic_id=123		BkwdLogicScript	2014-12-27 09:52:59.327349-05
5501	51	1	1	The monoid and field are commutative, so the monoid ring is also	Obvious	rschwiebert	2015-01-14 19:20:36.150758-05
5502	51	81	1	 	N.C. Norton, Generalizations of the theory of quasi-Frobenius rings p  113	rschwiebert	2015-01-14 19:21:58.344926-05
5503	51	50	0	 	N.C. Norton, Generalizations of the theory of quasi-Frobenius rings p  113	rschwiebert	2015-01-14 19:22:33.194758-05
5504	51	67	1	logic_id=2		FwdLogicScript	2015-01-14 19:33:52.361768-05
5505	51	100	1	logic_id=4		FwdLogicScript	2015-01-14 19:33:53.028228-05
5506	51	106	1	logic_id=155		FwdLogicScript	2015-01-14 19:34:05.798443-05
5507	51	130	1	logic_id=201		FwdLogicScript	2015-01-14 19:34:08.21113-05
5508	51	68	1	logic_id=3		FwdLogicScript	2015-01-14 19:34:08.871815-05
5509	51	99	1	logic_id=5		FwdLogicScript	2015-01-14 19:34:08.921418-05
5510	51	101	1	logic_id=6		FwdLogicScript	2015-01-14 19:34:08.97872-05
5511	51	128	1	logic_id=403		FwdLogicScript	2015-01-14 19:34:11.205979-05
5512	51	52	1	logic_id=142		FwdLogicScript	2015-01-14 19:34:13.066774-05
5513	51	62	1	logic_id=1		FwdLogicScript	2015-01-14 19:34:13.233832-05
5514	51	61	1	logic_id=516		FwdLogicScript	2015-01-14 19:34:13.360859-05
5515	51	89	1	logic_id=471		FwdLogicScript	2015-01-14 19:34:13.630489-05
5516	51	129	1	logic_id=401		FwdLogicScript	2015-01-14 19:34:13.833526-05
5517	51	107	1	logic_id=156		FwdLogicScript	2015-01-14 19:34:14.92764-05
5518	51	116	1	logic_id=263		FwdLogicScript	2015-01-14 21:45:48.127235-05
5519	51	64	1	logic_id=116		FwdLogicScript	2015-01-14 21:45:51.362113-05
5520	51	46	0	logic_id=131		BkwdLogicScript	2015-01-15 10:57:18.524241-05
5521	51	45	0	logic_id=110		BkwdLogicScript	2015-01-15 11:02:27.00256-05
5522	51	44	0	logic_id=74		BkwdLogicScript	2015-01-15 11:04:05.557885-05
5523	51	8	0	logic_id=40		BkwdLogicScript	2015-01-15 11:15:32.212734-05
5524	51	135	0	logic_id=19		BkwdLogicScript	2015-01-15 11:15:37.205139-05
5525	51	6	0	logic_id=17		BkwdLogicScript	2015-01-15 11:30:05.836427-05
5526	51	37	0	logic_id=231		BkwdLogicScript	2015-01-15 11:30:06.140417-05
5527	51	36	0	logic_id=232		BkwdLogicScript	2015-01-15 11:30:06.159211-05
5528	51	10	0	logic_id=352		BkwdLogicScript	2015-01-15 11:30:06.41348-05
5529	51	33	0	logic_id=423		BkwdLogicScript	2015-01-15 11:30:06.626674-05
5530	51	98	0	logic_id=502		BkwdLogicScript	2015-01-15 11:30:06.758323-05
5531	51	7	0	logic_id=504		BkwdLogicScript	2015-01-15 11:30:06.778539-05
5532	51	96	0	logic_id=510		BkwdLogicScript	2015-01-15 11:30:07.513775-05
5533	51	94	0	logic_id=214		BkwdLogicScript	2015-01-15 11:37:44.514425-05
5534	51	17	0	logic_id=216		BkwdLogicScript	2015-01-15 11:37:44.556659-05
5535	51	16	0	logic_id=248		BkwdLogicScript	2015-01-15 11:37:44.687459-05
5536	51	24	0	logic_id=408		BkwdLogicScript	2015-01-15 11:37:45.098272-05
5537	51	25	0	logic_id=410		BkwdLogicScript	2015-01-15 11:37:45.10658-05
5538	51	23	0	logic_id=427		BkwdLogicScript	2015-01-15 11:37:45.162843-05
5539	51	95	0	logic_id=213		BkwdLogicScript	2015-01-15 11:37:45.688047-05
5540	51	22	0	logic_id=426		BkwdLogicScript	2015-01-15 11:37:46.038268-05
5541	47	23	0	symmetry		SymmScript	2015-01-15 12:26:45.605074-05
5542	47	25	0	symmetry		SymmScript	2015-01-15 12:26:45.918371-05
5543	51	47	0	symmetry		SymmScript	2015-01-15 12:26:45.92089-05
5544	51	51	0	symmetry		SymmScript	2015-01-15 12:26:45.953374-05
5545	51	53	1	symmetry		SymmScript	2015-01-15 12:26:45.966808-05
5546	51	82	1	symmetry		SymmScript	2015-01-15 12:26:45.969525-05
5547	51	117	1	symmetry		SymmScript	2015-01-15 12:26:45.989455-05
5548	51	120	0	logic_id=335		BkwdLogicScript	2015-01-15 12:31:39.78535-05
5549	51	121	0	logic_id=338		BkwdLogicScript	2015-01-15 12:31:39.924825-05
5550	51	4	0	logic_id=383		BkwdLogicScript	2015-01-15 12:31:40.039575-05
5551	51	2	0	logic_id=9		BkwdLogicScript	2015-01-15 12:31:40.269392-05
5552	51	18	0	logic_id=71		BkwdLogicScript	2015-01-15 12:31:40.327844-05
5553	51	5	0	logic_id=384		BkwdLogicScript	2015-01-15 12:31:40.676085-05
5554	51	3	0	logic_id=11		BkwdLogicScript	2015-01-15 12:31:48.695013-05
5555	51	19	0	logic_id=251		BkwdLogicScript	2015-01-15 12:31:49.10905-05
5556	51	63	0	logic_id=498		BkwdLogicScript	2015-01-15 12:31:49.78603-05
5557	52	1	1	is a product of commutative rings	rschwiebert	\N	2015-02-01 20:29:31.004769-05
5558	52	13	1	is a product of strongly regular rings	rschwiebert	\N	2015-02-01 20:32:06.715298-05
5559	52	5	0	the rings in the product can be used to build an increasing sequence of ideals	rschwiebert	\N	2015-02-01 20:38:13.387695-05
\.


--
-- Name: ring_property_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('ring_property_id_seq', 5559, true);


--
-- Name: ringapp_invariance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('ringapp_invariance_id_seq', 38, true);


--
-- Name: ringapp_invarianttype_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('ringapp_invarianttype_type_id_seq', 9, true);


--
-- Data for Name: rings_keywords; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY rings_keywords (id, ring_id, keyword_id) FROM stdin;
2	50	2
3	50	3
4	49	2
5	49	3
6	48	1
7	47	2
8	47	3
9	46	4
10	46	5
11	45	6
12	44	8
13	44	7
14	43	9
15	51	10
20	52	11
\.


--
-- Name: rings_keywords_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('rings_keywords_id_seq', 20, true);


--
-- Data for Name: rings_reference; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY rings_reference (id, ring_id, citation_id) FROM stdin;
5	52	8
\.


--
-- Name: rings_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('rings_reference_id_seq', 5, true);


--
-- Name: rings_ring_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('"rings_ring_ID_seq"', 52, true);


--
-- Data for Name: test_rings; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY test_rings ("ring_ID", name, description) FROM stdin;
\.


--
-- Data for Name: test_ring_property; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY test_ring_property (id, has_property, reason, source, "property_ID", "ring_ID", poster, "time") FROM stdin;
\.


--
-- Name: test_ring_property_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('test_ring_property_id_seq', 292, true);


--
-- Name: test_rings_ring_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('"test_rings_ring_ID_seq"', 34, true);


--
-- Data for Name: theorems_reference; Type: TABLE DATA; Schema: public; Owner: ryan
--

COPY theorems_reference (id, theorem_id, citation_id) FROM stdin;
2	1	5
3	1	7
4	2	9
5	3	10
6	4	11
7	5	12
8	6	13
9	7	14
10	8	15
\.


--
-- Name: theorems_reference_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('theorems_reference_id_seq', 10, true);


--
-- Name: theorems_theorem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ryan
--

SELECT pg_catalog.setval('theorems_theorem_id_seq', 8, true);


--
-- PostgreSQL database dump complete
--

