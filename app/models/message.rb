class Message < ApplicationRecord
  after_create_commit { broadcast_prepend_to :messages }
  after_update_commit { broadcast_replace_to :messages }

end
