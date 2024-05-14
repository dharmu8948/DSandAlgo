import { LightningElement, track, wire } from 'lwc';
	
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveRegistration from '@salesforce/apex/LMSController.saveRegistration';
//import getDeveloperContactList from '@salesforce/apex/LMSController.getDeveloperContactList';

export default class UserRegistration extends LightningElement {
    @track profile = ''; // To store the selected value
    @track interest = '';// TO store Multiple selected value
    name = '';
    email = '';
    linkedInUrl = '';

    // Define your picklist options
    options1 = [
        { label: 'Developer', value: 'Developer' },
        { label: 'QA Engineer', value: 'QA Engineer' },
        { label: 'Business Analyst', value: 'Business Analyst' },
        { label: 'Salesforce Technical Architect', value: 'Salesforce Technical Architect'},
        { label: 'Manager', value: 'Manager'}
    ];
    
    // Define your picklist options
    options = [
        { label: 'Developer', value: 'Developer' },
        { label: 'QA Engineer', value: 'QA Engineer' },
        { label: 'Business Analyst', value: 'Business Analyst' },
        { label: 'Salesforce Technical Architect', value: 'Salesforce Technical Architect'},
        { label: 'Manager', value: 'Manager'}
   ];
    // Handle the picklist value change
    handleSelectChange1(event) {
        this.profile = event.detail.value;
        console.log('selected Interest ',this.profile);
        // You can perform any action you want based on the selected value here.
    }


    // Handle the multi-select picklist value change
    handleSelectChange(event) {
        this.interest = event.detail.value;
        console.log('selected Interest ',this.interest);
        // You can perform any action you want based on the selected values here.
    }
    // Handler for name
    nameHandler(event) {
        this.name = event.target.value;
        console.log('name', this.name);
    }

    emailHandler(event){
        this.email = event.target.value;
        console.log('name', this.email);
    }

    linkedInHandler(event){
        this.linkedInUrl = event.target.value;
        console.log('name', this.linkedInUrl);
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Registration Successfull',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    showErrorToast() {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'Email Id Already Exists!',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    //saving the record

    handleClick() {
        saveRegistration({name: this.name,email:this.email, linkedInUrl:this.linkedInUrl, profile : this.profile,interest:JSON.stringify(this.interest)})
        .then((result=>{
            console.log('result ', result);
            if(result.length == 0) {
               this.showErrorToast();
            }else {
                const obj = { key: result };
                localStorage.setItem('key', JSON.stringify(obj));
                console.log('local storage data',localStorage.getItem('key'));
                this.showToast();
               // window.open(url, '_self');
            }
        })) 
    }

    contacts = [];
    @track columns = [
        { label: 'First Name', fieldName: 'FirstName', type: 'text'},
        { label: 'Last Name', fieldName: 'LastName', type: 'text' },
        { label: 'Profile', fieldName: 'Profile__c', type: 'text' },
        { label: 'LinkedIn Id', fieldName: 'LinkedIn_Id__c', type: 'text' },
        
    ];

    @track contacts;
    //@wire(getDeveloperContactList)
    // wiredContacts({ error, data }) {
    //     if (data) {
    //         this.contacts = data;
    //     } else if (error) {
    //         console.error(error);
    //     }
    //     }
    
}