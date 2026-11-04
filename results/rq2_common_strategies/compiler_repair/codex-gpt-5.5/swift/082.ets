class HomeColors {
  static primary: string = '#4A6572'
  static background: string = '#F5F6F8'
  static white: string = '#FFFFFF'
  static black: string = '#000000'
  static gray: string = '#808080'
  static tempBg: string = '#E3F2FD'
  static tempText: string = '#1565C0'
  static humidityBg: string = '#E8F5E9'
  static humidityText: string = '#2E7D32'
  static inactiveIconBg: string = '#F0F0F0'
}

@Entry
@Component
struct Index {
  @State livingOn: boolean = true
  @State lockOn: boolean = true
  @State acOn: boolean = false
  @State routerOn: boolean = true
  @State kitchenOn: boolean = false
  @State corridorOn: boolean = true

  private deviceOn(kind: number): boolean {
    if (kind === 0) {
      return this.livingOn
    }
    if (kind === 1) {
      return this.lockOn
    }
    if (kind === 2) {
      return this.acOn
    }
    if (kind === 3) {
      return this.routerOn
    }
    if (kind === 4) {
      return this.kitchenOn
    }
    return this.corridorOn
  }

  @Builder
  HeaderSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(HomeColors.gray)
        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#1A4A6572')
        Text('User')
          .fontSize(11)
          .fontWeight(FontWeight.Bold)
          .fontColor(HomeColors.primary)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  EnvironmentCard(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textColor)
        .opacity(0.8)

      Blank()
        .layoutWeight(1)

      Column() {
        Text(value)
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
        Text(subtitle)
          .fontSize(11)
          .fontColor(textColor)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(bgColor)
    .borderRadius(16)
  }

  @Builder
  EnvironmentSummary() {
    Row({ space: 16 }) {
      this.EnvironmentCard('Temperature', '24°C', 'Comfortable', HomeColors.tempBg, HomeColors.tempText)
      this.EnvironmentCard('Humidity', '45%', 'Normal', HomeColors.humidityBg, HomeColors.humidityText)
    }
    .width('100%')
  }

  @Builder
  DeviceCard(name: string, icon: string, kind: number) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(36)
            .height(36)
            .fill(this.deviceOn(kind) ? '#33FFFFFF' : HomeColors.inactiveIconBg)
          Text(icon)
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.deviceOn(kind) ? HomeColors.white : HomeColors.gray)
        }
        .width(36)
        .height(36)

        Blank()
          .layoutWeight(1)

        Toggle({ type: ToggleType.Switch, isOn: this.deviceOn(kind) })
          .onChange((value: boolean) => {
            if (kind === 0) {
              this.livingOn = value
            } else if (kind === 1) {
              this.lockOn = value
            } else if (kind === 2) {
              this.acOn = value
            } else if (kind === 3) {
              this.routerOn = value
            } else if (kind === 4) {
              this.kitchenOn = value
            } else {
              this.corridorOn = value
            }
          })
      }
      .width('100%')

      Blank()
        .layoutWeight(1)

      Column({ space: 4 }) {
        Text(name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.deviceOn(kind) ? HomeColors.white : HomeColors.black)
        Text(this.deviceOn(kind) ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(this.deviceOn(kind) ? '#B3FFFFFF' : HomeColors.gray)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(this.deviceOn(kind) ? HomeColors.primary : HomeColors.white)
    .borderRadius(20)
    .shadow({ radius: 8, color: this.deviceOn(kind) ? '#4D4A6572' : '#0D000000', offsetY: 4 })
  }

  @Builder
  DevicesGrid() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(HomeColors.black)
        .width('100%')

      Grid() {
        GridItem() { this.DeviceCard('Living Room', 'Home', 0) }
        GridItem() { this.DeviceCard('Smart Lock', 'Lock', 1) }
        GridItem() { this.DeviceCard('Bedroom AC', 'AC', 2) }
        GridItem() { this.DeviceCard('Router', 'Net', 3) }
        GridItem() { this.DeviceCard('Kitchen', 'Info', 4) }
        GridItem() { this.DeviceCard('Corridor', 'Bell', 5) }
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
  NavBarItem(icon: string, label: string, selected: boolean) {
    Column({ space: 4 }) {
      Stack() {
        if (selected) {
          Rect()
            .width(64)
            .height(32)
            .fill('#1A4A6572')
            .radius(16)
        }
        Text(icon)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(selected ? HomeColors.primary : HomeColors.gray)
      }
      .width(64)
      .height(32)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(selected ? HomeColors.primary : HomeColors.gray)
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  BottomBar() {
    Stack() {
      Row() {
        Blank().layoutWeight(1)
        this.NavBarItem('Home', 'Home', true)
        Blank().layoutWeight(1)
        this.NavBarItem('Star', 'Scenes', false)
        Blank().layoutWeight(1)
        this.NavBarItem('Gear', 'Settings', false)
        Blank().layoutWeight(1)
      }
      .width('100%')
      .padding({ top: 16 })
    }
    .width('100%')
    .height(80)
    .backgroundColor(HomeColors.white)
    .borderRadius(24)
    .shadow({ radius: 4, color: '#0D000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Blank().height(24)

          Column() { this.HeaderSection() }
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(32)

          Column() { this.EnvironmentSummary() }
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(32)

          Column() { this.DevicesGrid() }
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(100)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)

      Column() {
        Blank().layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HomeColors.background)
  }
}
