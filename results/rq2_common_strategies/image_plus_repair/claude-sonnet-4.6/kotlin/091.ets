import { router } from '@kit.ArkUI';

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  build() {
    Column() {
      // Top Bar
      Row() {
        Button() {
          Column() {
            Divider().width(20).height(2).backgroundColor('#999999').margin({ bottom: 4 })
            Divider().width(20).height(2).backgroundColor('#999999').margin({ bottom: 4 })
            Divider().width(20).height(2).backgroundColor('#999999')
          }
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .borderRadius(20)

        Column() {
          Text('LIVING ROOM')
            .fontSize(12)
            .fontColor('#999999')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)
          if (this.isPowerOn) {
            Text('Active')
              .fontSize(11)
              .fontColor('#4CAF50')
          } else {
            Text('Off')
              .fontSize(11)
              .fontColor('#CCCCCC')
          }
        }
        .alignItems(HorizontalAlign.Center)

        Button() {
          Text('⚙')
            .fontSize(20)
            .fontColor('#999999')
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .borderRadius(20)
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

        // Temperature display
        Column() {
          Text(`${this.targetTemp}°`)
            .fontSize(96)
            .fontWeight(FontWeight.Lighter)
            .fontColor(this.isPowerOn ? Color.Black : '#CCCCCC')
          Text(`CURRENT: ${this.currentTemp}°`)
            .fontSize(14)
            .fontColor('#999999')
        }
        .alignItems(HorizontalAlign.Center)

        // Decrease button (left)
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
            .onClick(() => {
              this.targetTemp--;
            })
          }
          .width(280)
          .padding({ left: 20 })
          .justifyContent(FlexAlign.Start)
        }

        // Increase button (right)
        if (this.isPowerOn) {
          Row() {
            Button() {
              Text('+')
                .fontSize(24)
                .fontColor(Color.Black)
            }
            .width(48)
            .height(48)
            .borderRadius(24)
            .backgroundColor('#F5F5F5')
            .onClick(() => {
              this.targetTemp++;
            })
          }
          .width(280)
          .padding({ right: 20 })
          .justifyContent(FlexAlign.End)
        }
      }
      .width(280)
      .height(280)
      .margin({ top: 10, bottom: 20 })

      // Mode Selection
      Column() {
        Text('MODE')
          .fontSize(11)
          .fontColor('#999999')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 16 })

        Row({ space: 12 }) {
          ModeButtonComponent({
            label: 'Auto',
            iconText: '⌂',
            isSelected: this.selectedMode === 'Auto',
            isEnabled: this.isPowerOn,
            onModeClick: () => {
              this.selectedMode = 'Auto';
            }
          })
          ModeButtonComponent({
            label: 'Fan',
            iconText: '↺',
            isSelected: this.selectedMode === 'Fan',
            isEnabled: this.isPowerOn,
            onModeClick: () => {
              this.selectedMode = 'Fan';
            }
          })
          ModeButtonComponent({
            label: 'Cool',
            iconText: '★',
            isSelected: this.selectedMode === 'Cool',
            isEnabled: this.isPowerOn,
            onModeClick: () => {
              this.selectedMode = 'Cool';
            }
          })
        }
      }
      .alignItems(HorizontalAlign.Center)
      .margin({ bottom: 20 })

      // Info Cards
      Row({ space: 16 }) {
        InfoCardComponent({
          title: 'Humidity',
          value: '45%',
          iconText: 'ℹ'
        })
        InfoCardComponent({
          title: 'Energy',
          value: '12 kWh',
          iconText: '∧'
        })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ bottom: 20 })

      // Power Switch
      Row() {
        Column() {
          Text('Master Power')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
          Text(this.isPowerOn ? 'System is running' : 'System is off')
            .fontSize(12)
            .fontColor('#999999')
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
      .padding({ left: 24, right: 24 })
      .margin({ bottom: 40 })
      .backgroundColor('#F9F9F9')
      .borderRadius(16)
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .margin({ left: 24, right: 24, bottom: 40 })
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
  label: string = '';
  iconText: string = '';
  isSelected: boolean = false;
  isEnabled: boolean = true;
  onModeClick: () => void = () => {};

  build() {
    Column() {
      Button() {
        Text(this.iconText)
          .fontSize(22)
          .fontColor(
            this.isSelected && this.isEnabled ? Color.White :
              (this.isEnabled ? Color.Black : '#CCCCCC')
          )
      }
      .width(60)
      .height(60)
      .borderRadius(30)
      .backgroundColor(
        this.isSelected && this.isEnabled ? Color.Black :
          (this.isEnabled ? Color.White : '#F5F5F5')
      )
      .border({
        width: this.isSelected && this.isEnabled ? 0 : 1,
        color: this.isSelected && this.isEnabled ? Color.Black : '#E0E0E0'
      })
      .onClick(() => {
        if (this.isEnabled) {
          this.onModeClick();
        }
      })

      Text(this.label)
        .fontSize(11)
        .fontColor(this.isEnabled ? '#999999' : '#CCCCCC')
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCardComponent {
  title: string = '';
  value: string = '';
  iconText: string = '';

  build() {
    Column({ space: 8 }) {
      Text(this.iconText)
        .fontSize(18)
        .fontColor('#999999')
        .width(20)
        .height(20)
        .textAlign(TextAlign.Center)

      Text(this.value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Text(this.title)
        .fontSize(12)
        .fontColor('#999999')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#F0F0F0' })
    .layoutWeight(1)
  }
}