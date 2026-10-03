@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = "Cool";

  private lightGrayColor: string = "#D3D3D3";
  private grayColor: string = "#888888";

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("☰")
          .fontSize(24)
          .fontColor(this.grayColor)
          .padding(8)

        Column() {
          Text("LIVING ROOM")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.grayColor)
            .letterSpacing(2)

          Text(this.isPowerOn ? "Active" : "Off")
            .fontSize(11)
            .fontColor(this.isPowerOn ? "#4CAF50" : this.lightGrayColor)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)

        Text("⚙")
          .fontSize(24)
          .fontColor(this.grayColor)
          .padding(8)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      // Main Content
      Column() {
        // Temperature Circle
        Stack() {
          // Decorative circle background
          Row()
            .width(280)
            .height(280)
            .borderRadius(140)
            .backgroundColor(Color.White)
            .border({ width: 1, color: '#EEEEEE' })

          // Temperature text
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? Color.Black : this.lightGrayColor)

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(this.grayColor)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)

          // Increase button (right side)
          if (this.isPowerOn) {
            Row() {
              Blank()
              Button() {
                Text("+")
                  .fontSize(28)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#F5F5F5')
              .margin({ right: 20 })
              .onClick(() => {
                this.targetTemp++;
              })
            }
            .width(280)
            .height(280)
          }

          // Decrease button (left side)
          if (this.isPowerOn) {
            Row() {
              Button() {
                Text("-")
                  .fontSize(28)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .borderRadius(24)
              .backgroundColor('#F5F5F5')
              .margin({ left: 20 })
              .onClick(() => {
                this.targetTemp--;
              })
              Blank()
            }
            .width(280)
            .height(280)
          }
        }
        .width(280)
        .height(280)
        .margin({ top: 10 })

        // Mode Selection
        Column() {
          Text("MODE")
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.grayColor)
            .margin({ bottom: 16 })

          Row() {
            this.ModeButtonItem("home", "Auto", this.selectedMode == "Auto")
            this.ModeButtonItem("fan", "Fan", this.selectedMode == "Fan")
            this.ModeButtonItem("star", "Cool", this.selectedMode == "Cool")
          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .margin({ top: 24 })

        // Info Cards
        Row() {
          Column() {
            Text("ℹ")
              .fontSize(20)
              .fontColor(this.grayColor)

            Text("45%")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8 })

            Text("Humidity")
              .fontSize(12)
              .fontColor(this.grayColor)
              .margin({ top: 8 })
          }
          .width(0)
          .layoutWeight(1)
          .padding(16)
          .backgroundColor('#F9F9F9')
          .borderRadius(16)
          .border({ width: 1, color: '#F0F0F0' })
          .alignItems(HorizontalAlign.Start)

          Column() {
            Text("↑")
              .fontSize(20)
              .fontColor(this.grayColor)

            Text("12 kWh")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8 })

            Text("Energy")
              .fontSize(12)
              .fontColor(this.grayColor)
              .margin({ top: 8 })
          }
          .width(0)
          .layoutWeight(1)
          .padding(16)
          .backgroundColor('#F9F9F9')
          .borderRadius(16)
          .border({ width: 1, color: '#F0F0F0' })
          .alignItems(HorizontalAlign.Start)
          .margin({ left: 16 })
        }
        .width('100%')
        .margin({ top: 24 })

        // Power Switch
        Row() {
          Column() {
            Text("Master Power")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)

            Text(this.isPowerOn ? "System is running" : "System is off")
              .fontSize(12)
              .fontColor(this.grayColor)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
            .onChange((isOn: boolean) => {
              this.isPowerOn = isOn;
            })
            .selectedColor(Color.Black)
            .switchPointColor(Color.White)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .margin({ top: 24, bottom: 40 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  ModeButtonItem(iconKey: string, label: string, isSelected: boolean) {
    Column() {
      Button() {
        if (iconKey == "home") {
          Text("⌂")
            .fontSize(24)
            .fontColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : this.lightGrayColor))
        } else if (iconKey == "fan") {
          Text("≋")
            .fontSize(24)
            .fontColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : this.lightGrayColor))
        } else {
          Text("★")
            .fontSize(24)
            .fontColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : this.lightGrayColor))
        }
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(isSelected && this.isPowerOn ? Color.Black : (this.isPowerOn ? Color.White : '#F5F5F5'))
      .border({
        width: isSelected ? 0 : 1,
        color: isSelected && this.isPowerOn ? Color.Black : '#E0E0E0'
      })
      .enabled(this.isPowerOn)
      .onClick(() => {
        this.selectedMode = label;
      })

      Text(label)
        .fontSize(11)
        .fontColor(this.isPowerOn ? this.grayColor : this.lightGrayColor)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}
