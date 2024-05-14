import { LightningElement, track, wire } from 'lwc';
import getAccount from '@salesforce/apex/AccountHandler.getAccount';

export default class SearchAccount extends LightningElement {
    @track accountName;
    opps;
    handleClick() {
        this.accountName = this.template.querySelector('lightning-input').value;
        this.opps = this.getAccountRec;
        console.log("this.accountName:  ",this.opps);
    }
    @wire(getAccount,{accountName:'$accountName'})
    getAccountRec({data, error}) {
        if(data) {
            console.log("data.Name:   ",data[0].Name);
        }
        if(error) {
            console.log(error);
        }
    }
}