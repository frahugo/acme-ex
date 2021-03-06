defmodule MagasinCore.Inventory.OutOfStock do
  @moduledoc """
  A business rule violation when an item is out of stock.
  """

  use CivilCode.BusinessRuleViolation

  @type t :: %__MODULE__{}
end
