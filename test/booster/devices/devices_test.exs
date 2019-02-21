defmodule AB.DevicesTest do
  use AB.DataCase

  alias AB.Devices
  alias AB.Experiments

  describe "devices" do
    alias AB.Devices.Device

    @valid_exp_options [
      %{value: "red", percentage: 33},
      %{value: "green", percentage: 33},
      %{value: "blue", percentage: 33}]

    @valid_exp_attrs %{
      description: "some description",
      key: "some_key",
      options: @valid_exp_options}

    @valid_device_attr %{
      token: "some_token"
    }

    def experiment_fixture(attrs \\ %{}) do
      {:ok, experiment} =
        attrs
        |> Enum.into(@valid_exp_attrs)
        |> Experiments.create_experiment()
      Experiments.get_experiment!(experiment.id, [:options])
    end

    def device_fixture(attrs \\ %{}) do
      option = experiment_fixture().options |> List.first()
      attr = Map.merge(@valid_device_attr, %{
        experiment_id: option.experiment_id,
        option_id: option.id
      })
      {:ok, device} =
        attrs
        |> Enum.into(attr)
        |> Devices.create_device()
      device
    end

    test "list_devices/0 returns all devices" do
      device = device_fixture()
      list = Devices.list_devices()
      assert [device] == list
    end

    test "get_device!/1 returns the device with given id" do
      device = device_fixture()
      assert Devices.get_device!(device.id) == device
    end

    test "list_devices_by_token!/1 returns the devices with given token" do
      device = device_fixture()
      assert length(Devices.list_devices_by_token!(device.token)) == 1
    end

    test "create_device/1 with valid data creates a device" do
      option = experiment_fixture().options |> List.first()
      assert {:ok, %Device{} = device} = Devices.create_device(
        Map.merge(@valid_device_attr, %{
          experiment_id: option.experiment_id,
          option_id: option.id
        })
      )
      assert device.experiment_id == option.experiment_id
      assert device.option_id == option.id
      assert device.token == "some_token"
    end

    test "create_device/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Devices.create_device(@valid_device_attr)
    end

    test "delete_device/1 deletes the device" do
      device = device_fixture()
      assert {:ok, %Device{}} = Devices.delete_device(device)
      assert_raise Ecto.NoResultsError, fn -> Devices.get_device!(device.id) end
    end

  end
end
