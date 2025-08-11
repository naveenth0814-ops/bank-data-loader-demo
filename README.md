# Bank Data Loader Demo (Sample)

**Project:** Automated Data Loading & Validation for Banking Applications (Dummy/sample)

## Overview
This is a self-contained sample repository demonstrating an end-to-end automated data loading
pipeline using Oracle SQL*Loader, PL/SQL validation, Unix Shell scripting, Autosys job (JIL sample),
and a sample GitLab CI/CD pipeline. All data is anonymized/dummy and suitable to showcase as a
work sample on job portals like Naukri Gulf or GitHub.

## Tech Stack
- Oracle Database (12c/19c) - sample SQL/PLSQL
- SQL*Loader (control file sample)
- Unix Shell scripting (bash)
- Autosys (JIL sample)
- GitLab CI/CD (.gitlab-ci.yml sample)

## File Structure
- sql/create_table.sql            -> Create dummy table for sample data
- data/sample_data.csv            -> Dummy CSV to be loaded
- control/sample_control.ctl      -> SQL*Loader control file
- plsql/pkg_data_loader.sql       -> Sample PL/SQL package for validation
- scripts/load_files.sh           -> Shell script to call sqlldr and validation
- autosys/load_job.jil            -> Sample Autosys JIL job
- .gitlab-ci.yml                  -> Sample GitLab CI configuration
- docs/Implementation_Plan.md     -> Short implementation and rollback plan
- Automated_Data_Loading_Sample.md-> 1-page project summary (good for Naukri upload)

## How to use (local/demo)
1. Review SQL in `sql/create_table.sql` then run it in your Oracle environment:
   ```
   sqlplus / as sysdba @sql/create_table.sql
   ```
2. Place `data/sample_data.csv` on the server and update paths in `control/sample_control.ctl`.
3. Run SQL*Loader (replace placeholders):
   ```bash
   sqlldr userid=YOUR_USER/YOUR_PASS@YOUR_DB control=control/sample_control.ctl log=logs/load.log
   ```
4. After load, run PL/SQL validation (example in scripts/load_files.sh uses sqlplus):
   ```bash
   bash scripts/load_files.sh
   ```
5. To simulate CI/CD, check `.gitlab-ci.yml` for simple pipeline stages.

## Notes
- All code is sample/dummy. Remove or replace placeholders before running in production.
- No client data included.

