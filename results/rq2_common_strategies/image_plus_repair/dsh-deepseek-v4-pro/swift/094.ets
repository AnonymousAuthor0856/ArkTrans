// SwiftUI -> ArkTS (HarmonyOS ArkUI) translation
// Original: SecureKeyApp - a smart-lock / access-control UI

interface AccessPoint {
  id: string
  name: string
  status: string
  isLocked: boolean
  lastAccessed: string
}

// MARK: - Colors
class SecureColors {
  static readonly primary: ResourceColor = Color.Black
  static readonly surface: ResourceColor = '#F8F8F8'
  static readonly locked: ResourceColor = '#212121'
  static readonly unlocked: ResourceColor = '#4CAF50'
  static readonly border: ResourceColor = '#EFEFEF'
  static readonly textGray: ResourceColor = Color.Gray
  static readonly backgroundWhite: ResourceColor = Color.White
}

@Entry
@Component
struct SecureKeyApp {
  build() {
    // WindowGroup { ContentView() }
    Stack() {
      ContentView()
    }
  }
}

@Component
struct ContentView {
  build() {
    SecureKeyScreen()
    // .preferredColorScheme(.light)
    // .statusBarHidden(true)
  }
}

// MARK: - Main Screen
@Component
struct SecureKeyScreen {
  @State masterLockState: boolean = true

  accessPoints: AccessPoint[] = [
    { id: "1", name: "Main Entrance", status: "Active", isLocked: true, lastAccessed: "2h ago" },
    { id: "2", name: "Garage Door", status: "Active", isLocked: false, lastAccessed: "12m ago" },
    { id: "3", name: "Server Room", status: "Restricted", isLocked: true, lastAccessed: "Yesterday" }
  ]

  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          // Header
          HeaderSection()
            .padding({ top: 24 })

          Blank().height(40)

          // Master Status Card
          MasterStatusCard({
            isLocked: this.masterLockState,
            onToggle: () => {
              this.masterLockState = !this.masterLockState
            }
          })

          Blank().height(32)

          // Access Points Header
          Text('My Access Points')
            .fontSize(16)
            .fontWeight(700) // TitleMedium approx
            .fontColor('#333333') // DarkGray

          Blank().height(16)

          // Access Points List
          Column({ space: 12 }) {
            ForEach(this.accessPoints, (point: AccessPoint) => {
              AccessPointRow({ item: point })
            }, (point: AccessPoint) => point.id)
          }

          Blank().height(32)

          // Recent Activity Header
          Text('Recent Activity')
            .fontSize(16)
            .fontWeight(700) // TitleMedium approx
            .fontColor('#333333')

          Blank().height(16)

          // Activity Log
          Column({ space: 0 }) {
            ActivityLogItem({ time: "10:42 AM", event: "Main Gate unlocked", user: "You" })
            ActivityLogItem({ time: "09:15 AM", event: "Guest Entry Denied", user: "System" })
            ActivityLogItem({ time: "08:30 AM", event: "Garage Door opened", user: "Alice" })
          }

          Blank().height(24)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(SecureColors.backgroundWhite)
  }
}

// MARK: - Components

@Component
struct HeaderSection {
  build() {
    Row() {
      Column({ space: 2 }) {
        Text('Welcome back,')
          .fontSize(14) // BodyMedium approx
          .fontColor(SecureColors.textGray)

        Text('David Miller')
          .fontSize(24)
          .fontWeight(900) // HeadlineSmall + ExtraBold approx
          .fontColor(Color.Black)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        // Image(systemName: "person.fill")
        Text('👤')
          .fontSize(20)
          .fontColor(Color.Black)
      }
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
  }
}

@Component
struct MasterStatusCard {
  isLocked: boolean = false
  onToggle: () => void = () => {}

  statusColor(): ResourceColor {
    return this.isLocked ? SecureColors.locked : SecureColors.unlocked
  }

  statusIcon(): string {
    return this.isLocked ? '🔒' : '✅'
  }

  build() {
    Column({ space: 0 }) {
      // Icon Button
      Button({ type: ButtonType.Normal }) {
        Stack() {
          Circle()
            .width(80)
            .height(80)
            .fill(Color.White)
            .stroke(this.statusColor())
            .strokeWidth(2)
            .strokeOpacity(0.1)

          // Image(systemName: isLocked ? "lock.fill" : "checkmark.circle.fill")
          Text(this.statusIcon())
            .fontSize(36)
            .fontColor(this.statusColor())
        }
      }
      .onClick(() => {
        this.onToggle()
      })
      .padding({ bottom: 16 })

      // Status Text
      Text(this.isLocked ? 'SECURE' : 'UNLOCKED')
        .fontSize(22)
        .fontWeight(900)
        .letterSpacing(2)
        .fontColor(this.statusColor())

      Blank().height(8)

      // Subtext
      Text(this.isLocked ? 'All perimeter doors are locked.' : 'Perimeter access is currently open.')
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
  item: AccessPoint = { id: "", name: "", status: "", isLocked: false, lastAccessed: "" }
  @State checked: boolean = false

  aboutToAppear() {
    this.checked = !this.item.isLocked
  }

  build() {
    Row() {
      Row({ space: 16 }) {
        Stack() {
          Column()
            .width(40)
            .height(40)
            .backgroundColor('#FAFAFA')
            .borderRadius(10)

          // Image(systemName: "house.fill")
          Text('🏠')
            .fontSize(20)
            .fontColor(Color.Black)
        }

        Column({ space: 2 }) {
          Text(this.item.name)
            .fontSize(16)
            .fontWeight(600) // BodyLarge + SemiBold
            .fontColor(Color.Black)

          Text(this.item.lastAccessed)
            .fontSize(11) // LabelSmall
            .fontColor('#CCCCCC') // LightGray approximation
        }
        .alignItems(HorizontalAlign.Start)
      }

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: this.checked })
        .selectedColor(Color.Black)
        .onChange((isOn: boolean) => {
          this.checked = isOn
        })
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

@Component
struct ActivityLogItem {
  time: string = ""
  event: string = ""
  user: string = ""

  build() {
    Row() {
      Text(this.time)
        .fontSize(12) // LabelMedium
        .fontColor(SecureColors.textGray)
        .width(70)
        .textAlign(TextAlign.Start)

      Column()
        .width(1)
        .height(20)
        .backgroundColor('#EEEEEE')
        .margin({ right: 16 })

      Column({ space: 2 }) {
        Text(this.event)
          .fontSize(14)
          .fontWeight(500) // BodyMedium + Medium
          .fontColor(Color.Black)

        Text(`by ${this.user}`)
          .fontSize(11) // LabelSmall
          .fontColor(SecureColors.textGray)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }
}
