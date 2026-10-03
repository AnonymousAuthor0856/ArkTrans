class CryoColors {
  static readonly primaryBlue: string = '#0066CC'
  static readonly alertRed: string = '#D32F2F'
  static readonly safeGreen: string = '#388E3C'
  static readonly backgroundWhite: string = '#FFFFFF'
  static readonly surfaceGrey: string = '#F5F5F5'
  static readonly textDark: string = '#212121'
  static readonly textGrey: string = '#757575'
}

class LogEntry {
  id: string
  time: string
  message: string
  isSystem: boolean

  constructor(time: string, message: string, isSystem: boolean) {
    this.time = time
    this.message = message
    this.isSystem = isSystem
    this.id = `${time}-${message}`
  }
}

@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        SimpleTopBar()
          .padding({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor(CryoColors.backgroundWhite)

        Scroll() {
          Column() {
            Blank().height(16)

            SystemStatusBadge()

            Blank().height(32)

            MainTemperatureDisplay()

            Blank().height(32)

            SensorGrid()

            Blank().height(24)

            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)

            Blank().height(8)

            ActivityLogList()

            Blank().height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(CryoColors.backgroundWhite)

      BottomControlBar({ isLocked: $isLocked })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite)
  }
}

@Component
struct SimpleTopBar {
  build() {
    Row() {
      Column() {
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

      Blank().layoutWeight(1)

      Text('⚙')
        .fontSize(32)
        .fontColor(CryoColors.textDark)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(56)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row({ space: 8 }) {
      Text('✓')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
        .letterSpacing(1)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({
      width: 1,
      color: '#80388E3C',
      radius: 50
    })
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey)

      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor(CryoColors.textGrey)
          .margin({ left: 4, bottom: 8 })
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
        SensorCard({
          title: 'PRESSURE',
          value: '1.02',
          unit: 'Bar',
          iconName: 'info.circle.fill',
          isWarning: false
        })
          .layoutWeight(1)

        SensorCard({
          title: 'O2 LEVEL',
          value: '19.5',
          unit: '%',
          iconName: 'exclamationmark.triangle.fill',
          isWarning: true
        })
          .layoutWeight(1)
      }
      .width('100%')

      Row({ space: 12 }) {
        SensorCard({
          title: 'POWER',
          value: 'Stable',
          unit: 'AC',
          iconName: 'wrench.and.screwdriver.fill',
          isWarning: false
        })
          .layoutWeight(1)

        SensorCard({
          title: 'LIQUID N2',
          value: '88',
          unit: '%',
          iconName: 'arrow.clockwise',
          isWarning: false
        })
          .layoutWeight(1)
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct SensorCard {
  title: string = ''
  value: string = ''
  unit: string = ''
  iconName: string = ''
  isWarning: boolean = false

  build() {
    Column() {
      Row() {
        SensorIcon({
          iconName: this.iconName,
          isWarning: this.isWarning
        })

        Blank().layoutWeight(1)

        if (this.isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(CryoColors.alertRed)
        }
      }
      .width('100%')
      .height(28)

      Blank().height(12)

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)

        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
          .letterSpacing(0.5)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .height(104)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
  }
}

@Component
struct SensorIcon {
  iconName: string = ''
  isWarning: boolean = false

  build() {
    Stack() {
      if (this.iconName === 'info.circle.fill') {
        Circle()
          .width(20)
          .height(20)
          .fill(CryoColors.primaryBlue)

        Text('i')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
      } else if (this.iconName === 'exclamationmark.triangle.fill') {
        Text('▲')
          .fontSize(32)
          .fontColor(CryoColors.alertRed)

        Text('!')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 4 })
      } else if (this.iconName === 'wrench.and.screwdriver.fill') {
        Text('⚒')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.primaryBlue)
      } else {
        Text('↻')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.primaryBlue)
      }
    }
    .width(28)
    .height(28)
  }
}

@Component
struct ActivityLogList {
  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ]

  build() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row({ space: 12 }) {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill(CryoColors.surfaceGrey)

              Text(log.isSystem ? 'i' : '⚒')
                .fontSize(log.isSystem ? 16 : 14)
                .fontWeight(FontWeight.Bold)
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

            Blank().layoutWeight(1)
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider()
            .strokeWidth(1)
            .color(CryoColors.surfaceGrey)
        }
        .width('100%')
      }, (log: LogEntry) => log.id)
    }
    .width('100%')
  }
}

@Component
struct BottomControlBar {
  @Link isLocked: boolean

  build() {
    Column() {
      Blank()
        .height(1)
        .width('100%')
        .backgroundColor(CryoColors.backgroundWhite)
        .shadow({
          radius: 2,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -2
        })

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

        Blank().layoutWeight(1)

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(CryoColors.alertRed)
          .switchPointColor(Color.White)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({
        radius: 12,
        color: '#1A000000',
        offsetX: 0,
        offsetY: -4
      })
    }
    .width('100%')
  }
}