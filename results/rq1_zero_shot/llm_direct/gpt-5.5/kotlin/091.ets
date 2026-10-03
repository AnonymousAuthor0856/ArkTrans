import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct ThermostatScreen {
  @State currentTemp: number = 22;
  @State targetTemp: number = 24;
  @State isPowerOn: boolean = true;
  @State selectedMode: string = 'Cool';

  aboutToAppear(): void {
    const context = getContext(this) as common.UIAbilityContext;
    window.getLastWindow(context).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
    }).catch(() => {
    });
  }

  build() {
    Column() {
      Row() {
        Button({ type: ButtonType.Circle }) {
          Text('☰')
            .fontSize(28)
            .fontColor(Color.Gray)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .stateEffect(false)

        Column() {
          Text('LIVING ROOM')
            .fontSize(13)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(2)

          Text(this.isPowerOn ? 'Active' : 'Off')
            .fontSize(11)
            .fontColor(this.isPowerOn ? '#4CAF50' : Color.LightGray)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Center)

        Button({ type: ButtonType.Circle }) {
          Text('⚙')
            .fontSize(25)
            .fontColor(Color.Gray)
        }
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .stateEffect(false)
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 24, bottom: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Blank()
          .height(10)

        Stack({ alignContent: Alignment.Center }) {
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
              .fontColor(this.isPowerOn ? Color.Black : Color.LightGray)

            Text(`CURRENT: ${this.currentTemp}°`)
              .fontSize(14)
              .fontColor(Color.Gray)
          }
          .alignItems(HorizontalAlign.Center)

          if (this.isPowerOn) {
            Row() {
              Button({ type: ButtonType.Circle }) {
                Text('⌄')
                  .fontSize(28)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .backgroundColor('#F5F5F5')
              .onClick(() => {
                this.targetTemp--;
              })

              Blank()
                .layoutWeight(1)

              Button({ type: ButtonType.Circle }) {
                Text('+')
                  .fontSize(28)
                  .fontColor(Color.Black)
              }
              .width(48)
              .height(48)
              .backgroundColor('#F5F5F5')
              .onClick(() => {
                this.targetTemp++;
              })
            }
            .width('100%')
            .height('100%')
            .padding(20)
            .alignItems(VerticalAlign.Center)
          }
        }
        .width(280)
        .height(280)

        Column() {
          Text('MODE')
            .fontSize(11)
            .fontColor(Color.Gray)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 16 })

          Row() {
            ModeButton({
              icon: '⌂',
              label: 'Auto',
              isSelected: this.selectedMode === 'Auto',
              enabled: this.isPowerOn,
              onClick: () => {
                this.selectedMode = 'Auto';
              }
            })

            Blank()
              .width(12)

            ModeButton({
              icon: '↻',
              label: 'Fan',
              isSelected: this.selectedMode === 'Fan',
              enabled: this.isPowerOn,
              onClick: () => {
                this.selectedMode = 'Fan';
              }
            })

            Blank()
              .width(12)

            ModeButton({
              icon: '★',
              label: 'Cool',
              isSelected: this.selectedMode === 'Cool',
              enabled: this.isPowerOn,
              onClick: () => {
                this.selectedMode = 'Cool';
              }
            })
          }
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)

        Row() {
          InfoCard({
            title: 'Humidity',
            value: '45%',
            icon: 'i'
          })
            .layoutWeight(1)

          Blank()
            .width(16)

          InfoCard({
            title: 'Energy',
            value: '12 kWh',
            icon: '↑'
          })
            .layoutWeight(1)
        }
        .width('100%')

        Row() {
          Column() {
            Text('Master Power')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)

            Text(this.isPowerOn ? 'System is running' : 'System is off')
              .fontSize(12)
              .fontColor(Color.Gray)
              .margin({ top: 3 })
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
        .padding({ left: 20, right: 20, top: 16, bottom: 16 })
        .margin({ bottom: 40 })
        .backgroundColor('#F9F9F9')
        .borderRadius(16)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
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
}

@Component
struct ModeButton {
  @Prop icon: string;
  @Prop label: string;
  @Prop isSelected: boolean;
  @Prop enabled: boolean;
  onClick: () => void = () => {
  };

  build() {
    Column() {
      Button({ type: ButtonType.Circle }) {
        Text(this.icon)
          .fontSize(24)
          .fontColor(!this.enabled ? Color.LightGray : this.isSelected ? Color.White : Color.Black)
      }
      .width(60)
      .height(60)
      .padding(0)
      .enabled(this.enabled)
      .backgroundColor(!this.enabled ? '#F5F5F5' : this.isSelected ? Color.Black : Color.White)
      .border({
        width: this.isSelected ? 0 : 1,
        color: this.isSelected ? Color.Black : '#E0E0E0',
        radius: 30
      })
      .onClick(() => {
        if (this.enabled) {
          this.onClick();
        }
      })

      Blank()
        .height(8)

      Text(this.label)
        .fontSize(11)
        .fontColor(this.enabled ? Color.Gray : Color.LightGray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct InfoCard {
  @Prop title: string;
  @Prop value: string;
  @Prop icon: string;

  build() {
    Column() {
      Text(this.icon)
        .fontSize(20)
        .fontColor(Color.Gray)

      Text(this.value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ top: 8 })

      Text(this.title)
        .fontSize(12)
        .fontColor(Color.Gray)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#F9F9F9')
    .border({
      width: 1,
      color: '#F0F0F0',
      radius: 16
    })
  }
}