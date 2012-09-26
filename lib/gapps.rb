require 'gdata'
class Gapps
  def create_group(id, name, description)
    post = <<-EOF
<atom:entry xmlns:atom="http://www.w3.org/2005/Atom" xmlns:apps="http://schemas.google.com/apps/2006" xmlns:gd="http://schemas.google.com/g/2005">
      <apps:property name="groupId" value="#{id}"></apps:property>
      <apps:property name="groupName" value="#{name}"></apps:property>
      <apps:property name="description" value="#{description}"></apps:property>
      <apps:property name="emailPermission" value="Anyone"></apps:property>
    </atom:entry>
             EOF
    login
    @gapps.post("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl", post)
  end
  handle_asynchronously :create_group
  
  def destroy_group(id)
    login
    @gapps.delete("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl/#{id}")
  end
  handle_asynchronously :destroy_group
  
  def add_group_member(groupId, memberId, memberFamilyName, memberGivenName)
     post = <<-EOF
<?xml version="1.0" encoding="UTF-8"?>
      <atom:entry xmlns:atom="http://www.w3.org/2005/Atom"
          xmlns:apps="http://schemas.google.com/apps/2006"
          xmlns:gd="http://schemas.google.com/g/2005">
          <apps:property name="memberId" value="#{memberId}"/>
          <apps:name familyName="#{memberFamilyName}" givenName="#{memberGivenName}"/>
      </atom:entry>
      EOF
      login
      @gapps.post("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl/#{groupId}/member",post)
  end
  handle_asynchronously :add_group_member
  
  def destroy_group_member(groupId, memberId)
    login
    @gapps.delete("https://apps-apis.google.com/a/feeds/group/2.0/kronos.nl/#{groupId}/member/#{memberId}")
  end
  handle_asynchronously :destroy_group_member
  
  private
  
  def login
     @gapps = GData::Client::Apps.new
     @gapps.clientlogin('webmaster@kronos.nl', Settings.gapps_password)
   end
end