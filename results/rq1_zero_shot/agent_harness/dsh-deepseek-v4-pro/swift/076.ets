// Translated from SwiftUI (076.swift) to ArkTS / ArkUI

// MARK: - Entry Point
@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    SmartHomeDashboard()
    // .statusBarHidden(true)
  }
}

@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
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
                .fontColor('#808080')
              Text('Alex Johnson')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Blank().width(48).height(48).backgroundColor('#FFFFFF').borderRadius(24)
              Text('👤')
                .fontSize(24)
                .fontColor('#000000')
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
                  .fontColor('#FFFFFF')
                  .opacity(0.8)
                Text('28.5 kWh')
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#FFFFFF')
                Text('Today')
                  .fontSize(12)
                  .fontColor('#FFFFFF')
                  .opacity(0.6)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Stack() {
                Blank().width(56).height(56).backgroundColor('#33FFFFFF').borderRadius(28)
                Text('🔔')
                  .fontSize(24)
                  .fontColor('#FFFFFF')
              }
            }
            .alignItems(VerticalAlign.Center)
            .padding(24)
          }
          .backgroundColor('#5E60CE')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
          .padding({ left: 24, right: 24 })

          Blank().height(32)

          // Scenes Section
          Text('Scenes')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          Scroll() {
            Row({ space: 12 }) {
              SceneButton({ text: 'Home', icon: '🏠', isSelected: true })
              SceneButton({ text: 'Away', icon: '🔒', isSelected: false })
              SceneButton({ text: 'Sleep', icon: '⭐', isSelected: false })
            }
            .padding({ left: 24, right: 24 })
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Blank().height(32)

          // Devices Section
          Text('Devices')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#000000')
            .padding({ left: 24, right: 24 })

          Blank().height(16)

          // Devices Grid
          Row({ space: 16 }) {
            Column({ space: 16 }) {
              DeviceCard({ name: 'Smart Lamp', icon: '⭐', isActive: true, accentColor: '#FFC107' })
              DeviceCard({ name: 'Thermostat', icon: '≡', isActive: true, accentColor: '#FF7043' })
            }
            .layoutWeight(1)

            Column({ space: 16 }) {
              DeviceCard({ name: 'Main Lock', icon: '🔒', isActive: false, accentColor: '#4CAF50' })
              DeviceCard({ name: 'Wi-Fi Router', icon: '⚙', isActive: true, accentColor: '#2196F3' })
            }
            .layoutWeight(1)
          }
          .alignItems(VerticalAlign.Top)
          .padding({ left: 24, right: 24 })

          Blank().height(24)
        }
        .padding({ top: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
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
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? '#FFFFFF' : '#000000')
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? '#212121' : '#FFFFFF')
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  @Prop name: string = ''
  @Prop icon: string = ''
  @Prop isActive: boolean = false
  @Prop accentColor: string = ''
  @State switchState: boolean = false

  aboutToAppear() {
    this.switchState = this.isActive
  }

  build() {
    Column() {
      Row() {
        Stack() {
          Blank().width(40).height(40).backgroundColor(this.switchState ? '#1A' + this.accentColor.substring(1) : '#F0F0F0').borderRadius(20)
          Text(this.icon)
            .fontSize(14)
            .fontColor(this.switchState ? this.accentColor : '#808080')
        }
        Blank()
      }

      Blank()

      Column({ space: 4 }) {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000')

        Text(this.switchState ? 'On' : 'Off')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : '#808080')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .onChange((isOn: boolean) => { this.switchState = isOn })
          .selectedColor(this.accentColor)
          .scale({ x: 0.8, y: 0.8 })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .aspectRatio(0.85)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })
  }
}
