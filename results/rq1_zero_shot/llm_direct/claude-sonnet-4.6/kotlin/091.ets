import { router } from '@kit.ArkUI';

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
        Button({ type: ButtonType.Circle }) {
          Text("☰")
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.White)

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
              .fontColor('#CCCCCC')
          }
        }
        .alignItems(HorizontalAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text("⚙")
            .fontSize(20)
            .fontColor(Color.Gray)
        }
        .width(44)
        .height(44)
        .backgroundColor(Color.White)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column() {
        // Temperature Control Circle
        Stack({ alignContent: Alignment.Center }) {
          // Decorative circle
          Circle()
            .width(280)
            .height(280)
            .fill(Color.White)
            .stroke('#EEEEEE')
            .strokeWidth(1)

          // Temperature display
          Column() {
            Text(`${this.targetTemp}°`)
              .fontSize(96)
              .fontWeight(FontWeight.Lighter)
              .fontColor(this.isPowerOn ? Color.Black : '#CCCCCC')

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Center)

          // Increase button
          if (this.isPowerOn) {
            Row() {
              Blank()
              Button({ type: ButtonType.Circle }) {
                Text("+")
                  .fontSize(20)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .backgroundColor('#F5F5F5')
              .onClick(() => {
                this.targetTemp++;
              })
            }
            .width(240)
            .justifyContent(FlexAlign.End)

            // Decrease button
            Row() {
              Button({ type: ButtonType.Circle }) {
                Text("−")
                  .fontSize(20)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .backgroundColor('#F5F5F5')
              .onClick(() => {
                this.targetTemp--;
              })
              Blank()
            }
            .width(240)
            .justifyContent(FlexAlign.Start)
          }
        }
        .width(280)
        .height(280)

        Blank().height(24)

        // Mode Selection
        Column() {
          Text("MODE")
            .fontSize(10)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })

          Row({ space: 12 }) {
            ModeButton({
              icon: "🏠",
              label: "Auto",
              isSelected: this.selectedMode === "Auto",
              enabled: this.isPowerOn,
              onClick: () => {
                this.selectedMode = "Auto";
              }
            })
            ModeButton({
              icon: "🔄",
              label: "Fan",
              isSelected: this.selectedMode === "Fan",
              enabled: this.isPowerOn,
              onClick: () => {
                this.selectedMode = "Fan";
              }
            })
            ModeButton({
              icon: "⭐",
              label: "Cool",
              isSelected: this.selectedMode === "Cool",
              enabled: this.isPowerOn,
              onClick: () => {
                this.selectedMode = "Cool";
              }
            })
          }
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')

        Blank().height(24)

        // Info Cards
        Row({ space: 16 }) {
          InfoCard({
            title: "Humidity",
            value: "45%",
            icon: "ℹ️"
          })
          InfoCard({
            title: "Energy",
            value: "12 kWh",
            icon: "↑"
          })
        }
        .width('100%')

        Blank().height(24)

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
              this.isPowerOn = isOn;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .margin({ bottom: 40 })
      }
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}

@Component
struct ModeButton {
  icon: string = "";
  label: string = "";
  isSelected: boolean = false;
  enabled: boolean = true;
  onClick: () => void = () => {};

  build() {
    Column() {
      Button({ type: ButtonType.Circle }) {
        Text(this.icon)
          .fontSize(20)
          .fontColor(
            this.isSelected && this.enabled
              ? Color.White
              : this.enabled ? Color.Black : '#CCCCCC'
          )
      }
      .width(60)
      .height(60)
      .backgroundColor(
        this.isSelected && this.enabled
          ? Color.Black
          : this.enabled ? Color.White : '#F5F5F5'
      )
      .border({
        width: 1,
        color: this.isSelected && this.enabled ? Color.Black : '#E0E0E0'
      })
      .enabled(this.enabled)
      .onClick(() => {
        this.onClick();
      })

      Blank().height(8)

      Text(this.label)
        .fontSize(10)
        .fontColor(this.enabled ? Color.Gray : '#CCCCCC')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCard {
  title: string = "";
  value: string = "";
  icon: string = "";

  build() {
    Column({ space: 8 }) {
      Text(this.icon)
        .fontSize(20)
        .fontColor(Color.Gray)

      Text(this.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
    .layoutWeight(1)
  }
}