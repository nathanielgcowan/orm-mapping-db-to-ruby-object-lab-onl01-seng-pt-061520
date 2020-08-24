Why an ORM is Useful

ORM - Object Relations Mapping (ORM) is the technique of accessing a relations database using an object-oriented programming language. Object Relations Mapping is a way for our Ruby programs to manage database data by "mapping " database tables to classes and instances of classes to rows in those tables.

There is no special programming magic to an ORM - it is simply a manner in which we implement the code that connects our Ruby program to our database. For example, you may have seen code that connect your ruby program to a given database.

an ORM is really just a concept. it is a design pattern, a conventional way for us to organize our programs when we want those programs to conect to a database. the convention is this:

when 'mapping" our program to a database, we equate classes with database tables and instances of those classes with table rows.

you may also see this referred to as "wrapping" a database, because we are writing Ruby code that "wraps" or handles SQl.

Why Use ORM?
There are a number of reasons why we use the ORM pattern. Two good ones are:

cutting down on repetitious code.
implementing conventional patterns that are organized and sensical.

cutting down on repetition
let's take a look at some of the common code we might use to interact our ruby program with our database.

let's say we have a progrma that helps a eterinary office keep track of the pets it treats and those pets' owners. such a program would have an owners class and Cats class (among classes to represent other pets). Our program surely needs to connect to a database so that the veterinary office can persist information about its pets and owners.


Our program would create a connection to the databse

orm lets us put sql in ruby
orm is not repetitive
logical design -

_______
Mapping Ruby Classes to Database Tables
_______
map a ruby class to a database table and an istance of a class to a table row

write code that maps a ruby class to a database table

write code that inserts data regarding an instance of a class into a database table row.

Mapping a Class to a Table

we map classes to tables to persist information regarding songs to a database. in order to persist that data efficiently and in an organized manner, we need to first map or equate our Ruby class to a database table.

in order to "map" this song class to a songs database table, we need to create our database, then we need to create our songs table. in buildin an orm, it is conventional to pluralize the name of the class to create the name of the table. therefore, the song class equals the "songs" table.

Creating the Database

classes are mapped to tables instide a database, not to the database as a whole. we may want to build other classes that we equate with other database tables later on.

it is the responsibility of our program as a whole to create and establish the database. accordingly , you'll see our ruby programs set up such that they have a config directory that contains an environment.rb file. 

ex:

require 'sqlite3'
require_relative '../lib/song..rb'

DB = {:conn => SQLite:Database.new("db/music.db")}

this will create a new database called music.db, stored inside the db subdirectory of our app and it will return a Ruby object that represents the connection between our Ruby program and our newly-created SQl database. here's a look at the object that gets returned by the line of code above:

this object is created for us by the code provided by the SQLite-Ruby gem. don't worry too much about what is going on under the hood. the important thing to understand sis that this is the object that connects the rest of the ruby program, i.e. any code we write to create artists, songs and genres, to our SWL database.

NOTE: there are a number of methods available to us, that are provided by the SLite-Ruby gem, that we can call on the above object to execute commands against our database.

here, we also set up a constant, DB, that is equal to a has hthat contains our connection to the databse. In our lib/song.rb file ,we can therefore access the DB constant and the database connection ti holds like this:
DB[:conn]
so , as we move through this reading, let's assume that our hypothetical program has a config/environemnt.rb file and that the DB[:conn] constant refers to our connection to the database.

Now that our hypothetical database is set up in our hypothetical program, let's move on to our Song class and its equivalent database table.

Creating the Table

according to the ORM convention in which a class is mapped toor equated with a database table, we need to create a songs table. we will accomplish this by wriiting a class method in our Song class that creates this table.

to "map" our class to a database table, we will create a table with the same name as out class and give that table column names that match tha ttr_accessor s of our class.

here's an example of a Song class that maps instance s attributes to tables columns:

id attribute

Mapping a Class

--id Attribute

--The .create_table Method
    the .create_table, that crafts  aswlstatement to creata  songs table and give that table column names that match the attributes of an individial instance of Song. Why is the .create_table method a class method? Well, it is not the responsibility of an individual song to create the table it wiill eventualy be saved into. it is the job of the clas as a whole to create the table that it is mapped to. Why is the .create_table method a class method? Well, it is not the responsibility of an individual song to create the table it will eventually be saved into. it is the job of the class as a whole to create the table that it is mapped to.
    tip
    heredoc is helpful for crafting long strip in Ruby..

