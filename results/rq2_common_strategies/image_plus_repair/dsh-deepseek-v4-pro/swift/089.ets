@Component
struct CryoGenApp {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    // .preferredColorScheme(.light) and .statusBarHidden(true) have no direct
    // declarative ArkUI equivalent; the screen uses a fixed light (white) palette.
    CryoGenMonitorScreen()
  }
}

// MARK: - App Colors
class CryoColors {
  static readonly primaryBlue: string = '#0066CC';
  static readonly alertRed: string = '#D32F2F';
  static readonly safeGreen: string = '#388E3C';
  static readonly backgroundWhite: string = '#FFFFFF';
  static readonly surfaceGrey: string = '#F5F5F5';
  static readonly textDark: string = '#212121';
  static readonly textGrey: string = '#757575';
}

// MARK: - Main Screen
@Entry
@Component
struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        SimpleTopBar()
          .padding({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor(CryoColors.backgroundWhite)

        // Content
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(16)

            // Status Badge
            SystemStatusBadge()

            Blank().height(32)

            // Temperature Display
            MainTemperatureDisplay()

            Blank().height(32)

            // Grid
            SensorGrid()

            Blank().height(24)

            // Activity Log Header
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)

            Blank().height(8)

            // Log List
            ActivityLogList()

            // Space for bottom bar
            Blank().height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - Components

@Component
struct SimpleTopBar {
  build() {
    Row() {
      Column({ space: 0 }) {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        // SF Symbol "gearshape.fill"
        Text('⚙️')
          .fontSize(24)
          .fontColor(CryoColors.textDark)
      }
      .backgroundColor(Color.Transparent)
      .onClick(() => {})
    }
    .width('100%')
    .height(56)
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row({ space: 8 }) {
      // SF Symbol "checkmark"
      Text('✓')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: '#80388E3C', radius: 50 })
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    Column({ space: 0 }) {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey)
      Row({ space: 4 }) {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor(CryoColors.textGrey)
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SensorGrid {
  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false })
        SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true })
      }
      .width('100%')

      Row({ space: 12 }) {
        SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false })
        SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false })
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct SensorCard {
  title: string = '';
  value: string = '';
  unit: string = '';
  iconName: string = '';
  isWarning: boolean = false;

  iconGlyph(): string {
    if (this.iconName === 'info.circle.fill') {
      return 'ℹ️';
    }
    if (this.iconName === 'exclamationmark.triangle.fill') {
      return '⚠️';
    }
    if (this.iconName === 'wrench.and.screwdriver.fill') {
      return '🔧';
    }
    if (this.iconName === 'arrow.clockwise') {
      return '🔄';
    }
    return '•';
  }

  build() {
    Column({ space: 0 }) {
      // Header Row
      Row() {
        Text(this.iconGlyph())
          .fontSize(20)
          .fontColor(this.isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)
        Blank()
        if (this.isWarning) {
          Circle()
            .fill(CryoColors.alertRed)
            .width(6)
            .height(6)
        }
      }
      .width('100%')

      Blank().height(12)

      // Value Column
      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)
        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
  }
}

@Component
struct ActivityLogList {
  logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ];

  build() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Column({ space: 0 }) {
          Row({ space: 12 }) {
            Stack({ alignContent: Alignment.Center }) {
              Circle()
                .fill(CryoColors.surfaceGrey)
                .width(32)
                .height(32)
              // SF Symbol: log.isSystem ? "info.circle.fill" : "wrench.fill"
              Text(log.isSystem ? 'ℹ️' : '🔧')
                .fontSize(16)
                .fontColor(CryoColors.textGrey)
            }

            Column({ space: 2 }) {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(CryoColors.textDark)
              Text(log.time)
                .fontSize(11)
                .fontColor(CryoColors.textGrey)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding({ top: 4, bottom: 4 })

          Divider()
            .color(CryoColors.surfaceGrey)
        }
        .width('100%')
      }, (log: LogEntry) => log.id)
    }
    .width('100%')
  }
}

class LogEntry {
  id: string;
  time: string;
  message: string;
  isSystem: boolean;
  static nextId: number = 0;

  constructor(time: string, message: string, isSystem: boolean) {
    LogEntry.nextId = LogEntry.nextId + 1;
    this.id = 'log-' + LogEntry.nextId.toString();
    this.time = time;
    this.message = message;
    this.isSystem = isSystem;
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true;

  build() {
    Column({ space: 0 }) {
      // Shadow simulation via background logic; standard shadow works fine
      Rect()
        .fill(Color.White)
        .width('100%')
        .height(1)
        .shadow({ color: '#1A000000', radius: 2, offsetX: 0, offsetY: -2 })

      Row() {
        Column({ space: 2 }) {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(CryoColors.textGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? CryoColors.textDark : CryoColors.alertRed)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // SwiftUI Binding(get: { !isLocked }, set: { isLocked = !$0 }) mirrored via onChange
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
          .selectedColor(CryoColors.alertRed)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({ color: '#1A000000', radius: 12, offsetX: 0, offsetY: -4 })
    }
    .width('100%')
  }
}
