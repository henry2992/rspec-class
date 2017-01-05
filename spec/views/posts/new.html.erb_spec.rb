require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      :author => "MyString",
      :text => "MyText"
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_author[name=?]", "post[author]"

      assert_select "textarea#post_text[name=?]", "post[text]"
    end
  end
end
