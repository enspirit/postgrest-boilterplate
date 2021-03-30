Sequel.migration do
  up do
    schema = ENV['PGRST_DB_SCHEMA']
    anon = ENV['PGRST_DB_ANON_USER']
    authenticator = ENV['PGRST_DB_AUTH_USER']
    authenticator_pass = ENV['PGRST_DB_AUTH_PASSWORD']
    run <<-SQL
      CREATE SCHEMA #{schema};
    SQL
    run <<-SQL
      CREATE ROLE #{anon} NOLOGIN;
      GRANT USAGE ON SCHEMA #{schema} TO #{anon};
    SQL
    run <<-SQL
      CREATE ROLE #{authenticator} NOINHERIT LOGIN PASSWORD '#{authenticator_pass}';
      GRANT #{anon} TO #{authenticator};
    SQL
  end
end
