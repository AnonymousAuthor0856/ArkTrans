class DeviceItem {
  id: number
  name: string
  status: string
  icon: string
  isActive: boolean

  constructor(id: number, name: string, status: string, icon: string, isActive: boolean) {
    this.id = id
    this.name = name
    this.status = status
    this.icon = icon
    this.isActive = isActive
  }
}

const PRIMARY_COLOR: string = '#4A6572'
const BACKGROUND_COLOR: string = '#F5F6F8'

@Entry
@Component
struct Index {
  build() {
    SmartHomeScreen()
  }
}

@Component
struct SmartHomeScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Blank()
              .height(24)

            HeaderSection({ primaryColor: PRIMARY_COLOR })
              .padding({ left: 24, right: 24 })

            Blank()
              .height(32)

            EnvironmentSummary()
              .padding({ left: 24, right: 24 })

            Blank()
              .height(32)

            DevicesGrid({ primaryColor: PRIMARY_COLOR })
              .padding({ left: 24, right: 24 })

            Blank()
              .height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND_COLOR)

      SmartHomeBottomBar({ primaryColor: PRIMARY_COLOR })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}

@Component
struct HeaderSection {
  primaryColor: string = PRIMARY_COLOR

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#8E8E93')

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Text('👤')
          .fontSize(26)
          .fontColor(this.primaryColor)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('rgba(74,101,114,0.10)')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row({ space: 16 }) {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        bgColor: '#E3F2FD',
        textColor: '#1565C0'
      })
        .layoutWeight(1)

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  title: string = ''
  value: string = ''
  subtitle: string = ''
  bgColor: string = '#FFFFFF'
  textColor: string = '#000000'

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

      Blank()

      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)

        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .height(100)
    .width('100%')
    .padding(16)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  primaryColor: string = PRIMARY_COLOR

  private devices: DeviceItem[] = [
    new DeviceItem(0, 'Living Room', '2 Lights On', '⌂', true),
    new DeviceItem(1, 'Smart Lock', 'Locked', '🔒', true),
    new DeviceItem(2, 'Bedroom AC', '22°C', '✦', false),
    new DeviceItem(3, 'Router', 'Online', '◎', true),
    new DeviceItem(4, 'Kitchen', 'All Off', 'i', false),
    new DeviceItem(5, 'Corridor', 'Motion Detected', '🔔', true)
  ]

  @State activeStates: boolean[] = [true, true, false, true, false, true]

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({
              device: device,
              primaryColor: this.primaryColor,
              isChecked: this.activeStates[device.id],
              onToggle: (checked: boolean) => {
                this.activeStates[device.id] = checked
                this.activeStates = this.activeStates.slice()
              }
            })
          }
        }, (device: DeviceItem) => device.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .height(452)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = new DeviceItem(0, '', '', '', false)
  primaryColor: string = PRIMARY_COLOR
  isChecked: boolean = false
  onToggle: (checked: boolean) => void = (checked: boolean) => {}

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.device.icon)
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? '#FFFFFF' : '#8E8E93')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? 'rgba(255,255,255,0.20)' : '#F0F0F0')

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('rgba(255,255,255,0.40)')
          .switchPointColor('#FFFFFF')
          .scale({ x: 0.72, y: 0.72 })
          .onChange((checked: boolean) => {
            this.onToggle(checked)
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? 'rgba(255,255,255,0.70)' : '#8E8E93')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? 'rgba(74,101,114,0.30)' : 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: string = PRIMARY_COLOR

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 4,
          color: 'rgba(0,0,0,0.05)',
          offsetX: 0,
          offsetY: -2
        })

      Row() {
        Blank()

        NavBarItem({
          icon: '⌂',
          label: 'Home',
          isSelected: true,
          primaryColor: this.primaryColor
        })

        Blank()

        NavBarItem({
          icon: '★',
          label: 'Scenes',
          isSelected: false,
          primaryColor: this.primaryColor
        })

        Blank()

        NavBarItem({
          icon: '⚙',
          label: 'Settings',
          isSelected: false,
          primaryColor: this.primaryColor
        })

        Blank()
      }
      .width('100%')
      .height(64)
      .padding({ top: 16 })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  icon: string = ''
  label: string = ''
  isSelected: boolean = false
  primaryColor: string = PRIMARY_COLOR

  build() {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        if (this.isSelected) {
          Column()
            .width(64)
            .height(32)
            .borderRadius(16)
            .backgroundColor('rgba(74,101,114,0.10)')
        }

        Text(this.icon)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? this.primaryColor : '#8E8E93')
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#8E8E93')
    }
    .alignItems(HorizontalAlign.Center)
  }
}