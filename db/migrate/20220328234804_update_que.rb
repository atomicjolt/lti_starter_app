class UpdateQue < ActiveRecord::Migration[6.1]
  def up
    # Whenever you use Que in a migration, always specify the version you're
    # migrating to. If you're unsure what the current version is, check the
    # changelog.
    Que.migrate!(version: 5)
  end

  def down
    # Migrate to version 0 to remove Que entirely.
    Que.migrate!(version: 3)
  end
end
