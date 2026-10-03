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
              .fontColor(Color.Gray)
              .fontWeight(FontWeight.Medium)

            Text('Alex Johnson')
              .fontSize(24)
              .fontColor(Color.Black)
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Text('person')
              .fontSize(20)
              .fontColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor(Color.White)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
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

            Text('Today')
              .fontSize(12)
              .fontColor('#99FFFFFF')
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Text('notifications')
              .fontSize(24)
              .fontColor(Color.White)
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#33FFFFFF')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding(24)
        .borderRadius(24)
        .backgroundColor('#5E60CE')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .shadow({
          radius: 8,
          color: '#33000000',
          offsetX: 0,
          offsetY: 4
        })

        Blank().height(32)

        Text('Scenes')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')

        Blank().height(16)

        Row({ space: 12 }) {
          SceneButton({
            text: 'Home',
            icon: 'home',
            isSelected: true
          })

          SceneButton({
            text: 'Away',
            icon: 'lock',
            isSelected: false
          })

          SceneButton({
            text: 'Sleep',
            icon: 'star',
            isSelected: false
          })
        }
        .width('100%')

        Blank().height(32)

        Text('Devices')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .width('100%')

        Blank().height(16)

        Row({ space: 16 }) {
          Column() {
            DeviceCard({
              name: 'Smart Lamp',
              icon: 'star',
              isActive: true,
              accentColor: '#FFC107'
            })

            Blank().height(16)

            DeviceCard({
              name: 'Thermostat',
              icon: 'menu',
              isActive: true,
              accentColor: '#FF7043'
            })
          }
          .layoutWeight(1)

          Column() {
            DeviceCard({
              name: 'Main Lock',
              icon: 'lock',
              isActive: false,
              accentColor: '#4CAF50'
            })

            Blank().height(16)

            DeviceCard({
              name: 'Wi-Fi Router',
              icon: 'settings',
              isActive: true,
              accentColor: '#2196F3'
            })
          }
          .layoutWeight(1)
        }
        .width('100%')

        Blank().height(24)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .scrollBar(BarState.Off)
  }
}

@Component
struct SceneButton {
  @Prop text: string = ''
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

  build() {
    Row() {
      Text(this.icon)
        .fontSize(18)
        .fontColor(this.isSelected ? Color.White : Color.Black)

      Blank().width(8)

      Text(this.text)
        .fontSize(14)
        .fontColor(this.isSelected ? Color.White : Color.Black)
        .fontWeight(FontWeight.Medium)
    }
    .padding({
      left: 24,
      right: 24,
      top: 12,
      bottom: 12
    })
    .borderRadius(30)
    .backgroundColor(this.isSelected ? '#212121' : Color.White)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
    })
  }
}

@Component
struct DeviceCard {
  @Prop name: string = ''
  @Prop icon: string = ''
  @Prop isActive: boolean = false
  @Prop accentColor: string = '#000000'
  @State switchState: boolean = false

  aboutToAppear() {
    this.switchState = this.isActive
  }

  build() {
    Column() {
      Row() {
        Row() {
          Text(this.icon)
            .fontSize(24)
            .fontColor(this.switchState ? this.accentColor : Color.Gray)
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? this.withAlpha(this.accentColor, '1A') : '#F0F0F0')
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)

        Blank().height(4)

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontColor(this.switchState ? this.accentColor : Color.Gray)
          .fontWeight(FontWeight.Medium)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({
          type: ToggleType.Switch,
          isOn: this.switchState
        })
          .selectedColor(this.accentColor)
          .switchPointColor(Color.White)
          .width(52)
          .height(32)
          .scale({
            x: 0.8,
            y: 0.8
          })
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
    .borderRadius(20)
    .backgroundColor(Color.White)
    .justifyContent(FlexAlign.SpaceBetween)
    .shadow({
      radius: 2,
      color: '#22000000',
      offsetX: 0,
      offsetY: 1
    })
  }

  withAlpha(color: string, alpha: string): string {
    if (color.startsWith('#') && color.length === 7) {
      return `#${alpha}${color.substring(1)}`
    }
    return color
  }
}