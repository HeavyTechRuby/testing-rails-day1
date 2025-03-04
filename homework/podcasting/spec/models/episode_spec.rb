require 'rails_helper'

RSpec.describe Episode do
  describe 'validations' do
    context 'when valid attributes' do
      it 'should be valid' do
        episode = build(:episode)
        expect(episode).to be_valid
      end
    end

    describe 'on title' do
      it 'should be invalid when no title' do
        episode = build(:episode, title: nil)
        expect(episode).to be_invalid
      end

      it 'should be invalid with empty title' do
        episode = build(:episode, title: "")
        expect(episode).to be_invalid
      end

      it 'should be invalid title has no text' do
        episode = build(:episode, title: "   ")
        expect(episode).to be_invalid
      end
    end

    describe 'on podcast' do
      it 'should be invalid when no podcast' do
        episode = build(:episode, podcast: nil)
        expect(episode).to be_invalid
      end

      it 'should be invalid when podcast is archived' do
        podcast = create(:podcast, status: :archived)
        episode = build(:episode, podcast:)
        expect(episode).to be_invalid
      end
    end
  end

  describe '.popular scope' do
    it 'should not include episode' do
      episode = create(:episode)
      expect(Episode.popular).not_to include(episode)
    end

    context 'when user liked' do
      it 'should include episode' do
        episode = create(:episode)
        user = create(:user)
        episode.like_by(user)
        expect(Episode.popular).to include(episode)
      end

      context 'when user removed his like' do
        it 'should not include episode' do
          episode = create(:episode)
          user = create(:user)
          create(:like, episode: episode, user: user)

          expect(episode.likes.count).to eq(1)
          episode.unliked_by(user)
          expect(episode.likes.count).to eq(0)
        end
      end
    end
  end

  describe 'comments' do
    it 'should be empty when no comments' do
      episode = create(:episode)
      expect(episode.comments).to be_empty
    end

    it 'should be possible to add comment' do
      episode = create(:episode)
      comment = create(:comment, episode:)
      expect(episode.comments).to include(comment)
    end

    context 'when episode archived' do
      it 'should be possible to add comment' do
        podcast = create(:podcast)
        episode = create(:episode, podcast: podcast, status: :archived)
        comment = create(:comment, episode:)
        expect(episode.comments).to include(comment)
      end
    end
  end

  describe 'stats' do
    context 'when user played episode' do
      it 'should increase plays_count' do
        episode = create(:episode)
        user = create(:user)
        episode.play_by(user)
        expect(episode.stats.count).to eq(1)
      end
    end

    context 'when user paused episode' do
      it 'should not change plays_count' do
        episode = create(:episode)
        user = create(:user)
        episode.play_by(user)
        episode.pause_by(user, 10)
        expect(episode.stats.count).to eq(1)
      end

      it 'should save position' do
        episode = create(:episode)
        user = create(:user)
        episode.play_by(user)
        episode.pause_by(user, 10)
        expect(episode.stats.first.position).to eq(10)
      end
    end
  end
end
