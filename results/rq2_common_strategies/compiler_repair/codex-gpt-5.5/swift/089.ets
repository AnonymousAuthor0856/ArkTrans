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

@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  private readonly primaryBlue: string = '#0066CC'
  private readonly alertRed: string = '#D32F2F'
  private readonly safeGreen: string = '#388E3C'
  private readonly surfaceGrey: string = '#F5F5F5'
  private readonly textDark: string = '#212121'
  private readonly textGrey: string = '#757575'
  private readonly logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ]

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
              .fontColor(this.textGrey)
              .letterSpacing(1.5)
              .width('100%')
            Blank().height(8)
            this.ActivityLogList()
            Blank().height(100)
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
      .backgroundColor(Color.White)
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  SimpleTopBar() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(this.textDark)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(92)
    .padding({ left: 24, right: 24, top: 24, bottom: 12 })
    .backgroundColor(Color.White)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.safeGreen)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.safeGreen)
        .margin({ left: 8 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .borderRadius(50)
    .border({ width: 1, color: '#80388E3C' })
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textGrey)
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.textDark)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontColor(this.textGrey)
          .margin({ left: 4, top: 24 })
      }
      .alignItems(VerticalAlign.Top)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SensorGrid() {
    Column() {
      Row() {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'i', false)
        Blank().width(12)
        this.SensorCard('O2 LEVEL', '19.5', '%', '!', true)
      }
      .width('100%')
      Blank().height(12)
      Row() {
        this.SensorCard('POWER', 'Stable', 'AC', '⚒', false)
        Blank().width(12)
        this.SensorCard('LIQUID N2', '88', '%', '↻', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, iconText: string, isWarning: boolean) {
    Column() {
      Row() {
        Text(iconText)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(isWarning ? this.alertRed : this.primaryBlue)
        Blank()
        if (isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(this.alertRed)
        }
      }
      .width('100%')
      Blank().height(12)
      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
        Text(unit + '  ' + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textGrey)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .height(112)
    .layoutWeight(1)
    .backgroundColor(this.surfaceGrey)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ActivityLogList() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill(this.surfaceGrey)
              Text(log.isSystem ? 'i' : '⚒')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.textGrey)
            }
            .width(32)
            .height(32)
            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textDark)
              Text(log.time)
                .fontSize(11)
                .fontColor(this.textGrey)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 12 })
            Blank()
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          Divider().color(this.surfaceGrey)
        }
      }, (log: LogEntry) => log.time + log.message)
    }
    .width('100%')
  }

  @Builder
  BottomControlBar() {
    Column() {
      Rect()
        .height(1)
        .width('100%')
        .fill(Color.White)
      Row() {
        Column() {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.textGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? this.textDark : this.alertRed)
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(this.alertRed)
          .onChange((value: boolean) => {
            this.isLocked = !value
          })
      }
      .padding(24)
      .width('100%')
      .backgroundColor(Color.White)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
  }
}