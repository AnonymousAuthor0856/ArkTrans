@Entry
@Component
struct SmartHomeDashboard {
  build() {
    Scroll() {
      Column() {
        Blank().height(16)

        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor('#888888')
              .fontWeight(FontWeight.Medium)

            Text('Alex Johnson')
              .fontSize(24)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Stack({ alignContent: Alignment.Center }) {
            IconGlyph({ icon: 'person', color: Color.Black, size: 28 })
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(Color.White)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        Row() {
          Column() {
            Text('Energy Usage')
              .fontSize(14)
              .fontColor('#CCFFFFFF')

            Text('28.5 kWh')
              .fontSize(32)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8 })

            Text('Today')
              .fontSize(12)
              .fontColor('#99FFFFFF')
              .margin({ top: 8 })
          }
          .alignItems(HorizontalAlign.Start)

          Stack({ alignContent: Alignment.Center }) {
            IconGlyph({ icon: 'bell', color: Color.White, size: 26 })
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#33FFFFFF')
        }
        .width('100%')
        .padding(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({
          radius: 22,
          color: '#22000000',
          offsetX: 0,
          offsetY: 8
        })

        Blank().height(32)

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .textAlign(TextAlign.Start)

        Blank().height(16)

        Row({ space: 12 }) {
          SceneButton({ title: 'Home', icon: 'home', selected: true })
          SceneButton({ title: 'Away', icon: 'lock', selected: false })
          SceneButton({ title: 'Sleep', icon: 'star', selected: false })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Blank().height(32)

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')
          .textAlign(TextAlign.Start)

        Blank().height(16)

        Row() {
          Column() {
            DeviceCard({
              name: 'Smart Lamp',
              icon: 'star',
              switchState: true,
              accentColor: '#FFC107',
              accentLightColor: '#1AFFC107'
            })

            Blank().height(16)

            DeviceCard({
              name: 'Thermostat',
              icon: 'menu',
              switchState: true,
              accentColor: '#FF7043',
              accentLightColor: '#1AFF7043'
            })
          }
          .layoutWeight(1)

          Blank().width(16)

          Column() {
            DeviceCard({
              name: 'Main Lock',
              icon: 'lock',
              switchState: false,
              accentColor: '#4CAF50',
              accentLightColor: '#1A4CAF50'
            })

            Blank().height(16)

            DeviceCard({
              name: 'Wi-Fi Router',
              icon: 'settings',
              switchState: true,
              accentColor: '#2196F3',
              accentLightColor: '#1A2196F3'
            })
          }
          .layoutWeight(1)
        }
        .width('100%')

        Blank().height(24)
      }
      .width('100%')
      .padding({
        left: 24,
        right: 24,
        top: 16,
        bottom: 24
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
  }
}

@Component
struct SceneButton {
  title: string = ''
  icon: string = ''
  selected: boolean = false

  build() {
    Row() {
      IconGlyph({
        icon: this.icon,
        color: this.selected ? Color.White : Color.Black,
        size: 18
      })

      Blank().width(8)

      Text(this.title)
        .fontSize(14)
        .fontColor(this.selected ? Color.White : Color.Black)
        .fontWeight(FontWeight.Medium)
    }
    .height(48)
    .padding({
      left: 24,
      right: 24,
      top: 12,
      bottom: 12
    })
    .borderRadius(30)
    .backgroundColor(this.selected ? '#212121' : Color.White)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
    })
  }
}

@Component
struct DeviceCard {
  name: string = ''
  icon: string = ''
  accentColor: ResourceColor = '#000000'
  accentLightColor: ResourceColor = '#11000000'
  @State switchState: boolean = false

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          IconGlyph({
            icon: this.icon,
            color: this.switchState ? this.accentColor : '#888888',
            size: 24
          })
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? this.accentLightColor : '#F0F0F0')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#888888')
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({
          type: ToggleType.Switch,
          isOn: this.switchState
        })
          .selectedColor(this.accentColor)
          .width(52)
          .height(32)
          .scale({ x: 0.8, y: 0.8 })
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({
      radius: 8,
      color: '#16000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct IconGlyph {
  icon: string = 'star'
  color: ResourceColor = Color.Black
  size: number = 24

  getGlyph(): string {
    switch (this.icon) {
      case 'home':
        return '⌂'
      case 'lock':
        return '▣'
      case 'star':
        return '★'
      case 'menu':
        return '≡'
      case 'settings':
        return '⚙'
      case 'bell':
        return '♟'
      case 'person':
        return '♟'
      default:
        return '•'
    }
  }

  build() {
    Text(this.getGlyph())
      .fontSize(this.size)
      .fontColor(this.color)
      .fontWeight(FontWeight.Bold)
      .textAlign(TextAlign.Center)
      .lineHeight(this.size + 8)
      .width(this.size + 10)
      .height(this.size + 10)
  }
}