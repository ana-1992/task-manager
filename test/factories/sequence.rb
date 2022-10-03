FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :name, :description, :state] do |n|
    "string#{n}"
  end
  sequence :email do |n|
    "person#{n}@gmail.com"
  end
  sequence :expired_at do |n|
    Date.today
  end
end
