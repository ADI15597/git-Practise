public with sharing class contactsData {
    public contactsData() {

    }
    @AuraEnabled(cacheable = true)
    public static list<contact> getContacts(id accId){

        return ([select id,firstName,lastName,AccountId,Email,Account.Name from contact where AccountId =:accId ]);
        
    }
}