import { LightningElement,track, wire } from 'lwc';
import getCategoryList from '@salesforce/apex/SingerAppCOntroller.getCategoryList';
import getAlbums from '@salesforce/apex/SingerAppCOntroller.getAlbums';
import getAllAlbums from '@salesforce/apex/SingerAppCOntroller.getAllAlbums';

export default class ShowCategories extends LightningElement {
    @track genrecats;
    @track albums;
    @track albumDetailsOnLoad;
    @track albumDet=[];
    @track isExists = false;

    @track categories = [];

    @wire(getCategoryList)
    wiredCategory({ error, data }) {
        if (data) {
            this.genrecats = data;
            console.log('genre:: ',this.genrecats);
            for(var index = 0;index<this.genrecats.length;index++) {
                this.categories.push({'id':this.genrecats[index].Id,'name':this.genrecats[index].Name});
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.genrecats = undefined;
        }
    }

    // get all category list
    @wire(getAllAlbums)
    wiredAllAlbum({ error, data }) {
        if (data) {
            this.albumDetailsOnLoad = data;
            for(var i = 0;i<this.albumDetailsOnLoad.length;i++) {
                this.albumDet.push({'Id':this.albumDetailsOnLoad[i].Id,'Name':this.albumDetailsOnLoad[i].Name,'SingerId':this.albumDetailsOnLoad[i].Singer__c, 'Image':this.albumDetailsOnLoad[i].Album_Image__c,'PublishedDate':this.albumDetailsOnLoad[i].Date_Published__c,'Price':this.albumDetailsOnLoad[i].Price__c});
            }
            console.log('album details:: ',this.albumDet);
            if(this.albumDet.length>0) {
                this.isExists = true;
            }else {
                this.isExists = false;
            }
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.albumDetailsOnLoad = undefined;
        }
    }

    handleCategoryClick(event) {
        this.albumDet = [];
        const categoryId = event.currentTarget.dataset.id;
        console.log('cat:::',categoryId);
        getAlbums({ genreId: categoryId})
            .then(result => {
                this.albums = result;
                this.error = undefined;
                console.log('abum  ', this.albums.length);
                for(var i = 0;i<this.albums.length;i++) {
                    this.albumDet.push({'Id':this.albums[i].Id,'Name':this.albums[i].Name,'SingerId':this.albums[i].Singer__c, 'Image':this.albums[i].Album_Image__c,'PublishedDate':this.albums[i].Date_Published__c,'Price':this.albums[i].Price__c});
                }
                if(this.albumDet.length>0) {
                    this.isExists = true;
                }else {
                    this.isExists = false;
                }
                console.log('albumDet:: ',this.albumDet);
            })
            .catch(error => {
                this.error = error;
                this.saveData = undefined;
            });
        // Perform actions based on the category ID, such as navigating to a different page or loading related content.
        // Example:
        // console.log('Category clicked:', categoryId);
    }
}