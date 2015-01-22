class ProductImage < ActiveRecord::Base
    has_attached_file :image,
        :styles => {
            :retina => "800x800",
            :normal => "400x400",
            :gallery => "200x200"
        }
    validates_attachment :image,
        :presence => true,
        :content_type => { :content_type => /\Aimage\/.*\Z/ },
        :size => { :less_than => 1.megabyte }
end
