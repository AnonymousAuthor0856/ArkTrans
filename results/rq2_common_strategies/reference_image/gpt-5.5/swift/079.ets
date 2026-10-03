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
  private backgroundColor: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            Blank().height(24)

            HeaderSection({ primaryColor: this.primaryColor })
              .margin({ left: 24, right: 24 })

            Blank().height(32)

            EnvironmentSummary()
              .margin({ left: 24, right: 24 })

            Blank().height(32)

            DevicesGrid({ primaryColor: this.primaryColor })
              .margin({ left: 24, right: 24 })

            Blank().height(120)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)

      SmartHomeBottomBar({ primaryColor: this.primaryColor })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}

@Component
struct HeaderSection {
  @Prop primaryColor: string

  @Builder
  Avatar() {
    Stack({ alignContent: Alignment.Center }) {
      Stack() {}
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#E7ECEF')

      Stack({ alignContent: Alignment.Center }) {
        Column({ space: 4 }) {
          Stack() {}
          .width(9)
          .height(9)
          .borderRadius(5)
          .backgroundColor('#FFFFFF')

          Stack() {}
          .width(22)
          .height(12)
          .borderRadius(12)
          .backgroundColor('#FFFFFF')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.primaryColor)
    }
    .width(48)
    .height(48)
  }

  build() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor('#8E8E96')
          .fontWeight(FontWeight.Regular)

        Text('Alex Johnson')
          .fontSize(28)
          .fontColor('#000000')
          .fontWeight(FontWeight.Bold)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      this.Avatar()
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
  @Prop title: string
  @Prop value: string
  @Prop subtitle: string
  @Prop bgColor: string
  @Prop textColor: string

  build() {
    Column() {
      Text(this.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textColor)
        .opacity(0.8)

      Blank()

      Column({ space: 0 }) {
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
    .justifyContent(FlexAlign.Start)
    .padding(16)
    .width('100%')
    .height(100)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
  }
}

@Component
struct DevicesGrid {
  @Prop primaryColor: string

  private devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '⌂', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '▣', isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: '★', isActive: false },
    { name: 'Router', status: 'Online', icon: '➤', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: 'i', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '!', isActive: true }
  ]

  build() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#000000')
        .width('100%')

      Grid() {
        ForEach(this.devices, (device: DeviceItem) => {
          GridItem() {
            DeviceCard({
              name: device.name,
              status: device.status,
              icon: device.icon,
              active: device.isActive,
              primaryColor: this.primaryColor
            })
          }
        }, (device: DeviceItem) => device.name)
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(16)
      .rowsGap(16)
      .width('100%')
      .height(452)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  @Prop name: string
  @Prop status: string
  @Prop icon: string
  @Prop active: boolean
  @Prop primaryColor: string

  @State checked: boolean = false

  aboutToAppear() {
    this.checked = this.active
  }

  @Builder
  DeviceSwitch() {
    Row() {
      if (this.checked) {
        Blank().layoutWeight(1)
      }

      Stack() {}
      .width(26)
      .height(26)
      .borderRadius(13)
      .backgroundColor('#FFFFFF')
      .shadow({
        radius: 3,
        color: '#33000000',
        offsetX: 0,
        offsetY: 1
      })

      if (!this.checked) {
        Blank().layoutWeight(1)
      }
    }
    .width(52)
    .height(30)
    .padding({ left: 2, right: 2 })
    .backgroundColor(this.checked ? '#91A5AE' : '#F7F7F7')
    .borderRadius(15)
    .border({
      width: this.checked ? 0 : 1,
      color: this.checked ? '#00000000' : '#C9C9CE'
    })
    .onClick(() => {
      this.checked = !this.checked
    })
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Stack() {}
          .width(36)
          .height(36)
          .borderRadius(18)
          .backgroundColor(this.checked ? '#78909C' : '#F0F0F0')

          Text(this.icon)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.checked ? '#FFFFFF' : '#8E8E96')
        }
        .width(36)
        .height(36)

        Blank()

        this.DeviceSwitch()
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank()

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? '#FFFFFF' : '#000000')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.checked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.checked ? '#CCFFFFFF' : '#8E8E96')
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.checked ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 16,
      color: this.checked ? '#334A6572' : '#12000000',
      offsetX: 0,
      offsetY: 8
    })
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop primaryColor: string

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Stack() {}
      .width('100%')
      .height(80)
      .backgroundColor('#FFFFFF')
      .borderRadius({
        topLeft: 24,
        topRight: 24,
        bottomLeft: 0,
        bottomRight: 0
      })
      .shadow({
        radius: 4,
        color: '#14000000',
        offsetX: 0,
        offsetY: -2
      })

      Row() {
        Blank().layoutWeight(1)

        NavBarItem({
          icon: '⌂',
          label: 'Home',
          selected: true,
          primaryColor: this.primaryColor
        })

        Blank().layoutWeight(1)

        NavBarItem({
          icon: '★',
          label: 'Scenes',
          selected: false,
          primaryColor: this.primaryColor
        })

        Blank().layoutWeight(1)

        NavBarItem({
          icon: '⚙',
          label: 'Settings',
          selected: false,
          primaryColor: this.primaryColor
        })

        Blank().layoutWeight(1)
      }
      .width('100%')
      .height(80)
      .padding({ top: 16 })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height(80)
  }
}

@Component
struct NavBarItem {
  @Prop icon: string
  @Prop label: string
  @Prop selected: boolean
  @Prop primaryColor: string

  build() {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        if (this.selected) {
          Stack() {}
          .width(64)
          .height(32)
          .borderRadius(16)
          .backgroundColor('#E7ECEF')
        }

        Text(this.icon)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.selected ? this.primaryColor : '#8E8E96')
      }
      .width(70)
      .height(32)

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selected ? this.primaryColor : '#8E8E96')
    }
    .width(88)
    .alignItems(HorizontalAlign.Center)
  }
}