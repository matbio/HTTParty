class ApiUser
    include HTTParty
    base_uri "http://localhost:3001"
    headers "Content-Type" => "application/json"

    def self.user_auth(user_email, user_senha)
        result = post("/auth", body: {email: user_email, password: user_senha}.to_json)
        "JWT #{result.parsed_response["token"]}"
    end

    def self.user_delete(token, user_id)
        delete("/user/#{user_id}", headers: {"Authorization" => token})
    end

    def self.user_post(user)
        post("/user", body: user.to_json)
    end

    def self.user_put(token,user_id,user)
        put("/user/#{user_id}", body: user.to_json, headers: {"Authorization" => token})
    end


    def self.user_get(token, user_id)
        get("/user/#{user_id}", headers: {"Authorization" => token})
    end
end