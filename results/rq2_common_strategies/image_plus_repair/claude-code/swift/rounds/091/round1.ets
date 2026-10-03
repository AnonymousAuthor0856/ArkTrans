@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = "Cool";

  build() {
    Stack() {
      Column() {
        // Top Bar
        this.TopBar()

        Blank().height(10)

        // Temperature Circle Control
        this.TemperatureControl()

        Blank()

        // Mode Selection
        this.ModeSelection()

        Blank()

        // Info Cards
        this.InfoCardsRow()

        Blank()

        // Master Power Switch
        this.PowerSwitch()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  TopBar() {
    Row() {
      // Menu Button
      Button() {
        Column({ space: 3 }) {
          Row().width(22).height(2).backgroundColor('#9E9E9E').borderRadius(1)
          Row().width(22).height(2).backgroundColor('#9E9E9E').borderRadius(1)
          Row().width(22).height(2).backgroundColor('#9E9E9E').borderRadius(1)
        }
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .width(48)
      .height(48)

      Blank()

      Column({ space: 2 }) {
        Text("LIVING ROOM")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#9E9E9E')
          .letterSpacing(2)

        Text(this.isPowerOn ? "Active" : "Off")
          .fontSize(14)
          .fontColor(this.isPowerOn ? '#4CAF50' : '#9E9E9E')
      }

      Blank()

      // Settings Button
      Button() {
        Text("⚙")
          .fontSize(28)
          .fontColor('#9E9E9E')
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .width(48)
      .height(48)
    }
    .width('100%')
    .margin({ left: 24, right: 24, top: 24, bottom: 24 })
  }

  @Builder
  TemperatureControl() {
    Stack() {
      // Background Circle
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke({ color: '#EEEEEE', width: 1 })

      // Temperature Text
      Column({ space: 8 }) {
        Text(this.targetTemp + "°")
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : '#D4D4D4')

        Text("CURRENT: " + this.currentTemp + "°")
          .fontSize(14)
          .fontColor('#9E9E9E')
      }

      // +/- Buttons (only when power is on)
      if (this.isPowerOn) {
        Row() {
          // Decrease Button
          Button() {
            Text("⌄")
              .fontSize(28)
              .fontColor(Color.Black)
          }
          .type(ButtonType.Circle)
          .width(64)
          .height(64)
          .backgroundColor('#F5F5F5')
          .onClick(() => {
            this.targetTemp -= 1;
          })
          .margin({ left: 20 })

          Blank()

          // Increase Button
          Button() {
            Text("+")
              .fontSize(28)
              .fontColor(Color.Black)
          }
          .type(ButtonType.Circle)
          .width(64)
          .height(64)
          .backgroundColor('#F5F5F5')
          .onClick(() => {
            this.targetTemp += 1;
          })
          .margin({ right: 20 })
        }
        .width(280)
      }
    }
    .width(280)
    .height(280)
  }

  @Builder
  ModeSelection() {
    Column({ space: 16 }) {
      Text("MODE")
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#9E9E9E')

      Row({ space: 12 }) {
        this.ModeButton(
          "⌂",
          "Auto",
          this.selectedMode == "Auto",
          () => { this.selectedMode = "Auto"; }
        )
        this.ModeButton(
          "↻",
          "Fan",
          this.selectedMode == "Fan",
          () => { this.selectedMode = "Fan"; }
        )
        this.ModeButton(
          "★",
          "Cool",
          this.selectedMode == "Cool",
          () => { this.selectedMode = "Cool"; }
        )
      }
    }
  }

  @Builder
  ModeButton(icon: string, label: string, isSelected: boolean, action: () => void) {
    Column({ space: 8 }) {
      Button() {
        Text(icon)
          .fontSize(28)
          .fontColor(
            isSelected && this.isPowerOn
              ? Color.White
              : (this.isPowerOn ? Color.Black : '#D4D4D4')
          )
      }
      .type(ButtonType.Circle)
      .width(68)
      .height(68)
      .backgroundColor(
        isSelected && this.isPowerOn ? Color.Black : Color.White
      )
      .border({
        width: !isSelected ? 1 : 0,
        color: '#E0E0E0'
      })
      .enabled(this.isPowerOn)
      .onClick(action)

      Text(label)
        .fontSize(11)
        .fontColor(this.isPowerOn ? '#9E9E9E' : '#D4D4D4')
    }
  }

  @Builder
  InfoCardsRow() {
    Row({ space: 16 }) {
      this.InfoCard("Humidity", "45%", "i")
      this.InfoCard("Energy", "12 kWh", "^")
    }
    .width('100%')
    .margin({ left: 24, right: 24 })
  }

  @Builder
  InfoCard(title: string, value: string, icon: string) {
    Column({ space: 8 }) {
      Text(icon)
        .fontSize(20)
        .fontColor('#9E9E9E')
        .width(28)
        .height(28)
        .textAlign(TextAlign.Center)

      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(title)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
    .width('50%')
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
  }

  @Builder
  PowerSwitch() {
    Row() {
      Column({ space: 4 }) {
        Text("Master Power")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
        Text(this.isPowerOn ? "System is running" : "System is off")
          .fontSize(12)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .width(60)
        .height(32)
        .selectedColor(Color.Black)
        .onChange((value: boolean) => {
          this.isPowerOn = value;
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .margin({ bottom: 40, left: 24, right: 24 })
  }
}
