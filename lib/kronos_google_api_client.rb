require 'google/apis/admin_directory_v1'
require 'google/api_client/client_secrets'

class KronosGoogleAPIClient
  def get_config
    if Rails.env.production?
      return 'https://www.googleapis.com/auth/admin.directory.group'
    else
      return ['https://www.googleapis.com/auth/admin.directory.group.readonly', 'https://www.googleapis.com/auth/admin.directory.user.readonly']
    end
  end

  def initialize
    # Initialize the client.
    Google::Apis::ClientOptions.default.application_name = 'Kronos-Website'
    Google::Apis::ClientOptions.default.application_version = '1.0.0'
    @admin_api = Google::Apis::AdminDirectoryV1::DirectoryService.new
    client_secrets = Google::APIClient::ClientSecrets.load(:google_app_default)
    authorization = client_secrets.to_authorization
    authorization.scope = self.get_config
    authorization.fetch_access_token!
    @admin_api.authorization = authorization

  end


  def members_of_group(email)
    result = @admin_api.list_members(:groupKey => email)

    result.data
  end

  def create_email_group(email, name, description)

    @admin_api.insert_group( {:email => email, :name => name,
                                              :description => description})
    result
  end

  def destroy_email_group(email)

    result = @admin_api.delete_group(:groupKey => email)
    result.success?

  end

  def add_member_to_group(user, group_email)
    result = @admin_api.insert_member(group_email, {:email => user.email, :name => user.name})

    result.success?
  end

  def remove_member_from_group(user, group_email)
    result = @admin_api.delete_member(group_email, user.email)

    result.success?
  end

  def add_alias_to_group(alia, group_email)
    result = @admin_api.insert_member(group_email, {:email => alia.emailaddress, :name => alia.name})

    result.success?
  end

  def remove_alias_from_group(alia, group_email)
    result = @admin_api.delete_member(group_email, alia.emailaddress)

    result.success?
  end

  def add_group_to_group(mailinglis, group_email)
    result = @admin_api.insert_member(group_email, {:email => mailinglis.full_email, :name => mailinglis.name})

    result.success?
  end

  def remove_group_from_group(mailinglis, group_email)
    result = @admin_api.delete_member(group_email, mailinglis.full_email)

    result.success?
  end

end
