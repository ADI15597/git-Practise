trigger ContactRecursionTrigger on Contact (before update,after update)
{
    set<id> AccIdSet = new set<id>();
    for(contact objectcon  :trigger.new)
    {
        if(objectcon.Accountid != null)
        {
            AccIdSet.add(objectcon.Accountid);
        }
    }
    
    map<id,Account> AccMap = new map<id,Account>();
    if(!AccIdSet.isEmpty())
    {
        for(account ObjeAcc : [select id,status__c from account where id IN :AccIdSet  ])
        {
            AccMap.put(ObjeAcc.id,ObjeAcc);
        }
    }
    if(!AccMap.isEmpty())
    {
        if(trigger.isBefore && trigger.isUpdate)
        {
            for(contact objectcon  :trigger.new)
            {
                
                if( AccMap.get(objectcon.AccountId).status__c == 'Pending')
                {
                    objectcon.Account_Status__c = 'Rejected';
                }
            }
        }
        if(trigger.isAfter && trigger.isUpdate)
        {
            
            for(contact objectcon  :trigger.new)
            {
                
                if( objectcon.Account_Status__c == 'Rejected')
                {
                    AccMap.get(objectcon.AccountId).status__c = 'Pending';
                }
            }
            list<account> accUpdateList = new List<account>();
            accUpdateList.addAll(AccMap.values());

            if(CheackRecursion.firstCall)
            {
              CheackRecursion.firstCall = false ;
              update accUpdateList ;
            }
        }
    }
    
    
}