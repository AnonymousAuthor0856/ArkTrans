// SecureKeyApp.ets

// MARK: - Models
interface AccessPoint {
  id: string;
  name: string;
  status: string;
  isLocked: boolean;
  lastAccessed: string;
}

// MARK: - Colors
class SecureColors {
  static readonly primary: string = '#000000';
  static readonly surface: string = '#F8F8F8';
  static readonly locked: string = '#212121';
  static readonly unlocked: string = '#4CAF50';
  static readonly border: string = '#EFEFEF';
  static readonly textGray: string = '#808080';
  static readonly backgroundWhite: string = '#FFFFFF';
}

// MARK: - Main Entry
@Entry
@Component
struct SecureKeyApp {
  build() {
    Column() {
      SecureKeyScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Main Screen
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true;

  private accessPoints: AccessPoint[] = [
    { id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago" },
    { id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago" },
    { id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday" }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(SecureColors.backgroundWhite)

      // Scrollable Content
      Scroll() {
        Column() {
          // Header
          HeaderSection()
            .margin({ top: 24 })

          // Spacer
          Blank().height(40)

          // Master Status Card
          MasterStatusCard({ isLocked: this.masterLockState, onToggle: () => {
            this.masterLockState = !this.masterLockState;
          }})

          // Spacer
          Blank().height(32)

          // Access Points Header
          Text("My Access Points")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          // Spacer
          Blank().height(16)

          // Access Points List
          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            })
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          // Spacer
          Blank().height(32)

          // Recent Activity Header
          Text("Recent Activity")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#333333')
            .alignSelf(ItemAlign.Start)

          // Spacer
          Blank().height(16)

          // Activity Log
          Column() {
            ActivityLogItem({ time: "10:42 AM", event: "Main Gate unlocked", user: "You" })
            ActivityLogItem({ time: "09:15 AM", event: "Guest Entry Denied", user: "System" })
            ActivityLogItem({ time: "08:30 AM", event: "Garage Door opened", user: "Alice" })
          }
          .width('100%')

          // Spacer
          Blank().height(24)
        }
        .padding({ left: 24, right: 24 })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      // Greeting
      Column() {
        Text("Welcome back,")
          .fontSize(14)
          .fontColor(SecureColors.textGray)
          .alignSelf(ItemAlign.Start)

        Text("David Miller")
          .fontSize(24)
          .fontWeight(FontWeight.Bolder)
          .fontColor(Color.Black)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      // Spacer
      Blank()

      // Profile Icon
      Stack() {
        Circle({ width: 48, height: 48 })
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        Text('👤')
          .fontSize(20)
      }
      .width(48)
      .height(48)
    }
    .width('100%')
  }
}

@Component
struct MasterStatusCard {
  @Prop isLocked: boolean;
  onToggle: () => void = () => {};

  get statusColor(): string {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked;
  }

  build() {
    Column() {
      // Icon Button
      Button({ type: ButtonType.Normal }) {
        Stack() {
          Circle({ width: 80, height: 80 })
            .fill(Color.White)
            .stroke(this.statusColor)
            .strokeWidth(2)
            .opacity(0.1)

          Text(this.isLocked ? '🔒' : '✅')
            .fontSize(36)
            .fontColor(this.statusColor)
        }
        .width(80)
        .height(80)
      }
      .onClick(() => {
        this.onToggle();
      })
      .backgroundColor(Color.Transparent)
      .margin({ bottom: 16 })

      // Status Text
      Text(this.isLocked ? "SECURE" : "UNLOCKED")
        .fontSize(22)
        .fontWeight(FontWeight.Bolder)
        .fontColor(this.statusColor)
        .letterSpacing(2)

      // Spacer
      Blank().height(8)

      // Subtext
      Text(this.isLocked ? "All perimeter doors are locked." : "Perimeter access is currently open.")
        .fontSize(14)
        .fontColor(SecureColors.textGray)
    }
    .padding(24)
    .width('100%')
    .backgroundColor(SecureColors.surface)
    .borderRadius(24)
    .border({ width: 1, color: SecureColors.border })
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
      Row({ space: 16 }) {
        // Icon Box
        Stack() {
          // Rounded Rectangle Background
          Column()
            .width(40)
            .height(40)
            .backgroundColor('#FAFAFA')
            .borderRadius(10)

          Text('🏠')
            .fontSize(20)
        }
        .width(40)
        .height(40)

        // Texts
        Column() {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Black)
            .alignSelf(ItemAlign.Start)

          Text(this.item.lastAccessed)
            .fontSize(11)
            .fontColor('#CCCCCC')
            .alignSelf(ItemAlign.Start)
        }
        .alignItems(HorizontalAlign.Start)
      }

      // Spacer
      Blank()

      // Toggle
      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.checked = isOn;
        })
    }
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
    .width('100%')
  }
}

@Component
struct ActivityLogItem {
  private time: string = "";
  private event: string = "";
  private user: string = "";

  build() {
    Row() {
      Text(this.time)
        .fontSize(12)
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start)

      // Divider
      Column()
        .width(1)
        .height(20)
        .backgroundColor('#EEEEEE')
        .margin({ right: 16 })

      Column() {
        Text(this.event)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.Black)
          .alignSelf(ItemAlign.Start)

        Text(`by ${this.user}`)
          .fontSize(11)
          .fontColor(SecureColors.textGray)
          .alignSelf(ItemAlign.Start)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .padding({ top: 12, bottom: 12 })
    .width('100%')
  }
}