namespace :clean_infections do
  desc "Removes tempIDs from the Infection db after 2 weeks since they are presumably no longer contagious"
  task clean_infections: :environment do

    # Manual testing
    # user1 = Infection.create(temp_id: "101", created_at: Time.now.to_datetime)
    # user2 = Infection.create(temp_id: "102", created_at: Time.now.to_datetime)
    # user3 = Infection.create(temp_id: "103", created_at: 15.days.ago.to_datetime)
    # user4 = Infection.create(temp_id: "104", created_at: 15.days.ago.to_datetime)
    # user5 = Infection.create(temp_id: "105", created_at: 15.days.ago.to_datetime)

    # Infection.where("created_at > ?", 1.days.ago.to_datetime).delete_all
    # puts "Removed infections added today"

    # The syntax of created_at uses < to mean backward in time and vice versa

    Infection.where("created_at < ?", 14.days.ago.to_datetime).delete_all
    puts "Removed infections older than 14 days"
    #puts "hey working"

  end

end
