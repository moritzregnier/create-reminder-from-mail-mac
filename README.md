# Create reminder from mail for Mac OS X
Create a reminder from a selected email message: supports for 6 accounts and avoids duplicates

This AppleScript is a modification of the script found at http://www.michaelkummer.com/2014/03/18/how-to-create-a-reminder-from-an-e-mail/. Thanks Michael for that great job.

Compared to his original I did the following modifications:

- support for six email accounts (2x work, 4x personal) instead of 2
- an optional modification dialog for a custom title instead of only the messages subject
- identification of an existing reminder based on the unique message id instead of the subject
- allowing to reschedule / set a new date for mails with existing reminder
- simplying the configuration of the script

For installation follow Michaels page while using the script here. Basically you 

- create in Automator a service with no input and only for Mail.app
- add a step that executes AppleScript (and replace the given code by this one)
- save it in ~/Library/Service with some useful name like "Create Reminder from Email"
- and give it a Keyboard shortcut under System Preferences > Keyboard > Shortcuts > Services 
