import { LightningElement, wire, track, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAssetAndProduct from '@salesforce/apex/AssetProductControllerLWC.getAssetAndProduct';
import linkOppToAssets from '@salesforce/apex/AssetProductControllerLWC.linkOppToAssets';
import { CloseActionScreenEvent } from 'lightning/actions';


export default class AssetSelectionComponentForOpp extends LightningElement {

  // @track oppId;
  @track availableAssets;
  // @track productNames;
  @track selectedAssets;
  // @track totalData;
  @api recordId;

  columns = [
    { label: 'Serial Number', fieldName: 'serialNumber' },
    { label: 'Vehicle Inner Color', fieldName: 'interiorColor' },
    { label: 'Vehicle Color', fieldName: 'exteriorColor' },
    { label: 'Product', fieldName: 'productName' }
  ];

  /*
  @wire(getRecord, { recordId: '$recordId', fields: ['Opportunity.Id'] })
  wiredOpportunity({ error, data }) {
    if (data) {
      this.oppId = this.wiredOpportunity.data.fields.Id.value;
    } else if (error) {
      this.showToast('Error', error.body.message, 'error');
    }
  }
  */

  @wire(getAssetAndProduct)
  wiredAvailableAssets({ error, data }) {
    if (data) {
      // console.log('HERE IS DATAA !!!! ' + JSON.stringify(data));
      this.availableAssets = data;
    } else if (error) {
      this.showToast('Error', error.body.message, 'error');
    }
  }

  /*
  @wire(getProductName)
  wiredGetProductNames({ error, data }) {
    if (data) {
      this.productNames = data;
    } else if (error) {
      this.showToast('Error', error.body.message, 'error');
    }
  }
  */

  // totalData = availableAssets + productNames;

  linkAssets() {
    this.selectedAssets = this.template.querySelector('lightning-datatable').getSelectedRows();
    this.dispatchEvent(new CloseActionScreenEvent());
    // console.log('HERE IS AVAILABLE ASSETSSS !!!!!!!!' + JSON.stringify(this.availableAssets));
    linkOppToAssets({ oppId: this.recordId, assPrdList: this.selectedAssets })
      .then((response) => {
        if (response === 0) {

          this.dispatchEvent(new ShowToastEvent({
            title: 'Error!',
            message: 'Could not link the selected Asset/s',
            variant: 'error'

          }))

        } else if (response === 1) {

          this.dispatchEvent(new ShowToastEvent({
            title: 'Success!',
            message: 'You have successfully linked the selected Asset/s',
            variant: 'success'

          }))

        } else {

        }
      })
      .catch((error) => {
        this.showToast('Error', error.body.message, 'error');
      });
  }
}