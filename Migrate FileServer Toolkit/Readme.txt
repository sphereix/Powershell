#################################################
# File Server Migration Toolkit			#
# Compiled By Thomas Hughes 2023		#
# SID History Module by Ashley McGlone		#
#################################################

i put together this toolkit so that i could migrate a file server to a new domain with no trust in place between the domains and i wanted to retain the file permissions.

the module itself is very powerful however i needed specific functions from it to achieve what i needed.

we had 0 access to the source DC apart from to run scripts via a 3rd party.

Users & Groups are initially set up using Active Directory Migration Kit i created in this same github

using the scripts in this toolkit you can then match up the users SIDS from the old domain with the SIDS of the new users from the new domain

this generates two sidmapping files in two different folders, one for users one for groups - you run the commands from each folder and it'll convert the previous SIDS found in the filesystem with the new SIDS.


1) - import the SIDHistory Module by doing cd .\SIDHistory then run import-module .\SIDHistory.psm1
2) - run Get-GroupSIDHistory.ps1 and Get-UserSIDHistory on both domains to get two different SID outputs from each domain
3) - both scripts output the SIDs to C:\SIDHistoryGroups and C:\SIDHistoryUsers - make sure both SID outputs from each domain      exist in both folders, so you should have two files in both directories


C:\SIDHistoryGroups
domain1-Groups.csv
domain2-Groups.csv

C:\SIDHistoryUsers
domain1-Users.csv
domain2-Users.csv


4) - cd to C:\SIDHistoryGroups and run Export-SIDMappingGroupsMapFile 
5) - cd to C:\SIDHistoryUsers and run Export-SIDMappingUserMapFile
6) - you'll now have a SIDMap.csv file in each of the folders, one for users one for groups
so the contents of the directories will now look like:

C:\SIDHistoryGroups
domain1-Groups.csv
domain2-Groups.csv
sidmap.csv

C:\SIDHistoryUsers
domain1-Users.csv
domain2-Users.csv
sidmap.csv


7) - you can then run the commands to convert all the SIDS found to exist in the previous domain to the users in the new domain

to confirm the same commands work for both users and groups, its the SIDS that get replaced so group or user does not matter.

it does rely on the "sidmap.csv" file being called that though, which is why we do this in seperate directories

ensure that the user account your running this with has full access to the filesystem from the top down, might be a good idea to do a takeown first from the top down if you dont have access initially.


#whatif permissions changes
Convert-SIDHistoryNTFS "\\server\network\share" -whatif


#add new found SIDS 
Convert-SIDHistoryNTFS "\\server\network\share" -add


#replace found sids with new sids
Convert-SIDHistoryNTFS "\\server\network\share"


there is also Modify-SIDMapOutputShowUsername.ps1 as part of this toolkit, i put this together so that when i had the SIDmap file i could see who was who as this populates the names from the output of either domain1 or domain2-users.csv file

in the scenario i worked on users had multiple SIDS as the fileserver had changed hands a few times - i had to manually add in the mappings for the users and groups with extra SIDS to the sidmap file

