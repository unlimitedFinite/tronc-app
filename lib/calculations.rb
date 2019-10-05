module Calculations
  def vat_and_net_for(gross)
    vat = gross / 5
    net = gross - vat
    [vat, net]
  end
end

