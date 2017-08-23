class Session
  include ActiveModel::Validations
  include Draper::Decorator

  attr_reader :email, :password, :user

  def initialize params
    @user     = params['user']
    @email    = params['email']
    @password = params['password']
  end

  validate do |model|
    model.errors.add :email, 'not found' unless user
    model.errors.add :password 'is invalid' unless user.authenticate password    
  end

  def save!
    raise ActiveModel::StrictValidationFailed unless valid?

    user.create_auth_token
  end

  def destroy!
    user.auth_tokens.destroy_all
  end

  def auth_token
    user&.auth_tokens&.last
  end

  def user
    @user ||= User.find_by email: email
  end
end