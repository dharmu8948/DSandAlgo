import { LightningElement,track } from 'lwc';
import getWeatherDetails from '@salesforce/apex/WeatherDetailClass.getWeatherDetail';

export default class WeatherScreen extends LightningElement {
   cityName='';
   showDetails = false;
   @track weatherDetails;

   // on change of input value
    handleChange(event) {
        this.cityName = event.detail.value;
        console.log(this.cityName);
    }

    // on click of button to get the data
    handleClick() {
        getWeatherDetails({cityName:this.cityName})
        .then((result) => {
            this.weatherDetails = result;
            console.log('weather details: ',this.weatherDetails);
            this.showDetails = true;
        })
        .catch((error)=> {
            this.showDetails = false;
            console.log('some error occured while fetching the results');
        });

        console.log('result '+JSON.stringify(this.weatherDetails));
    }
}