trigger updateOpportunityFromEvent1 on Event (before insert,before update,after delete) {

     map<id,opportunity> opps = new map<id,opportunity>();
    for(event record:trigger.new) 
    {
        if(trigger.isInsert || trigger.isUpdate)
        {
            if(record.whatid != null && record.whatid.getsobjecttype() == opportunity.sobjecttype) 
            {
                opps.put(record.whatid, new opportunity(id=record.whatid, Latetst_Activity__c = dateTime.now()));
            }
            
              
        }
        update opps.values();
}
}