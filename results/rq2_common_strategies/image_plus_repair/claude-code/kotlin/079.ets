interface DeviceItem {
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
}

interface BottomTabItem {
  icon: string;
  label: string;
}

@Entry
@Component
struct SmartHomeScreen {
  @State selectedTab: number = 0;

  build() {
    Column() {
      Column() {
        HeaderSection()
        EnvironmentSummary()
        DevicesGrid()
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24, top: 24 })

      SmartHomeBottomBar({ selectedTab: this.selectedTab, onTabChange: (index: number) => {
        this.selectedTab = index;
      } })
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
          .fontColor('#999999')
        Text('Alex Johnson')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('\u{1F464}')
          .fontSize(28)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('rgba(74, 101, 114, 0.1)')
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
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

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        bgColor: '#E8F5E9',
        textColor: '#2E7D32'
      })
      .layoutWeight(1)
      .margin({ left: 16 })
    }
    .width('100%')
    .margin({ top: 32 })
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  bgColor: string = '';
  textColor: string = '';

  build() {
    Column() {
      Text(this.title)
        .fontSize(14)
        .fontColor(this.textColor)
        .opacity(0.8)

      Column() {
        Text(this.value)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(this.textColor)
          .opacity(0.7)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  private devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '\u{2302}', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '\u{1F512}', isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: '\u{2B50}', isActive: false },
    { name: 'Router', status: 'Online', icon: '\u{25CE}', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: '\u{2139}', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '\u{1F514}', isActive: true }
  ];

  build() {
    Column() {
      Text('My Devices')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Grid() {
        ForEach(this.devices, (item: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: item })
          }
        }, (item: DeviceItem) => item.name)
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .margin({ top: 32 })
  }
}

@Component
struct DeviceCard {
  @State device: DeviceItem = { name: '', status: '', icon: '', isActive: false };
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.device.icon)
            .fontSize(18)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? 'rgba(255, 255, 255, 0.2)' : '#F0F0F0')

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
          .width(48)
          .height(28)
          .selectedColor(this.isChecked ? 'rgba(255, 255, 255, 0.4)' : '#CCCCCC')
          .switchPointColor('#FFFFFF')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#333333')
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(12)
          .fontColor(this.isChecked ? '#FFFFFF' : '#666666')
          .opacity(this.isChecked ? 0.7 : 1)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: this.isChecked ? 12 : 4,
      color: 'rgba(0, 0, 0, 0.15)',
      offsetX: 0,
      offsetY: this.isChecked ? 6 : 2
    })
  }
}

@Component
struct SmartHomeBottomBar {
  selectedTab: number = 0;
  onTabChange: (index: number) => void = (index: number) => {};

  private tabs: BottomTabItem[] = [
    { icon: '\u{2302}', label: 'Home' },
    { icon: '\u{2B50}', label: 'Scenes' },
    { icon: '\u{2699}', label: 'Settings' }
  ];

  build() {
    Row() {
      ForEach(this.tabs, (tab: BottomTabItem, index: number) => {
        Column() {
          Text(tab.icon)
            .fontSize(22)
            .fontColor(this.selectedTab === index ? '#4A6572' : '#666666')
          Text(tab.label)
            .fontSize(12)
            .fontColor(this.selectedTab === index ? '#4A6572' : '#666666')
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.onTabChange(index);
        })
      }, (tab: BottomTabItem) => tab.label)
    }
    .width('100%')
    .height(72)
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.08)',
      offsetY: -2
    })
  }
}
