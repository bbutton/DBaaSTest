require 'mysql2'

get '/' do
  connection_string_hash = settings.connection_string.to_hash

  connection = Mysql2::Client.new(
      host: connection_string_hash[:host],
      port: connection_string_hash[:port],
      username: connection_string_hash[:username],
      password: connection_string_hash[:password],
      database: connection_string_hash[:database],
      sslca: "./client_cert.pem")

  results = connection.query("show status")

end