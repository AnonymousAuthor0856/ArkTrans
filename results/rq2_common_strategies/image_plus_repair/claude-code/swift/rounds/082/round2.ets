import prompt from '@ohos.promptAction';

@Observed
class DeviceItem {
  id: string;
  name: string;
  status: string;
  iconSymbol: string;
  isActive: boolean;

  constructor(id: string, name: string, status: string, iconSymbol: string, isActive: boolean) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.iconSymbol = iconSymbol;
    this.isActive = isActive;
  }
}

@Entry
@Component
struct SmartHomeApp {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
              .margin({ top: 24, left: 24, right: 24 })

            EnvironmentSummary()
              .margin({ top: 32, left: 24, right: 24 })

            DevicesGrid()
              .margin({ top: 32, left: 24, right: 24 })

            Blank()
              .height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F6F8')

      SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

@Component
struct HeaderSection {
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

      Stack() {
        Circle({ width: 48, height: 48 })
          .fill('#E8EAEC')

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

      Blank()
        .width(16)

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
  @State title: string = '';
  @State value: string = '';
  @State subtitle: string = '';
  @State bgColor: string = '#FFFFFF';
  @State textColor: string = '#000000';

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

@Component
struct DevicesGrid {
  @State devices: DeviceItem[] = [
    new DeviceItem('1', 'Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('2', 'Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('3', 'Bedroom AC', '22°C', '❄️', false),
    new DeviceItem('4', 'Router', 'Online', '📡', true),
    new DeviceItem('5', 'Kitchen', 'All Off', '🍳', false),
    new DeviceItem('6', 'Corridor', 'Motion Detected', '🔔', true)
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
            DeviceCard({ device: device })
          }
        }, (device: DeviceItem) => device.id)
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  @ObjectLink device: DeviceItem;
  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(this.isChecked ? 'rgba(255,255,255,0.2)' : '#F0F0F0')

          Text(this.device.iconSymbol)
            .fontSize(16)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .selectedColor('#4A6572')
          .switchPointColor('#FFFFFF')
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bolder)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? 'rgba(255,255,255,0.7)' : '#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? 'rgba(74,101,114,0.3)' : 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  build() {
    Column() {
      Row() {
        Blank()
        NavBarItem({ icon: '🏠', label: 'Home', isSelected: true })
        Blank()
        NavBarItem({ icon: '⭐', label: 'Scenes', isSelected: false })
        Blank()
        NavBarItem({ icon: '⚙️', label: 'Settings', isSelected: false })
        Blank()
      }
      .width('100%')
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Component
struct NavBarItem {
  @State icon: string = '';
  @State label: string = '';
  @State isSelected: boolean = false;

  build() {
    Column() {
      Stack() {
        if (this.isSelected) {
          Circle({ width: 64, height: 32 })
            .fill('rgba(74,101,114,0.1)')
        }

        Text(this.icon)
          .fontSize(22)
          .fontColor(this.isSelected ? '#4A6572' : '#888888')
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#4A6572' : '#888888')
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}
