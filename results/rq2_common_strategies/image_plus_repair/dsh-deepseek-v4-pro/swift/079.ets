// SwiftUI SmartHomeApp translated to ArkTS (HarmonyOS ArkUI).
// SF Symbols are approximated with emoji text placeholders (ArkUI has no SF Symbols).
// Colors use the same hex values as the Swift code.

// MARK: - Models
class DeviceItem {
  id: string = '';
  name: string = '';
  status: string = '';
  icon: string = '';
  isActive: boolean = false;

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.id = name; // stand-in for UUID()
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    // .preferredColorScheme(.light) and .statusBarHidden(true) have no direct
    // ArkUI equivalent; approximated by the default light rendering.
    Column() {
      SmartHomeScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Main Screen
@Component
struct SmartHomeScreen {
  // Colors matching Android theme
  primaryColor: string = '#4A6572'; // #4A6572
  bgColor: string = '#F5F6F8'; // #F5F6F8

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

            // Extra padding for bottom bar
            Blank().height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    // .edgesIgnoringSafeArea(.bottom) approximated by full-size layout
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  primaryColor: string = '';

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
          .width(48)
          .height(48)
          .fill(this.primaryColor)
          .opacity(0.1)
        Text('👤') // person.circle.fill
          .fontSize(32)
          .fontColor(this.primaryColor)
      }
    }
    .width('100%')
  }
}

@Component
struct EnvironmentSummary {
  build() {
    // Temperature + Humidity cards, side by side (following the 2-card row).
    // A single wide Temperature card appears in some visual references; this
    // implementation follows the code logic of two cards in a row.
    Row({ space: 16 }) {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        bgColor: '#E3F2FD', // Color(red: 0.89, green: 0.95, blue: 0.99)
        textColor: '#1565C0' // Color(red: 0.08, green: 0.40, blue: 0.75)
      })
        .layoutWeight(1)

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9', // Color(red: 0.91, green: 0.96, blue: 0.91)
        textColor: '#2E7D32' // Color(red: 0.18, green: 0.49, blue: 0.20)
      })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  bgColor: string = '';
  textColor: string = '';

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
    .width('100%')
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  primaryColor: string = '';

  // Data from Android code
  devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '⭐', false),
    new DeviceItem('Router', 'Online', '📍', true),
    new DeviceItem('Kitchen', 'All Off', 'ℹ️', false),
    new DeviceItem('Corridor', 'Motion Detected', '🔔', true)
  ];

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        }, (device: DeviceItem) => device.id)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = new DeviceItem('', '', '', false);
  primaryColor: string = '';
  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.isChecked ? '#FFFFFF' : '#F0F0F0')
            .opacity(this.isChecked ? 0.2 : 1.0)
          Text(this.device.icon)
            .fontSize(14)
            .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
        }

        Blank()

        // Approximating the SwiftUI SwitchToggleStyle tint styling.
        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .scale({ x: 0.7, y: 0.7 })
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
          .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
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
      color: this.isChecked ? this.primaryColor : 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: string = '';

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Shadow layer
      Column()
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: -2 })

      Row() {
        Blank()
        NavBarItem({ icon: '🏠', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '⭐', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: '⚙️', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
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
  icon: string = '';
  label: string = '';
  isSelected: boolean = false;
  primaryColor: string = '';

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          // Capsule-shaped highlight
          Row()
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

// MARK: - Helper for Corners
// SwiftUI's RoundedCorner Shape + View.cornerRadius(_:corners:) extension is
// replaced by ArkUI's per-corner borderRadius option, e.g.:
//   .borderRadius({ topLeft: 24, topRight: 24 })
// (see SmartHomeBottomBar above).
