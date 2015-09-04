require 'spec_helper'

describe ActiveNullObject::Finder do
  it 'returns the record if it exists' do
    User.create!
    expect(User.find_or_null_object(1).class).to eq User
  end

  it 'returns returns the null object if no record is found' do
    expect(User.find_or_null_object(1).class).to eq NullUser
  end

  describe 'works with customizable initialize_method' do
    it 'defaults to the #new method on the object' do
      expect(NullUser).to receive(:new)
      User.find_or_null_object(1)
    end

    it 'calls the custom initialize_method' do
      ActiveNullObject.initialize_method = :custom
      expect(NullUser).to receive(:custom)
      User.find_or_null_object(1)
      ActiveNullObject.initialize_method = :new
    end
  end

  describe 'works with customizable null_object' do
    it 'defaults to the #new method on the object' do
      expect(Guest).to receive(:new)
      User.find_or_null_object(1, null_object: 'Guest')
    end

    it 'calls the custom initialize_method' do
      ActiveNullObject.initialize_method = :custom
      expect(Guest).to receive(:custom)
      User.find_or_null_object(1, null_object: 'Guest')
      ActiveNullObject.initialize_method = :new
    end
  end
end
