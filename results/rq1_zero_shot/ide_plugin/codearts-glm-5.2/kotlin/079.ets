class DeviceItem {
  name: string = ''
  status: string = ''
  icon: string = ''
  isActive: boolean = false
  constructor(name: string, status: string, icon: string, isActive: boolean) {
    this.name = name
    this.status = status
    this.icon = icon
    this.isActive = isActive
  }
}

@Component
struct DeviceCardComponent {
  @State isChecked: boolean = false
  @Prop name: string = ''
  @Prop icon: string = ''
  @Prop isActive: boolean = false

  aboutToAppear() {
    this.isChecked = this.isActive
  }

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.icon)
            .fontSize(18)
            .fontColor(this.isChecked ? '#FFFFFF' : '#888888')
        }
        .width(36)
        .height(36)
        .backgroundColor(this.isChecked ? '#33FFFFFF' : '#F0F0F0')
        .borderRadius(18)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor('#66FFFFFF')
          .width(36)
          .height(20)
          .onChange((isOn: boolean) => {
            this.isChecked = isOn
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

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
      .margin({ top: 8 })
    }
    .width('100%')
    .height(140)
    .padding(16)
    .backgroundColor(this.isChecked ? '#4A6572' : '#FFFFFF')
    .borderRadius(20)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Entry
@Component
struct SmartHomeScreen {
  private devices: DeviceItem[] = [
    new DeviceItem('Living Room', '2 Lights On', '🏠', true),
    new DeviceItem('Smart Lock', 'Locked', '🔒', true),
    new DeviceItem('Bedroom AC', '22°C', '⭐', false),
    new DeviceItem('Router', 'Online', '📍', true),
    new DeviceItem('Kitchen', 'All Off', 'ℹ', false),
    new DeviceItem('Corridor', 'Motion Detected', '🔔', true),
  ]

  @Builder
  EnvironmentCardBuilder(title: string, value: string, subtitle: string, bgColor: string, textColor: string, textAlpha80: string, textAlpha70: string) {
    Column() {
      Text(title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textAlpha80)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(textColor)
        Text(subtitle)
          .fontSize(11)
          .fontColor(textAlpha70)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .height(100)
    .padding(16)
    .backgroundColor(bgColor)
    .borderRadius(16)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Column() {
        Row() {
          Column() {
            Text('Welcome Home,')
              .fontSize(14)
              .fontColor('#888888')
            Text('Alex Johnson')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Column() {
            Text('👤')
              .fontSize(28)
              .fontColor('#4A6572')
          }
          .width(48)
          .height(48)
          .backgroundColor('#1A4A6572')
          .borderRadius(24)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24 })

        Row() {
          this.EnvironmentCardBuilder('Temperature', '24°C', 'Comfortable', '#E3F2FD', '#1565C0', '#CC1565C0', '#B31565C0')
          this.EnvironmentCardBuilder('Humidity', '45%', 'Normal', '#E8F5E9', '#2E7D32', '#CC2E7D32', '#B32E7D32')
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 32 })

        Text('My Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ top: 32 })

        Grid() {
          ForEach(this.devices, (device: DeviceItem) => {
            GridItem() {
              DeviceCardComponent({
                name: device.name,
                icon: device.icon,
                isActive: device.isActive
              })
            }
          }, (device: DeviceItem) => device.name)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(16)
        .rowsGap(16)
        .width('100%')
        .layoutWeight(1)
        .margin({ top: 16, bottom: 16 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })
      .layoutWeight(1)

      Row() {
        Column() {
          Text('🏠')
            .fontSize(24)
            .fontColor('#4A6572')
          Text('Home')
            .fontSize(12)
            .fontColor('#4A6572')
        }
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text('⭐')
            .fontSize(24)
            .fontColor('#888888')
          Text('Scenes')
            .fontSize(12)
            .fontColor('#888888')
        }
        .alignItems(HorizontalAlign.Center)

        Column() {
          Text('⚙')
            .fontSize(24)
            .fontColor('#888888')
          Text('Settings')
            .fontSize(12)
            .fontColor('#888888')
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F6F8')
  }
}