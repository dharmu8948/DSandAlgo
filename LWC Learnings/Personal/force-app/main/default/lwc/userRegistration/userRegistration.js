import { LightningElement, track, wire } from 'lwc';
import LightningConfirm from "lightning/confirm";
import sendOtpEmail from '@salesforce/apex/LMSController.sendOtpEmail';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import saveRegistration from '@salesforce/apex/LMSController.saveRegistration';
import getLMSCode from '@salesforce/apex/LMSController.getLMSCode';
import verifyOtp from '@salesforce/apex/LMSController.verifyOtp';
import BackgroundImg from '@salesforce/resourceUrl/bckImg';
import ZordialLogo from "@salesforce/resourceUrl/ZordialLOgo";
import { CurrentPageReference } from 'lightning/navigation';
import MeetingMessage from '@salesforce/label/c.MeetingMessage';
import createMeeting from '@salesforce/apex/LMSController.createMeeting';

export default class UserRegistration extends LightningElement {
    label = {
        MeetingMessage,
    }
    @track profile = ''; // To store the selected value
    @track interest = ''; // TO store Multiple selected value
    name = '';
    email = '';
    lmsClmsCodeode = '';
    meetingCode = '';
    eventCode='';
    linkedInUrl = '';
    otpCode = '';
    enteredOtp ='';
    currentURL='';
    urlParams;
    idWantToConnectWith;
    lastName;
    isRegistrationSuccess = false;
    finalSubmit = false;
    showLMCode = false;
    isOtpExpired = false;
    loadLMSPage = false;
    noRecordFound = false;
    @track isVerificationSuccessful = false;
    @track isVerificationFailed = false;
    @track isOtpExpired = false; // Track OTP expiration
    // boolean variable to get the track of respose loaded or not
    isLoaded = false;
    // boolean variable to show the OTP button
    isSendOtp=true;
    isShowOTPButton = false;
    isRegistered=false;
    contacts = [];
    imageUrl = BackgroundImg;
    LogoImage = ZordialLogo;



    get getBackgroundImage(){
        return `background-image:url("${this.imageUrl}"); position: absolute; width:100%; left:0`;
    }

    @track columns = [
        { label: 'Name', fieldName: 'LastName', type: 'text'},
        { label: 'Profile', fieldName: 'Profile__c', type: 'text' },
        { label: 'LinkedIn Id', fieldName: 'LinkedIn_ID__c', type: 'url' },
    ];

    // Define your picklist options
    options1 = [
        { label: 'Developer', value: 'Developer' },
        { label: 'Test Engineer', value: 'Test Engineer' },
        { label: 'Business Analyst', value: 'Business Analyst' },
        { label: 'Salesforce Technical Architect', value: 'Salesforce Technical Architect' },
        { label: 'Manager', value: 'Manager' },
    ];
    
    // Define your picklist options
    options = [
        { label: 'Developer', value: 'Developer' },
        { label: 'Test Engineer', value: 'Test Engineer' },
        { label: 'Business Analyst', value: 'Business Analyst' },
        { label: 'Salesforce Technical Architect', value: 'Salesforce Technical Architect' },
        { label: 'Manager', value: 'Manager' },
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
    }

    emailHandler(event){
        this.email = event.target.value;
        console.log('email  ', this.email);
    }
    // lms code handler
    LMSCodeHandler(event) {
        this.lmsCode = event.target.value;
        console.log('lmsCode  ', this.lmsCode);
    }

    linkedInHandler(event){
        this.linkedInUrl = event.target.value;
    }
    codeHandler(event) {
        this.enteredOtp = event.target.value;
        console.log('this.enteredOtp ', this.enteredOtp);
    }
   
    // handle OTP Button
    handleOtp(event) {
        if(this.email){
            console.log('otpHandle click: ',this.email);
            sendOtpEmail({email: this.email})
            .then(result => {
                if(result==true) {
                    this.isSendOtp=false;
                    this.isShowOTPButton = true;
                    console.log('OTP sent successfully.'+result);
                }else{
                    this.isSendOtp=true;
                    this.isShowOTPButton = false;
                    this.showErrorToast();
                }
                // Handle success or error
                
                // this.isShowOTPButton = true;
            })
            .catch(error => {
                // Handle error
                console.error('Error sending OTP: ' + error);
            });
        }else{
            this.showEmailToast();
        }
    }

