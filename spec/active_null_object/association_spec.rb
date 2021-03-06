require 'spec_helper'

describe ActiveNullObject::Association do
  let(:user) { User.create! }
  let(:post) { Post.create! }
  let(:comment) { Comment.create! }
  let(:message) { Message.create! }

  describe 'normal belongs_to' do
    it 'finds the user' do
      user.posts << post
      expect(post.user.class).to eq User
    end

    it 'returns null if user does not exists' do
      expect(post.user.class).to eq NilClass
    end
  end

  describe 'belongs to with explicit null_object option' do
    it 'finds the user' do
      user.comments << comment
      expect(comment.user.class).to eq User
    end

    it 'returns NullUser if user does not exists' do
      expect(comment.user.class).to eq NullUser
    end
  end

  describe 'belongs to with boolean null_object option' do
    it 'finds the user' do
      user.messages << message
      expect(message.user.class).to eq User
    end

    it 'returns NullUser if user does not exists' do
      expect(message.user.class).to eq NullUser
    end
  end

  describe 'Works with customizable initialize_method' do
    it 'calls of new on the Nullobject' do
      expect(NullUser).to receive(:new)
      message.user
    end

    it 'calls of new on the Nullobject' do
      ActiveNullObject.initialize_method = :custom
      expect(NullUser).to receive(:custom)
      message.user
      ActiveNullObject.initialize_method = :new
    end
  end
end
