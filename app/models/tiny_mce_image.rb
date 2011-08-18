class TinyMceImage < ActiveRecord::Base
  validates_presence_of :alt, :file

  file_column :file
end
