`INTERVAL` times and divide with numerics
SQL spec defines a few more operations that are not yet implemented in partiql-lang-kotlin.

Operations include
- [ ] INTERVAL * NUMERIC -> INTERVAL
- [ ] INTERVAL / NUMERIC -> INTERVAL
- [ ] NUMERIC * INTERVAL -> INTERVAL

Example expected query behavior:
```
-- note: the following query currently returns `MISSING`
partiql ▶ INTERVAL '20' YEAR * 2;

=== RESULT ===
INTERVAL '40' YEAR (2)

OK!
```