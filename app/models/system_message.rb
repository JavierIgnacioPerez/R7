class SystemMessage < ApplicationRecord
  after_create_commit { broadcast_prepend_to :system_messages }
  after_update_commit { broadcast_replace_to :system_messages }
end
