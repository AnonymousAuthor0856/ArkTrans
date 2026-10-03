// SmartHomeApp.ets
import { EntryComponent, Column, Row, Text, Image, ScrollView, Stack, Toggle, Space, Color, BorderRadius, Shadow, FontWeight, Alignment } from '@ohos.arkui';

@Entry
@Component
struct SmartHomeApp {
  build() {
    Column() {
      SmartHomeDashboard()
    }
    .width('100%')
    .height('100%')
    .expandSafeArea(false)
  }
}

@Component
struct SmartHomeDashboard {
  build() {
    Stack() {
      // Background Color
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Color.Hex(0xF4F6F8))

      ScrollView() {
        Column() {
          // Top Header Spacer
          Space().width('100%').height(16)

          // Header
          Row() {
            Column() {
              Text("Good Morning,")
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Hex(0x808080))
              Text("Alex Johnson")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .alignItems(HorizontalAlign.Start)

            Space() // Spacer

            Stack() {
              Circle()
                .width(48)
                .height(48)
                .backgroundColor(Color.White)

              Image($r('app.media.icon')) // Placeholder for person.fill
                .width(24)
                .height(24)
                .fillColor(Color.Black)
            }
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Space().width('100%').height(32)

          // Energy Usage Card
          Column() {
            Row() {
              Column() {
                Text("Energy Usage")
                  .fontSize(14)
                  .fontColor(Color.White.opacity(0.8))
                Text("28.5 kWh")
                  .fontSize(32)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(Color.White)
                Text("Today")
                  .fontSize(12)
                  .fontColor(Color.White.opacity(0.6))
              }
              .alignItems(HorizontalAlign.Start)

              Space()

              Stack() {
                Circle()
                  .width(56)
                  .height(56)
                  .backgroundColor(Color.White.opacity(0.2))

                Image($r('app.media.icon')) // Placeholder for bell.fill
                  .width(24)
                  .height(24)
                  .fillColor(Color.White)
              }
            }
            .width('100%')
            .padding(24)
          }
          .width('100%')
          .backgroundColor(Color.Hex(0x5E60CE))
          .borderRadius(24)
          .shadow({ radius: 8, color: Color.Black.opacity(0.1), offsetX: 0, offsetY: 4 })
          .padding({ left: 24, right: 24 })

          Space().width('100%').height(32)

          // Scenes Section
          Text("Scenes")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .padding({ left: 24, right: 24 })

          Space().width('100%').height(16)

          // Horizontal ScrollView for Scenes
          ScrollView() {
            Row() {
              Space().width(12)

              SceneButton({ text: "Home", icon: $r('app.media.icon'), isSelected: true })
              SceneButton({ text: "Away", icon: $r('app.media.icon'), isSelected: false })
              SceneButton({ text: "Sleep", icon: $r('app.media.icon'), isSelected: false })

              Space().width(12)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)

          Space().width('100%').height(32)

          // Devices Section
          Text("Devices")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .width('100%')
            .padding({ left: 24, right: 24 })

          Space().width('100%').height(16)

          // Devices Grid
          Row() {
            Column() {
              DeviceCard({ name: "Smart Lamp", icon: $r('app.media.icon'), isActive: true, accentColor: Color.Hex(0xFFC107) })
              DeviceCard({ name: "Thermostat", icon: $r('app.media.icon'), isActive: true, accentColor: Color.Hex(0xFF7043) })
            }
            .layoutWeight(1)

            Space().width(16)

            Column() {
              DeviceCard({ name: "Main Lock", icon: $r('app.media.icon'), isActive: false, accentColor: Color.Hex(0x4CAF50) })
              DeviceCard({ name: "Wi-Fi Router", icon: $r('app.media.icon'), isActive: true, accentColor: Color.Hex(0x2196F3) })
            }
            .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          Space().width('100%').height(24)
        }
        .padding({ top: 24, bottom: 24 })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct SceneButton {
  @Prop text: string;
  @Prop icon: Resource;
  @Prop isSelected: boolean;

  build() {
    Row() {
      Image(this.icon)
        .width(18)
        .height(18)
        .fillColor(this.isSelected ? Color.White : Color.Black)

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.isSelected ? Color.White : Color.Black)
    }
    .padding({ left: 24, right: 24, top: 12, bottom: 12 })
    .backgroundColor(this.isSelected ? Color.Hex(0x212121) : Color.White)
    .borderRadius(30)
  }
}

@Component
struct DeviceCard {
  @Prop name: string;
  @Prop icon: Resource;
  @Prop isActive: boolean;
  @Prop accentColor: Color;
  @State switchState: boolean = this.isActive;

  build() {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(40)
            .height(40)
            .backgroundColor(this.switchState ? this.accentColor.opacity(0.1) : Color.Hex(0xF0F0F0))

          Image(this.icon)
            .width(24)
            .height(24)
            .fillColor(this.switchState ? this.accentColor : Color.Gray)
        }
        Space()
      }
      .width('100%')

      Space()

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)

        Text(this.switchState ? "On" : "Off")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.switchState ? this.accentColor : Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)

      Space()

      Row() {
        Space()
        Toggle({ type: ToggleType.Switch, isOn: $this.switchState })
          .selectedColor(this.accentColor)
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .backgroundColor(Color.White)
    .borderRadius(20)
    .shadow({ radius: 2, color: Color.Black.opacity(0.05), offsetX: 0, offsetY: 1 })
    .margin({ bottom: 16 })
  }
}