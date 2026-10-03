// Index.ets
import { Length, Resource } from '@ohos.arkui';

// --- Domain Models ---
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// --- Mock Data ---
const accessPointsData: AccessPoint[] = [
  { id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago" },
  { id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago" },
  { id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday" }
];

@Entry
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;
  private scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column() {
        // Top Header
        HeaderSection();

        Blank().height(40);

        // Master Control Status
        MasterStatusCard({ isLocked: this.masterLockState, onToggle: () => {
          this.masterLockState = !this.masterLockState;
        }});

        Blank().height(32);

        // Quick Access List
        Text("My Access Points")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 16 });

        AccessPointList();

        Blank().height(32);

        // Recent Activity / Visitor Log
        Text("Recent Activity")
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .margin({ bottom: 16 });

        ActivityLogItem({ time: "10:42 AM", event: "Main Gate unlocked", user: "You" });
        ActivityLogItem({ time: "09:15 AM", event: "Guest Entry Denied", user: "System" });
        ActivityLogItem({ time: "08:30 AM", event: "Garage Door opened", user: "Alice" });
      }
      .padding(24)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
    .scrollBar(BarState.Off)
    .align(Alignment.Top);
  }
}

// --- Composable: Header ---
@Component
struct HeaderSection {
  build() {
    Row() {
      Column() {
        Text("Welcome back,")
          .fontSize(14)
          .fontColor('#888888');
        Text("David Miller")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#000000');
      }
      .alignItems(HorizontalAlign.Start);

      Blank(); // Pushes avatar to the right

      // Profile Icon Box
      Row() {
        Image($r('sys.media.ohos_ic_public_contacts'))
          .width(24)
          .height(24)
          .fillColor('#000000');
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center);
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween);
  }
}

// --- Composable: Master Status Card ---
@Component
struct MasterStatusCard {
  @Prop isLocked: boolean = true;
  onToggle: () => void = () => {};

  build() {
    Column() {
      // Status Icon
      Row() {
        Image(this.isLocked ? $r('sys.media.ohos_ic_public_lock') : $r('sys.media.ohos_ic_public_check'))
          .width(36)
          .height(36)
          .fillColor(this.isLocked ? '#212121' : '#4CAF50');
      }
      .width(80)
      .height(80)
      .borderRadius(40)
      .backgroundColor('#FFFFFF')
      .border({ width: 2, color: this.isLocked ? '#1A212121' : '#1A4CAF50' })
      .justifyContent(FlexAlign.Center)
      .onClick(() => this.onToggle());

      Blank().height(16);

      Text(this.isLocked ? "SECURE" : "UNLOCKED")
        .fontSize(22)
        .fontWeight(FontWeight.Black)
        .fontColor(this.isLocked ? '#212121' : '#4CAF50')
        .letterSpacing(2);

      Blank().height(8);

      Text(this.isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
        .fontSize(14)
        .fontColor('#888888')
        .textAlign(TextAlign.Center);
    }
    .padding(24)
    .width('100%')
    .borderRadius(24)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EFEFEF' });
  }
}

// --- Composable: Access Points ---
@Component
struct AccessPointList {
  build() {
    Column({ space: 12 }) {
      ForEach(accessPointsData, (point: AccessPoint) => {
        AccessPointRow({ item: point });
      });
    }
    .width('100%');
  }
}

@Component
struct AccessPointRow {
  @Prop item: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.item.isLocked;
  }

  build() {
    Row() {
      Row() {
        // Icon Box
        Row() {
          Image($r('sys.media.ohos_ic_public_home'))
            .width(20)
            .height(20)
            .fillColor('#000000');
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')
        .justifyContent(FlexAlign.Center);

        Blank().width(16);

        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#000000');
          Text(this.item.lastAccessed)
            .fontSize(12)
            .fontColor('#CCCCCC');
        }
        .alignItems(HorizontalAlign.Start);
      }

      Blank(); // Pushes switch to the right

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor('#000000')
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        });
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#EEEEEE' })
    .justifyContent(FlexAlign.SpaceBetween);
  }
}

// --- Composable: Activity Log ---
@Component
struct ActivityLogItem {
  @Prop time: string;
  @Prop event: string;
  @Prop user: string;

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor('#888888')
        .width(70);

      // Divider
      Divider()
        .vertical(true)
        .height(20)
        .width(1)
        .color('#EEEEEE');

      Blank().width(16);

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#000000');
        Text(`by ${this.user}`)
          .fontSize(12)
          .fontColor('#888888');
      }
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center);
  }
}