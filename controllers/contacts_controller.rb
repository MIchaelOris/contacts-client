module ContactsController

  def contacts_index_action
    response = Unirest.get("http://localhost:3000/contacts")
    contact_hashs = response.body
    contacts = []

    contact_hashs.each do |contact_hash|
      contacts << Contact.new(contact_hash)
    end

    products_index_view(contacts)
  end

  def contacts_show_action
    print "Enter name: "
    input_name = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts/#{input_name}")
    contact_hash = response.body
    contact = contact.new(contact_hash)

    contacts_show_view(contact)
  end

  def contacts_create_action

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

  def contacts_update_action
    print "Enter name: "
    input_id = gets.chomp

    response = Unirest.get("http://localhost:3000/contacts/#{input_id}")
    product = response.body

    client_params = {}

    print "Name (#{contact["first_name"]}): "
    client_params[:first_name] = gets.chomp

    print "middle_name (#{contact["middle_name"]}): "
    client_params[:middle_name] = gets.chomp

    print "last_name (#{contact["last_name"]}): "
    client_params[:last_name] = gets.chomp

    print "email (#{contact["email"]}): "
    client_params[:email] = gets.chomp

    client_params.delete_if { |key, value| value.empty? }

    response = Unirest.patch(
                            "http://localhost:3000/contacts/#{input_id}",
                            parameters: client_params
                            )

    if response.code == 200
      contact_data = response.body
      puts JSON.pretty_generate(product_data)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def contacts_destroy_action
    print "Enter contact id: "
    input_id = gets.chomp

    response = Unirest.delete("http://localhost:3000/contacts/#{name}")
    data = response.body
    puts data["message"]
  end
end