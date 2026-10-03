// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct FlightCheckInPage {
  @State name: string = '';
  @State bookingCode: string = '';
  @State selectedSeatClass: number = 0; // 0: Economy, 1: Premium, 2: Business
  @State showSuccessDialog: boolean = false;

  build() {
    Column() {
      // Header
      Row() {
        Circle({ width: '22vp', height: '22vp' })
          .backgroundColor('#1E3A8A')
        
        Text('Flight Check-in')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        
        Circle({ width: '22vp', height: '22vp' })
          .backgroundColor('#2563EB')
      }
      .width('100%')
      .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      
      // Main content with gradient background
      Column() {
        // Passenger info card
        Column() {
          Column() {
            Text('Passenger')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .margin({ bottom: 10 })
            
            TextInput({ placeholder: 'Full name' })
              .placeholderColor('#0B122099')
              .backgroundColor('#E8EEFA')
              .borderRadius(12)
              .height(48)
              .onChange((value: string) => {
                this.name = value;
              })
              .margin({ bottom: 14 })
            
            Text('Booking Code')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .margin({ bottom: 10 })
            
            TextInput({ placeholder: 'e.g. XY7ZK2' })
              .placeholderColor('#0B122099')
              .backgroundColor('#E8EEFA')
              .borderRadius(12)
              .height(48)
              .onChange((value: string) => {
                this.bookingCode = value;
              })
              .margin({ bottom: 14 })
            
            Text('Seat Class')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .margin({ bottom: 10 })
            
            // Seat class selection
            Row() {
              Button('Economy')
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedSeatClass === 0 ? '#1E3A8A' : '#E8EEFA')
                .fontColor(this.selectedSeatClass === 0 ? '#FFFFFF' : '#0B1220')
                .borderRadius(this.selectedSeatClass === 0 ? [12, 0, 0, 12] as BorderRadiuses : [0, 0, 0, 0] as BorderRadiuses)
                .onClick(() => {
                  this.selectedSeatClass = 0;
                })
                .layoutWeight(1)
                .margin({ right: 1 })
              
              Button('Premium')
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedSeatClass === 1 ? '#1E3A8A' : '#E8EEFA')
                .fontColor(this.selectedSeatClass === 1 ? '#FFFFFF' : '#0B1220')
                .borderRadius([0, 0, 0, 0] as BorderRadiuses)
                .onClick(() => {
                  this.selectedSeatClass = 1;
                })
                .layoutWeight(1)
                .margin({ left: 1, right: 1 })
              
              Button('Business')
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedSeatClass === 2 ? '#1E3A8A' : '#E8EEFA')
                .fontColor(this.selectedSeatClass === 2 ? '#FFFFFF' : '#0B1220')
                .borderRadius([0, 12, 12, 0] as BorderRadiuses)
                .onClick(() => {
                  this.selectedSeatClass = 2;
                })
                .layoutWeight(1)
                .margin({ left: 1 })
            }
            .width('100%')
            .height(40)
          }
          .padding(18)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(18)
        .shadow({ radius: 8, color: '#00000029', offsetY: 4 })
        .margin({ bottom: 18 })
        
        // Flight details card
        Column() {
          Column() {
            Row() {
              Column() {
                Text('Flight')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                
                Text('BL 213 • HND → CTS')
                  .fontSize(14)
                  .fontColor('#0B1220')
                  .margin({ top: 6 })
              }
              .layoutWeight(1)
              
              Circle({ width: '36vp', height: '36vp' })
                .backgroundColor('#2563EB')
            }
            .width('100%')
            .margin({ bottom: 14 })
            
            Row() {
              Column() {
                Text('Boarding')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E3A8A')
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              
              Column() {
                Text('Gate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E3A8A')
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
              
              Column() {
                Text('Seat')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                
                Text(this.getSeatNumber())
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1E3A8A')
                  .margin({ top: 2 })
              }
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ bottom: 14 })
            
            Button('Confirm Check-in')
              .type(ButtonType.Normal)
              .backgroundColor('#1E3A8A')
              .fontColor('#FFFFFF')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .borderRadius(18)
              .height(52)
              .onClick(() => {
                this.showSuccessDialog = true;
              })
          }
          .padding(18)
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius(18)
        .shadow({ radius: 8, color: '#00000029', offsetY: 4 })
      }
      .width('100%')
      .padding({ left: 18, right: 18, top: 14, bottom: 14 })
      .linearGradient({
        angle: 180,
        colors: [['#60A5FA40', 0], ['#F5F8FF', 0.5], ['#2563EB33', 1]]
      })
      
      // Success dialog using custom component logic within the tree or separate if supported by version
      // Since Dialog is not a standard declarative UI component in older versions, we use a conditional overlay
      if (this.showSuccessDialog) {
        Stack() {
          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0B1220')
              .margin({ bottom: 10 })
            
            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor('#0B1220')
              .margin({ bottom: 14 })
            
            Button('Done')
              .type(ButtonType.Normal)
              .backgroundColor('#2563EB')
              .fontColor('#FFFFFF')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .borderRadius(12)
              .height(40)
              .onClick(() => {
                this.showSuccessDialog = false;
              })
          }
          .padding(18)
          .width(300)
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
        }
        .position({ x: '50%', y: '50%' })
        .translate({ x: '-50%', y: '-50%' })
        .zIndex(100)
      }
    }
    .width('100%')
    .height('100%')
  }
  
  getSeatNumber(): string {
    switch (this.selectedSeatClass) {
      case 0: return '23C';
      case 1: return '11A';
      case 2: return '2F';
      default: return '23C';
    }
  }
}