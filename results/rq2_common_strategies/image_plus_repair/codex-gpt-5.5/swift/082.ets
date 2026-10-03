interface DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean
}

@Entry
@Component
struct SmartHomeScreen {
  private primaryColor: string = '#4A6572'
  private pageBgColor: string = '#F5F6F8'

  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '\u2302', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '\u25A3', isActive: true },
    { name: 'Bedroom AC', status: '22\u00B0C', icon: '\u2726', isActive: false },
    { name: 'Router', status: 'Online', icon: '\u25CE', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: '\u2139', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '\u25CF', isActive: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Blank()
            .height(24)

          Row() {
            this.HeaderSection()
          }
          .width('100%')
            .margin({ left: 24, right: 24 })

          Blank()
            .height(32)

          Row() {
            this.EnvironmentSummary()
          }
          .width('100%')
            .margin({ left: 24, right: 24 })

          Blank()
            .height(32)

          Column() {
            this.DevicesGrid()
          }
          .width('100%')
            .margin({ left: 24, right: 24 })

          Blank()
            .height(108)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      this.SmartHomeBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.pageBgColor)
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor('#80848A')
          .lineHeight(22)

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .lineHeight(38)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill('#E9EEF0')

        Text('\u25C9')
          .fontSize(31)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.primaryColor)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentSummary() {
    Row() {
      Column() {
        this.EnvironmentCard('Temperature', '24\u00B0C', 'Comfortable', '#E3F2FD', '#1565C0')
      }
        .layoutWeight(1)

      Blank()
        .width(16)

      Column() {
        this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
      }
        .layoutWeight(1)
    }
    .width('100%')
    .height(100)
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textColor)
        .opacity(0.82)
        .lineHeight(17)

      Blank()

      Column() {
        Text(value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
          .lineHeight(29)

        Text(subtitle)
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(textColor)
          .opacity(0.72)
          .lineHeight(15)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .height(100)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(bgColor)
    .borderRadius(16)
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .lineHeight(28)
        .margin({ bottom: 16 })

      Grid() {
        ForEach(this.devices, (device: DeviceItem, index: number) => {
          GridItem() {
            this.DeviceCard(device, index)
          }
        }, (device: DeviceItem) => device.name)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  DeviceCard(device: DeviceItem, index: number) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(36)
            .height(36)
            .fill(device.isActive ? '#6F838C' : '#F0F0F0')

          Text(device.icon)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(device.isActive ? '#FFFFFF' : '#85888C')
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: device.isActive })
          .width(42)
          .height(24)
          .selectedColor(device.isActive ? '#FFFFFF66' : '#D5D7DA')
          .switchPointColor(device.isActive ? '#FFFFFF' : '#FFFFFF')
          .onChange((isOn: boolean) => {
            this.devices[index] = {
              name: this.devices[index].name,
              status: this.devices[index].status,
              icon: this.devices[index].icon,
              isActive: isOn
            }
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(device.isActive ? '#FFFFFF' : '#000000')
          .lineHeight(20)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(device.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontWeight(FontWeight.Regular)
          .fontColor(device.isActive ? '#FFFFFF' : '#85888C')
          .opacity(device.isActive ? 0.72 : 1)
          .lineHeight(15)
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(device.isActive ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: device.isActive ? '#4D4A6572' : '#0D000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  SmartHomeBottomBar() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
      }
        .width('100%')
        .height(80)
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 4, color: '#0D000000', offsetX: 0, offsetY: -2 })

      Row() {
        Blank()
        this.NavBarItem('\u2302', 'Home', true)
        Blank()
        this.NavBarItem('\u2726', 'Scenes', false)
        Blank()
        this.NavBarItem('\u2699', 'Settings', false)
        Blank()
      }
      .width('100%')
      .padding({ top: 16 })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height(80)
  }

  @Builder
  NavBarItem(icon: string, label: string, isSelected: boolean) {
    Column() {
      Stack({ alignContent: Alignment.Center }) {
        if (isSelected) {
          Rect()
            .width(64)
            .height(32)
            .fill('#1A4A6572')
            .radius(16)
        }

        Text(icon)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(isSelected ? this.primaryColor : '#85888C')
      }
      .width(64)
      .height(32)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? this.primaryColor : '#85888C')
        .lineHeight(17)
        .margin({ top: 4 })
    }
    .width(76)
    .alignItems(HorizontalAlign.Center)
  }
}
