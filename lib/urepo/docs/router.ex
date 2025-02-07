defmodule Urepo.Docs.Router do
  @moduledoc false

  use Plug.Router

  alias Urepo.Docs
  alias Urepo.Docs.View

  import Urepo.Endpoint, only: [route: 2, redirect: 2, set_inferred_content_type: 2]

  plug(:set_inferred_content_type)
  plug(:match)
  plug(:dispatch)

  get "/" do
    names = Docs.names()

    View.send(conn, :index, names: names)
  end

  get "/:package" do
    case Docs.newest(package) do
      {:ok, version} ->
        redirect(conn, route(conn, "#{package}/#{version}/index.html"))

      _ ->
        send_resp(conn, 404, "")
    end
  end

  get "/:package/:version" do
    case Version.parse(version) do
      {:ok, _} -> redirect(conn, route(conn, "#{package}/#{version}/index.html"))
      _ -> send_resp(conn, 404, "")
    end
  end

  get "/:package/:version/docs_config.js" do
    case Docs.versions(package) do
      {:ok, versions} ->
        versions =
          for version <- versions do
            [
              ~S({"version":"v),
              version,
              ~S(","url":"),
              route(conn, "#{package}/#{version}"),
              ~S("})
            ]
          end

        send_resp(conn, 200, [
          "var versionNodes=[",
          Enum.intersperse(versions, ?,),
          "];"
        ])

      _ ->
        send_resp(conn, 200, "")
    end
  end

  get "/:package/:version/*path" do
    case Docs.file(package, version, Path.join(path)) do
      {:ok, content} -> send_resp(conn, 200, content)
      _ -> send_resp(conn, 404, "")
    end
  end

  get _ do
    send_resp(conn, 404, "Not found")
  end
end
