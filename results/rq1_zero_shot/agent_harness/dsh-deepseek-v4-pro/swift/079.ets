// Translated from SwiftUI (079.swift) to ArkTS / ArkUI

// MARK: - Entry Point
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
    // .preferredColorScheme(.light)
    // .statusBarHidden(true)
  }
}

// MARK: - Models
class DeviceItem {
  id: string;
  name: string;
  status: string;
  icon: string;
  isActive: boolean;

  constructor(id: string, name: string, status: string, icon: string, isActive: boolean) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

// MARK: - Main Screen
@Component
struct SmartHomeScreen {
  primaryColor: string = '#4A6572'
  backgroundColor: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column({ space: 0 }) {
          Blank().height(24)

          HeaderSection({ primaryColor: this.primaryColor })
            .padding({ left: 24, right: 24 })

          Blank().height(32)

          EnvironmentSummary()
            .padding({ left: 24, right: 24 })

          Blank().height(32)

          DevicesGrid({ primaryColor: this.primaryColor })
            .padding({ left: 24, right: 24 })

          // Extra padding for bottom bar
          Blank().height(100)
        }
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  @Prop primaryColor: string = ''

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
        Blank().width(48).height(48).backgroundColor('#1A' + this.primaryColor.substring(1)).borderRadius(24) // primaryColor.opacity(0.1)
        Text('👤')
          .fontSize(32)
          .fontColor(this.primaryColor)
      }
    }
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct EnvironmentSummary {
  build() {
    Row({ space: 16 }) {
      EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', bgColor: '#E3F2FD', textColor: '#1565C0' })
      EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', bgColor: '#E8F5E9', textColor: '#2E7D32' })
    }
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop subtitle: string = ''
  @Prop bgColor: string = ''
  @Prop textColor: string = ''

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
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  @Prop primaryColor: string = ''

  devices: DeviceItem[] = [
    new DeviceItem('1', 'Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('2', 'Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('3', 'Bedroom AC', '22°C', '★', false),
    new DeviceItem('4', 'Router', 'Online', '📍', true),
    new DeviceItem('5', 'Kitchen', 'All Off', 'ℹ', false),
    new DeviceItem('6', 'Corridor', 'Motion Detected', '🔔', true)
  ]

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Column({ space: 16 }) {
        Row({ space: 16 }) {
          DeviceCard({ device: this.devices[0], primaryColor: this.primaryColor })
          DeviceCard({ device: this.devices[1], primaryColor: this.primaryColor })
        }
        Row({ space: 16 }) {
          DeviceCard({ device: this.devices[2], primaryColor: this.primaryColor })
          DeviceCard({ device: this.devices[3], primaryColor: this.primaryColor })
        }
        Row({ space: 16 }) {
          DeviceCard({ device: this.devices[4], primaryColor: this.primaryColor })
          DeviceCard({ device: this.devices[5], primaryColor: this.primaryColor })
        }
      }
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = new DeviceItem('', '', '', '', false)
  @Prop primaryColor: string = ''
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.device.isActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Blank().width(36).height(36).backgroundColor(this.isChecked ? '#33FFFFFF' : '#F0F0F0').borderRadius(18)
          Text(this.device.icon)
            .fontSize(14)
            .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
        }

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => { this.isChecked = isOn })
          .selectedColor('#66FFFFFF') // white.opacity(0.4)
          .scale({ x: 0.7, y: 0.7 })
      }

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Semibold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#808080') // white.opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .layoutWeight(1)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 8, color: this.isChecked ? '#4D' + this.primaryColor.substring(1) : '#0D000000', offsetY: 4 })
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string = ''

  build() {
    Stack() {
      Blank().width('100%').height(80).backgroundColor('#FFFFFF').borderRadius({ topLeft: 24, topRight: 24 }).shadow({ radius: 4, color: '#0D000000', offsetY: -2 })

      Row() {
        Blank()
        NavBarItem({ icon: '🏠', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '★', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '⚙', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
        Blank()
      }
      .padding({ top: 16 })
    }
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: string = ''
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  @Prop primaryColor: string = ''

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Blank().width(64).height(32).backgroundColor('#1A' + this.primaryColor.substring(1)).borderRadius(16)
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
