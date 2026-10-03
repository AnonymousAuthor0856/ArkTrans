class DeviceCardInfo {
  name: string = ''
  icon: string = ''
  isActive: boolean = false
  accentColor: string = ''
  accentAlpha10: string = ''
  constructor(name: string, icon: string, isActive: boolean, accentColor: string, accentAlpha10: string) {
    this.name = name
    this.icon = icon
    this.isActive = isActive
    this.accentColor = accentColor
    this.accentAlpha10 = accentAlpha10
  }
}

@Component
struct DeviceCardComponent {
  @State switchState: boolean = false
  @Prop name: string = ''
  @Prop icon: string = ''
  @Prop isActive: boolean = false
  @Prop accentColor: string = ''
  @Prop accentAlpha10: string = ''

  aboutToAppear() {
    this.switchState = this.isActive
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.icon)
            .fontSize(20)
            .fontColor(this.switchState ? this.accentColor : '#888888')
        }
        .width(40)
        .height(40)
        .backgroundColor(this.switchState ? this.accentAlpha10 : '#F0F0F0')
        .borderRadius(20)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#888888')
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .width(42)
          .height(26)
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(170)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct SmartHomeDashboard {
  private devicesLeft: DeviceCardInfo[] = [
    new DeviceCardInfo('Smart Lamp', '⭐', true, '#FFC107', '#1AFFC107'),
    new DeviceCardInfo('Thermostat', '☰', true, '#FF7043', '#1AFF7043'),
  ]
  private devicesRight: DeviceCardInfo[] = [
    new DeviceCardInfo('Main Lock', '🔒', false, '#4CAF50', '#1A4CAF50'),
    new DeviceCardInfo('Wi-Fi Router', '⚙', true, '#2196F3', '#1A2196F3'),
  ]

  @Builder
  SceneButtonBuilder(text: string, icon: string, isSelected: boolean) {
    Row() {
      Text(icon)
        .fontSize(16)
        .fontColor(isSelected ? '#FFFFFF' : '#000000')
      Text(text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#FFFFFF' : '#000000')
        .margin({ left: 8 })
    }
    .backgroundColor(isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Scroll() {
      Column() {
        Row() {
          Column() {
            Text('Good Morning,')
              .fontSize(16)
              .fontColor('#888888')
              .fontWeight(FontWeight.Medium)
            Text('Alex Johnson')
              .fontSize(24)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Column() {
            Text('👤')
              .fontSize(22)
              .fontColor('#000000')
          }
          .width(48)
          .height(48)
          .backgroundColor('#FFFFFF')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16 })

        Row() {
          Column() {
            Text('Energy Usage')
              .fontSize(14)
              .fontColor('#CCFFFFFF')
            Text('28.5 kWh')
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
            Text('Today')
              .fontSize(12)
              .fontColor('#99FFFFFF')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Column() {
            Text('🔔')
              .fontSize(26)
              .fontColor('#FFFFFF')
          }
          .width(56)
          .height(56)
          .backgroundColor('#33FFFFFF')
          .borderRadius(28)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#5E60CE')
        .borderRadius(24)
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 32 })

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 32 })

        Row() {
          this.SceneButtonBuilder('Home', '🏠', true)
          this.SceneButtonBuilder('Away', '🔒', false)
          this.SceneButtonBuilder('Sleep', '⭐', false)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: 16 })

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')
          .margin({ top: 32 })

        Row() {
          Column() {
            ForEach(this.devicesLeft, (device: DeviceCardInfo) => {
              DeviceCardComponent({
                name: device.name,
                icon: device.icon,
                isActive: device.isActive,
                accentColor: device.accentColor,
                accentAlpha10: device.accentAlpha10
              })
            }, (device: DeviceCardInfo) => device.name)
          }
          .layoutWeight(1)

          Column() {
            ForEach(this.devicesRight, (device: DeviceCardInfo) => {
              DeviceCardComponent({
                name: device.name,
                icon: device.icon,
                isActive: device.isActive,
                accentColor: device.accentColor,
                accentAlpha10: device.accentAlpha10
              })
            }, (device: DeviceCardInfo) => device.name)
          }
          .layoutWeight(1)
          .margin({ left: 16 })
        }
        .width('100%')
        .margin({ top: 16 })
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
    .backgroundColor('#F4F6F8')
  }
}