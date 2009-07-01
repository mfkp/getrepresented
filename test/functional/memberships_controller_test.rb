require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase
  def test_create_invalid
    Membership.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Membership.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    membership = Membership.first
    delete :destroy, :id => membership
    assert_redirected_to root_url
    assert !Membership.exists?(membership.id)
  end
end
