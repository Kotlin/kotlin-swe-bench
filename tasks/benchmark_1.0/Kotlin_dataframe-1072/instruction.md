# Implement the issue(s) in Kotlin/dataframe:

## Issue #988 https://github.com/Kotlin/dataframe/issues/988: `renameToCamelCase` works is not as expected

              it did from ID       ITEM  PRICE ORDER_DATE ->  iD       iTEM  pRICE  oRDERDATE"

_Originally posted by @zaleslaw in https://github.com/Kotlin/dataframe/pull/986#discussion_r1870008458_

It handles mostly the typical use-case, when we are reading from CSV file, created somewhere in Python, but when we are reading from the databases, it mostly using the capital letters, which we need to lowercase
            
