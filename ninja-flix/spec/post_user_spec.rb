describe "Dado que estou na API POST User" do
    context "Quando realizo a requisição" do     
        let(:result){ApiUser.user_post(build(:user).to_hash)}

        it "Então tenho uma resposta de sucesso (200)" do
            expect(result.response.code).to eql "200"
        end
    end

    context "Quando realizo a requisição com um e-mail já cadastrado" do
        let(:result){ApiUser.user_post(build(:user_duplicated_email).to_hash)}
        it "Então tenho uma resposta de conflict (409)" do
            expect(result.response.code).to eql "409"
        end
        it "E vai retornar a mensagem [Oops. Looks like you already have an account with this email address.]" do
            expect(result.parsed_response["msg"]).to eql "Oops. Looks like you already have an account with this email address."
        end
    end

    context "Quando realizo a requisição com um e-mail inválido" do
        let(:result){ApiUser.user_post(build(:user_wrong_email).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Oops. You entered a wrong email.]" do
            expect(result.parsed_response["msg"]).to eql "Oops. You entered a wrong email."
        end
    end

    context "Quando realizo a requisição com um usuário vazio" do
        let(:result){ApiUser.user_post(build(:user_full_empty).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on full_name failed]" do
            expect(result.parsed_response["msg"]).to eql "Validation notEmpty on full_name failed"
        end
    end

    context "Quando realizo a requisição com uma senha vazia" do
        let(:result){ApiUser.user_post(build(:user_password_empty).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on password failed]" do
            expect(result.parsed_response["msg"]).to eql "Validation notEmpty on password failed"
        end
    end

    context "Quando realizo a requisição com um e-mail vazio" do
        let(:result){ApiUser.user_post(build(:user_email_empty).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Validation notEmpty on email failed]" do
            expect(result.parsed_response["msg"]).to eql "Validation notEmpty on email failed"
        end
    end

    context "Quando realizo a requisição com um usuário nulo" do
        let(:result){ApiUser.user_post(build(:user_full_null).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Users.full_name cannot be null]" do
            expect(result.parsed_response["msg"]).to eql "Users.full_name cannot be null"
        end
    end

    context "Quando realizo a requisição com uma senha nula" do
        let(:result){ApiUser.user_post(build(:user_password_null).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Users.password cannot be null]" do
            expect(result.parsed_response["msg"]).to eql "Users.password cannot be null"
        end
    end

    context "Quando realizo a requisição com um e-mail nulo" do
        let(:result){ApiUser.user_post(build(:user_email_null).to_hash)}
        it "Então tenho uma resposta de Precondition Failed (412)" do
            expect(result.response.code).to eql "412"
        end
        it "E vai retornar a mensagem [Users.email cannot be null]" do
            expect(result.parsed_response["msg"]).to eql "Users.email cannot be null"
        end
    end
end