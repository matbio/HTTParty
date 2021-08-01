describe "Dado que estou na API GET User" do
    context "Quando eu realizo a requisição" do
        let(:user){build(:user_duplicated_email)}
        let(:token){ApiUser.user_auth(user.email,user.password)}
        let(:result){ApiUser.user_get(token, user.id)}
        let(:user_data){Database.new.select_user(user.email)}

        it "Então tenho uma resposta de Sucesso (200)" do
            expect(result.response.code).to eql "200"
        end
        it "E visualizo o nome do usuário" do
            expect(result.parsed_response["full_name"]).to eql user_data["full_name"]
        end
        it "E visualizo o e-mail do usuário" do
            expect(result.parsed_response["email"]).to eql user_data["email"]
        end
        it "E visualizo a senha do usuário" do
            expect(result.parsed_response["password"]).to eql user_data["password"]
        end
        it "E visualizo a data de criação do usuário" do
            expect(Time.parse(result.parsed_response["createdAt"])).to eql Time.parse(user_data["created_at"])
        end
        it "E visualizo a data de atualização do usuário" do
            expect(Time.parse(result.parsed_response["updatedAt"])).to eql Time.parse(user_data["updated_at"])
        end
            
    end
    context "Quando eu realizo a requisição sem autentiação" do
        let(:user){build(:user_duplicated_email)}
        let(:result){ApiUser.user_get("", user.id)}

        it "Então não visualizo o usuário - Unauthorized (401)" do
            expect(result.response.code).to eql "401"
        end
    end
    context "Quando eu realizo a requisição sem um usuário existente" do
        let(:user){build(:user_not_found)}
        let(:token){ApiUser.user_auth(user.email,user.password)}
        let(:result){ApiUser.user_get(token, user.id)}

        it "Então não visualizo o usuário - Not Found (404)" do
            expect(result.response.code).to eql "404"
        end
    end
end