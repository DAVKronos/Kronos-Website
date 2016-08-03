prawn_document do |pdf|
  @users.group_by(&:user_type).each do |user_type, users|
    pdf.text(user_type.name << " (totaal: #{users.count})", :size => 8)
    table_data = [["Geslacht", "Naam", "Adres", "Postcode", "Plaats", "Geboortedatum", "AU-licentienr.", "IBAN"]]
    table_data += users.collect{|u| [u.sex, u.name << ", " << u.initials, u.address, u.postalcode, u.city, I18n.l(u.birthdate, :format => :default), u.licensenumber, u.iban]}

    pdf.table(table_data, {:header => true, :cell_style => {:size => 7}})
  end
end

#%h1 Ledenlijst #{Time.now}
#- @users.group_by(&:user_type).each do |user_type, users|
#  %h2= user_type.name << " (totaal: #{users.count})"
#  %br
#  %table{border: 1}
#    %tr
#      %th geslacht
#      %th naam
#      %th addr
#      %th postcod
#      %th stad
#      %th geboortedag
#      %th licencienr
#      %th iban
#    - users.each do |user|
#      %tr
#        %td= user.sex
#        %td= user.name << ", " << user.initials
#        %td= user.address
#        %td= user.postalcode
#        %td= user.city
#        %td= l user.birthdate, :format => :default
#        %td= user.licensenumber
#        %td= user.iban
