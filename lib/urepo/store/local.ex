defmodule Urepo.Store.Local do
  @moduledoc """
  Storage that uses locally mounted filesystem for storing the packages.

  ## Options

  - `:path` - local path where all the packages will be stored
  """

  @behaviour Urepo.Store

  require Logger

  @impl true
  def put(path, content, opts) do
    root = Keyword.fetch!(opts, :path)
    file_path = Path.join(root, path)

    Logger.debug("Saving data to #{file_path}")

    with :ok <-
           file_path
           |> Path.dirname()
           |> File.mkdir_p(),
         do: File.write(file_path, content)
  end

  @impl true
  def fetch(path, opts) do
    root = Keyword.fetch!(opts, :path)
    file_path = Path.join(root, path)

    Logger.debug("Fetching data form #{file_path}")

    with :ok <-
           file_path
           |> Path.dirname()
           |> File.mkdir_p(),
         do: File.read(file_path)
  end
end
