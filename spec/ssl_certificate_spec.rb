require 'rspec'
require 'json'
require_relative '../models/ssl_certificate'

describe 'When creating an ssl certificate from text' do

  after { File.delete("certificate.pem")}

  let(:cloud_foundry_json_string) {
      '{
      "ctl_mysql": [
      {
          "credentials": {
      "certificate": "-----BEGIN CERTIFICATE-----\nMIIDgTCCAmmgAwIBAgIJAMubOSUqSIZOMA0GCSqGSIb3DQEBCwUAMFcxGTAXBgNV\nBAoMEENlbnR1cnlMaW5rREJhYVMxHTAbBgNVBAsMFENlcnRpZmljYXRlQXV0aG9y\naXR5MRswGQYDVQQDDBJDZW50dXJ5TGlua0RCYWFTQ0EwHhcNMTUwNjEyMDExMzIx\nWhcNMjUwNjA5MDExMzIxWjBXMRkwFwYDVQQKDBBDZW50dXJ5TGlua0RCYWFTMR0w\nGwYDVQQLDBRDZXJ0aWZpY2F0ZUF1dGhvcml0eTEbMBkGA1UEAwwSQ2VudHVyeUxp\nbmtEQmFhU0NBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzN5bNNjV\nGLZzq1vpGzgIDBdKzZtl625QSCVXu5vOGKZxsQDdMcflDylOPlOyJmg6t9KEkduQ\nKJvZhAoR03/ftqsYTNvzsbzyTraZb3fK7NZhbPLml9JLGrCeN0F3XmmYCKy+hoDA\nIegCOk4QazHu2XvVp/ATFc+w9jzEb6uHRrfvXtBPoGV3Td5tqfLEx+ZC9JAm6Ri3\n/eT8D+ys+sKYUyPPqJD12QN/ceWjvBrlCpyca2QoBb7OfZOZR8Q/xhxznYLsqBda\n4gWov23bGOVj9vSD/2kr9eSO+Ap739Awlso/hOjB/abDumsW9t1NPYSdscjxTD+t\n2EVcdGrvT5CT+QIDAQABo1AwTjAdBgNVHQ4EFgQULNhBKIj12kTdxWrg/hwMbtSk\nND4wHwYDVR0jBBgwFoAULNhBKIj12kTdxWrg/hwMbtSkND4wDAYDVR0TBAUwAwEB\n/zANBgkqhkiG9w0BAQsFAAOCAQEAbuEg3VquJxgg5exRtdgff9tWTozM0OozJc6d\noYgV11oH8NtvKLkwbChgGHKL1bXmMxTfW4vUk3FhuiO5S85oi0vvDGPq5gqM6oxr\ntbhaml7Nd0OoNCvRsGJiINKS3G8JRKmZ3+WA55wQEjZC5KuPlgB5XO418byYYDnc\n/k08pmEr8ztymAjVvc6rzlK0ZmUJqQnIEk+cDTHNYbALQwJ7+QZMbOGj1v/9w05M\nxFpTIBmySTP2+leCTP2qnJUiFc9yzfcMPQs6wS1KOOTwWS5LAqEUicZ17hCOMUi+\n1J1oVss1KdfPYfhSmbCbPg1ELwEHvnE7Bo4ildRlPGeSSb+gZw==\n-----END CERTIFICATE-----",
      "dbname": "default",
      "host": "66.151.15.159",
      "password": "OlWtxgKvyvSn9it6",
      "port": 49171,
      "username": "admin"
  },
      "label": "ctl_mysql",
      "name": "bab-mysql",
      "plan": "free",
      "tags": []
  }
  ]
  }'
  }

  let(:cloud_foundry_json) {JSON.parse(cloud_foundry_json_string)}

  it 'should store certificate text into a file' do
    certificate_text = "cert text\n"
    cert = SslCertificate.new(certificate_text)

    cert.create_pem("certificate.pem")

    File.open("certificate.pem") do |f|
      line = f.readline()
      expect(line).to eq("cert text\n")
    end
  end

  it 'should create certificate file from CloudFoundry JSON' do
    cert = SslCertificate.FromCloudFoundryJSON(cloud_foundry_json_string)
    cert.create_pem("certificate.pem")

    File.open("certificate.pem") do |f|
      lines = f.readlines().join
      expect(lines).to eq(cloud_foundry_json["ctl_mysql"][0]["credentials"]["certificate"])
    end
  end
end