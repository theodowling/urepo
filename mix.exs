defmodule Urepo.MixProject do
  use Mix.Project

  def project do
    [
      app: :urepo,
      version: "0.4.0",
      elixir: "~> 1.10",
      elixirc_paths: paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls],
      deps: deps(),
      docs: docs(),
      aliases: [test: "test --no-start"]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :crypto],
      mod: {Urepo.Application, []},
      env: [
        name: "urepo",
        port: 8080
      ]
    ]
  end

  defp paths(:test), do: ~w[lib test/support]
  defp paths(_), do: ~w[lib]

  defp docs do
    [
      main: "readme",
      formatters: ["html"],
      extras: ~w[
        guides/configuration.md
        README.md
        CHANGELOG.md
      ],
      groups_for_modules: [
        Stores: ~r/^Urepo\.Store\./
      ]
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.6"},
      {:hex_core, "~> 0.10.0"},
      {:ex_aws_s3, "~> 2.5.2"},
      {:sweet_xml, "~> 0.7.4"},
      {:jason, "~> 1.4.1"},
      {:hackney, "~> 1.20.1"},
      # Development tools
      {:dialyxir, "~> 1.4.2", only: :dev, runtime: false},
      {:credo, "~> 1.7.1", only: :dev, runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, ">= 0.0.0", only: [:dev, :test], runtime: false}
    ]
  end
end
