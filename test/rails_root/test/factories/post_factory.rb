Factory.define :post do |factory|
  factory.title 'MyString'
  factory.body 'MyText'
  factory.user { |user| user.association(:user) }
end