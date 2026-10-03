@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      SmartHomeScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

// Models
class DeviceItem {
  id: string = ''
  name: string = ''
  status: string = ''
  icon: string = ''
  isActive: boolean = false

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.id = `${Date.now()}_${Math.random()}`
    this.name = name
    this.status = status
    this.icon = icon
    this.isActive = isActive
  }
}

// Main Screen
@Component
struct SmartHomeScreen {
  private primaryColor: string = '#4A6572'
  private backgroundColor: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column({ space: 0 }) {
            // Top spacing
            Row().height(24)

            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            Row().height(32)

            EnvironmentSummary()
              .padding({ left: 24, right: 24 })

            Row().height(32)

            DevicesGrid({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            // Extra padding for bottom bar
            Row().height(100)
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

// Header Section
@Component
struct HeaderSection {
  @Prop primaryColor: string = '#4A6572'

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#808080')
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .fill(this.primaryColor + '1A')
          .width(48)
          .height(48)

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

// Environment Summary
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
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop subtitle: string = ''
  @Prop bgColor: string = '#FFFFFF'
  @Prop textColor: string = '#000000'

  build() {
    Column({ space: 0 }) {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor + 'CC')

      Blank()

      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor + 'B3')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

// Devices Grid
@Component
struct DevicesGrid {
  @Prop primaryColor: string = '#4A6572'
  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '⭐', false),
    new DeviceItem('Router', 'Online', '📍', true),
    new DeviceItem('Kitchen', 'All Off', 'ℹ️', false),
    new DeviceItem('Corridor', 'Motion Detected', '🔔', true)
  ]

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
              primaryColor: this.primaryColor
            })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

// Device Card
@Component
struct DeviceCard {
  @Prop device: DeviceItem = new DeviceItem('', '', '', false)
  @Prop primaryColor: string = '#4A6572'
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.device.isActive
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? '#FFFFFF33' : '#F0F0F0')
            .width(36)
            .height(36)

          Text(this.device.icon)
            .fontSize(16)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#FFFFFF66')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
          .width(40)
          .height(24)
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#FFFFFFB3' : '#808080')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? this.primaryColor + '4D' : '#0000000D',
      offsetX: 0,
      offsetY: 4
    })
  }
}

// Bottom Bar
@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string = '#4A6572'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 4,
          color: '#0000000D',
          offsetX: 0,
          offsetY: -2
        })

      Row() {
        Blank()
        NavBarItem({
          icon: '🏠',
          label: 'Home',
          isSelected: true,
          primaryColor: this.primaryColor
        })
        Blank()
        NavBarItem({
          icon: '⭐',
          label: 'Scenes',
          isSelected: false,
          primaryColor: this.primaryColor
        })
        Blank()
        NavBarItem({
          icon: '⚙️',
          label: 'Settings',
          isSelected: false,
          primaryColor: this.primaryColor
        })
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
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  @Prop primaryColor: string = '#4A6572'

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor(this.primaryColor + '1A')
            .borderRadius(16)
        }
        Text(this.icon)
          .fontSize(22)
          .fontColor(this.isSelected ? this.primaryColor : '#808080')
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#808080')
    }
    .alignItems(HorizontalAlign.Center)
  }
}