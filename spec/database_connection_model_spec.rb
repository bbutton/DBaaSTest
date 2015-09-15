require 'rspec'
require_relative '../models/database_connection_model'

describe 'When reading JSON connection information from CloudFoundry' do
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

  it 'should create the correct connection value dictionary' do
    connection_model = DatabaseConnectionModel.new("host_name", "port", "user_id", "password", "database", "cert_data", "cert.pem")

    connection_hash = connection_model.to_hash

    expect(connection_hash).to eq({host: 'host_name', port: 'port', username: 'user_id', password: 'password', database: 'database', sslcert: 'cert.pem'})
  end

  it 'should create the connection model from cloud foundry json' do
    connection_model = DatabaseConnectionModel.FromCloudFoundryJson(cloud_foundry_json_string, 'cert.pem')

    connection_hash = connection_model.to_hash

    expect(connection_hash).to eq({host: '66.151.15.159', port: 49171, username: 'admin', password: 'OlWtxgKvyvSn9it6', database: 'default', sslcert: 'cert.pem'})
  end
end