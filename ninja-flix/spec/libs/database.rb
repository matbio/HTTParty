require "pg"

class Database
  def initialize
    @connection = PG.connect(host:"localhost", dbname: "nflix", user:"postgres", password: "qaninja")
  end

  def clean_db
    @connection.exec("DELETE FROM public.users WHERE ID > 1;")
  end

  def delete_user(email)
    @connection.exec("DELETE FROM public.users WHERE email = '#{email}';")
  end

  def insert_user(name, password, email)
    sql_script = "INSERT INTO public.users(full_name, password, email, created_at, updated_at)" \
    " VALUES('#{name}', '#{password}', '#{email}', current_timestamp, current_timestamp);"
    @connection.exec(sql_script)
  end

  def select_user(email)
    @connection.exec("SELECT id, full_name, password, email, created_at, updated_at FROM public.users WHERE email = '#{email}';").first
  end
end