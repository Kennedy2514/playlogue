--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: admin
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO admin;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: admin
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: game_genre; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.game_genre (
    gameid integer NOT NULL,
    genreid integer NOT NULL
);


ALTER TABLE public.game_genre OWNER TO admin;

--
-- Name: game_platform; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.game_platform (
    gameid integer NOT NULL,
    platformid integer NOT NULL
);


ALTER TABLE public.game_platform OWNER TO admin;

--
-- Name: games; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.games (
    gameid integer NOT NULL,
    title character varying(255) NOT NULL,
    release_date date,
    cover text
);


ALTER TABLE public.games OWNER TO admin;

--
-- Name: games_gameid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.games_gameid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.games_gameid_seq OWNER TO admin;

--
-- Name: games_gameid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.games_gameid_seq OWNED BY public.games.gameid;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.genres (
    genreid integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.genres OWNER TO admin;

--
-- Name: genres_genreid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.genres_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.genres_genreid_seq OWNER TO admin;

--
-- Name: genres_genreid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.genres_genreid_seq OWNED BY public.genres.genreid;


--
-- Name: platform; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.platform (
    platformid integer NOT NULL,
    name character varying(50)
);


ALTER TABLE public.platform OWNER TO admin;

--
-- Name: platform_platformid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.platform_platformid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.platform_platformid_seq OWNER TO admin;

--
-- Name: platform_platformid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.platform_platformid_seq OWNED BY public.platform.platformid;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.reviews (
    reviewid integer NOT NULL,
    userid integer,
    gameid integer,
    content text,
    rating smallint,
    date_posted timestamp without time zone DEFAULT now(),
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO admin;

--
-- Name: reviews_reviewid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.reviews_reviewid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_reviewid_seq OWNER TO admin;

--
-- Name: reviews_reviewid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.reviews_reviewid_seq OWNED BY public.reviews.reviewid;


--
-- Name: user_favorites; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_favorites (
    userid integer NOT NULL,
    gameid integer NOT NULL
);


ALTER TABLE public.user_favorites OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    password text NOT NULL
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_userid_seq OWNER TO admin;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;


--
-- Name: games gameid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.games ALTER COLUMN gameid SET DEFAULT nextval('public.games_gameid_seq'::regclass);


--
-- Name: genres genreid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.genres ALTER COLUMN genreid SET DEFAULT nextval('public.genres_genreid_seq'::regclass);


--
-- Name: platform platformid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.platform ALTER COLUMN platformid SET DEFAULT nextval('public.platform_platformid_seq'::regclass);


--
-- Name: reviews reviewid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reviews ALTER COLUMN reviewid SET DEFAULT nextval('public.reviews_reviewid_seq'::regclass);


--
-- Name: users userid; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);


--
-- Data for Name: game_genre; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.game_genre (gameid, genreid) FROM stdin;
1	1
2	1
2	4
3	6
3	9
4	6
5	1
6	1
6	9
7	6
7	1
8	1
8	4
9	1
10	6
10	1
11	6
11	1
11	4
12	3
13	6
13	1
14	1
15	1
15	4
16	6
16	1
17	3
17	1
17	9
17	2
17	11
18	6
18	1
19	6
19	1
20	6
20	1
20	4
21	11
21	2
21	1
22	12
22	1
23	6
23	12
23	1
23	4
24	1
25	13
25	2
25	14
26	1
26	4
27	6
27	1
28	1
29	1
30	6
30	1
31	6
31	1
32	1
33	1
33	4
34	3
34	1
35	11
35	2
35	1
36	11
36	3
36	1
37	1
37	4
38	2
38	4
38	8
40	6
40	1
40	8
41	2
41	6
41	10
41	1
42	2
42	1
43	1
43	4
44	6
44	1
45	2
45	12
45	1
45	4
46	6
46	3
46	1
47	2
47	3
47	1
48	6
48	1
49	6
49	1
51	3
51	1
52	3
52	1
53	6
53	1
53	4
54	6
54	1
54	4
55	6
55	1
55	4
56	1
56	4
58	5
59	3
59	1
59	4
62	1
63	6
63	1
64	11
64	2
65	12
65	1
66	3
66	1
67	1
68	6
68	3
68	1
69	3
69	1
70	6
71	6
71	1
72	6
72	1
73	1
73	4
74	6
74	1
75	6
75	1
75	4
76	6
76	1
77	3
77	1
78	6
78	1
79	1
79	15
80	1
80	4
81	2
81	3
81	1
81	4
82	6
82	1
83	1
83	4
84	1
84	7
84	14
84	2
84	12
85	3
85	1
85	4
86	3
86	1
87	2
87	3
87	1
87	4
88	1
88	10
88	8
88	2
88	12
89	6
89	1
90	1
90	4
91	3
91	1
91	4
91	2
91	12
92	6
92	3
92	1
93	6
93	1
94	5
94	8
95	16
95	2
95	3
96	2
96	1
97	5
98	2
98	4
99	3
99	1
99	4
99	15
99	11
100	5
100	1
651	2
651	3
651	1
201	6
201	1
202	6
202	1
203	3
203	1
204	3
204	1
205	11
205	1
206	6
206	1
207	3
207	1
208	3
208	1
208	9
208	2
208	11
209	1
209	4
210	6
210	1
211	3
211	1
213	2
213	3
216	3
216	1
217	1
218	6
218	1
219	6
219	12
219	1
220	1
222	11
222	2
222	1
223	1
224	2
224	3
224	4
225	1
225	4
226	6
226	1
227	7
227	1
227	8
229	5
229	8
230	6
230	3
230	1
231	2
231	1
231	4
232	2
232	3
233	3
234	13
234	10
235	6
235	1
236	6
237	6
237	1
238	5
238	4
239	2
239	3
240	6
240	2
240	1
241	3
241	1
241	4
241	5
241	8
241	12
242	6
242	1
243	2
243	3
243	1
244	5
245	5
245	8
246	11
246	3
247	2
247	3
247	1
248	3
248	1
248	4
249	1
701	2
701	3
701	8
702	6
702	1
703	3
703	1
704	3
704	1
705	6
705	1
706	1
707	5
707	2
707	4
708	6
708	1
709	6
709	3
709	1
710	6
710	1
711	6
711	1
712	11
712	2
712	1
712	4
713	19
713	2
713	8
713	9
714	3
714	1
714	9
715	1
715	4
716	5
716	4
717	6
717	1
717	4
718	3
718	1
719	2
719	3
720	3
720	4
721	3
721	1
721	9
721	2
721	11
722	3
722	1
723	13
723	8
723	14
724	2
724	1
725	5
725	2
725	4
726	1
726	4
727	6
727	1
730	6
730	1
731	2
731	1
732	2
732	1
732	4
733	4
734	3
734	9
735	3
735	1
736	6
736	1
737	11
738	1
739	1
740	1
740	4
741	6
741	4
742	3
742	1
743	1
744	1
744	4
745	6
745	2
745	1
746	6
747	2
747	3
749	6
750	6
750	1
250	2
250	6
250	10
250	1
251	3
251	9
252	5
252	2
252	8
253	11
253	3
253	1
254	2
254	3
254	9
255	11
255	2
255	1
256	2
256	8
257	5
257	1
257	4
258	5
258	2
258	8
259	6
259	3
259	1
259	4
260	6
260	1
261	13
261	10
262	5
262	8
263	3
263	1
264	3
264	1
264	4
265	3
265	9
266	3
266	7
266	10
266	2
266	11
267	6
267	3
267	1
267	4
268	1
269	1
269	4
270	3
270	1
271	3
271	1
271	4
271	7
271	2
273	3
273	1
274	6
274	1
274	4
275	5
275	8
276	6
276	1
277	6
277	1
278	11
278	2
279	6
279	1
280	1
282	6
282	2
282	1
283	5
283	4
284	1
285	1
286	3
286	1
287	1
288	1
290	7
290	2
290	10
290	8
291	3
291	1
291	4
292	6
292	3
292	1
293	2
293	1
293	9
294	6
294	3
294	1
294	4
295	2
295	3
296	3
296	1
297	3
297	1
298	6
298	1
299	5
300	4
301	2
301	3
301	1
301	8
302	5
302	8
303	6
303	1
304	2
304	1
305	1
305	4
306	3
306	1
306	15
307	6
307	1
308	2
308	8
309	3
309	4
310	5
310	2
310	8
311	2
311	5
311	3
311	4
313	3
313	1
313	9
313	2
313	11
314	2
314	1
315	7
315	2
315	1
315	4
316	16
316	3
316	1
317	2
317	6
317	5
317	1
318	1
318	9
318	10
318	2
318	11
319	1
320	1
322	13
323	12
323	1
323	4
324	6
324	1
325	11
325	3
325	1
326	6
326	2
326	1
327	3
327	1
328	1
329	6
329	2
329	1
330	3
330	1
330	4
331	1
331	4
332	11
332	2
332	1
333	11
333	1
333	14
334	3
334	1
334	7
334	2
334	11
335	7
335	5
335	2
336	2
336	3
336	8
336	9
337	18
337	5
337	2
337	4
339	2
339	1
340	5
340	8
341	2
341	3
341	4
342	6
342	1
343	3
343	9
343	7
343	16
343	2
344	2
344	3
344	8
345	3
346	2
346	4
347	6
347	12
347	1
348	6
348	1
349	6
349	1
400	3
401	6
401	1
402	2
402	3
402	1
403	3
403	1
404	1
404	15
405	1
405	4
406	5
406	2
406	1
407	6
407	1
408	3
408	1
409	7
409	2
409	1
410	6
410	3
410	1
411	6
411	3
411	1
412	3
413	1
413	4
414	6
414	1
416	6
416	1
417	2
417	3
418	11
418	5
418	2
418	1
420	5
420	2
420	1
421	6
421	1
422	16
422	11
422	10
422	1
423	6
423	1
424	11
424	2
424	1
425	2
425	8
426	7
426	2
426	3
427	1
427	4
428	6
428	1
429	11
429	2
429	1
430	6
430	10
430	1
431	1
431	15
431	14
432	2
432	11
432	3
432	1
433	2
433	11
433	3
433	1
434	6
434	3
434	1
435	6
435	1
436	5
437	1
437	4
438	3
438	1
439	3
439	1
439	9
439	7
439	10
439	2
439	11
440	19
440	2
440	1
440	8
441	6
441	1
442	2
442	1
443	11
443	2
443	1
443	4
444	1
444	8
444	14
445	3
445	1
445	4
446	6
446	1
447	4
448	6
448	2
448	1
449	1
449	4
450	10
450	1
451	3
451	1
451	4
452	3
452	1
454	7
454	5
454	3
454	1
455	6
455	1
456	3
456	1
456	9
456	2
456	11
457	10
457	3
457	1
458	6
458	1
459	2
459	1
459	4
460	6
460	1
461	1
462	5
462	2
462	4
463	2
463	1
463	4
464	6
464	12
464	1
465	5
465	4
466	2
466	1
467	3
467	1
467	4
467	8
467	12
468	2
468	3
468	1
469	13
469	10
470	1
470	4
472	1
473	3
473	1
473	9
473	10
473	11
474	16
474	2
474	3
475	5
475	12
475	1
475	4
476	11
476	10
477	6
477	3
477	1
478	5
478	4
478	8
480	13
480	1
480	7
480	14
480	2
481	1
481	4
482	5
482	4
482	8
483	6
483	1
483	4
484	6
484	1
485	12
485	1
485	4
486	5
486	1
486	8
487	7
487	5
487	3
487	9
488	1
488	4
489	11
489	2
489	1
490	3
490	9
491	2
491	3
491	1
492	1
492	4
493	3
493	1
493	4
494	13
494	10
495	1
495	4
496	2
496	1
497	5
497	2
497	8
497	9
498	3
498	4
499	2
499	11
499	3
499	1
500	11
500	3
500	9
501	5
501	2
501	1
501	4
502	6
502	1
503	2
503	5
503	3
503	4
504	1
504	15
505	6
505	3
505	1
505	10
505	2
506	5
506	8
507	2
507	3
507	1
507	4
508	6
508	1
509	16
509	8
510	5
510	4
511	7
511	5
511	2
511	8
512	6
512	1
513	6
514	3
514	1
514	4
514	5
514	2
515	3
515	9
515	7
515	8
515	2
516	6
516	1
517	16
517	11
517	10
517	1
518	1
518	4
519	13
519	10
519	1
519	2
520	13
520	8
520	14
521	12
521	4
522	7
522	6
522	12
522	1
524	6
524	1
525	5
525	2
525	1
526	2
526	6
526	3
526	1
527	3
527	1
528	3
528	1
529	5
529	2
529	1
529	8
531	1
532	6
532	1
533	3
533	1
534	2
534	3
534	1
534	8
535	7
535	10
536	5
536	4
537	3
537	1
538	2
538	3
538	8
538	9
539	3
539	1
540	2
540	1
540	4
541	2
542	2
542	1
543	13
543	10
544	5
544	1
544	4
545	6
545	1
546	5
546	2
546	4
547	11
547	3
547	1
547	9
548	2
548	3
548	1
548	4
549	6
549	1
550	3
550	4
281	6
281	3
281	1
350	1
350	6
351	4
351	5
351	17
351	18
352	1
352	3
352	7
352	11
354	1
354	3
355	1
355	8
355	2
356	4
357	3
357	2
357	9
358	1
358	6
358	3
358	5
359	1
359	3
360	1
360	6
360	3
361	4
361	5
361	2
362	3
362	2
362	9
362	11
363	2
363	11
364	1
364	3
365	1
365	3
365	4
366	1
366	6
367	1
367	6
367	3
367	12
368	1
368	4
368	2
368	11
369	1
369	4
369	7
370	3
370	4
370	2
370	9
371	1
371	6
372	3
372	2
372	9
374	1
374	4
374	2
374	11
375	13
375	10
376	1
376	6
377	1
378	1
378	6
378	3
379	1
379	3
379	4
380	6
381	3
382	1
382	3
383	3
383	9
384	3
384	16
384	2
384	9
385	1
385	6
386	4
387	6
387	4
388	1
388	6
389	1
389	3
389	2
389	9
389	11
390	5
390	2
391	6
391	4
392	1
392	6
393	3
394	1
394	6
395	1
395	4
396	15
397	1
398	5
398	19
398	16
398	2
398	9
399	6
\.


--
-- Data for Name: game_platform; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.game_platform (gameid, platformid) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	14
1	16
2	1
2	2
2	3
2	4
2	5
2	6
2	12
3	1
3	3
3	12
3	13
3	14
3	16
4	1
4	13
4	14
4	16
5	1
5	3
5	4
5	12
5	14
5	16
6	1
6	6
6	8
6	12
6	13
6	14
6	16
7	1
7	12
7	13
7	14
8	1
8	2
8	3
8	4
8	5
8	6
8	14
8	16
9	1
9	3
9	4
10	1
10	8
10	12
10	13
10	14
10	15
11	1
11	8
11	12
11	13
11	14
11	16
11	19
12	1
12	4
12	3
12	7
12	8
12	12
12	13
12	14
12	16
13	1
13	2
13	3
13	4
13	5
13	51
14	1
14	4
15	1
15	2
15	3
15	4
16	1
16	3
16	13
17	1
17	3
17	4
17	6
17	7
17	8
17	12
17	13
17	14
17	16
17	19
18	1
18	12
18	13
19	1
19	3
19	4
19	6
20	1
20	2
20	3
20	4
20	5
20	6
21	1
21	3
21	4
21	6
21	7
21	8
21	9
21	12
21	13
21	14
21	16
21	19
21	21
22	1
22	12
22	13
23	1
23	2
23	3
23	4
23	5
23	6
23	7
24	1
24	3
24	14
24	16
25	1
25	3
25	4
25	6
25	12
25	13
26	1
26	4
27	1
27	14
28	1
28	3
28	4
28	12
29	1
29	3
29	4
29	6
30	1
30	3
30	4
30	14
30	16
31	1
31	3
31	4
31	6
31	12
32	1
32	3
32	4
32	7
32	8
32	12
32	14
32	15
32	16
32	17
33	1
33	4
33	3
33	12
33	13
33	14
33	16
34	1
34	4
34	3
34	6
34	7
34	8
34	12
34	14
34	16
34	19
35	1
35	3
35	4
35	6
35	12
35	13
36	1
36	3
36	4
36	6
36	7
37	1
37	3
37	4
38	1
38	3
38	4
38	6
38	7
38	8
38	12
38	13
38	19
40	1
40	3
40	4
40	12
40	13
41	1
41	3
41	4
41	6
41	13
41	19
42	1
42	3
42	4
42	6
42	12
42	13
43	1
43	3
43	4
43	12
43	13
44	1
44	3
44	4
44	14
44	16
45	1
45	3
45	4
46	1
46	3
46	14
47	1
47	12
47	13
48	1
48	3
48	4
48	14
48	16
49	1
49	3
49	14
49	16
51	1
51	3
51	13
51	14
51	16
52	1
52	4
53	1
53	3
53	4
54	1
54	3
54	4
54	14
54	16
55	1
55	14
55	16
56	1
56	3
56	4
58	1
58	12
58	13
59	1
59	3
59	4
59	14
59	16
62	1
62	4
62	7
62	8
62	12
62	15
62	17
62	19
63	1
63	3
63	4
63	12
63	14
63	16
64	1
64	4
64	6
64	8
64	12
64	13
64	14
64	19
64	21
64	51
65	1
65	3
65	4
66	1
66	3
66	4
66	6
66	14
66	16
67	1
67	4
67	3
67	6
67	14
67	16
67	21
68	1
68	2
68	3
68	4
68	5
69	1
69	2
69	3
69	4
70	1
70	12
70	13
71	1
71	3
71	14
71	16
72	2
72	4
73	1
73	3
73	14
73	16
74	1
74	3
74	4
75	1
75	8
75	12
75	13
75	14
75	16
76	1
76	12
76	13
76	15
77	1
77	4
78	1
78	12
78	14
79	1
79	3
79	4
80	1
80	3
80	4
80	6
81	1
81	2
81	3
81	4
81	5
81	6
82	1
82	3
82	14
82	16
83	1
83	3
83	14
83	16
84	1
84	3
84	4
84	5
84	6
85	1
85	3
85	4
86	1
86	3
86	4
86	12
86	13
86	14
87	1
87	4
87	3
87	6
87	7
87	12
87	13
87	14
87	19
88	1
88	3
88	4
88	6
88	7
88	8
88	9
88	12
88	13
88	14
88	16
88	19
88	21
89	1
89	3
89	4
89	6
89	12
90	1
90	3
90	4
90	8
91	1
91	3
91	4
91	6
91	7
91	12
91	13
92	1
92	3
92	4
92	6
92	12
93	1
93	3
93	4
94	1
94	3
94	4
94	6
94	12
94	13
95	1
95	4
95	7
95	16
96	1
96	3
96	4
97	1
97	7
97	8
97	12
97	14
97	16
98	1
98	4
98	3
98	5
98	6
98	12
98	13
98	19
99	1
99	3
99	4
99	6
99	12
99	13
100	1
100	3
100	7
100	12
100	13
100	14
100	16
651	1
651	4
651	3
651	6
651	7
651	8
651	14
651	16
201	1
201	3
201	14
201	16
202	1
202	3
202	4
203	1
203	3
203	4
203	14
203	16
203	21
204	1
204	3
204	4
204	12
204	13
205	1
205	4
205	3
205	7
205	12
205	13
205	14
205	15
205	16
205	17
206	1
206	2
206	3
206	4
207	1
207	4
207	16
208	1
208	3
208	4
208	6
208	7
208	12
209	1
209	3
209	4
210	1
210	12
210	14
210	16
211	1
211	3
211	4
211	13
211	14
211	16
213	1
213	3
213	4
213	6
213	12
213	13
216	1
216	3
216	4
216	6
216	7
216	8
217	1
217	3
217	12
217	14
217	16
218	1
218	3
218	4
219	1
219	3
219	4
219	12
219	13
220	1
220	3
220	6
220	14
220	16
222	1
222	3
222	4
222	6
222	12
223	1
223	8
223	14
223	16
224	1
224	2
224	3
224	4
224	5
224	6
224	12
225	1
225	2
225	3
225	4
225	5
226	1
226	2
226	3
226	4
226	6
227	1
227	2
227	4
227	3
227	6
227	7
227	8
229	1
229	12
229	13
230	1
230	3
230	5
231	1
231	4
231	6
231	7
231	12
231	13
232	1
232	3
232	4
232	7
232	12
232	13
233	1
233	4
233	3
233	7
233	8
233	12
233	14
233	19
234	1
234	12
234	14
234	16
235	1
235	3
235	4
236	1
236	3
236	4
236	14
236	16
237	1
237	3
237	4
237	6
237	14
237	16
238	1
238	4
238	6
238	12
238	13
239	1
239	12
239	13
240	1
240	12
240	13
241	1
241	3
241	4
242	1
242	3
242	13
242	14
242	16
243	1
243	12
243	13
244	1
244	12
244	13
245	1
245	3
245	4
245	6
245	7
245	12
245	13
246	1
246	3
246	14
247	1
247	3
247	4
247	12
247	13
248	1
248	3
248	4
249	1
249	3
249	4
249	14
249	16
249	21
701	1
701	6
701	7
701	8
701	12
701	13
701	19
702	1
702	3
702	6
702	14
702	16
703	1
703	3
703	4
703	12
703	14
703	16
704	1
704	3
704	4
705	1
705	3
705	4
705	6
705	14
705	16
706	1
706	12
706	13
707	1
707	7
707	8
707	12
707	13
708	1
708	4
708	7
708	8
708	12
708	15
708	17
709	2
709	4
710	1
710	3
710	4
710	6
711	1
711	3
711	4
711	14
711	16
712	1
712	3
712	4
712	6
712	7
712	12
712	13
713	1
713	7
713	8
713	12
713	13
713	19
714	1
714	3
714	4
715	1
715	8
716	1
716	3
716	4
716	6
717	1
717	14
717	16
718	4
718	16
719	1
719	2
719	3
719	4
719	5
719	6
719	12
720	1
720	3
720	4
720	6
720	14
720	16
721	1
721	4
721	6
721	7
721	12
721	13
721	14
721	16
721	19
722	1
722	2
722	3
722	4
722	5
722	6
723	1
723	3
723	4
723	12
723	13
724	1
724	6
724	12
724	14
724	16
725	1
725	4
725	3
725	6
725	12
725	13
725	19
726	1
726	3
726	6
726	7
726	8
726	12
726	14
726	15
727	1
727	4
727	7
727	8
727	17
727	22
727	23
730	1
730	3
730	7
730	10
730	12
730	14
730	16
730	22
731	1
731	4
731	3
731	12
731	13
731	14
731	16
732	1
732	12
733	1
733	3
733	12
733	14
733	16
734	1
734	6
734	7
734	8
734	10
734	12
734	14
734	16
735	1
735	3
735	4
735	14
735	16
736	1
736	3
736	14
736	16
737	1
737	3
737	4
737	6
737	14
737	16
737	19
737	21
738	1
738	2
738	3
738	4
739	1
739	3
739	4
739	6
739	12
739	14
739	16
740	1
740	3
740	4
740	16
741	1
741	3
741	14
741	16
742	1
742	4
742	16
743	1
743	4
744	1
744	3
744	4
744	6
744	12
744	13
745	1
745	4
745	3
745	6
745	12
745	13
745	51
746	1
746	3
746	4
746	14
746	16
747	1
747	3
747	4
747	6
747	7
749	1
749	14
749	16
750	1
750	3
750	4
250	1
250	4
250	6
250	7
250	8
250	12
250	13
250	16
250	19
251	1
251	3
251	4
251	6
251	7
251	8
251	12
251	13
251	19
252	1
252	7
252	12
252	13
253	1
253	3
253	5
253	6
254	1
254	3
254	4
254	7
254	8
254	12
255	1
255	4
255	6
255	12
255	13
256	1
256	12
256	13
257	1
257	3
257	4
257	14
257	16
258	1
258	12
258	13
259	1
259	3
259	4
259	6
260	1
260	3
260	7
260	12
260	14
260	16
260	22
261	1
261	3
261	5
262	1
262	3
262	4
262	12
262	13
263	1
263	4
263	3
263	6
263	7
263	8
263	12
263	14
263	16
263	19
264	6
264	21
265	1
265	6
265	7
265	8
265	12
265	14
265	15
265	16
265	17
266	1
266	12
266	13
267	1
267	2
267	3
267	4
267	5
267	6
268	1
268	3
268	4
268	6
268	12
269	1
269	3
269	12
269	14
269	16
270	1
270	14
270	16
271	1
271	6
271	7
271	8
271	12
271	13
273	1
273	4
273	3
273	6
273	14
273	16
273	21
274	1
274	3
274	4
275	1
275	3
275	4
275	6
276	1
276	14
276	16
277	1
277	3
277	14
277	16
277	21
278	1
278	3
278	4
278	6
278	12
278	13
279	1
279	16
280	1
280	3
280	8
280	14
280	16
282	1
282	13
283	1
283	12
283	13
284	4
285	1
285	2
285	3
285	4
285	6
286	1
286	7
286	8
286	9
286	10
286	14
286	16
286	19
286	22
287	1
287	3
287	4
287	6
287	12
287	14
287	16
288	1
288	15
288	17
290	1
290	3
290	4
290	6
291	1
291	2
291	4
292	1
292	3
292	4
293	1
293	3
293	4
293	6
293	7
293	8
293	12
293	13
294	1
294	3
294	4
294	5
294	6
295	1
295	12
295	13
296	1
296	3
296	4
297	4
297	16
298	1
298	4
298	14
298	15
298	16
298	17
299	1
299	7
300	1
300	3
300	4
301	1
301	3
301	4
301	6
301	12
301	13
302	1
302	3
302	12
302	14
303	1
303	4
303	14
303	15
303	16
303	17
303	30
304	1
304	4
304	12
304	19
305	1
305	3
305	4
305	6
305	7
305	9
305	12
305	13
305	19
305	21
306	1
306	2
306	3
306	4
306	5
306	6
307	1
307	3
307	4
308	1
308	12
308	13
309	1
309	6
309	8
309	12
309	13
309	14
309	15
310	1
310	3
310	4
310	6
310	12
310	13
311	1
311	3
311	4
311	6
311	7
311	8
311	12
311	13
313	1
313	2
313	3
313	4
313	5
313	6
313	12
314	1
314	3
314	4
314	6
314	12
314	13
315	1
315	12
315	13
316	1
316	4
316	3
316	9
316	12
316	14
316	16
316	19
316	21
317	1
317	12
317	13
317	14
317	16
318	1
318	3
318	7
318	12
318	13
318	14
318	16
319	1
319	3
319	4
320	1
322	1
322	3
322	10
322	14
322	16
323	1
323	3
323	4
324	1
324	14
324	16
325	1
325	2
325	3
325	4
325	5
325	6
326	1
326	3
326	4
326	6
326	12
326	13
327	1
327	4
327	3
327	6
327	14
327	16
327	19
328	1
328	3
328	4
328	12
328	14
328	16
329	1
329	12
329	13
329	14
329	16
330	1
330	3
330	4
330	7
330	8
331	1
331	6
331	14
331	16
331	21
332	1
332	6
332	12
332	13
332	14
333	1
333	7
333	8
333	14
333	16
333	19
333	25
333	46
334	1
334	3
334	12
334	13
334	14
335	1
335	3
335	4
335	6
335	12
336	1
336	7
336	8
336	12
336	13
337	1
337	3
337	4
337	6
337	7
337	8
337	12
337	13
339	1
339	2
339	4
340	1
340	12
340	13
341	1
341	3
341	4
341	6
341	7
341	8
341	12
341	13
342	1
342	3
342	14
342	16
343	1
343	3
343	4
343	6
343	7
343	8
343	12
343	13
343	19
344	1
344	3
344	4
344	6
345	1
345	3
345	4
345	6
345	7
345	8
345	12
345	14
345	16
346	1
346	3
346	4
346	6
346	14
346	16
346	19
346	21
347	1
347	4
348	1
348	14
348	16
349	1
349	14
349	16
400	1
400	3
401	1
401	3
401	5
402	1
402	3
402	4
402	6
403	1
403	14
403	15
403	16
403	17
403	20
403	23
404	1
404	4
405	1
405	2
405	5
406	1
406	12
406	13
407	1
407	14
407	16
408	1
408	3
408	4
408	6
408	9
408	14
408	16
408	21
409	1
409	3
409	4
409	6
409	12
409	13
410	1
410	3
410	4
411	1
411	3
412	1
412	4
412	3
412	7
412	8
412	12
412	13
413	1
413	3
413	12
413	13
413	14
414	1
414	3
414	4
414	10
414	12
414	14
414	16
414	22
416	1
416	3
416	4
416	6
416	12
416	14
416	15
417	1
417	4
417	6
417	7
417	12
417	13
418	1
418	12
418	13
418	14
418	16
420	1
421	1
422	1
422	3
422	4
422	9
422	14
422	16
423	1
423	14
423	16
424	1
424	3
424	6
424	12
425	1
425	3
425	4
425	12
425	13
426	1
426	3
426	4
426	6
426	12
426	13
426	16
426	21
427	1
427	15
428	1
428	3
428	14
428	16
429	1
429	14
430	1
430	3
430	4
430	6
431	1
431	3
431	4
432	1
432	3
432	4
432	6
432	12
432	13
433	1
433	12
433	13
433	14
433	16
434	1
434	3
434	4
435	1
435	14
435	15
435	17
436	1
437	1
437	3
437	4
438	2
438	4
439	1
439	4
439	6
439	7
439	8
439	9
439	12
439	13
439	19
440	1
440	4
440	6
440	7
440	8
440	12
440	13
441	1
441	14
441	16
442	1
442	3
442	4
443	1
443	3
443	4
444	1
444	3
444	4
445	1
445	12
445	13
446	4
446	16
447	1
447	3
447	14
447	16
448	1
449	1
449	3
449	4
450	1
450	3
450	4
450	6
451	1
451	2
451	4
451	6
451	7
451	8
452	1
452	12
452	14
452	16
454	1
454	3
454	4
454	14
454	16
455	1
456	1
456	3
456	4
456	6
456	9
456	12
456	13
456	19
456	21
457	1
457	3
457	4
457	14
457	16
458	1
458	4
458	3
458	6
458	12
458	13
458	15
459	1
459	3
459	5
460	1
460	3
460	4
461	1
461	3
461	4
462	1
462	3
462	4
462	6
462	7
462	8
462	12
462	13
463	1
463	4
463	3
463	6
463	7
463	12
463	13
463	19
464	1
464	3
464	4
464	14
465	1
466	1
466	3
466	4
466	12
466	13
467	1
467	3
467	4
467	12
468	1
468	3
468	4
468	6
469	1
469	3
469	4
470	1
470	3
470	12
470	13
470	14
470	16
472	1
472	3
472	4
472	14
472	16
473	1
473	3
473	4
473	6
473	14
474	1
474	3
474	4
474	6
474	7
474	8
474	12
474	13
474	16
474	19
474	21
475	1
475	12
475	13
476	6
477	1
477	4
477	6
477	12
477	15
477	23
477	30
478	1
478	4
478	12
478	13
478	14
480	1
480	3
480	4
480	6
480	12
480	13
481	1
481	3
481	4
482	1
482	4
482	7
482	12
482	13
483	1
483	14
483	16
484	1
484	3
484	4
485	1
485	3
485	4
486	1
487	1
487	7
487	8
487	9
487	21
488	1
488	14
489	1
489	4
489	3
489	6
489	12
489	13
489	19
490	1
490	3
490	4
490	6
491	1
491	3
491	4
491	6
491	7
491	8
491	12
491	13
492	1
492	6
493	1
493	3
493	4
493	6
494	1
494	6
494	7
494	8
494	14
494	16
494	22
495	1
495	14
496	1
496	4
497	1
497	8
497	12
497	13
498	1
498	3
498	4
498	6
499	1
499	3
499	4
499	6
499	9
499	12
499	13
499	19
500	4
500	16
501	1
502	1
502	3
502	4
502	7
502	12
502	13
503	1
503	3
503	4
503	6
503	7
503	12
504	1
504	14
504	16
505	1
505	3
505	4
505	6
505	7
506	1
506	14
507	1
507	3
507	4
507	6
507	7
507	12
507	13
508	1
508	14
508	15
508	16
508	17
508	22
509	1
510	1
510	12
511	1
511	6
511	12
511	13
512	1
512	3
512	4
512	6
512	12
512	13
513	1
513	12
513	14
513	16
514	1
514	4
514	6
514	12
515	1
515	3
515	4
515	6
516	1
516	3
516	14
516	16
517	1
517	3
517	7
517	9
517	12
517	14
517	16
517	19
517	22
518	1
519	1
519	3
519	4
519	7
519	12
519	13
519	16
519	19
519	21
519	51
520	1
520	3
520	4
521	1
522	1
522	3
522	4
522	6
524	1
524	3
524	4
524	14
524	16
525	1
525	14
526	1
526	3
526	14
526	16
527	1
527	3
527	4
527	6
528	1
528	15
528	16
528	17
528	23
529	1
529	7
529	8
529	12
529	13
529	14
529	16
531	1
531	4
531	16
532	1
532	2
532	3
532	4
532	6
532	14
532	15
533	1
533	3
533	7
533	8
533	10
533	12
533	14
533	16
533	22
534	1
534	3
534	4
534	6
534	12
534	13
535	1
535	3
535	4
535	6
536	1
536	12
536	13
537	1
537	3
537	4
537	6
537	7
537	8
538	1
538	7
538	8
538	12
539	1
539	3
539	14
539	16
540	1
540	3
540	12
541	1
542	1
542	15
543	1
543	3
543	4
543	14
543	16
544	1
544	6
544	16
545	1
545	3
545	14
546	1
546	6
546	8
546	12
547	1
547	3
547	4
547	6
548	1
548	3
548	4
548	6
548	12
548	13
549	1
549	3
549	4
550	1
550	4
550	6
550	12
281	4
350	16
350	4
350	14
350	3
351	3
351	7
351	1
351	4
351	8
352	4
352	3
352	1
352	6
354	1
354	16
354	14
354	8
354	7
355	12
355	3
355	6
355	1
355	4
356	14
356	15
356	1
357	3
357	4
357	7
357	1
357	12
357	13
357	6
357	8
358	3
358	1
358	4
359	5
359	1
359	7
359	2
359	6
359	3
359	4
360	1
360	3
360	4
360	16
360	14
361	4
361	12
361	1
361	3
362	8
362	12
362	1
362	7
362	3
362	2
362	5
362	4
362	6
363	16
363	14
363	1
363	4
363	19
364	14
364	22
364	12
364	1
364	10
364	16
365	4
365	1
365	3
365	6
366	16
366	3
366	1
366	14
367	1
367	3
367	4
368	4
368	14
368	1
368	7
368	16
368	19
368	6
369	1
369	12
369	13
369	14
370	6
370	7
370	1
370	12
370	4
370	3
370	13
371	15
371	20
371	17
371	1
372	4
372	6
372	3
372	1
374	14
374	7
374	1
374	12
374	13
374	6
374	4
375	14
375	1
375	16
376	1
376	15
376	17
377	13
377	12
377	1
378	2
378	5
378	1
378	4
378	6
378	3
379	16
379	4
380	1
380	16
380	14
381	4
381	13
381	12
381	1
381	6
381	3
382	1
382	4
382	6
382	3
383	16
383	14
383	6
383	1
383	7
383	8
383	3
383	4
384	16
384	4
384	19
384	3
384	7
384	1
384	8
384	13
384	6
384	12
385	14
385	1
385	16
386	4
386	3
386	12
386	1
386	13
387	5
387	4
387	1
387	3
387	6
388	16
388	14
388	1
389	21
389	3
389	12
389	19
389	1
389	13
389	16
389	4
390	3
390	4
390	12
390	1
390	13
391	1
391	4
391	3
391	6
391	5
392	1
392	17
392	16
392	14
392	15
392	23
393	4
393	3
393	1
394	16
394	1
394	14
394	3
395	16
395	3
395	1
395	21
395	14
396	8
396	4
396	1
396	3
396	7
397	12
397	1
397	13
398	8
398	7
398	1
398	12
398	13
398	6
398	22
399	14
399	1
399	16
399	10
399	3
399	22
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.games (gameid, title, release_date, cover) FROM stdin;
1	Grand Theft Auto V	2013-09-17	https://media.rawg.io/media/games/20a/20aa03a10cda45239fe22d035c0ebe64.jpg
2	The Witcher 3: Wild Hunt	2015-05-18	https://media.rawg.io/media/games/618/618c2031a07bbff6b4f611f10b6bcdbc.jpg
3	Portal 2	2011-04-18	https://media.rawg.io/media/games/2ba/2bac0e87cf45e5b508f227d281c9252a.jpg
4	Counter-Strike: Global Offensive	2012-08-21	https://media.rawg.io/media/games/736/73619bd336c894d6941d926bfd563946.jpg
5	Tomb Raider (2013)	2013-03-05	https://media.rawg.io/media/games/021/021c4e21a1824d2526f925eff6324653.jpg
6	Portal	2007-10-09	https://media.rawg.io/media/games/7fa/7fa0b586293c5861ee32490e953a4996.jpg
7	Left 4 Dead 2	2009-11-17	https://media.rawg.io/media/games/d58/d588947d4286e7b5e0e12e1bea7d9844.jpg
8	The Elder Scrolls V: Skyrim	2011-11-11	https://media.rawg.io/media/games/7cf/7cfc9220b401b7a300e409e539c9afd5.jpg
9	Red Dead Redemption 2	2018-10-26	https://media.rawg.io/media/games/511/5118aff5091cb3efec399c808f8c598f.jpg
10	Half-Life 2	2004-11-16	https://media.rawg.io/media/games/b8c/b8c243eaa0fbac8115e0cdccac3f91dc.jpg
11	Borderlands 2	2012-09-18	https://media.rawg.io/media/games/49c/49c3dfa4ce2f6f140cc4825868e858cb.jpg
12	Life is Strange	2015-01-29	https://media.rawg.io/media/games/562/562553814dd54e001a541e4ee83a591c.jpg
13	Destiny 2	2017-09-06	https://media.rawg.io/media/games/34b/34b1f1850a1c06fd971bc6ab3ac0ce0e.jpg
14	God of War (2018)	2018-04-20	https://media.rawg.io/media/games/4be/4be6a6ad0364751a96229c56bf69be59.jpg
15	Fallout 4	2015-11-09	https://media.rawg.io/media/games/d82/d82990b9c67ba0d2d09d4e6fa88885a7.jpg
16	PAYDAY 2	2013-08-13	https://media.rawg.io/media/games/73e/73eecb8909e0c39fb246f457b5d6cbbe.jpg
17	Limbo	2010-07-21	https://media.rawg.io/media/games/942/9424d6bb763dc38d9378b488603c87fa.jpg
18	Team Fortress 2	2007-10-10	https://media.rawg.io/media/games/46d/46d98e6910fbc0706e2948a7cc9b10c5.jpg
19	DOOM (2016)	2016-05-12	https://media.rawg.io/media/games/587/587588c64afbff80e6f444eb2e46f9da.jpg
20	Cyberpunk 2077	2020-12-10	https://media.rawg.io/media/games/26d/26d4437715bee60138dab4a7c8c59c92.jpg
21	Terraria	2011-05-16	https://media.rawg.io/media/games/f46/f466571d536f2e3ea9e815ad17177501.jpg
22	Dota 2	2013-07-09	https://media.rawg.io/media/games/6fc/6fcf4cd3b17c288821388e6085bb0fc9.jpg
23	Warframe	2013-03-25	https://media.rawg.io/media/games/f87/f87457e8347484033cb34cde6101d08d.jpg
24	Grand Theft Auto IV	2008-04-29	https://media.rawg.io/media/games/4a0/4a0a1316102366260e6f38fd2a9cfdce.jpg
25	Rocket League	2015-07-07	https://media.rawg.io/media/games/8cc/8cce7c0e99dcc43d66c8efd42f9d03e3.jpg
26	Horizon Zero Dawn	2017-02-28	https://media.rawg.io/media/games/b7d/b7d3f1715fa8381a4e780173a197a615.jpg
27	Metro 2033	2010-03-16	https://media.rawg.io/media/games/120/1201a40e4364557b124392ee50317b99.jpg
28	Rise of the Tomb Raider	2015-11-10	https://media.rawg.io/media/games/b45/b45575f34285f2c4479c9a5f719d972e.jpg
29	Batman: Arkham Knight	2015-06-23	https://media.rawg.io/media/games/310/3106b0e012271c5ffb16497b070be739.jpg
30	Metal Gear Solid V: The Phantom Pain	2015-09-01	https://media.rawg.io/media/games/490/49016e06ae2103881ff6373248843069.jpg
31	Apex Legends	2019-02-04	https://media.rawg.io/media/games/737/737ea5662211d2e0bbd6f5989189e4f1.jpg
32	Grand Theft Auto: San Andreas	2004-10-26	https://media.rawg.io/media/games/960/960b601d9541cec776c5fa42a00bf6c4.jpg
33	Middle-earth: Shadow of Mordor	2014-09-30	https://media.rawg.io/media/games/d1a/d1a2e99ade53494c6330a0ed945fe823.jpg
34	The Walking Dead: Season 1	2012-04-23	https://media.rawg.io/media/games/8d6/8d69eb6c32ed6acfd75f82d532144993.jpg
35	Hollow Knight	2017-02-23	https://media.rawg.io/media/games/4cf/4cfc6b7f1850590a4634b08bfab308ab.jpg
36	Little Nightmares	2017-04-27	https://media.rawg.io/media/games/8a0/8a02f84a5916ede2f923b88d5f8217ba.jpg
37	Dark Souls III	2016-04-11	https://media.rawg.io/media/games/da1/da1b267764d77221f07a4386b6548e5a.jpg
38	Stardew Valley	2016-02-25	https://media.rawg.io/media/games/713/713269608dc8f2f40f5a670a14b2de94.jpg
40	Hitman	2016-03-11	https://media.rawg.io/media/games/16b/16b1b7b36e2042d1128d5a3e852b3b2f.jpg
41	Hotline Miami	2012-10-22	https://media.rawg.io/media/games/9fa/9fa63622543e5d4f6d99aa9d73b043de.jpg
42	Outlast	2013-09-03	https://media.rawg.io/media/games/9dd/9ddabb34840ea9227556670606cf8ea3.jpg
43	Deus Ex: Mankind Divided	2016-08-22	https://media.rawg.io/media/games/00d/00d374f12a3ab5f96c500a2cfa901e15.jpg
44	Far Cry 3	2012-11-28	https://media.rawg.io/media/games/15c/15c95a4915f88a3e89c821526afe05fc.jpg
45	Path of Exile	2013-10-23	https://media.rawg.io/media/games/d0f/d0f91fe1d92332147e5db74e207cfc7a.jpg
46	Alan Wake	2010-05-14	https://media.rawg.io/media/games/5c0/5c0dd63002cb23f804aab327d40ef119.jpg
47	Amnesia: The Dark Descent	2010-09-08	https://media.rawg.io/media/games/b54/b54598d1d5cc31899f4f0a7e3122a7b0.jpg
48	Wolfenstein: The New Order	2014-05-19	https://media.rawg.io/media/games/c80/c80bcf321da44d69b18a06c04d942662.jpg
49	Spec Ops: The Line	2012-06-26	https://media.rawg.io/media/games/b49/b4912b5dbfc7ed8927b65f05b8507f6c.jpg
51	Saints Row: The Third	2011-11-15	https://media.rawg.io/media/games/d69/d69810315bd7e226ea2d21f9156af629.jpg
52	Detroit: Become Human	2018-05-25	https://media.rawg.io/media/games/951/951572a3dd1e42544bd39a5d5b42d234.jpg
53	Prey	2017-05-05	https://media.rawg.io/media/games/e6d/e6de699bd788497f4b52e2f41f9698f2.jpg
54	Fallout: New Vegas	2010-10-19	https://media.rawg.io/media/games/995/9951d9d55323d08967640f7b9ab3e342.jpg
55	Borderlands	2009-10-20	https://media.rawg.io/media/games/c6b/c6bfece1daf8d06bc0a60632ac78e5bf.jpg
56	Dishonored 2	2016-11-10	https://media.rawg.io/media/games/f6b/f6bed028b02369d4cab548f4f9337e81.jpg
58	Company of Heroes 2	2013-06-25	https://media.rawg.io/media/games/0bd/0bd5646a3d8ee0ac3314bced91ea306d.jpg
59	Dishonored	2012-09-25	https://media.rawg.io/media/games/4e6/4e6e8e7f50c237d76f38f3c885dae3d2.jpg
62	Grand Theft Auto: Vice City	2002-10-27	https://media.rawg.io/media/games/13a/13a528ac9cf48bbb6be5d35fe029336d.jpg
63	Hitman: Absolution	2012-11-19	https://media.rawg.io/media/games/d46/d46373f39458670305704ef089387520.jpg
64	Super Meat Boy	2010-10-20	https://media.rawg.io/media/games/e04/e04963f3ac4c4fa83a1dc0b9231e50db.jpg
65	For Honor	2017-02-13	https://media.rawg.io/media/games/4e0/4e0e7b6d6906a131307c94266e5c9a1c.jpg
66	L.A. Noire	2011-05-17	https://media.rawg.io/media/games/e2d/e2d3f396b16dded0f841c17c9799a882.jpg
67	Assassin’s Creed IV: Black Flag	2013-10-29	https://media.rawg.io/media/games/849/849414b978db37d4563ff9e4b0d3a787.jpg
68	Control	2019-08-27	https://media.rawg.io/media/games/253/2534a46f3da7fa7c315f1387515ca393.jpg
69	Star Wars Jedi: Fallen Order	2019-11-15	https://media.rawg.io/media/games/559/559bc0768f656ad0c63c54b80a82d680.jpg
70	Counter-Strike: Source	2004-11-01	https://media.rawg.io/media/games/48e/48e63bbddeddbe9ba81942772b156664.jpg
71	Dead Space (2008)	2008-10-13	https://media.rawg.io/media/games/ebd/ebdbb7eb52bd58b0e7fa4538d9757b60.jpg
72	Uncharted 4: A Thief’s End	2016-05-10	https://media.rawg.io/media/games/709/709bf81f874ce5d25d625b37b014cb63.jpg
73	Mass Effect 2	2010-01-26	https://media.rawg.io/media/games/3cf/3cff89996570cf29a10eb9cd967dcf73.jpg
74	Just Cause 3	2015-11-30	https://media.rawg.io/media/games/5bb/5bb55ccb8205aadbb6a144cf6d8963f1.jpg
75	Borderlands: The Pre-Sequel	2014-10-13	https://media.rawg.io/media/games/530/5302dd22a190e664531236ca724e8726.jpg
76	Counter-Strike	2000-11-01	https://media.rawg.io/media/games/9c4/9c47f320eb73c9a02d462e12f6206b26.jpg
77	Death Stranding	2019-11-08	https://media.rawg.io/media/games/2ad/2ad87a4a69b1104f02435c14c5196095.jpg
78	Left 4 Dead	2008-11-17	https://media.rawg.io/media/games/476/476178ef18ab0534771d099f51cdc694.jpg
79	Mortal Kombat X	2015-04-07	https://media.rawg.io/media/games/aa3/aa36ba4b486a03ddfaef274fb4f5afd4.jpg
80	NieR:Automata	2017-03-17	https://media.rawg.io/media/games/5a4/5a44112251d70a25291cc33757220fce.jpg
81	Hades	2020-09-17	https://media.rawg.io/media/games/1f4/1f47a270b8f241e4676b14d39ec620f7.jpg
82	Just Cause 2	2010-03-23	https://media.rawg.io/media/games/a3c/a3c529a12c896c0ef02db5b4741de2ba.jpg
83	Mass Effect	2007-11-16	https://media.rawg.io/media/games/a6c/a6ccd34125c594abf1a9c9821b9a715d.jpg
84	Fall Guys: Ultimate Knockout	2020-08-04	https://media.rawg.io/media/games/5eb/5eb49eb2fa0738fdb5bacea557b1bc57.jpg
85	Monster Hunter: World	2018-01-26	https://media.rawg.io/media/games/21c/21cc15d233117c6809ec86870559e105.jpg
86	Mad Max	2015-08-31	https://media.rawg.io/media/games/d7d/d7d33daa1892e2468cd0263d5dfc957e.jpg
87	Bastion	2011-07-20	https://media.rawg.io/media/games/f99/f9979698c43fd84c3ab69280576dd3af.jpg
88	Minecraft	2009-05-10	https://media.rawg.io/media/games/b4e/b4e4c73d5aa4ec66bbf75375c4847a2b.jpg
89	Paladins	2016-09-15	https://media.rawg.io/media/games/d2c/d2c74dacd89fd817c2deb625b01adb1a.jpg
90	Middle-earth: Shadow of War	2017-09-27	https://media.rawg.io/media/games/21a/21ad672cedee9b4378abb6c2d2e626ee.jpg
91	ARK: Survival Evolved	2015-06-02	https://media.rawg.io/media/games/58a/58ac7f6569259dcc0b60b921869b19fc.jpg
92	Resident Evil 7: Biohazard	2017-01-23	https://media.rawg.io/media/games/cee/cee577e2097a59b77193fe2bce94667d.jpg
93	Titanfall 2	2016-10-28	https://media.rawg.io/media/games/569/56978b5a77f13aa2ec5d09ec81d01cad.jpg
94	Cities: Skylines	2015-03-10	https://media.rawg.io/media/games/25c/25c4776ab5723d5d735d8bf617ca12d9.jpg
95	Journey	2012-03-13	https://media.rawg.io/media/games/baf/baf9905270314e07e6850cffdb51df41.jpg
96	Warhammer: Vermintide 2	2018-03-08	https://media.rawg.io/media/games/5be/5bec14622f6faf804a592176577c1347.jpg
97	XCOM: Enemy Unknown	2012-10-09	https://media.rawg.io/media/games/238/2383a172b4d50a7b44e07980eb7141ea.jpg
98	Undertale	2015-09-14	https://media.rawg.io/media/games/ffe/ffed87105b14f5beff72ff44a7793fd5.jpg
99	SEGA Mega Drive and Genesis Classics	2010-06-01	https://media.rawg.io/media/games/0fd/0fd84d36596a83ef2e5a35f63a072218.jpg
100	Brutal Legend	2009-10-12	https://media.rawg.io/media/games/af7/af7a831001c5c32c46e950cc883b8cb7.jpg
201	Mafia II	2010-08-24	https://media.rawg.io/media/games/9e5/9e5b274c7e3aa5e30beba31b834b0e7e.jpg
202	Far Cry 5	2018-03-27	https://media.rawg.io/media/games/bce/bce62fbc7cf74bf6a1a37340993ec148.jpg
203	Watch Dogs	2014-05-27	https://media.rawg.io/media/games/879/879c930f9c6787c920153fa2df452eb3.jpg
204	Shadow of the Tomb Raider	2018-09-14	https://media.rawg.io/media/games/7f6/7f6cd70ba2ad57053b4847c13569f2d8.jpg
205	Psychonauts	2005-04-01	https://media.rawg.io/media/games/c89/c89ca70716080733d03724277df2c6c7.jpg
206	Metro Exodus	2019-02-13	https://media.rawg.io/media/games/152/152e788b7504aa2753c86dae912fb34c.jpg
207	Heavy Rain	2010-02-17	https://media.rawg.io/media/games/0af/0af85e8edddfa55368e47c539914a220.jpg
208	INSIDE	2016-06-28	https://media.rawg.io/media/games/d5a/d5a24f9f71315427fa6e966fdd98dfa6.jpg
209	Sekiro: Shadows Die Twice	2019-03-22	https://media.rawg.io/media/games/67f/67f62d1f062a6164f57575e0604ee9f6.jpg
210	Max Payne 3	2012-05-15	https://media.rawg.io/media/games/5bf/5bf88a28de96321c86561a65ee48e6c2.jpg
211	Saints Row IV	2013-08-20	https://media.rawg.io/media/games/e3d/e3ddc524c6292a435d01d97cc5f42ea7.jpg
213	Firewatch	2016-02-08	https://media.rawg.io/media/games/0be/0bea0a08a4d954337305391b778a7f37.jpg
216	Alien: Isolation	2014-10-05	https://media.rawg.io/media/games/daa/daaee07fcb40744d90cf8142f94a241f.jpg
217	The Darkness II	2012-02-07	https://media.rawg.io/media/games/744/744adc36e6573dd67a0cb0e373738d19.jpg
218	Hitman 2	2018-11-13	https://media.rawg.io/media/games/858/858c016de0cf7bc21a57dcc698a04a0c.jpg
219	War Thunder	2013-08-15	https://media.rawg.io/media/games/d07/d0790809a13027251b6d0f4dc7538c58.jpg
220	Darksiders	2010-01-27	https://media.rawg.io/media/games/8d4/8d46786ca86b1d95f3dc7e700e2dc4dd.jpg
222	Cuphead	2017-09-29	https://media.rawg.io/media/games/226/2262cea0b385db6cf399f4be831603b0.jpg
223	Batman: Arkham Origins	2013-10-25	https://media.rawg.io/media/games/fc3/fc30790a3b3c738d7a271b02c1e26dc2.jpg
224	Disco Elysium	2019-10-14	https://media.rawg.io/media/games/840/8408ad3811289a6a5830cae60fb0b62a.jpg
225	Elden Ring	2022-02-25	https://media.rawg.io/media/games/b29/b294fdd866dcdb643e7bab370a552855.jpg
226	DOOM Eternal	2020-03-20	https://media.rawg.io/media/games/3ea/3ea3c9bbd940b6cb7f2139e42d3d443f.jpg
227	Among Us	2018-07-25	https://media.rawg.io/media/games/e74/e74458058b35e01c1ae3feeb39a3f724.jpg
229	Crusader Kings II	2012-02-13	https://media.rawg.io/media/games/c22/c22d804ac753c72f2617b3708a625dec.jpg
230	Halo Infinite	2021-12-08	https://media.rawg.io/media/games/e1f/e1ffbeb1bac25b19749ad285ca29e158.jpg
231	Transistor	2014-05-20	https://media.rawg.io/media/games/d1f/d1f872a48286b6b751670817d5c1e1be.jpg
232	Layers of Fear	2016-02-16	https://media.rawg.io/media/games/6a2/6a2e48933245e2cd3c92248c75c925e1.jpg
233	The Wolf Among Us	2013-10-10	https://media.rawg.io/media/games/be0/be084b850302abe81675bc4ffc08a0d0.jpg
234	GRID 2	2013-05-27	https://media.rawg.io/media/games/27b/27b02ffaab6b250cc31bf43baca1fc34.jpg
235	Battlefield 1	2016-10-21	https://media.rawg.io/media/games/998/9980c4296f311d8bcc5b451ca51e4fe1.jpg
236	Far Cry 4	2014-11-18	https://media.rawg.io/media/games/b39/b396dac1f3e0f538841aa0355dd066d3.jpg
237	Resident Evil 5	2009-03-05	https://media.rawg.io/media/games/974/974342a3959981a17bdbbff2fd7f97b0.jpg
238	XCOM 2	2016-02-04	https://media.rawg.io/media/games/9bf/9bfac18ff678f41a4674250fa0e04a52.jpg
239	The Stanley Parable	2013-10-17	https://media.rawg.io/media/screenshots/8f0/8f0b94922ad5e59968852649697b2643.jpg
240	Insurgency	2014-01-22	https://media.rawg.io/media/games/1a1/1a17e9b6286edb7e1f1e510110ccb0c0.jpg
241	Black Desert Online	2014-12-01	https://media.rawg.io/media/games/651/651ae84f2d5e36206aad90976a453329.jpg
242	Saints Row 2	2008-10-14	https://media.rawg.io/media/games/10d/10d19e52e5e8415d16a4d344fe711874.jpg
243	Amnesia: A Machine for Pigs	2013-09-09	https://media.rawg.io/media/games/d9f/d9f982e042df6263684ba1fdea3efc1c.jpg
244	Total War: SHOGUN 2	2011-03-14	https://media.rawg.io/media/games/be9/be9cf02720c9326e11d0fda14518554f.jpg
245	Sid Meier’s Civilization VI	2016-10-20	https://media.rawg.io/media/games/997/997ab4d67e96fb20a4092383477d4463.jpg
246	Ori and the Blind Forest	2015-03-10	https://media.rawg.io/media/games/f8c/f8c6a262ead4c16b47e1219310210eb3.jpg
247	SOMA	2015-09-21	https://media.rawg.io/media/games/149/149bbed9d90dc09328ba79bbacfda3c8.jpg
248	Kingdom Come: Deliverance	2018-02-13	https://media.rawg.io/media/games/d8f/d8f3b28fc747ed6f92943cdd33fb91b5.jpeg
249	Assassin’s Creed III	2012-10-30	https://media.rawg.io/media/games/275/2759da6fcaa8f81f21800926168c85f6.jpg
250	Hotline Miami 2: Wrong Number	2015-03-09	https://media.rawg.io/media/games/003/0031c0067559d41df19cf98ad87e02aa.jpg
251	Grim Fandango Remastered	2015-01-26	https://media.rawg.io/media/games/df2/df20fd77db56ae7b0a26a7ff4baa9ccc.jpg
252	FTL: Faster Than Light	2012-09-14	https://media.rawg.io/media/games/5f4/5f4780690dbf04900cbac5f05b9305f3.jpg
253	Ori and the Will of the Wisps	2020-03-10	https://media.rawg.io/media/games/718/71891d2484a592d871e91dc826707e1c.jpg
254	The Witness	2016-01-25	https://media.rawg.io/media/games/00b/00b164224ebaf381104d0b215a37afb3.jpg
255	Broforce	2015-10-15	https://media.rawg.io/media/games/9cc/9cc11e2e81403186c7fa9c00c143d6e4.jpg
256	Euro Truck Simulator 2	2012-10-19	https://media.rawg.io/media/games/1f5/1f5ddf7199f2778ff83663b93b5cb330.jpg
257	Dragon Age: Inquisition	2014-11-18	https://media.rawg.io/media/games/260/26023c855f1769a93411d6a7ea084632.jpeg
258	Kingdom: Classic	2015-09-21	https://media.rawg.io/media/games/e40/e40cc9d1957b0a0ed7e389834457b524.jpg
259	The Outer Worlds	2019-10-25	https://media.rawg.io/media/games/704/704f831d2d132e9614931f1c4eab9e86.jpg
260	Call of Duty: Modern Warfare 3	2011-11-08	https://media.rawg.io/media/games/e9c/e9c042d14515eb3ff7cb4db9fe78e435.jpg
261	Forza Horizon 4	2018-10-02	https://media.rawg.io/media/games/786/7863e587bac630de82fca50d799236a9.jpg
262	Surviving Mars	2018-03-14	https://media.rawg.io/media/games/08b/08b2eee52a9876a48b955e5149affe5b.jpg
263	The Walking Dead: Season 2	2013-12-16	https://media.rawg.io/media/games/471/4712c9ac591f556f553556b864a7e92b.jpg
264	The Legend of Zelda: Breath of the Wild	2017-03-03	https://media.rawg.io/media/games/cc1/cc196a5ad763955d6532cdba236f730c.jpg
265	Syberia 2	2004-03-30	https://media.rawg.io/media/games/c00/c003705c0eaed100397ae408b7b89e90.jpg
266	A Story About My Uncle	2014-05-27	https://media.rawg.io/media/games/37a/37a9536e92cf8fe3b60045aa75dbd41f.jpg
267	Borderlands 3	2019-09-13	https://media.rawg.io/media/games/9f1/9f1891779cb20f44de93cef33b067e50.jpg
268	SMITE	2015-08-19	https://media.rawg.io/media/games/cc7/cc77035eb972f179f5090ee2a0fabd99.jpg
269	Deus Ex: Human Revolution	2011-08-22	https://media.rawg.io/media/games/81e/81e6c6819d4322caf375b6735c3043ec.jpg
270	Sleeping Dogs	2012-08-14	https://media.rawg.io/media/games/3d9/3d9bac98d79bcd2d445f829e8d6be902.jpg
271	To the Moon	2011-01-10	https://media.rawg.io/media/games/fae/faebf3c8cbf30db3f46bfbecf6ada3d6.jpg
273	Bayonetta	2009-06-23	https://media.rawg.io/media/games/bee/bee483efadcf9d7e657e52184316a34e.jpg
274	Tom Clancy’s The Division	2016-03-07	https://media.rawg.io/media/games/c73/c73c4ffebfe968ba0982a56c2b5020ef.jpg
275	Frostpunk	2018-04-24	https://media.rawg.io/media/games/a88/a886c37bf112d009e318b106db9d420a.jpg
276	Warhammer 40,000: Space Marine	2011-09-05	https://media.rawg.io/media/games/ac2/ac25b5cef220bf5b8d052e0978451cab.jpg
277	Call of Duty: Black Ops II	2012-11-13	https://media.rawg.io/media/games/8ee/8eed88e297441ef9202b5d1d35d7d86f.jpg
278	Celeste	2018-01-25	https://media.rawg.io/media/games/594/59487800889ebac294c7c2c070d02356.jpg
279	PAYDAY The Heist	2011-10-18	https://media.rawg.io/media/games/546/546cf59a24b0ae308e311a07611ca22f.jpg
280	Metal Gear Rising: Revengeance	2013-02-19	https://media.rawg.io/media/games/8e6/8e699e91cf77c2060b6d515e2135b1b1.jpg
281	Ratchet & Clank	2016-04-12	https://media.rawg.io/media/games/d30/d30ef0c7dd4878161b1f781e297ae6a0.jpg
282	Black Mesa	2020-03-06	https://media.rawg.io/media/games/009/009e4e84975d6a60173ec1199db25aa3.jpg
283	Age of Wonders III	2014-03-31	https://media.rawg.io/media/games/f95/f95ec06eddda5c5bf206618c49cd3e68.jpg
284	inFAMOUS Second Son	2014-03-21	https://media.rawg.io/media/games/be2/be239d5eb4d0bf02bf722aff51e694ad.jpg
285	Dead by Daylight	2016-06-14	https://media.rawg.io/media/games/e11/e11325e2f89151d31f612e38dee3b6a0.jpg
286	LEGO The Lord of the Rings	2012-10-30	https://media.rawg.io/media/games/89a/89a700d3c6a76bd0610ca89ccd20da54.jpg
287	Batman: Arkham Asylum	2009-08-25	https://media.rawg.io/media/games/d56/d564ee964eb3c17892b3b35dd607f836.jpg
288	Mafia: The City of Lost Heaven	2002-08-28	https://media.rawg.io/media/games/74c/74ca0ec569682a150f3c6f9f661fb6a5.jpg
290	Overcooked	2016-08-01	https://media.rawg.io/media/games/270/270b412b66688081497b3d70c100b208.jpg
291	Ghost of Tsushima	2020-07-17	https://media.rawg.io/media/games/f24/f2493ea338fe7bd3c7d73750a85a0959.jpeg
292	STAR WARS Battlefront II	2017-11-17	https://media.rawg.io/media/games/f54/f54e9fb2f4aac37810ea1a69a3e4480a.jpg
293	Human: Fall Flat	2016-07-22	https://media.rawg.io/media/games/74d/74dafeb9a442b87b9dd4a1d4a2faa37b.jpg
294	S.T.A.L.K.E.R.: Shadow of Chernobyl	2007-03-19	https://media.rawg.io/media/games/348/348640e78a7fcd4bb7dcad4fea014eeb.jpg
295	Doki Doki Literature Club!	2017-09-22	https://media.rawg.io/media/games/972/972aea3c9eb253e893947bec2d2cfbb9.jpg
296	A Way Out	2018-03-23	https://media.rawg.io/media/games/473/473bd9a5e9522629d6cb28b701fb836a.jpg
297	Until Dawn	2015-08-25	https://media.rawg.io/media/games/d64/d6443375f9971152866ea76bff97d6d6.jpg
298	Hitman: Blood Money	2006-05-29	https://media.rawg.io/media/games/233/233cdc08cce0228f6f35222eca3bff92.jpg
299	Company of Heroes	2006-09-11	https://media.rawg.io/media/games/0fa/0fadc446fd1e9ae9e23a32793d9a5406.jpg
300	FINAL FANTASY XV	2016-11-29	https://media.rawg.io/media/games/2ee/2eeed8524931b4fae1e4a40d0e5443b5.jpg
301	The Long Dark	2014-09-22	https://media.rawg.io/media/games/fd2/fd20a68d7ef195855588c937865dd0a7.jpg
302	Tropico 4	2011-08-24	https://media.rawg.io/media/games/d1e/d1e70ce3762efcfc170c6bd067d7e9e3.jpg
303	Max Payne	2001-07-25	https://media.rawg.io/media/games/2f5/2f5eb72fe45540e93ac2726877551a20.jpg
304	Titan Souls	2015-04-13	https://media.rawg.io/media/screenshots/2fc/2fc6994425146f9dba3133400b414e29.jpg
305	The Binding of Isaac: Rebirth	2014-11-03	https://media.rawg.io/media/games/926/926928beb8a9f9b31cf202965aa4cbbc.jpg
306	Mortal Kombat 11	2019-04-22	https://media.rawg.io/media/games/eb5/eb514db62d397c64288160d5bd8fd67a.jpg
307	Wolfenstein: The Old Blood	2015-05-04	https://media.rawg.io/media/games/f14/f1422eacab98c5f85a5123da4e9d9e89.jpg
308	Hacknet	2015-08-11	https://media.rawg.io/media/games/23b/23b69bfef2a1ce2e3dcdf1aa8ef1150b.jpg
309	Star Wars: Knights of the Old Republic II – The Sith Lords	2004-12-06	https://media.rawg.io/media/games/046/0464f4a36cd975a37c95b93b06058855.jpg
310	Prison Architect	2015-10-05	https://media.rawg.io/media/games/6bc/6bc79f5bc023b1e6938f6eaf9926f073.jpg
311	Beholder	2016-11-08	https://media.rawg.io/media/games/40a/40ab95c1639aa1d7ec04d4cd523af6b1.jpg
313	Stray	2022-07-19	https://media.rawg.io/media/games/cd3/cd3c9c7d3e95cb1608fd6250f1b90b7a.jpg
314	Jotun: Valhalla Edition	2015-09-29	https://media.rawg.io/media/games/032/0329db96e252aa41e672da2ba16f914c.jpg
315	Starbound	2016-07-22	https://media.rawg.io/media/games/6d9/6d92d50affeebf2eb3894d178eb1117e.jpg
316	LEGO The Hobbit	2014-04-08	https://media.rawg.io/media/games/e4f/e4fb3fd188f61fabec48dca22e6ef28a.jpg
317	Sanctum 2	2013-05-15	https://media.rawg.io/media/games/963/963815b2a1a88475a31f311b591e70fb.jpg
318	Braid	2008-08-06	https://media.rawg.io/media/games/a5a/a5abaa1b5cc1567b026fa3aa9fbd828e.jpg
319	Killing Floor 2	2016-11-18	https://media.rawg.io/media/games/192/1921ec949024a5fbd1e1c7008f54b5af.jpg
320	Red Orchestra 2: Heroes of Stalingrad with Rising Storm	2011-09-13	https://media.rawg.io/media/games/bff/bff077fb7c3b037bd5ed920bf447c863.jpg
322	GRID (2008)	2008-06-03	https://media.rawg.io/media/games/fc0/fc076b974197660a582abd34ebccc27f.jpg
323	Neverwinter	2013-06-20	https://media.rawg.io/media/games/26b/26b27e1da9e3727fcb12e3e4e86c8c19.jpg
324	F.E.A.R.	2005-10-18	https://media.rawg.io/media/games/89a/89a8378d49732505cdb28babe505df9e.jpg
325	It Takes Two	2021-03-26	https://media.rawg.io/media/games/d47/d479582ed0a46496ad34f65c7099d7e5.jpg
326	Enter the Gungeon	2016-04-04	https://media.rawg.io/media/games/3be/3be0e624424d3453005019799a760af2.jpg
327	Resident Evil Revelations 2	2015-02-24	https://media.rawg.io/media/games/ea3/ea3228b5c6c749019a9ed42e90a4e7c6.jpg
328	Assassin’s Creed Brotherhood	2010-11-16	https://media.rawg.io/media/games/116/116b93c6876a361a96b2eee3ee58ab13.jpg
329	Serious Sam 3: BFE	2011-11-22	https://media.rawg.io/media/games/12e/12ea6b35b65df38258e25885a0a392a6.jpg
330	Lords of the Fallen (2014)	2014-10-28	https://media.rawg.io/media/games/d09/d096ad37b7f522e11c02848252213a9a.jpg
331	Darksiders II	2012-08-14	https://media.rawg.io/media/games/848/8482235332f4518da363c3cb4e5cd075.jpg
332	Mark of the Ninja	2012-09-07	https://media.rawg.io/media/games/b17/b17485d757ca36b5f1ad376b6b096885.jpg
333	Jet Set Radio	2000-06-29	https://media.rawg.io/media/games/fd7/fd794a9f0ffe816038d981b3acc3eec9.jpg
334	BattleBlock Theater	2013-04-03	https://media.rawg.io/media/games/388/388935d851846f8ec747fffc7c765800.jpg
335	Drawful 2	2016-06-20	https://media.rawg.io/media/games/eeb/eeb9e668da5fd07bab9f655acfbbe579.jpg
336	Orwell: Keeping an Eye On You	2016-10-27	https://media.rawg.io/media/games/2e1/2e187b31e5cee21c110bd16798d75fab.jpg
337	Slay the Spire	2019-01-22	https://media.rawg.io/media/games/f52/f5206d55f918edf8ee07803101106fa6.jpg
339	Deep Rock Galactic	2020-05-13	https://media.rawg.io/media/games/c92/c9207a31f0eeb9904a840fc26eae6afb.jpg
340	Stellaris	2016-05-08	https://media.rawg.io/media/games/92b/92bbf8a451e2742ab812a580546e593a.jpg
341	Oxenfree	2016-01-14	https://media.rawg.io/media/games/7ba/7baf4663962bad7197e2470d59a6e322.jpg
342	Far Cry 2	2008-10-21	https://media.rawg.io/media/games/89e/89e913f4ba5260cfb8b775667f81c23a.jpg
343	Broken Age	2014-01-28	https://media.rawg.io/media/games/3ef/3eff92562640e452d3487c04ba6d7fae.jpg
344	ABZU	2016-08-02	https://media.rawg.io/media/games/ba9/ba9ad92b6d04825bd15a407c6059db94.jpg
345	Tales from the Borderlands: A Telltale Game Series	2015-10-21	https://media.rawg.io/media/games/264/2642b17a7885f7abc4fd018e98943242.jpg
346	Child of Light	2014-04-29	https://media.rawg.io/media/games/c47/c4796c4c49e7e06ad328e07aa8944cdd.jpg
347	PlanetSide 2	2012-11-20	https://media.rawg.io/media/games/2fd/2fd1b58116b10cc1f4442bee5593ca7c.jpg
348	F.E.A.R. 3	2011-03-25	https://media.rawg.io/media/games/1da/1da9a7af524e81d257f972fbc06baefd.jpg
349	F.E.A.R. 2: Project Origin	2009-02-10	https://media.rawg.io/media/games/d1d/d1dd46e2ef7f8a1ee946d3ab779c3754.jpg
350	Destiny	2014-09-09	https://media.rawg.io/media/games/062/062420d85c7143f72ad3557f32c41ead.jpg
351	Gwent: The Witcher Card Game	2018-10-23	https://media.rawg.io/media/games/742/7424c1f7d0a8da9ae29cd866f985698b.jpg
352	Sonic Mania	2017-08-15	https://media.rawg.io/media/games/bbf/bbf8d74ab64440ad76294cff2f4d9cfa.jpg
354	Lara Croft and the Guardian of Light	2010-08-05	https://media.rawg.io/media/games/a92/a92272ea5cfc35b8ad6317fbd81ce0f6.jpg
355	The Flame in the Flood	2016-02-23	https://media.rawg.io/media/games/87a/87a29bcc56b6b6082ead1dd5e2510aaa.jpg
356	The Elder Scrolls III: Morrowind	2002-05-01	https://media.rawg.io/media/games/ccf/ccf26f6e3d553a04f0033a8107a521b8.jpg
357	The Talos Principle	2014-12-11	https://media.rawg.io/media/games/948/948fe7f00b6cba8472f5ecd07a455077.jpg
358	STAR WARS Battlefront	2015-11-17	https://media.rawg.io/media/games/bd2/bd2cc7714e0b9b1adad1ba1b2400d436.jpg
359	Resident Evil: Village	2021-05-07	https://media.rawg.io/media/games/6cc/6cc23249972a427f697a3d10eb57a820.jpg
360	Dying Light	2015-01-27	https://media.rawg.io/media/games/4a5/4a5ce21f529cf8fd4670b4c3188b25df.jpg
481	The Surge	2017-05-15	https://media.rawg.io/media/games/396/3963e0df75c22d5995368ec43dacc19e.jpg
361	Divinity: Original Sin	2014-06-30	https://media.rawg.io/media/games/963/9639183ff27251b0b686acaa6aac0297.jpg
362	Gris	2018-12-13	https://media.rawg.io/media/games/51c/51c430f1795c79b78f863a9f22dc422d.jpg
363	Spelunky	2012-07-04	https://media.rawg.io/media/games/fad/fadc4be043ed07904012d47cd02671e4.jpg
364	Tomb Raider: Underworld	2008-11-18	https://media.rawg.io/media/games/341/3413d7275fb1e919f00a925df8288b77.jpg
365	Vampyr	2018-06-04	https://media.rawg.io/media/games/23b/23b42b7a896140f4ce1d0df8c42fa012.jpg
366	Battlefield 3	2011-10-25	https://media.rawg.io/media/games/8bd/8bda6d876f3e241c6024022299553efd.jpg
367	Battlefield V	2018-11-20	https://media.rawg.io/media/games/45b/45b57ed59de4b84effd8f6bc4b7bf515.jpg
368	Rogue Legacy	2013-06-27	https://media.rawg.io/media/games/598/59851e152a6898c8bf79069b5bf2f4db.jpg
369	Overlord	2007-06-26	https://media.rawg.io/media/games/d1c/d1cd8a226cb224357c1f59605577cbf2.jpg
370	Deponia	2012-01-27	https://media.rawg.io/media/games/c2e/c2e6ad5c838d551aeff376f1f3d9d65e.jpg
371	Star Wars: Battlefront II (2005)	2005-10-30	https://media.rawg.io/media/games/662/6625a20ca1d13699ee7c191b20a02408.jpg
372	Outer Wilds	2019-05-29	https://media.rawg.io/media/games/9f4/9f418898f5415668ca47b5f4ab1ecfeb.jpg
374	Dust: An Elysian Tail	2012-08-15	https://media.rawg.io/media/games/c40/c40f9f0a3d1b4601a7a44d230c95f126.jpg
375	DiRT Showdown	2012-05-24	https://media.rawg.io/media/games/23d/23d78acedbb5f40c9fb64e73af5af65d.jpg
376	Max Payne 2: The Fall of Max Payne	2003-10-14	https://media.rawg.io/media/games/6fd/6fd971ffa72faa1758960d25ef6196bc.jpg
377	Day of Defeat: Source	2005-09-26	https://media.rawg.io/media/games/bff/bff7d82316cddea9541261a045ba008a.jpg
378	Sniper Elite 4	2017-02-13	https://media.rawg.io/media/games/2fe/2feec1ba840f467a2280061b9e665c6e.jpg
379	Persona 5	2016-09-15	https://media.rawg.io/media/games/3ea/3ea0e57ede873970c0f1130e30d88749.jpg
380	Medal of Honor	2010-10-12	https://media.rawg.io/media/games/106/1069e754e7e6012b0cf42b4b04704792.jpg
381	Life is Strange 2	2018-09-27	https://media.rawg.io/media/games/883/883bc3050f9a4115d1968ece56bddfc2.jpg
382	The LEGO NINJAGO Movie Video Game	2017-09-22	https://media.rawg.io/media/games/f60/f607e3212c540e3d25c2418c2edb6306.jpg
383	Valiant Hearts: The Great War	2014-06-24	https://media.rawg.io/media/games/39a/39a8aa7798b685f9625e857bc394259d.jpg
384	Machinarium	2009-10-16	https://media.rawg.io/media/games/8cd/8cd179c85bd3de8f79bef245b15075fb.jpg
385	Red Faction: Guerrilla	2009-06-02	https://media.rawg.io/media/games/94a/94a59c5136a9b90eef5f23fea7bf997c.jpg
386	Pillars of Eternity	2015-03-26	https://media.rawg.io/media/games/789/7896837ec22a83e4007018ddd55e8c9a.jpg
387	S.T.A.L.K.E.R.: Call of Pripyat	2009-10-02	https://media.rawg.io/media/games/5ad/5adab016a307c2902a82b60d487fe287.jpg
388	Crysis	2007-11-12	https://media.rawg.io/media/games/90f/90fd5e569bc4c4a666c588a732124908.jpg
389	The Swapper	2013-05-13	https://media.rawg.io/media/games/6fc/6fcb1c529c764700d55f3bbc1b0fbb5b.jpg
390	Shadow Tactics: Blades of the Shogun	2016-12-05	https://media.rawg.io/media/games/c35/c354856af9151dc63844be4f9843d2c2.jpg
391	S.T.A.L.K.E.R.: Clear Sky	2008-08-22	https://media.rawg.io/media/games/68e/68e34eb2122fe9e23f634e0b5f5ea6ae.jpg
392	Hitman 2: Silent Assassin	2002-10-01	https://media.rawg.io/media/games/683/6833fbb183fd72a61c032501e3bc6d36.jpg
393	The Awesome Adventures of Captain Spirit	2018-06-25	https://media.rawg.io/media/games/efd/efd6b2cb621c41a2b6580d8ac260b8ba.jpg
394	Rage	2011-10-03	https://media.rawg.io/media/games/8a7/8a75028028592f9323d1e6e86668bb91.jpg
395	Mass Effect 3	2012-03-05	https://media.rawg.io/media/games/315/3156817d3ac1f341da73de6495fb28f5.jpg
396	Injustice 2	2017-05-09	https://media.rawg.io/media/games/e42/e428e70c97064037326d7863a43a0454.jpg
397	Day of Defeat	2003-05-01	https://media.rawg.io/media/games/ccc/ccc0d5396e3331d58e5eb58a6a1fa1b7.jpg
398	World of Goo	2008-10-13	https://media.rawg.io/media/games/d03/d030347839f74454afcd1008248b08ae.jpg
399	Call of Duty: World at War	2008-11-11	https://media.rawg.io/media/games/da1/da15524e850ee9791b32973b748e08d5.jpg
400	Tell Me Why	2020-08-27	https://media.rawg.io/media/games/b28/b28a135fa6133e17b228f46902a4fda4.jpg
401	Gears 5	2019-09-10	https://media.rawg.io/media/games/121/1213f8b9b0a26307e672cf51f34882f8.jpg
402	Outlast 2	2017-04-24	https://media.rawg.io/media/games/880/880f6aa65fe9d786f1a455963df76180.jpg
403	Tomb Raider: Legend	2006-04-06	https://media.rawg.io/media/games/9d4/9d45e22df640fcb6f4b754aa3491ae09.jpg
404	Street Fighter V	2016-02-15	https://media.rawg.io/media/games/a32/a32c9c299488ca99afc3fcea605a7718.jpg
405	Deathloop	2021-09-14	https://media.rawg.io/media/games/018/01857c5ff9579c48fa8bd76b4d83a946.jpg
406	Satellite Reign	2015-08-27	https://media.rawg.io/media/games/8df/8df64136042eb6e2ed4fa910a6ad96ac.jpg
407	Red Faction: Armageddon	2011-06-07	https://media.rawg.io/media/games/395/395ad028483d6cd9076b746a3eec993d.jpg
408	Resident Evil Revelations	2012-02-07	https://media.rawg.io/media/games/89a/89ac2742fcfeba3b95ac94457af766ef.jpg
409	Overcooked! 2	2018-08-06	https://media.rawg.io/media/games/d11/d11470677a829e34562e95a4002c2c7f.jpg
410	The Evil Within 2	2017-10-11	https://media.rawg.io/media/games/d5f/d5fd2f970f48d0877a53aec98825faba.jpg
411	Sunset Overdrive	2014-10-28	https://media.rawg.io/media/games/c2e/c2eb6021a2596644b437e943612af25c.jpg
412	Life is Strange: Before The Storm	2017-08-31	https://media.rawg.io/media/games/214/2140885d34e3a3398b45036e5d870971.jpg
413	Torchlight	2009-10-26	https://media.rawg.io/media/games/b17/b175178f8842276b8b18b339fe3146a1.jpg
414	Call of Duty 4: Modern Warfare	2007-11-05	https://media.rawg.io/media/games/9fb/9fbaea2168caea1f806546dfdaaeb1da.jpg
416	Star Wars Jedi Knight: Jedi Academy	2003-09-16	https://media.rawg.io/media/games/7e8/7e8890a662539b1bdefcf57409aef765.jpg
417	Gone Home	2013-08-14	https://media.rawg.io/media/games/9e5/9e5b91a6d02e66b8d450a977a59ae123.jpg
418	Awesomenauts	2012-05-01	https://media.rawg.io/media/screenshots/4df/4df0b0812fd89af2285e683fb78f1323.jpg
420	Orcs Must Die! 2	2012-07-30	https://media.rawg.io/media/games/725/725eb4171c8aacee030a2d050ebf9fad.jpg
421	Alien Swarm	2010-07-19	https://media.rawg.io/media/screenshots/a65/a65e9f01832997a4d913b3ea86319af4.jpg
422	Sonic Generations	2011-11-01	https://media.rawg.io/media/games/9a1/9a18c226cf379272c698f26d2b79b3da.jpg
423	Metro: Last Light	2013-05-13	https://media.rawg.io/media/games/b1f/b1f1eeee149ef49c008a2258ee6c0d78.jpg
424	Katana ZERO	2019-04-17	https://media.rawg.io/media/games/d37/d37e110ddcc0bd52d99f0f647b737a0a.jpg
425	Kerbal Space Program	2015-04-26	https://media.rawg.io/media/games/bda/bdab2603c0dc67268d0610449bc7df16.jpg
426	Never Alone	2014-11-18	https://media.rawg.io/media/games/23a/23acbd56da0c30bca0227967a5720c96.jpg
427	Deus Ex 2: Invisible War	2003-12-01	https://media.rawg.io/media/screenshots/ca0/ca06700d8184f451b99396c23b4ffbe4.jpg
428	Battlefield: Bad Company 2	2010-03-02	https://media.rawg.io/media/games/e8f/e8f923180ecb9614ec564a15937cfd9e.jpg
429	Deadlight	2012-06-01	https://media.rawg.io/media/games/595/59556e1839b2e79b6f11f2c68a197663.jpg
430	Risk of Rain 2	2020-08-11	https://media.rawg.io/media/games/238/238e2b2b24c9838626700c69cacf1e3a.jpg
431	TEKKEN 7	2015-03-18	https://media.rawg.io/media/games/62b/62b035add7205737540d66e082b85930.jpg
432	Blasphemous	2019-09-09	https://media.rawg.io/media/games/b01/b01aa6b2d6d4f683203e9471a8b8d5b5.jpg
433	Outland	2011-04-26	https://media.rawg.io/media/games/f80/f805774c679cca1a1a472d9ac39c78b7.jpg
434	Shadow Warrior 2	2016-10-12	https://media.rawg.io/media/games/0b2/0b240149610b8b20eac098b8071f575a.jpg
435	Just Cause	2006-09-22	https://media.rawg.io/media/games/e60/e601c02ec49ef4f1d5ef147994b3935f.jpg
436	Galactic Civilizations II: Ultimate Edition	2011-12-02	https://media.rawg.io/media/games/3d8/3d8e76154123ef352d8d3216da061a2d.jpg
437	Styx: Master of Shadows	2014-10-06	https://media.rawg.io/media/games/cd7/cd78e63236e86f97f4b2e45f3843eb3d.jpg
438	Uncharted: The Lost Legacy	2017-08-22	https://media.rawg.io/media/games/560/56056a71c74f751552c9baedebf8f317.jpg
439	VVVVVV	2010-01-09	https://media.rawg.io/media/screenshots/6fe/6fe228662a253cd929cc78a103541ee0.jpg
440	Surgeon Simulator	2013-04-18	https://media.rawg.io/media/screenshots/ca8/ca840f2a8ebfc74aac1688367dc1f903.jpg
441	Renegade Ops	2011-09-13	https://media.rawg.io/media/games/31b/31b1a1a45ad7103e52eed8ef658209a2.jpg
442	Warhammer: End Times - Vermintide	2015-10-23	https://media.rawg.io/media/games/1dc/1dc45435c09f844b24eb96cd66eb6325.jpg
443	Stories: The Path of Destinies	2016-04-11	https://media.rawg.io/media/games/1aa/1aaf454e0d3809ba1c34df4514492237.jpg
444	Steep	2016-12-02	https://media.rawg.io/media/games/b22/b227810b1a1bcbe9cf3dda22534c686e.jpg
445	Enclave	2002-07-18	https://media.rawg.io/media/games/de4/de4b7cb80b39d95943f2931093b46932.jpg
446	Uncharted 2: Among Thieves	2009-10-13	https://media.rawg.io/media/games/74b/74b239f6ef0216a2f66e652d54abb2e6.jpg
447	FINAL FANTASY XIII	2009-12-17	https://media.rawg.io/media/games/943/9432de383089b0a427a3cdf3687b2b73.jpg
448	Serious Sam: The First Encounter	2001-03-21	https://media.rawg.io/media/games/f0e/f0e050dc774d4ae3afced76b33516295.jpg
449	Mass Effect: Andromeda	2017-03-21	https://media.rawg.io/media/games/a9b/a9be26838e6d54d8fb008ffc70e0d59a.jpg
450	Furi	2016-07-04	https://media.rawg.io/media/games/556/556157feed9ee1f55f2b12b2973e30a3.jpg
451	Genshin Impact	2020-09-28	https://media.rawg.io/media/games/c38/c38bdb5da139005777176d33c463d70f.jpg
452	Prince of Persia (2008)	2008-12-02	https://media.rawg.io/media/games/956/95640d5ea0288c187dbce849a4254a41.jpg
454	Prototype	2009-06-09	https://media.rawg.io/media/games/b74/b74b15a48ac7bc37fbb42ee4afcc0b91.jpg
455	Hitman: Codename 47	2000-11-19	https://media.rawg.io/media/games/3f6/3f6a397ec36acfcc18bb6ab3414c7658.jpg
456	SteamWorld Dig	2013-08-08	https://media.rawg.io/media/games/e07/e07737df8469bf32d132ba9eaffc3461.jpg
457	Strider	2012-02-16	https://media.rawg.io/media/screenshots/12e/12ee2600684863837596c0dbb1923fca.jpg
458	DOOM 3	2004-08-03	https://media.rawg.io/media/games/3b0/3b01313965c19adc6b6c37a3d9d33576.jpg
459	Grim Dawn	2016-02-25	https://media.rawg.io/media/games/920/92039cd19460532b76f6244b2bb3e4ac.jpg
460	Call of Duty: Modern Warfare (2019)	2019-10-25	https://media.rawg.io/media/games/e43/e43f9f0a1429bd9332020ac5876bc693.jpg
461	Dishonored: Death of the Outsider	2017-09-14	https://media.rawg.io/media/games/742/74276457ebb9466e11d75a2be7722265.jpg
462	The Banner Saga	2014-01-14	https://media.rawg.io/media/games/fa3/fa3dd043cba3a9cbfe3085e75d92bf7e.jpg
463	Crypt of the NecroDancer	2015-04-22	https://media.rawg.io/media/games/70a/70a7a7b21d8fdf5f19622e5e14599bcd.jpg
464	World of Tanks	2010-08-12	https://media.rawg.io/media/games/c3b/c3be1d5f55cb9324c97ccb7aaaf42ad4.jpg
465	Fallout Tactics: Brotherhood of Steel	2001-03-01	https://media.rawg.io/media/games/27c/27c86ebfba2281ebe3ea8ca6c9e752f1.jpg
466	Superhot: Mind Control Delete	2020-07-15	https://media.rawg.io/media/games/b56/b56853f28ecdc04b44f552f7b9c8ea69.jpg
467	Elite Dangerous	2015-04-02	https://media.rawg.io/media/games/b69/b69a67833630dd96d8eee9d2c8c27574.jpg
468	The Vanishing of Ethan Carter	2014-09-25	https://media.rawg.io/media/games/90c/90caf1fcb836cad70013452f6f239008.jpg
469	Need for Speed Heat	2019-11-08	https://media.rawg.io/media/games/370/3703c683968a54f09630dcf03366ea35.jpg
470	Overlord II	2009-06-22	https://media.rawg.io/media/games/bfb/bfb2bf7a0413443b1fcf0be7c3244053.jpg
472	Dead Rising 2	2010-08-31	https://media.rawg.io/media/games/7e7/7e79e3296a7f64e7535c9e5bb5aa4b53.jpg
473	Unravel	2016-02-09	https://media.rawg.io/media/games/cfe/cfe114c081281960bd79ace5209c0a4a.jpg
474	Thomas Was Alone	2012-06-30	https://media.rawg.io/media/games/6c8/6c8cb4780ce30b76b944cf656e8fff49.jpg
475	EVE Online	2003-05-06	https://media.rawg.io/media/games/82b/82be203e68d737762846203811165933.jpg
476	Super Mario Odyssey	2017-10-27	https://media.rawg.io/media/games/267/267bd0dbc496f52692487d07d014c061.jpg
477	Star Wars Jedi Knight II: Jedi Outcast	2002-03-01	https://media.rawg.io/media/games/0a5/0a56e2bb9ce95359e69ff9689c553a45.jpg
478	Tropico 5	2014-05-22	https://media.rawg.io/media/games/3c9/3c994986d767f56e7b72a124a35d4c3c.jpg
480	SpeedRunners	2016-04-19	https://media.rawg.io/media/games/9e5/9e52a797f049e701d4eee84774a99007.jpg
482	Dungeons 2	2015-04-23	https://media.rawg.io/media/games/476/4767c380895fd35a4f1b59016dc45967.jpg
483	Alpha Protocol	2010-04-08	https://media.rawg.io/media/games/8b9/8b9e77be7f0f7941b11ae4b21ca2db43.jpg
484	Far Cry Primal	2016-02-23	https://media.rawg.io/media/games/119/119bb59e64c7956171a33df0d35aee6b.jpg
485	TERA	2017-01-31	https://media.rawg.io/media/screenshots/6d3/6d367773c06886535620f2d7fb1cb866.jpg
486	ArmA II	2009-06-18	https://media.rawg.io/media/screenshots/c38/c38595cc04bdddaa84ed8feae5319849.jpg
487	Scribblenauts Unlimited	2012-11-13	https://media.rawg.io/media/screenshots/42d/42d770eb49f2ba01cd4045e0d92af7a9.jpg
488	Dark Messiah of Might and Magic	2006-10-24	https://media.rawg.io/media/games/330/330952c1726bbb56fc3b9f8a8c83ab1d.jpg
489	Risk of Rain	2013-11-07	https://media.rawg.io/media/games/f62/f62eb0901c7017776e0a5c6a94f979d5.jpg
490	RiME	2017-05-25	https://media.rawg.io/media/games/5aa/5aa4c12a53bc5f606bf8d92461ec747d.jpg
491	Moonlighter	2018-05-28	https://media.rawg.io/media/games/5c2/5c2b78d4ee2647849d0bfb5d772345c8.jpg
492	Gothic	2001-03-15	https://media.rawg.io/media/games/e75/e75c54e5a9a2754bab181b2240472389.jpg
493	Remnant: From the Ashes	2019-08-20	https://media.rawg.io/media/games/30f/30f2c0f6890da6971102210c56d8513c.jpg
494	Need For Speed: Hot Pursuit	2010-11-16	https://media.rawg.io/media/games/367/367463d43c2a1465f27e830b5b1334ee.jpg
495	Risen	2009-10-02	https://media.rawg.io/media/games/155/155a7d8f464ef6029e11cc6a9c0f763d.jpg
496	Loadout	2014-01-10	https://media.rawg.io/media/games/560/560847de3a0fd510bbe6c305abca0f0f.jpg
497	SpaceChem	2011-01-01	https://media.rawg.io/media/screenshots/95a/95a557d6dfa6430dd662a136d71e5915.jpg
498	South Park: The Fractured But Whole	2017-03-31	https://media.rawg.io/media/games/63c/63cb04333dea1726e90b38dc3d10258f.jpg
499	SteamWorld Dig 2	2017-09-21	https://media.rawg.io/media/games/95a/95adc7a2135783dfd2204f694200c836.jpg
500	LittleBigPlanet 3	2014-11-18	https://media.rawg.io/media/games/8e3/8e399167fd529da5e9e505e987ae63ff.jpg
501	The Red Solstice	2015-07-09	https://media.rawg.io/media/games/d87/d87268c4b7b33b278cbc1f152db39729.jpg
502	Shadow Warrior (2013)	2013-09-25	https://media.rawg.io/media/games/907/90757eaa9dc7c5cf7c47bf4960843999.jpg
503	Dungeon of the Endless	2014-10-27	https://media.rawg.io/media/games/a0c/a0cb0ac048c75b41d2620d2e6cb6f983.jpg
504	Skullgirls	2012-02-14	https://media.rawg.io/media/games/416/4164ca654a339af5be8e63cc9c480c70.jpg
505	My Friend Pedro	2019-06-19	https://media.rawg.io/media/games/21d/21dfa5f7f5c0fa2b85f418c4e1c6ab1b.jpg
506	Tropico 3	2009-10-20	https://media.rawg.io/media/games/d49/d4974f5eb9e6c47794f681f149280d9d.jpg
507	Hyper Light Drifter	2016-03-30	https://media.rawg.io/media/games/578/57885b9590c9a9f80ceea34d147a34c4.jpg
508	Far Cry	2004-03-22	https://media.rawg.io/media/games/2ee/2eef5ed5e82c28d1299ecc2a0e60f2cb.jpg
509	SPORE	2008-09-04	https://media.rawg.io/media/games/cae/caeb9d0cb154124b132d51861735431e.jpg
510	Endless Legend	2014-09-18	https://media.rawg.io/media/screenshots/0a6/0a62ee096ef629d5c3c44cc4bcc8cbb5.jpg
511	Factorio	2020-08-14	https://media.rawg.io/media/games/7e4/7e4e22b76da131e9690d5757555093c2.jpg
512	RUINER	2017-09-26	https://media.rawg.io/media/games/489/4899fe1e7b65e550ea619db02006ca6c.jpg
513	Call of Duty	2003-10-29	https://media.rawg.io/media/games/9c5/9c5bc0b6e67102bc96dcf1ba41509e42.jpg
514	Aegis Defenders	2018-02-07	https://media.rawg.io/media/games/054/054ab7dd5e83f84f1ec8bedf849b627f.jpg
515	Snake Pass	2017-03-28	https://media.rawg.io/media/games/f15/f15e1dbda32b588a981bbc6b222a4b4c.jpg
516	Bulletstorm	2011-02-22	https://media.rawg.io/media/games/b42/b42b05096de6668833bbab38f6099c6a.jpg
517	Rayman Origins	2011-11-15	https://media.rawg.io/media/screenshots/375/375f84d018242d7519a230f623981217.jpg
518	Vampire: The Masquerade - Bloodlines	2004-11-15	https://media.rawg.io/media/games/6f0/6f0a69db053bce957d8328a7253fbb29.jpg
519	Race The Sun	2013-08-17	https://media.rawg.io/media/games/a01/a01b34c722ceec784817381eb1824fa5.jpg
520	DiRT Rally 2.0	2019-02-26	https://media.rawg.io/media/games/8f3/8f306808c45a4dbe0cd698e0b142af08.jpg
521	Lost Ark	2022-02-11	https://media.rawg.io/media/games/d9e/d9e868382c48ec98c9b23b8fbe6a2045.jpg
522	Overwatch	2016-05-24	https://media.rawg.io/media/games/4ea/4ea507ceebeabb43edbc09468f5aaac6.jpg
524	Call of Duty: Advanced Warfare	2014-11-03	https://media.rawg.io/media/games/e05/e053aae547e0978ad90280a1a3d8f177.jpg
525	Orcs Must Die!	2011-10-05	https://media.rawg.io/media/games/417/4176298c1b22ccd338ce3dfc34eb7e28.jpg
526	Vanquish	2010-10-19	https://media.rawg.io/media/games/88a/88af17cc08783ccdd1608ae63c47eeac.jpg
527	The Dark Pictures Anthology: Man of Medan	2019-08-30	https://media.rawg.io/media/games/206/2060eda39e4646bbe90b55ab7495c173.jpg
528	Prince of Persia: The Sands of Time	2003-10-28	https://media.rawg.io/media/games/99b/99b39612e864d6ddfdb2c407fd9010a1.jpg
529	Anomaly: Warzone Earth	2011-04-07	https://media.rawg.io/media/games/d28/d28e64fd1af23d1846d20b47dfa933f8.jpeg
531	HELLDIVERS	2015-12-07	https://media.rawg.io/media/games/ae3/ae357d6e6f9e89597e8293469ddabba9.jpg
532	Star Wars: Republic Commando	2005-03-01	https://media.rawg.io/media/games/b1d/b1de33eca64ad293702d9554f5ac5cd5.jpg
533	LEGO Star Wars - The Complete Saga	2007-11-06	https://media.rawg.io/media/games/cf3/cf39c637f18800b6d3f65d640a8ebbaa.jpg
534	Slime Rancher	2016-01-14	https://media.rawg.io/media/games/43f/43f4f3a50651f371c147ecce8ee841a9.jpg
535	PAC-MAN CHAMPIONSHIP EDITION 2	2016-09-13	https://media.rawg.io/media/screenshots/7fa/7fa3e1fbabb9fb5c77525e47fa49e261.jpg
536	Warhammer 40,000: Dawn of War II	2009-02-18	https://media.rawg.io/media/screenshots/4d9/4d9afae02fdf2896569b1c7bfeabb8c1.jpg
537	Bloodstained: Ritual of the Night	2019-06-18	https://media.rawg.io/media/games/26c/26cacc55399ed6b2c14e20d2eca0620a.jpg
538	Her Story	2015-06-23	https://media.rawg.io/media/games/a9a/a9a4e45ad8e653df2295e8410b7e96fd.jpg
539	Alice: Madness Returns	2011-06-14	https://media.rawg.io/media/games/0b5/0b5410b1e4b3fb72696dcefbf4f1cf40.jpg
540	The Incredible Adventures of Van Helsing	2013-05-22	https://media.rawg.io/media/games/3c3/3c363e31f4add887affadc82c641de72.jpg
541	AudioSurf	2008-02-15	https://media.rawg.io/media/screenshots/0f5/0f585fa72f534f62f9e5da051179f5de.jpg
542	Serious Sam 2	2005-10-11	https://media.rawg.io/media/games/bc7/bc77b1eb8e35df2d90b952bac5342c75.jpg
543	Need for Speed Rivals	2013-11-15	https://media.rawg.io/media/games/1fa/1fa75f0895240b12fc65cc98ae9649fd.jpg
544	Valkyria Chronicles	2008-04-24	https://media.rawg.io/media/games/0d4/0d4e5446db732e2fcce34d1dcb4dd914.jpg
545	Gears of War	2006-11-08	https://media.rawg.io/media/games/988/98834d39955e7f15d3717fac438128aa.jpg
546	Into the Breach	2018-02-26	https://media.rawg.io/media/games/800/800d07ca648a9778a8230f40088e0866.jpg
547	Unravel Two	2018-06-09	https://media.rawg.io/media/games/3e3/3e355e1b8a5ee47f4c76e28e3055236d.jpg
548	Children of Morta	2019-09-03	https://media.rawg.io/media/games/434/43431e04f0cd5419a3d8e31a5c8c3d5d.jpg
549	Call of Duty: Infinite Warfare	2016-11-04	https://media.rawg.io/media/games/6f7/6f7341dd656910be2c2cda39193a7ec9.jpg
550	Deltarune	2018-10-30	https://media.rawg.io/media/games/7a9/7a907fb5e158c8dc34e783d9c22674c3.jpg
651	Brothers: A Tale of Two Sons	2013-08-07	https://media.rawg.io/media/games/b6b/b6b20bfc4b34e312dbc8aac53c95a348.jpg
701	This War of Mine	2014-11-14	https://media.rawg.io/media/games/283/283e7e600366b0da7021883d27159b27.jpg
702	Call of Juarez: Gunslinger	2013-05-14	https://media.rawg.io/media/games/a86/a86ce0afaf2d5ec2b0f048989f01795e.jpg
703	Thief	2014-02-25	https://media.rawg.io/media/games/59a/59a3ebcba3d08c51532c6ca877aff256.jpg
704	Watch Dogs 2	2016-11-28	https://media.rawg.io/media/games/f52/f52cf6ba08089cd5f1a9c8f7fcc93d1f.jpg
705	Red Dead Redemption	2010-05-18	https://media.rawg.io/media/games/686/686909717c3aa01518bc42ae2bf4259e.jpg
706	Killing Floor	2009-05-14	https://media.rawg.io/media/games/806/8060a7663364ac23e15480728938d6f3.jpg
707	Shadowrun Returns	2013-07-24	https://media.rawg.io/media/games/d4b/d4bcd78873edd9992d93aff9cc8db0c8.jpg
708	Grand Theft Auto III	2001-10-22	https://media.rawg.io/media/games/5fa/5fae5fec3c943179e09da67a4427d68f.jpg
709	The Last of Us Part II	2020-06-19	https://media.rawg.io/media/games/909/909974d1c7863c2027241e265fe7011f.jpg
710	Wolfenstein II: The New Colossus	2017-10-25	https://media.rawg.io/media/games/a0e/a0ef08621301a1eab5e04fa5c96978fa.jpeg
711	Call of Duty: Black Ops III	2015-11-06	https://media.rawg.io/media/games/fd6/fd6a1eecd3ec0f875f1924f3656b7dd9.jpg
712	Dead Cells	2018-08-07	https://media.rawg.io/media/games/f90/f90ee1a4239247a822771c40488e68c5.jpg
713	Papers, Please	2013-08-08	https://media.rawg.io/media/games/6d3/6d33014a4ed48a19c30a77ead5a0f62e.jpg
714	Lara Croft and the Temple of Osiris	2014-12-08	https://media.rawg.io/media/games/1fb/1fb1c5f7a71d771f440b27ce7f71e7eb.jpg
715	Magicka	2011-01-25	https://media.rawg.io/media/games/c7a/c7a71a0531a9518236d99d0d60abe447.jpg
716	Divinity: Original Sin 2	2017-09-14	https://media.rawg.io/media/games/424/424facd40f4eb1f2794fe4b4bb28a277.jpg
717	Dead Island	2011-09-06	https://media.rawg.io/media/games/56e/56ed40948bebaf1968234aa6e3c74771.jpg
718	The Last Of Us	2013-06-14	https://media.rawg.io/media/games/a5a/a5a7fb8d9cb8063a8b42ee002b410db6.jpg
719	Subnautica	2018-01-23	https://media.rawg.io/media/games/739/73990e3ec9f43a9e8ecafe207fa4f368.jpg
720	South Park: The Stick of Truth	2014-03-04	https://media.rawg.io/media/games/8ca/8ca40b562a755d6a0e30d48e6c74b178.jpg
721	FEZ	2012-04-13	https://media.rawg.io/media/games/4cb/4cb855e8ef1578415a928e53c9f51867.png
722	A Plague Tale: Innocence	2019-05-13	https://media.rawg.io/media/games/b4a/b4adf80c36e267b35acc3497ed2af19c.jpg
723	DiRT Rally	2015-12-07	https://media.rawg.io/media/games/78d/78dfae12fb8c5b16cd78648553071e0a.jpg
724	Castle Crashers	2008-08-27	https://media.rawg.io/media/games/d1a/d1a1202a378607b6c635c8f18ace95dd.jpg
725	Darkest Dungeon	2016-01-18	https://media.rawg.io/media/games/fd9/fd92f105dcd6491bc5d61135033d1f19.jpg
726	Star Wars: Knights of the Old Republic	2003-07-15	https://media.rawg.io/media/games/6e0/6e0c19bb111bd4fa20cf0eb72a049519.jpg
727	Resident Evil 4 (2005)	2005-01-11	https://media.rawg.io/media/games/fee/fee0100afd87b52bfbd33e26689fa26c.jpg
730	Call of Duty: Black Ops	2010-11-09	https://media.rawg.io/media/games/410/41033a495ce8f7fd4b0934bdb975f12a.jpg
731	Chivalry: Medieval Warfare	2012-10-16	https://media.rawg.io/media/games/7f0/7f021d4a3577ac9d591a628a431fc2e5.jpg
732	The Binding of Isaac	2011-09-28	https://media.rawg.io/media/games/cef/cefedf18016cbab466861eb698daf988.jpg
733	Dragon Age: Origins	2009-11-03	https://media.rawg.io/media/games/dc0/dc0926d3f84ffbcc00968fe8a6f0aed3.jpg
734	Syberia	2002-01-09	https://media.rawg.io/media/games/852/8522935d8ab27b610a254b52de0da212.jpg
735	DmC: Devil May Cry	2013-01-15	https://media.rawg.io/media/games/295/295eb868c241e6ad32ac033b8e6a2ede.jpg
736	Dead Space 2	2011-01-25	https://media.rawg.io/media/games/ae1/ae1518c3dc1e847344661905fd2a8d16.jpg
737	Rayman Legends	2013-08-29	https://media.rawg.io/media/games/85c/85c8ae70e7cdf0105f06ef6bdce63b8b.jpg
738	Devil May Cry 5	2019-03-08	https://media.rawg.io/media/games/9fb/9fbf956a16249def7625ab5dc3d09515.jpg
739	Batman: Arkham City	2011-10-18	https://media.rawg.io/media/games/b5a/b5a1226bfd971284a735a4a0969086b3.jpg
740	Yakuza 0	2015-03-12	https://media.rawg.io/media/games/ca1/ca16da30f86d8f4d36261de45fb35430.jpg
741	Fallout 3	2008-10-28	https://media.rawg.io/media/games/5a4/5a4e70bb8a862829dbaa398aa5f66afc.jpg
742	Beyond: Two Souls	2013-10-07	https://media.rawg.io/media/games/07a/07a74470a2618fd71945db0619602baf.jpg
743	Days Gone	2019-04-26	https://media.rawg.io/media/games/a79/a79d2fc90c4dbf07a8580b19600fd61d.jpg
744	Torchlight II	2012-09-20	https://media.rawg.io/media/games/c06/c06d88c35785c8003147cb53c84af033.jpg
745	SUPERHOT	2016-02-24	https://media.rawg.io/media/screenshots/ad4/ad445a12ee46543d4d117f3893041ebf.jpg
746	Battlefield 4	2013-10-29	https://media.rawg.io/media/games/ac7/ac7b8327343da12c971cfc418f390a11.jpg
747	What Remains of Edith Finch	2017-04-23	https://media.rawg.io/media/games/34e/34e100b1f648de99f32d477065f04653.jpg
749	Homefront	2011-03-15	https://media.rawg.io/media/games/657/657574cd437df9102f511b3be095b0ea.jpg
750	Call of Duty: WWII	2017-11-03	https://media.rawg.io/media/games/1e5/1e5e33b88be978f451196a751424a72e.jpg
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.genres (genreid, name) FROM stdin;
1	Action
2	Indie
3	Adventure
4	RPG
5	Strategy
6	Shooter
7	Casual
8	Simulation
9	Puzzle
10	Arcade
11	Platformer
12	Massively Multiplayer
13	Racing
14	Sports
15	Fighting
16	Family
17	Board Games
18	Card
19	Educational
\.


--
-- Data for Name: platform; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.platform (platformid, name) FROM stdin;
1	PC
2	PlayStation 5
3	Xbox One
4	PlayStation 4
5	Xbox Series S/X
6	Nintendo Switch
7	iOS
8	Android
9	Nintendo 3DS
10	Nintendo DS
12	macOS
13	Linux
14	Xbox 360
15	Xbox
16	PlayStation 3
17	PlayStation 2
19	PS Vita
20	PSP
21	Wii U
22	Wii
23	GameCube
25	Game Boy Advance
30	Classic Macintosh
46	Dreamcast
51	Web
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.reviews (reviewid, userid, gameid, content, rating, date_posted) FROM stdin;
\.


--
-- Data for Name: user_favorites; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_favorites (userid, gameid) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (userid, username, email, password) FROM stdin;
7	admin	admin@playlogue.com	$2y$10$mXh.oE7jKk.skLHZkYmVSeEiwz0uYb0nn8g.ad.79ELb1cGYkz/7G
8	alejandro	aromero@gmail.com	$2y$10$6JSRHtoKWfI0/RHE.boxp.fxBtTpqIBKgAj9EcH/2QthAQ.ToeIrq
\.


--
-- Name: games_gameid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.games_gameid_seq', 1052, true);


--
-- Name: genres_genreid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.genres_genreid_seq', 20, true);


--
-- Name: platform_platformid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.platform_platformid_seq', 52, true);


--
-- Name: reviews_reviewid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.reviews_reviewid_seq', 10, true);


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_userid_seq', 8, true);


--
-- Name: game_genre game_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_genre
    ADD CONSTRAINT game_genre_pkey PRIMARY KEY (gameid, genreid);


--
-- Name: game_platform game_platform_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT game_platform_pkey PRIMARY KEY (gameid, platformid);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (gameid);


--
-- Name: games games_unique; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_unique UNIQUE (title);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genreid);


