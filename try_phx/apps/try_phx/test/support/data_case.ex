defmodule TryPhx.DataCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias TryPhx.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import TryPhx.DataCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(TryPhx.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(TryPhx.Repo, {:shared, self()})
    end

    :ok
  end

  @doc """
  A helper that transforms changeset errors into a map of messages.

      assert {:error, changeset} = Accounts.create_user(%{password: "short"})
      assert "password is too short" in errors_on(changeset).password
      assert %{password: ["password is too short"]} = errors_on(changeset)

  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Enum.reduce(opts, message, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
