require "pry"

class Pokemon

  attr_accessor :id, :name, :type, :db, :hp

  def initialize(name)
    @name = name
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  def self.find(id, db)
    arr = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    pokemon = Pokemon.new(arr[1]).tap do |u|
      u.id = arr[0]
      u.type = arr[2]
      u.hp = arr[3]
    end
  end

  def alter_hp(hp, db)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL
    db.execute(sql, hp, self.id)
    self
  end

end
