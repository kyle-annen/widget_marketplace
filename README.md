# Widget Marketplace

A barebones marketplace for widgets.

## Getting started

Clone the repo, and install dependencies.

### Dependencies

The following should be install prior to running the project:

- elixir 1.11.2
- erlang 23.1.2
- Postgres 13 (11+ is probably fine)

There is a `.tool-versions` file for convineince in installing elixir and OTP via asdf.

```
asdf install
```

Postgres can be installed from the [Postgres website](https://postgresapp.com/)

Run the following mix commands to bootstrap the project.
```
mix deps.get
mix ecto.create
mix ecto.migrate
```

Install NPM dependencies:
```
npm install --prefix assets/
```

Run the server with the following, the user interface is fully functional @ http://localhost:4000/
```
mix phx.server
```

Run the tests with the following:
```
mix test
```

# Technology choices
- Elixir: My go to language for backend services.
- Postgres: I always ask "Why not postgres", and I think that answer should be compelling. Super mature, open source.
- Phoenix: Even for APIs, I find Phoenix to offer many of the features I would like to have.

# Design decisions
- Utilized the repository pattern. I believe in most cases, we can use generalized functions for access to the datbase. Additionally, if their comes a time when the database needs to be swapped, or multiple adapters need to be utilized, the repository provides a seam that makes this much simpler.
- Tests are exclusively on the `WidgetMarkeplace` portion of the application. This is purely due to time. I wanted to test well where I needed to, and I just don't think that I had the time to test all actions on the front end. As it was, I spent ~8 hours on the entire project.
- Utilized the below dependencies for the reasons stated below.
- The `WidgetMarkeplace` has more documentation around the business logic.
- I chose to use integer for currency. The goal was to use the `Money` library, which is a bit similar to Authentication, generally suggested not to roll your own, and I didn't have the time to go down the "How do we store currency" rabbit hole. Would be next on the to-do.

# Hex dependencies

#### argon2_elixir
This dependecy is need to ensure the hashing used is strong enough to last in production for a few years.

#### ecto_sql
This dependecy is needed in order to use Ecto with the postgres database.

#### guardian
This dependecy is used for session tokens, and authorization.

#### jason
This dependecy is use to serialize/deserialize JSON.

#### phoenix
This is the base web framework.

#### phoenix_ecto
This is the plugin which integrates phoenix and ecto

#### phoenix_html
This plugin provides many methods for creating html markup dynamically using helpers.

#### phoenix_live_dashboard
This plugin now ships with phoenix. Link is removed, but can still be visited at `http://localhost:4000/dashboard`

#### phoenix_live_reload
This dependecy is used for development, hot reloads code changes while the dev server is running.

#### postgrex
This dependecy is used by Ecto for the database adapter.

#### telemetry_metrics
This is the telemetry_metrics plugin, provides convineince methods for gathering metrics.

#### telemetry_poller
Allows to periodically collect measurements and dispatch them as Telemetry events. Ships with phoenix.

#### plug_cowboy
Plug adapter for the Erlang Cowboy web server.

#### credo
Configurable static code analyzer, used in development and CI.

#### mix_test_watch
Test watcher to smooth development.

#### dialyxir
Descrepancy analyzer for elixir. Used to check type signature if typespecs are provided, dead/unreachable code, unneeded test, etc. Used in CI.



