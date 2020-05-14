# == Schema Information
#
# Table name: kronometers
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  date              :date
#  public            :boolean
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#


# The default path for files is: :rails_root/public/system/:class/:attachment/:id_partition/:style/:filename
class Kronometer < ApplicationRecord

  has_attached_file :file, :styles => { :thumb => ["260", :png] },
                    path: ":rails_root/secure_files/:class/:attachment/:id_partition/:style/:filename",
                    url: "/kronometers/:id/display/:style"
  do_not_validate_attachment_file_type :file
end
