import { LightningElement ,track} from 'lwc';
import obj_con from '@salesforce/schema/Contact';

export default class CreateNewContact extends LightningElement {

    @track ContactApi = obj_con;
}