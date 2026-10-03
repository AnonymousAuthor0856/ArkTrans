// entry/src/main/ets/pages/Index.ets
// Register this page in entry/src/main/resources/base/profile/main_pages.json

const PRIMARY_BLUE: string = '#0066CC';
const ALERT_RED: string = '#D32F2F';
const SAFE_GREEN: string = '#388E3C';
const SAFE_GREEN_ALPHA: string = '#80388E3C';
const BACKGROUND_WHITE: string = '#FFFFFF';
const SURFACE_GREY: string = '#F5F5F5';
const TEXT_DARK: string = '#212121';
const TEXT_GREY: string = '#757575';

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}

@Entry
@Component
struct CryoGenMonitor {
  @State isLocked: boolean = true;

  private logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true }
  ];

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
            .fontColor(TEXT_GREY)
            .letterSpacing(1.5)
            .margin({ top: 24 })

          this.ActivityLogList()
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  // --- Components ---

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
      }
      .alignItems(HorizontalAlign.Start)

      Text('⚙')
        .fontSize(24)
        .fontColor(TEXT_DARK)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding({ left: 24, right: 24, top: 24, bottom: 12 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(SAFE_GREEN)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(SAFE_GREEN)
        .margin({ left: 8 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: SAFE_GREEN_ALPHA, radius: 50 })
    .alignItems(VerticalAlign.Center)
    .margin({ top: 16 })
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(TEXT_GREY)

      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(300)
          .fontColor(TEXT_DARK)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(TEXT_GREY)
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
    Column() {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ⓘ', false)
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '🔧', false)
        this.SensorCard('LIQUID N2', '88', '%', '⟳', false)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .margin({ top: 12 })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(18)
          .fontColor(isWarning ? ALERT_RED : PRIMARY_BLUE)

        if (isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(ALERT_RED)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_DARK)
        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT_GREY)
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 12 })
    }
    .layoutWeight(1)
    .padding(16)
    .backgroundColor(SURFACE_GREY)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ActivityLogList() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        this.LogRow(log)
      }, (log: LogEntry) => log.message + log.time)
    }
    .width('100%')
    .margin({ top: 8 })
  }

  @Builder
  LogRow(log: LogEntry) {
    Column() {
      Row() {
        Stack({ alignContent: Alignment.Center }) {
          Text(log.isSystem ? '⟳' : '👤')
            .fontSize(14)
            .fontColor(TEXT_GREY)
        }
        .width(32)
        .height(32)
        .backgroundColor(SURFACE_GREY)
        .borderRadius(16)

        Column() {
          Text(log.message)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(TEXT_DARK)
          Text(log.time)
            .fontSize(11)
            .fontColor(TEXT_GREY)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ top: 4, bottom: 4 })

      Divider()
        .color(SURFACE_GREY)
        .strokeWidth(1)
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
          .fontColor(TEXT_GREY)
        Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isLocked ? TEXT_DARK : ALERT_RED)
      }
      .alignItems(HorizontalAlign.Start)

      Stack({ alignContent: this.isLocked ? Alignment.Start : Alignment.End }) {
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .width(52)
          .height(32)
          .selectedColor(ALERT_RED)
          .switchPointColor(BACKGROUND_WHITE)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })

        Text(this.isLocked ? '🔒' : '⚠')
          .fontSize(12)
          .margin({ left: 7, right: 7 })
          .hitTestBehavior(HitTestMode.None)
      }
      .width(52)
      .height(32)
    }
    .width('100%')
    .padding(24)
    .backgroundColor(BACKGROUND_WHITE)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }
}