class SensorData {
  title: string
  value: string
  unit: string
  icon: string
  warning: boolean

  constructor(title: string, value: string, unit: string, icon: string, warning: boolean) {
    this.title = title
    this.value = value
    this.unit = unit
    this.icon = icon
    this.warning = warning
  }
}

class LogEntry {
  time: string
  message: string
  system: boolean

  constructor(time: string, message: string, system: boolean) {
    this.time = time
    this.message = message
    this.system = system
  }
}

@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  private sensors: SensorData[] = [
    new SensorData('PRESSURE', '1.02', 'Bar', 'i', false),
    new SensorData('O2 LEVEL', '19.5', '%', '!', true),
    new SensorData('POWER', 'Stable', 'AC', '◇', false),
    new SensorData('LIQUID N2', '88', '%', '↻', false)
  ]

  private logs: LogEntry[] = [
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
            this.SystemStatusBadge()
            this.MainTemperatureDisplay()
            this.SensorGrid()
            Text('MAINTENANCE LOG')
              .width('100%')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
              .margin({ top: 24, bottom: 8 })
            this.ActivityLogList()
          }
          .width('100%')
          .padding({ left: 24, right: 24, bottom: 116 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

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
          .fontColor('#757575')
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Button('⚙')
        .fontSize(24)
        .fontColor('#212121')
        .backgroundColor(Color.Transparent)
        .width(48)
        .height(48)
        .padding(0)
    }
    .width('100%')
    .height(92)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(16)
        .fontColor('#388E3C')
        .fontWeight(FontWeight.Bold)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#388E3C')
        .margin({ left: 8 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: 'rgba(56,142,60,0.5)', radius: 50 })
    .alignItems(VerticalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontColor('#757575')
        .fontWeight(FontWeight.Medium)
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor('#212121')
        Text('°C')
          .fontSize(24)
          .fontColor('#757575')
          .margin({ left: 4, bottom: 12 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 })
  }

  @Builder
  SensorGrid() {
    Grid() {
      ForEach(this.sensors, (sensor: SensorData) => {
        GridItem() {
          this.SensorCard(sensor)
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(12)
    .columnsGap(12)
    .width('100%')
    .height(220)
    .margin({ top: 32 })
  }

  @Builder
  SensorCard(sensor: SensorData) {
    Column() {
      Row() {
        Text(sensor.icon)
          .fontSize(20)
          .fontColor(sensor.warning ? '#D32F2F' : '#0066CC')
          .fontWeight(FontWeight.Bold)
        if (sensor.warning) {
          Circle()
            .width(6)
            .height(6)
            .fill('#D32F2F')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      Text(sensor.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#212121')
        .margin({ top: 12 })
      Text(sensor.unit + '  ' + sensor.title)
        .fontSize(10)
        .fontWeight(FontWeight.Bold)
        .fontColor('#757575')
        .margin({ top: 2 })
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .borderRadius(12)
    .backgroundColor('#F5F5F5')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ActivityLogList() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        this.LogRow(log)
      })
    }
    .width('100%')
  }

  @Builder
  LogRow(log: LogEntry) {
    Column() {
      Row() {
        Stack() {
          Circle()
            .width(32)
            .height(32)
            .fill('#F5F5F5')
          Text(log.system ? '↻' : '人')
            .fontSize(16)
            .fontColor('#757575')
        }
        Column() {
          Text(log.message)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212121')
          Text(log.time)
            .fontSize(11)
            .fontColor('#757575')
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 4, bottom: 4 })
      Divider()
        .color('#F5F5F5')
    }
    .width('100%')
    .margin({ bottom: 8 })
  }

  @Builder
  BottomControlBar() {
    Row() {
      Column() {
        Text('MANUAL OVERRIDE')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
        Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isLocked ? '#212121' : '#D32F2F')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
        .selectedColor('#D32F2F')
        .onChange((on: boolean) => {
          this.isLocked = !on
        })
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .shadow({ radius: 12, color: 'rgba(0,0,0,0.12)', offsetY: -4 })
  }
}
