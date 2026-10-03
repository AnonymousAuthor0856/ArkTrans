// EntryComponent.ets
import { StyleConstants, CommonConstants } from '@ohos/arkui';

@Entry
@Component
struct ThermostatPage {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Column() {
      // --- Top Bar ---
      Row() {
        Image($r('sys.media.ohos_ic_public_drawer'))
          .width(24).height(24).fillColor('#9E9E9E')
          .onClick(() => {})
        
        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontColor('#9E9E9E')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          
          if (this.isPowerOn) {
            Text('Active')
              .fontSize(10)
              .fontColor('#4CAF50')
              .margin({ top: 2 })
          } else {
            Text('Off')
              .fontSize(10)
              .fontColor('#BDBDBD')
              .margin({ top: 2 })
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24).height(24).fillColor('#9E9E9E')
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)

      // --- Main Content ---
      Column() {
        // --- Main Temperature Control ---
        Stack() {
          // Decorative Circle
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? '#000000' : '#BDBDBD')
            
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor('#9E9E9E')
              .margin({ top: 8 })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            // Increase Button
            Column() {
              Image($r('sys.media.ohos_ic_public_add'))
                .width(24).height(24).fillColor('#000000')
                .onClick(() => { this.targetTemp++; })
            }
            .width(48).height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .position({ x: '82%', y: '42%' }) // Roughly CenterEnd

            // Decrease Button
            Column() {
              Image($r('sys.media.ohos_ic_public_arrow_down'))
                .width(24).height(24).fillColor('#000000')
                .onClick(() => { this.targetTemp--; })
            }
            .width(48).height(48)
            .backgroundColor('#F5F5F5')
            .borderRadius(24)
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .position({ x: '2%', y: '42%' }) // Roughly CenterStart
          }
        }
        .width(280)
        .height(280)
        .borderRadius(140)
        .border({ width: 1, color: '#EEEEEE' })
        .backgroundColor('#FFFFFF')
        .margin({ top: 10, bottom: 20 })

        // --- Mode Selection ---
        Text('MODE')
          .fontSize(10)
          .fontColor('#9E9E9E')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        Row({ space: 12 }) {
          this.ModeButton('sys.media.ohos_ic_public_home', 'Auto')
          this.ModeButton('sys.media.ohos_ic_public_refresh', 'Fan')
          this.ModeButton('sys.media.ohos_ic_public_star', 'Cool')
        }

        // --- Info Cards ---
        Row({ space: 16 }) {
          this.InfoCard('Humidity', '45%', 'sys.media.ohos_ic_public_info')
          this.InfoCard('Energy', '12 kWh', 'sys.media.ohos_ic_public_arrow_up')
        }
        .width('100%')
        .margin({ top: 24 })

        // --- Power Switch ---
        Row() {
          Column() {
            Text('Master Power')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12)
              .fontColor('#9E9E9E')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .selectedColor('#000000')
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn;
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24, bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // Helper Component for Mode Buttons
  @Builder ModeButton(iconResource: Resource, label: string) {
    Column() {
      Column() {
        Image($r(iconResource))
          .width(24).height(24)
          .fillColor(this.selectedMode === label && this.isPowerOn ? '#FFFFFF' : (this.isPowerOn ? '#000000' : '#BDBDBD'))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.selectedMode === label && this.isPowerOn ? '#000000' : '#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .onClick(() => {
        if (this.isPowerOn) this.selectedMode = label;
      })

      Text(label)
        .fontSize(10)
        .fontColor(this.isPowerOn ? '#9E9E9E' : '#BDBDBD')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  // Helper Component for Info Cards
  @Builder InfoCard(title: string, value: string, iconResource: Resource) {
    Column() {
      Image($r(iconResource))
        .width(20).height(20).fillColor('#9E9E9E')
      
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 8 })
      
      Text(title)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(HorizontalAlign.Start)
  }
}