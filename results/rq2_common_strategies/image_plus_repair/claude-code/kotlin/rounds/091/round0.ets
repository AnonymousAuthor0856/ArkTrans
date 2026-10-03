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
        // Menu Icon
        Column() {
          Column() {}
          .width(20)
          .height(2)
          .backgroundColor(Color.Gray)
          .margin({ bottom: 4 })
          Column() {}
          .width(20)
          .height(2)
          .backgroundColor(Color.Gray)
          .margin({ bottom: 4 })
          Column() {}
          .width(20)
          .height(2)
          .backgroundColor(Color.Gray)
        }
        .width(48)
        .height(48)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .borderRadius(24)
        .onClick(() => {})

        // Title
        Column() {
          Text("LIVING ROOM")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .letterSpacing(2)
          Text(this.isPowerOn ? "Active" : "Off")
            .fontSize(12)
            .fontColor(this.isPowerOn ? "#4CAF50" : Color.LightGray)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)

        // Settings Icon (gear)
        Text("⚙")
          .fontSize(28)
          .fontColor(Color.Gray)
          .width(48)
          .height(48)
          .textAlign(TextAlign.Center)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        Blank()

        // Temperature Circle
        Stack() {
          // Decorative circle border
          Circle()
            .width(280)
            .height(280)
            .fill(Color.White)
            .stroke("#EEEEEE")
            .strokeWidth(1)

          // Temperature Text
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? Color.Black : Color.LightGray)
            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Center)

          // Plus Button
          if (this.isPowerOn) {
            Row() {
              Blank()
              Text("+")
                .fontSize(32)
                .fontColor(Color.Black)
                .width(48)
                .height(48)
                .textAlign(TextAlign.Center)
                .backgroundColor("#F5F5F5")
                .borderRadius(24)
                .margin({ right: 20 })
                .onClick(() => { this.targetTemp++ })
            }
            .width(280)
            .height(280)
          }

          // Minus Button (down arrow)
          if (this.isPowerOn) {
            Row() {
              Text("∨")
                .fontSize(32)
                .fontColor(Color.Black)
                .width(48)
                .height(48)
                .textAlign(TextAlign.Center)
                .backgroundColor("#F5F5F5")
                .borderRadius(24)
                .margin({ left: 20 })
              Blank()
            }
            .width(280)
            .height(280)
          }
        }
        .width(280)
        .height(280)

        Blank()

        // Mode Selection
        Column() {
          Text("MODE")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .margin({ bottom: 16 })

          Row() {
            this.ModeButtonIcon("⌂", "Auto", this.selectedMode === "Auto")
              .margin({ right: 12 })
              .onClick(() => { if (this.isPowerOn) this.selectedMode = "Auto" })
            this.ModeButtonIcon("↻", "Fan", this.selectedMode === "Fan")
              .margin({ right: 12 })
              .onClick(() => { if (this.isPowerOn) this.selectedMode = "Fan" })
            this.ModeButtonIcon("★", "Cool", this.selectedMode === "Cool")
              .onClick(() => { if (this.isPowerOn) this.selectedMode = "Cool" })
          }
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Blank()

        // Info Cards
        Row() {
          // Humidity Card
          Column() {
            Text("ⓘ")
              .fontSize(20)
              .fontColor(Color.Gray)
            Text("45%")
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 8 })
            Text("Humidity")
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 8 })
          }
          .width('100%')
          .layoutWeight(1)
          .padding(16)
          .backgroundColor("#F9F9F9")
          .borderRadius(16)
          .border({ width: 1, color: "#F0F0F0" })
          .alignItems(HorizontalAlign.Start)

          // Energy Card
          Column() {
            Text("∧")
              .fontSize(20)
              .fontColor(Color.Gray)
            Text("12 kWh")
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
              .margin({ top: 8 })
            Text("Energy")
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 8 })
          }
          .width('100%')
          .layoutWeight(1)
          .padding(16)
          .backgroundColor("#F9F9F9")
          .borderRadius(16)
          .border({ width: 1, color: "#F0F0F0" })
          .margin({ left: 16 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')

        Blank()

        // Power Switch Row
        Row() {
          Column() {
            Text("Master Power")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
            Text(this.isPowerOn ? "System is running" : "System is off")
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          // Custom Switch
          Row() {
            Circle()
              .width(22)
              .height(22)
              .fill(Color.White)
              .margin(this.isPowerOn ? { left: 26, right: 4 } : { left: 4, right: 26 })
              .transition({ type: TransitionType.Translate, duration: 200 })
          }
          .width(52)
          .height(30)
          .borderRadius(15)
          .backgroundColor(this.isPowerOn ? Color.Black : "#D3D3D3")
          .justifyContent(FlexAlign.Start)
          .alignItems(VerticalAlign.Center)
          .onClick(() => { this.isPowerOn = !this.isPowerOn })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor("#F9F9F9")
        .borderRadius(16)
        .margin({ bottom: 40 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  ModeButtonIcon(icon: string, label: string, isSelected: boolean) {
    Column() {
      Text(icon)
        .fontSize(24)
        .fontColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : Color.LightGray))
        .width(60)
        .height(60)
        .textAlign(TextAlign.Center)
        .backgroundColor(isSelected && this.isPowerOn ? Color.Black : Color.White)
        .borderRadius(30)
        .border({
          width: isSelected ? 0 : 1,
          color: isSelected ? Color.Black : "#E0E0E0"
        })
      Text(label)
        .fontSize(12)
        .fontColor(this.isPowerOn ? Color.Gray : Color.LightGray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}
