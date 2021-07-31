class UserModel
    attr_accessor :full_name, :email, :password
  
    #transforma um objeto em hash
    def to_hash
      {
        full_name: @full_name,
        email: @email,
        password: @password,
      }
    end
  end
  