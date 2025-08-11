/* pkg_data_loader.sql - Sample PL/SQL package for validation and move */
CREATE OR REPLACE PACKAGE pkg_data_loader IS
  PROCEDURE validate_and_move(p_batch_id IN NUMBER := NULL);
END pkg_data_loader;
/
CREATE OR REPLACE PACKAGE BODY pkg_data_loader IS
PROCEDURE validate_and_move(p_batch_id IN NUMBER := NULL) IS
  CURSOR c_bad_rows IS
    SELECT * FROM demo_staging WHERE txn_amount <= 0 OR acct_no IS NULL;
  TYPE t_row IS TABLE OF demo_staging%ROWTYPE;
  l_bad t_row;
BEGIN
  OPEN c_bad_rows;
  FETCH c_bad_rows BULK COLLECT INTO l_bad LIMIT 1000;
  IF l_bad.COUNT > 0 THEN
    -- Example: mark bad rows as rejected
    FOR i IN 1..l_bad.COUNT LOOP
      UPDATE demo_staging SET status = 'REJECTED' WHERE ROWID = ROWID;
      -- (In real code, use a primary key or unique identifier)
    END LOOP;
  END IF;
  -- Move valid rows to target
  INSERT INTO demo_target (acct_no, txn_amount, txn_date, status, created_ts)
  SELECT acct_no, txn_amount, txn_date, 'LOADED', SYSDATE FROM demo_staging WHERE NVL(status,'') <> 'REJECTED';
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;
END validate_and_move;
END pkg_data_loader;
/
