trigger MaxOpportunity on Opportunity (After insert,After update,after delete,After Undelete) 
{
    set<id>AccIdSet = new set<id>();
    if(trigger.isInsert || trigger.isUpdate || trigger.IsUndelete)
    {
        for(opportunity objOpp : trigger.new)
        {
            if(objOpp.AccountId != null)
            {
                AccIdSet.add(objOpp.AccountId);
            }
        }
    }
    if(trigger.isUpdate || trigger.IsDelete)
    {
        for(opportunity objOpp : trigger.old)
        {
            if(objOpp.accountId != null)
            {
                AccIdSet.add(objOpp.accountId);
            }
        }
    }
    list<account> AccupdateList = new list<account>();
    if(!AccIdSet.isEmpty())
    {
         for(AggregateResult  result : [select accountId AccID,Max(Amount) maxAmt from Opportunity where accountID IN:AccIdSet group by accountId ])
         {
              Account objAcc= new Account();
             objAcc.Max_Opportunity_Amount__c = (Decimal) result.get('maxAmt');
             objAcc.id =  (id) result.get('AccID');
             AccupdateList.add(objAcc);
             
         }
    }
    if(!AccupdateList.isEmpty())
    {
       database.Update(AccupdateList);
    }
}