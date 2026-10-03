// CryoGenApp.ets
import { 
  EntryComponent, 
  Component, 
  Build, 
  Column, 
  Row, 
  Text, 
  Button, 
  Image, 
  Stack, 
  Scroll, 
  Divider, 
  ForEach, 
  State, 
  Toggle, 
  Circle, 
  Rect, 
  Spacer, 
  FontWeight, 
  FontSize, 
  Color, 
  Alignment, 
  EdgeInsets, 
  BorderRadius, 
  Shadow 
} from '@ohos.arkui';

// MARK: - App Colors
class CryoColors {
  static readonly primaryBlue: Color = Color.rgb(0, 102, 204);
  static readonly alertRed: Color = Color.rgb(211, 47, 47);
  static readonly safeGreen: Color = Color.rgb(56, 142, 60);
  static readonly backgroundWhite: Color = Color.WHITE;
  static readonly surfaceGrey: Color = Color.rgb(245, 245, 245);
  static readonly textDark: Color = Color.rgb(33, 33, 33);
  static readonly textGrey: Color = Color.rgb(117, 117, 117);
}

// MARK: - Data Models
class LogEntry {
  id: string = Math.random().toString(36).substring(7);
  time: string;
  message: string;
  isSystem: boolean;

  constructor(time: string, message: string, isSystem: boolean) {
    this.time = time;
    this.message = message;
    this.isSystem = isSystem;
  }
}

// MARK: - Main Entry
@EntryComponent
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
    Stack({ alignment: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(CryoColors.backgroundWhite)

      Column() {
        // Top Bar
        SimpleTopBar()
          .padding({ top: 24, bottom: 12, left: 24, right: 24 })
          .backgroundColor(CryoColors.backgroundWhite)

        // Content
        Scroll() {
          Column() {
            // Spacer
            Spacer().height(16)

            // Status Badge
            SystemStatusBadge()

            Spacer().height(32)

            // Temperature Display
            MainTemperatureDisplay()

            Spacer().height(32)

            // Grid
            SensorGrid()

            Spacer().height(24)

            // Activity Log Header
            Text("MAINTENANCE LOG")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)

            Spacer().height(8)

            // Log List
            ActivityLogList()

            // Space for bottom bar
            Spacer().height(100)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(Alignment.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

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
      Column() {
        Text("UNIT-04")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)

        Text("CryoGen Monitor")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)
      }
      .alignItems(Alignment.Start)

      Spacer()

      Button({ type: ButtonType.Normal }) {
        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(CryoColors.textDark)
      }
      .backgroundColor(Color.Transparent)
      .width(48)
      .height(48)
    }
    .width('100%')
    .height(56)
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row() {
      Image($r('sys.media.ohos_ic_public_check'))
        .width(14)
        .height(14)
        .fillColor(CryoColors.safeGreen)
        .margin({ right: 8 })

      Text("SYSTEM NOMINAL")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .borderRadius(50)
    .border({ width: 1, color: Color.opacity(CryoColors.safeGreen, 0.5) })
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    Column() {
      Text("CORE TEMPERATURE")
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey)
        .margin({ bottom: 4 })

      Row() {
        Text("-184.2")
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)

        Text("°C")
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(CryoColors.textGrey)
          .margin({ left: 4, bottom: 8 })
      }
      .alignItems(Alignment.Bottom)
    }
    .alignItems(Alignment.Start)
  }
}

@Component
struct SensorGrid {
  build() {
    Column() {
      Row() {
        SensorCard({
          title: "PRESSURE",
          value: "1.02",
          unit: "Bar",
          iconName: $r('sys.media.ohos_ic_public_info'),
          isWarning: false
        })

        Spacer().width(12)

        SensorCard({
          title: "O2 LEVEL",
          value: "19.5",
          unit: "%",
          iconName: $r('sys.media.ohos_ic_public_warning'),
          isWarning: true
        })
      }
      .width('100%')

      Spacer().height(12)

      Row() {
        SensorCard({
          title: "POWER",
          value: "Stable",
          unit: "AC",
          iconName: $r('sys.media.ohos_ic_public_tools'),
          isWarning: false
        })

        Spacer().width(12)

        SensorCard({
          title: "LIQUID N2",
          value: "88",
          unit: "%",
          iconName: $r('sys.media.ohos_ic_public_refresh'),
          isWarning: false
        })
      }
      .width('100%')
    }
  }
}

@Component
struct SensorCard {
  @Prop title: string;
  @Prop value: string;
  @Prop unit: string;
  @Prop iconName: Resource;
  @Prop isWarning: boolean;

  build() {
    Column() {
      // Header Row
      Row() {
        Image(this.iconName)
          .width(20)
          .height(20)
          .fillColor(this.isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)

        Spacer()

        if (this.isWarning) {
          Circle({ width: 6, height: 6 })
            .fill(CryoColors.alertRed)
        }
      }
      .width('100%')

      Spacer().height(12)

      // Value Column
      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)

        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
      }
      .alignItems(Alignment.Start)
    }
    .padding(16)
    .width('50%')
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
  }
}

@Component
struct ActivityLogList {
  private logs: LogEntry[] = [
    new LogEntry("08:00 AM", "Auto-Cycle Complete", true),
    new LogEntry("07:45 AM", "Pressure stabilized", true),
    new LogEntry("06:30 AM", "Technician access", false),
    new LogEntry("02:15 AM", "Nitrogen refill", true),
    new LogEntry("Yesterday", "System Reboot", true)
  ];

  build() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row() {
            Stack() {
              Circle({ width: 32, height: 32 })
                .fill(CryoColors.surfaceGrey)

              Image(log.isSystem ? $r('sys.media.ohos_ic_public_info') : $r('sys.media.ohos_ic_public_tools'))
                .width(16)
                .height(16)
                .fillColor(CryoColors.textGrey)
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
            }
            .alignItems(Alignment.Start)
            .margin({ left: 12 })

            Spacer()
          }
          .width('100%')
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
    Column() {
      // Shadow line
      Row()
        .width('100%')
        .height(1)
        .backgroundColor(Color.WHITE)
        .shadow({ radius: 2, color: Color.opacity(Color.BLACK, 0.1), offsetY: -2 })

      Row() {
        Column() {
          Text("MANUAL OVERRIDE")
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(CryoColors.textGrey)

          Text(this.isLocked ? "LOCKED" : "ACTIVE")
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? CryoColors.textDark : CryoColors.alertRed)
        }
        .alignItems(Alignment.Start)

        Spacer()

        Toggle({
          type: ToggleType.Switch,
          isOn: !this.isLocked,
          onColor: CryoColors.alertRed
        })
        .onChange((isOn: boolean) => {
          this.isLocked = !isOn;
        })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({ radius: 12, color: Color.opacity(Color.BLACK, 0.1), offsetY: -4 })
    }
  }
}