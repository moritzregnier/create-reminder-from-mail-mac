#################################################################################
# Title: Create reminder from selected Mail
#################################################################################

# Use at your own risk and responsibility
# Backup your data before use

# Last update: 2016-03-15
# Version: 0.4.2
# Tested on OS X 10.11.3 El Capitan

# Description
# When installed as a Service, this AppleScript script can be used to automatically create a reminder (in pre-defined Reminder lists)
# from a selected email and flag the email.
# If you run the script against an email that matches an existing reminder it can mark the reminder as completed and clear the flag in Mail

# Contributors and sources
# Rick0713 at https://discussions.apple.com/thread/3435695?start=30&tstart=0
# http://www.macosxautomation.com/applescript/sbrt/sbrt-06.html
# http://www.michaelkummer.com/2014/03/18/how-to-create-a-reminder-from-an-e-mail/

#################################################################################
# Configuration
#################################################################################

# Set this according to your email account names and Reminder's lists
# Depending on your needs multiple accounts can send reminders to one or more reminder lists
set Work1AccountName to "Work"
set Work1RemindersList to "Work"
set Work2AccountName to "WorkOther"
set Work2RemindersList to "Work"
set Personal1AccountName to "Privat"
set Personal1RemindersList to "Privat"
set Personal2AccountName to "iCloud"
set Personal2RemindersList to "Privat"
set Personal3AccountName to "Google"
set Personal3RemindersList to "Privat"
set Personal4AccountName to "PrivatOther"
set Personal4RemindersList to "Privat"

# Set the name of the default reminder list (depends on your OS Language)
set DefaultReminderList to "Reminders"

# On my machine 5 is the Purple flag, which is the color I would like to use for mails flagged as Reminder
# choose something between 1 and 6
set FlagIndex to 5

# set the default reminder date
# these are the possible choices: "Tomorrow", "2 Days", "3 Days", "4 Days", "End of Week", "Next Monday", "1 Week", "2 Weeks", "1 Month", "2 Months", "3 Months"
set defaultReminder to "1 Week"

# set the default reminder time in hours after midnight, I suggest any number between 0,5 and 23,5
# for a reminder at "8:00 am" set "8", for "3 PM" or "15:00" set "15", for "8h30" set "8,5"
set defaultReminderTime to "8,75"

# switch 'auto-achive' "on" or "off"
set switchArchive to "on"

# set the archive target mailbox
set Work1Archive to "Archive"
set Work2Archive to "Archive"
set Personal1Archive to "Archive"
set Personal2Archive to "Archive"
set Personal3Archive to "Archive"
set Personal3Archive to "Archive"

#################################################################################
# Script
#################################################################################

