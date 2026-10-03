interface LogEntry {
  time: string
  message: string
  isSystem: boolean
}

const logs: LogEntry[] = [
  { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
  { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
  { time: '06:30 AM', message: 'Technician access', isSystem: false },
  { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
  { time: 'Yesterday', message: 'System Reboot', isSystem: true }
]

@Entry
@Component
struct Index {
  build() {
    Column() {
      SimpleTopBar()

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
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
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
          .fontColor('#757575')
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
      }
      Button({ type: ButtonType.Circle }) {
        Text('⚙').fontSize(24).fontColor('#212121')
      }
      .width(48).height(48)
      .backgroundColor('#00000000')
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row() {
      Text('✓').fontSize(16).fontColor('#388E3C')
      Blank().width(8)
      Text('SYSTEM NOMINAL')
        .fontColor('#388E3C')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: 'rgba(56, 142, 60, 0.5)', radius: 25 })
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
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
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontColor('#757575')
          .margin({ bottom: 12, left: 4 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SensorGrid {
  build() {
    Column() {
      Row() {
        SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', icon: 'ⓘ', isWarning: false })
        SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', icon: '⚠', isWarning: true })
      }
      .width('100%')
      .space(12)

      Row() {
        SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', icon: '🛠', isWarning: false })
        SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', icon: '↻', isWarning: false })
      }
      .width('100%')
      .space(12)
    }
    .space(12)
  }
}

@Component
struct SensorCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop unit: string = ''
  @Prop icon: string = ''
  @Prop isWarning: boolean = false

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(20)
          .fontColor(this.isWarning ? '#D32F2F' : '#0066CC')
        if (this.isWarning) {
          Stack() {}
            .width(6).height(6)
            .borderRadius(3)
            .backgroundColor('#D32F2F')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

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
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }
}

@Component
struct ActivityLogList {
  build() {
    Column() {
      ForEach(logs, (log: LogEntry) => {
        Column() {
          Row() {
            Stack() {
              Text(log.isSystem ? '↻' : '👤')
                .fontSize(16)
                .fontColor('#757575')
            }
            .width(32).height(32)
            .borderRadius(16)
            .backgroundColor('#F5F5F5')
            .alignContent(Alignment.Center)

            Blank().width(12)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#212121')
              Text(log.time)
                .fontSize(11)
                .fontColor('#757575')
            }
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider().color('#F5F5F5').strokeWidth(1)
        }
      }, (log: LogEntry) => log.time + log.message)
    }
    .width('100%')
    .space(8)
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true

  build() {
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
      }

      Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
        .selectedColor('#D32F2F')
        .switchPointColor('#FFFFFF')
        .onChange((isOn: boolean) => { this.isLocked = !isOn })
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: 'rgba(0, 0, 0, 0.2)' })
  }
}
