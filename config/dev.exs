import Config

config :urepo,
  token: "secret",
  private_key: "private.pem",
  public_key: "public.pem",
  store: {Urepo.Store.Local, bucket: "repo", path: "repo"}

config :ex_aws, :s3,
  region: "",
  scheme: "http://",
  host: "localhost",
  port: 9000,
  access_key_id: "minioadmin",
  secret_access_key: "minioadmin"
