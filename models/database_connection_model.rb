require 'json'

class DatabaseConnectionModel
  attr_reader :host_name, :port, :user_id, :password, :database, :cert_data, :cert_file

  def self.FromCloudFoundryJson(vcap_services_json_string, cert_file_name)
    vcap_service_json = JSON.parse(vcap_services_json_string)
    host_name = vcap_service_json["ctl_mysql"][0]["credentials"]["host"]
    port = vcap_service_json["ctl_mysql"][0]["credentials"]["port"]
    user_id = vcap_service_json["ctl_mysql"][0]["credentials"]["username"]
    password = vcap_service_json["ctl_mysql"][0]["credentials"]["password"]
    database = vcap_service_json["ctl_mysql"][0]["credentials"]["dbname"]
    cert_data = vcap_service_json["ctl_mysql"][0]["credentials"]["certificate"]

    DatabaseConnectionModel.new(host_name, port, user_id, password, database, cert_data, cert_file_name)
  end

  def initialize(host_name, port, user_id, password, database, cert_data, cert_file)
    @host_name = host_name
    @port = port
    @user_id = user_id
    @password = password
    @database = database
    @cert_file = cert_file
    @cert_data = cert_data
  end

  def to_hash
    {host: @host_name, port: @port, username: @user_id, password: @password, database: @database, sslcert: @cert_file}
  end
end