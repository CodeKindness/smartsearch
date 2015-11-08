desc 'Syncs emails from imap service provider.'
task :sync_mail => :environment do
  result = FetchMail.call
  puts result.inspect
end
