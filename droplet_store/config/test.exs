import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :droplet_store, CouchDBEx,
  hostname: "localhost",
  username: "droplet",
  password: "droplet",
  auth_method: :cookie

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :droplet_store, DropletStoreWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "RKHmgG5ub/IBU5ToEeoErziOpPa00XOyvWNvvaqo3tqliUZobZoz6azfuSJhKleh",
  server: false

# In test we don't send emails.
config :droplet_store, DropletStore.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
