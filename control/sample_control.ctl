-- SQL*Loader control file (sample)
LOAD DATA
INFILE 'data/sample_data.csv'
INTO TABLE demo_staging
APPEND
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(acct_no, txn_amount, txn_date "TO_DATE(:txn_date,'YYYY-MM-DD')")
