defmodule AB.Devices do
  @moduledoc """
  The Devices context.
  """

  import Ecto.Query, warn: false
  alias AB.Repo
  alias AB.Devices.Device

  @doc """
  Returns the list of devices.

  ## Examples
      iex> list_devices()
      [%Device{}, ...]
  """
  def list_devices do
    Repo.all(Device)
  end

  @doc """
  Find or register new device.
  Returns deices with experiment and option
  """
  def find_or_register_device(token \\ "s1") do
    case list_devices_experiments(token) do
      {:ok, devices} ->
        {:ok, devices}
      :not_found ->
        with {_, _} = register_device!(token) do
          find_or_register_device(token)
        end
    end
  end

  @doc """
  Registers a new device with available experiments and options
  """
  def register_device!(token) do
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now, :second)
    devices_attr = AB.Options.Dispatcher.get()
      |> Enum.map(&Map.merge(&1, %{token: token, inserted_at: now, updated_at: now}))
    Repo.insert_all(Device, devices_attr)
  end

  @doc """
  List devices by token with experiment and option preloaded
  """
  def list_devices_experiments!(token \\ "s1") do
    query = from d in Device,
            where: d.token == ^token,
            preload: [:option, :experiment]
    Repo.all(query)
  end

  @doc """
  List devices by token with experiment and option
  """
  def list_devices_experiments(token \\ "s1") do
    case list_devices_experiments!(token) do
           [] -> :not_found
      devices -> {:ok, devices}
    end
  end

  @doc """
  Gets devices by token
  """
  def list_devices_by_token!(token) do
    query = from d in Device,
            where: d.token == ^token,
            preload: [:option]
    Repo.all(query)
  end

  @doc """
  Gets devices by token,
  return tuple
  """
  def list_devices_by_token(token) do
    case list_devices_by_token!(token) do
           [] -> {:error, "Device not found"}
      devices -> {:ok, devices}
    end
  end

  @doc """
  Gets a single device.

  Raises `Ecto.NoResultsError` if the Device does not exist.

  ## Examples

      iex> get_device!(123)
      %Device{}

      iex> get_device!(456)
      ** (Ecto.NoResultsError)

  """
  def get_device!(id), do: Repo.get!(Device, id)

  @doc """
  Creates a device.

  ## Examples

      iex> create_device(%{field: value})
      {:ok, %Device{}}

      iex> create_device(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_device(attrs \\ %{}) do
    %Device{}
    |> Device.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a device.

  ## Examples

      iex> update_device(device, %{field: new_value})
      {:ok, %Device{}}

      iex> update_device(device, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_device(%Device{} = device, attrs) do
    device
    |> Device.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Device.

  ## Examples

      iex> delete_device(device)
      {:ok, %Device{}}

      iex> delete_device(device)
      {:error, %Ecto.Changeset{}}

  """
  def delete_device(%Device{} = device) do
    Repo.delete(device)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking device changes.

  ## Examples

      iex> change_device(device)
      %Ecto.Changeset{source: %Device{}}

  """
  def change_device(%Device{} = device) do
    Device.changeset(device, %{})
  end
end
