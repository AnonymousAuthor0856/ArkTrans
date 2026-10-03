const PRIMARY_BLUE: string = '#0066CC'
const ALERT_RED: string = '#D32F2F'
const SAFE_GREEN: string = '#388E3C'
const BACKGROUND_WHITE: string = '#FFFFFF'
const SURFACE_GREY: string = '#F5F5F5'
const TEXT_DARK: string = '#212121'
const TEXT_GREY: string = '#757575'

class LogEntry {
  time: string
  message: string
  isSystem: boolean

  constructor(time: string, message: string, isSystem: boolean) {
    this.time = time
    this.message = message
    this.isSystem = isSystem
  }
}

const LOGS: LogEntry[] = [
  new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
  new LogEntry('07:45 AM', 'Pressure stabilized', true),
  new LogEntry('06:30 AM', 'Technician access', false),
  new LogEntry('02:15 AM', 'Nitrogen refill', true),
  new LogEntry('Yesterday', 'System Reboot', true)
]

@Entry
@Component
struct Index {
  @State private isLocked: boolean = true

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.SimpleTopBar()

        Scroll() {
          Column() {
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
              .fontColor(TEXT_GREY)
              .letterSpacing(1.5)
              .width('100%')

            Blank().height(8)

            this.ActivityLogList()

            Blank().height(120)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BACKGROUND_WHITE)

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
  }

  @Builder
  private SimpleTopBar() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_GREY)

        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
          .margin({ top: 6 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(32)
          .fontColor(TEXT_DARK)
      }
      .type(ButtonType.Circle)
      .backgroundColor(Color.Transparent)
      .width(56)
      .height(56)
    }
    .width('100%')
    .height(56)
    .padding({ left: 24, right: 24 })
    .margin({ top: 24, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(24)
        .fontColor(SAFE_GREEN)
        .fontWeight(FontWeight.Normal)
        .width(24)

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(SAFE_GREEN)
        .letterSpacing(1.2)
        .margin({ left: 8 })
    }
    .height(36)
    .padding({ left: 12, right: 16 })
    .border({
      width: 1,
      color: '#80388E3C'
    })
    .borderRadius(50)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_GREY)
        .letterSpacing(1.2)

      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TEXT_DARK)
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(TEXT_GREY)
          .margin({ left: 4, bottom: 12 })
      }
      .alignItems(VerticalAlign.Bottom)
      .margin({ top: 14 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private SensorGrid() {
    Column() {
      Row() {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'i', PRIMARY_BLUE, false)
        Blank().width(12)
        this.SensorCard('O2 LEVEL', '19.5', '%', '!', ALERT_RED, true)
      }
      .width('100%')

      Row() {
        this.SensorCard('POWER', 'Stable', 'AC', '🔧', PRIMARY_BLUE, false)
        Blank().width(12)
        this.SensorCard('LIQUID N2', '88', '%', '⟳', PRIMARY_BLUE, false)
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
  }

  @Builder
  private SensorCard(title: string, value: string, unit: string, icon: string, iconColor: string, showDot: boolean) {
    Column() {
      Row() {
        if (icon === 'i') {
          Text(icon)
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(BACKGROUND_WHITE)
            .textAlign(TextAlign.Center)
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(iconColor)
        } else if (icon === '!') {
          Text('▲')
            .fontSize(31)
            .fontWeight(FontWeight.Bold)
            .fontColor(iconColor)
            .height(32)
            .width(32)
            .textAlign(TextAlign.Center)
        } else {
          Text(icon)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(iconColor)
            .width(32)
            .height(32)
            .textAlign(TextAlign.Center)
        }

        Blank()

        if (showDot) {
          Circle()
            .width(6)
            .height(6)
            .fill(ALERT_RED)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Blank().layoutWeight(1)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
          .maxLines(1)

        Text(unit + '  ' + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_GREY)
          .letterSpacing(0.6)
          .margin({ top: 8 })
          .maxLines(1)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .height(112)
    .layoutWeight(1)
    .padding(16)
    .backgroundColor(SURFACE_GREY)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  private ActivityLogList() {
    Column() {
      ForEach(LOGS, (log: LogEntry) => {
        Column() {
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill(SURFACE_GREY)

              Text(log.isSystem ? '⟳' : '👤')
                .fontSize(16)
                .fontColor(TEXT_GREY)
                .textAlign(TextAlign.Center)
            }
            .width(32)
            .height(32)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(TEXT_DARK)

              Text(log.time)
                .fontSize(11)
                .fontColor(TEXT_GREY)
                .margin({ top: 3 })
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 12 })
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider()
            .color(SURFACE_GREY)
            .strokeWidth(1)
        }
      }, (log: LogEntry) => log.time + log.message)
    }
    .width('100%')
  }

  @Builder
  private BottomControlBar() {
    Row() {
      Column() {
        Text('MANUAL OVERRIDE')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_GREY)
          .letterSpacing(0.8)

        Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isLocked ? TEXT_DARK : ALERT_RED)
          .margin({ top: 14 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row() {
        Stack() {
          Circle()
            .width(48)
            .height(48)
            .fill(this.isLocked ? '#8A8A8A' : ALERT_RED)

          Text(this.isLocked ? '🔒' : '⚠')
            .fontSize(23)
            .fontColor(BACKGROUND_WHITE)
            .textAlign(TextAlign.Center)
        }
        .width(48)
        .height(48)
      }
      .width(104)
      .height(56)
      .padding({ left: this.isLocked ? 8 : 48, right: this.isLocked ? 48 : 8 })
      .backgroundColor(SURFACE_GREY)
      .borderRadius(28)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.isLocked = !this.isLocked
      })
    }
    .width('100%')
    .height(96)
    .padding({ left: 24, right: 24 })
    .backgroundColor(BACKGROUND_WHITE)
    .alignItems(VerticalAlign.Center)
  }
}