require 'rails_helper'

RSpec.describe Podcast do
  describe 'validations' do
    context 'when valid attributes' do
      let (:author) { User.new(name: 'Arthur Morgan', account: Account.new) }
      let (:podcast) { Podcast.new(title: 'New Podcast!', status: 'new', author: author) }

      it 'should be valid' do
        expect(podcast.valid?).to eq(true)
      end
    end

    describe 'on title' do
      let (:author) { User.new(name: 'Arthur Morgan', account: Account.new) }
      let (:podcast_no_title) { Podcast.new(status: 'new', author: author) }
      let (:podcast_nil_title) { Podcast.new(title: nil, status: 'new', author: author) }
      let (:podcast_empty_title) { Podcast.new(title: '', status: 'new', author: author) }

      it 'should be invalid when no title' do
        expect(podcast_no_title.valid?).to eq(false)
      end

      it 'should be invalid with empty title' do
        expect(podcast_nil_title.valid?).to eq(false)
      end

      it 'should be invalid title has no text' do
        expect(podcast_empty_title.valid?).to eq(false)
      end
    end

    describe 'on author' do
      let (:author_blocked) { User.new(name: 'Arthur Morgan', blocked: true, account: Account.new) }
      let (:podcast_no_author) { Podcast.new(title: 'New Podcast!', status: 'new') }
      let (:podcast_with_blocked_author) { Podcast.new(title: 'New Podcast!', status: 'new', author: author_blocked) }

      it 'should be invalid when no author' do
        expect(podcast_no_author.valid?).to eq(false)
      end

      it 'should be invalid when user is blocked' do
        expect(podcast_with_blocked_author.valid?).to eq(false)
      end
    end
  end

  describe 'subscriptions' do
    let (:author) { User.new(name: 'Arthur Morgan', account: Account.new) }
    let (:subscriber) { User.new(name: 'John Marston', account: Account.new) }
    let (:no_subscriber) { User.new(name: 'Dutch Willson', account: Account.new) }
    let (:podcast) { Podcast.new(title: 'New Podcast!', status: 'new', author: author) }
    let (:subscription) { podcast.subscribe(subscriber) }

    it 'should be empty' do
      expect(podcast.subscriptions.empty?).to eq(true)
    end

    context 'when user subscribed' do
      it 'should include user' do
        expect(subscription.user == subscriber).to eq(true)
      end
    end

    context 'when user NOT subscribed' do
      it 'should not include user' do
        expect(subscription.user == no_subscriber).to eq(false)
      end
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
