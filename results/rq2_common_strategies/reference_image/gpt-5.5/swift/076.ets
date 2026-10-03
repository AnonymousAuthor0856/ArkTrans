@Entry
@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F4F6F8')

      Scroll() {
        Column() {
          Blank().height(16)

          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#8E8E93')

              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(48)
                .height(48)
                .fill('#FFFFFF')

              Stack({ alignContent: Alignment.Center }) {
                Circle()
                  .width(13)
                  .height(13)
                  .fill('#000000')
                  .translate({ y: -10 })

                Ellipse()
                  .width(30)
                  .height(18)
                  .fill('#000000')
                  .translate({ y: 10 })
              }
              .width(34)
              .height(34)
            }
            .width(48)
            .height(48)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          Column() {
            Row() {
              Column() {
                Text('Energy Usage')
                  .fontSize(14)
                  .fontColor('rgba(255, 255, 255, 0.80)')

                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                  .margin({ top: 6 })

                Text('Today')
                  .fontSize(12)
                  .fontColor('rgba(255, 255, 255, 0.60)')
                  .margin({ top: 4 })
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack({ alignContent: Alignment.Center }) {
                Circle()
                  .width(56)
                  .height(56)
                  .fill('rgba(255, 255, 255, 0.20)')

                Text('●')
                  .fontSize(28)
                  .fontColor('#FFFFFF')
              }
              .width(56)
              .height(56)
            }
            .width('100%')
            .height('100%')
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(118)
          .padding(24)
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({
            radius: 8,
            color: 'rgba(0, 0, 0, 0.10)',
            offsetX: 0,
            offsetY: 4
          })
          .margin({ left: 24, right: 24 })

          Blank().height(32)

          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Scroll() {
            Row({ space: 12 }) {
              SceneButton({ text: 'Home', icon: '⌂', isSelected: true })
              SceneButton({ text: 'Away', icon: '■', isSelected: false })
              SceneButton({ text: 'Sleep', icon: '★', isSelected: false })
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Blank().height(32)

          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({
                name: 'Smart Lamp',
                icon: '★',
                isActive: true,
                accentColor: '#FFC107',
                accentSoftColor: '#FFF8E1'
              })

              DeviceCard({
                name: 'Thermostat',
                icon: '≡',
                isActive: true,
                accentColor: '#FF7043',
                accentSoftColor: '#FBE9E7'
              })
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              DeviceCard({
                name: 'Main Lock',
                icon: '▣',
                isActive: false,
                accentColor: '#4CAF50',
                accentSoftColor: '#E8F5E9'
              })

              DeviceCard({
                name: 'Wi-Fi Router',
                icon: '⚙',
                isActive: true,
                accentColor: '#2196F3',
                accentSoftColor: '#E3F2FD'
              })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Blank().height(24)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
  }
}

@Component
struct SceneButton {
  text: string = ''
  icon: string = ''
  isSelected: boolean = false

  build() {
    Row({ space: 8 }) {
      Text(this.icon)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
        .width(22)
        .height(22)
        .textAlign(TextAlign.Center)

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
    }
    .height(42)
    .padding({ left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  name: string = ''
  icon: string = ''
  isActive: boolean = false
  accentColor: string = '#000000'
  accentSoftColor: string = '#F0F0F0'

  @State switchState: boolean = false

  aboutToAppear() {
    this.switchState = this.isActive
  }

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(40)
            .height(40)
            .fill(this.switchState ? this.accentSoftColor : '#F0F0F0')

          Text(this.icon)
            .fontSize(this.icon === '≡' ? 28 : 26)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.switchState ? this.accentColor : '#8E8E93')
            .textAlign(TextAlign.Center)
        }
        .width(40)
        .height(40)

        Blank()
      }
      .width('100%')

      Blank()

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#8E8E93')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .scale({ x: 0.82, y: 0.82 })
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
      }
      .width('100%')
    }
    .width('100%')
    .height(183)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({
      radius: 2,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 1
    })
    .alignItems(HorizontalAlign.Start)
  }
}