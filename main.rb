require 'rubygems'
require 'data_mapper'

require_relative './models/database_connection_model'
require_relative './models/ssl_certificate'

require_relative "./routes/routes.rb"

vcap_services = ENV["VCAP_SERVICES"]

puts "Read vcap_services of #{vcap_services}"
puts "current directory is #{Dir.getwd}"

pem_file_path = './client_cert.pem'

connection_string_model = DatabaseConnectionModel.FromCloudFoundryJson(vcap_services, pem_file_path)
ssl_certificate_file = SslCertificate.FromCloudFoundryJSON(vcap_services)
ssl_certificate_file.create_pem(pem_file_path)

set :connection_info, connection_string_model

