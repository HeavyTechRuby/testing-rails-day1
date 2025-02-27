RSpec.describe Podcast do
  describe 'validations' do
    context 'when valid attributes' do
      it 'should be valid'
    end

    describe 'on title' do
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
      it 'should include user'
    end

    context 'when user NOT subscribed' do
      it 'should not include user'
    end
  end

  describe 'episodes' do
    it 'should be possible to publish episode'
    it 'should be possible to add draft episode'
    it 'should be possible to unpublish episode'
    it 'should be possible to delete episode'

    describe '#episodes.published' do
      context 'when no episodes' do
        it "is expected to be empty"
      end

      context 'when has published episode' do
        it "is expected to include episode"
      end
    end
  end

  describe 'author account creation' do
    it "expect author account to be empty"

    context 'when no user account' do
      it 'should add account to user after podcast created'
    end

    context 'when user account exists' do
      it 'should NOT add account to user after podcast created'
    end
  end
end
