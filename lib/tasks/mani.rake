require 'csv'

task :mani => [:environment] do
  file = "aa.csv"

  CSV.foreach(file, :headers => true) do |row|
    p row[0]
    p row[1]
    p row[3]
    p row[4]
    p row[5]
    p row[6]
    p player =  Player.new(
          first_name: row[0],
          last_name: row[1],
          is_cricket: row[2],
          is_football: row[3],
          is_badminton: row[4],
          sex: row[5],
          base_price: row[6],
          in_for_auction: row[7],
          is_star: row[9]
      )
    player.save!
  end

end