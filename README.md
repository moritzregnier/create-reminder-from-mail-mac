# Create reminder from mail for Mac OS X
Create a reminder from a selected email message. The script supports 

- up to 6 email accounts (in Mail.app) and 
- up to 6 reminder lists (in Reminder.app).
- It avoids duplicate reminder entries.
- It has a switch to set 'auto-archiving' on/off

### Additional features

Compared to his original I did the following modifications:

- support for six email accounts (e.g. 2x work, 4x personal accounts or whatever) instead of 2
- an optional modification dialog for a custom title instead of only the messages subject
- identification of an existing reminder based on the unique message id instead of the subject
- allowing to reschedule / set a new date for mails with existing reminder
- extended the list of possible reminder dates
- configure the default reminder time
- switch on/off auto-archiving
- simplying the configuration of the script

### Screenshots

![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder01.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder02.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder03.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder04.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder05.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder06.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder07.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder08.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder09.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/emailreminder10.jpg)  

### Installation

For installation follow Michaels page while using the script here. Basically you 

- create in Automator a service with no input and only for Mail.app
- add a step that executes AppleScript (and replace the given code by this one)
- save it in ~/Library/Service with some useful name like "Create Reminder from Email"
- and give it a Keyboard shortcut under System Preferences > Keyboard > Shortcuts > Services 

Find a step by step description on [mackungfu.org](http://www.mackungfu.org/create-email-reminders-within-email-app).

![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/workflow.png)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/master/screenshots/keyboardshortcut.png)  
