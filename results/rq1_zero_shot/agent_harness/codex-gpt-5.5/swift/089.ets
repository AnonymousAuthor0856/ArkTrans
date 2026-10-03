class CryoColors {
  static primaryBlue: string = '#0066CC';
  static alertRed: string = '#D32F2F';
  static safeGreen: string = '#388E3C';
  static backgroundWhite: string = '#FFFFFF';
  static surfaceGrey: string = '#F5F5F5';
  static textDark: string = '#212121';
  static textGrey: string = '#757575';
}

class LogEntry {
  time: string;
  message: string;
  isSystem: boolean;

  constructor(time: string, message: string, isSystem: boolean) {
    this.time = time;
    this.message = message;
    this.isSystem = isSystem;
  }
}

@Entry
@Component
struct CryoGenMonitorScreen {
  @State private isLocked: boolean = true;
  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ];

  @Builder
  private SimpleTopBar() {
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
      Button('⚙')
        .fontSize(24)
        .fontColor(CryoColors.textDark)
        .backgroundColor(Color.Transparent)
    }
    .height(56)
    .width('100%')
  }

  @Builder
  private SystemStatusBadge() {
    Row({ space: 8 }) {
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
    .border({ width: 1, color: '#388E3C80' })
    .borderRadius(50)
  }

  @Builder
  private MainTemperatureDisplay() {
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
        Text('°C')
          .fontSize(24)
          .fontColor(CryoColors.textGrey)
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private SensorCard(title: string, value: string, unit: string, iconName: string, isWarning: boolean) {
    Column({ space: 0 }) {
      Row() {
        Text(iconName)
          .fontSize(20)
          .fontColor(isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)
        Blank()
        if (isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(CryoColors.alertRed)
        }
      }
      .width('100%')
      Blank().height(12)
      Column({ space: 0 }) {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)
        Text(`${unit}  ${title}`)
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

  @Builder
  private SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'i', false)
        this.SensorCard('O2 LEVEL', '19.5', '%', '!', true)
      }
      .width('100%')
      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '⚒', false)
        this.SensorCard('LIQUID N2', '88', '%', '↻', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  private LogItem(log: LogEntry) {
    Column({ space: 0 }) {
      Row({ space: 12 }) {
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill(CryoColors.surfaceGrey)
          Text(log.isSystem ? 'i' : '🔧')
            .fontSize(16)
            .fontColor(CryoColors.textGrey)
        }
        .width(32)
        .height(32)
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
      .padding({ top: 4, bottom: 4 })
      .width('100%')
      Divider().color(CryoColors.surfaceGrey)
    }
  }

  @Builder
  private ActivityLogList() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        this.LogItem(log)
      })
    }
    .width('100%')
  }

  @Builder
  private BottomControlBar() {
    Column({ space: 0 }) {
      Rect()
        .width('100%')
        .height(1)
        .fill(Color.White)
        .shadow({ radius: 2, color: '#0000001A', offsetX: 0, offsetY: -2 })
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
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(CryoColors.alertRed)
          .onChange((enabled: boolean) => {
            this.isLocked = !enabled;
          })
      }
      .padding(24)
      .width('100%')
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({ radius: 12, color: '#0000001A', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.SimpleTopBar()
          .padding({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor(CryoColors.backgroundWhite)

        Scroll() {
          Column({ space: 0 }) {
            Blank().height(16)
            this.SystemStatusBadge()
            Blank().height(32)
            this.MainTemperatureDisplay()
            Blank().height(32)
            this.SensorGrid()
            Blank().height(24)
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .width('100%')
              .textAlign(TextAlign.Start)
            Blank().height(8)
            this.ActivityLogList()
            Blank().height(100)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomControlBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite)
  }
}
