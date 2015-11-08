desc 'Syncs emails from imap service provider.'
task :sync_mail => :environment do
  SyncMail.call
end
