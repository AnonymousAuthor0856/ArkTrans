@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22
  @State targetTemp: number = 24
  @State isPowerOn: boolean = true
  @State selectedMode: string = "Cool"

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Text("☰")
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)

        Column() {
          Text("LIVING ROOM")
            .fontSize(12)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)

          if (this.isPowerOn) {
            Text("Active")
              .fontSize(10)
              .fontColor('#4CAF50')
          } else {
            Text("Off")
              .fontSize(10)
              .fontColor(Color.Gray)
          }
        }
        .alignItems(HorizontalAlign.Center)

        Button() {
          Text("⚙")
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Temperature Control
      Stack() {
        // Decorative circle
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
            .fontColor(this.isPowerOn ? Color.Black : Color.Gray)

          Text(`CURRENT: ${this.currentTemp}°`)
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Center)

        if (this.isPowerOn) {
          Row() {
            Button() {
              Text("−")
                .fontSize(24)
                .fontColor(Color.Black)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#F5F5F5')
            .onClick(() => {
              this.targetTemp--
            })

            Blank()
              .width(160)

            Button() {
              Text("+")
                .fontSize(24)
                .fontColor(Color.Black)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#F5F5F5')
            .onClick(() => {
              this.targetTemp++
            })
          }
          .width(260)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 10 })

      // Mode Selection
      Column() {
        Text("MODE")
          .fontSize(10)
          .fontColor(Color.Gray)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        Row({ space: 12 }) {
          ModeButtonComponent({
            iconText: "🏠",
            label: "Auto",
            isSelected: this.selectedMode === "Auto",
            isEnabled: this.isPowerOn,
            onClickHandler: () => {
              this.selectedMode = "Auto"
            }
          })

          ModeButtonComponent({
            iconText: "↺",
            label: "Fan",
            isSelected: this.selectedMode === "Fan",
            isEnabled: this.isPowerOn,
            onClickHandler: () => {
              this.selectedMode = "Fan"
            }
          })

          ModeButtonComponent({
            iconText: "★",
            label: "Cool",
            isSelected: this.selectedMode === "Cool",
            isEnabled: this.isPowerOn,
            onClickHandler: () => {
              this.selectedMode = "Cool"
            }
          })
        }
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .margin({ top: 24 })

      // Info Cards
      Row({ space: 16 }) {
        InfoCardComponent({
          title: "Humidity",
          value: "45%",
          iconText: "💧"
        })

        InfoCardComponent({
          title: "Energy",
          value: "12 kWh",
          iconText: "⚡"
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 24 })

      // Power Switch
      Row() {
        Column() {
          Text("Master Power")
            .fontSize(16)
            .fontWeight(FontWeight.Medium)

          Text(this.isPowerOn ? "System is running" : "System is off")
            .fontSize(12)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Start)

        Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
          .selectedColor(Color.Black)
          .switchPointColor(Color.White)
          .onChange((isOn: boolean) => {
            this.isPowerOn = isOn
          })
      }
      .width('100%')
      .margin({ top: 24, bottom: 40, left: 24, right: 24 })
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#F9F9F9')
      .borderRadius(16)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ModeButtonComponent {
  iconText: string = ""
  label: string = ""
  isSelected: boolean = false
  isEnabled: boolean = true
  onClickHandler: () => void = () => {}

  build() {
    Column() {
      Button() {
        Text(this.iconText)
          .fontSize(20)
          .fontColor(this.isSelected && this.isEnabled ? Color.White : (this.isEnabled ? Color.Black : Color.Gray))
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.isSelected && this.isEnabled ? Color.Black : (this.isEnabled ? Color.White : '#F5F5F5'))
      .border({ width: this.isSelected ? 0 : 1, color: this.isSelected ? Color.Black : '#E0E0E0' })
      .onClick(() => {
        if (this.isEnabled) {
          this.onClickHandler()
        }
      })

      Text(this.label)
        .fontSize(10)
        .fontColor(this.isEnabled ? Color.Gray : Color.Gray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCardComponent {
  title: string = ""
  value: string = ""
  iconText: string = ""

  build() {
    Column() {
      Text(this.iconText)
        .fontSize(20)
        .fontColor(Color.Gray)

      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 8 })

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 4 })
    }
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
  }
}