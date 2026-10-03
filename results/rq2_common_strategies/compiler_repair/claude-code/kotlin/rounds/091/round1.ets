@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = "Cool";

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('sys.media.ohos_ic_public_menu'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
          .padding(8)

        Column() {
          Text("LIVING ROOM")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
            .letterSpacing(2)

          Text(this.isPowerOn ? "Active" : "Off")
            .fontSize(11)
            .fontColor(this.isPowerOn ? "#4CAF50" : Color.LightGray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
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
              .fontColor(this.isPowerOn ? Color.Black : Color.LightGray)

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)

          // Increase button (right side)
          if (this.isPowerOn) {
            Row() {
              Blank()
              Button() {
                Image($r('sys.media.ohos_ic_public_add'))
                  .width(24)
                  .height(24)
                  .fillColor(Color.Black)
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
                Image($r('sys.media.ohos_ic_public_minus'))
                  .width(24)
                  .height(24)
                  .fillColor(Color.Black)
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
            .fontColor(Color.Gray)
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
            Image($r('sys.media.ohos_ic_public_info'))
              .width(20)
              .height(20)
              .fillColor(Color.Gray)

            Text("45%")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8 })

            Text("Humidity")
              .fontSize(12)
              .fontColor(Color.Gray)
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
            Image($r('sys.media.ohos_ic_public_arrow_up'))
              .width(20)
              .height(20)
              .fillColor(Color.Gray)

            Text("12 kWh")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8 })

            Text("Energy")
              .fontSize(12)
              .fontColor(Color.Gray)
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
              .fontColor(Color.Gray)
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
          Image($r('sys.media.ohos_ic_public_home'))
            .width(24)
            .height(24)
            .fillColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : Color.LightGray))
        } else if (iconKey == "fan") {
          Text("≋")
            .fontSize(24)
            .fontColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : Color.LightGray))
        } else {
          Image($r('sys.media.ohos_ic_public_star'))
            .width(24)
            .height(24)
            .fillColor(isSelected && this.isPowerOn ? Color.White : (this.isPowerOn ? Color.Black : Color.LightGray))
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
        .fontColor(this.isPowerOn ? Color.Gray : Color.LightGray)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}
