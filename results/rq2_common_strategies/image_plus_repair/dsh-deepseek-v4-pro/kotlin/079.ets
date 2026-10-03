interface DeviceItem {
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
}

interface NavItem {
  icon: string;
  label: string;
}

@Entry
@Component
struct SmartHomePage {
  build() {
    Column() {
      Scroll() {
        Column() {
          Row().width('100%').height(24)
          HeaderSection()
          Row().width('100%').height(32)
          EnvironmentSummary()
          Row().width('100%').height(32)
          DevicesGrid()
          Row().width('100%').height(16)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

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
          .fontColor('#333333')
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('👤')
          .fontSize(32)
          .fontColor('#4A6572')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#1A4A6572')
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
      EnvironmentCard({ title: 'Temperature', value: '24°C', subtitle: 'Comfortable', cardColor: '#E3F2FD', textColor: '#1565C0' })
      EnvironmentCard({ title: 'Humidity', value: '45%', subtitle: 'Normal', cardColor: '#E8F5E9', textColor: '#2E7D32' })
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  title: string = '';
  value: string = '';
  subtitle: string = '';
  cardColor: string = '';
  textColor: string = '';

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontColor('#CC' + this.textColor.substring(1))
      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor('#B3' + this.textColor.substring(1))
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(16)
    .backgroundColor(this.cardColor)
    .layoutWeight(1)
  }
}

@Component
struct DevicesGrid {
  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '🏠', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '🔒', isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: '⭐', isActive: false },
    { name: 'Router', status: 'Online', icon: '📍', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: 'ℹ️', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '🔔', isActive: true }
  ];

  build() {
    Column() {
      Text('My Devices')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
      Row().width('100%').height(16)
      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({ name: device.name, icon: device.icon, initialActive: device.isActive })
          }
        }, (device: DeviceItem) => device.name)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .height(452)
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct DeviceCard {
  name: string = '';
  icon: string = '';
  initialActive: boolean = false;
  @State isChecked: boolean = false;

  aboutToAppear(): void {
    this.isChecked = this.initialActive;
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.icon)
            .fontSize(20)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? '#33FFFFFF' : '#F0F0F0')

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(32)
          .height(16)
          .selectedColor('#66FFFFFF')
          .switchPointColor(this.isChecked ? '#FFFFFF' : '#888888')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#B3000000')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .borderRadius(20)
    .backgroundColor(this.isChecked ? '#4A6572' : '#FFFFFF')
    .shadow({ radius: this.isChecked ? 8 : 2, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
  }
}

@Component
struct SmartHomeBottomBar {
  @State selectedIndex: number = 0;
  private items: NavItem[] = [
    { icon: '🏠', label: 'Home' },
    { icon: '⭐', label: 'Scenes' },
    { icon: '⚙️', label: 'Settings' }
  ];

  build() {
    Row() {
      ForEach(this.items, (item: NavItem, index: number) => {
        Column({ space: 2 }) {
          Stack() {
            Text(item.icon)
              .fontSize(22)
              .fontColor(index === this.selectedIndex ? '#4A6572' : '#888888')
          }
          .width(48)
          .height(28)
          .borderRadius(14)
          .backgroundColor(index === this.selectedIndex ? '#1A4A6572' : 'rgba(0,0,0,0)')

          Text(item.label)
            .fontSize(11)
            .fontColor(index === this.selectedIndex ? '#4A6572' : '#888888')
        }
        .layoutWeight(1)
        .height(64)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          this.selectedIndex = index;
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
  }
}
