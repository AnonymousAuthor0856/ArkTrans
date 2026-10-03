class DeviceItem {
  id: string
  name: string
  status: string
  icon: string
  isActive: boolean

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.id = name
    this.name = name
    this.status = status
    this.icon = icon
    this.isActive = isActive
  }
}

@Entry
@Component
struct ContentView {
  build() {
    SmartHomeScreen()
  }
}

@Component
struct SmartHomeScreen {
  private primaryColor: ResourceColor = '#4A6572'
  private backgroundColor: ResourceColor = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Blank()
            .height(24)

          HeaderSection({ primaryColor: this.primaryColor })
            .padding({ left: 24, right: 24 })

          Blank()
            .height(32)

          EnvironmentSummary()
            .padding({ left: 24, right: 24 })

          Blank()
            .height(32)

          DevicesGrid({ primaryColor: this.primaryColor })
            .padding({ left: 24, right: 24 })

          Blank()
            .height(100)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

@Component
struct HeaderSection {
  primaryColor: ResourceColor = '#4A6572'

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(Color.Gray)

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Row()
          .width(48)
          .height(48)
          .backgroundColor('rgba(74, 101, 114, 0.10)')
          .borderRadius(24)

        Text('👤')
          .fontSize(28)
      }
      .width(48)
      .height(48)
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
  bgColor: ResourceColor = '#FFFFFF'
  textColor: ResourceColor = '#000000'

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

      Blank()
        .layoutWeight(1)

      Column() {
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
    .width('100%')
    .height(100)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  primaryColor: ResourceColor = '#4A6572'

  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', 'house.fill', true),
    new DeviceItem('Smart Lock', 'Locked', 'lock.fill', true),
    new DeviceItem('Bedroom AC', '22°C', 'star.fill', false),
    new DeviceItem('Router', 'Online', 'location.circle.fill', true),
    new DeviceItem('Kitchen', 'All Off', 'info.circle.fill', false),
    new DeviceItem('Corridor', 'Motion Detected', 'bell.fill', true)
  ]

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({
              device: device,
              primaryColor: this.primaryColor
            })
          }
        }, (device: DeviceItem) => device.id)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .height(452)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = new DeviceItem('', '', '', false)
  primaryColor: ResourceColor = '#4A6572'
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.device.isActive
  }

  private iconText(icon: string): string {
    if (icon === 'house.fill') {
      return '⌂'
    }
    if (icon === 'lock.fill') {
      return '🔒'
    }
    if (icon === 'star.fill') {
      return '★'
    }
    if (icon === 'location.circle.fill') {
      return '◎'
    }
    if (icon === 'info.circle.fill') {
      return 'i'
    }
    if (icon === 'bell.fill') {
      return '🔔'
    }
    return '●'
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Row()
            .width(36)
            .height(36)
            .backgroundColor(this.isChecked ? 'rgba(255, 255, 255, 0.20)' : '#F0F0F0')
            .borderRadius(18)

          Text(this.iconText(this.device.icon))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? Color.White : Color.Gray)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('rgba(255, 255, 255, 0.40)')
          .switchPointColor(Color.White)
          .scale({ x: 0.7, y: 0.7 })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()
        .layoutWeight(1)

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : Color.Black)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? 'rgba(255, 255, 255, 0.70)' : Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? 'rgba(74, 101, 114, 0.30)' : 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: ResourceColor = '#4A6572'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.05)',
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
      .height(80)
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
  primaryColor: ResourceColor = '#4A6572'

  build() {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        if (this.isSelected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor('rgba(74, 101, 114, 0.10)')
            .borderRadius(16)
        }

        Text(this.icon)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isSelected ? this.primaryColor : Color.Gray)
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : Color.Gray)
    }
    .alignItems(HorizontalAlign.Center)
  }
}