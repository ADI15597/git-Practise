trigger noOFContact on Contact (after insert,after update,after delete ,After Undelete) {

     set<id> accountIdSet = new set<id>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        for(contact objectcontact : trigger.new)
        {
            if(objectcontact.AccountId != null)
            {
                accountIdSet.add(objectcontact.AccountId);
            }
            
        }
    }
    if(trigger.isAfter && ( trigger.isUpdate || trigger.isDelete))
    {
        for(contact objectcontact : trigger.old)
        {
            if(objectcontact.AccountId != null)
            {
                accountIdSet.add(objectcontact.AccountId);
            }
            
        }
    }
    map<id,Account> accountMap = new map<id,Account>();
    if(!accountIdSet.isEmpty())
    {
        for(Account objectAccount : [select id,No_of_contacts__c,(select id from contacts) from Account where id IN:accountIdSet])
        {
            accountMap.put(objectAccount.id,objectAccount);
        }
    }
    if(!accountMap.isEmpty())
    {
        if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
        {
            for(contact objectcontact : trigger.new)
            {
                if(accountMap.containsKey(objectcontact.AccountId))
                {
                    list<contact> contactList = accountMap.get(objectcontact.AccountId).contacts;
                    
                    accountMap.get(objectcontact.AccountId).No_of_contacts__c = contactList.size();
                }
            }
            
        }
         if(trigger.isAfter && ( trigger.isUpdate || trigger.isDelete))
        {
            for(contact objectcontact : trigger.old)
            {
                if(accountMap.containsKey(objectcontact.AccountId))
                {
                    list<contact> contactList = accountMap.get(objectcontact.AccountId).contacts;
                    
                    accountMap.get(objectcontact.AccountId).No_of_contacts__c = contactList.size();
                }
            }
            
        }
    }
    list<Account> UpdateList = new list<Account>();
    UpdateList.addAll(accountMap.values());
     if(!UpdateList.isEmpty())
     {
         database.update(UpdateList,false);
     }
}