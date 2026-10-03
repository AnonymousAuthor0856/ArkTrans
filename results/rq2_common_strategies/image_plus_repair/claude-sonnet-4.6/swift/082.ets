@Entry
@Component
struct SmartHomeScreen {
  @State primaryColorVal: string = '#4A6572'
  @State backgroundColorVal: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Blank().height(24)
            HeaderSection({ primaryColor: this.primaryColorVal })
              .margin({ left: 24, right: 24 })
            Blank().height(32)
            EnvironmentSummary()
              .margin({ left: 24, right: 24 })
            Blank().height(32)
            DevicesGrid({ primaryColor: this.primaryColorVal })
              .margin({ left: 24, right: 24 })
            Blank().height(100)
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
      .backgroundColor(this.backgroundColorVal)

      SmartHomeBottomBar({ primaryColor: this.primaryColorVal })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColorVal)
  }
}

@Component
struct HeaderSection {
  primaryColor: string = '#4A6572'

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
          .fill('#1A4A6572')
          .width(48)
          .height(48)
        Text('👤')
          .fontSize(28)
          .fontColor(this.primaryColor)
      }
      .width(48)
      .height(48)
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
  title: string = ''
  value: string = ''
  subtitle: string = ''
  bgColor: string = '#E3F2FD'
  textColor: string = '#1565C0'

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)
        .alignSelf(ItemAlign.Start)

      Blank()

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)
          .alignSelf(ItemAlign.Start)
        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor)
          .opacity(0.7)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .width('100%')
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
  }
}

interface DeviceItemData {
  id: number;
  name: string;
  status: string;
  icon: string;
  isActive: boolean;
}

@Component
struct DevicesGrid {
  primaryColor: string = '#4A6572'
  devices: DeviceItemData[] = [
    { id: 1, name: 'Living Room', status: '2 Lights On', icon: '🏠', isActive: true },
    { id: 2, name: 'Smart Lock', status: 'Locked', icon: '🔒', isActive: true },
    { id: 3, name: 'Bedroom AC', status: '22°C', icon: '❄️', isActive: false },
    { id: 4, name: 'Router', status: 'Online', icon: '📡', isActive: true },
    { id: 5, name: 'Kitchen', status: 'All Off', icon: '🍳', isActive: false },
    { id: 6, name: 'Corridor', status: 'Motion Detected', icon: '🔔', isActive: true }
  ]

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .alignSelf(ItemAlign.Start)

      Grid() {
        ForEach(this.devices, (device: DeviceItemData) => {
          GridItem() {
            DeviceCard({ device: device, primaryColor: this.primaryColor })
          }
        }, (device: DeviceItemData) => device.id.toString())
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
  device: DeviceItemData = { id: 0, name: '', status: '', icon: '', isActive: false }
  primaryColor: string = '#4A6572'
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.device.isActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.isChecked ? '#334D5C' : '#F0F0F0')
            .width(36)
            .height(36)
          Text(this.device.icon)
            .fontSize(16)
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
          .selectedColor('#FFFFFF66')
          .switchPointColor(this.isChecked ? '#FFFFFF' : '#CCCCCC')
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
      .width('100%')
    }
    .padding(16)
    .height(140)
    .width('100%')
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
  primaryColor: string = '#4A6572'

  build() {
    Row() {
      NavBarItem({ icon: '🏠', label: 'Home', isSelected: true, primaryColor: this.primaryColor })
      NavBarItem({ icon: '⭐', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })
      NavBarItem({ icon: '⚙️', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })
    }
    .width('100%')
    .height(80)
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .padding({ top: 8, bottom: 8 })
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Component
struct NavBarItem {
  icon: string = ''
  label: string = ''
  isSelected: boolean = false
  primaryColor: string = '#4A6572'

  build() {
    Column({ space: 4 }) {
      Stack() {
        if (this.isSelected) {
          Text('')
            .width(64)
            .height(32)
            .backgroundColor('#1A4A6572')
            .borderRadius(16)
        }
        Text(this.icon)
          .fontSize(22)
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