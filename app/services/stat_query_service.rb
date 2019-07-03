class StatQueryService
  def initialize
  end

  def call
    sql = "SELECT ROUND(AVG(temperature), 2) AS avg_temperature, ROUND(MIN(temperature), 2) AS min_temperature, ROUND(MAX(temperature), 2) AS max_temperature,
            ROUND(AVG(humidity), 2) AS avg_humidity, ROUND(MIN(humidity), 2) AS min_humidity, ROUND(MAX(humidity), 2) AS max_humidity,
            ROUND(AVG(battery_charge), 2) AS avg_battery_charge, ROUND(MIN(battery_charge), 2) AS min_battery_charge, ROUND(MAX(battery_charge), 2) AS max_battery_charge
           FROM Readings;"
    stats = ActiveRecord::Base.connection.execute(sql)
  end
end
