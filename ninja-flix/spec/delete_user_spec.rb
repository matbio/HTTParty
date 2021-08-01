describe "Dado que estou na API DELETE User" do
    context "Quando eu realizo a requisição" do
        let(:user){build(:user_duplicated_email)}
        let(:token){ApiUser.user_auth(user.email,user.password)}
        let(:result){ApiUser.user_delete(token, user.id)}

        it "Então tenho uma resposta de No Content (204)" do
            expect(result.response.code).to eql "204"
        end
    end
    
    context "Quando eu envio a requisição" do
        let(:user){build(:user_not_found)}
        let(:token){ApiUser.user_auth(user.email,user.password)}
        let(:result){ApiUser.user_delete(token, user.id)}

        it "Então tenho uma resposta de Not Found (404)" do
            expect(result.response.code).to eql "404"
        end
    end

    context "Quando eu envio a requisição sem autorização" do
        let(:user){build(:user_duplicated_email)}
        let(:result){ApiUser.user_delete("", user.id)}

        it "Então tenho uma resposta de Unauthorized (401)" do
            expect(result.response.code).to eql "401"
        end
    end
end