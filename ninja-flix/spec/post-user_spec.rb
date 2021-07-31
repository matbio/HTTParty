describe "Dado que estou no Cadastro Usuário - API POST" do
    context "Quando insiro um novo usuário" do
        before do
            @new_user = build(:user).to_hash
            @result = ApiUser.user_post(@new_user)
        end

        it "Então ele é inserido - Sucesso (200)" do
            expect(@result.response.code).to eql "200"
        end
    end

    context "Quando tento inserir um usuário que já existe" do
        before do
            @new_user = build(:user).to_hash
            2.times do
                @result = ApiUser.user_post(@new_user)
            end
        end
        it "Então não será inserido - Error (409)" do
            expect(@result.response.code).to eql "409"
        end
        it "E vai retornar a mensagem [Oops. Looks like you already have an account with this email address.]" do
            expect(@result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address."
        end
    end

    context "Quando tento inserir um usuário sem um e-mail válido" do
        before do
            @new_user = build(:user_wrong_email).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Oops. You entered a wrong email.]" do
            expect(@result.parsed_response["msg"]).to eql "Oops. You entered a wrong email."
        end
    end

    context "Quando tento inserir um usuário vazio" do
        before do
            @new_user = build(:user_full_empty).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on full_name failed]" do
            expect(@result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed"
        end
    end

    context "Quando tento inserir um usuário com senha vazia" do
        before do
            @new_user = build(:user_password_empty).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on password failed]" do
            expect(@result.parsed_response["msg"]).to eql "Validation notEmpty on password failed"
        end
    end

    context "Quando tento inserir um usuário com e-mail vazio" do
        before do
            @new_user = build(:user_email_empty).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on email failed]" do
            expect(@result.parsed_response["msg"]).to eql "Validation notEmpty on email failed"
        end
    end

    context "Quando tento inserir um usuário nulo" do
        before do
            @new_user = build(:user_full_null).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on full_name failed]" do
            expect(@result.parsed_response["msg"]).to eql "Users.full_name cannot be null"
        end
    end

    context "Quando tento inserir um usuário com senha nula" do
        before do
            @new_user = build(:user_password_null).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on password failed]" do
            expect(@result.parsed_response["msg"]).to eql "Users.password cannot be null"
        end
    end

    context "Quando tento inserir um usuário com e-mail nulo" do
        before do
            @new_user = build(:user_email_null).to_hash
            @result = ApiUser.user_post(@new_user)
        end
        it "Então não será inserido - Error (412)" do
            expect(@result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on email failed]" do
            expect(@result.parsed_response["msg"]).to eql "Users.email cannot be null"
        end
    end
end