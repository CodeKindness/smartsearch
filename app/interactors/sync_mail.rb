class SyncMail
  include Interactor::Organizer

  organize FetchMail, ArchiveMail, NotifyUsers
end
