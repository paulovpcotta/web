class SourceFeedback < ActiveRecord::Base
  has_one :feedback
  has_one :professional_profession
end
