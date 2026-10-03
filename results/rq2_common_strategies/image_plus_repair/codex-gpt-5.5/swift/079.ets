interface DeviceItem {
  name: string
  status: string
  icon: string
  isActive: boolean
}

const PRIMARY_COLOR: string = '#4A6572'
const BACKGROUND_COLOR: string = '#F5F6F8'
const WHITE_COLOR: string = '#FFFFFF'
const BLACK_COLOR: string = '#000000'
const GRAY_COLOR: string = '#8F9096'
const LIGHT_GRAY: string = '#F0F0F0'

@Entry
@Component
struct SmartHomeScreen {
  @State private livingRoomOn: boolean = true
  @State private smartLockOn: boolean = true
  @State private bedroomAcOn: boolean = false
  @State private routerOn: boolean = true

  private readonly devices: DeviceItem[] = [
    { name: 'Living Room', status: 'On', icon: 'home', isActive: true },
    { name: 'Smart Lock', status: 'On', icon: 'lock', isActive: true },
    { name: 'Bedroom AC', status: 'Off', icon: 'star', isActive: false },
    { name: 'Router', status: 'On', icon: 'router', isActive: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Scroll() {
        Column() {
          Blank().height(24)
          this.headerSection()
          Blank().height(32)
          this.environmentSummary()
          Blank().height(32)
          this.devicesGrid()
          Blank().height(104)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .backgroundColor(BACKGROUND_COLOR)

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }

  @Builder
  private headerSection() {
    Row() {
      Column({ space: 4 }) {
        Text('Welcome Home,')
          .fontSize(16)
          .fontColor(GRAY_COLOR)

        Text('Alex Johnson')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(BLACK_COLOR)
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill('#E8ECEF')

        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(32)
            .height(32)
            .fill(PRIMARY_COLOR)

          Column({ space: 2 }) {
            Circle()
              .width(9)
              .height(9)
              .fill(WHITE_COLOR)

            Row()
              .width(20)
              .height(10)
              .backgroundColor(WHITE_COLOR)
              .borderRadius({ topLeft: 10, topRight: 10, bottomLeft: 2, bottomRight: 2 })
          }
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }
        .width(32)
        .height(32)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private environmentSummary() {
    Row({ space: 16 }) {
      this.environmentCard('Temperature', '24\u00B0C', 'Comfortable', '#E3F2FD', '#1565C0')
      this.environmentCard('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32')
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
  }

  @Builder
  private environmentCard(title: string, value: string, subtitle: string, bgColor: string, textColor: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textColor)

      Blank().layoutWeight(1)

      Text(value)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(textColor)

      Text(subtitle)
        .fontSize(11)
        .fontColor(textColor)
    }
    .height(100)
    .layoutWeight(1)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(bgColor)
    .borderRadius(16)
  }

  @Builder
  private devicesGrid() {
    Column({ space: 16 }) {
      Text('My Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(BLACK_COLOR)
        .width('100%')

      Row({ space: 16 }) {
        Column({ space: 16 }) {
          this.deviceCard(this.devices[0], this.livingRoomOn, 0)
          this.deviceCard(this.devices[2], this.bedroomAcOn, 2)
        }
        .layoutWeight(1)

        Column({ space: 16 }) {
          this.deviceCard(this.devices[1], this.smartLockOn, 1)
          this.deviceCard(this.devices[3], this.routerOn, 3)
        }
        .layoutWeight(1)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private deviceCard(device: DeviceItem, isOn: boolean, index: number) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(36)
            .height(36)
            .fill(isOn ? '#79909A' : LIGHT_GRAY)

          this.deviceIcon(device.icon, isOn ? WHITE_COLOR : '#8E9096')
        }
        .width(36)
        .height(36)

        Blank().layoutWeight(1)

        this.switchControl(isOn, index)
      }
      .width('100%')

      Blank().layoutWeight(1)

      Column({ space: 4 }) {
        Text(device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(isOn ? WHITE_COLOR : BLACK_COLOR)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(isOn ? 'On' : 'Off')
          .fontSize(11)
          .fontColor(isOn ? '#B3FFFFFF' : GRAY_COLOR)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(140)
    .padding(16)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(isOn ? PRIMARY_COLOR : WHITE_COLOR)
    .borderRadius(20)
    .shadow({
      radius: 10,
      color: isOn ? '#4D4A6572' : '#0D000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  private switchControl(isOn: boolean, index: number) {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width(44)
        .height(26)
        .backgroundColor(isOn ? '#91A1A8' : '#F0F0F2')
        .border({
          width: isOn ? 0 : 1,
          color: '#C9C9CD',
          radius: 13
        })

      Circle()
        .width(20)
        .height(20)
        .fill(WHITE_COLOR)
        .shadow({
          radius: 2,
          color: '#26000000',
          offsetX: 0,
          offsetY: 1
        })
        .translate({ x: isOn ? 9 : -9, y: 0 })
    }
    .width(44)
    .height(26)
    .onClick(() => {
      if (index === 0) {
        this.livingRoomOn = !this.livingRoomOn
      } else if (index === 1) {
        this.smartLockOn = !this.smartLockOn
      } else if (index === 2) {
        this.bedroomAcOn = !this.bedroomAcOn
      } else {
        this.routerOn = !this.routerOn
      }
    })
  }

  @Builder
  private bottomBar() {
    Stack({ alignContent: Alignment.Top }) {
      Row()
        .width('100%')
        .height(80)
        .backgroundColor(WHITE_COLOR)
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({
          radius: 10,
          color: '#12000000',
          offsetX: 0,
          offsetY: -2
        })

      Row() {
        this.navBarItem('home', 'Home', true)
        this.navBarItem('star', 'Scenes', false)
        this.navBarItem('gear', 'Settings', false)
      }
      .width('100%')
      .padding({ left: 48, right: 48, top: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height(80)
  }

  @Builder
  private navBarItem(icon: string, label: string, selected: boolean) {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Center }) {
        if (selected) {
          Row()
            .width(64)
            .height(32)
            .backgroundColor('#EEF2F3')
            .borderRadius(16)
        }

        this.navIcon(icon, selected ? PRIMARY_COLOR : GRAY_COLOR)
      }
      .width(72)
      .height(32)

      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(selected ? PRIMARY_COLOR : GRAY_COLOR)
    }
    .width(80)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  private deviceIcon(icon: string, color: string) {
    if (icon === 'home') {
      this.homeIcon(color, 18)
    } else if (icon === 'lock') {
      this.lockIcon(color, 18)
    } else if (icon === 'star') {
      this.starIcon(color, 18)
    } else {
      this.routerIcon(color, 18)
    }
  }

  @Builder
  private navIcon(icon: string, color: string) {
    if (icon === 'home') {
      this.homeIcon(color, 30)
    } else if (icon === 'star') {
      this.starIcon(color, 30)
    } else {
      this.gearIcon(color, 30)
    }
  }

  @Builder
  private homeIcon(color: string, size: number) {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width(size * 0.56)
        .height(size * 0.48)
        .backgroundColor(color)
        .borderRadius(1)
        .margin({ top: size * 0.25 })

      Row()
        .width(size * 0.68)
        .height(size * 0.08)
        .backgroundColor(color)
        .rotate({ angle: -42 })
        .margin({ left: -size * 0.17, top: -size * 0.1 })

      Row()
        .width(size * 0.68)
        .height(size * 0.08)
        .backgroundColor(color)
        .rotate({ angle: 42 })
        .margin({ left: size * 0.17, top: -size * 0.1 })

      Row()
        .width(size * 0.24)
        .height(size * 0.28)
        .backgroundColor(BACKGROUND_COLOR)
        .margin({ top: size * 0.42 })

      Row()
        .width(size * 0.1)
        .height(size * 0.26)
        .backgroundColor(color)
        .margin({ left: size * 0.52, top: -size * 0.08 })
    }
    .width(size)
    .height(size)
  }

  @Builder
  private lockIcon(color: string, size: number) {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width(size * 0.58)
        .height(size * 0.5)
        .backgroundColor(color)
        .borderRadius(2)
        .margin({ top: size * 0.26 })

      Row()
        .width(size * 0.42)
        .height(size * 0.36)
        .border({
          width: 2,
          color: color,
          radius: size * 0.2
        })
        .margin({ top: -size * 0.2 })
    }
    .width(size)
    .height(size)
  }

  @Builder
  private routerIcon(color: string, size: number) {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(size)
        .height(size)
        .fill(color)

      Row()
        .width(size * 0.18)
        .height(size * 0.54)
        .backgroundColor(isColorWhite(color) ? PRIMARY_COLOR : WHITE_COLOR)
        .borderRadius(2)
        .rotate({ angle: 35 })

      Row()
        .width(size * 0.44)
        .height(size * 0.16)
        .backgroundColor(isColorWhite(color) ? PRIMARY_COLOR : WHITE_COLOR)
        .borderRadius(2)
        .rotate({ angle: -20 })
        .margin({ left: -size * 0.1, top: -size * 0.06 })
    }
    .width(size)
    .height(size)
  }

  @Builder
  private starIcon(color: string, size: number) {
    Stack({ alignContent: Alignment.Center }) {
      Row()
        .width(size * 0.3)
        .height(size)
        .backgroundColor(color)
        .borderRadius(size * 0.06)

      Row()
        .width(size * 0.3)
        .height(size)
        .backgroundColor(color)
        .borderRadius(size * 0.06)
        .rotate({ angle: 72 })

      Row()
        .width(size * 0.3)
        .height(size)
        .backgroundColor(color)
        .borderRadius(size * 0.06)
        .rotate({ angle: -72 })
    }
    .width(size)
    .height(size)
  }

  @Builder
  private gearIcon(color: string, size: number) {
    Stack({ alignContent: Alignment.Center }) {
      this.starIcon(color, size)

      Circle()
        .width(size * 0.45)
        .height(size * 0.45)
        .fill(color)

      Circle()
        .width(size * 0.2)
        .height(size * 0.2)
        .fill(WHITE_COLOR)
    }
    .width(size)
    .height(size)
  }
}

function isColorWhite(color: string): boolean {
  return color === WHITE_COLOR
}
