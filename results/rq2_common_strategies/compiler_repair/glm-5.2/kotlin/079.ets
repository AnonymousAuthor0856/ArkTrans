// Index.ets
interface DeviceItem {
  name: string;
  status: string;
  icon: Resource;
  isActive: boolean;
}

@Entry
@Component
struct Index {
  @State devices: DeviceItem[] = [
    { name: "Living Room", status: "2 Lights On", icon: $r("app.media.icon"), isActive: true },
    { name: "Smart Lock", status: "Locked", icon: $r("app.media.icon"), isActive: true },
    { name: "Bedroom AC", status: "22°C", icon: $r("app.media.icon"), isActive: false },
    { name: "Router", status: "Online", icon: $r("app.media.icon"), isActive: true },
    { name: "Kitchen", status: "All Off", icon: $r("app.media.icon"), isActive: false },
    { name: "Corridor", status: "Motion Detected", icon: $r("app.media.icon"), isActive: true }
  ];

  build() {
    Column() {
      // Content Area
      Column() {
        // Header Section
        Row() {
          Column() {
            Text("Welcome Home,")
              .fontSize(16)
              .fontColor(Color.Gray)
              .margin({ bottom: 4 })
            Text("Alex Johnson")
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .fontColor("#333333")
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Image($r("app.media.icon"))
              .width(32)
              .height(32)
              .fillColor("#4A6572")
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor("#1A4A6572")
          .justifyContent(FlexAlign.Center)
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24, bottom: 32 })

        // Environment Summary
        Row() {
          // Temperature Card
          Column() {
            Text("Temperature")
              .fontSize(12)
              .fontColor("#CC1565C0")
            Blank()
            Column() {
              Text("24°C")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor("#1565C0")
              Text("Comfortable")
                .fontSize(10)
                .fontColor("#B31565C0")
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width("48%")
          .height(100)
          .padding(16)
          .backgroundColor("#E3F2FD")
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)

          Blank().width(16)

          // Humidity Card
          Column() {
            Text("Humidity")
              .fontSize(12)
              .fontColor("#CC2E7D32")
            Blank()
            Column() {
              Text("45%")
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor("#2E7D32")
              Text("Normal")
                .fontSize(10)
                .fontColor("#B32E7D32")
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width("48%")
          .height(100)
          .padding(16)
          .backgroundColor("#E8F5E9")
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width("100%")
        .margin({ bottom: 32 })

        // My Devices Title
        Row() {
          Text("My Devices")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor("#333333")
        }
        .width("100%")
        .margin({ bottom: 16 })

        // Devices Grid
        Grid() {
          ForEach(this.devices, (item: DeviceItem, index: number) => {
            GridItem() {
              DeviceCard({ device: item })
            }
          })
        }
        .columnsTemplate("1fr 1fr")
        .columnsGap(16)
        .rowsGap(16)
        .padding({ bottom: 16 })
        .layoutWeight(1)
      }
      .width("100%")
      .height("100%")
      .padding({ left: 24, right: 24 })
      .backgroundColor("#F5F6F8")

      // Bottom Bar
      Row() {
        Row() {
          Column() {
            Image($r("app.media.icon"))
              .width(24)
              .height(24)
              .fillColor("#4A6572")
            Text("Home")
              .fontSize(12)
              .fontColor("#4A6572")
              .margin({ top: 4 })
          }
          .justifyContent(FlexAlign.Center)
          .padding({ top: 8, bottom: 8 })
          .backgroundColor("#1A4A6572")
          .borderRadius(12)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        Column() {
          Image($r("app.media.icon"))
            .width(24)
            .height(24)
            .fillColor("#999999")
          Text("Scenes")
            .fontSize(12)
            .fontColor("#999999")
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)

        Column() {
          Image($r("app.media.icon"))
            .width(24)
            .height(24)
            .fillColor("#999999")
          Text("Settings")
            .fontSize(12)
            .fontColor("#999999")
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
      .width("100%")
      .height(64)
      .backgroundColor(Color.White)
      .borderRadius({ topLeft: 24, topRight: 24 })
      .shadow({ radius: 8, color: "#1A000000", offsetY: -2 })
    }
  }
}

@Component
struct DeviceCard {
  @Prop device: DeviceItem;
  @State isChecked: boolean = false;

  aboutToAppear() {
    this.isChecked = this.device.isActive;
  }

  build() {
    Column() {
      Row() {
        Row() {
          Image(this.device.icon)
            .width(20)
            .height(20)
            .fillColor(this.isChecked ? Color.White : Color.Gray)
        }
        .width(36)
        .height(36)
        .borderRadius(18)
        .backgroundColor(this.isChecked ? "#33FFFFFF" : "#F0F0F0")
        .justifyContent(FlexAlign.Center)

        Toggle({ type: ToggleType.Switch, isOn: this.isChecked })
          .selectedColor("#4A6572")
          .width(36)
          .height(20)
          .onChange((isOn: boolean) => {
            this.isChecked = isOn;
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank()

      Column() {
        Text(this.device.name)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isChecked ? Color.White : Color.Black)
        Text(this.isChecked ? "On" : "Off")
          .fontSize(10)
          .fontColor(this.isChecked ? "#B3FFFFFF" : "#B3000000")
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width("100%")
    .height(140)
    .padding(16)
    .backgroundColor(this.isChecked ? "#4A6572" : Color.White)
    .borderRadius(20)
    .shadow({ radius: this.isChecked ? 8 : 2, color: "#1A000000", offsetY: 2 })
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}