unmailboxes *

## Account settings
set from = julien.tant@mattermost.com
set realname = "Julien Tant"

set mbox_type = Maildir
set folder = "~/.mail/julien.tant@mattermost.com"
set sendmail = "msmtp -a julien.tant@mattermost.com"
set header_cache = "~/.cache/mutt/julien.tant@mattermost.com/header_cache"
set message_cachedir = "~/.cache/mutt/julien.tant@mattermost.com/message_cache"

# mailbox settings
set spoolfile = +INBOX
set postponed = +Drafts
unset record
set trash = +Trash
set move = no

mailboxes "=INBOX" "=All\ Mail" "=Drafts" "=Sent\ Mail" "=Spam" "=Trash"
