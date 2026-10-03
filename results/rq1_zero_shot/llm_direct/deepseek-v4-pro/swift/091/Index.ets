// ThermostatApp.ets
@Entry
@Component
struct ThermostatApp {
  build() {
    ThermostatScreen()
  }
}

@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Column() {
      TopBar({ isPowerOn: this.isPowerOn })
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })

      Blank().height(10)

      TemperatureControl({
        currentTemp: this.currentTemp,
        targetTemp: this.targetTemp,
        isPowerOn: this.isPowerOn,
        onTargetTempChange: (newTemp: number) => {
          this.targetTemp = newTemp;
        }
      })

      Blank()

      ModeSelection({
        selectedMode: this.selectedMode,
        isPowerOn: this.isPowerOn,
        onModeChange: (mode: string) => {
          this.selectedMode = mode;
        }
      })

      Blank()

      InfoCardsRow()
        .padding({ left: 24, right: 24 })

      Blank()

      PowerSwitch({
        isPowerOn: this.isPowerOn,
        onToggle: (value: boolean) => {
          this.isPowerOn = value;
        }
      })
        .padding({ bottom: 40, left: 24, right: 24 })
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
        // Menu action
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .backgroundImage($r('sys.media.ohos_ic_public_menu'))
      .backgroundImageSize({ width: 24, height: 24 })

      Blank()

      Column({ space: 2 }) {
        Text('LIVING ROOM')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(Color.Gray)

        Text(this.isPowerOn ? 'Active' : 'Off')
          .fontSize(11)
          .fontColor(this.isPowerOn ? '#4CAF50' : Color.Gray)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Button() {
        // Settings action
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .backgroundImage($r('sys.media.ohos_ic_public_settings_filled'))
      .backgroundImageSize({ width: 24, height: 24 })
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
  onTargetTempChange: (newTemp: number) => void = () => {};

  build() {
    Stack() {
      // Background circle
      Circle()
        .width(280)
        .height(280)
        .fill(Color.White)
        .stroke('#EEEEEE')
        .strokeWidth(1)

      // Text content
      Column({ space: 4 }) {
        Text(`${this.targetTemp}°`)
          .fontSize(96)
          .fontWeight(FontWeight.Light)
          .fontColor(this.isPowerOn ? Color.Black : '#D4D4D4')

        Text(`CURRENT: ${this.currentTemp}°`)
          .fontSize(14)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Center)

      // Buttons
      if (this.isPowerOn) {
        Row() {
          Button() {
            this.onTargetTempChange(this.targetTemp - 1);
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .backgroundImage($r('sys.media.ohos_ic_public_arrow_down'))
          .backgroundImageSize({ width: 24, height: 24 })

          Blank()

          Button() {
            this.onTargetTempChange(this.targetTemp + 1);
          }
          .width(48)
          .height(48)
          .backgroundColor('#F5F5F5')
          .borderRadius(24)
          .backgroundImage($r('sys.media.ohos_ic_public_add'))
          .backgroundImageSize({ width: 24, height: 24 })
        }
        .width(280)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ left: 20, right: 20 })
      }
    }
    .width(280)
    .height(280)
    .alignContent(Alignment.Center)
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
        .fontColor(Color.Gray)

      Row({ space: 12 }) {
        ModeButton({
          icon: $r('sys.media.ohos_ic_public_house'),
          label: 'Auto',
          isSelected: this.selectedMode === 'Auto',
          isEnabled: this.isPowerOn,
          onPress: () => {
            this.onModeChange('Auto');
          }
        })

        ModeButton({
          icon: $r('sys.media.ohos_ic_public_refresh'),
          label: 'Fan',
          isSelected: this.selectedMode === 'Fan',
          isEnabled: this.isPowerOn,
          onPress: () => {
            this.onModeChange('Fan');
          }
        })

        ModeButton({
          icon: $r('sys.media.ohos_ic_public_star_filled'),
          label: 'Cool',
          isSelected: this.selectedMode === 'Cool',
          isEnabled: this.isPowerOn,
          onPress: () => {
            this.onModeChange('Cool');
          }
        })
      }
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct ModeButton {
  @Prop icon: Resource;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop isEnabled: boolean;
  onPress: () => void = () => {};

  build() {
    Column({ space: 8 }) {
      Button() {
        this.onPress();
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(this.isSelected && this.isEnabled ? Color.Black : Color.White)
      .backgroundImage(this.icon)
      .backgroundImageSize({ width: 24, height: 24 })
      .enabled(this.isEnabled)
      .border({
        width: this.isSelected ? 0 : 1,
        color: this.isSelected ? Color.Transparent : '#E0E0E0',
        radius: 30
      })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? Color.Gray : '#D4D4D4')
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
        icon: $r('sys.media.ohos_ic_public_info_filled')
      })

      InfoCard({
        title: 'Energy',
        value: '12 kWh',
        icon: $r('sys.media.ohos_ic_public_arrow_up')
      })
    }
    .width('100%')
  }
}

@Component
struct InfoCard {
  @Prop title: string;
  @Prop value: string;
  @Prop icon: Resource;

  build() {
    Column({ space: 8 }) {
      Image(this.icon)
        .width(20)
        .height(20)
        .fillColor(Color.Gray)

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
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
  @Link isPowerOn: boolean;
  onToggle: (value: boolean) => void = () => {};

  build() {
    Row() {
      Column({ space: 0 }) {
        Text('Master Power')
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(Color.Black)

        Text(this.isPowerOn ? 'System is running' : 'System is off')
          .fontSize(12)
          .fontColor(Color.Gray)
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
    .alignItems(VerticalAlign.Center)
  }
}