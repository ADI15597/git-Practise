trigger leadTasksTrigger on Lead (after insert,after update) 
{
    decimal noOfTasks = 0;
    decimal updateVariable = 0;
    set<id> leadIdSet = new set<id>();
    list<task> deleteTaskList = new list<task>();
    list<task> taskUpdateList = new list<task>();
    
    for(Lead objLead : trigger.new)
    {
        
        
        if(objLead.No_Of_Tasks__c > 0)
        {
            leadIdSet.add(objLead.Id);
            if(trigger.isInsert)
            {
                noOfTasks = objLead.No_Of_Tasks__c;
            }
            if(trigger.isUpdate)
            {
                if(objLead.No_Of_Tasks__c != trigger.oldMap.get(objLead.id).No_Of_Tasks__c)
                {
                    system.debug('## inside update condition');
                    if(objLead.No_Of_Tasks__c > trigger.oldMap.get(objLead.id).No_Of_Tasks__c)
                    {
                        
                        noOfTasks = objLead.No_Of_Tasks__c - trigger.oldMap.get(objLead.id).No_Of_Tasks__c;
                        system.debug('## No of tasks'+noOfTasks);
                    }
                    if(objLead.No_Of_Tasks__c < trigger.oldMap.get(objLead.id).No_Of_Tasks__c)
                    {
                        updateVariable =  trigger.oldMap.get(objLead.id).No_Of_Tasks__c - objLead.No_Of_Tasks__c ;
                        
                    }
                }
            }
        }
        
    }
    
    if(updateVariable>0)
    {
        
        for(task objTask :[select id,whoId from task where whoId IN:leadIdSet order by createdDate ASC limit :(integer)updateVariable])
        {
            deleteTaskList.add(objTask);
        }
    }
    
    if(noOfTasks > 0)  
    {
        for(id LeadId : leadIdSet)
        {
            for (decimal i = 0; i < noOfTasks; i++) 
            {
                system.debug('## inside for loop');
                task objTask = new task();
                objTask.WhoId = leadid;
                system.debug('### whoId'+ objTask.WhoId);
                
                objTask.Subject = 'Call' ;
                system.debug('###subject'+objTask.Subject);
                
                objTask.Status ='In Progress' ;
                system.debug('### status'+objTask.Status);
                
                objTask.Priority ='High' ;
                system.debug('### priority'+objTask.Priority);
                
                
                objTask.ActivityDate = date.today();
                
                
                taskUpdateList.add(objTask);
            }
        }
    }
    
    if(!taskUpdateList.isEmpty())
    {
        insert taskUpdateList;
    }
    if(!deleteTaskList.isEmpty())
    {
        delete deleteTaskList;
    }
}