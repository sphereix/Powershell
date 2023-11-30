\\hollandsfile01\MasterData

#whatif permissions changes
Convert-SIDHistoryNTFS "\\hollandsfile01\MasterData\Data\departmental"


#add new found SIDS 
Convert-SIDHistoryNTFS "\\hollandsfile01\MasterData\Data\departmental\Marketing" -add


#replace found sids with new sids
Convert-SIDHistoryNTFS "\\hollandsfile01\MasterData\Data\departmental\Marketing"