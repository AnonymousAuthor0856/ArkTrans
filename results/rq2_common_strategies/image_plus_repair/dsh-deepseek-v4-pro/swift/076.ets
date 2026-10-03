// Translation of 076.swift (SwiftUI Smart Home Dashboard) to ArkTS (HarmonyOS)

@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct ContentView {
  build() {
    SmartHomeDashboard()
    // .statusBarHidden(true): in ArkTS the immersive/full-screen window is handled
    // via the expandSafeArea modifier on the root Stack below.
  }
}

@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
      // Background Color #F4F6F8 that ignores safe area.
      Scroll() {
        Column({ space: 0 }) {

          // Top Header Spacer
          Blank().height(16)

          // Header
          Row() {
            Column({ space: 0 }) {
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

            Stack() {
              Circle()
                .fill(Color.White)
                .width(48)
                .height(48)

              Text('👤')
                .fontSize(24)
                .fontColor(Color.Black)
            }
          }
          .alignItems(VerticalAlign.Center)
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          // Energy Usage Card
          Column() {
            Row() {
              Column({ space: 0 }) {
                Text('Energy Usage')
                  .fontSize(14)
                  .fontColor('#CCFFFFFF')
                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                Text('Today')
                  .fontSize(12)
                  .fontColor('#99FFFFFF')
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Circle()
                  .fill('#33FFFFFF')
                  .width(56)
                  .height(56)

                Text('🔔')
                  .fontSize(24)
                  .fontColor(Color.White)
              }
            }
            .alignItems(VerticalAlign.Center)
            .padding(24)
          }
          .backgroundColor('#5E60CE') // #5E60CE
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1A000000', offsetX: 0, offsetY: 4 })
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          // Scenes Section
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Scroll() {
            Row({ space: 12 }) {
              // Leading padding for scroll view content
              Blank().width(24)

              SceneButton({ text: 'Home', icon: '🏠', isSelected: true })
              SceneButton({ text: 'Away', icon: '🔒', isSelected: false })
              SceneButton({ text: 'Sleep', icon: '⭐', isSelected: false })

              // Trailing padding for scroll view content
              Blank().width(24)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank().height(32)

          // Devices Section
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          // Devices Grid
          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({ name: 'Smart Lamp', icon: '⭐', isActive: true, accentColor: '#FFC107' })
              DeviceCard({ name: 'Thermostat', icon: '☰', isActive: true, accentColor: '#FF7043' })
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              DeviceCard({ name: 'Main Lock', icon: '🔒', isActive: false, accentColor: '#4CAF50' })
              DeviceCard({ name: 'Wi-Fi Router', icon: '⚙️', isActive: true, accentColor: '#2196F3' })
            }
            .layoutWeight(1)
          }
          .alignItems(VerticalAlign.Top)
          .padding({ left: 24, right: 24 })

          Blank().height(24)
        }
        .alignItems(HorizontalAlign.Start)
        .padding({ top: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8') // #F4F6F8
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct SceneButton {
  @Prop text: string = ''
  @Prop icon: string = ''
  @Prop isSelected: boolean = false

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
    .backgroundColor(this.isSelected ? '#212121' : Color.White) // #212121
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = ''
  @Prop icon: string = ''
  @Prop isActive: boolean = false
  @Prop accentColor: string = '#FFFFFF'
  @State switchState: boolean = false

  aboutToAppear() {
    this.switchState = this.isActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .fill(this.switchState ? this.accentColor : '#F0F0F0') // #F0F0F0
            .opacity(this.switchState ? 0.1 : 1.0)
            .width(40)
            .height(40)

          Text(this.icon)
            .fontSize(24)
            .fontColor(this.switchState ? this.accentColor : Color.Gray)
        }
        Blank()
      }

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
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: $$this.switchState })
          .selectedColor(this.accentColor)
          .scale({ x: 0.8, y: 0.8 })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    // Aspect ratio 0.85 means width/height = 0.85, so height = width / 0.85
    // In a grid context, aspect ratio modifier works well.
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }
}
