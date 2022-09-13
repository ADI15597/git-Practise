import { LightningElement,api } from 'lwc';
import searchAccount from '@salesforce/apex/DemoCompoClass.searchAccount';

const  columns = [    
    { label: 'Name', fieldName: 'Name' } ,
    { label: 'Type', fieldName: 'Type' } ,
    { label: 'SLA', fieldName: 'SLA__c' },
    { label: 'Rating', fieldName: 'Rating' }
];

export default class HeaderCompo extends LightningElement {

    @api accName 
    @api acclist
    @api error
    @api columns = columns;
    @api isShowModal
    
    handleSearchKeyword()
    {
        this.isShowModal = true ;
        console.log('inside js scontroller');
        this.accName = this.template.querySelector('lightning-input[data-formfield="searchValue"]').value;
        searchAccount({accountname : this.accName})
        .then((result)=>{
            this.acclist = result ;
            console.log(JSON.stringify(result));
        })
        .catch((error)=>{
            this.error = error ;
            console.log(JSON.stringify(error));
        });
       

    }
    hideModalBox()
    {
        this.isShowModal = false ;
    }
}