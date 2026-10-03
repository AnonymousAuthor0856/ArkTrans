import prompt from '@ohos.promptAction';

@Observed
class DeviceItem {
  id: string = ''
  name: string = ''
  status: string = ''
  icon: string = ''
  isActive: boolean = false
}

@Entry
@Component
struct SmartHomeScreen {
  @State deviceList: DeviceItem[] = [
    { id: '0', name: 'Living Room', status: '2 Lights On', icon: '\u{E80A}', isActive: true },
    { id: '1', name: 'Smart Lock', status: 'Locked', icon: '\u{E897}', isActive: true },
    { id: '2', name: 'Bedroom AC', status: '22°C', icon: '\u{E838}', isActive: false },
    { id: '3', name: 'Router', status: 'Online', icon: '\u{E8A7}', isActive: true },
    { id: '4', name: 'Kitchen', status: 'All Off', icon: '\u{E88E}', isActive: false },
    { id: '5', name: 'Corridor', status: 'Motion Detected', icon: '\u{E7F4}', isActive: true }
  ]

  private primaryColor: string = '#4A6572'
  private bgColor: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        List() {
          ListItem() {
            Column({ space: 0 }) {
              Blank().height(24)

              HeaderSection({ primaryColor: this.primaryColor })
                .padding({ left: 24, right: 24 })

              Blank().height(32)

              EnvironmentSummary()
                .padding({ left: 24, right: 24 })

              Blank().height(32)

              DevicesGrid({ deviceList: this.deviceList, primaryColor: this.primaryColor })
                .padding({ left: 24, right: 24 })

              Blank().height(100)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
          }
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.bgColor)
  }
}

@Component
struct HeaderSection {
  primaryColor: string = '#4A6572'

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#888888')

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill(this.primaryColor + '1A')

        Text('\u{E7FD}')
          .fontSize(32)
          .fontColor(this.primaryColor)
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
    }
    .width('100%')
  }
}

@Component
struct EnvironmentCard {
  title: string = ''
  value: string = ''
  subtitle: string = ''
  bgColor: string = '#FFFFFF'
  textColor: string = '#000000'

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor + 'CC')

      Blank()

      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)

        Text(this.subtitle)
          .fontSize(11)
          .fontColor(this.textColor + 'B3')
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
  @Link deviceList: DeviceItem[]
  primaryColor: string = '#4A6572'

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')

      Grid() {
        ForEach(this.deviceList, (item: DeviceItem) => {
          GridItem() {
            DeviceCard({ device: item, primaryColor: this.primaryColor })
          }
        }, (item: DeviceItem) => item.id)
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
  @ObjectLink device: DeviceItem
  primaryColor: string = '#4A6572'

  private get isChecked(): boolean {
    return this.device.isActive
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(36)
            .height(36)
            .fill(this.isChecked ? 'rgba(255, 255, 255, 0.2)' : '#F0F0F0')

          Text(this.device.icon)
            .fontSize(14)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.device.isActive })
          .selectedColor('#FFFFFF')
          .switchPointColor('#FFFFFF')
          .onChange((isOn: boolean) => {
            this.device.isActive = isOn
          })
          .scale({ x: 0.7, y: 0.7 })
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? 'rgba(255, 255, 255, 0.7)' : '#888888')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: this.isChecked ? this.primaryColor + '4D' : 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Component
struct SmartHomeBottomBar {
  primaryColor: string = '#4A6572'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Row() {
        Blank()

        NavBarItem({ icon: '\u{E88A}', label: 'Home', isSelected: true, primaryColor: this.primaryColor })

        Blank()

        NavBarItem({ icon: '\u{E838}', label: 'Scenes', isSelected: false, primaryColor: this.primaryColor })

        Blank()

        NavBarItem({ icon: '\u{E8B8}', label: 'Settings', isSelected: false, primaryColor: this.primaryColor })

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
      color: 'rgba(0, 0, 0, 0.05)',
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
      Stack({ alignContent: Alignment.Center }) {
        if (this.isSelected) {
          Ellipse()
            .width(64)
            .height(32)
            .fill(this.primaryColor + '1A')
        }

        Text(this.icon)
          .fontSize(24)
          .fontColor(this.isSelected ? this.primaryColor : '#888888')
      }
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? this.primaryColor : '#888888')
    }
    .justifyContent(FlexAlign.Center)
  }
}
