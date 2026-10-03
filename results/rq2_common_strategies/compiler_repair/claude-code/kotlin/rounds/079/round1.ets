@Entry
@Component
struct SmartHomeScreen {
  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: '2 Lights On', icon: '🏠', isActive: true },
    { name: 'Smart Lock', status: 'Locked', icon: '🔒', isActive: true },
    { name: 'Bedroom AC', status: '22°C', icon: '⭐', isActive: false },
    { name: 'Router', status: 'Online', icon: '📍', isActive: true },
    { name: 'Kitchen', status: 'All Off', icon: 'ℹ', isActive: false },
    { name: 'Corridor', status: 'Motion Detected', icon: '🔔', isActive: true }
  ]
  @State selectedTab: number = 0

  build() {
    Column() {
      Column() {
        Column() {
          this.HeaderSection()
          this.EnvironmentSummary()
          this.DevicesGrid()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 24, right: 24, top: 24 })

        this.SmartHomeBottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F6F8')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  HeaderSection() {
    Row() {
      Column() {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(Color.Gray)
        Text('Alex Johnson')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Stack() {
        Text('👤')
          .fontSize(28)
          .fontColor('#4A6572')
      }
      .width(48)
      .height(48)
      .backgroundColor('rgba(74, 101, 114, 0.1)')
      .borderRadius(24)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentSummary() {
    Row() {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0')
      this.EnvironmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bgColor: ResourceColor, textColor: ResourceColor) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontColor(textColor)
        .opacity(0.8)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
        Text(subtitle)
          .fontSize(11)
          .fontColor(textColor)
          .opacity(0.7)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 'auto' })
    }
    .width(0)
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  DevicesGrid() {
    Column() {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 16 })

      Grid() {
        ForEach(this.devices, (item: DeviceItem, index: number) => {
          GridItem() {
            this.DeviceCard(item, index)
          }
        }, (item: DeviceItem) => item.name)
      }
      .columnsTemplate('1fr 1fr')
      .rowsGap(16)
      .columnsGap(16)
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  DeviceCard(device: DeviceItem, index: number) {
    Column() {
      Row() {
        Stack() {
          Text(device.icon)
            .fontSize(16)
            .fontColor(device.isActive ? Color.White : Color.Gray)
        }
        .width(36)
        .height(36)
        .backgroundColor(device.isActive ? 'rgba(255, 255, 255, 0.2)' : '#F0F0F0')
        .borderRadius(18)

        Toggle({ type: ToggleType.Switch, isOn: device.isActive })
          .onChange((isOn: boolean) => {
            this.devices[index].isActive = isOn
          })
          .width(32)
          .height(16)
          .selectedColor(device.isActive ? 'rgba(255, 255, 255, 0.4)' : '#CCCCCC')
          .switchPointColor(device.isActive ? Color.White : Color.Gray)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(device.isActive ? Color.White : '#333333')
        Text(device.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(device.isActive ? Color.White : '#999999')
          .opacity(0.7)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 'auto' })
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(device.isActive ? '#4A6572' : Color.White)
    .borderRadius(20)
    .shadow({
      radius: device.isActive ? 8 : 2,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: device.isActive ? 4 : 1
    })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  SmartHomeBottomBar() {
    Row() {
      this.BottomNavItem('🏠', 'Home', 0)
      this.BottomNavItem('⭐', 'Scenes', 1)
      this.BottomNavItem('⚙', 'Settings', 2)
    }
    .width('100%')
    .height(64)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetY: -2
    })
  }

  @Builder
  BottomNavItem(icon: string, label: string, index: number) {
    Column() {
      Text(icon)
        .fontSize(20)
        .fontColor(this.selectedTab === index ? '#4A6572' : '#999999')
      Text(label)
        .fontSize(11)
        .fontColor(this.selectedTab === index ? '#4A6572' : '#999999')
        .margin({ top: 4 })
    }
    .width(60)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedTab = index
    })
  }
}

interface DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean
}
