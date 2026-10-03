@Entry
@Component
struct SmartHomeApp {
  @State primaryColor: ResourceColor = '#4A6572'
  @State backgroundColor: ResourceColor = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            HeaderSection({ primaryColor: this.primaryColor })
              .margin({ top: 24, left: 24, right: 24 })

            EnvironmentSummary()
              .margin({ top: 32, left: 24, right: 24 })

            DevicesGrid({ primaryColor: this.primaryColor })
              .margin({ top: 32, left: 24, right: 24, bottom: 100 })
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
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#888888')
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Circle({ width: 48, height: 48 })
          .fill(this.colorWithOpacity(this.primaryColor, 0.1))

        Text('\u{1F464}')
          .fontSize(28)
          .fontColor(this.primaryColor as string)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  private colorWithOpacity(color: ResourceColor, opacity: number): string {
    const c = color as string
    if (c.startsWith('#')) {
      const hex = c.substring(1)
      const r = parseInt(hex.substring(0, 2), 16)
      const g = parseInt(hex.substring(2, 4), 16)
      const b = parseInt(hex.substring(4, 6), 16)
      return `rgba(${r}, ${g}, ${b}, ${opacity})`
    }
    return c
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row() {
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
        .fontColor(this.textColor as string)
        .opacity(0.8)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor as string)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor as string)
          .opacity(0.7)
          .margin({ top: 2 })
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

interface DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean
}

@Component
struct DevicesGrid {
  primaryColor: ResourceColor = '#4A6572'

  private devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '\u{1F3E0}', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '\u{1F512}', isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: '\u{2B50}', isActive: false },
    { name: 'Router', status: 'Online', icon: '\u{1F4CD}', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: '\u{2139}', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '\u{1F514}', isActive: true }
  ]

  build() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Grid() {
        ForEach(this.devices, (item: DeviceItem, index: number) => {
          GridItem() {
            DeviceCard({ device: item, primaryColor: this.primaryColor })
          }
        }, (item: DeviceItem, index: number) => index.toString())
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
      .margin({ top: 16 })
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = { name: '', status: '', icon: '', isActive: false }
  primaryColor: ResourceColor = '#4A6572'
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.device.isActive
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle({ width: 36, height: 36 })
            .fill(this.isChecked ? 'rgba(255, 255, 255, 0.2)' : '#EFEFEF')

          Text(this.device.icon)
            .fontSize(16)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectColor(this.isChecked ? 'rgba(255, 255, 255, 0.4)' : '#CCCCCC')
          .onChange((value: boolean) => {
            this.isChecked = value
          })
          .scale({ x: 0.85, y: 0.85 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? 'rgba(255, 255, 255, 0.7)' : '#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? 'rgba(74, 101, 114, 0.3)' : 'rgba(0, 0, 0, 0.05)',
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
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.05)',
          offsetX: 0,
          offsetY: -2
        })

      Row() {
        Blank()
        NavBarItem({ icon: '\u{1F3E0}', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '\u{2B50}', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '\u{2699}', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
        Blank()
      }
      .width('100%')
      .padding({ top: 16 })
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
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        if (this.isSelected) {
          Capsule()
            .width(64)
            .height(32)
            .fill(this.colorWithOpacity(this.primaryColor, 0.1))
        }
        Text(this.icon)
          .fontSize(22)
          .fontColor(this.isSelected ? this.primaryColor as string : '#888888')
      }
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor as string : '#888888')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  private colorWithOpacity(color: ResourceColor, opacity: number): string {
    const c = color as string
    if (c.startsWith('#')) {
      const hex = c.substring(1)
      const r = parseInt(hex.substring(0, 2), 16)
      const g = parseInt(hex.substring(2, 4), 16)
      const b = parseInt(hex.substring(4, 6), 16)
      return `rgba(${r}, ${g}, ${b}, ${opacity})`
    }
    return c
  }
}