--
-- Name: platform platform_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.platform
    ADD CONSTRAINT platform_pkey PRIMARY KEY (platformid);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (reviewid);


--
-- Name: user_favorites user_favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_favorites
    ADD CONSTRAINT user_favorites_pkey PRIMARY KEY (userid, gameid);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: game_genre fk_game; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_genre
    ADD CONSTRAINT fk_game FOREIGN KEY (gameid) REFERENCES public.games(gameid) ON DELETE CASCADE;


--
-- Name: game_platform fk_game; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT fk_game FOREIGN KEY (gameid) REFERENCES public.games(gameid) ON DELETE CASCADE;


--
-- Name: user_favorites fk_game; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_favorites
    ADD CONSTRAINT fk_game FOREIGN KEY (gameid) REFERENCES public.games(gameid) ON DELETE CASCADE;


--
-- Name: reviews fk_game; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_game FOREIGN KEY (gameid) REFERENCES public.games(gameid) ON DELETE CASCADE;


--
-- Name: game_genre fk_genre; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_genre
    ADD CONSTRAINT fk_genre FOREIGN KEY (genreid) REFERENCES public.genres(genreid) ON DELETE CASCADE;


--
-- Name: game_platform fk_platform; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT fk_platform FOREIGN KEY (platformid) REFERENCES public.platform(platformid) ON DELETE CASCADE;


