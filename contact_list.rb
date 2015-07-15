require_relative 'contact_database'

class ContactList

  def command
    puts "Do you want to create/update , destroy, show all or find a contact?"
    command = gets.chomp.to_s

    case command
      when 'create'
        self.create
      when 'destroy'
        ContactDatabase.destroy
      when 'all'
      ContactDatabase.all
      when 'find'
        puts "Do you want to find by id, firstname,lastname, or email?"
        find_input = gets.chomp
        if find_input == 'id'
          puts "Whats the id?"
          @id = gets.chomp.to_i
          ContactDatabase.find_by_id(@id)
        elsif find_input == 'firstname'
          puts "What's the first name?"
          @firstname = gets.chomp.to_s
          puts @firstname
          ContactDatabase.find_all_by_firstname(@firstname)
        elsif find_input == 'lastname'
          puts "What's the last name?"
          @lastname = gets.chomp.to_s
          ContactDatabase.find_all_by_lastname(@lastname)
        elsif find_input == 'email'
          puts "Whats the email?"
          @email = gets.chomp.to_s
          ContactDatabase.find_all_by_email(@email)
        end
     end
  end 


  def create

      puts 'Please enter their full name: "First name", "Last name", then "email address."'
      puts 'Enter first name:'
      @firstname = gets.chomp.to_s
      puts 'Enter last name:'
      @lastname = gets.chomp.to_s
      puts 'Enter email address:' 
      @email = gets.chomp.to_s

      hash = {"firstname" => @firstname,
      "lastname"=> @lastname,
      "email"=> @email}

      new_contact = ContactDatabase.new(hash)
      new_contact.save

    end
end

contact_list = ContactList.new
contact_list.command