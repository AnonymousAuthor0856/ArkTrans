interface DeviceItem {
  id: number;
  name: string;
  status: string;
  isActive: boolean;
}

@Entry
@Component
struct SmartHomeScreen {
  primaryCol: string = '#4A6572';
  bgColor: string = '#F5F6F8';

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            HeaderSection({ primaryColor: this.primaryCol })
              .margin({ top: 24, left: 24, right: 24 })

            EnvironmentSummary()
              .margin({ top: 32, left: 24, right: 24 })

            DevicesGrid({ primaryColor: this.primaryCol })
              .margin({ top: 32, left: 24, right: 24, bottom: 100 })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.bgColor)

      SmartHomeBottomBar({ primaryColor: this.primaryCol })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
  }
}

@Component
struct HeaderSection {
  primaryColor: string = '#4A6572';

  build() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#888888')
          .margin({ bottom: 4 })
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#1A4A6572')

        Text('👤')
          .fontSize(24)
          .fontColor(this.primaryColor)
      }
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
        cardBgColor: '#E3F2FD',
        cardTextColor: '#1565C0'
      })

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        cardBgColor: '#E8F5E9',
        cardTextColor: '#2E7D32'
      })
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  cardBgColor: string = '#FFFFFF';
  cardTextColor: string = '#000000';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.cardTextColor)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cardTextColor)
          .alignSelf(ItemAlign.Start)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.cardTextColor)
          .opacity(0.7)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .height(100)
    .backgroundColor(this.cardBgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DevicesGrid {
  primaryColor: string = '#4A6572';

  devices: DeviceItem[] = [
    { id: 1, name: 'Living Room', status: '2 Lights On', isActive: true },
    { id: 2, name: 'Smart Lock', status: 'Locked', isActive: true },
    { id: 3, name: 'Bedroom AC', status: '22°C', isActive: false },
    { id: 4, name: 'Router', status: 'Online', isActive: true },
    { id: 5, name: 'Kitchen', status: 'All Off', isActive: false },
    { id: 6, name: 'Corridor', status: 'Motion Detected', isActive: true }
  ];

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .alignSelf(ItemAlign.Start)

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        }, (device: DeviceItem) => device.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = { id: 0, name: '', status: '', isActive: false };
  primaryColor: string = '#4A6572';
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  getIconText(): string {
    const iconMap: Record<number, string> = {
      1: '🏠',
      2: '🔒',
      3: '❄️',
      4: '📡',
      5: '🍳',
      6: '🔔'
    };
    return iconMap[this.device.id] || '💡';
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.isChecked ? '#33FFFFFF' : '#F0F0F0')

          Text(this.getIconText())
            .fontSize(16)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor(this.isChecked ? '#FFFFFF' : '#CCCCCC')
          .switchPointColor(this.isChecked ? this.primaryColor : '#FFFFFF')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .width(44)
          .height(26)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .alignSelf(ItemAlign.Start)
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#FFFFFFB3' : '#888888')
          .alignSelf(ItemAlign.Start)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? '#4D4A6572' : '#0D000000',
      offsetX: 0,
      offsetY: 4
    })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: string = '#4A6572';

  build() {
    Row() {
      NavBarItem({ icon: '🏠', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
      Blank()
      NavBarItem({ icon: '⭐', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
      Blank()
      NavBarItem({ icon: '⚙️', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
    }
    .width('100%')
    .height(80)
    .padding({ left: 24, right: 24, top: 12 })
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Top)
  }
}

@Component
struct NavBarItem {
  icon: string = '';
  label: string = '';
  isSelected: boolean = false;
  primaryColor: string = '#4A6572';

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor('#1A4A6572')
            .borderRadius(16)
        }
        Text(this.icon)
          .fontSize(22)
          .fontColor(this.isSelected ? this.primaryColor : '#888888')
      }
      .width(64)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }
}