import { Stack, Text, Button, Image, Column, Row, Circle, Border, Color, FontWeight, FontSize, Alignment, MainAxisAlignment, CrossAxisAlignment, EdgeInsets, BorderRadius, BorderStyle } from '@ohos.arkui';

@Entry
@Component
struct ContentView {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = "Cool";

  build() {
    Stack() {
      // Background
      Column() {
        // Top Bar
        TopBar({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        // Spacer
        Column().height(10)

        // Temperature Circle Control
        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: this.targetTemp,
          isPowerOn: this.isPowerOn
        })

        // Spacer
        Column().layoutWeight(1)

        // Mode Selection
        ModeSelection({
          selectedMode: this.selectedMode,
          isPowerOn: this.isPowerOn
        })

        // Spacer
        Column().layoutWeight(1)

        // Info Cards
        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        // Spacer
        Column().layoutWeight(1)

        // Master Power Switch
        PowerSwitch({ isPowerOn: this.isPowerOn })
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

// MARK: - Subcomponents

@Component
struct TopBar {
  @Prop isPowerOn: boolean;

  build() {
    Row() {
      Button() {
        Image($r('sys.symbol.menu'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Column() {
        Text("LIVING ROOM")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Gray)
          .letterSpacing(2)

        Text(this.isPowerOn ? "Active" : "Off")
          .fontSize(11)
          .fontColor(this.isPowerOn ? new Color(0x4C, 0xAF, 0x50) : Color.Gray)
      }

      Blank()

      Button() {
        Image($r('sys.symbol.gearshape_fill'))
          .width(24)
          .height(24)
          .fillColor(Color.Gray)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureControl {
  @Prop currentTemp: number;
  @Link targetTemp: number;
  @Prop isPowerOn: boolean;

  build() {
    Stack() {
      // Background Circle
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke(new Border({ width: 1, color: new Color(0xEE, 0xEE, 0xEE) }))

      // Text Content
      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : new Color(0xD3, 0xD3, 0xD3))

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }

      // Buttons
      if (this.isPowerOn) {
        Row() {
          // Decrease Button (Left)
          Button() {
            Image($r('sys.symbol.chevron_down'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(48)
          .height(48)
          .backgroundColor(new Color(0xF5, 0xF5, 0xF5))
          .borderRadius(24)
          .onClick(() => {
            this.targetTemp -= 1;
          })
          .margin({ left: 20 })

          Blank()

          // Increase Button (Right)
          Button() {
            Image($r('sys.symbol.plus'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(48)
          .height(48)
          .backgroundColor(new Color(0xF5, 0xF5, 0xF5))
          .borderRadius(24)
          .onClick(() => {
            this.targetTemp += 1;
          })
          .margin({ right: 20 })
        }
        .width(280)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
    }
    .width(280)
    .height(280)
  }
}

@Component
struct ModeSelection {
  @Link selectedMode: string;
  @Prop isPowerOn: boolean;

  build() {
    Column() {
      Text("MODE")
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Gray)

      Row() {
        ModeButton({
          iconName: 'sys.symbol.house_fill',
          label: "Auto",
          isSelected: this.selectedMode === "Auto",
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = "Auto" }
        })
        ModeButton({
          iconName: 'sys.symbol.arrow_clockwise',
          label: "Fan",
          isSelected: this.selectedMode === "Fan",
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = "Fan" }
        })
        ModeButton({
          iconName: 'sys.symbol.star_fill',
          label: "Cool",
          isSelected: this.selectedMode === "Cool",
          isEnabled: this.isPowerOn,
          action: () => { this.selectedMode = "Cool" }
        })
      }
      .margin({ top: 16 })
    }
  }
}

@Component
struct ModeButton {
  @Prop iconName: string;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop isEnabled: boolean;
  action: () => void;

  build() {
    Column() {
      Button() {
        Image($r(this.iconName))
          .width(24)
          .height(24)
          .fillColor(
            this.isSelected && this.isEnabled ? Color.White :
              (this.isEnabled ? Color.Black : new Color(0xD3, 0xD3, 0xD3))
          )
      }
      .width(60)
      .height(60)
      .backgroundColor(
        this.isSelected && this.isEnabled ? Color.Black : Color.White
      )
      .borderRadius(30)
      .border(
        !this.isSelected ? 
          new Border({ width: 1, color: new Color(0xE0, 0xE0, 0xE0) }) : 
          new Border({ width: 0, color: Color.Transparent })
      )
      .enabled(this.isEnabled)
      .onClick(this.action)

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? Color.Gray : new Color(0xD3, 0xD3, 0xD3))
        .margin({ top: 8 })
    }
  }
}

@Component
struct InfoCardsRow {
  build() {
    Row() {
      InfoCard({
        title: "Humidity",
        value: "45%",
        iconName: 'sys.symbol.info_circle_fill'
      })
      InfoCard({
        title: "Energy",
        value: "12 kWh",
        iconName: 'sys.symbol.chevron_up'
      })
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  @Prop title: string;
  @Prop value: string;
  @Prop iconName: string;

  build() {
    Column() {
      Image($r(this.iconName))
        .width(20)
        .height(20)
        .fillColor(Color.Gray)

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(new Color(0xF9, 0xF9, 0xF9))
    .borderRadius(16)
    .border(new Border({ width: 1, color: new Color(0xF0, 0xF0, 0xF0) }))
  }
}

@Component
struct PowerSwitch {
  @Link isPowerOn: boolean;

  build() {
    Row() {
      Column() {
        Text("Master Power")
          .fontSize(16)
          .fontWeight(FontWeight.Semibold)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? "System is running" : "System is off")
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.isPowerOn = isOn;
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(new Color(0xF9, 0xF9, 0xF9))
    .borderRadius(16)
  }
}