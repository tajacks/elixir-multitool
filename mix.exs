defmodule Multitool.MixProject do
  use Mix.Project

  def project do
    [
      app: :multitool,
      description: "A collection of functions useful for programming challenges and beyond",
      source_url: "https://github.com/tajacks/elixir-multitool",
      homepage_url: "https://github.com/tajacks/elixir-multitool",
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
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
