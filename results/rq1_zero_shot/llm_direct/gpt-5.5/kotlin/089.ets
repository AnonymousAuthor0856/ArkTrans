const PrimaryBlue: string = '#0066CC'
const AlertRed: string = '#D32F2F'
const SafeGreen: string = '#388E3C'
const SafeGreenBorder: string = '#80388E3C'
const BackgroundWhite: string = '#FFFFFF'
const SurfaceGrey: string = '#F5F5F5'
const TextDark: string = '#212121'
const TextGrey: string = '#757575'
const Transparent: string = '#00000000'

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
struct CryoGenApp {
  @State isLocked: boolean = true

  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ]

  build() {
    Column() {
      this.SimpleTopBar()

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
          .fontColor(TextGrey)
          .letterSpacing(1.5)

        Blank().height(8)

        this.ActivityLogList()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24 })

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }

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

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(TextDark)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Transparent)
      .padding(0)
      .width(48)
      .height(48)
      .onClick(() => {
      })
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(SafeGreen)

      Blank().width(8)

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(SafeGreen)
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({
      width: 1,
      color: SafeGreenBorder,
      radius: 50
    })
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
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(TextGrey)
          .padding({ bottom: 12, left: 4 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ⓘ', false)
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true)
      }
      .width('100%')

      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '🔧', false)
        this.SensorCard('LIQUID N2', '88', '%', '⟳', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean = false) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? AlertRed : PrimaryBlue)

        if (isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(AlertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Blank().height(12)

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
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor(SurfaceGrey)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  ActivityLogList() {
    List({ space: 0 }) {
      ForEach(this.logs, (log: LogEntry) => {
        ListItem() {
          Column() {
            Row() {
              Stack() {
                Circle()
                  .width(32)
                  .height(32)
                  .fill(SurfaceGrey)

                Text(log.isSystem ? '⟳' : '👤')
                  .fontSize(16)
                  .fontColor(TextGrey)
              }
              .width(32)
              .height(32)

              Blank().width(12)

              Column() {
                Text(log.message)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(TextDark)

                Text(log.time)
                  .fontSize(11)
                  .fontColor(TextGrey)
              }
              .alignItems(HorizontalAlign.Start)
            }
            .width('100%')
            .padding({ top: 4, bottom: 4 })
            .alignItems(VerticalAlign.Center)

            Divider()
              .color(SurfaceGrey)
              .strokeWidth(1)
          }
          .width('100%')
        }
      }, (log: LogEntry) => `${log.time}-${log.message}`)
    }
    .width('100%')
    .layoutWeight(1)
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

      Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
        .selectedColor(AlertRed)
        .switchPointColor(this.isLocked ? TextGrey : BackgroundWhite)
        .onChange((isOn: boolean) => {
          this.isLocked = !isOn
        })
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor(BackgroundWhite)
    .shadow({
      radius: 12,
      color: '#33000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}