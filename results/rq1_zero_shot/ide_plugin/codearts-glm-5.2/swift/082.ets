class ShColors {
  static readonly primary: string = '#FF4A6572'
  static readonly background: string = '#FFF5F6F8'
  static readonly surface: string = '#FFFFFFFF'
  static readonly primary10: string = '#1A4A6572'
  static readonly primary30: string = '#4D4A6572'
  static readonly white20: string = '#33FFFFFF'
  static readonly white40: string = '#66FFFFFF'
  static readonly white70: string = '#B3FFFFFF'
  static readonly inactiveIconBg: string = '#FFF0F0F0'
  static readonly gray: string = '#FF808080'
  static readonly black: string = '#FF000000'
  static readonly tempBg: string = '#FFE3F2FD'
  static readonly tempText: string = '#FF1565C0'
  static readonly tempText80: string = '#CC1565C0'
  static readonly tempText70: string = '#B31565C0'
  static readonly humBg: string = '#FFE8F5E9'
  static readonly humText: string = '#FF2E7D32'
  static readonly humText80: string = '#CC2E7D32'
  static readonly humText70: string = '#B32E7D32'
}

class DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.name = name
    this.status = status
    this.icon = icon
    this.isActive = isActive
  }
}

@Entry
@Component
struct Index {
  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '⌂', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '★', false),
    new DeviceItem('Router', 'Online', '⊙', true),
    new DeviceItem('Kitchen', 'All Off', 'ⓘ', false),
    new DeviceItem('Corridor', 'Motion Detected', '🔔', true),
  ]

  build() {
    Stack() {
      Column() {
        Scroll() {
          Column() {
            Blank().height(24)

            Row() {
              Column() {
                Text('Welcome Home,')
                  .fontSize(16)
                  .fontColor(ShColors.gray)
                Text('Alex Johnson')
                  .fontSize(28)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(ShColors.black)
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Circle({ width: 48, height: 48 })
                  .fill(ShColors.primary10)
                Text('◉')
                  .fontSize(32)
                  .fontColor(ShColors.primary)
              }
            }
            .padding({ left: 24, right: 24 })

            Blank().height(32)

            Row() {
              EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: ShColors.tempBg, textColor: ShColors.tempText, textColor80: ShColors.tempText80, textColor70: ShColors.tempText70 })
              EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: ShColors.humBg, textColor: ShColors.humText, textColor80: ShColors.humText80, textColor70: ShColors.humText70 })
            }
            .padding({ left: 24, right: 24 })

            Blank().height(32)

            Column() {
              Text('My Devices')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor(ShColors.black)

              Row() {
                DeviceCard({ devName: this.devices[0].name, devStatus: this.devices[0].status, devIcon: this.devices[0].icon, devIsActive: this.devices[0].isActive })
                DeviceCard({ devName: this.devices[1].name, devStatus: this.devices[1].status, devIcon: this.devices[1].icon, devIsActive: this.devices[1].isActive })
              }
              .margin({ top: 16 })

              Row() {
                DeviceCard({ devName: this.devices[2].name, devStatus: this.devices[2].status, devIcon: this.devices[2].icon, devIsActive: this.devices[2].isActive })
                DeviceCard({ devName: this.devices[3].name, devStatus: this.devices[3].status, devIcon: this.devices[3].icon, devIsActive: this.devices[3].isActive })
              }
              .margin({ top: 16 })

              Row() {
                DeviceCard({ devName: this.devices[4].name, devStatus: this.devices[4].status, devIcon: this.devices[4].icon, devIsActive: this.devices[4].isActive })
                DeviceCard({ devName: this.devices[5].name, devStatus: this.devices[5].status, devIcon: this.devices[5].icon, devIsActive: this.devices[5].isActive })
              }
              .margin({ top: 16 })
            }
            .padding({ left: 24, right: 24 })
            .alignItems(HorizontalAlign.Start)

            Blank().height(100)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Column() {
          Row() {
            Blank()
            NavBarItem({ icon: '⌂', label: 'Home', isSelected: true })
            Blank()
            NavBarItem({ icon: '★', label: 'Scenes', isSelected: false })
            Blank()
            NavBarItem({ icon: '⚙', label: 'Settings', isSelected: false })
            Blank()
          }
          .padding({ top: 16 })
        }
        .height(80)
        .width('100%')
        .backgroundColor(ShColors.surface)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0D000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)
    }
    .backgroundColor(ShColors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop subtitle: string = ''
  @Prop bgColor: string = '#FFFFFF'
  @Prop textColor: string = '#FFFFFF'
  @Prop textColor80: string = '#FFFFFF'
  @Prop textColor70: string = '#FFFFFF'

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor80)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor70)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 16 })
  }
}

@Component
struct DeviceCard {
  @Prop devName: string = ''
  @Prop devStatus: string = ''
  @Prop devIcon: string = ''
  @Prop devIsActive: boolean = false
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.devIsActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(this.isChecked ? ShColors.white20 : ShColors.inactiveIconBg)
          Text(this.devIcon)
            .fontSize(14)
            .fontColor(this.isChecked ? '#FFFFFFFF' : ShColors.gray)
        }

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor(ShColors.white40)
          .scale({ x: 0.7, y: 0.7 })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
      }

      Blank()

      Column() {
        Text(this.devName)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isChecked ? '#FFFFFFFF' : ShColors.black)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? ShColors.white70 : ShColors.gray)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .height(140)
    .layoutWeight(1)
    .backgroundColor(this.isChecked ? ShColors.primary : ShColors.surface)
    .borderRadius(20)
    .shadow({ radius: 8, color: this.isChecked ? ShColors.primary30 : '#0D000000', offsetY: 4 })
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 16 })
  }
}

@Component
struct NavBarItem {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false

  build() {
    Column() {
      Stack() {
        if (this.isSelected) {
          Column() {
            Blank()
          }
          .width(64)
          .height(32)
          .backgroundColor(ShColors.primary10)
          .borderRadius(16)
        }
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.isSelected ? ShColors.primary : ShColors.gray)
      }
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? ShColors.primary : ShColors.gray)
        .margin({ top: 4 })
    }
  }
}