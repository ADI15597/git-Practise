import { LightningElement,api ,wire} from 'lwc';
import getContacts from "@salesforce/apex/contactsData.getContacts";


const  columns = [
{ label: 'id', fieldName: 'Id', editable: true },
{ label: 'First Name', fieldName: 'FirstName', editable: true },
{ label: 'Last Name', fieldName: 'LastName', editable: true },
{ label: 'Email', fieldName: 'Email', editable: true },
{ label: 'Account Name', fieldName: 'AccName', editable: true }


];


export default class ContactComponent extends LightningElement {


@api recordId;
@api conlist;
@api error;
@api columns = columns;

 @wire(getContacts, {accId:'$recordId'})
wiredContacts({data, error}){
    if(data){
        let tempRecords = JSON.parse( JSON.stringify( data ) );
        tempRecords = tempRecords.map( row => {
        return {...row, AccName: row.Account.Name };
        })
        this.conlist = tempRecords;
        this.error = undefined;
        }
else if (error) {
this.error = error;
console.log('message = '+this.error);
}

}
}