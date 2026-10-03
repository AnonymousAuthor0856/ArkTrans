class SensorItem {
  title: string;
  value: string;
  unit: string;
  icon: string;
  warning: boolean;

  constructor(title: string, value: string, unit: string, icon: string, warning: boolean = false) {
    this.title = title;
    this.value = value;
    this.unit = unit;
    this.icon = icon;
    this.warning = warning;
  }
}

class LogEntry {
  time: string;
  message: string;
  system: boolean;

  constructor(time: string, message: string, system: boolean) {
    this.time = time;
    this.message = message;
    this.system = system;
  }
}

@Entry
@Component
struct MainActivity {
  @State locked: boolean = true;

  private sensors: SensorItem[] = [
    new SensorItem('PRESSURE', '1.02', 'Bar', 'i'),
    new SensorItem('O2 LEVEL', '19.5', '%', '!', true),
    new SensorItem('POWER', 'Stable', 'AC', '⚒'),
    new SensorItem('LIQUID N2', '88', '%', '↻')
  ];
  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ];

  @Builder
  TopBar() {
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
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('⚙')
        .fontSize(24)
        .fontColor('#212121')
        .width(44)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: 24, right: 24, top: 24, bottom: 12 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SystemStatusBadge() {
    Row({ space: 8 }) {
      Text('✓')
        .fontSize(16)
        .fontColor('#388E3C')
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#388E3C')
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .alignItems(VerticalAlign.Center)
    .border({ width: 1, color: '#80388E3C' })
    .borderRadius(25)
    .alignSelf(ItemAlign.Start)
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#757575')
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Light)
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
  }

  @Builder
  SensorCard(sensor: SensorItem) {
    Column() {
      Row() {
        Text(sensor.icon)
          .fontSize(20)
          .fontColor(sensor.warning ? '#D32F2F' : '#0066CC')
        if (sensor.warning) {
          Circle().width(6).height(6).fill('#D32F2F')
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(sensor.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
        Text(`${sensor.unit}  ${sensor.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
      }
      .margin({ top: 12 })
      .alignItems(HorizontalAlign.Start)
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard(this.sensors[0])
        this.SensorCard(this.sensors[1])
      }
      .width('100%')
      Row({ space: 12 }) {
        this.SensorCard(this.sensors[2])
        this.SensorCard(this.sensors[3])
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  LogItem(log: LogEntry) {
    Column() {
      Row() {
        Text(log.system ? '↻' : '●')
          .fontSize(16)
          .fontColor('#757575')
          .textAlign(TextAlign.Center)
          .width(32)
          .height(32)
          .lineHeight(32)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
        Column() {
          Text(log.message)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212121')
          Text(log.time)
            .fontSize(11)
            .fontColor('#757575')
        }
        .layoutWeight(1)
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding({ top: 4, bottom: 4 })
      .alignItems(VerticalAlign.Center)
      Divider().color('#F5F5F5')
    }
    .width('100%')
  }

  @Builder
  BottomControlBar() {
    Row() {
      Column() {
        Text('MANUAL OVERRIDE')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
        Text(this.locked ? 'LOCKED' : 'ACTIVE')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.locked ? '#212121' : '#D32F2F')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Toggle({ type: ToggleType.Switch, isOn: !this.locked })
        .selectedColor('#D32F2F')
        .onChange((value: boolean) => {
          this.locked = !value;
        })
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: '#26000000', offsetY: -4 })
  }

  build() {
    Column() {
      this.TopBar()
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
          .fontColor('#757575')
          .width('100%')
        Blank().height(8)
        Scroll() {
          Column({ space: 8 }) {
            ForEach(this.logs, (log: LogEntry) => {
              this.LogItem(log)
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
