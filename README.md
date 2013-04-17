The code in this repo was built for a new dynamically-searchable database of meetings pertinent to Intergroup Central Office of Santa Clara County, Inc.   It is authored in Ruby on Rails.  

However!  I realized it's basically like a custom CMS, and it can be modified and adaped to other counties and intergroups.  All you need is a .CSV of data listing out all the meetings in your group -- customize it as your own!  Meetings in a .CSV file can be mass-uploaded and mass-updated (to update many records at once), or individually.  For the correct format of the .CSV file check out 

db/all-meetings-formatted-plain-urls.csv

which has been tested and WORKS with the current site.

The main things to note are that:  

* Column header column names must be lower-case
* URLs should be plain http:// strings -- no spaces before or after them
* Watch out for empty spaces at the beginning or end of the column headers

The admin interface does require authentication be given via command-line.  
