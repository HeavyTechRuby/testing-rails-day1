require 'rails_helper'

RSpec.describe Podcast do
  describe 'validations' do
    context 'when valid attributes' do
      it 'should be valid' do
        podcast = build(:podcast)
        expect(podcast).to be_valid
      end
    end

    describe 'on title' do
      it 'should be invalid when no title' do
        podcast = build(:podcast, title: nil)
        expect(podcast).to be_invalid
      end

      it 'should be invalid with empty title' do
        podcast = build(:podcast, title: "")
        expect(podcast).to be_invalid
      end

      it 'should be invalid title has no text' do
        podcast = build(:podcast, title: " ")
        expect(podcast).to be_invalid
      end
    end

    describe 'on author' do
      it 'should be invalid when no author' do
        podcast = build(:podcast, author: nil)
        expect(podcast).to be_invalid
      end

      it 'should be invalid when user is blocked' do
        podcast = build(:podcast, author: create(:user, blocked: true))
        expect(podcast).to be_invalid
      end
    end
  end

  describe 'subscriptions' do
    it 'should be empty' do
      podcast = create(:podcast)
      expect(podcast.subscriptions).to be_empty
    end

    context 'when user subscribed' do
      it 'should include user' do
        podcast = create(:podcast)
        user = create(:user)
        podcast.subscribe(user)

        expect(podcast.subscriptions.first.user_id).to eq(user.id)
        expect(podcast.subscriptions.first.podcast_id).to eq(podcast.id)
      end
    end

    context 'when user NOT subscribed' do
      it 'should not include user' do
        podcast = create(:podcast)
        user = create(:user)
        expect(podcast.subscriptions).not_to include(user)
      end
    end
  end

  describe 'episodes' do
    it 'should be possible to publish episode' do
      podcast = create(:podcast)
      episode = create(:episode, podcast: podcast)
      podcast.publish(episode)
      expect(podcast.episodes).to include(episode)
    end

    it 'should be possible to add draft episode' do
      podcast = create(:podcast)
      episode = create(:episode, podcast: podcast)
      podcast.add_draft(episode)
      expect(podcast.episodes).to include(episode)
    end

    it 'should be possible to unpublish episode' do
      podcast = create(:podcast)
      episode = create(:episode, podcast: podcast)
      podcast.unpublish(episode)
      expect(podcast.episodes).not_to include(episode)
    end

    it 'should be possible to delete episode' do
      podcast = create(:podcast)
      episode = create(:episode, podcast: podcast)
      podcast.delete(episode)
      expect(podcast.episodes).not_to include(episode)
    end

    describe '#episodes.published' do
      context 'when no episodes' do
        it "is expected to be empty" do
          podcast = create(:podcast)
          expect(podcast.episodes.published).to be_empty
        end
      end

      context 'when has published episode' do
        it "is expected to include episode" do
          podcast = create(:podcast)
          episode = create(:episode, podcast: podcast, status: :published)
          expect(podcast.episodes.published).to include(episode)
        end
      end
    end
  end

  describe 'author account creation' do
    it "expect author account to be empty"

    context 'when no user account' do
      it 'should add account to user after podcast created' do
        podcast = create(:podcast)
        expect(podcast.author.account).to be_present
      end
    end

    context 'when user account exists' do
      it 'should NOT add account to user after podcast created'
    end
  end
end
