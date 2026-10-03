import { router } from '@kit.ArkUI';

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        TopBar({ isPowerOn: this.isPowerOn })
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        Blank().height(10)

        // Temperature Circle Control
        TemperatureControl({
          currentTemp: this.currentTemp,
          targetTemp: this.targetTemp,
          isPowerOn: this.isPowerOn,
          onDecrease: () => {
            this.targetTemp -= 1;
          },
          onIncrease: () => {
            this.targetTemp += 1;
          }
        })

        Blank()

        // Mode Selection
        ModeSelection({
          selectedMode: this.selectedMode,
          isPowerOn: this.isPowerOn,
          onModeChange: (mode: string) => {
            this.selectedMode = mode;
          }
        })

        Blank()

        // Info Cards
        InfoCardsRow()
          .padding({ left: 24, right: 24 })

        Blank()

        // Master Power Switch
        PowerSwitch({
          isPowerOn: this.isPowerOn,
          onToggle: (val: boolean) => {
            this.isPowerOn = val;
          }
        })
          .padding({ bottom: 40, left: 24, right: 24 })
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
  @Prop isPowerOn: boolean;

  build() {
    Row() {
      Button() {
        Text('☰')
          .fontSize(24)
          .fontColor('#9E9E9E')
      }
      .backgroundColor(Color.Transparent)
      .borderWidth(0)

      Blank()

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor('#9E9E9E')

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : '#9E9E9E')
      }

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#9E9E9E')
      }
      .backgroundColor(Color.Transparent)
      .borderWidth(0)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct TemperatureControl {
  @Prop currentTemp: number;
  @Prop targetTemp: number;
  @Prop isPowerOn: boolean;
  onDecrease: () => void = () => {};
  onIncrease: () => void = () => {};

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Background Circle
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke('#EEEEEE', 1)

      // Text Content
      Column() {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.isPowerOn ? Color.Black : '#D4D4D4')

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Center)

      // Buttons
      if (this.isPowerOn) {
        Row() {
          Button() {
            Text('∨')
              .fontSize(20)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .margin({ left: 20 })
          .onClick(() => {
            this.onDecrease();
          })

          Blank()

          Button() {
            Text('+')
              .fontSize(24)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor('#F5F5F5')
          .margin({ right: 20 })
          .onClick(() => {
            this.onIncrease();
          })
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
  @Prop selectedMode: string;
  @Prop isPowerOn: boolean;
  onModeChange: (mode: string) => void = () => {};

  build() {
    Column({ space: 16 }) {
      Text('MODE')
        .fontSize(11)
        .fontWeight(FontWeight.Bold)
        .fontColor('#9E9E9E')

      Row({ space: 12 }) {
        ModeButton({
          icon: '🏠',
          label: 'Auto',
          isSelected: this.selectedMode === 'Auto',
          isEnabled: this.isPowerOn,
          action: () => {
            this.onModeChange('Auto');
          }
        })

        ModeButton({
          icon: '↻',
          label: 'Fan',
          isSelected: this.selectedMode === 'Fan',
          isEnabled: this.isPowerOn,
          action: () => {
            this.onModeChange('Fan');
          }
        })

        ModeButton({
          icon: '★',
          label: 'Cool',
          isSelected: this.selectedMode === 'Cool',
          isEnabled: this.isPowerOn,
          action: () => {
            this.onModeChange('Cool');
          }
        })
      }
      .justifyContent(FlexAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ModeButton {
  @Prop icon: string;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop isEnabled: boolean;
  action: () => void = () => {};

  build() {
    Column({ space: 8 }) {
      Button() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(
            this.isSelected && this.isEnabled
              ? Color.White
              : (this.isEnabled ? Color.Black : '#D4D4D4')
          )
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(
        this.isSelected && this.isEnabled ? Color.Black : Color.White
      )
      .borderWidth(this.isSelected ? 0 : 1)
      .borderColor('#E0E0E0')
      .enabled(this.isEnabled)
      .onClick(() => {
        this.action();
      })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? '#9E9E9E' : '#D4D4D4')
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
        icon: 'ℹ'
      })

      InfoCard({
        title: 'Energy',
        value: '12 kWh',
        icon: '↑'
      })
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  @Prop title: string;
  @Prop value: string;
  @Prop icon: string;

  build() {
    Column({ space: 8 }) {
      Text(this.icon)
        .fontSize(20)
        .fontColor('#9E9E9E')

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.title)
        .fontSize(12)
        .fontColor('#9E9E9E')
    }
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .borderWidth(1)
    .borderColor('#F0F0F0')
  }
}

@Component
struct PowerSwitch {
  @Prop isPowerOn: boolean;
  onToggle: (val: boolean) => void = () => {};

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor('#9E9E9E')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.onToggle(isOn);
        })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}