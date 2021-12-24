class SystemMessage < ApplicationRecord
  after_create_commit { broadcast_update_to :system_messages, target: :connection_count }
  after_update_commit { broadcast_update_to :system_messages, target: :connection_count }
end
