import { LightningElement,api,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import uploadFile from '@salesforce/apex/FileUploaderClass.uploadFile';
import getSearchProduct from '@salesforce/apex/FileUploaderClass.getSearchProduct';
import getAllFiles from '@salesforce/apex/FileUploaderClass.getAllFiles';
import getPaginatedRecords from '@salesforce/apex/FileUploaderClass.getPaginatedRecords';

const PAGE_SIZE = 3;
export default class FileUploadLWC extends LightningElement {

    // Variables
    @api recordId;
    fileData;
    offset;
    inputValue;
    currentProd;
    allProducts;
    offset = 0;
    records = [];
    hasMoreData = true;

     // connectedcallbacks
      connectedCallback() {
        this.getAllProducts();
      }
    

    @wire(getPaginatedRecords, { startIndex: '$offset', recordLimit: PAGE_SIZE })
    wiredRecords({ data, error }) {
        if (data) {
            this.records = [...this.records, ...data];
            // for(var i=0;i<this.records.length;i++) {
            //     this.allProducts.push(this.records);
            // }
            console.log('these are data',JSON.stringify(this.records));
            if (data.length < PAGE_SIZE) {
                console.log('exceeded  the size');
                this.hasMoreData = false;
            }
        } else if (error) {
            console.error('Error fetching records: ' + error);
        }
    }
      getAllProducts() {
        getAllFiles({})
        .then((result)=>{
            if(result) {
                this.allProducts = result;
                console.log("all Prods:: ",this.allProducts);
                for(var i = 0;i<this.allProducts.length;i++) {
                    this.allProducts[i].thumbnailFileCard ="/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=" +
                                                            this.allProducts[i].Id +
                                                            "&operationContext=CHATTER&contentId=" +
                                                            this.allProducts[i].ContentDocumentId
                }
                console.log('allProducts:: ',this.allProducts);
            }else {
                alert('You do so many files in System');
            }
           
        })
      }
    // uploading the file with-in accepted format
    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'recordId': this.recordId
            }
            console.log('this.fileData:: ',this.fileData.filename,' recordId:: ',this.fileData.recordId);
        }
        reader.readAsDataURL(file)
    }
    // upload the file after clicking on Add Product
    handleClick(){
        const {base64, filename, recordId} = this.fileData
        uploadFile({ base64, filename, recordId }).then(result=>{
            this.currentProd = result;
            this.currentProd.thumbnailFileCard = "/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=" +
                                                    this.currentProd.Id +
                                                    "&operationContext=CHATTER&contentId=" +
                                                    this.currentProd.ContentDocumentId;
            this.allProducts.push(this.currentProd);
           // this.allProducts = [...this.allProducts];
            console.log('uploaded success: ',this.currentProd);
            console.log("all prodddd: ",this.allProducts);
            this.fileData = null
            let title = `${filename} uploaded successfully!!`
            this.toast(title,"success");
        })
    }
    renderedCallback() {

    }
   // common toast message for every event based on parameter the message will shown
    toast(title, type){
        const toastEvent = new ShowToastEvent({
            title, 
            variant:type
        })
        this.dispatchEvent(toastEvent)
    }
   // handle change to search the product
    handleChange(event) {
      this.inputValue = event.target.value;
      console.log('Input Value:: ',this.inputValue);
      if(this.inputValue=='' || this.inputValue == null) {
        this.getAllProducts();
      }
    }
    // button to search the entered Product
    handleSearchClick() {
     if(this.inputValue) {
        getSearchProduct({productName:this.inputValue})
        .then((result)=>{
            if(result && result.length>0) {
                this.allProducts = result;
                for(var i=0;i<this.allProducts.length;i++) {
                    this.allProducts[i].thumbnailFileCard = "/sfc/servlet.shepherd/version/renditionDownload?rendition=THUMB720BY480&versionId=" +
                                                            this.allProducts[i].Id +
                                                            "&operationContext=CHATTER&contentId=" +
                                                            this.allProducts[i].ContentDocumentId;
                }
               console.log('file found::'+JSON.stringify(this.allProducts));
               this.toast(this.inputValue+' found', 'success')
            }else {
                this.allProducts = '';
                this.toast('Record Not found','warning');
            }
            
        })
    }
     console.log('Search the Product::: '+ this.inputValue);
    }

    // handle click to load more
    loadMoreHandleClick() {
        this.offset += PAGE_SIZE;
        if(this.hasMoreData== false) {
            this.toast('You do not have more record, Please add to see','warning')
        }
        //alert('You do not have so many files in System');
        console.log('load more clicked');
    }
}