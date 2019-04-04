require 'google/apis/admin_directory_v1'
require 'google/api_client/client_secrets'
require 'googleauth'

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
    authorization = Google::Auth.get_application_default(self.get_config)
    @admin_api = Google::Apis::AdminDirectoryV1::DirectoryService.new
    @admin_api.client_options.application_name ='Kronos-Website'
    @admin_api.client_options.application_version ='1.0.0'
    some_headers = {"person": "webmaster@kronos.nl"}
    authorization.apply(some_headers)
    authorization.fetch_access_token!
    @admin_api.authorization = authorization

  end


  def members_of_group(email)
    result = @admin_api.list_members(:groupKey => email)

    result.data
  end

  def create_email_group(email, name, description)
    group = Google::Apis::AdminDirectoryV1::Group.new(:email => email, :name => name,
                                                       :description => description)
    @admin_api.insert_group(group)
    result
  end

  def destroy_email_group(email)

    result = @admin_api.delete_group(:groupKey => email)
    result.success?

  end

  def add_member_to_group(user, group_email)
    member = Google::Apis::AdminDirectoryV1::Member.new(:email => user.email, :name => user.name)
    result = @admin_api.insert_member(group_email, member)

    result.success?
  end

  def remove_member_from_group(user, group_email)
    result = @admin_api.delete_member(group_email, user.email)

    result.success?
  end

  def add_alias_to_group(alia, group_email)

    member = Google::Apis::AdminDirectoryV1::Member.new(:email => alia.emailaddress, :name => alia.name)
    result = @admin_api.insert_member(group_email, member)

    result.success?
  end

  def remove_alias_from_group(alia, group_email)
    result = @admin_api.delete_member(group_email, alia.emailaddress)

    result.success?
  end

  def add_group_to_group(mailinglis, group_email)
    member = Google::Apis::AdminDirectoryV1::Member.new(:email => mailinglis.full_email, :name => mailinglis.name)
    result = @admin_api.insert_member(group_email, member)

    result.success?
  end

  def remove_group_from_group(mailinglis, group_email)
    result = @admin_api.delete_member(group_email, mailinglis.full_email)

    result.success?
  end

end
