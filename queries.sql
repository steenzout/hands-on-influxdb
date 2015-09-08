SELECT MEDIAN(internal) FROM temperature WHERE time > '2015-09-08T05:14:00Z' GROUP BY time(1m);

SELECT MEDIAN(internal) FROM temperature WHERE time > NOW() - 12h GROUP BY time(1m)

SELECT PERCENTILE(internal, 80) FROM temperature WHERE time > NOW() - 10h GROUP BY time(1m)


