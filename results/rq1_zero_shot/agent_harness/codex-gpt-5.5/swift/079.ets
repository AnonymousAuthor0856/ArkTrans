class DeviceItem {
  name: string;
  status: string;
  icon: string;
  isActive: boolean;

  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

@Entry
@Component
struct SmartHomeScreen {
  @State private switches: boolean[] = [true, true, false, true, false, true];
  private primaryColor: string = '#4A6572';
  private backgroundColor: string = '#F5F6F8';
  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '⌂', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '★', false),
    new DeviceItem('Router', 'Online', '⌖', true),
    new DeviceItem('Kitchen', 'All Off', 'ⓘ', false),
    new DeviceItem('Corridor', 'Motion Detected', '🔔', true)
  ];

  @Builder
  private HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#808080')
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#4A65721A')
        Text('👤')
          .fontSize(28)
          .fontColor(this.primaryColor)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
  }

  @Builder
  private EnvironmentCard(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(`${textColor}CC`)
      Blank()
      Column({ space: 0 }) {
        Text(value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
        Text(subtitle)
          .fontSize(11)
          .fontColor(`${textColor}B3`)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(bgColor)
    .borderRadius(16)
  }

  @Builder
  private EnvironmentSummary() {
    Row({ space: 16 }) {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
      this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
    }
    .width('100%')
  }

  @Builder
  private DeviceCard(device: DeviceItem, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.switches[index] ? '#FFFFFF33' : '#F0F0F0')
          Text(device.icon)
            .fontSize(14)
            .fontColor(this.switches[index] ? Color.White : '#808080')
        }
        .width(36)
        .height(36)
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switches[index] })
          .selectedColor('#FFFFFF66')
          .scale({ x: 0.7, y: 0.7 })
          .onChange((isOn: boolean) => {
            let updated: boolean[] = this.switches.slice();
            updated[index] = isOn;
            this.switches = updated;
          })
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(this.switches[index] ? Color.White : Color.Black)
        Text(this.switches[index] ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.switches[index] ? '#FFFFFFB3' : '#808080')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(140)
    .width('100%')
    .backgroundColor(this.switches[index] ? this.primaryColor : Color.White)
    .borderRadius(20)
    .shadow({ radius: 8, color: this.switches[index] ? '#4A65724D' : '#0000000D', offsetX: 0, offsetY: 4 })
  }

  @Builder
  private DevicesGrid() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)
        .width('100%')
        .textAlign(TextAlign.Start)

      Grid() {
        ForEach(this.devices, (device: DeviceItem, index: number) => {
          GridItem() {
            this.DeviceCard(device, index)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  private NavBarItem(icon: string, label: string, isSelected: boolean) {
    Column({ space: 4 }) {
      Stack() {
        if (isSelected) {
          Rect()
            .width(64)
            .height(32)
            .fill('#4A65721A')
            .radius(16)
        }
        Text(icon)
          .fontSize(24)
          .fontColor(isSelected ? this.primaryColor : '#808080')
      }
      .width(64)
      .height(32)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? this.primaryColor : '#808080')
    }
  }

  @Builder
  private SmartHomeBottomBar() {
    Stack({ alignContent: Alignment.Top }) {
      Rect()
        .width('100%')
        .height(80)
        .fill(Color.White)
        .radius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0000000D', offsetX: 0, offsetY: -2 })
      Row() {
        Blank()
        this.NavBarItem('⌂', 'Home', true)
        Blank()
        this.NavBarItem('★', 'Scenes', false)
        Blank()
        this.NavBarItem('⚙', 'Settings', false)
        Blank()
      }
      .padding({ top: 16 })
      .width('100%')
    }
    .height(80)
    .width('100%')
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(24)
            this.HeaderSection()
              .padding({ left: 24, right: 24 })
            Blank().height(32)
            this.EnvironmentSummary()
              .padding({ left: 24, right: 24 })
            Blank().height(32)
            this.DevicesGrid()
              .padding({ left: 24, right: 24 })
            Blank().height(100)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.SmartHomeBottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}
