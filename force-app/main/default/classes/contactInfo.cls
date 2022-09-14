public with sharing class contactInfo {
    public contactInfo() {

    }
    @AuraEnabled(cacheable=true)
    public static List<contact> getContactList( id accId)
    {
        list<contact> conlist = [select Id,Name,AccountId,Email from contact where AccountId =: accId];
        
        return conlist;
    }
    @AuraEnabled(cacheable=true)
    public static List<contact> getContactToday( )
    {
        list<contact> conlist = [select Id,Name,Email,CreatedDate from contact where CreatedDate = LAST_N_DAYS:365 ];
        
        return conlist;
    }
    @AuraEnabled(cacheable=true)
    public static List<contact> getContactAcc (id conId)
    {
        list<contact> conlist = [select Id,Name,Email,CreatedDate,Account.Name from contact where id =: conId ];
        
        return conlist;
    }
    public static void gitPractisemethod()
    {
        string test = 'added for git practise';
    }

}