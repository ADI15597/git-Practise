import { LightningElement,api,wire } from 'lwc';
import getOpportunity from '@salesforce/apex/opportunityProvider.getOpportunity'

const  columns = [
{ label: 'id', fieldName: 'id', editable: true },
{ label: 'Opportunity Name', fieldName: 'Name', editable: true },
{ label: 'Stage', fieldName: 'StageName', editable: true }
];


export default class OpportunityCompo extends LightningElement {

    @api columns = columns;
    @api oppList ;
    @api error;

    @wire(getOpportunity)
    wiredContacts({data, error}){
    if(data){
    this.oppList = data;
    this.error = undefined;
    console.log('oppList'+this.contactList);
    }
    else if (error) {
    this.error = error;
    console.log('message = '+this.error);
    }
    

}
}