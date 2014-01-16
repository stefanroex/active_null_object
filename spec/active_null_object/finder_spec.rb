require 'spec_helper'

describe ActiveNullObject::Finder do
  describe '.find_or_null_object' do
    it 'returns the record if it exists' do
      User.create!
      expect(User.find_or_null_object(1).class).to eq User
    end

    it 'returns returns the null object if no record is found' do
      expect(User.find_or_null_object(1).class).to eq NullUser
    end
  end
end
