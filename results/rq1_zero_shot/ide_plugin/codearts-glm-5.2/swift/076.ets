class ShColors {
  static readonly background: string = '#FFF4F6F8'
  static readonly energyCardBg: string = '#FF5E60CE'
  static readonly white80: string = '#CCFFFFFF'
  static readonly white60: string = '#99FFFFFF'
  static readonly white20: string = '#33FFFFFF'
  static readonly sceneSelected: string = '#FF212121'
  static readonly lampAccent: string = '#FFFFC107'
  static readonly lampAccent10: string = '#1AFFC107'
  static readonly thermostatAccent: string = '#FFFF7043'
  static readonly thermostatAccent10: string = '#1AFF7043'
  static readonly lockAccent: string = '#FF4CAF50'
  static readonly lockAccent10: string = '#1A4CAF50'
  static readonly routerAccent: string = '#FF2196F3'
  static readonly routerAccent10: string = '#1A2196F3'
  static readonly inactiveIconBg: string = '#FFF0F0F0'
  static readonly gray: string = '#FF808080'
  static readonly black: string = '#FF000000'
}

@Entry
@Component
struct Index {
  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank().height(16)

          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(ShColors.gray)
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(ShColors.black)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle({ width: 48, height: 48 })
                .fill('#FFFFFFFF')
              Text('◉')
                .fontSize(24)
                .fontColor(ShColors.black)
            }
          }
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          Column() {
            Row() {
              Column() {
                Text('Energy Usage')
                  .fontSize(14)
                  .fontColor(ShColors.white80)

                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFFFF')

                Text('Today')
                  .fontSize(12)
                  .fontColor(ShColors.white60)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Circle({ width: 56, height: 56 })
                  .fill(ShColors.white20)
                Text('🔔')
                  .fontSize(24)
              }
            }
            .padding(24)
          }
          .backgroundColor(ShColors.energyCardBg)
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(ShColors.black)
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Scroll() {
            Row() {
              SceneButton({ text: 'Home', icon: '⌂', isSelected: true })
              SceneButton({ text: 'Away', icon: '🔒', isSelected: false })
              SceneButton({ text: 'Sleep', icon: '★', isSelected: false })
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank().height(32)

          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(ShColors.black)
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Row() {
            Column() {
              DeviceCard({ name: 'Smart Lamp', icon: '★', isActive: true, accentColor: ShColors.lampAccent, accentColor10: ShColors.lampAccent10 })
              DeviceCard({ name: 'Thermostat', icon: '☰', isActive: true, accentColor: ShColors.thermostatAccent, accentColor10: ShColors.thermostatAccent10 })
            }
            .layoutWeight(1)

            Column() {
              DeviceCard({ name: 'Main Lock', icon: '🔒', isActive: false, accentColor: ShColors.lockAccent, accentColor10: ShColors.lockAccent10 })
              DeviceCard({ name: 'Wi-Fi Router', icon: '⚙', isActive: true, accentColor: ShColors.routerAccent, accentColor10: ShColors.routerAccent10 })
            }
            .layoutWeight(1)
          }
          .padding({ left: 24, right: 24 })

          Blank().height(24)
        }
        .padding({ top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
    }
    .backgroundColor(ShColors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct SceneButton {
  @Prop text: string = ''
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Row() {
      Text(this.icon)
        .fontSize(18)
        .fontColor(this.isSelected ? '#FFFFFFFF' : ShColors.black)

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFFFF' : ShColors.black)
        .margin({ left: 8 })
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? ShColors.sceneSelected : '#FFFFFFFF')
    .borderRadius(30)
    .margin({ right: 12 })
  }
}

@Component
struct DeviceCard {
  @Prop name: string = ''
  @Prop icon: string = ''
  @Prop isActive: boolean = false
  @Prop accentColor: string = '#FFFFFF'
  @Prop accentColor10: string = '#1AFFFFFF'
  @State switchState: boolean = false

  aboutToAppear() {
    this.switchState = this.isActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 40, height: 40 })
            .fill(this.switchState ? this.accentColor10 : ShColors.inactiveIconBg)
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.switchState ? this.accentColor : ShColors.gray)
        }
        Blank()
      }

      Blank()

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ShColors.black)

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : ShColors.gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .scale({ x: 0.8, y: 0.8 })
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
      }
    }
    .padding(16)
    .height(174)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
    .margin({ bottom: 16 })
  }
}