unmailboxes *

## Account settings
set from = aosixphone@gmail.com
set realname = "Julien Tant"

set mbox_type = Maildir
set folder = "~/.mail/aosixphone@gmail.com"
set sendmail = "msmtp -a aosixphone@gmail.com"
set header_cache = "~/.cache/mutt/aosixphone@gmail.com/header_cache"
set message_cachedir = "~/.cache/mutt/aosixphone@gmail.com/message_cache"

# mailbox settings
set spoolfile = +INBOX
set postponed = +Drafts
unset record
set trash = +Trash
set move = no

mailboxes "=INBOX" "=All\ Mail" "=Drafts" "=Sent\ Mail" "=Spam" "=Trash"
