import { router } from '@kit.ArkRouter';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct ThermostatApp {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Column() {
      // Top Bar
      this.TopBar()
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      Spacer().height(10)

      // Temperature Circle Control
      this.TemperatureControl()

      Spacer()

      // Mode Selection
      this.ModeSelection()

      Spacer()

      // Info Cards
      this.InfoCardsRow()
        .padding({ left: 24, right: 24 })

      Spacer()

      // Master Power Switch
      this.PowerSwitch()
        .padding({ bottom: 40, left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      Button() {
        Image($r('app.media.ic_menu')) // Placeholder for line.3.horizontal
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)

      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(Color.Gray)
        
        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? Color.fromHex('#4CAF50') : Color.Gray)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      Button() {
        Image($r('app.media.ic_settings')) // Placeholder for gearshape.fill
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  TemperatureControl() {
    Stack() {
      // Background Circle
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .border({ width: 1, color: Color.fromHex('#EEEEEE') })

      // Text Content
      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Light)
          .fontColor(this.isPowerOn ? Color.Black : Color.fromHex('#D3D3D3'))
        
        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      // Buttons
      if (this.isPowerOn) {
        Row() {
          // Decrease Button
          Button() {
            Image($r('app.media.ic_chevron_down')) // Placeholder for chevron.down
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .type(ButtonType.Normal)
          .width(48)
          .height(48)
          .backgroundColor(Color.fromHex('#F5F5F5'))
          .borderRadius(24)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp -= 1;
            }
          })
          .margin({ left: 20 })

          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            // Spacer handled by layout
          }
          
          // Increase Button
          Button() {
            Image($r('app.media.ic_plus')) // Placeholder for plus
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .type(ButtonType.Normal)
          .width(48)
          .height(48)
          .backgroundColor(Color.fromHex('#F5F5F5'))
          .borderRadius(24)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp += 1;
            }
          })
          .margin({ right: 20 })
        }
        .width(280)
        .justifyContent(FlexAlign.SpaceBetween)
      }
    }
    .width(280)
    .height(280)
  }

  @Builder
  ModeSelection() {
    Column() {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)
      
      Row() {
        this.ModeButton('Auto', $r('app.media.ic_house'), this.selectedMode === 'Auto')
        this.ModeButton('Fan', $r('app.media.ic_fan'), this.selectedMode === 'Fan')
        this.ModeButton('Cool', $r('app.media.ic_cool'), this.selectedMode === 'Cool')
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')
    }
    .spacing(16)
  }

  @Builder
  ModeButton(label: string, iconRes: Resource, isSelected: boolean) {
    Column() {
      Button() {
        Image(iconRes)
          .width(24)
          .height(24)
          .fillColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : Color.fromHex('#D3D3D3')))
      }
      .type(ButtonType.Normal)
      .width(60)
      .height(60)
      .backgroundColor(isSelected && this.isPowerOn ? Color.Black : Color.White)
      .borderRadius(30)
      .border({ 
        width: isSelected ? 0 : 1, 
        color: isSelected ? Color.Transparent : Color.fromHex('#E0E0E0') 
      })
      .enabled(this.isPowerOn)
      .onClick(() => {
        if (this.isPowerOn) {
          this.selectedMode = label;
        }
      })

      Text(label)
        .fontSize(11)
        .fontColor(this.isPowerOn ? Color.Gray : Color.fromHex('#D3D3D3'))
    }
    .spacing(8)
  }

  @Builder
  InfoCardsRow() {
    Row() {
      this.InfoCard('Humidity', '45%', $r('app.media.ic_info'))
      this.InfoCard('Energy', '12 kWh', $r('app.media.ic_energy'))
    }
    .spacing(16)
    .width('100%')
  }

  @Builder
  InfoCard(title: string, value: string, iconRes: Resource) {
    Column({ space: 8 }) {
      Image(iconRes)
        .width(20)
        .height(20)
        .fillColor(Color.Gray)
      
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
      
      Text(title)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(Color.fromHex('#F9F9F9'))
    .borderRadius(16)
    .border({ width: 1, color: Color.fromHex('#F0F0F0') })
  }

  @Builder
  PowerSwitch() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)
        
        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn;
        })
        .width(50)
        .height(30)
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.fromHex('#F9F9F9'))
    .borderRadius(16)
  }
}