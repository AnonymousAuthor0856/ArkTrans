interface DeviceItem {
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
}

const PRIMARY_COLOR: string = '#4A6572';
const BACKGROUND_COLOR: string = '#F5F6F8';
const TEXT_COLOR: string = '#202029';

const DEVICE_ITEMS: DeviceItem[] = [
  { name: 'Living Room', status: '2 Lights On', icon: '⌂', isActive: true },
  { name: 'Smart Lock', status: 'Locked', icon: '▣', isActive: true },
  { name: 'Bedroom AC', status: '22°C', icon: '★', isActive: false },
  { name: 'Router', status: 'Online', icon: '⌖', isActive: true },
  { name: 'Kitchen', status: 'All Off', icon: 'i', isActive: false },
  { name: 'Corridor', status: 'Motion Detected', icon: '●', isActive: true }
];

@Entry
@Component
struct SmartHomePage {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          HeaderSection()

          Blank()
            .height(32)

          EnvironmentSummary()

          Blank()
            .height(64)

          DevicesGrid()
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND_COLOR)
      .scrollBar(BarState.Off)
      .padding({
        left: 24,
        right: 24,
        top: 54,
        bottom: 120
      })

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
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#888888')
          .fontWeight(FontWeight.Regular)

        Text('Alex Johnson')
          .fontSize(30)
          .fontColor(TEXT_COLOR)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 8 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: Alignment.Center }) {
        Text('●')
          .fontSize(38)
          .fontColor(PRIMARY_COLOR)

        Text('●')
          .fontSize(18)
          .fontColor('#F5F6F8')
          .translate({ x: 0, y: -8 })

        Text('◒')
          .fontSize(24)
          .fontColor('#F5F6F8')
          .translate({ x: 0, y: 10 })
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#E6EAEE')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
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
        cardColor: '#E3F2FD',
        textColor: '#1565C0'
      })
        .width('100%')

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        cardColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
        .width('100%')
    }
    .width('100%')
    .height(100)
    .clip(true)
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  cardColor: string = '#FFFFFF';
  textColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.textColor)
        .opacity(0.8)

      Column() {
        Text(this.value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)

        Text(this.subtitle)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor)
          .opacity(0.7)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .borderRadius(16)
    .backgroundColor(this.cardColor)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DevicesGrid {
  build() {
    Column() {
      Text('My Devices')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_COLOR)
        .margin({ bottom: 16 })

      Flex({
        wrap: FlexWrap.Wrap,
        justifyContent: FlexAlign.SpaceBetween,
        alignItems: ItemAlign.Start
      }) {
        ForEach(DEVICE_ITEMS, (device: DeviceItem) => {
          DeviceCard({ device: device })
            .width('47.5%')
            .margin({ bottom: 16 })
        }, (device: DeviceItem) => device.name)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = {
    name: '',
    status: '',
    icon: '',
    isActive: false
  };

  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(this.device.icon)
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? '#66FFFFFF' : '#F0F0F0')

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(56)
          .height(32)
          .selectedColor(this.isChecked ? '#9AAAB1' : '#FFFFFF')
          .switchPointColor(this.isChecked ? '#FFFFFF' : '#888888')
          .onChange((value: boolean) => {
            this.isChecked = value;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.device.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .maxLines(1)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#D9FFFFFF' : '#99000000')
          .margin({ top: 8 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(this.isChecked ? PRIMARY_COLOR : '#FFFFFF')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .shadow({
      radius: this.isChecked ? 20 : 8,
      color: this.isChecked ? '#33000000' : '#16000000',
      offsetX: 0,
      offsetY: this.isChecked ? 8 : 2
    })
  }
}

@Component
struct SmartHomeBottomBar {
  build() {
    Row() {
      BottomNavItem({
        title: 'Home',
        icon: '⌂',
        selected: true
      })

      BottomNavItem({
        title: 'Scenes',
        icon: '★',
        selected: false
      })

      BottomNavItem({
        title: 'Settings',
        icon: '⚙',
        selected: false
      })
    }
    .width('100%')
    .height(96)
    .padding({
      left: 24,
      right: 24,
      top: 14,
      bottom: 12
    })
    .borderRadius({
      topLeft: 24,
      topRight: 24,
      bottomLeft: 0,
      bottomRight: 0
    })
    .backgroundColor('#ECEFF1')
    .shadow({
      radius: 10,
      color: '#16000000',
      offsetX: 0,
      offsetY: -2
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomNavItem {
  title: string = '';
  icon: string = '';
  selected: boolean = false;

  build() {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        Text(this.icon)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selected ? PRIMARY_COLOR : '#4A4A54')
      }
      .width(64)
      .height(32)
      .borderRadius(18)
      .backgroundColor(this.selected ? '#DDE5EA' : '#00FFFFFF')

      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.selected ? PRIMARY_COLOR : '#4A4A54')
        .margin({ top: 8 })
    }
    .width('33.3%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}