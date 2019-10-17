module CalculateHelper
  def calc_vat(gross)
    vat = gross / 5
    "#{vat}"
  end

  def calc_net(gross)
    vat = gross / 5
    net = gross - vat
    "#{net}"
  end
end
