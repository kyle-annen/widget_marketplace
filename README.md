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

Run the following mix commands to bootstrap the project.
```
mix deps.get
mix ecto.create
mix ecto.migrate
```

Run the server with the following:
```
mix phx.server
```



