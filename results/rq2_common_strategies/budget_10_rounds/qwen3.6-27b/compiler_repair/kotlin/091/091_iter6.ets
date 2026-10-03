import { router } from '@kit.ArkRouter'
import { window } from '@kit.ArkUI'

// Define a simple Icon component to replace Material Icons for this demo
@Entry
@Component
struct ThermostatApp {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = "Cool"

  build() {
    Column() {
      // Top Bar
      Row() {
        Button('', { type: ButtonType.Circle })
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            // Menu action
          })
        
        Column() {
          Text("LIVING ROOM")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
            .fontColor('#9E9E9E')
          
          Text(this.isPowerOn ? "Active" : "Off")
            .fontSize(10)
            .fontColor(this.isPowerOn ? '#4CAF50' : '#BDBDBD')
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)

        Button('', { type: ButtonType.Circle })
          .width(48)
          .height(48)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            // Settings action
          })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Spacer().height(10)

      // Main Temperature Control
      Stack() {
        Circle()
          .width(280)
          .height(280)
          .fill(Color.White)
          .borderWidth(1)
          .borderColor('#EEEEEE')
        
        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(96)
            .fontWeight(FontWeight.Lighter)
            .fontColor(this.isPowerOn ? Color.Black : '#BDBDBD')
          
          Text(`CURRENT: ${this.currentTemp}°`)
            .fontSize(14)
            .fontColor('#9E9E9E')
            .margin({ top: -10 })
        }
        .alignItems(HorizontalAlign.Center)

        if (this.isPowerOn) {
          // Increase Button
          Button('+', { type: ButtonType.Circle })
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .fontColor(Color.Black)
            .position({ x: 116, y: 116 })
            .onClick(() => {
              this.targetTemp++
            })

          // Decrease Button
          Button('-', { type: ButtonType.Circle })
            .width(48)
            .height(48)
            .backgroundColor('#F5F5F5')
            .fontColor(Color.Black)
            .position({ x: 16, y: 116 })
            .onClick(() => {
              this.targetTemp--
            })
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 20 })

      // Mode Selection
      Column() {
        Text("MODE")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#9E9E9E')
          .margin({ bottom: 16 })
        
        Row() {
          this.ModeButton('Auto', '🏠', this.selectedMode === 'Auto')
          this.ModeButton('Fan', '🔄', this.selectedMode === 'Fan')
          this.ModeButton('Cool', '⭐', this.selectedMode === 'Cool')
        }
        .justifyContent(FlexAlign.SpaceEvenly)
        .width('100%')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center)
      .margin({ top: 30 })

      // Info Cards
      Row() {
        this.InfoCard("Humidity", "45%", "💧")
        this.InfoCard("Energy", "12 kWh", "⚡")
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 20 })

      Spacer().layoutWeight(1)

      // Power Switch
      Row() {
        Column() {
          Text("Master Power")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Text(this.isPowerOn ? "System is running" : "System is off")
            .fontSize(12)
            .fontColor('#9E9E9E')
            .margin({ top: 4 })
        }
        
        Toggle({
          type: ToggleType.Switch,
          isOn: this.isPowerOn
        })
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn
        })
        .width(50)
        .height(30)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#F9F9F9')
      .borderRadius(16)
      .margin({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .padding({ left: 24, right: 24 })
  }

  @Builder
  ModeButton(label: string, icon: string, isSelected: boolean) {
    Column() {
      Button(icon, { type: ButtonType.Circle })
        .width(60)
        .height(60)
        .fontSize(24)
        .backgroundColor(isSelected && this.isPowerOn ? Color.Black : Color.White)
        .fontColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : '#BDBDBD'))
        .borderWidth(!isSelected ? 1 : 0)
        .borderColor(!isSelected ? '#E0E0E0' : Color.Transparent)
        .enabled(this.isPowerOn)
        .onClick(() => {
          this.selectedMode = label
        })
      
      Text(label)
        .fontSize(12)
        .fontColor(this.isPowerOn ? '#9E9E9E' : '#BDBDBD')
        .margin({ top: 8 })
    }
  }

  @Builder
  InfoCard(title: string, value: string, icon: string) {
    Column() {
      Text(icon)
        .fontSize(20)
        .margin({ bottom: 8 })
      
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
      
      Text(title)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
    .width('48%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .borderWidth(1)
    .borderColor('#F0F0F0')
  }
}