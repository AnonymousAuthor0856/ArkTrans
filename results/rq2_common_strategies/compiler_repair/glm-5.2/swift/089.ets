// CryoGenApp.ets

// MARK: - App Colors
class CryoColors {
  static readonly primaryBlue: string = '#0066CC';
  static readonly alertRed: string = '#D32F2F';
  static readonly safeGreen: string = '#388E3C';
  static readonly backgroundWhite: string = '#FFFFFF';
  static readonly surfaceGrey: string = '#F5F5F5';
  static readonly textDark: string = '#212121';
  static readonly textGrey: string = '#757575';
}

// MARK: - Data Models
class LogEntry {
  id: string;
  time: string;
  message: string;
  isSystem: boolean;

  constructor(time: string, message: string, isSystem: boolean) {
    this.id = `${time}-${message}-${Math.random().toString(36).substring(7)}`;
    this.time = time;
    this.message = message;
    this.isSystem = isSystem;
  }
}

// MARK: - Main Entry
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
export struct CryoGenMonitorScreen {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        SimpleTopBar()

        // Content
        Scroll() {
          Column() {
            // Status Badge
            SystemStatusBadge()
              .margin({ top: 16, bottom: 32 })

            // Temperature Display
            MainTemperatureDisplay()
              .margin({ bottom: 32 })

            // Grid
            SensorGrid()
              .margin({ bottom: 24 })

            // Activity Log Header
            Text("MAINTENANCE LOG")
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)
              .margin({ bottom: 8 })

            // Log List
            ActivityLogList()

            // Space for bottom bar
            Blank().height(100)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite)
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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Circle }) {
        Text('⚙')
          .fontSize(24)
          .fontColor(CryoColors.textDark)
      }
      .backgroundColor(Color.Transparent)
      .width(44)
      .height(44)
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .backgroundColor(CryoColors.backgroundWhite)
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
      
      Text("SYSTEM NOMINAL")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({
      width: 1,
      color: CryoColors.safeGreen,
      radius: 50
    })
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
          title: "PRESSURE", 
          value: "1.02", 
          unit: "Bar", 
          iconName: 'ℹ', 
          isWarning: false 
        })
        SensorCard({ 
          title: "O2 LEVEL", 
          value: "19.5", 
          unit: "%", 
          iconName: '⚠', 
          isWarning: true 
        })
      }
      .width('100%')

      Row({ space: 12 }) {
        SensorCard({ 
          title: "POWER", 
          value: "Stable", 
          unit: "AC", 
          iconName: '🔧', 
          isWarning: false 
        })
        SensorCard({ 
          title: "LIQUID N2", 
          value: "88", 
          unit: "%", 
          iconName: '↻', 
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
  private title: string = '';
  private value: string = '';
  private unit: string = '';
  private iconName: string = '';
  private isWarning: boolean = false;

  build() {
    Column() {
      // Header Row
      Row() {
        Text(this.iconName)
          .fontSize(20)
          .fontColor(this.isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)
        
        Blank()

        if (this.isWarning) {
          Circle({ width: 6, height: 6 })
            .fill(CryoColors.alertRed)
        }
      }
      .width('100%')
      .margin({ bottom: 12 })

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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
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
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row() {
            Stack() {
              Circle({ width: 32, height: 32 })
                .fill(CryoColors.surfaceGrey)
              
              Text(log.isSystem ? 'ℹ' : '🔧')
                .fontSize(16)
                .fontColor(CryoColors.textGrey)
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
            .margin({ left: 12 })

            Blank()
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider()
            .color(CryoColors.surfaceGrey)
            .strokeWidth(1)
            .margin({ top: 8 })
        }
      })
    }
    .width('100%')
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true;

  build() {
    Column() {
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
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        // Custom Toggle Implementation
        Row() {
          Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
            .selectedColor(CryoColors.alertRed)
            .onChange((isOn: boolean) => {
              this.isLocked = !isOn;
            })
        }
      }
      .width('100%')
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
      .shadow({ radius: 12, color: 'rgba(0,0,0,0.1)', offsetY: -4 })
    }
    .width('100%')
  }
}