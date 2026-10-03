@Entry
@Component
struct SmartHomeScreen {
  @State selectedTab: number = 0

  build() {
    Column() {
      // Main content
      Column() {
        // Header Section
        Row() {
          Column() {
            Text('Welcome Home,')
              .fontSize(14)
              .fontColor('#999999')
            Text('Alex Johnson')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          // Avatar circle
          Stack() {
            Circle()
              .width(48)
              .height(48)
              .fill('#1A4A6572')
            Text('AJ')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#4A6572')
          }
          .width(48)
          .height(48)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        // Environment Summary
        Row() {
          // Temperature Card
          Column() {
            Text('Temperature')
              .fontSize(12)
              .fontColor('#1A1565C0')
              .margin({ bottom: 8 })
            Text('24°C')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#1565C0')
            Text('Comfortable')
              .fontSize(11)
              .fontColor('#B31565C0')
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding(16)
          .height(100)
          .layoutWeight(1)
          .backgroundColor('#E3F2FD')
          .borderRadius(16)

          Blank().width(16)

          // Humidity Card
          Column() {
            Text('Humidity')
              .fontSize(12)
              .fontColor('#1A2E7D32')
              .margin({ bottom: 8 })
            Text('45%')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#2E7D32')
            Text('Normal')
              .fontSize(11)
              .fontColor('#B32E7D32')
          }
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)
          .padding(16)
          .height(100)
          .layoutWeight(1)
          .backgroundColor('#E8F5E9')
          .borderRadius(16)
        }
        .width('100%')
        .margin({ top: 32 })

        // Devices Grid
        Column() {
          Text('My Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .margin({ bottom: 16 })

          DevicesGrid()
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .margin({ top: 32 })
      }
      .padding({ left: 24, right: 24 })
      .layoutWeight(1)

      // Bottom Navigation Bar
      SmartHomeBottomBar({ selectedTab: this.selectedTab, onTabChange: (tab: number) => { this.selectedTab = tab } })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}

@Component
struct DevicesGrid {
  build() {
    Grid() {
      GridItem() {
        DeviceCard({ name: 'Living Room', status: '2 Lights On', iconType: 'home', isActive: true })
      }
      GridItem() {
        DeviceCard({ name: 'Smart Lock', status: 'Locked', iconType: 'lock', isActive: true })
      }
      GridItem() {
        DeviceCard({ name: 'Bedroom AC', status: '22°C', iconType: 'star', isActive: false })
      }
      GridItem() {
        DeviceCard({ name: 'Router', status: 'Online', iconType: 'location', isActive: true })
      }
      GridItem() {
        DeviceCard({ name: 'Kitchen', status: 'All Off', iconType: 'info', isActive: false })
      }
      GridItem() {
        DeviceCard({ name: 'Corridor', status: 'Motion Detected', iconType: 'notification', isActive: true })
      }
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(16)
    .columnsGap(16)
    .width('100%')
    .height(480)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = ''
  @Prop status: string = ''
  @Prop iconType: string = 'home'
  @Prop isActive: boolean = false
  @State isChecked: boolean = false

  aboutToAppear() {
    this.isChecked = this.isActive
  }

  getIconText(): string {
    switch (this.iconType) {
      case 'home': return '🏠'
      case 'lock': return '🔒'
      case 'star': return '⭐'
      case 'location': return '📍'
      case 'info': return 'ℹ️'
      case 'notification': return '🔔'
      default: return '🏠'
    }
  }

  build() {
    Column() {
      Row() {
        // Icon circle
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.isChecked ? '#334A6572' : '#F0F0F0')
          Text(this.getIconText())
            .fontSize(16)
        }
        .width(36)
        .height(36)

        Blank()

        // Toggle switch
        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .width(44)
          .height(22)
          .selectedColor(this.isChecked ? '#80FFFFFF' : '#CCCCCC')
          .switchPointColor(this.isChecked ? '#FFFFFF' : '#888888')
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(this.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? '#FFFFFF' : '#000000')
        Text(this.isChecked ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.isChecked ? '#B3FFFFFF' : '#B3000000')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .height(140)
    .backgroundColor(this.isChecked ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: this.isChecked ? 8 : 2,
      color: '#1A000000',
      offsetX: 0,
      offsetY: this.isChecked ? 4 : 1
    })
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct SmartHomeBottomBar {
  @Prop selectedTab: number = 0
  onTabChange: (tab: number) => void = () => {}

  build() {
    Row() {
      // Home tab
      Column() {
        Text('⌂')
          .fontSize(22)
          .fontColor(this.selectedTab === 0 ? '#4A6572' : '#888888')
        Text('Home')
          .fontSize(12)
          .fontColor(this.selectedTab === 0 ? '#4A6572' : '#888888')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 8, bottom: 8 })
      .backgroundColor(this.selectedTab === 0 ? '#1A4A6572' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        this.onTabChange(0)
      })

      // Scenes tab
      Column() {
        Text('★')
          .fontSize(22)
          .fontColor(this.selectedTab === 1 ? '#4A6572' : '#888888')
        Text('Scenes')
          .fontSize(12)
          .fontColor(this.selectedTab === 1 ? '#4A6572' : '#888888')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 8, bottom: 8 })
      .backgroundColor(this.selectedTab === 1 ? '#1A4A6572' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        this.onTabChange(1)
      })

      // Settings tab
      Column() {
        Text('⚙')
          .fontSize(22)
          .fontColor(this.selectedTab === 2 ? '#4A6572' : '#888888')
        Text('Settings')
          .fontSize(12)
          .fontColor(this.selectedTab === 2 ? '#4A6572' : '#888888')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .padding({ top: 8, bottom: 8 })
      .backgroundColor(this.selectedTab === 2 ? '#1A4A6572' : Color.Transparent)
      .borderRadius(12)
      .onClick(() => {
        this.onTabChange(2)
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor('#FFFFFF')
    .padding({ left: 16, right: 16 })
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}