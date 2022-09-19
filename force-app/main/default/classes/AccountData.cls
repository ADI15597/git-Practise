public with sharing class AccountData {
    public AccountData() {

    }
    @AuraEnabled
    public static account getAccount(string accName){
       
        Account objectAcc = [select id,Name,type,rating,SLA__c from account where Name =:accName and name != 'black rock'];
        return objectAcc ;
    }
    
   
         @AuraEnabled(cacheable=true)
        public static list<Account> getAccountToday(){
           
            list<account> acclist = [select id,name,Rating,CreatedDate from Account where CreatedDate = Today];
            system.debug('####'+acclist);
            return acclist ;
           
        }

        @AuraEnabled(cacheable=true)
        public static list<Account> getAccountByType(string Acctype ){
           
            list<account> acclist = [select id,name,Rating,CreatedDate,type from Account where type=:Acctype];
            system.debug('####'+acclist);
            return acclist ;
           
        }

        @AuraEnabled(cacheable=true)
        public static list<Account> getAccContacts(string AccName){

            system.debug('###'+AccName);
                return([select id,Name,rating,(select id,Name,email from contacts) from account where Name =:AccName]);
                
          
        }

        @AuraEnabled(cacheable=true)
        public static list<account> GetAccBywords(string USerInput ){
            
             return([select id,name,rating from account where Name like:USerInput]);

        }
        @AuraEnabled
        public static contact findAcc(id conId){
          
            string test = 'added for git practise';
            contact objCon = [select id,Account.Name,Account.Rating from contact where id=:conid];
            return objCon;
            
        }
        public static void gitMethod()
        {
            string pullReq ="just for practise";
            string newPull;
        }


        public static void gitPractise()
        {
            string p = 'practise variable';
        }

}