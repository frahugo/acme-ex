defmodule AcmePlatform.MixProject do
  use Mix.Project

  def project do
    [
      aliases: aliases(),
      apps_path: "apps",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      version: "0.0.0",
      dialyzer: [
        flags: [
          :unmatched_returns,
          :error_handling,
          :race_conditions,
          :underspecs,
          :no_opaque
        ],
        plt_add_deps: :transitive,
        plt_add_apps: [:mix],
        ignore_warnings: "dialyzer.ignore-warnings"
      ],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.html": :test,
        "project.check": :test,
        dialyzer: :test
      ],
      test_coverage: [tool: ExCoveralls],
      # Docs
      name: "Acme - Magasin",
      source_url: "https://github.com/civilcode/acme-platform",
      homepage_url: "https://www.civilcode.io",
      docs: [
        extras: ["README.md"]
      ],
      releases: [
        acme_platform_staging: [
          include_executables_for: [:unix],
          include_erts: true,
          version: "0.0.0",
          applications: [
            civilcode: :permanent,
            runtime_tools: :permanent,
            magasin_demo: :permanent,
            magasin_data: :permanent,
            magasin_web: :permanent,
            master_proxy: :permanent
          ]
        ]
      ]
    ]
  end

  defp aliases do
    [
      "project.seed": ["run apps/magasin_data/priv/seeds.exs"],
      "project.setup": [
        "ecto.drop",
        "ecto.create",
        "demo.load",
        "event_store.init",
        "ecto.migrate",
        "project.seed"
      ],
      "project.check": [
        "compile --force --warnings-as-errors",
        "coveralls --umbrella --timeout 1000",
        "credo --strict",
        "dialyzer"
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.4", only: [:test], runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      # Uncomment this when updating during development
      # {:civil_credo, path: "./packages/civil-credo"},
      {:civil_credo, github: "civilcode/civil-credo", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", runtime: false},
      {:excoveralls, "~> 0.8", only: :test}
    ]
  end
end
