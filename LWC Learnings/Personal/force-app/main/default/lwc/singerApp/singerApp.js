import { LightningElement, api, track, wire } from 'lwc';
import getCategoryList from '@salesforce/apex/SingerAppCOntroller.getCategoryList';
import getAlbumCategories from '@salesforce/apex/SingerAppCOntroller.getAlbumCategories';
import saveAlbum from '@salesforce/apex/SingerAppCOntroller.saveAlbum';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SingerApp extends LightningElement {
    @track isShowModal = false;
    @track categories;
    @track options = [];
    @track catOption = [];
    @track imageVal;


    // get acceptedFormats() {
    //     return ['.jpeg', '.png','.jpg','.jfif'];
    // }

    handleUploadFinished(event) {
        // Get the list of uploaded files
        const uploadedFiles = event.detail.files;
        console.log('No. of files uploaded : ' + JSON.stringify(uploadedFiles));
    }

    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }
    _selected = [];

    get options() {
        console.log('result:: ',this.options);

        return this.options;
    }

    get selected() {
        console.log('selected:: ', this._selected);
        return this._selected.length ? this._selected : 'none';
    }
    albumName;
    datePublish;
    price;
    genreName;
    singerName;
    handleChange(event) {
      
        if(event.target.name === 'albumName') {
            this.albumName = event.target.value;
        }
        if(event.target.name === 'datePublish') {
            this.datePublish = event.target.value;
        }
        if(event.target.name === 'price') {
            this.price = event.target.value;
        }
        if(event.target.name === 'image') {
            this.imageVal = event.target.value
        }
        console.log('al:',this.albumName,' date:: ', this.datePublish,'  price::',this.price,'  this.imageVal:: ', this.imageVal);
    }
   
    handleGenre(event) {
      this.genreName = event.detail.recordId;
      console.log('this.genreName:: ',this.genreName);
    }
    handleSinger(event) {
        this.singerName = event.detail.recordId;
        console.log('this.genreName:: ',this.singerName);
    }

    handleChangeSelect(e) {
        this._selected = e.detail.value;
        console.log('selected on change:: ', this._selected);
    }
    saveData;
    handleClickSave() {
        console.log('Data Saved');
        this.isShowModal = false;
        saveAlbum({ albumName: this.albumName,genreId: this.genreName,singerId:this.singerName,publishDate:this.datePublish,price: this.price,selectedItems:this._selected, image:this.imageVal })
            .then(result => {
                this.saveData = result;
                this.error = undefined;
                console.log('saveData:: ',this.saveData);
                this.showToast();
            })
            .catch(error => {
                this.error = error;
                this.saveData = undefined;
            });
    }


    //imperative call
    // handleClickSave() {

    // }
    // wire methods
    @wire(getCategoryList)
    wiredCategory({ error, data }) {
        if (data) {
            this.categories = data;
            console.log('categories:: ',this.categories);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.categories = undefined;
        }
    }

    @wire(getAlbumCategories)
    wiredCategory({ error, data }) {
        if (data) {
            this.catOption = data;
            for(var i=0;i<this.catOption.length;i++) {
                this.options.push({'label':this.catOption[i],'value':this.catOption[i]});
            }
            console.log('options:: ',this.options);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.catOption = undefined;
        }
    }

    // TOAST Messages
    showToast() {
        const event = new ShowToastEvent({
            title: 'Album Record Created',
            message: 'Album Record Created',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}