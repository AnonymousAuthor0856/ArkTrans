// Translated from SwiftUI (Swift) to ArkTS (ArkUI)
// Source: CryoGenApp

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}

@Component
struct ContentView {
  build() {
    CryoGenMonitorScreen()
  }
}

// MARK: - Main Screen
@Component
struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        SimpleTopBar()
          .padding({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor('#FFFFFF')

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
              .fontColor('#757575')
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

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}

// MARK: - Components

@Component
struct SimpleTopBar {
  build() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')

        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor('#212121')
      }
      .onClick(() => {})
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
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#388E3C')

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#388E3C')
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: '#80388E3C', radius: 50 })
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#757575')

      Row({ space: 4 }) {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#212121')
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor('#757575')
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SensorGrid {
  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'ℹ', isWarning: false })
        SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: '⚠', isWarning: true })
      }
      .width('100%')

      Row({ space: 12 }) {
        SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: '🛠', isWarning: false })
        SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', iconName: '🔄', isWarning: false })
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
        Text(this.iconName)
          .fontSize(20)
          .fontColor(this.isWarning ? '#D32F2F' : '#0066CC')

        Blank()

        if (this.isWarning) {
          Circle()
            .fill('#D32F2F')
            .width(6)
            .height(6)
        }
      }
      .width('100%')

      Blank().height(12)

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')

        Text(this.unit + '  ' + this.title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

class LogEntry {
  id: string
  time: string
  message: string
  isSystem: boolean

  constructor(time: string, message: string, isSystem: boolean) {
    this.id = message
    this.time = time
    this.message = message
    this.isSystem = isSystem
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
  ]

  build() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row({ space: 12 }) {
            Stack() {
              Circle()
                .fill('#F5F5F5')
                .width(32)
                .height(32)

              Text(log.isSystem ? 'ℹ' : '🔧')
                .fontSize(16)
                .fontColor('#757575')
            }
            .width(32)
            .height(32)

            Column({ space: 2 }) {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#212121')

              Text(log.time)
                .fontSize(11)
                .fontColor('#757575')
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 4, bottom: 4 })

          Divider().backgroundColor('#F5F5F5')
        }
      }, (log: LogEntry) => log.id)
    }
    .width('100%')
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true

  build() {
    Column() {
      Column()
        .width('100%')
        .height(1)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 2, color: '#1A000000', offsetY: -2 })

      Row() {
        Column({ space: 2 }) {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')

          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? '#212121' : '#D32F2F')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .onChange((isOn: boolean) => { this.isLocked = !isOn })
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }
}
