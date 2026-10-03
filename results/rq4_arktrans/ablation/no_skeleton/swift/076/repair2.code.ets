@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      SmartHomeDashboard()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}

@Component
struct SmartHomeDashboard {
  build() {
    Scroll() {
      Column({ space: 0 }) {
        // Top Header Spacer
        Blank().height(16)

        // Header
        Row() {
          Column({ space: 0 }) {
            Text('Good Morning,').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#999999')
            Text('Alex Johnson').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#000000')
          }
          Blank()
          Stack() {
            Circle().fill('#FFFFFF').width(48).height(48)
            Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#000000')
          }
        }.padding({ left: 24, right: 24 })

        Blank().height(32)

        // Energy Usage Card
        Column() {
          Row() {
            Column({ space: 0 }) {
              Text('Energy Usage').fontSize(14).fontColor('#CCFFFFFF')
              Text('28.5 kWh').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
              Text('Today').fontSize(12).fontColor('#99FFFFFF')
            }
            Blank()
            Stack() {
              Circle().fill('#33FFFFFF').width(56).height(56)
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#FFFFFF')
            }
          }.padding(24)
        }
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
        .margin({ left: 24, right: 24 })

        Blank().height(32)

        // Scenes Section
        Text('Scenes').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000').margin({ left: 24, right: 24 })

        Blank().height(16)

        // Scenes Horizontal Scroll
        Scroll() {
          Row({ space: 12 }) {
            Blank().width(12)
            SceneButtonComponent({ props: { text: 'Home', icon: $r('app.media.startIcon'), isSelected: true } })
            SceneButtonComponent({ props: { text: 'Away', icon: $r('app.media.startIcon'), isSelected: false } })
            SceneButtonComponent({ props: { text: 'Sleep', icon: $r('app.media.startIcon'), isSelected: false } })
            Blank().width(24)
          }
        }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

        Blank().height(32)

        // Devices Section
        Text('Devices').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#000000').margin({ left: 24, right: 24 })

        Blank().height(16)

        // Devices Grid
        GridRow({ columnsGap: 16 }) {
          GridCol({ columns: '1fr' }) {
            Column({ space: 16 }) {
              DeviceCardComponent({ props: { name: 'Smart Lamp', icon: $r('app.media.startIcon'), isActive: true, accentColor: '#FFC107' } })
              DeviceCardComponent({ props: { name: 'Thermostat', icon: $r('app.media.startIcon'), isActive: true, accentColor: '#FF7043' } })
            }
          }
          GridCol({ columns: '1fr' }) {
            Column({ space: 16 }) {
              DeviceCardComponent({ props: { name: 'Main Lock', icon: $r('app.media.startIcon'), isActive: false, accentColor: '#4CAF50' } })
              DeviceCardComponent({ props: { name: 'Wi-Fi Router', icon: $r('app.media.startIcon'), isActive: true, accentColor: '#2196F3' } })
            }
          }
        }.margin({ left: 24, right: 24 })

        Blank().height(24)
      }.padding({ top: 0, bottom: 24 })
    }.scrollBar(BarState.Off).width('100%').height('100%')
  }
}

interface SceneButtonProps {
  text: string
  icon: Resource
  isSelected: boolean
}

@Component
struct SceneButtonComponent {
  @Prop props: SceneButtonProps

  build() {
    Row({ space: 8 }) {
      Image(this.props.icon).width(18).height(18).objectFit(ImageFit.Contain).fillColor(this.props.isSelected ? '#FFFFFF' : '#000000')
      Text(this.props.text).fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.props.isSelected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.props.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }
}

interface DeviceCardProps {
  name: string
  icon: Resource
  isActive: boolean
  accentColor: string
}

@Component
struct DeviceCardComponent {
  @Prop props: DeviceCardProps
  @State switchState: boolean = false

  aboutToAppear() {
    this.switchState = this.props.isActive
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Stack() {
          Circle().fill(this.switchState ? this.hexToRgba(this.props.accentColor, 0.1) : '#F0F0F0').width(40).height(40)
          Image(this.props.icon).width(24).height(24).objectFit(ImageFit.Contain).fillColor(this.switchState ? this.props.accentColor : '#999999')
        }
        Blank()
      }

      Blank()

      Column({ space: 4 }) {
        Text(this.props.name).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#000000')
        Text(this.switchState ? 'On' : 'Off').fontSize(14).fontWeight(FontWeight.Medium).fontColor(this.switchState ? this.props.accentColor : '#999999')
      }

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
          .selectedColor(this.props.accentColor)
          .scale({ x: 0.8, y: 0.8 })
      }
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })
  }

  hexToRgba(hex: string, alpha: number): string {
    let c: string
    if (/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex)) {
      c = hex.substring(1)
      if (c.length === 3) {
        c = `${c[0]}${c[0]}${c[1]}${c[1]}${c[2]}${c[2]}`
      }
      const num = parseInt(c, 16)
      const r = (num >> 16) & 255
      const g = (num >> 8) & 255
      const b = num & 255
      return `rgba(${r},${g},${b},${alpha})`
    }
    return hex
  }
}