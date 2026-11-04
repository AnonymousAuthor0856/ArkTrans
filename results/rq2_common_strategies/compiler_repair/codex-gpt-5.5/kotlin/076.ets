class SceneItem {
  label: string
  icon: string
  selected: boolean

  constructor(label: string, icon: string, selected: boolean) {
    this.label = label
    this.icon = icon
    this.selected = selected
  }
}

class DeviceItem {
  name: string
  icon: string
  active: boolean
  accent: Color

  constructor(name: string, icon: string, active: boolean, accent: Color) {
    this.name = name
    this.icon = icon
    this.active = active
    this.accent = accent
  }
}

@Entry
@Component
struct Index {
  private scenes: SceneItem[] = [
    new SceneItem('Home', '⌂', true),
    new SceneItem('Away', '⌕', false),
    new SceneItem('Sleep', '★', false)
  ]

  @State lampOn: boolean = true
  @State thermostatOn: boolean = true
  @State lockOn: boolean = false
  @State routerOn: boolean = true

  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor(Color.Gray)
              .fontWeight(FontWeight.Medium)
            Text('Alex Johnson')
              .fontSize(24)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Circle()
              .width(48)
              .height(48)
              .fill(Color.White)
            Text('人')
              .fontSize(22)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
          }
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        Row() {
          Column() {
            Text('Energy Usage')
              .fontSize(14)
              .fontColor('rgba(255,255,255,0.8)')
            Text('28.5 kWh')
              .fontSize(32)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 6 })
            Text('Today')
              .fontSize(12)
              .fontColor('rgba(255,255,255,0.6)')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Start)

          Stack() {
            Circle()
              .width(56)
              .height(56)
              .fill('rgba(255,255,255,0.2)')
            Text('!')
              .fontSize(24)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
          }
        }
        .width('100%')
        .padding(24)
        .borderRadius(24)
        .backgroundColor('#5E60CE')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .shadow({ radius: 16, color: 'rgba(94,96,206,0.28)', offsetY: 8 })
        .margin({ top: 32 })

        Text('Scenes')
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 32 })

        Row() {
          ForEach(this.scenes, (scene: SceneItem) => {
            this.SceneButton(scene)
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 16 })

        Text('Devices')
          .width('100%')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 32 })

        Row() {
          Column() {
            this.DeviceCard('Smart Lamp', '★', this.lampOn, '#FFC107', () => {
              this.lampOn = !this.lampOn
            })
            this.DeviceCard('Thermostat', '≡', this.thermostatOn, '#FF7043', () => {
              this.thermostatOn = !this.thermostatOn
            })
          }
          .layoutWeight(1)

          Column() {
            this.DeviceCard('Main Lock', '●', this.lockOn, '#4CAF50', () => {
              this.lockOn = !this.lockOn
            })
            this.DeviceCard('Wi-Fi Router', '⚙', this.routerOn, '#2196F3', () => {
              this.routerOn = !this.routerOn
            })
          }
          .layoutWeight(1)
          .margin({ left: 16 })
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)
        .margin({ top: 16, bottom: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }

  @Builder
  SceneButton(scene: SceneItem) {
    Row() {
      Text(scene.icon)
        .fontSize(18)
        .fontColor(scene.selected ? Color.White : Color.Black)
      Text(scene.label)
        .fontSize(14)
        .fontColor(scene.selected ? Color.White : Color.Black)
        .fontWeight(FontWeight.Medium)
        .margin({ left: 8 })
    }
    .height(44)
    .padding({ left: 18, right: 18 })
    .borderRadius(30)
    .backgroundColor(scene.selected ? '#212121' : Color.White)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  DeviceCard(name: string, icon: string, isActive: boolean, accent: string, toggle: () => void) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .fill(isActive ? this.tintColor(accent) : '#F0F0F0')
          Text(icon)
            .fontSize(22)
            .fontColor(isActive ? accent : Color.Gray)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        Text(isActive ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(isActive ? accent : Color.Gray)
          .margin({ top: 4 })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: isActive })
          .selectedColor(accent)
          .onChange(() => {
            toggle()
          })
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .borderRadius(20)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetY: 2 })
    .margin({ bottom: 16 })
  }

  tintColor(accent: string): string {
    if (accent === '#FFC107') {
      return 'rgba(255,193,7,0.12)'
    }
    if (accent === '#FF7043') {
      return 'rgba(255,112,67,0.12)'
    }
    if (accent === '#4CAF50') {
      return 'rgba(76,175,80,0.12)'
    }
    return 'rgba(33,150,243,0.12)'
  }
}
