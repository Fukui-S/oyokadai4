class Relationship < ApplicationRecord
    belongs_to :following, class_name: "User"
    belongs_to :folloer, class_name: "User"
end
