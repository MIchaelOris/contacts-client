require 'unirest'

system "clear"

puts "You have engaged your Contacts Program"
puts "Please, choose an option: "
puts "      [1] Show all contacts"
puts "        [1.1] Search all contacts"
puts "        [1.2] Sort contacts by first name"
puts "        [1.3] Sort contacts by last time"
puts "      [2] Show one contact"
puts "      [3] Create a new contact"
puts "      [4] Update a contact"
puts "      [5] Destroy a contact"

input_option = gets.chomp
system "clear"



if input_option == "1"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  puts JSON.pretty_generate(contacts)

  elsif input_option == "1.1"
  print "Enter a search term: "
  search_term = gets.chomp

  response = Unirest.get("http://localhost:3000/recipes?search=#{search_term}")
  products = response.body
  puts JSON.pretty_generate(contactss)

elsif input_option == "1.2"
  response = Unirest.get("http://localhost:3000/contacts?sort=first_name")
  contacts = response.body
  puts JSON.pretty_generate(contacts) 
elsif input_option == "1.3"
  response = Unirest.get("http://localhost:3000/recipes?sort=prep_time")
  contacts = response.body
  puts JSON.pretty_generate(contacts) 








elsif input_option == "2"
  print "Enter a contact id: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "3"
  puts "Enter information for a new contact"
  client_params = {}

  print "First Name: "
  client_params[:first_name] = gets.chomp

  print "Middle Name: "
  client_params[:middle_name] = gets.chomp

  print "Last Name: "
  client_params[:last_name] = gets.chomp

  print "Email: "
  client_params[:email] = gets.chomp

  print "Bio: "
  client_params[:bio] = gets.chomp

  print "Phone Number: "
  client_params[:phone_number] = gets.chomp

  response = Unirest.post(
                          "http://localhost:3000/contacts",
                          parameters: client_params
                          )

  if response.code == 200
    contact_data = response.body
    puts JSON.pretty_generate(contact)
  else 
    errors = response.body["errors"]
    errors.each do |error|
      puts error

    end 

  elsif input_option == "4"
  print "Enter a contact id: "
  input_id = gets.chomp

  response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
  contact = response.body

  puts "Enter new information for contact ##{input_id}"
  client_params = {}

  print "First Name (#{contact["first_name"]}): "
  client_params[:first_name] = gets.chomp

  print "Middle Name (#{contact["middle_name"]}): "
  client_params[:middle_name] = gets.chomp

  print "Last Name (#{contact["last_name"]}): "
  client_params[:last_name] = gets.chomp

  print "Email (#{contact["email"]}): "
  client_params[:email] = gets.chomp

  print "Bio (#{contact["bio"]}): "
  client_params[:bio] = gets.chomp

  print "Phone Number (#{contact["phone_number"]}): "
  client_params[:phone_number] = gets.chomp

  client_params.delete_if {|key, value| value.empty? }

  response = Unirest.patch(
                          "http://localhost:3000/contacts/#{input_id}",
                          parameters: client_params
                          )
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "5"
  print "Enter a contact id that you want to delete: "
  input_id = gets.chomp

  response = Unirest.delete("http://localhost:3000/contacts/#{input_id}")
  data = response.body
  puts data["message"]
end


