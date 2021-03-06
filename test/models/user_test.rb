require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Foobar', email: 'foobar@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert 'invalid', @user.valid?
  end

  test 'name should be present' do
    @user.name = '       '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'name should not be too short' do
    @user.name = 'bar'
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[
      (user@example.com)
      (USER@foo.COM)
      (A_US-ER@foo.bar.org)
      (first.last@foo.jp)
      (alice+bob@baz.cn)]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert "#{valid_address.inspect} should be valid", @user.valid?
    end
  end

  test 'email validation should not accept invalid emails' do
    invalid_adresses = %w[
      (user@example,com)
      (user_at_foo.org)
      (user.name@example.)
      (foo@bar_baz.com foo@bar+baz.com)]
    invalid_adresses.each do |invalid|
      @user.email = invalid
      assert_not @user.valid?, "#{invalid} should not be valid"
    end
  end

  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false if user's digest is nil" do
    assert_not @user.authenticated?(:remember, '')
  end
end
