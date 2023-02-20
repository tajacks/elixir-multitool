defmodule Multitool.MixProject do
  use Mix.Project

  def project do
    [
      app: :multitool,
      description: "A collection of functions useful for programming challenges and beyond",
      source_url: "https://github.com/tajacks/elixir-multitool",
      homepage_url: "https://github.com/tajacks/elixir-multitool",
      version: "0.3.4",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp package do
    [
      name: "multitool",
      licenses: ["GPL-3.0-only"],
      links: %{"GitHub" => "https://github.com/tajacks/elixir-multitool"}
    ]
  end
end
