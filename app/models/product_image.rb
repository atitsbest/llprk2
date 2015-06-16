class ProductImage < ActiveRecord::Base
    has_attached_file :content,
        :styles => {
            :retina => "800x800",
            :normal => "400x400",
            :gallery => "200x200",
            :thumbnail => "100x100"
        },
        :convert_options => {
            :normal => "-strip",
            :retina => "-quality 50 -strip",
            :gallery => "-quality 75 -strip" 
        },
        processors: [:bulk]

    after_post_process -> { Paperclip::BulkQueue.process(content) }

    validates_attachment :content,
        :presence => true,
        :content_type => { :content_type => /\Aimage\/.*\Z/ },
        :size => { :less_than => 1.megabyte }
end