    // toast messages
    enterValidVeri(){
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'Please enter Correct Verification Code!',
            variant: 'Error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    enterVeriToast(){
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'Please enter verification code!',
            variant: 'Error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    showEmailToast(){
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'Please enter email address!',
            variant: 'Error',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    showToast() {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Thanks for Registration, we have send further details on your email',
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
    showWorningToast() {
        const evt = new ShowToastEvent({
            title: 'Warning',
            message: 'Please Choose value in Every Fields',
            variant: 'warning',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    // toast when email is not verified
    showvalidateEmailError() {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'Please Verify your Email to proceed!',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    // toast message for invalid LM Code
    showInvalidLMCodeError() {
        const evt = new ShowToastEvent({
            title: 'Error',
            message: 'Please Enter Correct UserId',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    //saving the record

    handleClick() {
    console.log('handle click');
            saveRegistration({name: this.name,email:this.email, linkedInUrl:this.linkedInUrl, profile : this.profile,interest:this.interest})
        .then((result=>{
            console.log('result ', result);
            if(result == null) {
                this.showWorningToast();
            }else if(result.length === 0) {
                this.showWorningToast();
                this.isLoaded = false;
                console.log('result: ',result);
                this.contacts = result;
            }
            else {
                const obj = { key: result };
                localStorage.setItem('key', JSON.stringify(obj));
                this.showToast();
                this.contacts = result;
                console.log('Contacts  ',this.contacts);
                this.isLoaded = true;
               
            }
        }))
        // }
        // else {
        //     this.showvalidateEmailError();
        // }
    }

    // HandleClick of Button to validate the LMS Code
    lmsHandleClick() {
        
            getLMSCode({lmsCode: this.lmsCode})
            .then((result)=>{
                if(result && result.length != 0) {
                    this.contacts = result;
                    this.isLoaded = true;
                    this.loadLMSPage = false;
                    console.log('result ', result);
                }else {
                    //this.noRecordFound = true;
                    console.log('No Record Found');
                    this.showInvalidLMCodeError();
                }
            
            })       
    }

    // OTP Verification
    verifyOtp() {
        if(this.enteredOtp){
                    //    this.isVerificationSuccessful = true;
                    //     this.isVerificationFailed = false;
                    //     this.isOtpExpired = false;
                    //      this.isShowOTPButton = false;
                    //     this.isRegistered=true;
            // Call the Apex method to verify the OTP
            verifyOtp({ email: this.email, enteredOtp: this.enteredOtp,name: this.name,linkedInUrl:this.linkedInUrl, profile : this.profile,interest:this.interest })
                .then(result => {
                    console.log('result ', result);
                    if (result) {
                        this.isVerificationSuccessful = true;
                        this.isVerificationFailed = false;
                        this.isOtpExpired = false;
                         this.isShowOTPButton = false;
                        this.isRegistered=false;
                        if(result == null) {
                            this.showWorningToast();
                        }else if(result.length === 0) {
                            this.showWorningToast();
                            this.isLoaded = false;
                            console.log('result: ',result);
                            this.contacts = result;
                        }
                        else {
                            const obj = { key: result };
                            localStorage.setItem('key', JSON.stringify(obj));
                            this.showToast();
                            //this.contacts = result;
                            console.log('Contacts  ',this.contacts);
                            this.isRegistrationSuccess = true;
                            //this.isLoaded = true;
                           
                        }
                    } else {
                        this.isVerificationSuccessful = false;
                        this.isVerificationFailed = true;
                        this.isOtpExpired = false;
                        this.isShowOTPButton = true;
                        this.enterValidVeri();
                    }
                })
                .catch(error => {
                    if (error.body.message.includes('expired')) {
                        this.isOtpExpired = true;
                    } else if (error.body.message.includes('used')) {
                        // Handle the case where OTP has already been used
                        console.error('OTP has already been used: ' + error);
                    } else {
                        console.error('Error verifying OTP: ' + error);
                    }
                });
        }
        else{
            this.enterVeriToast();
        }
    }

    connectedCallback() {
        if(!this.lmsCode) {
            console.log('Inside handle Click ');
            this.handleConfirmClick();
        }
        console.log('Hay connectedCallback getting called first');
       
    }
    // handling URL parameters
   //lmsCodeUrl;
    @wire(CurrentPageReference)
    currentPageReferenceHandler(pageRef) {
        if (pageRef) {
            console.log('Hay currentPageReferenceHandler getting called first');
            // Get the URL parameters from the page reference
            this.urlParams = pageRef.state;
            console.log('urlParams: ',this.urlParams);
            // Access specific parameters
            this.lmsCode = this.urlParams.userId;
            this.eventCode = this.urlParams.event;
            console.log('param1:', this.lmsCode);
            getLMSCode({lmsCode: this.lmsCode})
                .then((result)=>{
                if(result && result.length != 0) {
                    this.contacts = result;
                    this.isLoaded = true;
                    this.loadLMSPage = false;
                    console.log('result ', result);
                }
                else {
                    //this.noRecordFound = true;
                    console.log('No Record Found');
                   // this.handleConfirmClick();
                }
           
            })
        }
    }
    async handleConfirmClick() {
        const result = await LightningConfirm.open({
            message: "",
            variant: "default", // headerless
            label: "Click OK If you are an existing user ?"
        });

        //Confirm has been closed

        //result is true if OK was clicked
        if (result) {
            this.handleSuccessAlertClick();
        } else {
            //and false if cancel was clicked
            this.handleErrorAlertClick();
        }
    }
    handleSuccessAlertClick() {
        this.loadLMSPage = true;
    }
    handleErrorAlertClick() {
        //this.loadLMSPage = false;
    }
    handleConnectClick() {
        this.showLMCode = true;
    }
  
    onRowSelectionHandle(event) {
        this.idWantToConnectWith = event.detail.selectedRows[0].Id;
        this.lastName = event.detail.selectedRows[0].LastName;
       console.log('Selected Row: ', this.idWantToConnectWith);
       console.log('lastName: ', this.lastName);
    }

    meetingChangeHandler(event) {
        this.meetingCode = event.target.value;
        console.log('mettingchange: ',this.meetingCode);
    }
    letsConnectClick() {
        if(this.idWantToConnectWith){
            createMeeting({userId: this.lmsCode,eventCode: this.eventCode, meetingCode:this.meetingCode})
            .then((result)=>{
                if(result) {
                    console.log('result ', result);
                    this.finalSubmit = true;
                }
                else {
                    console.log('Record not saved');
                }
        });
        }else {
            alert('Select at least one person');
        }
    }
}