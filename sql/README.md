# SQL Scripts

Any files in this directory will be mounted as a volume in the running PostGres container, making them available for execution. 

To run a file, from the project root run:

```bash
./pg-local.sh execute <my_file_name>.sql
```

Do not include the full path, just the name of the file. So to run the example script, run:

```bash
./pg-local.sh execute example.sql
```
