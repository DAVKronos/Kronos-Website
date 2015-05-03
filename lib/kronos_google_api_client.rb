require 'google/api_client'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'

class KronosGoogleAPIClient

  # Initialize the client.
  client = Google::APIClient.new(
      :application_name => 'Kronos-Website',
      :application_version => '1.0.0'
  )

# Load client secrets from your client_secrets.json.
  client_secrets = Google::APIClient::ClientSecrets.load

end

