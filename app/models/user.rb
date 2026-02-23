class User < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:first_name, :last_name, :email, :type]
    validates_format /\A[^@\s]+@[^@\s]+\z/, :email, message: 'format is not valid'
  end
end
