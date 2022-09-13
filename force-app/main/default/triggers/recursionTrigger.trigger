trigger recursionTrigger on Account (after update,before update) 
{
    
    map<id,account> accMap = new map<id,account>();
    for(account objAccount : trigger.new)
    {
        if(!string.isEmpty(objAccount.Status__c))
        {
            accMap.put(objAccount.Id,objAccount);
        }
    }
    
    list<contact> ConList = new list<contact>();
    list<account> acclist = new list<account>();
    if(!accMap.isEmpty())
    {
        for(contact objectCon : [select id,AccountId,Account_Status__c,Account.status__c from contact where AccountId IN :accMap.keySet()])
        {
            ConList.add(objectCon);
        }
        
    }
    
    
    if(!ConList.isEmpty())
    {
        if(trigger.isAfter && trigger.isUpdate)
        {
            for( contact objCon : ConList)
            {
                if(accMap.containsKey(objCon.accountId))
                {
                    if(accMap.get(objCon.accountId).status__c == 'Pending')
                    {
                        objCon.Account_Status__c = 'Rejected';
                        
                    }
                }
            }
            database.update (conlist,false);
        }
        if(trigger.isBefore && trigger.isupdate)
        {
            for( contact objCon : ConList)
            {
                if(objCon.Account_Status__c  == 'Rejected' )
                {
                    
                    accMap.get(objCon.AccountId).status__c = 'Pending';
                    
                    
                }
            }
            
        }
    }
}