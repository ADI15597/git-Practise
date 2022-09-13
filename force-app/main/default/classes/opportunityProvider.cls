public with sharing class opportunityProvider {
    public opportunityProvider() {

    }

    @AuraEnabled(cacheable = true)
    public static list<opportunity> getOpportunity(){
       
        return ([select id,Name,StageName from opportunity where StageName ='Closed Won' ]);
    }
}