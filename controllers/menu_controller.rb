# #1
require_relative "../models/address_book"

class MenuController
    attr_accessor :address_book
    
    def initialize
        @address_book = AddressBook.new
    end
    
    def main_menu
        # #2
        puts "Main Menu - #{@address_book.entries.count} entries"
        puts "1 - View entry number N"
        puts "2 - View all entries"
        puts "3 - Create an entry"
        puts "4 - Search for an entry"
        puts "5 - Import entries from a CSV"
        puts "6 - Exit"
        print "Enter your selection: "
        
        # #3
        selection = gets.to_i
        
 
  case selection
    when 1
     system "clear"
     view_entry_n
     main_menu
    when 2
     system "clear"
     view_all_entries
     main_menu
    when 3
     system "clear"
     create_entry
     main_menu
    when 4
     system "clear"
     search_entries
     main_menu
    when 5
     system "clear"
     read_csv
     main_menu
    when 6
     puts "Good-bye!"
     # #8
     exit(0)
     # #9
    else
     system "clear"
     puts "Sorry, that is not a valid input"
     main_menu
    end
  end
    
    def view_entry_n
        system "clear"
        puts "Enter the entry you would like to view: "
        entry_selection = gets.chomp.to_i
        
        @address_book.entries.each_with_index do |entry, index|
            if entry_selection - 1 == index
                puts entry
            else
                puts "That entry is not valid. Try again."
        end
      end
    end
    def view_all_entries
        @address_book.entries.each do |entry|
            system "clear"
            puts entry.to_s
            # #15
            entry_submenu(entry)
        end
        
        system "clear"
        puts "End of entries"
    end
    
    def create_entry
        system "clear"
        puts "New AddressBloc Entry"
        # #12
        print "Name: "
        name = gets.chomp
        print "Phone number: "
        phone = gets.chomp
        print "Email: "
        email = gets.chomp
        
        # #13
        @address_book.add_entry(name, phone, email)
        
        system "clear"
        puts "New entry created"
    end
    
    def search_entries
        print "Search by name: "
        name = gets.chomp
        
        match = @address_book.binary_search(name)
        system "clear"
        
        if match
            puts match.to_s
            search_submenu(match)
            else
            puts "No match found for #{name}"
        end
    end
    
    def read_csv
        
        print "Enter CSV file to import: "
        file_name = gets.chomp
        
        if file_name.empty?
            system "clear"
            puts "No CSV file read"
            main_menu
        end
        
        
        begin
            entry_count = @address_book.import_from_csv(file_name)
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
            rescue
            puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
            read_csv
        end
    end
        

   
    
    def entry_submenu(entry)
        # #16
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to main menu"
        
        # #17
        selection = gets.chomp
        
        case selection
            
            when "n"
            
            when "d"
                delete_entry(entry)
            
            when "e"
                edit_entry(entry)
                entry_submenu(entry)
            
            when "m"
            system "clear"
            main_menu
            else
            system "clear"
            puts "#{selection} is not a valid input"
            entries_submenu(entry)
        end
    end



        def delete_entry(entry)
            @address_book.entries.delete(entry)
            puts "#{entry.name} has been deleted"
        end
        
        def edit_entry(entry)
            
            print "Updated name: "
            name = gets.chomp
            
            print "Updated phone number: "
            phone_number = gets.chomp
            
            print "Updated email: "
            email = gets.chomp
            
            entry.name = name if !name.empty?
            entry.phone_number = phone_number if !phone_number.empty?
            entry.email = email if !email.empty?
            system "clear"
            
            puts "Updated entry:"
            puts entry
        end
        
        def search_submenu(entry)
            # #12
            puts "\nd - delete entry"
            puts "e - edit this entry"
            puts "m - return to main menu"
            # #13
            selection = gets.chomp
            
            # #14
            case selection
                when "d"
                system "clear"
                delete_entry(entry)
                main_menu
                when "e"
                edit_entry(entry)
                system "clear"
                main_menu
                when "m"
                system "clear"
                main_menu
                else
                system "clear"
                puts "#{selection} is not a valid input"
                puts entry.to_s
                search_submenu(entry)
            end
        end
    end
