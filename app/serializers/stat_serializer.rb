class StatSerializer
  include FastJsonapi::ObjectSerializer
  set_type :stat  # optional
  set_id :stat_id # optional

  attributes :avg_temperature, :min_temperature, :max_temperature,
    :avg_humidity, :min_humidity, :max_humidity,
    :avg_battery_charge, :min_battery_charge, :max_battery_charge

  # before_initialize :set_id

  # def set_id
  #   @stat_id = 1
  # end
end
