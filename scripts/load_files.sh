#!/bin/bash
#
# load_files.sh - sample script to run SQL*Loader and PL/SQL validation
# Usage: bash load_files.sh <db_user> <db_pass> <db_connect_string>
#
DB_USER="$1"
DB_PASS="$2"
DB_CONN="$3"
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

if [ -z "$DB_USER" ] || [ -z "$DB_PASS" ] || [ -z "$DB_CONN" ]; then
  echo "Usage: bash load_files.sh DB_USER DB_PASS DB_CONN"
  exit 1
fi

echo "Starting SQL*Loader..."
sqlldr userid=${DB_USER}/${DB_PASS}@${DB_CONN} control=control/sample_control.ctl log=${LOG_DIR}/sqlldr_$(date +%F_%T).log

echo "Running PL/SQL validation..."
sqlplus -s ${DB_USER}/${DB_PASS}@${DB_CONN} <<EOF
SET SERVEROUTPUT ON
EXEC pkg_data_loader.validate_and_move;
EXIT;
EOF

echo "Done."
