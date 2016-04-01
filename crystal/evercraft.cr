
require "spec"

class Character
  def initialize(name)
    @name = name
    @alignment = "Neutral"
    @hitpoints = 10
    @armorclass = 5
  end

  def name
    @name
  end

  def name(name)
    @name = name
  end

  def alignment
    @alignment
  end

  def alignment(al)
    if ["Good", "Evil", "Neutral"].includes? al.capitalize
      @alignment = al.capitalize
    end
  end

  def hitpoints
    @hitpoints
  end

  def armorclass
    @armorclass
  end

  def attack(tohit, ac)
    tohit >= ac
  end

  def damage
    @hitpoints -= 1
  end

  def damage(inflicted)
    @hitpoints -= inflicted
  end

end

# spec

describe "Character" do

  # As a character I want to have a name so that I can be distinguished from other characters

  describe "#name" do
    it "correctly gets the name" do
      test_char = Character.new "Triss"
      test_char.name.should eq "Triss"
    end
    
    it "correctly sets the name" do
      test_char = Character.new "Bob"
      test_char.name "Frangelica"
      test_char.name.should eq "Frangelica" 
    end
  end

  # As a character I want to have an alignment so that I have something to guide my actions

  describe "#alignment" do
    it "correctly gets the alignment" do
      test_char = Character.new "Hodor"
      test_char.alignment.should eq "Neutral"
    end

    it "correctly sets the alignment" do
      test_char = Character.new "Beelzebub"
      test_char.alignment "evil"
      test_char.alignment.should eq "Evil"
    end

    it "only works for valid alignments" do
      test_char = Character.new "Burrito"
      test_char.alignment "taco bell"
      test_char.alignment.should eq "Neutral"
    end
  end

  # As a combatant I want to have an armor class and hit points so that I can resist attacks from my enemies

  describe "#hitpoints" do
    it "correctly sets the default HP to 10" do
      test_char = Character.new "Xena"
      test_char.hitpoints.should eq 10
    end
  end

  describe "#armorclass" do
    it "correctly sets default AC to 5" do
      test_char = Character.new "Hercules"
      test_char.armorclass.should eq 5
    end
  end

  # As a combatant I want to be able to attack other combatants so that I can survive to fight another day

  describe "#attack" do
    it "returns true if roll beats AC" do
      test_char = Character.new "Pidgeotto"
      hit = test_char.attack 15, 10
      hit.should be_true
    end

    it "returns false if roll lower than AC" do
      test_char = Character.new "Magikarp"
      hit = test_char.attack 3, 10
      hit.should be_false
    end
  end

  # As an attacker I want to be able to damage my enemies so that they will die and I will live

  describe "#damage" do
    it "does 1 damage by default to defender if attack hits" do
      attacker = Character.new "Lion"
      defender = Character.new "Zebra"
      hit = attacker.attack 10, defender.armorclass
      before_hp = defender.hitpoints
      
      if hit
        defender.damage
      end
      
      defender.hitpoints.should eq (before_hp - 1)
    end

    it "can do a specified amount of damage" do
      attacker = Character.new "Lion"
      defender = Character.new "Zebra"
      hit = attacker.attack 10, defender.armorclass
      before_hp = defender.hitpoints

      if hit
        defender.damage 5
      end

      defender.hitpoints.should eq (before_hp - 5)
    end
  end

end
