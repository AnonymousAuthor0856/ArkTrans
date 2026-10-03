// Index.ets

// MARK: - Models
interface DeviceItem {
  id: string;
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

// MARK: - Main Entry
@Entry
@Component
struct SmartHomeApp {
  private primaryColor: ResourceColor = '#4A6572';
  private backgroundColor: ResourceColor = '#F5F6F8';

  private devices: DeviceItem[] = [
    { id: '1', name: 'Living Room', status: '2 Lights On', icon: $r('sys.media.ohos_ic_public_contacts'), isActive: true },
    { id: '2', name: 'Smart Lock', status: 'Locked', icon: $r('sys.media.ohos_ic_public_lock'), isActive: true },
    { id: '3', name: 'Bedroom AC', status: '22°C', icon: $r('sys.media.ohos_ic_public_star'), isActive: false },
    { id: '4', name: 'Router', status: 'Online', icon: $r('sys.media.ohos_ic_public_location'), isActive: true },
    { id: '5', name: 'Kitchen', status: 'All Off', icon: $r('sys.media.ohos_ic_public_info'), isActive: false },
    { id: '6', name: 'Corridor', status: 'Motion Detected', icon: $r('sys.media.ohos_ic_public_reminder'), isActive: true }
  ];

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
            // Header
            this.HeaderSection()

            // Environment Summary
            this.EnvironmentSummary()

            // Devices Grid
            this.DevicesGrid()
          }
          .padding({ left: 24, right: 24, top: 24, bottom: 100 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }

      // Bottom Bar
      this.SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
  }

  // MARK: - Header Section
  @Builder
  HeaderSection() {
    Row() {
      Column() {
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

      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(this.primaryColor)
          .opacity(0.1)
        Image($r('sys.media.ohos_ic_public_contacts'))
          .width(32)
          .height(32)
          .fillColor(this.primaryColor)
      }
    }
    .width('100%')
    .margin({ bottom: 32 })
  }

  // MARK: - Environment Summary
  @Builder
  EnvironmentSummary() {
    Row({ space: 16 }) {
      // Temperature Card
      Column() {
        Text('Temperature')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1565C0')
          .opacity(0.8)
        Blank()
        Text('24°C')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1565C0')
        Text('Comfortable')
          .fontSize(11)
          .fontColor('#1565C0')
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .height(100)
      .layoutWeight(1)
      .backgroundColor('#E3F2FD')
      .borderRadius(16)

      // Humidity Card
      Column() {
        Text('Humidity')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#2E7D32')
          .opacity(0.8)
        Blank()
        Text('45%')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E7D32')
        Text('Normal')
          .fontSize(11)
          .fontColor('#2E7D32')
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .height(100)
      .layoutWeight(1)
      .backgroundColor('#E8F5E9')
      .borderRadius(16)
    }
    .width('100%')
    .margin({ bottom: 32 })
  }

  // MARK: - Devices Grid
  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 })

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            this.DeviceCard(device)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  // MARK: - Device Card
  @Builder
  DeviceCard(device: DeviceItem) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(device.isActive ? '#FFFFFF' : '#F0F0F0')
            .opacity(device.isActive ? 0.2 : 1.0)
          Image(device.icon)
            .width(20)
            .height(20)
            .fillColor(device.isActive ? Color.White : Color.Gray)
        }

        Blank()

        // Custom Toggle approximation
        Stack() {
          if (device.isActive) {
            // Active Track
            Row()
              .width(40)
              .height(20)
              .borderRadius(10)
              .backgroundColor('#FFFFFF')
              .opacity(0.4)
          } else {
            // Inactive Track
            Row()
              .width(40)
              .height(20)
              .borderRadius(10)
              .border({ width: 1, color: Color.Gray })
              .opacity(0.5)
          }
          // Knob
          Circle({ width: 16, height: 16 })
            .fill(Color.White)
            .position({ x: device.isActive ? 30 : 10, y: 2 })
        }
        .width(40)
        .height(20)
      }
      .width('100%')

      Blank()

      Column() {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(device.isActive ? Color.White : Color.Black)
        Text(device.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(device.isActive ? Color.White : Color.Gray)
          .opacity(device.isActive ? 0.7 : 1.0)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .backgroundColor(device.isActive ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({ radius: 8, color: device.isActive ? '#4D4A6572' : '#0D000000', offsetX: 0, offsetY: 4 })
  }

  // MARK: - Bottom Bar
  @Builder
  SmartHomeBottomBar() {
    Column() {
      Row() {
        Blank()
        this.NavBarItem($r('sys.media.ohos_ic_public_contacts'), 'Home', true)
        Blank()
        this.NavBarItem($r('sys.media.ohos_ic_public_star'), 'Scenes', false)
        Blank()
        this.NavBarItem($r('sys.media.ohos_ic_public_settings'), 'Settings', false)
        Blank()
      }
      .width('100%')
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }

  // MARK: - Nav Bar Item
  @Builder
  NavBarItem(icon: Resource, label: string, isSelected: boolean) {
    Column({ space: 4 }) {
      Stack() {
        if (isSelected) {
          // Capsule background for selected item
          Row()
            .width(64)
            .height(32)
            .borderRadius(16)
            .backgroundColor(this.primaryColor)
            .opacity(0.1)
        }
        Image(icon)
          .width(24)
          .height(24)
          .fillColor(isSelected ? this.primaryColor : Color.Gray)
      }
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? this.primaryColor : Color.Gray)
    }
  }
}