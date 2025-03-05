require 'rails_helper'

RSpec.describe Episode do
  describe 'validations' do
    let(:episode) { build(:episode, :with_podcast) }
    let(:episode_empty_title) { build(:episode, :with_podcast, title: '') }
    let(:episode_nil_title) { build(:episode, :with_podcast, title: nil) }
    let(:episode_without_podcast) { build(:episode) }
    let(:episode_with_podcast_archived) { build(:episode, :with_archived_podcast) }

    context 'when valid attributes' do
      it 'should be valid' do
        expect(episode).to be_valid
      end
    end

    describe 'on title' do
      it 'should be invalid when no title' do
        expect(Episode.new).to be_invalid
      end

      it 'should be invalid with empty title' do
        expect(episode_empty_title).to be_invalid
      end

      it 'should be invalid title has no text' do
        expect(episode_nil_title).to be_invalid
      end
    end

    describe 'on podcast' do
      it 'should be invalid when no podcast' do
        expect(episode_without_podcast).to be_invalid
      end

      it 'should be invalid when podcast is archived' do
        expect(episode_with_podcast_archived).to be_invalid
      end
    end
  end

  describe '.popular scope' do
    let(:episode) { build(:episode, :with_podcast) }
    let(:user) { build(:user) }

    it 'should not include episode' do
      expect(Episode.popular).to be_empty
    end

    context 'when user liked' do
      it 'should include episode' do
        episode.like(user)
        expect(Episode.popular).to be_any
      end

      context 'when user removed his like' do
        it 'should not include episode' do
          episode.like(user)
          episode.unlike(user)
          expect(Episode.popular).to be_empty
        end
      end
    end
  end

  describe 'comments' do
    let(:episode) { create(:episode, :with_podcast) }
    let(:user) { build(:user) }

    it 'should be empty when no comments' do
      expect(episode.comments).to be_empty
    end

    it 'should be possible to add comment' do
      comments_before = episode.comments.count
      episode.add_comment(user, "some text")
      expect(comments_before + 1).to be(episode.comments.count)
    end

    it 'should be possible to remove comment' do
      episode.add_comment(user, "some text")
      comments_before = episode.comments.count
      episode.del_comment(user)
      expect(comments_before - 1).to be(episode.comments.count)
    end

    context 'when episode archived' do
      it 'should be possible to add comment' do
        expect {
          episode.add_comment(user, "some text")
        }.to change { episode.comments.count }.by(1)
      end
    end
  end

  describe 'stats' do
    let(:user) { build(:user) }
    let(:episode) { build(:episode_with_podcast) }
    let(:play_stat_for_position) { create(:play_stat, user: user, episode: episode, position: 10) }

    context 'when user played episode' do
      it 'should increase plays_count' do
        expect { create(:play_stat, user: user, episode: episode, is_finished: true) }
          .to change { Episode.played.count }.by(1)
      end
    end

    context 'when user paused episode' do
      it 'should not change plays_count' do
        expect { create(:play_stat, user: user, episode: episode, position: 10) }
        .to change { Episode.played.count }.by(0)
      end

      it 'should save position' do
        expect(play_stat_for_position.position).not_to eq(0)
      end
    end
  end
end
