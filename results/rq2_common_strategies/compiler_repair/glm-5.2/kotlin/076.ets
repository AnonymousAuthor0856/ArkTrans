// Index.ets
interface SceneItem {
  text: string;
  icon: Resource;
  isSelected: boolean;
}

interface DeviceItem {
  name: string;
  icon: Resource;
  isActive: boolean;
  accentColor: ResourceColor;
}

@Entry
@Component
struct SmartHomeDashboard {
  private scenes: SceneItem[] = [
    { text: "Home", icon: $r('app.media.icon'), isSelected: true },
    { text: "Away", icon: $r('app.media.icon'), isSelected: false },
    { text: "Sleep", icon: $r('app.media.icon'), isSelected: false }
  ];

  private leftDevices: DeviceItem[] = [
    { name: "Smart Lamp", icon: $r('app.media.icon'), isActive: true, accentColor: "#FFC107" },
    { name: "Thermostat", icon: $r('app.media.icon'), isActive: true, accentColor: "#FF7043" }
  ];

  private rightDevices: DeviceItem[] = [
    { name: "Main Lock", icon: $r('app.media.icon'), isActive: false, accentColor: "#4CAF50" },
    { name: "Wi-Fi Router", icon: $r('app.media.icon'), isActive: true, accentColor: "#2196F3" }
  ];

  build() {
    Scroll() {
      Column() {
        // Header
        Row() {
          Column() {
            Text("Good Morning,")
              .fontSize(16)
              .fontColor("#888888")
              .fontWeight(FontWeight.Medium)
            Text("Alex Johnson")
              .fontSize(24)
              .fontColor("#000000")
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Image($r('app.media.icon'))
              .width(24)
              .height(24)
              .fillColor("#000000")
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor("#FFFFFF")
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Energy Usage Card
        Row() {
          Column() {
            Text("Energy Usage")
              .fontColor("#CCFFFFFF")
              .fontSize(14)
            Text("28.5 kWh")
              .fontColor("#FFFFFF")
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
            Text("Today")
              .fontColor("#99FFFFFF")
              .fontSize(12)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Image($r('app.media.icon'))
              .width(28)
              .height(28)
              .fillColor("#FFFFFF")
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor("#33FFFFFF")
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .padding(24)
        .borderRadius(24)
        .backgroundColor("#5E60CE")
        .margin({ top: 32 })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        // Scenes
        Text("Scenes")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor("#000000")
          .margin({ top: 32, bottom: 16 })
          .width('100%')

        Row({ space: 12 }) {
          ForEach(this.scenes, (item: SceneItem) => {
            Row() {
              Image(item.icon)
                .width(18)
                .height(18)
                .fillColor(item.isSelected ? "#FFFFFF" : "#000000")
              Text(item.text)
                .fontColor(item.isSelected ? "#FFFFFF" : "#000000")
                .fontWeight(FontWeight.Medium)
                .fontSize(14)
                .margin({ left: 8 })
            }
            .padding({ left: 24, right: 24, top: 12, bottom: 12 })
            .borderRadius(30)
            .backgroundColor(item.isSelected ? "#212121" : "#FFFFFF")
          })
        }
        .width('100%')

        // Devices
        Text("Devices")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor("#000000")
          .margin({ top: 32, bottom: 16 })
          .width('100%')

        Row({ space: 16 }) {
          Column({ space: 16 }) {
            ForEach(this.leftDevices, (item: DeviceItem) => {
              DeviceCard({ name: item.name, icon: item.icon, isActive: item.isActive, accentColor: item.accentColor })
            })
          }
          .layoutWeight(1)

          Column({ space: 16 }) {
            ForEach(this.rightDevices, (item: DeviceItem) => {
              DeviceCard({ name: item.name, icon: item.icon, isActive: item.isActive, accentColor: item.accentColor })
            })
          }
          .layoutWeight(1)
        }
        .width('100%')
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F4F6F8')
    .align(Alignment.Top)
    .scrollBar(BarState.Off)
  }
}

@Component
struct DeviceCard {
  @Prop name: string;
  @Prop icon: Resource;
  @Prop isActive: boolean;
  @Prop accentColor: ResourceColor;
  @State switchState: boolean = false;

  aboutToAppear() {
    this.switchState = this.isActive;
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.icon)
            .width(24)
            .height(24)
            .fillColor(this.switchState ? this.accentColor : "#888888")
        }
        .width(40)
        .height(40)
        .borderRadius(20)
        .backgroundColor(this.switchState ? '#1A000000' : '#F0F0F0')
        .justifyContent(FlexAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.name)
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .fontColor("#000000")
        Text(this.switchState ? "On" : "Off")
          .fontColor(this.switchState ? this.accentColor : "#888888")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 16 })

      Row() {
        Toggle({ type: ToggleType.Switch, isOn: this.switchState })
          .selectedColor(this.accentColor)
          .switchPointColor("#FFFFFF")
          .onChange((isOn: boolean) => {
            this.switchState = isOn;
          })
          .scale({ x: 0.8, y: 0.8 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .margin({ top: 16 })
    }
    .padding(16)
    .borderRadius(20)
    .backgroundColor("#FFFFFF")
    .height(180)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}