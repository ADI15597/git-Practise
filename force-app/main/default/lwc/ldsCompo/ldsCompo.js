import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import lead_object from '@salesforce/schema/Lead';
import email from '@salesforce/schema/Lead.Email';
import company from '@salesforce/schema/Lead.Company';
import fname from '@salesforce/schema/Lead.FirstName';
import lname from '@salesforce/schema/Lead.LastName';
import leadStatus from '@salesforce/schema/Lead.Status';

export default class LdsCompo extends LightningElement {

    objectApiName = lead_object;
    fields = [fname, lname, leadStatus,company,email];
    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "lead created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
    }

  
    
}