Mapping Class Instances to Table rows
    when we say that we are saving data to our database, what data are we referring to? if individual instances of a class are "mapped" to rows in a table, does that mean that the instances themselves, these individual Ruby objects, are saved into the database?
    Actually we are not saving Ruby objects in our database. we are going to take the individual attributes of a given instance, in this case a song's name and album , and save those attributes that describe an individaul song to the database as one, single row.

    if we had 
    gold_digger = Song.new("Gold Digger", "Late Registration")

    gold_digger.name
    gold_digger.album

    This song has its two attributes, name and album, set equal to the above values. in order to save thesong gold_digger into the songs table, we will use the name and album ofthe song to create a new row in that table. the swl statement we want tto execute would liik something like this:

    INSERT INTO songs (name, album) VALUES ("Gold Digger", "Late Registration")

    in order to save hello into our database, we do not insert the ruby object stored inthe hello variable. instead we use hello's name and album valuesto create an ew row in the songs table

    INSERT INTO songs (name, album) VALUES ("Hello", "25")

    We can see that the operaton of saving the attributes of a partiucalr song into a database table is common enough. every time we want tot save a record, though, we are repeating the same exact steps and using the same code. the only things tath are different are the values that we are inserting into our songs table. let's abstract this functionality into an instance method, #save.

    Inserting Data in to a table with the #save Method
    the #save , that saves a given instance of our Song class into the songs table of our database.

        class Song
            def save
                sql = <<-SQL
                    INSERT INTO songs (name, album)
                    VALUES (?,?)
                SQL

                DB[:conn].execute(swl, self.name, self.album)
            end
        end

        THe #save Method 
        in order to insert data into our songs table, we need to craft a swl insert statement. ideally ,it would look somethin like this:

        insert into songs (name, album)
        values songs_name, songs_album

        above, we used the hereddoc to craft our multi-line sql statement. how are we going to pass in, or interpolate, the name and album of a given song itn our heredoc
        we use something called Bound paramenret

        bound pararmeters- protect our program for getting confusing by swl injections and special characters. instead of interpolation variables into a stinrg of swl, we are using the . characters as placeholders. then ,the special magic provided to us by the swlite3-Ruby gem's #execute method will take the values we pass in as an argument and applu them as the values of the quesitons marks.

        SQL interjections - is a code injection technique, used to attack data-driven applications, in which mailciaosn SWL statments are isnert into an entry feild for execution

        If we want
            hello.name    in the database
        
        Then we write
            INSERT INTO songs(name, album) VALUES ("Hello", "25")
        

        The Save Method
            The save method when given an instance of our class into the table of our database
                class Song
                    def save
                        sql = <<-SQL
                            INSERT INTO songs (name, album)
                            VALUES (?,?)
                        SQL

                        DB[:conn].execute(sql,self.name, self.album)
                    end
                end

                in rder to insert dta inot our songs table, we need to craft a swl insert statement. ideally it would look something like this:

                    INSERT INTO song (name, album)
                    VALUES songs_name, songs_album
                Above, we used the heredoc to craft our multi-line SQL statment. HOw are we going to pass in, or interpolate, the name and album of a givensonginto our heredoc?

                We use something called bound parameters.

                Bound parameters
                    protect our program from getting confuses by SQL injections and specail characters. instead of interpolation variables into a tring of SQL, we are using the ?characters as placeholders. then, the special magic provide to us by the SQLite3-Ruby gem's #execute method will take the values we pass in as an argument and apply them as the values of the question marks.

                How it works
                    So, our #save method inserts a record into our database that has the name and album values of the song instancewe are trying to save. We are not saving the Ruby object itself. We are creating a new row in our songs table that has the values that characterize that song instance.

                    Important: Notice that we didn't insert an ID number into the table with the above statment. remember that the INTEGER PRIMARY KEY datatype will assign and auto-increment the id attribute of each record that gets saved.

                Creating Instances vs. Creating Table rows
                    the moment in which we create a new song instance with the #new method is different that nthe moment in which we save a representation of that song to our database. the #new method createsa new instance of the song class, a new Ruby object. The #save method takes the attributes that characterize a given song and save them in a new row of the songs table in our database.

                    At what point in time should we actually save a new record? While it is possible to save the record right at the moment the new object is created, i/e/ in the initialize method, this is not a great idea. we don't want to force our objects to be saved every time they are created, or make the ccreation of an object dependent upon/always coupled with saving a record to the database. As our program grows and changes, we may find the need to create obects and not save them. a dependency between instantiaion an object ans saving the record to the databasw would preclude this or, at the very least make it harder to implement.

                        class Song
                        
                        attr_accessor :name, :album, :id
                        
                        def initialize(name, album, id=nil)
                            @id = id
                            @name = name
                            @album = album
                        end
                        
                        def save
                            sql = <<-SQL
                            INSERT INTO songs (name, album) 
                            VALUES (?, ?)
                            SQL
                        
                            DB[:conn].execute(sql, self.name, self.album)
                        
                            @id = DB[:conn].execute("SELECT last_insert_rowid() FROM songs")[0][0]
                        
                        end
                        end

                        Now, we can create and save songs like this:

                        Song.create_table
                        hello=Song.new("Hello", "25")
                        ninety_nine_problems = SOng.new("99 Problems", "The Black ALbum")

                        hello.new
                        ninety_nine_problems.save
