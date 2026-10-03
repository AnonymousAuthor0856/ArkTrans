// SmartHomeApp.ets

// MARK: - Models
interface DeviceItem {
  name: string;
  status: string;
  icon: ResourceStr;
  isActive: boolean;
}

// MARK: - Main Screen
@Entry
@Component
struct SmartHomeScreen {
  private primaryColor: ResourceColor = '#4A6572';
  private bgColor: ResourceColor = '#F5F6F8';
  
  private devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: $r('sys.symbol.house'), isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: $r('sys.symbol.lock'), isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: $r('sys.symbol.star'), isActive: false },
    { name: 'Router', status: 'Online', icon: $r('sys.symbol.wifi'), isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: $r('sys.symbol.circle'), isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: $r('sys.symbol.bell'), isActive: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(this.bgColor);

      // Main Content
      Column() {
        Scroll() {
          Column() {
            Blank().height(24);
            
            // Header Section
            this.HeaderSection();
            Blank().height(32);
            
            // Environment Summary
            this.EnvironmentSummary();
            Blank().height(32);
            
            // Devices Grid
            this.DevicesGrid();
            Blank().height(100); // Extra padding for bottom bar
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start);
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%');

      // Bottom Bar
      this.SmartHomeBottomBar();
    }
    .width('100%')
    .height('100%')
  }

  // MARK: - Components

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(Color.Gray)
          .margin({ bottom: 4 });
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black);
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      Stack() {
        Circle({ width: 48, height: 48 })
          .fill(this.primaryColor)
          .opacity(0.1);
        
        Image($r('sys.symbol.person'))
          .width(32)
          .height(32)
          .fillColor(this.primaryColor);
      }
      .width(48)
      .height(48);
    }
    .width('100%')
    .padding({ left: 24, right: 24 });
  }

  @Builder
  EnvironmentSummary() {
    Row({ space: 16 }) {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0');
      this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32');
    }
    .width('100%')
    .padding({ left: 24, right: 24 });
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bgColor: ResourceColor, textColor: ResourceColor) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textColor)
        .opacity(0.8);
      
      Blank(); // Pushes content to bottom

      Column() {
        Text(value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor);
        Text(subtitle)
          .fontSize(11)
          .fontColor(textColor)
          .opacity(0.7);
      }
      .alignItems(HorizontalAlign.Start);
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween);
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .margin({ bottom: 16 });

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            this.DeviceCard(device);
          }
        });
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%');
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  DeviceCard(device: DeviceItem) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(device.isActive ? '#33FFFFFF' : '#F0F0F0');
          
          Image(device.icon)
            .width(20)
            .height(20)
            .fillColor(device.isActive ? Color.White : Color.Gray);
        }
        .width(36)
        .height(36)
        .alignContent(Alignment.Center);

        Blank();

        // Toggle Switch Simulation
        Stack() {
          // Track
          Row()
            .width(40)
            .height(20)
            .borderRadius(10)
            .backgroundColor(device.isActive ? '#66FFFFFF' : '#E0E0E0');
          
          // Thumb
          Circle({ width: 16, height: 16 })
            .fill(Color.White)
            .position({ x: device.isActive ? 22 : 2, y: 2 });
        }
        .width(40)
        .height(20);
      }
      .width('100%');

      Blank(); // Pushes text to bottom

      Column() {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(device.isActive ? Color.White : Color.Black);
        
        Text(device.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(device.isActive ? '#B3FFFFFF' : Color.Gray);
      }
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(device.isActive ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({ radius: 8, color: device.isActive ? '#4D4A6572' : '#0D000000', offsetX: 0, offsetY: 4 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  SmartHomeBottomBar() {
    Column() {
      Row() {
        Blank();
        this.NavBarItem($r('sys.symbol.house'), 'Home', true);
        Blank();
        this.NavBarItem($r('sys.symbol.star'), 'Scenes', false);
        Blank();
        this.NavBarItem($r('sys.symbol.gear'), 'Settings', false);
        Blank();
      }
      .width('100%')
      .padding({ top: 16, bottom: 16 });
    }
    .width('100%')
    .height(80)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: -2 });
  }

  @Builder
  NavBarItem(icon: ResourceStr, label: string, isSelected: boolean) {
    Column({ space: 4 }) {
      Stack() {
        if (isSelected) {
          // Capsule background for selected item
          Row()
            .width(64)
            .height(32)
            .borderRadius(16)
            .backgroundColor(this.primaryColor)
            .opacity(0.1);
        }
        
        Image(icon)
          .width(24)
          .height(24)
          .fillColor(isSelected ? this.primaryColor : Color.Gray);
      }
      .width(64)
      .height(32)
      .alignContent(Alignment.Center);

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? this.primaryColor : Color.Gray);
    }
    .justifyContent(FlexAlign.Center);
  }
}