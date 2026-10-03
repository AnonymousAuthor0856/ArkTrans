@Entry
@Component
struct CryoGenMonitorScreen {
  @State isLocked: boolean = true;

  private logs: LogEntry[] = [
    { id: '1', time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { id: '2', time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { id: '3', time: '06:30 AM', message: 'Technician access', isSystem: false },
    { id: '4', time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { id: '5', time: 'Yesterday', message: 'System Reboot', isSystem: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        this.SimpleTopBar()

        // Content
        Scroll() {
          Column() {
            // Status Badge
            this.SystemStatusBadge()

            // Temperature Display
            this.MainTemperatureDisplay()

            // Sensor Grid
            this.SensorGrid()

            // Activity Log Header
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)
              .letterSpacing(1.5)
              .margin({ top: 24, bottom: 8 })

            // Log List
            this.ActivityLogList()

            // Space for bottom bar
            Blank()
              .height(100)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 24, right: 24 })
        }
        .width('100%')
        .scrollBar(BarState.Off)
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar Overlay
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(CryoColors.backgroundWhite)
  }

  @Builder
  SimpleTopBar() {
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

      Text('⚙')
        .fontSize(24)
        .fontColor(CryoColors.textDark)
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .backgroundColor(CryoColors.backgroundWhite)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)

      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(CryoColors.safeGreen)
        .margin({ left: 8 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({
      width: 1,
      color: '#80388E3C',
      radius: 50
    })
    .borderRadius(50)
    .margin({ top: 16 })
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(CryoColors.textGrey)

      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(CryoColors.textDark)
          .letterSpacing(-2)

        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor(CryoColors.textGrey)
          .margin({ left: 4 })
      }
      .alignItems(VerticalAlign.Bottom)
      .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 })
  }

  @Builder
  SensorGrid() {
    Column() {
      Row() {
        Column() {
          this.SensorCard('PRESSURE', '1.02', 'Bar', 'i', false)
        }
        .layoutWeight(1)

        Column() {
          this.SensorCard('O2 LEVEL', '19.5', '%', '!', true)
        }
        .layoutWeight(1)
        .margin({ left: 12 })
      }
      .width('100%')

      Row() {
        Column() {
          this.SensorCard('POWER', 'Stable', 'AC', '⚡', false)
        }
        .layoutWeight(1)

        Column() {
          this.SensorCard('LIQUID N2', '88', '%', '↻', false)
        }
        .layoutWeight(1)
        .margin({ left: 12 })
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean) {
    Column() {
      // Header Row
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? CryoColors.alertRed : CryoColors.primaryBlue)

        Blank()

        if (isWarning) {
          Column()
            .width(6)
            .height(6)
            .borderRadius(3)
            .backgroundColor(CryoColors.alertRed)
        }
      }
      .width('100%')

      // Value Column
      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textDark)

        Text(unit + '  ' + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(CryoColors.textGrey)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ActivityLogList() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row() {
            Column() {
              Text(log.isSystem ? 'i' : '⚒')
                .fontSize(16)
                .fontColor(CryoColors.textGrey)
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor(CryoColors.surfaceGrey)
            .justifyContent(FlexAlign.Center)

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

          Divider()
            .color(CryoColors.surfaceGrey)
            .strokeWidth(1)
        }
        .width('100%')
      }, (log: LogEntry) => log.id)
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
          .onChange((value: boolean) => {
            this.isLocked = !value;
          })
          .selectedColor(CryoColors.alertRed)
          .switchPointColor('#FFFFFF')
      }
      .width('100%')
      .padding(24)
      .backgroundColor(CryoColors.backgroundWhite)
    }
    .width('100%')
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -4
    })
  }
}

interface LogEntry {
  id: string;
  time: string;
  message: string;
  isSystem: boolean;
}

class CryoColors {
  static primaryBlue: string = '#0066CC';
  static alertRed: string = '#D32F2F';
  static safeGreen: string = '#388E3C';
  static backgroundWhite: string = '#FFFFFF';
  static surfaceGrey: string = '#F5F5F5';
  static textDark: string = '#212121';
  static textGrey: string = '#757575';
}