tell application "Mail"
	set theSelection to selection as list
	# do nothing if no email is selected in Mail
	try
		set theMessage to item 1 of theSelection
	on error
		return
	end try
	
	set theSubject to theMessage's subject
	set theOrigMessageId to theMessage's message id
	set theUrl to {"message:%3C" & my replaceText(theOrigMessageId, "%", "%25") & "%3E"}
	
	# display a dialog to ask for the reminder title
	if flag index of theMessage is not FlagIndex then
		display dialog "Create a reminder with the following title: '" & theSubject & "' or choose 'Other'" with title "Choose a title for the reminder" buttons {"Other", "Cancel", "OK"} default button 3
		
		set theSubjectChoice to button returned of result
		if theSubjectChoice is "OK" then
			set theSubject to theMessage's subject
		else if theSubjectChoice is "Cancel" then
			return
		else if theSubjectChoice is "Other" then
			set theSubject to text returned of (display dialog "Choose a title:" default answer "")
		end if
	end if
	
	# Make sure reminder doesn't already exist so we don't create duplicates
	tell application "Reminders"
		set theNeedlesName to name of reminders whose body is theUrl and completed is false
		if theNeedlesName is not {} then
			# make sure dialog is in focus when called as a service
			# without the below, Mail would be the active application
			tell me
				activate
			end tell
			set theButton to button returned of (display dialog "The selected email matches an existing reminder: '" & theNeedlesName & "'. Would you like to mark the reminder as complete and clear any remaining flags of this message?" with title "Create Reminder from E-Mail" buttons {"New date", "Cancel", "Mark complete"} default button 3)
			
			if theButton is "Mark complete" then
				tell application "Mail"
					# unflag email/message
					set flag index of theMessage to -1
				end tell
				# find correct reminder based on subject and mark as complete
				set theNeedle to last reminder whose body is theUrl and completed is false
				set completed of theNeedle to true
				return
			else if theButton is "New date" then
				# set the new reminder date
				
				# present user with a list of follow-up times (in minutes)
				(choose from list {"Tomorrow", "2 Days", "3 Days", "4 Days", "End of Week", "Next Monday", "1 Week", "2 Weeks", "1 Month", "2 Months", "3 Months"} default items defaultReminder OK button name "Set new date" with prompt "Set follow-up time" with title "Set new reminder date")
				
				set reminderDate to result as text
				
				# Exit if user clicks Cancel
				if reminderDate is "false" then return
				
				# choose the reminder date
				set remindMeDate to my chooseRemindMeDate(reminderDate)
				
				# find correct reminder based on subject and mark as complete
				set theNeedle to last reminder whose body is theUrl and completed is false
				set remind me date of theNeedle to remindMeDate
				return
			else if theButton is "Cancel" then
				return
			end if
			
		end if
	end tell
	
	# present user with a list of follow-up times (in minutes)
	(choose from list {"Tomorrow", "2 Days", "3 Days", "4 Days", "End of Week", "Next Monday", "1 Week", "2 Weeks", "1 Month", "2 Months", "3 Months"} default items defaultReminder OK button name "Create" with prompt "Set follow-up time" with title "Create Reminder from E-Mail")
	
	set reminderDate to result as rich text
	
	# Exit if user clicks Cancel
	if reminderDate is "false" then return
	
	# choose the reminder date
	set remindMeDate to my chooseRemindMeDate(reminderDate)
	set time of remindMeDate to 60 * 60 * defaultReminderTime
	
	# Flag selected email/message in Mail
	set flag index of theMessage to FlagIndex
	
	# Get the unique identifier (ID) of selected email/message
	set theOrigMessageId to theMessage's message id
	
	#we need to encode % with %25 because otherwise the URL will be screwed up in Reminders and you won't be able to just click on it to open the linked message in Mail
	set theUrl to {"message:%3C" & my replaceText(theOrigMessageId, "%", "%25") & "%3E"}
	
	# determine correct Reminder's list based on account the email/message is in
	if name of account of mailbox of theMessage is Work1AccountName then
		set RemindersList to Work1RemindersList
	else if name of account of mailbox of theMessage is Work2AccountName then
		set RemindersList to Work2RemindersList
	else if name of account of mailbox of theMessage is Personal1AccountName then
		set RemindersList to Personal1RemindersList
	else if name of account of mailbox of theMessage is Personal2AccountName then
		set RemindersList to Personal2RemindersList
	else if name of account of mailbox of theMessage is Personal3AccountName then
		set RemindersList to Personal3RemindersList
	else if name of account of mailbox of theMessage is Personal4AccountName then
		set RemindersList to Personal4RemindersList
	else if account type of account of mailbox of theMessage is "r/o" then
		#default list name in Reminders
		set RemindersList to DefaultReminderList
	else
		#default list name in Reminders
		set RemindersList to DefaultReminderList
	end if
	
	# dispatch the mailbox where to archive the selected message
	if switchArchive is "on" then
		if name of account of mailbox of theMessage is Work1AccountName then
			move theMessage to mailbox Work1Archive of account Work1AccountName
		else if name of account of mailbox of theMessage is Work2AccountName then
			move theMessage to mailbox Work2Archive of account Work2AccountName
		else if name of account of mailbox of theMessage is Personal1AccountName then
			move theMessage to mailbox Personal1Archive of account Personal1AccountName
		else if name of account of mailbox of theMessage is Personal2AccountName then
			move theMessage to mailbox Personal2Archive of account Personal2AccountName
		else if name of account of mailbox of theMessage is Personal3AccountName then
			move theMessage to mailbox Personal3Archive of account Personal3AccountName
		else if name of account of mailbox of theMessage is Personal4AccountName then
			move theMessage to mailbox Personal4Archive of account Personal4AccountName
		end if
	end if
	
