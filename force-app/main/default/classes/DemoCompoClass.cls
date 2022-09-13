public with sharing class DemoCompoClass {
    
    
    @AuraEnabled
    public static list<account> searchAccount(string accountname){
        try {
            return ([select id,Name,type,SLA__c,Rating from Account where Name like:accountname WITH SECURITY_ENFORCED]);
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}