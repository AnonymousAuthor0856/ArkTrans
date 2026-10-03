// Index.ets

interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;
  @State accessPoints: AccessPoint[] = [
    { id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago" },
    { id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago" },
    { id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday" }
  ];

  build() {
    Scroll() {
      Column() {
        // Header Section
        Row() {
          Column() {
            Text("Welcome back,")
              .fontSize(14)
              .fontColor(Color.Gray)
            Text("David Miller")
              .fontSize(22)
              .fontWeight(FontWeight.ExtraBold)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Image($r('sys.media.ohos_ic_public_contacts'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .width(48)
          .height(48)
          .borderRadius(24)
          .backgroundColor("#F5F5F5")
          .border({ width: 1, color: "#E0E0E0" })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(40)

        // Master Status Card
        Column() {
          Row() {
            Image(this.masterLockState ? $r('sys.media.ohos_ic_public_lock') : $r('sys.media.ohos_ic_public_check'))
              .width(36)
              .height(36)
              .fillColor(this.masterLockState ? "#212121" : "#4CAF50")
          }
          .width(80)
          .height(80)
          .borderRadius(40)
          .backgroundColor(Color.White)
          .border({ width: 2, color: this.masterLockState ? "#1A212121" : "#1A4CAF50" })
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.masterLockState = !this.masterLockState;
          })

          Blank().height(16)

          Text(this.masterLockState ? "SECURE" : "UNLOCKED")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.masterLockState ? "#212121" : "#4CAF50")
            .letterSpacing(2)

          Blank().height(8)

          Text(this.masterLockState ? "All perimeter doors are locked." : "Perimeter access is currently open.")
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        .width('100%')
        .padding(24)
        .borderRadius(24)
        .backgroundColor("#F8F8F8")
        .border({ width: 1, color: "#EFEFEF" })

        Blank().height(32)

        Text("My Access Points")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor("#A9A9A9")
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        // Access Point List
        ForEach(this.accessPoints, (item: AccessPoint) => {
          AccessPointRow({ item: item })
        })

        Blank().height(32)

        Text("Recent Activity")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor("#A9A9A9")
          .alignSelf(ItemAlign.Start)

        Blank().height(16)

        ActivityLogItem({ time: "10:42 AM", event: "Main Gate unlocked", user: "You" })
        ActivityLogItem({ time: "09:15 AM", event: "Guest Entry Denied", user: "System" })
        ActivityLogItem({ time: "08:30 AM", event: "Garage Door opened", user: "Alice" })
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off)
  }
}

@Component
struct AccessPointRow {
  item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        Image($r('sys.media.ohos_ic_public_home'))
          .width(20)
          .height(20)
          .fillColor(Color.Black)
      }
      .width(40)
      .height(40)
      .borderRadius(10)
      .backgroundColor("#FAFAFA")
      .justifyContent(FlexAlign.Center)

      Blank().width(16)

      Column() {
        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
        Text(this.item.lastAccessed)
          .fontSize(12)
          .fontColor("#D3D3D3")
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: "#EEEEEE" }
    )
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct ActivityLogItem {
  time: string;
  event: string;
  user: string;

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(Color.Gray)
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .color("#EEEEEE")

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        Text(`by ${this.user}`)
          .fontSize(12)
          .fontColor(Color.Gray)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}