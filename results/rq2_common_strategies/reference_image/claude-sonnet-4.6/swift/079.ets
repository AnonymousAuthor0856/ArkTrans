// Index.ets
// HarmonyOS ArkTS port of the SwiftUI "Smart Home" screen.

const PRIMARY: string = '#4A6572';
const PRIMARY_10: string = '#1A4A6572'; // primary @ 10%
const PRIMARY_20: string = '#334A6572'; // primary @ 20%
const PRIMARY_30: string = '#4D4A6572'; // primary @ 30%
const PRIMARY_40: string = '#664A6572'; // primary @ 40%
const PRIMARY_70: string = '#B34A6572'; // primary @ 70%
const PRIMARY_80: string = '#CC4A6572'; // primary @ 80%
const BACKGROUND: string = '#F5F6F8';
const TEXT_GRAY: string = '#8A8A8E';
const ICON_GRAY: string = '#EFEFEF';
const CARD_SHADOW: string = '#0D000000';

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
struct Index {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            HeaderSection()
              .padding({ left: 24, right: 24, top: 24 })

            EnvironmentSummary()
              .margin({ top: 32 })
              .padding({ left: 24, right: 24 })

            DevicesGrid()
              .margin({ top: 32 })
              .padding({ left: 24, right: 24 })

            // Extra room so the bottom bar never covers the last row.
            Blank().height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .align(Alignment.Top)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')

      SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - Header

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

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill(PRIMARY_10)

        Text('👤')
          .fontSize(24)
          .fontColor(PRIMARY)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// MARK: - Environment summary

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
  @Prop title: string = '';
  @Prop value: string = '';
  @Prop subtitle: string = '';
  @Prop bgColor: string = '#FFFFFF';
  @Prop textColor: string = '#000000';

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
    .justifyContent(FlexAlign.SpaceBetween)
    .padding(16)
    .height(100)
    .layoutWeight(1)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

// MARK: - Devices grid

@Component
struct DevicesGrid {
  private devices: DeviceItem[] = [
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
        .fontColor(Color.Black)

      Grid() {
        ForEach(this.devices, (item: DeviceItem) => {
          GridItem() {
            DeviceCard({
              name: item.name,
              icon: item.icon,
              active: item.isActive
            })
          }
          .height(140)
        }, (item: DeviceItem) => item.name)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      // 3 rows x 140 + 2 gaps x 16
      .height(452)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct DeviceCard {
  @Prop name: string = '';
  @Prop icon: string = '';
  @Prop active: boolean = false;
  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.active;
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(36)
            .height(36)
            .fill(this.isChecked ? PRIMARY_20 : ICON_GRAY)

          Text(this.icon)
            .fontSize(16)
            .fontColor(this.isChecked ? Color.White : TEXT_GRAY)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor(PRIMARY_40)
          .switchPointColor(Color.White)
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : Color.Black)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? PRIMARY_70 : TEXT_GRAY)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.isChecked ? PRIMARY : Color.White)
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? PRIMARY_30 : CARD_SHADOW,
      offsetX: 0,
      offsetY: 4
    })
  }
}

// MARK: - Bottom navigation

@Component
struct SmartHomeBottomBar {
  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column()
        .width('100%')
        .height(80)
        .backgroundColor(Color.White)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: CARD_SHADOW, offsetX: 0, offsetY: -2 })

      Row() {
        NavBarItem({ icon: '🏠', label: 'Home', selected: true })
        NavBarItem({ icon: '⭐', label: 'Scenes', selected: false })
        NavBarItem({ icon: '⚙️', label: 'Settings', selected: false })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceAround)
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: string = '';
  @Prop label: string = '';
  @Prop selected: boolean = false;

  build() {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        if (this.selected) {
          Capsule()
            .width(64)
            .height(32)
            .fill(PRIMARY_10)
        }

        Text(this.icon)
          .fontSize(20)
          .fontColor(this.selected ? PRIMARY : TEXT_GRAY)
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selected ? PRIMARY : TEXT_GRAY)
    }
  }
}