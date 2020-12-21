class Seat
  def initialize(seat_data)
    @rows = seat_data[0..6].chars
    @columns = seat_data[7..9].chars
  end

  def row
    @row ||= begin
               plane_rows = (0..127).to_a
               @rows.each do |row_action|
                 if row_action == "F"
                   plane_rows = plane_rows.take(plane_rows.count / 2)
                 elsif row_action == "B"
                   plane_rows = plane_rows.drop(plane_rows.count / 2)
                 end
               end
               if plane_rows.count != 1
                 raise "Oh no lots of rows in #{plane_rows}"
               end
               plane_rows.first
             end
  end

  def column
    @column ||= begin
                  plane_columns = (0..7).to_a
                  @columns.each do |column_action|
                    if column_action == "L"
                      plane_columns = plane_columns.take(plane_columns.count / 2)
                    elsif column_action == "R"
                      plane_columns = plane_columns.drop(plane_columns.count / 2)
                    end
                  end
                  if plane_columns.count != 1
                    raise "Oh no lots of columns in #{plane_columns}"
                  end
                  plane_columns.first
                end
  end

  def seat_id
    (row * 8) + column
  end

  def to_s
    "#<Seat: rows:#{@rows}, columns:#{@columns}, row: #{row}, column: #{column}, id: #{seat_id}>"
  end
end