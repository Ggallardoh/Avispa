# generate 10 clients
(1..10).each do
    Client.create!(
        name: Faker::Name.name
    )
end
# generate 50 events
states = ["published", "created"]
(1..50).each do
    e = Event.create!(
        client_id: rand(1..10),
        name: Faker::Movie.title,
        description: Faker::Lorem.paragraph,
        image: Faker::File.file_name(dir: 'path/to'),
        start_date: Faker::Date.between(from: 2.days.ago, to: 2.weeks.from_now),
        publish_date: Faker::Date.between(from: 2.weeks.ago, to: Date.today),
        state: states.sample,
        slug: Faker::Alphanumeric.alpha(number: 10),
        available_tickets: Faker::Number.number(digits: 2),
        price: Faker::Number.number(digits: 4),
        created_at: DateTime.now,
        updated_at: DateTime.now
    )
end


