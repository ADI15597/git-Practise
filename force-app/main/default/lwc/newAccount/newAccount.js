import { LightningElement ,track} from 'lwc';
import createNewAccount from '@salesforce/apex/AccountOprations.createNewAccount';

export default class NewAccount extends LightningElement {

  @track objectAccount = {'sobjectType':'Account'} 

  CreateAccounHandler()
  {
      
      console.log('inside the js controller');
      this.objectAccount.Name = this.template.querySelector('lightning-input[data-formfield="accountname"]').value;
      console.log(this.objectAccount.Name);
      createNewAccount({objAccount : this.objectAccount})
      .then((result)=>{
          this.result = result;
      })
      .catch((error)=>{
         this.error = error;
      });
  }
}