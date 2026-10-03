// CryoGen Monitor — ArkTS (HarmonyOS / ArkUI) conversion
// EntryAbility loads: windowStage.loadContent('pages/Index', ...)

class CryoColors {
  static readonly primaryBlue: string = '#0066CC';
  static readonly alertRed: string = '#D32F2F';
  static readonly safeGreen: string = '#388E3C';
  static readonly backgroundWhite: string = '#FFFFFF';
  static readonly surfaceGrey: string = '#F5F5F5';
  static readonly textDark: string = '#212121';
  static readonly textGrey: string = '#757575';
  static readonly borderGreen: string = '#80388E3C';
}

class LogEntry {
  time: string;
  message: string;
  isSystem: boolean;

  constructor(time: string, message: string, isSystem: boolean) {
    this.time = time;
    this.message = message;
    this.isSystem = isSystem;
  }
}

@Entry
@Component
struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // ---------- Top Bar ----------
        SimpleTopBar()

        // ---------- Scrollable content ----------
        Scroll() {
          Column() {
            // Status badge
            SystemStatusBadge()
              .margin({ top: 16 })

            // Core temperature
            MainTemperatureDisplay()
              .margin({ top: 32 })

            // Sensor grid
            SensorGrid()
              .margin({ top: 32 })

            // Maintenance log header
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)
              .margin({ top: 24, bottom: 8 })

            // Log list
            ActivityLogList()

            // Space for the bottom bar
            Row().height(100)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(CryoColors.backgroundWhite)

      // ---------- Bottom overlay bar ----------
      BottomControlBar()
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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        SymbolGlyph($r('sys.symbol.gearshape_fill'))
          .fontSize(24)
          .fontColor([CryoColors.textDark])
      }
      .backgroundColor(Color.Transparent)
      .width(40)
      .height(40)
      .padding(0)
    }
    .width('100%')
    .height(56)
    .padding({ left: 24, right: 24 })
    .margin({ top: 24, bottom: 12 })
    .backgroundColor(CryoColors.backgroundWhite)
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row({ space: 8 }) {
      SymbolGlyph($r('sys.symbol.checkmark'))
        .fontSize(14)
        .fontColor([CryoColors.safeGreen])

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: CryoColors.borderGreen, radius: 50 })
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
          .fontWeight(FontWeight.Light)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(CryoColors.textGrey)
          .margin({ left: 4, bottom: 8 })
      }
      .alignItems(VerticalAlign.Bottom)
      .margin({ top: 4 })
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
          iconName: $r('sys.symbol.info_circle_fill'),
          isWarning: false
        })
          .layoutWeight(1)

        SensorCard({
          title: 'O2 LEVEL',
          value: '19.5',
          unit: '%',
          iconName: $r('sys.symbol.exclamationmark_triangle_fill'),
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
          iconName: $r('sys.symbol.wrench_and_screwdriver_fill'),
          isWarning: false
        })
          .layoutWeight(1)

        SensorCard({
          title: 'LIQUID N2',
          value: '88',
          unit: '%',
          iconName: $r('sys.symbol.arrow_clockwise'),
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
  title: string = '';
  value: string = '';
  unit: string = '';
  iconName: Resource = $r('sys.symbol.info_circle_fill');
  isWarning: boolean = false;

  build() {
    Column() {
      // Header row: icon on the left, warning dot on the right
      Row() {
        SymbolGlyph(this.iconName)
          .fontSize(20)
          .fontColor([this.isWarning ? CryoColors.alertRed : CryoColors.primaryBlue])

        Blank()

        if (this.isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(CryoColors.alertRed)
        }
      }
      .width('100%')

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)

        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .margin({ top: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
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
  ];

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

              SymbolGlyph(log.isSystem
                ? $r('sys.symbol.info_circle_fill')
                : $r('sys.symbol.wrench_fill'))
                .fontSize(16)
                .fontColor([CryoColors.textGrey])
            }
            .width(32)
            .height(32)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(CryoColors.textDark)

              Text(log.time)
                .fontSize(11)
                .fontColor(CryoColors.textGrey)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank()
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider()
            .color(CryoColors.surfaceGrey)
            .strokeWidth(1)
        }
        .width('100%')
      }, (log: LogEntry) => `${log.time}-${log.message}`)
    }
    .width('100%')
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true;

  build() {
    Column() {
      // Hairline separator above the bar
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(CryoColors.backgroundWhite)
        .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: -2 })

      Row() {
        Column() {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(CryoColors.textGrey)

          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? CryoColors.textDark : CryoColors.alertRed)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(CryoColors.alertRed)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(CryoColors.backgroundWhite)
    }
    .width('100%')
    .backgroundColor(CryoColors.backgroundWhite)
    .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: -4 })
  }
}