// SmartHomeDashboard.ets
import { Component, ObservedObject, ObservedPropertySimple } from '@ohos/arkui';

interface SceneItem {
  name: string;
  icon: Resource;
  isSelected: boolean;
}

interface DeviceItem {
  name: string;
  icon: Resource;
  isActive: boolean;
  accentColor: string;
}

@Component
export struct SmartHomeDashboard {
  private scenes: SceneItem[] = [
    { name: "Home", icon: $r("app.media.ic_home"), isSelected: true },
    { name: "Away", icon: $r("app.media.ic_lock"), isSelected: false },
    { name: "Sleep", icon: $r("app.media.ic_star"), isSelected: false },
  ];

  private devices: DeviceItem[] = [
    { name: "Smart Lamp", icon: $r("app.media.ic_star"), isActive: true, accentColor: "#FFC107" },
    { name: "Thermostat", icon: $r("app.media.ic_menu"), isActive: true, accentColor: "#FF7043" },
    { name: "Main Lock", icon: $r("app.media.ic_lock"), isActive: false, accentColor: "#4CAF50" },
    { name: "Wi-Fi Router", icon: $r("app.media.ic_settings"), isActive: true, accentColor: "#2196F3" },
  ];

  build() {
    Column() {
      // Header
      Row() {
        Column() {
          Text("Good Morning,")
            .fontSize(16)
            .fontColor("#808080")
            .fontWeight(FontWeight.Medium)
          Text("Alex Johnson")
            .fontSize(24)
            .fontColor("#000000")
            .fontWeight(FontWeight.Bold)
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Image(this.scenes[0].icon) // Placeholder for Person Icon
            .width(24).height(24)
            .fillColor("#000000")
        }
        .width(48).height(48)
        .borderRadius(24)
        .backgroundColor("#FFFFFF")
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({ top: 16, bottom: 32 })

      // Energy Usage Card
      Row() {
        Column() {
          Text("Energy Usage")
            .fontSize(14)
            .fontColor("#CCFFFFFF")
          Text("28.5 kWh")
            .fontSize(32)
            .fontColor("#FFFFFF")
            .fontWeight(FontWeight.Bold)
            .margin({ top: 4 })
          Text("Today")
            .fontSize(12)
            .fontColor("#99FFFFFF")
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Image($r("app.media.ic_notifications"))
            .width(28).height(28)
            .fillColor("#FFFFFF")
        }
        .width(56).height(56)
        .borderRadius(28)
        .backgroundColor("#33FFFFFF")
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .padding(24)
      .borderRadius(24)
      .backgroundColor("#5E60CE")
      .justifyContent(FlexAlign.SpaceBetween)

      // Scenes Section
      Text("Scenes")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor("#000000")
        .margin({ top: 32, bottom: 16 })

      Row() {
        ForEach(this.scenes, (scene: SceneItem) => {
          Row() {
            Image(scene.icon)
              .width(18).height(18)
              .fillColor(scene.isSelected ? "#FFFFFF" : "#000000")
            Text(scene.name)
              .fontSize(14)
              .fontColor(scene.isSelected ? "#FFFFFF" : "#000000")
              .fontWeight(FontWeight.Medium)
              .margin({ left: 8 })
          }
          .padding({ left: 24, right: 24, top: 12, bottom: 12 })
          .borderRadius(30)
          .backgroundColor(scene.isSelected ? "#212121" : "#FFFFFF")
          .margin({ right: 12 })
        })
      }

      // Devices Section
      Text("Devices")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor("#000000")
        .margin({ top: 32, bottom: 16 })

      Row() {
        Column() {
          DeviceCard({ name: this.devices[0].name, icon: this.devices[0].icon, isActive: this.devices[0].isActive, accentColor: this.devices[0].accentColor })
          DeviceCard({ name: this.devices[1].name, icon: this.devices[1].icon, isActive: this.devices[1].isActive, accentColor: this.devices[1].accentColor })
        }
        .layoutWeight(1)
        .margin({ right: 8 })

        Column() {
          DeviceCard({ name: this.devices[2].name, icon: this.devices[2].icon, isActive: this.devices[2].isActive, accentColor: this.devices[2].accentColor })
          DeviceCard({ name: this.devices[3].name, icon: this.devices[3].icon, isActive: this.devices[3].isActive, accentColor: this.devices[3].accentColor })
        }
        .layoutWeight(1)
        .margin({ left: 8 })
      }
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor("#F4F6F8")
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct DeviceCard {
  @State private switchState: boolean = false;
  private name: string = "";
  private icon: Resource = $r("app.media.ic_star");
  private isActive: boolean = false;
  private accentColor: string = "#FFC107";

  aboutToAppear() {
    this.switchState = this.isActive;
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.icon)
            .width(24).height(24)
            .fillColor(this.switchState ? this.accentColor : "#808080")
        }
        .width(40).height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? this.accentColor + "1A" : "#F0F0F0") // 1A is ~10% opacity hex
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      // Spacer
      Column().layoutWeight(1)

      Column() {
        Text(this.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor("#000000")
        Text(this.switchState ? "On" : "Off")
          .fontSize(14)
          .fontColor(this.switchState ? this.accentColor : "#808080")
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .switchPointColor(0xFFFFFFFF)
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 8 })
    }
    .padding(16)
    .width('100%')
    .aspectRatio(0.85)
    .borderRadius(20)
    .backgroundColor("#FFFFFF")
    .margin({ bottom: 16 })
  }
}