import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - Models
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// MARK: - Colors
const SecureColors: Record<string, string> = {
  primary: '#000000',
  surface: '#F8F8F8',
  locked: '#212121',
  unlocked: '#4CAF50',
  border: '#EFEFEF',
  textGray: '#9E9E9E',
  backgroundWhite: '#FFFFFF'
};

@Entry
@Component
struct SecureKeyApp {
  @State masterLockState: boolean = true;

  accessPoints: AccessPoint[] = [
    { id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago" },
    { id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago" },
    { id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday" }
  ];

  build() {
    Column() {
      // Header
      this.HeaderSection()
        .padding({ top: 24 })

      Blank().height(40)

      // Master Status Card
      this.MasterStatusCard(this.masterLockState, () => {
        this.masterLockState = !this.masterLockState;
      })

      Blank().height(32)

      // Access Points Header
      Text("My Access Points")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Blank().height(16)

      // Access Points List
      Column({ space: 12 }) {
        ForEach(this.accessPoints, (point: AccessPoint) => {
          this.AccessPointRow(point)
        })
      }

      Blank().height(32)

      // Recent Activity Header
      Text("Recent Activity")
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')

      Blank().height(16)

      // Activity Log
      Column() {
        this.ActivityLogItem("10:42 AM", "Main Gate unlocked", "You")
        this.ActivityLogItem("09:15 AM", "Guest Entry Denied", "System")
        this.ActivityLogItem("08:30 AM", "Garage Door opened", "Alice")
      }

      Blank().height(24)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .backgroundColor(SecureColors.backgroundWhite)
  }

  @Builder
  HeaderSection(): void {
    Row() {
      Column({ space: 2 }) {
        Text("Welcome back,")
          .fontSize(14)
          .fontColor(SecureColors.textGray)

        Text("David Miller")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(SecureColors.primary)
      }

      Blank()

      Stack() {
        Circle()
          .fill('#F5F5F5')
          .width(48)
          .height(48)
          .border({ width: 1, color: '#E0E0E0' })

        Image($r('app.media.ic_person'))
          .width(20)
          .height(20)
          .objectFit(ImageFit.Contain)
      }
    }
    .width('100%')
  }

  @Builder
  MasterStatusCard(isLocked: boolean, onToggle: () => void): void {
    Column() {
      Button() {
        Stack() {
          Circle()
            .fill(Color.White)
            .width(80)
            .height(80)
            .border({ width: 2, color: isLocked ? '#2121211A' : '#4CAF501A' })

          Image(isLocked ? $r('app.media.ic_lock') : $r('app.media.ic_check'))
            .width(36)
            .height(36)
            .objectFit(ImageFit.Contain)
        }
      }
      .type(ButtonType.Normal)
      .onClick(onToggle)
      .margin({ bottom: 16 })

      Text(isLocked ? "SECURE" : "UNLOCKED")
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .letterSpacing(2)
        .fontColor(isLocked ? SecureColors.locked : SecureColors.unlocked)

      Blank().height(8)

      Text(isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
        .fontSize(14)
        .fontColor(SecureColors.textGray)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border })
  }

  @Builder
  AccessPointRow(item: AccessPoint): void {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Capsule()
            .fill('#FAFAFA')
            .width(40)
            .height(40)

          Image($r('app.media.ic_home'))
            .width(20)
            .height(20)
            .objectFit(ImageFit.Contain)
        }

        Column({ space: 2 }) {
          Text(item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(SecureColors.primary)

          Text(item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
        }
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: !item.isLocked })
        .onChange((isOn: boolean) => {
          // Handle toggle state change if needed
        })
        .width(44)
        .height(24)
        .selectedColor(SecureColors.primary)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }

  @Builder
  ActivityLogItem(time: string, event: string, user: string): void {
    Row() {
      Text(time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start)

      Divider()
        .vertical(true)
        .height(20)
        .color('#EEEEEE')
        .margin({ left: 16, right: 16 })

      Column({ space: 2 }) {
        Text(event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(SecureColors.primary)

        Text(`by ${user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
      }

      Blank()
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}