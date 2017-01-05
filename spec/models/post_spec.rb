require 'rails_helper'
require 'factory_girl_rails'
require 'database_cleaner'

RSpec.describe Post, type: :model do
  
  
  describe Post, 'validation' do
    
    
    # it "should validate presence of author" do
    #   post = FactoryGirl.build(:post, :author => "", :text => "This is a fake text to test." )
    #   expect(post).not_to be_valid

    #   post.author = "Foo"
    #   expect(post).to be_valid
    # end

    # it "should validate minimum length of author" do
    #   post = FactoryGirl.build(:post, :author => "G", :text => "This is a fake text to test." )
    #   expect(post).not_to be_valid

    #   post.author = "Gu"
    #   expect(post).to be_valid
    # end

    #  it "should validate maximum length of author" do
    #   post = FactoryGirl.build(:post, :author => "G" * 21, :text => "This is a fake text to test." )
    #   expect(post).not_to be_valid

    #   post.author = "G" * 20
    #   expect(post).to be_valid
    # end


    it { should validate_presence_of(:author) }
    it { should validate_length_of(:author).is_at_least(2) }
    it { should validate_length_of(:author).is_at_most(20) }

    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(20) }
    it { should validate_length_of(:text).is_at_most(200) }

  end


  describe Post, '.search_by_author' do
    
    before(:each) do
      category = FactoryGirl.create(:category)
      FactoryGirl.create(:post, author: 'Gus Gonzales', category: category)
    end

    it 'returns post that match with author' do
      expect(Post.search_by_author('Gus Gonzales').count).to eq(1)
    end

    it 'returns post that like author' do
      expect(Post.search_by_author('gus gonzales').count).to eql(1)
    end

    it 'returns post when author is blank' do
      expect(Post.search_by_author('').count).to eql 1
    end

    it 'returns empty when author is not match' do
      expect(Post.search_by_author('not match').count).to eql 0
    end
  end

  describe Post, 'column_specification' do
    it { should have_db_column(:author).of_type(:string).with_options(length: { minimum: 2, maximum: 20 }, presence: true) }
    it { should have_db_column(:text).of_type(:text).with_options(length: { minimum: 20, maximum: 200 }) }
  end

  describe Post, 'association' do
    it { should belong_to(:category) }
  end

end



