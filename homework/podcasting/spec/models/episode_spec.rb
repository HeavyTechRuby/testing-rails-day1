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
    it 'should not include episode'

    context 'when user liked' do
      it 'should include episode'

      context 'when user removed his like' do
        it 'should not include episode'
      end
    end
  end

  describe 'comments' do
    it 'should be empty when no comments'
    it 'should be possible to add comment'
    it 'should be possible to remove comment'

    context 'when episode archived' do
      it 'should be possible to add comment'
    end
  end

  describe 'stats' do
    context 'when user played episode' do
      it 'should increase plays_count'
    end

    context 'when user paused episode' do
      it 'should not change plays_count'
      it 'should save position'
    end
  end
end
