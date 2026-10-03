// Index.ets  —  ArkTS / ArkUI port of the SwiftUI SmartHome screen
const PRIMARY_COLOR: string = '#4A6572';
const BACKGROUND_COLOR: string = '#F5F6F8';
const PRIMARY_TINT: string = '#1A4A6572'; // #4A6572 @ 10% (ARGB)
const ICON_BG_INACTIVE: string = '#F0F0F0';
const TEXT_GRAY: string = '#8E8E93';

@Observed
class DeviceItem {
  id: number;
  name: string;
  status: string;
  icon: string;
  isActive: boolean;

  constructor(id: number, name: string, status: string, icon: string, isActive: boolean) {
    this.id = id;
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.isActive = isActive;
  }
}

@Entry
@Component
struct Index {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column({ space: 32 }) {
            HeaderSection()
            EnvironmentSummary()
            DevicesGrid()
            Row().width('100%').height(100) // room for the bottom bar
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24, top: 24 })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .align(Alignment.Top)
      }
      .width('100%')
      .height('100%')

      SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(TEXT_GRAY)
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(PRIMARY_TINT)
        Text('👤')
          .fontSize(22)
          .fontColor(PRIMARY_COLOR)
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
      Column() {
        EnvironmentCard({
          title: 'Temperature',
          value: '24°C',
          subtitle: 'Comfortable',
          bgColor: '#E3F2FD',
          textColor: '#1565C0'
        })
      }
      .layoutWeight(1)

      Column() {
        EnvironmentCard({
          title: 'Humidity',
          value: '45%',
          subtitle: 'Normal',
          bgColor: '#E8F5E9',
          textColor: '#2E7D32'
        })
      }
      .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  @Prop title: string;
  @Prop value: string;
  @Prop subtitle: string;
  @Prop bgColor: string;
  @Prop textColor: string;

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

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
    .width('100%')
    .height(100)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  @State devices: DeviceItem[] = [
    new DeviceItem(1, 'Living Room', '2 Lights On', '🏠', true),
    new DeviceItem(2, 'Smart Lock', 'Locked', '🔒', true),
    new DeviceItem(3, 'Bedroom AC', '22°C', '❄️', false),
    new DeviceItem(4, 'Router', 'Online', '📶', true),
    new DeviceItem(5, 'Kitchen', 'All Off', '🍽️', false),
    new DeviceItem(6, 'Corridor', 'Motion Detected', '🔔', true)
  ];

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.Black)

      Grid() {
        ForEach(this.devices, (item: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: item })
          }
        }, (item: DeviceItem) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .height(452)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  @ObjectLink device: DeviceItem;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.device.isActive ? '#33FFFFFF' : ICON_BG_INACTIVE)
          Text(this.device.icon)
            .fontSize(16)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.device.isActive })
          .selectedColor('#66FFFFFF')
          .switchPointColor(Color.White)
          .onChange((isOn: boolean) => {
            this.device.isActive = isOn;
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.device.isActive ? Color.White : Color.Black)
        Text(this.device.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.device.isActive ? '#B3FFFFFF' : TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(this.device.isActive ? PRIMARY_COLOR : Color.White)
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.device.isActive ? '#4D4A6572' : '#0D000000',
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
        NavBarItem({ icon: '🏠', label: 'Home', isSelected: true })
        NavBarItem({ icon: '⭐', label: 'Scenes', isSelected: false })
        NavBarItem({ icon: '⚙️', label: 'Settings', isSelected: false })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 8, color: '#0D000000', offsetX: 0, offsetY: -2 })
  }
}

@Component
struct NavBarItem {
  @Prop icon: string;
  @Prop label: string;
  @Prop isSelected: boolean;

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor(PRIMARY_TINT)
            .borderRadius(16)
        }
        Text(this.icon)
          .fontSize(22)
          .opacity(this.isSelected ? 1 : 0.45)
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? PRIMARY_COLOR : TEXT_GRAY)
    }
  }
}