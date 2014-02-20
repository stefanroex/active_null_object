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

  describe 'Works with customizable initialize_method' do
    it 'calls of new on the Nullobject' do
      expect(NullUser).to receive(:new)
      User.find_or_null_object(1)
    end

    it 'calls of new on the Nullobject' do
      ActiveNullObject.initialize_method = :custom
      expect(NullUser).to receive(:custom)
      User.find_or_null_object(1)
      ActiveNullObject.initialize_method = :new
    end
  end
end
