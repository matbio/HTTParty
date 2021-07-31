class ApiUser
    include HTTParty
    base_uri "http://localhost:3001"
    headers "Content-Type" => "application/json"

    def self.user_post(user)
        post("/user", body: user.to_json)
    end
end