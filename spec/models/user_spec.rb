require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:age).only_integer.is_greater_than(0) }
    it { should validate_inclusion_of(:gender).in_array(%w[male female other]) }
  end

  context "others validations" do
    it "is valid with valid attributes" do
      user = User.new(name: "John", age: 30, gender: "male")
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user = User.new(age: 30, gender: "male")
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is not valid with a non-integer age" do
      user = User.new(name: "John", age: "thirty", gender: "male")
      expect(user).not_to be_valid
      expect(user.errors[:age]).to include("is not a number")
    end

    it "is not valid with a negative age" do
      user = User.new(name: "John", age: -30, gender: "male")
      expect(user).not_to be_valid
      expect(user.errors[:age]).to include("must be greater than 0")
    end

    it "is not valid with an invalid gender" do
      user = User.new(name: "John", age: 30, gender: "alien")
      expect(user).not_to be_valid
      expect(user.errors[:gender]).to include("is not included in the list")
    end
  end
end
