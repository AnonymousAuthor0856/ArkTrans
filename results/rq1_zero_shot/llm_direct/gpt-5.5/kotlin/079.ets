interface DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean
}

const PRIMARY_COLOR: string = '#4A6572'
const BACKGROUND_COLOR: string = '#F5F6F8'
const SURFACE_COLOR: string = '#FFFFFF'
const TEXT_COLOR: string = '#333333'

@Entry
@Component
struct SmartHomeScreen {
  private devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '⌂', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '🔒', isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: '★', isActive: false },
    { name: 'Router', status: 'Online', icon: '⌖', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: 'ℹ', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '🔔', isActive: true }
  ]

  build() {
    Column() {
      Column() {
        Blank().height(24)

        HeaderSection()

        Blank().height(32)

        EnvironmentSummary()

        Blank().height(32)

        Column() {
          Text('My Devices')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(TEXT_COLOR)

          Blank().height(16)

          Grid() {
            ForEach(this.devices, (device: DeviceItem) => {
              GridItem() {
                DeviceCard({ device: device })
              }
            }, (device: DeviceItem) => device.name)
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(16)
          .rowsGap(16)
          .padding({ bottom: 16 })
          .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })

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
          .fontColor('#808080')

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_COLOR)
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('👤')
          .fontSize(30)
          .fontColor(PRIMARY_COLOR)
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
    Row() {
      EnvironmentCard({
        title: 'Temperature',
        value: '24°C',
        subtitle: 'Comfortable',
        color: '#E3F2FD',
        textColor: '#1565C0'
      })
        .layoutWeight(1)

      Blank().width(16)

      EnvironmentCard({
        title: 'Humidity',
        value: '45%',
        subtitle: 'Normal',
        color: '#E8F5E9',
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
  color: string = '#FFFFFF'
  textColor: string = '#000000'

  build() {
    Column() {
      Text(this.title)
        .fontSize(13)
        .fontColor(this.textColor)
        .opacity(0.8)

      Column() {
        Text(this.value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textColor)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(this.textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(100)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.color)
    .borderRadius(16)
  }
}

@Component
struct DeviceCard {
  device: DeviceItem = { name: '', status: '', icon: '', isActive: false }
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.device.isActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Text(this.device.icon)
            .fontSize(18)
            .fontColor(this.isChecked ? '#FFFFFF' : '#808080')
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? '#33FFFFFF' : '#F0F0F0')

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(36)
          .height(20)
          .selectedColor('#66FFFFFF')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(this.device.name)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')

        Blank().height(4)

        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(12)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .height(140)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(this.isChecked ? PRIMARY_COLOR : SURFACE_COLOR)
    .borderRadius(20)
    .shadow({
      radius: this.isChecked ? 16 : 4,
      color: this.isChecked ? '#334A6572' : '#1A000000',
      offsetX: 0,
      offsetY: this.isChecked ? 8 : 2
    })
  }
}

@Component
struct SmartHomeBottomBar {
  build() {
    Row() {
      BottomBarItem({
        icon: '⌂',
        label: 'Home',
        selected: true
      })

      BottomBarItem({
        icon: '★',
        label: 'Scenes',
        selected: false
      })

      BottomBarItem({
        icon: '⚙',
        label: 'Settings',
        selected: false
      })
    }
    .width('100%')
    .height(76)
    .padding({ left: 20, right: 20, top: 8, bottom: 8 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE_COLOR)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .shadow({
      radius: 16,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}

@Component
struct BottomBarItem {
  icon: string = ''
  label: string = ''
  selected: boolean = false

  build() {
    Column() {
      Stack() {
        Text(this.icon)
          .fontSize(22)
          .fontColor(this.selected ? PRIMARY_COLOR : '#777777')
      }
      .width(56)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.selected ? '#1A4A6572' : '#00000000')

      Text(this.label)
        .fontSize(12)
        .fontColor(this.selected ? PRIMARY_COLOR : '#777777')
        .margin({ top: 2 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}