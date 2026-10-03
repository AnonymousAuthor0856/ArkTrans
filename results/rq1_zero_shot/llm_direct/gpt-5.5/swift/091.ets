@Entry
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

        Blank()
          .height(10)

        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: $targetTemp,
          isPowerOn: this.isPowerOn
        })

        Blank()
          .layoutWeight(1)

        ModeSelection({
          selectedMode: $selectedMode,
          isPowerOn: this.isPowerOn
        })

        Blank()
          .layoutWeight(1)

        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()
          .layoutWeight(1)

        PowerSwitch({ isPowerOn: $isPowerOn })
          .padding({ left: 24, right: 24, bottom: 40 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct TopBar {
  @Prop isPowerOn: boolean

  build() {
    Row() {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('☰')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : Color.Gray)
      }

      Blank()
        .layoutWeight(1)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(Color.Gray)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureControl {
  @Prop currentTemp: number
  @Link targetTemp: number
  @Prop isPowerOn: boolean

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke('#EEEEEE')
        .strokeWidth(1)

      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : '#D3D3D3')

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      if (this.isPowerOn) {
        Row() {
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Text('⌄')
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .onClick(() => {
            this.targetTemp -= 1
          })
          .margin({ left: 20 })

          Blank()
            .layoutWeight(1)

          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Text('+')
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .onClick(() => {
            this.targetTemp += 1
          })
          .margin({ right: 20 })
        }
        .width(280)
        .alignItems(VerticalAlign.Center)
      }
    }
    .width(280)
    .height(280)
  }
}

@Component
struct ModeSelection {
  @Link selectedMode: string
  @Prop isPowerOn: boolean

  build() {
    Column({ space: 16 }) {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)

      Row({ space: 12 }) {
        ModeButton({
          icon: '⌂',
          label: 'Auto',
          isSelected: this.selectedMode === 'Auto',
          isEnabled: this.isPowerOn,
          action: () => {
            this.selectedMode = 'Auto'
          }
        })

        ModeButton({
          icon: '↻',
          label: 'Fan',
          isSelected: this.selectedMode === 'Fan',
          isEnabled: this.isPowerOn,
          action: () => {
            this.selectedMode = 'Fan'
          }
        })

        ModeButton({
          icon: '★',
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
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ModeButton {
  icon: string = ''
  label: string = ''
  isSelected: boolean = false
  isEnabled: boolean = true
  action: () => void = () => {}

  build() {
    Column({ space: 8 }) {
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text(this.icon)
          .fontSize(24)
          .fontColor(
            this.isSelected && this.isEnabled
              ? Color.White
              : this.isEnabled
                ? Color.Black
                : '#D3D3D3'
          )
      }
      .width(60)
      .height(60)
      .backgroundColor(this.isSelected && this.isEnabled ? Color.Black : Color.White)
      .border({
        width: this.isSelected ? 0 : 1,
        color: this.isSelected ? Color.Transparent : '#E0E0E0',
        radius: 30
      })
      .enabled(this.isEnabled)
      .onClick(() => {
        if (this.isEnabled) {
          this.action()
        }
      })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? Color.Gray : '#D3D3D3')
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
        icon: 'ⓘ'
      })
        .layoutWeight(1)

      InfoCard({
        title: 'Energy',
        value: '12 kWh',
        icon: '⌃'
      })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  title: string = ''
  value: string = ''
  icon: string = ''

  build() {
    Column({ space: 8 }) {
      Text(this.icon)
        .fontSize(20)
        .fontColor(Color.Gray)

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({
      width: 1,
      color: '#F0F0F0',
      radius: 16
    })
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
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding(20)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
  }
}