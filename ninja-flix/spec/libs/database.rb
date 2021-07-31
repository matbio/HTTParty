require "pg"

class Database
  def initialize
    @connection = PG.connect(host:"localhost", dbname: "nflix", user:"postgres", password: "qaninja")
  end

  def delete_user(email)
    @connection.exec("DELETE FROM public.users WHERE email = '#{email}';")
  end

  def insert_user(name, password, email)
    sql_script = "INSERT INTO public.users(full_name, password, email, created_at, updated_at)" \
    " VALUES('#{name}', '#{password}', '#{email}', current_timestamp, current_timestamp);"
    @connection.exec(sql_script)
  end
end