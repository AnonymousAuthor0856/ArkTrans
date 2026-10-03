// Index.ets

// --- Theme Colors ---
const PrimaryBlue: string = '#0066CC';
const AlertRed: string = '#D32F2F';
const SafeGreen: string = '#388E3C';
const BackgroundWhite: string = '#FFFFFF';
const SurfaceGrey: string = '#F5F5F5';
const TextDark: string = '#212121';
const TextGrey: string = '#757575';

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}

@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true;

  private logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true },
  ];

  @Builder
  SimpleTopBar() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
      }
      .alignItems(HorizontalAlign.Start)

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(TextDark)
      }
      .type(ButtonType.Normal)
      .backgroundColor(BackgroundWhite)
      .onClick(() => {})
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(16)
        .fontColor(SafeGreen)
      Text('SYSTEM NOMINAL')
        .fontColor(SafeGreen)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 8 })
    }
    .border({ width: 1, color: SafeGreen, radius: 50 })
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontColor(TextGrey)
        .fontWeight(FontWeight.Medium)
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TextDark)
        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(TextGrey)
          .margin({ bottom: 12, left: 4 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean = false) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? AlertRed : PrimaryBlue)
        if (isWarning) {
          Text('')
            .width(6)
            .height(6)
            .borderRadius(3)
            .backgroundColor(AlertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGrey)
      }
      .margin({ top: 12 })
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .backgroundColor(SurfaceGrey)
    .borderRadius(12)
    .layoutWeight(1)
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ℹ')
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true)
      }
      .width('100%')

      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '🛠')
        this.SensorCard('LIQUID N2', '88', '%', '↻')
      }
      .width('100%')
    }
  }

  @Builder
  ActivityLogList() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        Row() {
          Text(log.isSystem ? '↻' : '👤')
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(SurfaceGrey)
            .textAlign(TextAlign.Center)
            .fontSize(16)
            .fontColor(TextGrey)

          Column() {
            Text(log.message)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(TextDark)
            Text(log.time)
              .fontSize(11)
              .fontColor(TextGrey)
          }
          .margin({ left: 12 })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding({ top: 4, bottom: 4 })
        .alignItems(VerticalAlign.Center)

        Divider()
          .color(SurfaceGrey)
          .strokeWidth(1)
      })
    }
  }

  @Builder
  BottomControlBar() {
    Row() {
      Column() {
        Text('MANUAL OVERRIDE')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGrey)
        Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isLocked ? TextDark : AlertRed)
      }
      .alignItems(HorizontalAlign.Start)

      Row() {
        Text(this.isLocked ? '🔒' : '⚠')
          .fontSize(16)
          .fontColor(this.isLocked ? TextGrey : BackgroundWhite)
      }
      .width(40)
      .height(24)
      .borderRadius(12)
      .backgroundColor(this.isLocked ? SurfaceGrey : AlertRed)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ left: 12 })
      .onClick(() => {
        this.isLocked = !this.isLocked;
      })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(BackgroundWhite)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 12, color: '#1A000000', offsetY: -2 })
  }

  build() {
    Column() {
      this.SimpleTopBar()

      Scroll() {
        Column() {
          this.SystemStatusBadge()
          this.MainTemperatureDisplay()
          this.SensorGrid()

          Text('MAINTENANCE LOG')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(TextGrey)
            .margin({ top: 24, bottom: 8 })

          this.ActivityLogList()
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .align(Alignment.Top)

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }
}