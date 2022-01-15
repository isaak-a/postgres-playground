# PostGres Playground

Just PostGres running in a Docker container, useful for prototyping or as a starting place for projects. 

The wrapper shell script, `pg-local`, spins up a PostGres instance and creates a database called `dev`. 

## Getting Started

Pull the latest PostGres image and spin up a container:

```bash
./pg-local pull
./pg-local create
```

You can run a psql prompt inside the container using: 

```bash
./pg-local prompt
```

Also, any scripts in the `sql/` folder will be executable by the container: 

```bash
./pg-local execute example.sql
```
