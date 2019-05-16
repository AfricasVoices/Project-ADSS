# Project ADSS
Data pipeline for ADSS.

This pipeline fetches all project data from a Rapid Pro instance, and processes it to produce CSV files suitable
for downstream analysis.

## Pre-requisites
Before the pipeline can be run, the following tools must be installed:
 - Docker
 - Bash
 
Development requires the following additional tools:
 - Python 3.6+
 - pipenv
 - git

## Usage
Running the pipeline requires 
(1) creating a phone number <-> UUID table to support de-identification of respondents, 
(2) optionally downloading coded data from Coda, 
(3) fetching all the relevant data from Rapid Pro, 
(4) processing the raw data to produce the outputs required for coding and then for analysis
(5) uploading new data to Coda for manual verification and coding, and
(6) optionally backing-up the project data root.

To simplify the configuration and execution of these stages, this project includes a `run_scripts`
directory, which contains shell scripts for driving each of those stages. 
More detailed descriptions of the functions of each of those stages, and instructions for using
the run scripts, are provided below. 

### 1. Phone Number <-> UUID Table
When running the pipeline for the first time, create an empty phone number <-> UUID table by running the following 
command in the `run_scripts` directory:

```
$ ./0_create_uuid_table.sh <data-root> 
```

where `data-root` is an absolute path to the directory in which all pipeline data should be stored. 
The UUID table will be saved to a file in the directory `<data-root>/UUIDs`.

### 2. Download Coded Data from Coda
This stage downloads coded datasets for this project from Coda (and is optional if manual coding hasn't started yet).
To use, run the following command from the `run_scripts` directory: 

```
$ ./1_coda_get.sh <coda-auth-file> <coda-tools-root> <data-root>
```

where:
- `coda-auth-file` is an absolute path to the private credentials file for the Coda instance to download coded datasets from.
- `coda-tools-root` is an absolute path to [CodaV2](https://github.com/AfricasVoices/CodaV2) repository's 
  data_tools directory (which contains the `get.py` script).
- `data-root` is an absolute path to the directory in which all pipeline data should be stored.
  Downloaded Coda files are saved to `<data-root>/Coded Coda Files/<dataset>.json`.

### 3. Fetch Raw Data
This stage fetches all the raw data required by the pipeline from Rapid Pro.
To use, run the following command from the `run_scripts` directory:

```
$ ./2_fetch_raw_data.sh <user> <google-cloud-credentials-file-path> <pipeline-configuration> <data-root>
```

where:
- `user` is the identifier of the person running the script, for use in the TracedData Metadata 
   e.g. `user@africasvoices.org` 
- `google-cloud-credentials-file-path` is an absolute path to a json file containing the private key credentials
  for accessing a cloud storage credentials bucket containing all the other project credentials files.
- `pipeline-config-file-path ` is an absolute path to a pipeline configuration json file.
 - `data-root` is an absolute path to the directory in which all pipeline data should be stored.
   Raw data will be saved to TracedData JSON files in `<data-root>/Raw Data`.

### 4. Generate Outputs
This stage processes the raw data to produce outputs for ICR, Coda, and messages/individuals/production
CSVs for final analysis.
To use, run the following command from the `run_scripts` directory:

```
$ ./3_generate_outputs.sh [--drive-upload <drive-service-account-credentials-url> <drive-upload-dir>] <user> <data-root>
```

where:
 - `--drive-upload` is an optional flag for uploading the messages, individuals, and production CSVs to Drive.
   If this flag set, pass the arguments:
  - `drive-service-account-credentials-url`, a gs URL to the private credentials file of a Google Drive service account.
    This service account will be used to upload outputted data for analysis to a directory on Google Drive.
  - `drive-upload-dir`, the path to a directory in Google Drive to upload the messages, individuals, and production 
    CSVs to. Before files can be uploaded to a directory, the directory must be shared with the service account's 
    email address (which can be found in the `client_email` field of the service account's credentials file).
 - `user` is the identifier of the person running the script, for use in the TracedData Metadata 
   e.g. `user@africasvoices.org`.
 - `data-root` is an absolute path to the directory in which all pipeline data should be stored.
   All output files will be saved in `<data-root>/Outputs`.
   
As well as uploading the messages, individuals, and production CSVs to Drive, this stage outputs the following to
`<data-root>/Outputs`:
 - Local copies of the messages, individuals, and production CSVs (`csap_mes.csv`, `csap_ind.csv`, `csap_prod.csv`)
 - A serialized export of the list of TracedData objects representing all the data that was exported for analysis 
   (`traced_data.json`)
 - For each week of radio shows, a random sample of 200 messages that weren't classified as noise, for use in ICR (`ICR/`)
 - Coda V2 messages files for each dataset (`Coda Files/<dataset>.json`). To upload these to Coda, see the next step.

### 5. Upload Auto-Coded Data to Coda
This stage uploads messages to Coda for manual coding and verification.
Messages which have already been uploaded will not be added again or overwritten.
To use, run the following command from the `run_scripts` directory:

```
$ ./4_coda_add.sh <coda-auth-file> <coda-tools-root> <data-root>
```

where:
- `coda-auth-file` is an absolute path to the private credentials file for the Coda instance to download coded datasets from.
- `coda-tools-root` is an absolute path to [CodaV2](https://github.com/AfricasVoices/CodaV2) repository's 
  data_tools directory (which contains the `get.py` script).
- `data-root` is an absolute path to the directory in which all pipeline data should be stored.
  Downloaded Coda files are saved to `<data-root>/Coded Coda Files/<dataset>.json`.

### 6. Back-up the Data Directory
This stage makes a backup of the project data directory by creating a compressed, versioned, time-stamped copy at the
requested location.
To use, run the following command from the `run_scripts` directory:

```
$ ./5_backup_data_root.sh <data-root> <data-backups-dir>
```

where:
- `data-root` is an absolute path to the directory to back-up.
- `data-backups-dir` is a directory which the `data-root` directory will be backed-up to.
  The data is gzipped and given the name `data-<utc-date-time-now>-<git-HEAD-hash>`.


## Development

### Profiling
To run the main processing stage with statistical cpu profiling enabled, pass the argument 
`--profile-cpu <profile-output-file>` to `run_scripts/3_generate_outputs.sh`.
The output file is generated by the statistical profiler [Pyflame](https://github.com/uber/pyflame), and is in a 
format compatible suitable for visualisation using [FlameGraph](https://github.com/brendangregg/FlameGraph).
