import { router } from '@kit.ArkUI';

// App Colors
const CryoColors = {
  primaryBlue: '#0066CC',
  alertRed: '#D32F2F',
  safeGreen: '#388E3C',
  backgroundWhite: '#FFFFFF',
  surfaceGrey: '#F5F5F5',
  textDark: '#212121',
  textGrey: '#757575',
  safeGreenOpacity: '#80388E3C',
};

interface LogEntryData {
  id: number;
  time: string;
  message: string;
  isSystem: boolean;
}

@Entry
@Component
struct ContentView {
  build() {
    CryoGenMonitorScreen()
  }
}

@Component
struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        SimpleTopBar()
          .margin({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor(CryoColors.backgroundWhite)

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
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)

            Blank().height(8)

            // Log List
            ActivityLogList()

            // Space for bottom bar
            Blank().height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(CryoColors.backgroundWhite)

      // Bottom Bar Overlay
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
      Column({ space: 0 }) {
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

      Blank()

      Button({ type: ButtonType.Normal }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(CryoColors.textDark)
      }
      .backgroundColor(Color.Transparent)
      .padding(0)
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
        .fontColor(CryoColors.safeGreen)

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
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
    Column({ space: 0 }) {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey)

      Row({ space: 4 }) {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(CryoColors.textGrey)
          .alignSelf(ItemAlign.End)
          .margin({ bottom: 8 })
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
struct SensorCard {
  title: string = '';
  value: string = '';
  unit: string = '';
  iconText: string = '';
  isWarning: boolean = false;

  build() {
    Column({ space: 0 }) {
      // Header Row
      Row() {
        Text(this.iconText)
          .fontSize(20)
          .fontColor(this.isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)

        Blank()

        if (this.isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(CryoColors.alertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      // Value Column
      Column({ space: 0 }) {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)

        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
  }
}

@Component
struct ActivityLogList {
  private logs: LogEntryData[] = [
    { id: 1, time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { id: 2, time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { id: 3, time: '06:30 AM', message: 'Technician access', isSystem: false },
    { id: 4, time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { id: 5, time: 'Yesterday', message: 'System Reboot', isSystem: true },
  ];

  build() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntryData) => {
        Column({ space: 0 }) {
          Row({ space: 12 }) {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fill(CryoColors.surfaceGrey)

              Text(log.isSystem ? 'ℹ' : '🔧')
                .fontSize(16)
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
            .layoutWeight(1)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 4, bottom: 4 })

          Divider()
            .color(CryoColors.surfaceGrey)
        }
      }, (log: LogEntryData) => log.id.toString())
    }
    .width('100%')
  }
}

@Component
struct BottomControlBar {
  @State private isLocked: boolean = true;

  build() {
    Column({ space: 0 }) {
      Divider()
        .color('#1A000000')
        .height(1)

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

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(CryoColors.alertRed)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(CryoColors.backgroundWhite)
    }
    .width('100%')
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    })
    .backgroundColor(CryoColors.backgroundWhite)
  }
}