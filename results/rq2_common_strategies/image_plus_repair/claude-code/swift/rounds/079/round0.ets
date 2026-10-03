@Entry
@Component
struct SmartHomeScreen {
  @State devices: DeviceItem[] = [
    { name: 'Living Room', status: 'On', icon: 'home', isActive: true },
    { name: 'Smart Lock', status: 'On', icon: 'lock', isActive: true },
    { name: 'Bedroom AC', status: 'Off', icon: 'star', isActive: false },
    { name: 'Router', status: 'On', icon: 'navigate', isActive: true }
  ]
  @State selectedTab: number = 0

  private primaryColor: string = '#4A6572'
  private backgroundColor: string = '#F5F6F8'

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Scroll() {
          Column() {
            // Header
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

              Stack() {
                Circle({ width: 48, height: 48 })
                  .fill(this.primaryColor)
                  .opacity(0.1)
                Text('person')
                  .fontSize(28)
                  .fontColor(this.primaryColor)
              }
              .width(48)
              .height(48)
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 24 })

            // Environment Summary
            Row({ space: 16 }) {
              // Temperature Card
              Column() {
                Text('Temperature')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#1565C0')
                  .opacity(0.8)

                Blank()

                Column({ space: 0 }) {
                  Text('24°C')
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#1565C0')
                  Text('Comfortable')
                    .fontSize(11)
                    .fontColor('#1565C0')
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('48%')
              .height(100)
              .padding(16)
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#E3F2FD')
              .borderRadius(16)

              // Humidity Card
              Column() {
                Text('Humidity')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#2E7D32')
                  .opacity(0.8)

                Blank()

                Column({ space: 0 }) {
                  Text('45%')
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#2E7D32')
                  Text('Normal')
                    .fontSize(11)
                    .fontColor('#2E7D32')
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)
              }
              .width('48%')
              .height(100)
              .padding(16)
              .alignItems(HorizontalAlign.Start)
              .backgroundColor('#E8F5E9')
              .borderRadius(16)
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .margin({ top: 32 })

            // My Devices Section
            Column({ space: 16 }) {
              Text('My Devices')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')

              Grid() {
                ForEach(this.devices, (item: DeviceItem, index: number) => {
                  GridItem() {
                    this.DeviceCardBuilder(item, index)
                  }
                }, (item: DeviceItem) => item.name)
              }
              .columnsTemplate('1fr 1fr')
              .rowsTemplate('1fr 1fr')
              .columnsGap(16)
              .rowsGap(16)
              .width('100%')
              .height(296)
            }
            .width('100%')
            .padding({ left: 24, right: 24 })
            .alignItems(HorizontalAlign.Start)
            .margin({ top: 32 })

            Blank()
              .height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)

      // Bottom Navigation Bar
      Stack({ alignContent: Alignment.Top }) {
        Column()
          .width('100%')
          .height(80)
          .backgroundColor('#FFFFFF')
          .borderRadius({ topLeft: 24, topRight: 24 })

        Row() {
          Blank()
          this.NavBarItemBuilder('home', 'Home', this.selectedTab === 0)
            .onClick(() => { this.selectedTab = 0 })
          Blank()
          this.NavBarItemBuilder('star', 'Scenes', this.selectedTab === 1)
            .onClick(() => { this.selectedTab = 1 })
          Blank()
          this.NavBarItemBuilder('settings', 'Settings', this.selectedTab === 2)
            .onClick(() => { this.selectedTab = 2 })
          Blank()
        }
        .width('100%')
        .padding({ top: 16 })
      }
      .width('100%')
      .height(80)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  DeviceCardBuilder(item: DeviceItem, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 36, height: 36 })
            .fill(item.isActive ? 'rgba(255,255,255,0.2)' : '#EEEEEE')
          Text(item.icon)
            .fontSize(14)
            .fontColor(item.isActive ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: item.isActive })
          .onChange((isOn: boolean) => {
            this.devices[index].isActive = isOn
            this.devices[index].status = isOn ? 'On' : 'Off'
          })
          .selectedColor(item.isActive ? 'rgba(255,255,255,0.4)' : '#CCCCCC')
          .switchPointColor('#FFFFFF')
          .width(50)
          .height(28)
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(item.name)
          .fontSize(14)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(item.isActive ? '#FFFFFF' : '#000000')
        Text(item.isActive ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(item.isActive ? 'rgba(255,255,255,0.7)' : '#888888')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(item.isActive ? this.primaryColor : '#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: item.isActive ? 'rgba(74,101,114,0.3)' : 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  NavBarItemBuilder(icon: string, label: string, isSelected: boolean) {
    Column({ space: 4 }) {
      Stack() {
        if (isSelected) {
          Capsule()
            .width(64)
            .height(32)
            .fill(this.primaryColor)
            .opacity(0.1)
        }
        Text(icon)
          .fontSize(24)
          .fontColor(isSelected ? this.primaryColor : '#888888')
      }
      .width(64)
      .height(32)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? this.primaryColor : '#888888')
    }
    .alignItems(HorizontalAlign.Center)
  }
}

interface DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean
}
