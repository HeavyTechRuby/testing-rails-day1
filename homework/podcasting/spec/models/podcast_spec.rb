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
    let (:author) { User.create(name: 'Arthur Morgan') }
    let (:podcast) { Podcast.create(title: 'New Podcast!', status: 'new', author: author) }
    let (:episode) { podcast.episodes.create(title: 'First Episode') }
    let (:episode_draft) { podcast.episodes.create(title: 'Second Episode Draft') }
    let (:episode_published) { podcast.episodes.create(title: 'Second Episode Draft', status: "published") }
    let (:episode_for_delete) { Episode.create(title: 'First Episode') }

    it 'should be possible to publish episode' do
      expect(podcast.publish(episode)).to eq("published")
    end

    it 'should be possible to add draft episode' do
      expect(podcast.add_draft(episode_draft)).to eq("draft")
    end

    it 'should be possible to unpublish episode' do
      podcast.unpublish(episode_published)
      expect(episode_published.unpublished?).to eq(true)
    end


    it 'should be possible to delete episode' do
      podcast.publish(episode_for_delete)
      podcast.destroy_episode(episode_for_delete)
      expect(podcast.episodes.include?(episode_for_delete)).to eq(false)
    end

    describe '#episodes.published' do
      context 'when no episodes' do
        it "is expected to be empty" do
          podcast.destroy_episode(episode)
          podcast.destroy_episode(episode_draft)
          podcast.destroy_episode(episode_published)
          expect(podcast.episodes.empty?).to eq(true)
        end
      end

      context 'when has published episode' do
        it "is expected to include episode" do
          podcast.publish(episode)
          expect(podcast.episodes.any?).to eq(true)
        end
      end
    end
  end

  describe 'author account creation' do
    let (:author) { User.new(name: 'Arthur Morgan') }
    let (:author_with_account) { User.new(name: 'Arthur Morgan', account: Account.create) }
    let (:podcast) { Podcast.create(title: 'New Podcast!', status: 'new', author: author) }

    it "expect author account to be empty" do
      expect(author.valid?).to eq(true)
    end

    context 'when no user account' do
      it 'should add account to user after podcast created' do
        expect(podcast.author.account.present?).to eq(true)
      end
    end

    context 'when user account exists' do
      it 'should NOT add account to user after podcast created' do
        account_id = author_with_account.account.id
        podcast = Podcast.create(title: 'New Podcast!', status: 'new', author: author_with_account)
        expect(podcast.author.account.id).to eq(account_id)
      end
    end
  end
end
