class DeviceInfo {
  name: string;
  icon: string;
  isActive: boolean;
  accentColor: string;

  constructor(name: string, icon: string, isActive: boolean, accentColor: string) {
    this.name = name;
    this.icon = icon;
    this.isActive = isActive;
    this.accentColor = accentColor;
  }
}

@Entry
@Component
struct SmartHomeDashboard {
  @State private lampOn: boolean = true;
  @State private thermostatOn: boolean = true;
  @State private lockOn: boolean = false;
  @State private routerOn: boolean = true;

  @Builder
  private SceneButton(text: string, icon: string, isSelected: boolean) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(18)
        .fontColor(isSelected ? Color.White : Color.Black)
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }

  @Builder
  private DeviceCard(name: string, icon: string, switchState: boolean, accentColor: string, key: string) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(switchState ? `${accentColor}1A` : '#F0F0F0')
          Text(icon)
            .fontSize(22)
            .fontColor(switchState ? accentColor : '#808080')
        }
        .width(40)
        .height(40)
        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(switchState ? accentColor : '#808080')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: switchState })
          .selectedColor(accentColor)
          .scale({ x: 0.8, y: 0.8 })
          .onChange((isOn: boolean) => {
            if (key === 'lamp') {
              this.lampOn = isOn;
            } else if (key === 'thermostat') {
              this.thermostatOn = isOn;
            } else if (key === 'lock') {
              this.lockOn = isOn;
            } else {
              this.routerOn = isOn;
            }
          })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 })
  }

  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          Blank().height(16)

          Row() {
            Column({ space: 0 }) {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#808080')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .alignItems(HorizontalAlign.Start)
            Blank()
            Stack() {
              Circle()
                .width(48)
                .height(48)
                .fill(Color.White)
              Text('👤')
                .fontSize(22)
                .fontColor(Color.Black)
            }
            .width(48)
            .height(48)
          }
          .padding({ left: 24, right: 24 })
          .width('100%')

          Blank().height(32)

          Row() {
            Column({ space: 0 }) {
              Text('Energy Usage')
                .fontSize(14)
                .fontColor('#FFFFFFCC')
              Text('28.5 kWh')
                .fontSize(32)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Text('Today')
                .fontSize(12)
                .fontColor('#FFFFFF99')
            }
            .alignItems(HorizontalAlign.Start)
            Blank()
            Stack() {
              Circle()
                .width(56)
                .height(56)
                .fill('#FFFFFF33')
              Text('🔔')
                .fontSize(22)
                .fontColor(Color.White)
            }
          }
          .padding(24)
          .width('100%')
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#0000001A', offsetX: 0, offsetY: 4 })
          .margin({ left: 24, right: 24 })

          Blank().height(32)

          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .padding({ left: 24, right: 24 })
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          Scroll() {
            Row({ space: 12 }) {
              Blank().width(12)
              this.SceneButton('Home', '⌂', true)
              this.SceneButton('Away', '🔒', false)
              this.SceneButton('Sleep', '★', false)
              Blank().width(12)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(32)

          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .padding({ left: 24, right: 24 })
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              this.DeviceCard('Smart Lamp', '★', this.lampOn, '#FFC107', 'lamp')
              this.DeviceCard('Thermostat', '≡', this.thermostatOn, '#FF7043', 'thermostat')
            }
            .layoutWeight(1)
            Column({ space: 16 }) {
              this.DeviceCard('Main Lock', '🔒', this.lockOn, '#4CAF50', 'lock')
              this.DeviceCard('Wi-Fi Router', '⚙', this.routerOn, '#2196F3', 'router')
            }
            .layoutWeight(1)
          }
          .padding({ left: 24, right: 24 })
          .width('100%')

          Blank().height(24)
        }
        .padding({ top: 24, bottom: 24 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}
