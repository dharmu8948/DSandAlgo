import { LightningElement,wire } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { RefreshEvent } from 'lightning/refresh';
import { CurrentPageReference } from 'lightning/navigation';
export default class UrlNavigation extends NavigationMixin(LightningElement) {
    handleClick() {
     
        this[NavigationMixin.Navigate]({
            "type": "standard__webPage",
            "attributes": {
                "url": window.location.href
            }
        });
    }
    //  @wire(CurrentPageReference)
    // currentPageReference;

    connectedCallback() {      
        console.log('c__myParam =',window.location.href); 
    }
}