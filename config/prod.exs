import Config

config :logger,
  level: :info

config :urepo,
  token: "secret",
  private_key: "private.pem",
  public_key: "public.pem",
  store: {Urepo.Store.Local, path: "/tmp/repo"}
