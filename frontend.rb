require 'unirest'

require_relative 'controllers/contacts_controller'
require_relative 'views/contacts_views'
require_relative 'models/contact'

class Frontend
  include ContactsController
  include ContactsViews

  def run

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
    contacts_index_action

    elsif input_option == "1.1"
    print "Enter a search term: "
    search_term = gets.chomp

    response = Unirest.get("http://localhost:3000/recipes?search=#{search_term}")
    products = response.body
    puts JSON.pretty_generate(contacts)

  elsif input_option == "1.2"
    response = Unirest.get("http://localhost:3000/contacts?sort=first_name")
    contacts = response.body
    puts JSON.pretty_generate(contacts) 
  elsif input_option == "1.3"
    response = Unirest.get("http://localhost:3000/recipes?sort=prep_time")
    contacts = response.body
    puts JSON.pretty_generate(contacts) 

  elsif input_option == "2"
    contacts_create_action
  elsif input_option == "3"
    contacts_create_action

    end 

    elsif input_option == "4"
    contacts_update_action
  elsif input_option == "5"
    contacts_destroy_action
  end