*** Review last insert row id***

_______
Mapping Database Tables to Ruby objects
_______
* build methods that read from a database table.
* build a Song.all class method that returns all songs from the database.
* Build a Song.find_bu_name class method that acceptss one argument, a name, searches that database for a song with that name and returns the matching song entry if one is found.
* Convert what the database gives you into a Ruby object.

Introduction
In this lesson, we'll cover the basics of reading from a database table that is mapped to a Ruby object.

Our Ruby program gets most interesting when we add adata. to do this, we use a database. When we want our Ruby program to store things, we send the off to a database. When we want to retrieve those things, we ask the database to send them back to our program. This works very well, but there is one smapp problem to overcome = our Ruby program and the database don't speak the same language

Ruby understands objects. The database understands raw data.

We don't store Ruby objects in the database, and we don't get Ruby objects back from the database. We store raw data describing a given Ruby object in a table row, and when we want to reconstruct a given Ruby object from the stored data, we select that same row in the table.

When we query the database, it is up to us to write the code that takes that data and turns it back into an instance of the appropriate class. we, the programmers, will be responsible for translating the faw data that the database sends into Ruby objects that are instances of a particulart class.

exampleLet's use a song domain as an example. Imagine we have a Song class that is responsible for making songs. every song will come with the two attributes, a title and a length. we could make a bunch of new songs, but frist, we want to look at all the songs that have already been created. 

Imagine we already have a database with 1 million songs.We need to build three methods to access all of those songss and conert them to Ruby objects.

.new_from_db
The first thing we need to do is convert what the database gives us into a Ruby object. We will use this method to create all the Ruby objects in our next two methods.

The first thing to know is that the database, SQLite in our case, will return an array of data for each row. For exampl,e a row for Muchael Jackson's "Thriller" that has a db id of 1 would look like thlis 

def self.new_from_db(row)
    new_song = self.new
    new_song.id = row [0]
    new_song.name = row[1]
    new_song.length = row[2]
    new_song
end

Now, you may notice something- since we're retrieving data from a database, we are using new. we don't need to create records. with this method we're reading data from swlite and temporarily representin that data in Ruby.

Song.all
Now we can start writing our methods to retrieve the data. to return all the songs in the database we need to execute the following SWl query: SELECT * FROM song. Let's store that in a variable called sql using a heredoc (<<-) since our string will go onto multiple lines:

sql = <<-SQL
    SELECT * FROM songs
SQl

Next, we will make a call to our database using DB[:conn]. This DB hash is located in the config/environment.rb file: DB = {:conn => SQLite3::Database.new("db/songs.db")} . Notice that the value of the hash is actually a new instnace of the swlite3::database class. this is how we will connect to our dataase. our dataase instnace responds to a method called execute that accepts raw swl as a string. let's pass in that sql we stored above

class Song
    def self.all
        sql = <<-SQL
            SELECT *
            FROM songs
        SQL

        DB[:conn].execute(sql)
    end
end

This will return an array of rows from the databse that matches our query. Now, all we have to do is iterate oer each row and use the self.new_from_db method to create a new Ruby object for each row:

class Song
    def self.all
        sql = <<-SQL
            SELECT* FROM songs
        SQL

        DB[:conn].execute(sql).map do |row|
            self.new_from_db(row)
        end
    end
end

Song.find_by_name
This one is similar to Song.all with the small exception being that we have to include a nmae in our SWL statement. To do this, we use a question mark where we want the name parameter to be passed in, and we include name as the second argument to the execute method:

class Song
    def self.find_bu_name(name)
        sql = <<-SQL
            SELECT * FROM songs WHERE name = ? LIMIT 1
        SQL

        DB[:conn].execute(sql, name).map do |row|
            self.new_from_db(row)
        end.first
    end
end

Don't be freaked out by that .first method chained to the end of the DB[:conn].execute(sql, name).map block. The return value of the .map method is an array, and we're simply grabbing the .first element from the returned array. Chaining is cool!






_______________
class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
    student = self.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
      sql = <<-SQL
        SELECT * FROM Students
      SQL
      
      DB[:conn].execute(sql).map do |row|
        self.new_from_db(row)
      end
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = <<-SQL
        SELECT * FROM Students WHERE name = ? LIMIT 1
    SQL
      
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end


