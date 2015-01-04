class KronoboxController < ApplicationController
  #load_and_authorize_resource
  skip_authorization_check

  def appshome
    key = Google::APIClient::PKCS12.load_key('/Users/woutertimmermans/Desktop/API Project-b9df7b3ac23f.p12', 'notasecret')

    asserter = Google::APIClient::JWTAsserter.new('971459186596-qb3ge4rqatff6tsjv4ccmcsvl9r65osi@developer.gserviceaccount.com', 'https://www.googleapis.com/auth/admin.directory.group', key)
    @client = Google::APIClient.new
    @client.authorization = asserter.authorize('webmaster@kronos.nl')

    @client.authorization.fetch_access_token!

    @group = @client.discovered_api("admin", "directory_v1")

    @disv = @group.members.list.parameters

    result = @client.execute(api_method: @group.groups.list, parameters: {"domain" => "kronos.nl"}).body
    result2 = JSON.parse(result)

    @hash = Hash.new
    result2['groups'].each do |g|
      @hash[g['email']] = {'name' => g['name'], 'email' => g['email'], 'members' => Array.new}
      result3 = JSON.parse(@client.execute(api_method: @group.members.list, parameters: {"groupKey" => g['id']}).body)
      if result3['members'] then
        result3['members'].each do |m|
          @hash[g['email']]['members'].push(m['email'])
        end
      end
    end

    @kronos_groups = Hash.new
    @kronos_groups['alleleden@kronos.nl'] = {'name' => 'Alle leden', 'email' => 'alleleden@kronos.nl', 'members' => Array.new}
    @kronos_groups['leden@kronos.nl'] = {'name' => 'Leden', 'email' => 'leden@kronos.nl', 'members' => Array.new}
    User.all.each do |h|
      if (h.user_type != UserType.find_by_name("Oudlid")) then
        @kronos_groups['alleleden@kronos.nl']['members'].push(h.email)
      end
      if (h.user_type == UserType.find_by_name("Wedstrijdlid") || h.user_type == UserType.find_by_name("Recreantlid") || h.user_type == UserType.find_by_name("Proeflid")) then
        @kronos_groups['leden@kronos.nl']['members'].push(h.email)
      end
    end
    Commission.all.each do |h|
      @kronos_groups[h.email] = {'name' => h.name, 'email' => h.email, 'members' => Array.new}
      h.commission_memberships.each do |m|
        @kronos_groups[h.email]['members'].push(m.user.email)
      end
    end

    exceptio = AppsException.all
    @exceptions = Hash.new
    exceptio.each do |value|
      if not @exceptions[value['group_email']] then
        @exceptions[value['group_email']] = Hash.new
        @exceptions[value['group_email']]['true'] = Array.new
        @exceptions[value['group_email']]['false'] = Array.new
      end
      if value.way then
        @exceptions[value['group_email']]['true'].push(value.email)
      else
        @exceptions[value['group_email']]['false'].push(value.email)
      end
    end

    @diff = Hash.new
    @kronos_groups.each do |key, value|
      if @hash[key] then
        @diff[key] = Hash.new
        @diff[key]['name'] = value['name']
        @diff[key]['email'] = value['email']
        @diff[key]['members_hier'] = Array.new
        @diff[key]['members_daar'] = Array.new
        if value['members'] && @hash[key]['members'] then
          @diff[key]['members_hier'] = value['members'] - @hash[key]['members']
        end
      end
    end
    @hash.each do |key, value|
      if @kronos_groups[key] then
        if not @diff[key] then
          @diff[key] = Hash.new
          @diff[key]['name'] = value['name']
          @diff[key]['email'] = value['email']
          @diff[key]['members_hier'] = Array.new
          @diff[key]['members_daar'] = Array.new
        end
        if value['members'] && @kronos_groups[key]['members'] then
          @diff[key]['members_daar'] = value['members'] - @kronos_groups[key]['members']
        end
      else
        @diff[key] = Hash.new
        @diff[key]['name'] = value['name']
        @diff[key]['email'] = value['email']
        @diff[key]['members_hier'] = Array.new
        @diff[key]['members_daar'] = Array.new
        if value['members'] then
          @diff[key]['members_daar'] = value['members']
        end
      end
    end
  end

  def groupadd
    key = Google::APIClient::PKCS12.load_key('/home/kronos/APIProject-c34ed1b047c8.p12', 'notasecret')

    asserter = Google::APIClient::JWTAsserter.new('971459186596-qb3ge4rqatff6tsjv4ccmcsvl9r65osi@developer.gserviceaccount.com', 'https://www.googleapis.com/auth/admin.directory.group', key)
    @client = Google::APIClient.new
    @client.authorization = asserter.authorize('webmaster@kronos.nl')

    @client.authorization.fetch_access_token!

    @group = @client.discovered_api("admin", "directory_v1")

    @client.execute(api_method: @group.members.insert, parameters: {"groupKey" => params['group']}, body_object: {"email" => params['mail']})

    redirect_to url_for :controller => 'kronobox', :action => 'appshome'
    return
  end

  def groupremove
    key = Google::APIClient::PKCS12.load_key('/home/kronos/APIProject-c34ed1b047c8.p12', 'notasecret')

    asserter = Google::APIClient::JWTAsserter.new('971459186596-qb3ge4rqatff6tsjv4ccmcsvl9r65osi@developer.gserviceaccount.com', 'https://www.googleapis.com/auth/admin.directory.group', key)
    @client = Google::APIClient.new
    @client.authorization = asserter.authorize('webmaster@kronos.nl')

    @client.authorization.fetch_access_token!

    @group = @client.discovered_api("admin", "directory_v1")

    @client.execute(api_method: @group.members.delete, parameters: {"groupKey" => params['group'], "memberKey" => params['mail']})
    redirect_to url_for :controller => 'kronobox', :action => 'appshome'
    return
  end

  def elfinder

    all_commissions = Commission.all
    my_commissions = current_user.commissions
    not_my_commissions = all_commissions.delete_if { |c| my_commissions.include?(c) }

    noaccess = not_my_commissions.map! { |commission| "#{commission.name}" }.join("|") unless not_my_commissions.empty?
    access = my_commissions.map! { |commission| "#{commission.name}" }.join("|") unless my_commissions.empty?

    perm_commissions = Hash.new;

    if current_user.admin?
      perm_commissions['.'] = {:read => true, :write => true, :rm => true}
    else
      perm_commissions[/^(#{noaccess})$/] = {:read => false, :write => false, :rm => false} unless noaccess.nil?
      perm_commissions[/^(#{access})$/] = {:read => true, :write => true, :rm => true} unless access.nil?
      perm_commissions['.'] = {:read => true, :write => false, :rm => false}
    end

    h, r = ElFinder::Connector.new(
        :root => File.join(Rails.public_path, 'system', 'elfinder'),
        :url => '/system/elfinder',
        :perms => perm_commissions,
        :extractors => {
            'application/zip' => ['unzip', '-qq', '-o'],
            'application/x-gzip' => ['tar', '-xzf'],
        },
        :archivers => {
            'application/zip' => ['.zip', 'zip', '-qr9'],
            'application/x-gzip' => ['.tgz', 'tar', '-czf'],
        },
        :thumbs => true
    ).run(params)

    headers.merge!(h)
    render (r.empty? ? {:nothing => true} : {:text => r.to_json}), :layout => false
  end

end