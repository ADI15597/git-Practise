trigger latestDateTrigger on Task (after insert,after update,after delete) {
     set<Id> idSet = new set<Id>();
    if(trigger.isInsert || trigger.isUpdate)
    {
        for (Task Objtask : Trigger.new)
        {
            idSet.add(Objtask.WhatId); 
            system.debug('####'+idSet);
        }
    }
    
    if(trigger.isDelete)
    {
        for (Task Objtask : Trigger.old)
        {
            idSet.add(Objtask.WhatId);   
        }
    }
    

   
    List<Opportunity> updateList = new List<opportunity>();
       if(trigger.isInsert || trigger.isUpdate)
        {    
            List<Opportunity> OpportunityList = [select id,Name,Latetst_Activity__c,stageName from Opportunity where id IN : idSet ];
            for(opportunity Objoppo:OpportunityList)
            {
                if(trigger.isInsert)
                {
               Objoppo.Latetst_Activity__c= dateTime.now();
               system.debug('####lstest Activity = '+Objoppo.Latetst_Activity__c);
               updatelist.add(Objoppo);
                }
                if(trigger.isUpdate && Objoppo.StageName == 'Closed Won' )
                {
               Objoppo.Latetst_Activity__c= dateTime.now();
               system.debug('####lstest Activity = '+Objoppo.Latetst_Activity__c);
               updatelist.add(Objoppo);
                }

                
                
            }
        }
        if(trigger.isdelete)
        {
            for(opportunity ObjOppo  :[select id,name,Latetst_Activity__c,(select id,createdDate from tasks order by createdDate desc limit 1) from opportunity])
            {
                for(task objtask :ObjOppo.tasks)
                {
                     ObjOppo.Latetst_Activity__c= objtask.createdDate;
                       updatelist.add(ObjOppo);
                }
            }
            
        }
        
    
    
    if(!updatelist.isEmpty())
    {
        update updatelist;
    }
}