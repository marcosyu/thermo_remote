class StatQueryService
  def initialize
  end

  def call
    Reading.find_by_sql(
      "SELECT * FROM readings;"
    )
  end
end
