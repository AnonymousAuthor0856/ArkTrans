@Entry
@Component
struct ContentView {
  build() {
    SmartHomeDashboard()
  }
}

@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank().height(16)

          Row() {
            Column() {
              Text('Good Morning,')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Gray)

              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .width(48)
                .height(48)
                .fill(Color.White)

              Text('👤')
                .fontSize(24)
                .fontColor(Color.Black)
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
                  .fontColor('rgba(255,255,255,0.8)')

                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)

                Text('Today')
                  .fontSize(12)
                  .fontColor('rgba(255,255,255,0.6)')
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack({ alignContent: Alignment.Center }) {
                Circle()
                  .width(56)
                  .height(56)
                  .fill('rgba(255,255,255,0.2)')

                Text('🔔')
                  .fontSize(24)
                  .fontColor(Color.White)
              }
              .width(56)
              .height(56)
            }
            .width('100%')
            .padding(24)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({
            radius: 8,
            color: 'rgba(0,0,0,0.1)',
            offsetX: 0,
            offsetY: 4
          })
          .margin({ left: 24, right: 24 })

          Blank().height(32)

          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Scroll() {
            Row({ space: 12 }) {
              SceneButton({
                text: 'Home',
                icon: '⌂',
                isSelected: true
              })

              SceneButton({
                text: 'Away',
                icon: '🔒',
                isSelected: false
              })

              SceneButton({
                text: 'Sleep',
                icon: '★',
                isSelected: false
              })
            }
            .padding({ left: 24, right: 24 })
          }
          .width('100%')
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank().height(32)

          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({
                name: 'Smart Lamp',
                icon: '★',
                switchState: true,
                accentColor: '#FFC107',
                accentBgColor: 'rgba(255,193,7,0.1)'
              })

              DeviceCard({
                name: 'Thermostat',
                icon: '≡',
                switchState: true,
                accentColor: '#FF7043',
                accentBgColor: 'rgba(255,112,67,0.1)'
              })
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              DeviceCard({
                name: 'Main Lock',
                icon: '🔒',
                switchState: false,
                accentColor: '#4CAF50',
                accentBgColor: 'rgba(76,175,80,0.1)'
              })

              DeviceCard({
                name: 'Wi-Fi Router',
                icon: '⚙',
                switchState: true,
                accentColor: '#2196F3',
                accentBgColor: 'rgba(33,150,243,0.1)'
              })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(VerticalAlign.Top)

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
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
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
        .fontSize(18)
        .fontColor(this.isSelected ? Color.White : Color.Black)

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : Color.White)
    .borderRadius(30)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct DeviceCard {
  name: string = ''
  icon: string = ''
  @State switchState: boolean = false
  accentColor: ResourceColor = '#FFC107'
  accentBgColor: ResourceColor = 'rgba(255,193,7,0.1)'

  build() {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Circle()
            .width(40)
            .height(40)
            .fill(this.switchState ? this.accentBgColor : '#F0F0F0')

          Text(this.icon)
            .fontSize(24)
            .fontColor(this.switchState ? this.accentColor : Color.Gray)
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
          .fontColor(Color.Black)

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : Color.Gray)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()

        Toggle({
          type: ToggleType.Switch,
          isOn: this.switchState
        })
          .selectedColor(this.accentColor)
          .scale({ x: 0.8, y: 0.8 })
          .onChange((isOn: boolean) => {
            this.switchState = isOn
          })
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({
      radius: 2,
      color: 'rgba(0,0,0,0.05)',
      offsetX: 0,
      offsetY: 1
    })
    .alignItems(HorizontalAlign.Start)
  }
}