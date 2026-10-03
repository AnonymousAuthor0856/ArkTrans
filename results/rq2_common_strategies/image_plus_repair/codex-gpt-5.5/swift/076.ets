interface DeviceInfo {
  name: string
  icon: string
  accent: string
  active: boolean
}

const BG: string = '#F4F6F8'
const BLACK: string = '#000000'
const GRAY: string = '#929397'
const WHITE: string = '#FFFFFF'
const PURPLE: string = '#5E60CE'
const YELLOW: string = '#FFBF07'
const CORAL: string = '#FF7043'
const BLUE: string = '#2196F3'

@Entry
@Component
struct SmartHomeDashboard {
  @State selectedScene: string = 'Home'
  @State lampOn: boolean = true
  @State lockOn: boolean = false
  @State thermostatOn: boolean = true
  @State routerOn: boolean = true

  private devices: DeviceInfo[] = [
    { name: 'Smart Lamp', icon: '★', accent: YELLOW, active: true },
    { name: 'Main Lock', icon: '♧', accent: '#96979B', active: false },
    { name: 'Thermostat', icon: '☰', accent: CORAL, active: true },
    { name: 'Wi-Fi Router', icon: '⚙', accent: BLUE, active: true }
  ]

  build() {
    Scroll() {
      Column() {
        Blank().height(16)
        this.header()
        Blank().height(32)
        this.energyCard()
        Blank().height(32)
        this.scenesSection()
        Blank().height(32)
        this.devicesSection()
        Blank().height(24)
      }
      .width('100%')
      .padding({ top: 8, bottom: 8 })
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor(BG)
  }

  @Builder
  header() {
    Row() {
      Column({ space: 0 }) {
        Text('Good Morning,')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(GRAY)
        Text('Alex Johnson')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(BLACK)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(WHITE)
        Column({ space: 2 }) {
          Circle()
            .width(11)
            .height(11)
            .fill(BLACK)
          Text('⌒')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(BLACK)
            .lineHeight(18)
        }
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  energyCard() {
    Row() {
      Column({ space: 0 }) {
        Text('Energy Usage')
          .fontSize(14)
          .fontColor('#D9DAF4')
        Text('28.5 kWh')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(WHITE)
          .margin({ top: 2 })
        Text('Today')
          .fontSize(12)
          .fontColor('#BFC1EA')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Stack() {
        Circle()
          .width(56)
          .height(56)
          .fill('#8587DA')
        Text('♟')
          .fontSize(28)
          .fontColor(WHITE)
          .rotate({ angle: 180 })
      }
    }
    .width('100%')
    .height(118)
    .padding(24)
    .backgroundColor(PURPLE)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#0000001A', offsetX: 0, offsetY: 4 })
    .margin({ left: 24, right: 24 })
  }

  @Builder
  scenesSection() {
    Column({ space: 16 }) {
      Text('Scenes')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(BLACK)
        .width('100%')

      Scroll() {
        Row({ space: 12 }) {
          this.sceneButton('⌂', 'Home')
          this.sceneButton('♧', 'Away')
          this.sceneButton('★', 'Sleep')
        }
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  sceneButton(icon: string, label: string) {
    Row({ space: 8 }) {
      Text(icon)
        .fontSize(23)
        .fontColor(this.selectedScene === label ? WHITE : BLACK)
        .fontWeight(FontWeight.Bold)
      Text(label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedScene === label ? WHITE : BLACK)
    }
    .height(42)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.selectedScene === label ? '#212121' : WHITE)
    .borderRadius(24)
    .onClick(() => {
      this.selectedScene = label
    })
  }

  @Builder
  devicesSection() {
    Column({ space: 16 }) {
      Text('Devices')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(BLACK)
        .width('100%')

      Row({ space: 16 }) {
        Column({ space: 16 }) {
          this.deviceCard(this.devices[0], this.lampOn, 0)
          this.deviceCard(this.devices[2], this.thermostatOn, 2)
        }
        .width('50%')

        Column({ space: 16 }) {
          this.deviceCard(this.devices[1], this.lockOn, 1)
          this.deviceCard(this.devices[3], this.routerOn, 3)
        }
        .width('50%')
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  deviceCard(device: DeviceInfo, isOn: boolean, index: number) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(isOn ? this.withOpacity(device.accent, '18') : '#F0F0F0')
          Text(device.icon)
            .fontSize(index === 1 ? 28 : 27)
            .fontWeight(FontWeight.Bold)
            .fontColor(isOn ? device.accent : '#96979B')
        }
        Blank().layoutWeight(1)
      }
      .width('100%')

      Blank().layoutWeight(1)

      Column({ space: 4 }) {
        Text(device.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(BLACK)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(isOn ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(isOn ? device.accent : '#96979B')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank().layoutWeight(1)

      Row() {
        Blank().layoutWeight(1)
        this.toggle(isOn, device.accent, index)
      }
      .width('100%')
    }
    .width('100%')
    .height(182)
    .padding(16)
    .backgroundColor(WHITE)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 })
  }

  @Builder
  toggle(isOn: boolean, accent: string, index: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width(48)
        .height(26)
        .borderRadius(13)
        .backgroundColor(isOn ? accent : '#E6E7E9')
      Circle()
        .width(22)
        .height(22)
        .fill(WHITE)
        .margin({ left: isOn ? 24 : 2 })
        .shadow({ radius: 2, color: '#00000018', offsetX: 0, offsetY: 1 })
    }
    .width(48)
    .height(26)
    .onClick(() => {
      if (index === 0) {
        this.lampOn = !this.lampOn
      } else if (index === 1) {
        this.lockOn = !this.lockOn
      } else if (index === 2) {
        this.thermostatOn = !this.thermostatOn
      } else {
        this.routerOn = !this.routerOn
      }
    })
  }

  private withOpacity(color: string, opacity: string): string {
    return `${color}${opacity}`
  }
}
