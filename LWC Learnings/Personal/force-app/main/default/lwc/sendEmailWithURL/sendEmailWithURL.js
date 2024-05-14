import { LightningElement, api } from 'lwc';
import sendEmail from '@salesforce/apex/EmailSender.sendEmail';
export default class SendEmailWithURL extends LightningElement {
    @api recipientEmail;
    @api subject;
    @api body;
    @api url;


    connectedCallback() {
        this.url =  window.location.origin;
        this.body ='You url is given below';
        this.subject = 'Registration URL';
        this.recipientEmail = 'dksharma8115@gmail.com';
    }

    handleSendEmail() {
        
        sendEmail({
            recipientEmail: this.recipientEmail,
            subject: this.subject,
            body: this.body,
            url: this.url
        })
            .then(result => {
                // Handle success
                console.log('Email sent successfully:', result);
            })
            .catch(error => {
                // Handle error
                console.error('Error sending email:', error);
            });
    }
}