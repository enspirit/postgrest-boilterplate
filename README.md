# PostgREST + DbAgent + Webspicy - A boilerplate

This repository is a boilerplate for developing an API with:

- [PostgreSQL](https://postgresql.org) as relational database
- [PostgREST](https://postgrest.org/) as RESTful API from database objects
- [DbAgent](https://github.com/enspirit/dbagent) for migrations & seeds
- [Webspicy](https://github.com/enspirit/webspicy) for black-box tests

## Getting started (yet, see configuration section later)

From a fresh clone and/or copy:

```
make install
make up
make test
```

There is already a webspicy test that checks that the OpenAPI specification
returned by PostgREST is correctly served.

## First steps

1. Add a database migration with additional tables & views in dbagent/migrations
2. Add some data in dbagent/data/test/base/
3. Add a new test in tests/formaldoc
4. Run `make db.migrate db.base api.up test`
5. Repeat

## Configuration

The default configuration creates

- an `example` database accessed by an `example` (super)user
- an `api` schema, `authenticator` and `anon` roles for PostgREST

If you want to change those defaults:

- Edit `postgres/env/devel.env` and `dbagent/env/devel.env` for the database
- Edit `api/env/devel.env` for PostgREST

Then reinstall the whole stuff:

```
make install
make up
make test
```
