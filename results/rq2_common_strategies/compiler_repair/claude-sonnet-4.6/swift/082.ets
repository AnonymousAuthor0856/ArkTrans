// Models
interface DeviceItem {
  id: number;
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

const devices: DeviceItem[] = [
  { id: 1, name: 'Living Room', status: '2 Lights On', icon: $r('sys.symbol.house_fill'), isActive: true },
  { id: 2, name: 'Smart Lock', status: 'Locked', icon: $r('sys.symbol.lock_fill'), isActive: true },
  { id: 3, name: 'Bedroom AC', status: '22°C', icon: $r('sys.symbol.star_fill'), isActive: false },
  { id: 4, name: 'Router', status: 'Online', icon: $r('sys.symbol.wifi'), isActive: true },
  { id: 5, name: 'Kitchen', status: 'All Off', icon: $r('sys.symbol.info_circle_fill'), isActive: false },
  { id: 6, name: 'Corridor', status: 'Motion Detected', icon: $r('sys.symbol.bell_fill'), isActive: true },
];

// Device Card Component
@Component
struct DeviceCard {
  device: DeviceItem = { id: 0, name: '', status: '', icon: $r('sys.symbol.house_fill'), isActive: false };
  @State isChecked: boolean = false;
  primaryColor: string = '#4A6572';

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
            .fill(this.isChecked ? 'rgba(255,255,255,0.2)' : '#F0F0F0')
          SymbolGlyph(this.device.icon)
            .fontSize(16)
            .fontColor([this.isChecked ? '#FFFFFF' : '#888888'])
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(44)
          .height(26)
          .selectedColor('rgba(255,255,255,0.5)')
          .switchPointColor(this.isChecked ? '#FFFFFF' : '#CCCCCC')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .maxLines(1)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? 'rgba(255,255,255,0.7)' : '#888888')
          .margin({ top: 4 })
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
      color: this.isChecked ? 'rgba(74,101,114,0.3)' : 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: 4
    })
    .alignItems(HorizontalAlign.Start)
  }
}

// Environment Card Component
@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  bgColor: string = '#FFFFFF';
  textColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .alignSelf(ItemAlign.Start)

        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
          .alignSelf(ItemAlign.Start)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }
}

// Nav Bar Item Component
@Component
struct NavBarItem {
  icon: Resource = $r('sys.symbol.house_fill');
  label: string = '';
  isSelected: boolean = false;
  primaryColor: string = '#4A6572';

  build() {
    Column() {
      Stack() {
        if (this.isSelected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor('rgba(74,101,114,0.1)')
            .borderRadius(16)
        }
        SymbolGlyph(this.icon)
          .fontSize(22)
          .fontColor([this.isSelected ? this.primaryColor : '#888888'])
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#888888')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// Main Smart Home Screen
@Entry
@Component
struct SmartHomeScreen {
  primaryColor: string = '#4A6572';
  bgColor: string = '#F5F6F8';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.bgColor)

      // Scrollable Content
      Scroll() {
        Column() {
          // Spacer top
          Column().height(24)

          // Header Section
          Row() {
            Column() {
              Text('Welcome Home,')
                .fontSize(16)
                .fontColor('#888888')
                .alignSelf(ItemAlign.Start)

              Text('Alex Johnson')
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .alignSelf(ItemAlign.Start)
                .margin({ top: 4 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Circle()
                .width(48)
                .height(48)
                .fill('rgba(74,101,114,0.1)')

              SymbolGlyph($r('sys.symbol.person_crop_circle_fill'))
                .fontSize(32)
                .fontColor([this.primaryColor])
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ left: 24, right: 24 })

          // Spacer
          Column().height(32)

          // Environment Summary
          Row() {
            EnvironmentCard({
              title: 'Temperature',
              value: '24°C',
              subtitle: 'Comfortable',
              bgColor: '#E3F2FD',
              textColor: '#1565C0'
            })

            Column().width(16)

            EnvironmentCard({
              title: 'Humidity',
              value: '45%',
              subtitle: 'Normal',
              bgColor: '#E8F5E9',
              textColor: '#2E7D32'
            })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          // Spacer
          Column().height(32)

          // Devices Grid Header
          Text('My Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ bottom: 16 })

          // Devices Grid - Row 1
          Row() {
            DeviceCard({ device: devices[0], primaryColor: this.primaryColor })
              .layoutWeight(1)

            Column().width(16)

            DeviceCard({ device: devices[1], primaryColor: this.primaryColor })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .margin({ bottom: 16 })

          // Devices Grid - Row 2
          Row() {
            DeviceCard({ device: devices[2], primaryColor: this.primaryColor })
              .layoutWeight(1)

            Column().width(16)

            DeviceCard({ device: devices[3], primaryColor: this.primaryColor })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .margin({ bottom: 16 })

          // Devices Grid - Row 3
          Row() {
            DeviceCard({ device: devices[4], primaryColor: this.primaryColor })
              .layoutWeight(1)

            Column().width(16)

            DeviceCard({ device: devices[5], primaryColor: this.primaryColor })
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .margin({ bottom: 16 })

          // Bottom padding for nav bar
          Column().height(100)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)

      // Bottom Navigation Bar
      Column() {
        Row() {
          Blank()
          NavBarItem({
            icon: $r('sys.symbol.house_fill'),
            label: 'Home',
            isSelected: true,
            primaryColor: this.primaryColor
          })
          Blank()
          NavBarItem({
            icon: $r('sys.symbol.star_fill'),
            label: 'Scenes',
            isSelected: false,
            primaryColor: this.primaryColor
          })
          Blank()
          NavBarItem({
            icon: $r('sys.symbol.gearshape_fill'),
            label: 'Settings',
            isSelected: false,
            primaryColor: this.primaryColor
          })
          Blank()
        }
        .width('100%')
        .padding({ top: 16, bottom: 16 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({
        radius: 8,
        color: 'rgba(0,0,0,0.08)',
        offsetX: 0,
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
  }
}