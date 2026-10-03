import { router } from '@kit.ArkUI'
import { window } from '@kit.ArkUI'

// --- Domain Models ---
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

@Entry
@Component
struct SecureKeyApp {
  @State masterLockState: boolean = true;
  private accessPoints: AccessPoint[] = [
    { id: '1', name: 'Main Entrance', status: 'Active', isLocked: true, lastAccessed: '2h ago' },
    { id: '2', name: 'Garage Door', status: 'Active', isLocked: false, lastAccessed: '12m ago' },
    { id: '3', name: 'Server Room', status: 'Restricted', isLocked: true, lastAccessed: 'Yesterday' }
  ];

  aboutToAppear() {
    // Configuration for Immersive Mode (Hide System Bars)
    let windowClass: window.Window | null = null;
    try {
      windowClass = window.getWindowSync(this.getUIContext().getWindow());
      if (windowClass) {
        windowClass.setWindowLayoutFullScreen(true);
        windowClass.setWindowSystemBarProperties({
          statusBarContentColor: '#00000000',
          navigationBarContentColor: '#00000000',
          statusBarColor: '#00000000',
          navigationBarColor: '#00000000'
        });
      }
    } catch (e) {
      console.error('Failed to set immersive mode');
    }
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 0 }) {
          HeaderSection()
          
          Blank().height(40)

          MasterStatusCard({
            isLocked: this.masterLockState,
            onToggle: () => {
              this.masterLockState = !this.masterLockState;
            }
          })

          Blank().height(32)

          Text("My Access Points")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#424242') // DarkGray equivalent

          Blank().height(16)

          AccessPointList({ points: this.accessPoints })

          Blank().height(32)

          Text("Recent Activity")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#424242')

          Blank().height(16)

          ActivityLogItem({ time: "10:42 AM", event: "Main Gate unlocked", user: "You" })
          ActivityLogItem({ time: "09:15 AM", event: "Guest Entry Denied", user: "System" })
          ActivityLogItem({ time: "08:30 AM", event: "Garage Door opened", user: "Alice" })
          
          Blank().height(24) // Bottom padding
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
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
          .fontColor('#757575') // Gray
        
        Text("David Miller")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4 })
      }

      Blank()

      Row() {
        Image($r('app.media.ic_person')) // Placeholder for Person Icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .border({ width: 1, color: '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}

// --- Composable: Master Status Card ---
@Component
struct MasterStatusCard {
  @Link isLocked: boolean;
  onToggle: () => void = () => {};

  build() {
    Column() {
      Column() {
        // Circle Button
        Row() {
          if (this.isLocked) {
            Image($r('app.media.ic_lock')) // Placeholder for Lock Icon
              .width(36)
              .height(36)
              .fillColor(this.getStatusColor())
          } else {
            Image($r('app.media.ic_check_circle')) // Placeholder for CheckCircle Icon
              .width(36)
              .height(36)
              .fillColor(this.getStatusColor())
          }
        }
        .width(80)
        .height(80)
        .borderRadius(40)
        .backgroundColor(Color.White)
        .border({ width: 2, color: Color(this.getStatusColor()).withAlpha(0.1) })
        .onClick(() => {
          this.onToggle();
        })

        Blank().height(16)

        Text(this.isLocked ? "SECURE" : "UNLOCKED")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(2)
          .fontColor(this.getStatusColor())

        Blank().height(8)

        Text(this.isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
          .fontSize(14)
          .fontColor('#757575') // Gray
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .borderRadius(24)
    .backgroundColor('#F8F8F8')
    .border({ width: 1, color: '#EFEFEF' })
  }

  getStatusColor(): Color {
    return this.isLocked ? new Color('#212121') : new Color('#4CAF50');
  }
}

// --- Composable: Access Points ---
@Component
struct AccessPointList {
  @ObjectLink points: AccessPoint[];

  build() {
    Column({ space: 12 }) {
      ForEach(this.points, (point: AccessPoint) => {
        AccessPointRow({ point: point })
      })
    }
  }
}

@Component
struct AccessPointRow {
  @ObjectLink point: AccessPoint;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = !this.point.isLocked;
  }

  build() {
    Row() {
      Row() {
        Row() {
          Image($r('app.media.ic_home')) // Placeholder for Home Icon
            .width(20)
            .height(20)
            .fillColor(Color.Black)
        }
        .width(40)
        .height(40)
        .borderRadius(10)
        .backgroundColor('#FAFAFA')
        .justifyContent(FlexAlign.Center)

        Blank().width(16)

        Column() {
          Text(this.point.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Text(this.point.lastAccessed)
            .fontSize(12)
            .fontColor('#BDBDBD') // LightGray
            .margin({ top: 2 })
        }
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
        .width(44)
        .height(24)
        .selectedColor('#000000') // Checked Track Color
        .color('#EEEEEE') // Unchecked Track Color
    }
    .width('100%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#EEEEEE' })
    .alignItems(VerticalAlign.Center)
  }
}

// --- Composable: Activity Log ---
@Component
struct ActivityLogItem {
  time: string = "";
  event: string = "";
  user: string = "";

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor('#757575') // Gray
        .width(70)

      Divider()
        .vertical(true)
        .height(20)
        .strokeWidth(1)
        .color('#EEEEEE')

      Blank().width(16)

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        
        Text(`by ${this.user}`)
          .fontSize(12)
          .fontColor('#757575') // Gray
          .margin({ top: 2 })
      }
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }
}