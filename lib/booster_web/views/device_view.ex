defmodule ABWeb.DeviceView do
  use ABWeb, :view
  alias ABWeb.DeviceView

  def render("index.json", %{devices: devices}) do
    %{data: render_many(devices, DeviceView, "device.json")}
  end

  def render("show.json", %{device: device}) do
    %{data: render_one(device, DeviceView, "device.json")}
  end

  def render("device.json", %{device: device}) do
    %{
      key: device.experiment.key,
      value: device.option.value
    }
  end
end
