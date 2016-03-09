# Create reminder from mail for Mac OS X
Create a reminder from a selected email message. The script supports 

- up to 6 email accounts (in Mail.app) and 
- up to 6 reminder lists (in Reminder.app).
- It avoids duplicate reminder entries.

This AppleScript is an extension of the script found at http://www.michaelkummer.com/2014/03/18/how-to-create-a-reminder-from-an-e-mail/.

### Additional features

Compared to his original I did the following modifications:

- support for six email accounts (e.g. 2x work, 4x personal accounts) instead of 2
- an optional modification dialog for a custom title instead of only the messages subject
- identification of an existing reminder based on the unique message id instead of the subject
- allowing to reschedule / set a new date for mails with existing reminder
- extended the list of possible reminder dates
- simplying the configuration of the script

### Screenshots

![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder01.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder02.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder03.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder04.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder05.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder06.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder07.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder08.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder09.jpg)  
![](https://github.com/moritzregnier/create-reminder-from-mail-mac/blob/cbecbb99b277e8fe243e69364ee5de92efbcd68e/emailreminder10.jpg)  

### Installation

For installation follow Michaels page while using the script here. Basically you 

- create in Automator a service with no input and only for Mail.app
- add a step that executes AppleScript (and replace the given code by this one)
- save it in ~/Library/Service with some useful name like "Create Reminder from Email"
- and give it a Keyboard shortcut under System Preferences > Keyboard > Shortcuts > Services 

