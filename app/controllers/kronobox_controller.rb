class KronoboxController < ApplicationController
  load_and_authorize_resource

  def elfinder

    all_commissions = Commission.all
    my_commissions = current_user.commissions
    not_my_commissions = all_commissions.delete_if {|c| my_commissions.include?(c)}
    
    noaccess =  not_my_commissions.map! { |commission| "#{commission.name}" }.join("|") unless not_my_commissions.empty?
    access = my_commissions.map! { |commission| "#{commission.name}" }.join("|") unless my_commissions.empty? 

    perm_commissions = Hash.new ;
    
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
    :perms =>  perm_commissions,
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