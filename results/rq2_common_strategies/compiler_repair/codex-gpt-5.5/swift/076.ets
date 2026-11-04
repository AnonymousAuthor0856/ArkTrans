class HomeColors {
  static background: string = '#F4F6F8'
  static cardPrimary: string = '#5E60CE'
  static black: string = '#000000'
  static white: string = '#FFFFFF'
  static selectedScene: string = '#212121'
  static inactiveIconBg: string = '#F0F0F0'
  static gray: string = '#808080'
  static lamp: string = '#FFC107'
  static thermostat: string = '#FF7043'
  static lock: string = '#4CAF50'
  static router: string = '#2196F3'
}

class DeviceInfo {
  name: string
  icon: string
  active: boolean
  accent: string

  constructor(name: string, icon: string, active: boolean, accent: string) {
    this.name = name
    this.icon = icon
    this.active = active
    this.accent = accent
  }
}

@Entry
@Component
struct Index {
  @State lampOn: boolean = true
  @State thermostatOn: boolean = true
  @State lockOn: boolean = false
  @State routerOn: boolean = true

  @Builder
  Header() {
    Row() {
      Column() {
        Text('Good Morning,')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(HomeColors.gray)
        Text('Alex Johnson')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(HomeColors.white)
        Text('User')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.black)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnergyCard() {
    Row() {
      Column() {
        Text('Energy Usage')
          .fontSize(14)
          .fontColor('#CCFFFFFF')
        Text('28.5 kWh')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.white)
        Text('Today')
          .fontSize(12)
          .fontColor('#99FFFFFF')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Stack() {
        Circle()
          .width(56)
          .height(56)
          .fill('#33FFFFFF')
        Text('Bell')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.white)
      }
      .width(56)
      .height(56)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(HomeColors.cardPrimary)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
  }

  @Builder
  SceneButton(text: string, selected: boolean) {
    Row({ space: 8 }) {
      Text(selected ? '*' : 'o')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(selected ? HomeColors.white : HomeColors.black)
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(selected ? HomeColors.white : HomeColors.black)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(selected ? HomeColors.selectedScene : HomeColors.white)
    .borderRadius(30)
  }

  @Builder
  DeviceCard(name: string, icon: string, isOn: boolean, accent: string, kind: number) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(isOn ? accent + '1A' : HomeColors.inactiveIconBg)
          Text(icon)
            .fontSize(11)
            .fontWeight(FontWeight.Bold)
            .fontColor(isOn ? accent : HomeColors.gray)
        }
        .width(40)
        .height(40)
        Blank()
          .layoutWeight(1)
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column({ space: 4 }) {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.black)
        Text(isOn ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(isOn ? accent : HomeColors.gray)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Row() {
        Blank()
          .layoutWeight(1)
        Toggle({ type: ToggleType.Switch, isOn: isOn })
          .onChange((value: boolean) => {
            if (kind === 0) {
              this.lampOn = value
            } else if (kind === 1) {
              this.thermostatOn = value
            } else if (kind === 2) {
              this.lockOn = value
            } else {
              this.routerOn = value
            }
          })
      }
      .width('100%')
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor(HomeColors.white)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })
  }

  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank()
            .height(16)

          this.Header()

          Blank()
            .height(32)

          Column() {
            this.EnergyCard()
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Blank()
            .height(32)

          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(HomeColors.black)
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank()
            .height(16)

          Scroll() {
            Row({ space: 12 }) {
              Blank()
                .width(12)
              this.SceneButton('Home', true)
              this.SceneButton('Away', false)
              this.SceneButton('Sleep', false)
              Blank()
                .width(12)
            }
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank()
            .height(32)

          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(HomeColors.black)
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank()
            .height(16)

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              this.DeviceCard('Smart Lamp', 'Lamp', this.lampOn, HomeColors.lamp, 0)
              this.DeviceCard('Thermostat', 'Heat', this.thermostatOn, HomeColors.thermostat, 1)
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              this.DeviceCard('Main Lock', 'Lock', this.lockOn, HomeColors.lock, 2)
              this.DeviceCard('Wi-Fi Router', 'WiFi', this.routerOn, HomeColors.router, 3)
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Blank()
            .height(24)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HomeColors.background)
  }
}
