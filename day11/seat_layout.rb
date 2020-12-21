class SeatLayout
  def initialize(layout)
    @layout = layout
    @new_layout = nil
    @total_rows = @layout.length
    @total_columns = @layout[0].length
  end

  def [](row, column)
    if row < 0 || column < 0
      nil
    elsif row >= @total_rows || column >= @total_columns
      nil
    else
      @layout[row][column]
    end
  end

  alias_method :seat, :[]

  def set_new_seat(row, column, value)
    @new_layout[row][column] = value
  end

  def shift!
    @new_layout = Marshal.load(Marshal.dump(@layout))

    @layout.each_with_index do |row_of_seats, row|
      row_of_seats.each_with_index do |seat, column|
        @occupied = 0
        @empty = 0
        surrounding_square.each do |pair|
          row_change = pair[0]
          column_change = pair[1]
          seat_to_check = seat(row + row_change, column + column_change)

          while seat_to_check == '.' do
            row_change += pair[0]
            column_change += pair[1]
            seat_to_check = seat(row + row_change, column + column_change)
          end

          if seat_to_check == 'L' || seat_to_check.nil?
            @empty += 1
          else
            @occupied += 1
          end
        end
        if seat == 'L' && @occupied == 0
          set_new_seat(row, column, '#')
        elsif seat == '#' && @occupied >= 5
          set_new_seat(row, column, 'L')
        end
      end
    end
    @changed = @layout != @new_layout
    @layout = @new_layout
    @changed
  end

  def occupied_count
    @layout.map do |row|
      row.select {|seat| seat == '#'}.count
    end.sum
  end

  def to_s
    @layout.map do |row|
      row.join
    end
  end

  private

  def surrounding_square
    square = [-1, 0, 1].product([-1, 0, 1])
    square.reject { |e| e == [0, 0] }
  end
end