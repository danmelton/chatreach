module ActsAsTaggableOn
  class Tag
    scope :alpha, :order => "name ASC"
    has_many :text_contents
  end
end
