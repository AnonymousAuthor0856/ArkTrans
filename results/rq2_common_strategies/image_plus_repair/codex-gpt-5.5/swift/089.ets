const PRIMARY_BLUE: string = '#0066CC';
const ALERT_RED: string = '#D32F2F';
const SAFE_GREEN: string = '#388E3C';
const BACKGROUND_WHITE: string = '#FFFFFF';
const SURFACE_GREY: string = '#F5F5F5';
const TEXT_DARK: string = '#212121';
const TEXT_GREY: string = '#757575';

interface SensorInfo {
  title: string;
  value: string;
  unit: string;
  icon: string;
  warning: boolean;
}

interface LogInfo {
  time: string;
  message: string;
  system: boolean;
}

@Entry
@Component
struct CryoGenMonitorScreen {
  @State isLocked: boolean = true;

  private logs: LogInfo[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', system: true },
    { time: '07:45 AM', message: 'Pressure stabilized', system: true },
    { time: '06:30 AM', message: 'Technician access', system: false },
    { time: '02:15 AM', message: 'Nitrogen refill', system: true },
    { time: 'Yesterday', message: 'System Reboot', system: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.SimpleTopBar()

        Scroll() {
          Column() {
            Blank()
              .height(16)

            this.SystemStatusBadge()

            Blank()
              .height(32)

            this.MainTemperatureDisplay()

            Blank()
              .height(32)

            this.SensorGrid()

            Blank()
              .height(24)

            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(TEXT_GREY)
              .letterSpacing(1.5)

            Blank()
              .height(8)

            this.ActivityLogList()

            Blank()
              .height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
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
  SimpleTopBar() {
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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal, stateEffect: false }) {
        Text('⚙')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
          .textAlign(TextAlign.Center)
      }
      .width(48)
      .height(48)
      .padding(0)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(92)
    .padding({ left: 24, right: 24, top: 24, bottom: 12 })
    .backgroundColor(BACKGROUND_WHITE)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(SAFE_GREEN)
        .lineHeight(20)

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(SAFE_GREEN)
        .letterSpacing(1)
        .margin({ left: 10 })
    }
    .height(55)
    .padding({ left: 24, right: 24 })
    .border({
      width: 1,
      color: '#93C99B',
      radius: 28
    })
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_GREY)
        .letterSpacing(0.5)

      Row() {
        Text('-184.2')
          .fontSize(84)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TEXT_DARK)
          .letterSpacing(-2)

        Text('°C')
          .fontSize(34)
          .fontWeight(FontWeight.Regular)
          .fontColor(TEXT_GREY)
          .margin({ left: 4, top: 22 })
      }
      .alignItems(VerticalAlign.Bottom)
      .height(116)
      .margin({ top: 10 })
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SensorGrid() {
    Column() {
      Row() {
        this.SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', icon: 'i', warning: false })
        Blank().width(12)
        this.SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', icon: '!', warning: true })
      }
      .width('100%')

      Row() {
        this.SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', icon: 'tools', warning: false })
        Blank().width(12)
        this.SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', icon: 'refresh', warning: false })
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
  }

  @Builder
  SensorCard(item: SensorInfo) {
    Column() {
      Row() {
        this.SensorIcon(item.icon, item.warning)
        Blank()
        if (item.warning) {
          Circle()
            .width(12)
            .height(12)
            .fill(ALERT_RED)
        }
      }
      .width('100%')
      .height(36)

      Blank()

      Text(item.value)
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_DARK)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(item.unit + '  ' + item.title)
        .fontSize(19)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT_GREY)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(32)
    .height(205)
    .layoutWeight(1)
    .backgroundColor(SURFACE_GREY)
    .borderRadius(20)
  }

  @Builder
  SensorIcon(icon: string, warning: boolean) {
    if (icon === 'i') {
      Stack() {
        Circle()
          .width(40)
          .height(40)
          .fill(PRIMARY_BLUE)
        Text('i')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(BACKGROUND_WHITE)
      }
      .width(40)
      .height(40)
    } else if (icon === '!') {
      Stack() {
        Polygon({ width: 42, height: 38 })
          .points([[21, 0], [42, 38], [0, 38]])
          .fill(ALERT_RED)
        Text('!')
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .fontColor(BACKGROUND_WHITE)
          .margin({ top: 8 })
      }
      .width(42)
      .height(42)
    } else if (icon === 'tools') {
      Text('⚒')
        .fontSize(42)
        .fontColor(PRIMARY_BLUE)
        .lineHeight(42)
    } else {
      Text('↻')
        .fontSize(45)
        .fontWeight(FontWeight.Medium)
        .fontColor(PRIMARY_BLUE)
        .lineHeight(45)
    }
  }

  @Builder
  ActivityLogList() {
    Column() {
      ForEach(this.logs, (log: LogInfo) => {
        Column() {
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill(SURFACE_GREY)
              Text(log.system ? 'i' : '⚒')
                .fontSize(log.system ? 18 : 17)
                .fontWeight(FontWeight.Bold)
                .fontColor(TEXT_GREY)
            }
            .width(32)
            .height(32)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(TEXT_DARK)
                .maxLines(1)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              Text(log.time)
                .fontSize(11)
                .fontColor(TEXT_GREY)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)
            .margin({ left: 12 })
          }
          .width('100%')
          .height(44)
          .alignItems(VerticalAlign.Center)
          .padding({ top: 4, bottom: 4 })

          Divider()
            .strokeWidth(1)
            .color(SURFACE_GREY)
        }
        .width('100%')
      }, (log: LogInfo) => log.time + log.message)
    }
    .width('100%')
  }

  @Builder
  BottomControlBar() {
    Column() {
      Row() {
        Column() {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(TEXT_GREY)

          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? TEXT_DARK : ALERT_RED)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(ALERT_RED)
          .switchPointColor(BACKGROUND_WHITE)
          .width(104)
          .height(62)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
      }
      .width('100%')
      .height(96)
      .padding({ left: 24, right: 24, top: 20, bottom: 20 })
      .backgroundColor(BACKGROUND_WHITE)
    }
    .width('100%')
    .backgroundColor(BACKGROUND_WHITE)
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}
