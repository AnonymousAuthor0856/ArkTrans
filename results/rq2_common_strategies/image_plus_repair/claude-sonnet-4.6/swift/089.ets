import { LengthMetrics } from '@kit.ArkUI';

// Colors
const primaryBlue = '#0066CC';
const alertRed = '#D32F2F';
const safeGreen = '#388E3C';
const backgroundWhite = '#FFFFFF';
const surfaceGrey = '#F5F5F5';
const textDark = '#212121';
const textGrey = '#757575';

interface LogEntryData {
  id: number;
  time: string;
  message: string;
  isSystem: boolean;
}

const logs: LogEntryData[] = [
  { id: 1, time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
  { id: 2, time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
  { id: 3, time: '06:30 AM', message: 'Technician access', isSystem: false },
  { id: 4, time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
  { id: 5, time: 'Yesterday', message: 'System Reboot', isSystem: true },
];

@Component
struct SimpleTopBar {
  build() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(textGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(textDark)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('⚙')
        .fontSize(24)
        .fontColor(textDark)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.SpaceBetween)
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
        .fontColor(safeGreen)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: '#7DC47E', radius: 50 })
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(textGrey)
        .width('100%')
      Row({ space: 4 }) {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(textDark)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontColor(textGrey)
          .alignSelf(ItemAlign.End)
          .margin({ bottom: 8 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct SensorCard {
  title: string = '';
  value: string = '';
  unit: string = '';
  iconText: string = '';
  isWarning: boolean = false;

  build() {
    Column() {
      Row() {
        Text(this.iconText)
          .fontSize(20)
          .fontColor(this.isWarning ? alertRed : primaryBlue)
        Blank()
        if (this.isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(alertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(textDark)
        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(textGrey)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(surfaceGrey)
    .borderRadius(12)
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
          iconText: 'ℹ',
          isWarning: false
        })
        SensorCard({
          title: 'O2 LEVEL',
          value: '19.5',
          unit: '%',
          iconText: '⚠',
          isWarning: true
        })
      }
      .width('100%')

      Row({ space: 12 }) {
        SensorCard({
          title: 'POWER',
          value: 'Stable',
          unit: 'AC',
          iconText: '🔧',
          isWarning: false
        })
        SensorCard({
          title: 'LIQUID N2',
          value: '88',
          unit: '%',
          iconText: '↻',
          isWarning: false
        })
      }
      .width('100%')
    }
    .width('100%')
  }
}

@Component
struct ActivityLogList {
  build() {
    Column({ space: 0 }) {
      ForEach(logs, (log: LogEntryData) => {
        Column() {
          Row({ space: 12 }) {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill(surfaceGrey)
              Text(log.isSystem ? 'ℹ' : '🔧')
                .fontSize(16)
                .fontColor(textGrey)
            }
            .width(32)
            .height(32)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(textDark)
              Text(log.time)
                .fontSize(11)
                .fontColor(textGrey)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Blank()
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider()
            .color(surfaceGrey)
            .strokeWidth(1)
        }
        .width('100%')
      }, (log: LogEntryData) => log.id.toString())
    }
    .width('100%')
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true;

  build() {
    Column() {
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)
      Row() {
        Column() {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(textGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? textDark : alertRed)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(alertRed)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(backgroundWhite)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(backgroundWhite)
    .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: -4 })
  }
}

@Entry
@Component
struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Column() {
          SimpleTopBar()
        }
        .padding({ top: 24, bottom: 12, left: 24, right: 24 })
        .backgroundColor(backgroundWhite)
        .width('100%')

        // Scrollable Content
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(16)

            // Status Badge
            SystemStatusBadge()

            Blank().height(32)

            // Temperature Display
            MainTemperatureDisplay()

            Blank().height(32)

            // Sensor Grid
            SensorGrid()

            Blank().height(24)

            // Maintenance Log Header
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(textGrey)
              .letterSpacing(1.5)
              .width('100%')

            Blank().height(8)

            // Log List
            ActivityLogList()

            // Space for bottom bar
            Blank().height(100)
          }
          .padding({ left: 24, right: 24 })
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(backgroundWhite)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(backgroundWhite)

      // Bottom Bar Overlay
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundWhite)
  }
}