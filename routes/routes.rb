require 'mysql2'
require_relative '../models/database_connection_model'

get '/' do
  connection_string_model = settings.connection_info

  connection = Mysql2::Client.new(
      host: connection_string_model.host_name,
      port: connection_string_model.port,
      username: connection_string_model.user_id,
      password: connection_string_model.password,
      database: connection_string_model.database,
      sslca: connection_string_model.cert_file)

  results = connection.query("show status like 'Ssl_cipher'")
  results.count.to_s
end