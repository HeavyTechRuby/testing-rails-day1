require 'rails_helper'

RSpec.describe Podcast do
  describe 'validations' do
    context 'when valid attributes' do
      let(:podcast) { build(:podcast) }

      it 'should be valid' do
        expect(podcast.valid?).to eq(true)
      end
    end

    describe 'on title' do
      let(:podcast_without_title) { build(:podcast, :with_nil_title) }
      let(:podcast_empty_title) { build(:podcast, :with_empty_title) }

      it 'should be invalid when no title' do
        expect(podcast_without_title).to be_invalid
      end

      it 'should be invalid with empty title' do
        expect(podcast_empty_title).to be_invalid
      end

      it 'should be invalid title has no text' do
        expect(Podcast.new).to be_invalid
      end
    end

    describe 'on author' do
      let(:podcast_no_author) { build(:podcast, author: nil) }
      let(:podcast_with_blocked_author) { build(:podcast, :with_blocked_author) }

      it 'should be invalid when no author' do
        expect(podcast_no_author).to be_invalid
      end

      it 'should be invalid when user is blocked' do
        expect(podcast_with_blocked_author).to be_invalid
      end
    end
  end

  describe 'subscriptions' do
    let(:podcast) { build(:podcast) }
    let(:subscriber) { build(:subscriber) }
    let(:subscription) { podcast.subscribe(subscriber) }
    let(:no_subscriber) { build(:no_subscriber) }

    it 'should be empty' do
      expect(podcast.subscriptions).to be_empty
    end

    context 'when user subscribed' do
      it 'should include user' do
        expect(subscription.user).to eq(subscriber)
      end
    end

    context 'when user NOT subscribed' do
      it 'should not include user' do
        expect(subscription.user).not_to eq(no_subscriber)
      end
    end
  end

  describe 'episodes' do
    let(:episode) { build(:episode) }
    let(:podcast) { build(:podcast) }

    it 'should be possible to publish episode' do
      podcast.publish(episode)
      expect(episode.published?).to eq(true)
    end

    it 'should be possible to add draft episode' do
      podcast.add_draft(episode)
      expect(episode).to be_draft
    end

    it 'should be possible to unpublish episode' do
      podcast.publish(episode)
      podcast.unpublish(episode)
      expect(episode).to be_unpublished
    end


    it 'should be possible to delete episode' do
      podcast.publish(episode)
      podcast.destroy_episode(episode)
      expect(podcast.episodes).not_to include(episode)
    end

    describe '#episodes.published' do
      context 'when no episodes' do
        it "is expected to be empty" do
          expect(podcast.episodes).to be_empty
        end
      end

      context 'when has published episode' do
        it "is expected to include episode" do
          podcast.publish(episode)
          expect(podcast.episodes).to be_any
        end
      end
    end
  end

  describe 'author account creation' do
    let(:author_without_account) { build(:author, :without_account) }
    let(:podcast_no_account) { build(:podcast, :with_author_without_account) }
    let(:author) { build(:author) }
    let(:podcast) { build(:podcast, author: author) }

    it "expect author account to be empty" do
      expect(author_without_account.account).to be_blank
    end

    context 'when no user account' do
      it 'should add account to user after podcast created' do
        expect(podcast_no_account.author.account).to be_blank
      end
    end

    context 'when user account exists' do
      it 'should NOT add account to user after podcast created' do
        expect(podcast.author.account).to eq(author.account)
      end
    end
  end
end
