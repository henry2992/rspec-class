require 'rails_helper'
require 'factory_girl_rails'
require 'database_cleaner'
require 'pp'


RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    
    it "assigns all posts as @posts" do
      category = FactoryGirl.create(:category) 
      post =  FactoryGirl.create(:post, category: category)
      post1 =  FactoryGirl.create(:post, category: category)
      get :index
      expect(assigns(:posts)).to eq([post, post1])
    end
  end

  describe "GET #show" do
    it "assigns the requested post as @post" do
      category = FactoryGirl.create(:category) 
      post =  FactoryGirl.create(:post, category: category)
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET #new" do
    it "assigns a new post as @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "GET #edit" do
    it "assigns the requested post as @post" do
      category = FactoryGirl.create(:category) 
      post =  FactoryGirl.create(:post, category: category)
      get :edit, params: {id: post.to_param}
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "POST #create" do
    
    it "creates a new Post" do
      expect {
        category = FactoryGirl.create(:category) 
        post =  FactoryGirl.create(:post, category: category)
      }.to change(Post, :count).by(1)
    end

    it "assigns a newly created post as @post" do
      category = FactoryGirl.create(:category) 
      post =  FactoryGirl.create(:post, category: category)
      expect(post).to be_a(Post)
      expect(post).to be_persisted
    end

    it "response succesfully" do
      # Remember to add parameters
      category = FactoryGirl.create(:category)
      post = FactoryGirl.create(:post, author: 'Gus Gonzales', category: category)
      expect(response.status).to eq(200)
    end

  end

  describe "Post #update" do 

    let(:attr) do 
      { :author => 'New Author', :text => 'new content for testing', :category_id => 1 }
    end

    before(:each) do
      category = FactoryGirl.create(:category)
      @post =  FactoryGirl.create(:post, author: 'Gus Gonzales', category: category)
      put :update,  :id => @post.id  , :post => attr 
      @post.reload
    end

    it { expect(response).to redirect_to(@post) }
    it { expect(@post.author).to eql attr[:author] }
    it { expect(@post.text).to eql attr[:text] }

  end

  describe "DELETE #destroy" do
    
    it "destroys the requested post" do
      category = FactoryGirl.create(:category) 
      post =  FactoryGirl.create(:post, category: category)
      
      expect {
        delete :destroy, params: {id: post.id}
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      category = FactoryGirl.create(:category) 
      post =  FactoryGirl.create(:post, category: category)

      delete :destroy, params: {id: post.id}
      expect(response).to redirect_to(posts_url)
    end

  end

end
