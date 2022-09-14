public with sharing class AccountOprations {
   
    @AuraEnabled
    public static string createNewAccount(Account objAccount){
        try 
        {
            if(objAccount != null)
            {
                insert objAccount;
               
            }
            return 'Account Created Sucessfully';
            
        }
        catch (Exception e) 
        {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static void gitPractiseMethod()
    {
        string test = 'declared for git practise and creating conflict';
    }

}