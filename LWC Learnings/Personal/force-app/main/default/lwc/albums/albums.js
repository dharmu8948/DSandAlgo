import { LightningElement, api, wire } from 'lwc';
import getSingerDetails from '@salesforce/apex/SingerAppCOntroller.getSingerDetails';

export default class Albums extends LightningElement {

    @api albumsDetails;
    isExists = false;
    singer = '';
    singerDetail;
    // connectedCallback(){
    //     console.table(albumsDetails);
    // }
    handleCategoryClick(event) {
        this.singer = event.target.value;
        if(this.singer != '' || this.singer != undefined) {
            this.isExists = true;
        }else {
            this.isExists = false;
        }
        // making imperative apex call
        getSingerDetails({ singerId: this.singer})
        .then(result => {
            this.singerDetail = result;
            this.error = undefined;
            console.log('saveData:: ',this.singerDetail);
            console.log('isExists:: ', this.isExists);
        })
        .catch(error => {
            this.error = error;
            this.singerDetail = undefined;
        });

        console.log('selected image Id-- ',this.singer);
    }   
}