import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';

// MARK: - App Colors
interface CryoColorConfig {
  primaryBlue: string;
  alertRed: string;
  safeGreen: string;
  backgroundWhite: string;
  surfaceGrey: string;
  textDark: string;
  textGrey: string;
}

const CryoColors: CryoColorConfig = {
  primaryBlue: '#0066CC',
  alertRed: '#D32F2F',
  safeGreen: '#388E3C',
  backgroundWhite: '#FFFFFF',
  surfaceGrey: '#F5F5F5',
  textDark: '#212121',
  textGrey: '#757575'
};

@Entry
@Component
struct CryoGenApp {
  build() {
    Column() {
      CryoGenMonitorScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite)
  }
}

// MARK: - Main Screen
@Component
struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        SimpleTopBar()
          .padding({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor(CryoColors.backgroundWhite)

        // Content
        Scroll() {
          Column({ space: 0 }) {
            Column().height(16)

            // Status Badge
            SystemStatusBadge()

            Column().height(32)

            // Temperature Display
            MainTemperatureDisplay()

            Column().height(32)

            // Grid
            SensorGrid()

            Column().height(24)

            // Activity Log Header
            Text("MAINTENANCE LOG")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)

            Column().height(8)

            // Log List
            ActivityLogList()

            // Space for bottom bar
            Column().height(100)
          }
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')

      // Bottom Bar Overlay
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct SimpleTopBar {
  build() {
    Row() {
      Column({ space: 0 }) {
        Text("UNIT-04")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)

        Text("CryoGen Monitor")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Image($r('app.media.settings')) // Placeholder for gear icon
          .width(24)
          .height(24)
          .fillColor(Color.Black)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
    }
    .height(56)
    .width('100%')
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row() {
      // Using a simple checkmark symbol or image
      Image($r('app.media.check')) 
        .width(14)
        .height(14)
        .fillColor(Color.Green)

      Text("SYSTEM NOMINAL")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: Color.Cyan.opacity(0.5), radius: 50 }) // Approximating stroke with border
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    Column({ space: 0 }) {
      Text("CORE TEMPERATURE")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey)

      Row() {
        Text("-184.2")
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)

        Text("°C")
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor(CryoColors.textGrey)
      }
      .verticalCenter(VerticalAlign.Top)
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
          title: "PRESSURE",
          value: "1.02",
          unit: "Bar",
          iconName: $r('app.media.info'),
          isWarning: false
        })

        SensorCard({
          title: "O2 LEVEL",
          value: "19.5",
          unit: "%",
          iconName: $r('app.media.warning'),
          isWarning: true
        })
      }

      Row({ space: 12 }) {
        SensorCard({
          title: "POWER",
          value: "Stable",
          unit: "AC",
          iconName: $r('app.media.tools'),
          isWarning: false
        })

        SensorCard({
          title: "LIQUID N2",
          value: "88",
          unit: "%",
          iconName: $r('app.media.refresh'),
          isWarning: false
        })
      }
    }
  }
}

interface SensorCardProps {
  title: string;
  value: string;
  unit: string;
  iconName: Resource;
  isWarning: boolean;
}

@Component
struct SensorCard {
  @Prop title: string;
  @Prop value: string;
  @Prop unit: string;
  @Prop iconName: Resource;
  @Prop isWarning: boolean;

  build() {
    Column({ space: 0 }) {
      // Header Row
      Row() {
        Image(this.iconName)
          .width(20)
          .height(20)
          .fillColor(this.isWarning ? Color.Red : Color.Blue)

        Blank()

        if (this.isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fillColor(Color.Red)
        }
      }

      Column().height(12)

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
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
  }
}

interface LogEntry {
  id: number;
  time: string;
  message: string;
  isSystem: boolean;
}

@Component
struct ActivityLogList {
  private logs: LogEntry[] = [
    { id: 1, time: "08:00 AM", message: "Auto-Cycle Complete", isSystem: true },
    { id: 2, time: "07:45 AM", message: "Pressure stabilized", isSystem: true },
    { id: 3, time: "06:30 AM", message: "Technician access", isSystem: false },
    { id: 4, time: "02:15 AM", message: "Nitrogen refill", isSystem: true },
    { id: 5, time: "Yesterday", message: "System Reboot", isSystem: true }
  ];

  build() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Column({ space: 0 }) {
          Row() {
            Stack() {
              Circle()
                .width(32)
                .height(32)
                .fillColor(Color.Gray)

              Image(log.isSystem ? $r('app.media.info') : $r('app.media.wrench'))
                .width(16)
                .height(16)
                .fillColor(Color.Gray)
            }

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

            Blank()
          }
          .padding({ top: 4, bottom: 4 })

          Divider()
            .color(CryoColors.surfaceGrey)
            .strokeWidth(1)
        }
      })
    }
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true;

  build() {
    Column({ space: 0 }) {
      // Shadow simulation line
      Rect()
        .width('100%')
        .height(1)
        .fillColor(Color.White)
        .shadow({ radius: 2, color: Color.Black, offsetY: -2 })

      Row() {
        Column({ space: 2 }) {
          Text("MANUAL OVERRIDE")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(CryoColors.textGrey)

          Text(this.isLocked ? "LOCKED" : "ACTIVE")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? CryoColors.textDark : CryoColors.alertRed)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
          .selectedColor(CryoColors.alertRed)
      }
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({ radius: 12, color: Color.Black, offsetY: -4 })
    }
    .width('100%')
  }
}