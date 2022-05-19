require 'csv'
require 'date'
# Creation of the seed base on the CSV file

def date_format_conversion(date)
  date = date.to_s.split('/')
  new_date="#{date[2]}-#{date[0]}-#{date[1]}"
  #p new_date.class
  return Date.strptime(new_date, '%Y-%m-%d')
end
CSV.foreach(Rails.root.join('lib/dataset.csv'), headers: true) do |row|
  superstore = Superstore.create!(
    order_id: row['Order ID'],
    order_date: date_format_conversion(row['Order Date']),
    #order_date: Date.strptime(row['Order Date'], '%Y-%m-%d'),
    customer_id: row['Customer ID'],
    state: row['State'],
    region: row['Region'],
    product_id: row['Product ID'],
    sales: row['Sales'],
    quantity: row['Quantity']
  )
  #p date_format_conversion(row['Order Date'])
end
