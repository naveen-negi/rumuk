use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bhaduli,
bucket_type: "test-users",
bucket_name: "test-users"

# Print only warnings and errors during test
config :logger, level: :warn

 config :pooler, pools:
   [
     [
       name: :riaklocal1,
       group: :riak,
       max_count: 20,
       init_count: 10,
       start_mfa: { Riak.Connection, :start_link, ['127.0.0.1', 8087]}
     ]
   ]

