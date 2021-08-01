describe "Dado que estou na API PUT User" do
    context "Quando eu realizo a requisição" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            @updated_user = build(:user)
            @result_put = ApiUser.user_put(token, original_user.id, @updated_user.to_hash)
            @result_get = ApiUser.user_get(token, original_user.id)

        end

        it "Então tenho uma resposta de Sucesso (200)" do
            expect(@result_put.response.code).to eql "200"
        end
        it "E vejo que o nome alterou" do
            expect(@result_get.parsed_response["full_name"]).to eql @updated_user.full_name
        end
        it "E vejo que o email alterou" do
            expect(@result_get.parsed_response["email"]).to eql @updated_user.email
        end
    end

    context "Quando eu realizo a requisição alterando o e-mail por um que já existe" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_duplicated_email)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Conflict (409)" do
            expect(@result_put.response.code).to eql "409"
        end
        it "E vai retornar a mensagem [Oops. Looks like you already have an account with this email address.]" do
            expect(@result_put.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address."
        end
    end

    context "Quando eu realizo a requisição sem autorização" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            updated_user = build(:user_wrong_email)
            @result_put = ApiUser.user_put("", original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Unauthorized (401)" do
            expect(@result_put.response.code).to eql "401"
        end
    end

    context "Quando eu realizo a requisição alterando para um e-mail inválido" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_wrong_email)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(@result_put.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Oops. You entered a wrong email.]" do
            expect(@result_put.parsed_response["msg"]).to eql "Oops. You entered a wrong email."
        end
    end

    context "Quando eu realizo a requisição alterando para um nome vazio" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_full_empty)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Bad Request (400)" do
            expect(@result_put.response.code).to eql "400"
        end
        it "E vai retornar a mensagem [Validation notEmpty on full_name failed]" do
            expect(@result_put.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed"
        end
    end

    context "Quando eu realizo a requisição alterando para uma senha vazia" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_password_empty)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Bad Request (400)" do
            expect(@result_put.response.code).to eql "400"
        end
        it "E vai retornar a mensagem [Validation notEmpty on password failed]" do
            expect(@result_put.parsed_response["msg"]).to eql "Validation notEmpty on password failed"
        end
    end

    context "Quando eu realizo a requisição alterando para um e-mail vazio" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_email_empty)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Bad Request (400)" do
            expect(@result_put.response.code).to eql "400"
        end
        it "E vai retornar a mensagem [Validation notEmpty on email failed]" do
            expect(@result_put.parsed_response["msg"]).to eql "Validation notEmpty on email failed"
        end
    end

    context "Quando eu realizo a requisição alterando para um nome nulo" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_full_null)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Bad Request (400)" do
            expect(@result_put.response.code).to eql "400"
        end
        it "E vai retornar a mensagem [Users.full_name cannot be null]" do
            expect(@result_put.parsed_response["msg"]).to eql "Users.full_name cannot be null"
        end
    end

    context "Quando eu realizo a requisição alterando para uma senha nula" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_password_null)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Bad Request (400)" do
            expect(@result_put.response.code).to eql "400"
        end
        it "E vai retornar a mensagem [Users.password cannot be null]" do
            expect(@result_put.parsed_response["msg"]).to eql "Users.password cannot be null"
        end
    end

    context "Quando eu realizo a requisição alterando para um email nulo" do
        before(:all) do
            original_user = build(:user_duplicated_email)
            token = ApiUser.user_auth(original_user.email, original_user.password)
            updated_user = build(:user_email_null)
            @result_put = ApiUser.user_put(token, original_user.id, updated_user.to_hash)
        end

        it "Então tenho uma resposta de Bad Request (400)" do
            expect(@result_put.response.code).to eql "400"
        end
        it "E vai retornar a mensagem [Users.full_email cannot be null]" do
            expect(@result_put.parsed_response["msg"]).to eql "Users.email cannot be null"
        end
    end

end