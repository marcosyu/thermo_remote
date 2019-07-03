class ReadingSerializer
  include FastJsonapi::ObjectSerializer

  attributes :temperature, :humidity, :battery_charge, :tracking_number

  belongs_to :thermostat

end