end tell

tell application "Reminders"
	
	tell list RemindersList
		# create new reminder with proper due date, subject name and the URL linking to the email in Mail
		make new reminder with properties {name:theSubject, remind me date:remindMeDate, body:theUrl}
		
	end tell
	
end tell


#################################################################################
# Functions
#################################################################################

# string replace function
# used to replace % with %25
on replaceText(subject, find, replace)
	set prevTIDs to text item delimiters of AppleScript
	set text item delimiters of AppleScript to find
	set subject to text items of subject
	
	set text item delimiters of AppleScript to replace
	set subject to "" & subject
	set text item delimiters of AppleScript to prevTIDs
	
	return subject
end replaceText

# date calculation with the selection from the dialogue
# use to set the initial and the re-scheduled date
on chooseRemindMeDate(selectedDate)
	if selectedDate = "Tomorrow" then
		# add 1 day and set time to 9h into the day = 9am
		set remindMeDate to (current date) + 1 * days
		
	else if selectedDate = "2 Days" then
		set remindMeDate to (current date) + 2 * days
		
	else if selectedDate = "3 Days" then
		set remindMeDate to (current date) + 3 * days
		
	else if selectedDate = "4 Days" then
		set remindMeDate to (current date) + 4 * days
		
	else if selectedDate = "End of Week" then
		# end of week means Thursday in terms of reminders
		# get the current day of the week
		set curWeekDay to weekday of (current date) as string
		if curWeekDay = "Monday" then
			set remindMeDate to (current date) + 3 * days
		else if curWeekDay = "Tuesday" then
			set remindMeDate to (current date) + 2 * days
		else if curWeekDay = "Wednesday" then
			set remindMeDate to (current date) + 1 * days
			# if it's Thursday, I'll set the reminder for Friday
		else if curWeekDay = "Thursday" then
			set remindMeDate to (current date) + 1 * days
			# if it's Friday I'll set the reminder for Thursday next week
		else if curWeekDay = "Friday" then
			set remindMeDate to (current date) + 6 * days
		else if curWeekDay = "Saturday" then
			set remindMeDate to (current date) + 5 * days
		else if curWeekDay = "Sunday" then
			set remindMeDate to (current date) + 4 * days
		end if
		
	else if selectedDate = "Next Monday" then
		set curWeekDay to weekday of (current date) as string
		if curWeekDay = "Monday" then
			set remindMeDate to (current date) + 7 * days
		else if curWeekDay = "Tuesday" then
			set remindMeDate to (current date) + 6 * days
		else if curWeekDay = "Wednesday" then
			set remindMeDate to (current date) + 5 * days
		else if curWeekDay = "Thursday" then
			set remindMeDate to (current date) + 4 * days
		else if curWeekDay = "Friday" then
			set remindMeDate to (current date) + 3 * days
		else if curWeekDay = "Saturday" then
			set remindMeDate to (current date) + 2 * days
		else if curWeekDay = "Sunday" then
			set remindMeDate to (current date) + 1 * days
		end if
		
	else if selectedDate = "1 Week" then
		set remindMeDate to (current date) + 7 * days
		
	else if selectedDate = "2 Weeks" then
		set remindMeDate to (current date) + 14 * days
		
	else if selectedDate = "1 Month" then
		set remindMeDate to (current date) + 28 * days
		
	else if selectedDate = "2 Months" then
		set remindMeDate to (current date) + 56 * days
		
	else if selectedDate = "3 Months" then
		set remindMeDate to (current date) + 84 * days
		
	end if
	
	return remindMeDate
end chooseRemindMeDate
