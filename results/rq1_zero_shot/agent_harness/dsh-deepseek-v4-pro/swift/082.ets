// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: SmartHomeApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    SmartHomeScreen()
  }
}

// MARK: - Models
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

// MARK: - Main Screen
@Component
struct SmartHomeScreen {
  primaryColor: string = '#4A6572'
  backgroundColor: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Blank().height(24)

            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            Blank().height(32)

            EnvironmentSummary()
              .padding({ left: 24, right: 24 })

            Blank().height(32)

            DevicesGrid({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            Blank().height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  primaryColor: string = '#4A6572'

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
          .fill(this.primaryColor)
          .opacity(0.1)
          .width(48)
          .height(48)

        Text('👤')
          .fontSize(32)
          .fontColor(this.primaryColor)
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
      EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: '#E3F2FD', textColor: '#1565C0' })
        .layoutWeight(1)
      EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: '#E8F5E9', textColor: '#2E7D32' })
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
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  primaryColor: string = '#4A6572'

  devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '★', false),
    new DeviceItem('Router', 'Online', '📍', true),
    new DeviceItem('Kitchen', 'All Off', 'ℹ', false),
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
            DeviceCard({ device: device, primaryColor: this.primaryColor, isChecked: device.isActive })
          }
        }, (device: DeviceItem) => device.id)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = new DeviceItem('', '', '', false)
  primaryColor: string = '#4A6572'
  @State isChecked: boolean = false

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? '#FFFFFF' : '#EEEEEE')
            .opacity(this.isChecked ? 0.2 : 1)
            .width(36)
            .height(36)

          Text(this.device.icon)
            .fontSize(14)
            .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => { this.isChecked = isOn })
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Semibold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
          .opacity(this.isChecked ? 0.7 : 1)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: this.isChecked ? '#4D4A6572' : '#0D000000', offsetY: 4 })
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: string = '#4A6572'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0D000000', offsetY: -2 })

      Row() {
        Blank()
        NavBarItem({ icon: '🏠', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '★', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '⚙', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
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
  primaryColor: string = '#4A6572'

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Column()
            .width(64)
            .height(32)
            .backgroundColor(this.primaryColor)
            .opacity(0.1)
            .borderRadius(16)
        }
        Text(this.icon)
          .fontSize(24)
          .fontColor(this.isSelected ? this.primaryColor : '#808080')
      }
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#808080')
    }
  }
}
