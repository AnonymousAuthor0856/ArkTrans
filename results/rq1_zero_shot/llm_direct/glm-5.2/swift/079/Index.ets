// SmartHomeApp.ets
import { Length, ResourceStr } from '@ohos.arkui';

// MARK: - Models
class DeviceItem {
  id: string;
  name: string;
  status: string;
  icon: ResourceStr;
  isActive: boolean;

  constructor(id: string, name: string, status: string, icon: ResourceStr, isActive: boolean) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

// MARK: - Main Screen
@Entry
@Component
struct SmartHomeScreen {
  // Colors matching Android theme
  private primaryColor: string = '#4A6572';
  private backgroundColor: string = '#F5F6F8';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.backgroundColor)

      // Main Content
      Column() {
        Scroll() {
          Column() {
            // Top Spacing
            Blank().height(24)

            // Header Section
            HeaderSection({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            Blank().height(32)

            // Environment Summary
            EnvironmentSummary()
              .padding({ left: 24, right: 24 })

            Blank().height(32)

            // Devices Grid
            DevicesGrid({ primaryColor: this.primaryColor })
              .padding({ left: 24, right: 24 })

            // Extra padding for bottom bar
            Blank().height(100)
          }
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  private primaryColor: string = '#4A6572';

  build() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#808080')
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 4, bottom: 4 })

      Blank()

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(this.primaryColor)
          .opacity(0.1)

        Image($r('sys.symbol.person_circle_fill'))
          .width(32)
          .height(32)
          .fillColor(this.primaryColor)
      }
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

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  private title: string = '';
  private value: string = '';
  private subtitle: string = '';
  private bgColor: string = '#FFFFFF';
  private textColor: string = '#000000';

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
    .layoutWeight(1)
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  private primaryColor: string = '#4A6572';

  private devices: DeviceItem[] = [
    new DeviceItem('1', 'Living Room', '2 Lights On', $r('sys.symbol.house_fill'), true),
    new DeviceItem('2', 'Smart Lock', 'Locked', $r('sys.symbol.lock_fill'), true),
    new DeviceItem('3', 'Bedroom AC', '22°C', $r('sys.symbol.star_fill'), false),
    new DeviceItem('4', 'Router', 'Online', $r('sys.symbol.location_circle_fill'), true),
    new DeviceItem('5', 'Kitchen', 'All Off', $r('sys.symbol.info_circle_fill'), false),
    new DeviceItem('6', 'Corridor', 'Motion Detected', $r('sys.symbol.bell_fill'), true)
  ];

  build() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .margin({ bottom: 16 })

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
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct DeviceCard {
  private device: DeviceItem = new DeviceItem('', '', '', '', false);
  private primaryColor: string = '#4A6572';
  @State isChecked: boolean = false;

  aboutToAppear() {
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

          Image(this.device.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? '#FFFFFF' : '#808080')
        }

        Blank()

        // Custom Toggle representation
        Row() {
          Stack({ alignContent: this.isChecked ? Alignment.End : Alignment.Start }) {
            Circle()
              .width(20)
              .height(20)
              .fill('#FFFFFF')
              .margin(2)
          }
          .width(44)
          .height(24)
          .borderRadius(12)
          .backgroundColor(this.isChecked ? '#FFFFFF' : '#C0C0C0')
          .opacity(this.isChecked ? 0.4 : 1.0)
          .onClick(() => {
            this.isChecked = !this.isChecked;
          })
        }
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
          .opacity(this.isChecked ? 0.7 : 1.0)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? this.primaryColor : '#000000',
      offsetX: 0,
      offsetY: 4
    })
    .shadowColor(this.isChecked ? `${this.primaryColor}4D` : '#0000000D') // Approximate opacity
  }
}

@Component
struct SmartHomeBottomBar {
  private primaryColor: string = '#4A6572';

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background Layer
      Column()
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0000000D', offsetX: 0, offsetY: -2 })

      // Nav Items
      Row() {
        Blank()
        NavBarItem({ icon: $r('sys.symbol.house_fill'), label: 'Home', isSelected: true, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: $r('sys.symbol.star_fill'), label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
        Blank()
        NavBarItem({ icon: $r('sys.symbol.gearshape_fill'), label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
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
  private icon: ResourceStr = '';
  private label: string = '';
  private isSelected: boolean = false;
  private primaryColor: string = '#4A6572';

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Capsule()
            .width(64)
            .height(32)
            .fill(this.primaryColor)
            .opacity(0.1)
        }
        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(this.isSelected ? this.primaryColor : '#808080')
      }
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#808080')
    }
  }
}