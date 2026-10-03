// Translated from 091.swift (Thermostat App)

@Entry
@Component
struct Index {
  build() {
    ThermostatScreen()
  }
}

@Component
struct ThermostatScreen {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = 'Cool'

  build() {
    Stack() {
      Column() {
        TopBar({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: $this.targetTemp,
          isPowerOn: this.isPowerOn
        })

        Blank()

        ModeSelection({
          selectedMode: $this.selectedMode,
          isPowerOn: this.isPowerOn
        })

        Blank()

        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()

        PowerSwitch({ isPowerOn: $this.isPowerOn })
          .padding({ bottom: 40, left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

@Component
struct TopBar {
  @Prop isPowerOn: boolean = true

  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(24)
          .fontColor('#808080')
      }
      .onClick(() => {})

      Blank()

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#808080')
        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4DB04F' : '#808080')
      }

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#808080')
      }
      .onClick(() => {})
    }
    .width('100%')
  }
}

@Component
struct TemperatureControl {
  @Prop currentTemp: number = 0
  @Link targetTemp: number
  @Prop isPowerOn: boolean = true

  build() {
    Stack() {
      Circle()
        .fill('#FFFFFF')
        .stroke('#EDEDED')
        .strokeWidth(1)
        .width(280)
        .height(280)

      Column() {
        Text(this.targetTemp.toString() + '°')
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? '#000000' : '#D4D4D4')
        Text('CURRENT: ' + this.currentTemp.toString() + '°')
          .fontSize(14)
          .fontColor('#808080')
      }

      if (this.isPowerOn) {
        Row() {
          Button() {
            Text('▼')
              .fontSize(24)
              .fontColor('#000000')
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
              .backgroundColor('#F5F5F5')
              .borderRadius(24)
          }
          .onClick(() => { this.targetTemp -= 1 })
          .padding({ left: 20 })

          Blank()

          Button() {
            Text('+')
              .fontSize(24)
              .fontColor('#000000')
              .width(48)
              .height(48)
              .textAlign(TextAlign.Center)
              .backgroundColor('#F5F5F5')
              .borderRadius(24)
          }
          .onClick(() => { this.targetTemp += 1 })
          .padding({ right: 20 })
        }
        .width(280)
      }
    }
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
        .fontColor('#808080')

      Row({ space: 12 }) {
        ModeButton({
          iconName: '⌂',
          label: 'Auto',
          isSelected: this.selectedMode == 'Auto',
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = 'Auto' }
        })
        ModeButton({
          iconName: '↻',
          label: 'Fan',
          isSelected: this.selectedMode == 'Fan',
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = 'Fan' }
        })
        ModeButton({
          iconName: '★',
          label: 'Cool',
          isSelected: this.selectedMode == 'Cool',
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = 'Cool' }
        })
      }
    }
  }
}

@Component
struct ModeButton {
  @Prop iconName: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  @Prop isEnabled: boolean = true
  action: () => void = () => {}

  build() {
    Column({ space: 8 }) {
      Button() {
        Text(this.iconName)
          .fontSize(24)
          .width(60)
          .height(60)
          .textAlign(TextAlign.Center)
          .fontColor(this.isSelected && this.isEnabled ? '#FFFFFF' : (this.isEnabled ? '#000000' : '#D4D4D4'))
          .backgroundColor(this.isSelected && this.isEnabled ? '#000000' : '#FFFFFF')
          .borderRadius(30)
          .border({
            width: 1,
            color: this.isSelected ? '#00000000' : '#E0E0E0',
            radius: 30
          })
      }
      .onClick(() => { this.action() })
      .enabled(this.isEnabled)

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? '#808080' : '#D4D4D4')
    }
  }
}

@Component
struct InfoCardsRow {
  build() {
    Row({ space: 16 }) {
      InfoCard({ title: 'Humidity', value: '45%', iconName: 'ⓘ' })
        .layoutWeight(1)
      InfoCard({ title: 'Energy', value: '12 kWh', iconName: '▲' })
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
        .fontSize(20)
        .fontColor('#808080')
      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
      Text(this.title)
        .fontSize(12)
        .fontColor('#808080')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0', radius: 16 })
  }
}

@Component
struct PowerSwitch {
  @Link isPowerOn: boolean

  build() {
    Row() {
      Column() {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Semibold)
          .fontColor('#000000')
        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor('#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .onChange((isOn: boolean) => { this.isPowerOn = isOn })
        .selectedColor('#000000')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FAFAFA')
    .borderRadius(16)
  }
}
