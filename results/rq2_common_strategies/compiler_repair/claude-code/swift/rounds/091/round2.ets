@Entry
@Component
struct ThermostatApp {
  build() {
    Column() {
      ThermostatScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ThermostatScreen {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = "Cool"

  build() {
    Stack() {
      Column() {
        TopBar({ isPowerOn: this.isPowerOn })
          .margin({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank()
          .height(10)

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
          .margin({ left: 24, right: 24 })

        Blank()

        PowerSwitch({ isPowerOn: $isPowerOn })
          .margin({ bottom: 40, left: 24, right: 24 })
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
  isPowerOn: boolean = false

  build() {
    Row() {
      Text("≡")
        .fontSize(24)
        .fontColor(Color.Gray)

      Blank()

      Column({ space: 2 }) {
        Text("LIVING ROOM")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text(this.isPowerOn ? "Active" : "Off")
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : Color.Gray)
      }

      Blank()

      Text("⚙")
        .fontSize(24)
        .fontColor(Color.Gray)
    }
    .width('100%')
  }
}

@Component
struct TemperatureControl {
  currentTemp: number = 0
  @Link targetTemp: number
  isPowerOn: boolean = false

  @Builder
  tempDisplay() {
    Column() {
      Text(`${this.targetTemp}°`)
        .fontSize(96)
        .fontWeight(FontWeight.Lighter)
        .fontColor(this.isPowerOn ? Color.Black : '#D4D4D4')

      Text(`CURRENT: ${this.currentTemp}°`)
        .fontSize(14)
        .fontColor(Color.Gray)
    }
  }

  build() {
    Stack() {
      Circle()
        .fill(Color.White)
        .stroke('#EEEEEE')
        .strokeWidth(1)
        .width(280)
        .height(280)

      this.tempDisplay()

      if (this.isPowerOn) {
        Row() {
          Stack() {
            Circle()
              .fill('#F5F5F5')
              .width(48)
              .height(48)
            Text("−")
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .onClick(() => {
            this.targetTemp -= 1
          })
          .margin({ left: 20 })

          Blank()

          Stack() {
            Circle()
              .fill('#F5F5F5')
              .width(48)
              .height(48)
            Text("+")
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .onClick(() => {
            this.targetTemp += 1
          })
          .margin({ right: 20 })
        }
        .width(280)
      }
    }
    .width(280)
    .height(280)
  }
}

@Component
struct ModeSelection {
  @Link selectedMode: string
  isPowerOn: boolean = false

  build() {
    Column({ space: 16 }) {
      Text("MODE")
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)

      Row({ space: 12 }) {
        ModeButton({
          label: "Auto",
          symbol: "A",
          isSelected: this.selectedMode === "Auto",
          isEnabled: this.isPowerOn,
          onSelect: () => { this.selectedMode = "Auto" }
        })

        ModeButton({
          label: "Fan",
          symbol: "F",
          isSelected: this.selectedMode === "Fan",
          isEnabled: this.isPowerOn,
          onSelect: () => { this.selectedMode = "Fan" }
        })

        ModeButton({
          label: "Cool",
          symbol: "❄",
          isSelected: this.selectedMode === "Cool",
          isEnabled: this.isPowerOn,
          onSelect: () => { this.selectedMode = "Cool" }
        })
      }
    }
  }
}

@Component
struct ModeButton {
  label: string = ""
  symbol: string = ""
  isSelected: boolean = false
  isEnabled: boolean = false
  onSelect: () => void = () => {}

  build() {
    Column({ space: 8 }) {
      Stack() {
        Circle()
          .fill(this.isSelected && this.isEnabled ? Color.Black : Color.White)
          .stroke(!this.isSelected ? '#E0E0E0' : Color.Transparent)
          .strokeWidth(1)
          .width(60)
          .height(60)

        Text(this.symbol)
          .fontSize(24)
          .fontColor(
            this.isSelected && this.isEnabled ? Color.White :
              (this.isEnabled ? Color.Black : '#D4D4D4')
          )
      }
      .onClick(() => {
        if (this.isEnabled) {
          this.onSelect()
        }
      })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? Color.Gray : '#D4D4D4')
    }
  }
}

@Component
struct InfoCardsRow {
  build() {
    Row({ space: 16 }) {
      InfoCard({
        title: "Humidity",
        value: "45%",
        symbol: "i"
      })
      .layoutWeight(1)

      InfoCard({
        title: "Energy",
        value: "12 kWh",
        symbol: "↑"
      })
      .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  title: string = ""
  value: string = ""
  symbol: string = ""

  build() {
    Column() {
      Text(this.symbol)
        .fontSize(20)
        .fontColor(Color.Gray)
        .margin({ bottom: 8 })
        .alignSelf(ItemAlign.Start)

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 8 })
        .alignSelf(ItemAlign.Start)

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .alignSelf(ItemAlign.Start)
    }
    .padding(16)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
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
      Column() {
        Text("Master Power")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? "System is running" : "System is off")
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 0 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((value: boolean) => {
          this.isPowerOn = value
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
  }
}
