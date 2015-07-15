require 'pg'
# require_relative 'contact_database'

class Contact

  attr_accessor :id, :lastname, :firstname, :email

  def initialize(hash)
    @id = hash["id"].to_i if hash["id"]
    @firstname = hash["firstname"]
    @lastname= hash["lastname"]
    @email = hash["email"]
  end

  def to_s
    "First name: [#{@firstname}] Last name: [#{@lastname}] Email: [#{@email}]"
  end
    
  def save
    if id
      sql = 'UPDATE contacts SET firstname=$1, lastname=$2, email = $3;'
      self.class.connection.exec_params(sql,[self.firstname, self.lastname, self.email, @id])
    else
      sql = 'INSERT INTO contacts (firstname, lastname, email) VALUES ($1,$2,$3) RETURNING id'
      result = self.class.connection.exec_params(sql, [self.firstname, self.lastname, self.email])
      @id = result[0]["id"].to_i
    end
  end

  def self.connection
    PG.connect(
      host: 'localhost',
      dbname: 'contacts',
      user: 'development',
      password: 'development'
  )
  end

  def self.all
    self.connection.exec('SELECT * FROM contacts;') do |results|
      results.map do |hash|
        return self.new(hash)
      end
    end
  end

  def self.destroy(firstname)
    self.connection.exec_params("DELETE FROM contacts WHERE firstname = '#{firstname}';") 
  end

  def self.find_by_id(id)
    self.connection.exec_params("SELECT * FROM contacts WHERE id = '#{id}';") do |results|
      results.each do |hash|
        puts self.new(hash)
      end
    end
  end

  def self.find_all_by_firstname(firstname)
    self.connection.exec("SELECT * FROM contacts WHERE firstname = '#{firstname}';") do |results|
      results.map do |hash|
        puts self.new(hash)
      end
    end
  end

  def self.find_all_by_lastname(lastname)
    self.connection.exec("SELECT * FROM contacts WHERE lastname = '#{lastname}';") do |results|
      results.map do |hash|
        puts self.new(hash)
      end
    end
  end

  def self.find_by_email(email)
    self.connection.exec("SELECT * FROM contacts WHERE email = '#{email}';") do |results|
      results.map do |hash|
        puts self.new(hash)
      end
    end
  end

end