--
-- Name: user_favorites fk_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_favorites
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: reviews fk_user; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_user FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: game_genre game_genre_gameid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_genre
    ADD CONSTRAINT game_genre_gameid_fkey FOREIGN KEY (gameid) REFERENCES public.games(gameid);


--
-- Name: game_genre game_genre_genreid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_genre
    ADD CONSTRAINT game_genre_genreid_fkey FOREIGN KEY (genreid) REFERENCES public.genres(genreid);


--
-- Name: game_platform game_platform_gameid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT game_platform_gameid_fkey FOREIGN KEY (gameid) REFERENCES public.games(gameid);


--
-- Name: game_platform game_platform_platformid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_platform
    ADD CONSTRAINT game_platform_platformid_fkey FOREIGN KEY (platformid) REFERENCES public.platform(platformid);


--
-- Name: reviews reviews_gameid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_gameid_fkey FOREIGN KEY (gameid) REFERENCES public.games(gameid);


--
-- Name: reviews reviews_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: user_favorites user_favorites_gameid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_favorites
    ADD CONSTRAINT user_favorites_gameid_fkey FOREIGN KEY (gameid) REFERENCES public.games(gameid);


--
-- Name: user_favorites user_favorites_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_favorites
    ADD CONSTRAINT user_favorites_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: admin
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

