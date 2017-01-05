require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :author => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_author[name=?]", "post[author]"

      assert_select "textarea#post_text[name=?]", "post[text]"
    end
  end
end
