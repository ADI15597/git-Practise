trigger opportunityTrigger on Opportunity (before insert,before update) 
{
    for(opportunity ObjOpp : trigger.new)
    {
        if(trigger.isInsert)
        {
            
                    }
        if(trigger.isUpdate)
        { 
           
           
        }
    }
    
    
}