@Entry
@Component
struct Index {
  build() {
    ThermostatScreen()
  }
}

@Component
struct ThermostatScreen {
  @State private currentTemp: number = 22
  @State private targetTemp: number = 24
  @State private isPowerOn: boolean = true
  @State private selectedMode: string = 'Cool'

  build() {
    Stack() {
      Column() {
        TopBar({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: $targetTemp,
          isPowerOn: this.isPowerOn
        })

        Blank()

        ModeSelection({
          selectedMode: $selectedMode,
          isPowerOn: this.isPowerOn
        })

        Blank()

        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()

        PowerSwitch({ isPowerOn: $isPowerOn })
          .padding({ left: 24, right: 24, bottom: 40 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopBar {
  @Prop isPowerOn: boolean = true

  build() {
    Row() {
      Text('☰')
        .fontSize(28)
        .fontColor('#8E8E93')
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)

      Blank()

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#8E8E93')

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : '#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Text('⚙')
        .fontSize(32)
        .fontColor('#8E8E93')
        .width(48)
        .height(48)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureControl {
  @Prop currentTemp: number = 22
  @Link targetTemp: number
  @Prop isPowerOn: boolean = true

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Column({ space: 0 }) {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Center)

      if (this.isPowerOn) {
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Text('⌄')
              .fontSize(36)
              .fontColor(Color.Black)
              .margin({ bottom: 8 })
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .onClick(() => {
            this.targetTemp -= 1
          })

          Blank()

          Stack({ alignContent: Alignment.Center }) {
            Text('+')
              .fontSize(36)
              .fontWeight(FontWeight.Normal)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .onClick(() => {
            this.targetTemp += 1
          })
        }
        .width(280)
        .padding({ left: 20, right: 20 })
        .alignItems(VerticalAlign.Center)
      }
    }
    .width(280)
    .height(280)
    .borderRadius(140)
    .border({ width: 1, color: '#EEEEEE' })
    .backgroundColor(Color.White)
  }
}

@Component
struct ModeSelection {
  @Link selectedMode: string
  @Prop isPowerOn: boolean = true

  build() {
    Column({ space: 16 }) {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')

      Row({ space: 12 }) {
        ModeButton({
          iconName: '⌂',
          label: 'Auto',
          isSelected: this.selectedMode === 'Auto',
          isEnabled: this.isPowerOn,
          action: () => {
            this.selectedMode = 'Auto'
          }
        })

        ModeButton({
          iconName: '↻',
          label: 'Fan',
          isSelected: this.selectedMode === 'Fan',
          isEnabled: this.isPowerOn,
          action: () => {
            this.selectedMode = 'Fan'
          }
        })

        ModeButton({
          iconName: '★',
          label: 'Cool',
          isSelected: this.selectedMode === 'Cool',
          isEnabled: this.isPowerOn,
          action: () => {
            this.selectedMode = 'Cool'
          }
        })
      }
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ModeButton {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  @Prop isEnabled: boolean = true
  action: () => void = () => {
  }

  build() {
    Column({ space: 8 }) {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.iconName)
          .fontSize(32)
          .fontColor(
            this.isSelected && this.isEnabled
              ? Color.White
              : (this.isEnabled ? Color.Black : '#D3D3D3')
          )
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.isSelected && this.isEnabled ? Color.Black : Color.White)
      .border({
        width: this.isSelected ? 0 : 1,
        color: '#E0E0E0'
      })
      .onClick(() => {
        if (this.isEnabled) {
          this.action()
        }
      })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? '#8E8E93' : '#D3D3D3')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCardsRow {
  build() {
    Row({ space: 16 }) {
      InfoCard({
        title: 'Humidity',
        value: '45%',
        iconName: 'ℹ'
      })
        .layoutWeight(1)

      InfoCard({
        title: 'Energy',
        value: '12 kWh',
        iconName: '⌃'
      })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop iconName: string = ''

  build() {
    Column({ space: 8 }) {
      Text(this.iconName)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#8E8E93')

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.title)
        .fontSize(12)
        .fontColor('#8E8E93')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }
}

@Component
struct PowerSwitch {
  @Link isPowerOn: boolean

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor('#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Stack()
          .width(54)
          .height(54)
          .borderRadius(27)
          .backgroundColor(Color.White)
      }
      .width(102)
      .height(62)
      .padding(4)
      .borderRadius(31)
      .backgroundColor(this.isPowerOn ? Color.Black : '#D3D3D3')
      .justifyContent(this.isPowerOn ? FlexAlign.End : FlexAlign.Start)
      .onClick(() => {
        this.isPowerOn = !this.isPowerOn
      })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .alignItems(VerticalAlign.Center)
  }
}