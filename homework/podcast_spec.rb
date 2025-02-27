require 'rails_helper'

RSpec.describe Podcast, type: :model do
  describe 'validations' do
    context 'when valid attributes' do
      it 'should be valid'
    end

    descibre 'on title' do
      it 'should be invalid when no title'
      it 'should be invalid with empty title'
      it 'should be invalid title has no text'
    end

    describe 'on author' do
      it 'should be invalid when no author'
      it 'should be invalid when user is blocked'
    end
  end

  describe 'subscriptions' do
    it 'should be empty'

    context 'when user subscribed' do
      it 'should include user subscribed'
      it 'should not include not subscribed user'
    end
  end

  describe 'episodes' do
    it 'should be possible to publish episode'
    it 'should be possible to add draft episode'
    it 'should be possible to unpublish episode'
    it 'should be possible to delete episode'
    it 'should be possible to delete episode'

    describe '#published_episodes' do
      context 'when no episodes'
    end
  end
end
