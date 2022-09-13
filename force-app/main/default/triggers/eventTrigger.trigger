trigger eventTrigger on Event (before insert) {

      set<id> oppIDSet = new set<id>();
    
    if(trigger.isInsert || trigger.isupdate || trigger.isUndelete)
    {
        for(Event ObjEvent : trigger.new)
        {
            oppIDSet.add(ObjEvent.whatid);
        }
    }
    if(trigger.isdelete)
    {
        
        for(Event ObjEvent : trigger.new)
        {
            oppIDSet.add(ObjEvent.whatid);
        }
    }
    
    map<id,opportunity> oppMAp = new map<id,opportunity>();
    if(!oppIDSet.isEmpty())
    {
        for(opportunity ObjectOpp  : [select id,Latetst_Activity__c,(select id,LastModifiedDate from Events order by LastModifiedDate limit 1) from opportunity where id IN:oppIDSet] )
        {
            oppMAp.put(ObjectOpp.id, ObjectOpp);
        }
    }
    if(!oppMAp.isEmpty())
    {
        if(trigger.isInsert || trigger.isupdate || trigger.isUndelete)
        {
            for(Event ObjEvent : trigger.new)
            {
                if(oppMAp.containsKey(ObjEvent.whatid))
                {
                    oppMAp.get(ObjEvent.whatid).Latetst_Activity__c = dateTime.now();
                }
            }
        }
        if( trigger.isDelete)
        {
            for(Event ObjEvent : trigger.old)
            {
                if(oppMAp.containsKey(ObjEvent.whatid))
                {
                    list<task> taskList = oppMAp.get(ObjEvent.whatid).tasks;
                    for(task objectTask :taskList )
                    {
                         oppMAp.get(ObjEvent.WhoId).Latetst_Activity__c = ObjEvent.LastModifiedDate;
                    }
                   
                }
            }
        }
    }
    list<opportunity> leadUpdate = new list<opportunity>();
    leadUpdate.add(oppMAp.values());
    if(!leadUpdate.isEmpty())
    {
      update leadUpdate;
    }
}