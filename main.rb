require 'rubygems'
require 'data_mapper'

require_relative './models/database_connection_model'
require_relative './models/ssl_certificate'

require_relative "./routes/routes.rb"

vcap_services = ENV["VCAP_SERVICES"]

puts "Read vcap_services of #{vcap_services}"
puts "current directory is #{Dir.getwd}"

connection_string_model = DatabaseConnectionModel.FromCloudFoundryJson(vcap_services, "./client_cert.pem")
ssl_certificate_file = SslCertificate.FromCloudFoundryJSON(vcap_services)

set :connection_string, connection_string_hash = connection_string_model.to_hash
ssl_certificate_file = ssl_certificate_file.create_pem('./client_cert.pem')

