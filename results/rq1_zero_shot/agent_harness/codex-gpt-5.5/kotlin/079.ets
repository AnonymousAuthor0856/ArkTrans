class DeviceItem {
  name: string;
  status: string;
  icon: string;
  active: boolean;

  constructor(name: string, status: string, icon: string, active: boolean) {
    this.name = name;
    this.status = status;
    this.icon = icon;
    this.active = active;
  }
}

@Entry
@Component
struct MainActivity {
  @State devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '⌂', true),
    new DeviceItem('Smart Lock', 'Locked', '⌘', true),
    new DeviceItem('Bedroom AC', '22°C', '★', false),
    new DeviceItem('Router', 'Online', '⌖', true),
    new DeviceItem('Kitchen', 'All Off', 'i', false),
    new DeviceItem('Corridor', 'Motion Detected', '!', true)
  ];

  private toggleDevice(index: number, value: boolean): void {
    this.devices[index].active = value;
    this.devices = [...this.devices];
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#808080')
        Text('Alex Johnson')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('●')
        .fontSize(32)
        .fontColor('#4A6572')
        .textAlign(TextAlign.Center)
        .width(48)
        .height(48)
        .lineHeight(48)
        .backgroundColor('#1A4A6572')
        .borderRadius(24)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bg: string, fg: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(fg)
        .opacity(0.8)
      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(fg)
        Text(subtitle)
          .fontSize(11)
          .fontColor(fg)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(bg)
    .borderRadius(16)
  }

  @Builder
  EnvironmentSummary() {
    Row({ space: 16 }) {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
      this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
    }
    .width('100%')
  }

  @Builder
  DeviceCard(device: DeviceItem, index: number) {
    Column() {
      Row() {
        Text(device.icon)
          .fontSize(20)
          .fontColor(device.active ? '#FFFFFF' : '#808080')
          .textAlign(TextAlign.Center)
          .width(36)
          .height(36)
          .lineHeight(36)
          .backgroundColor(device.active ? '#33FFFFFF' : '#F0F0F0')
          .borderRadius(18)
        Toggle({ type: ToggleType.Switch, isOn: device.active })
          .selectedColor(device.active ? '#FFFFFF' : '#4A6572')
          .onChange((value: boolean) => {
            this.toggleDevice(index, value);
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(device.active ? '#FFFFFF' : '#000000')
        Text(device.active ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(device.active ? '#B3FFFFFF' : '#808080')
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(140)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(device.active ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: device.active ? 8 : 2, color: '#22000000', offsetY: device.active ? 4 : 1 })
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
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
      .margin({ top: 16 })
    }
    .width('100%')
  }

  @Builder
  BottomBar() {
    Row() {
      Column() {
        Text('⌂').fontSize(22).fontColor('#4A6572')
        Text('Home').fontSize(11).fontColor('#4A6572')
      }.alignItems(HorizontalAlign.Center)
      Column() {
        Text('★').fontSize(22).fontColor('#808080')
        Text('Scenes').fontSize(11).fontColor('#808080')
      }.alignItems(HorizontalAlign.Center)
      Column() {
        Text('⚙').fontSize(22).fontColor('#808080')
        Text('Settings').fontSize(11).fontColor('#808080')
      }.alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height(72)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 8, color: '#33000000', offsetY: -4 })
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          Blank().height(24)
          this.HeaderSection()
          Blank().height(32)
          this.EnvironmentSummary()
          Blank().height(32)
          this.DevicesGrid()
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}
