require 'json'

class SslCertificate
  def self.FromCloudFoundryJSON(vcap_services_json_string)
    vcap_services_json = JSON.parse(vcap_services_json_string)
    SslCertificate.new(vcap_services_json["ctl_mysql"][0]["credentials"]["certificate"])
  end

  def initialize(certificate_text)
    @certificate_text = certificate_text
  end

  def create_pem(pem_file_path)
    File.open(pem_file_path, "w") do |f|
      f.write(@certificate_text)
    end
  end
end