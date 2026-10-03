// CryoGenApp.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true;
  @State logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true },
  ];

  // Theme Colors
  private primaryBlue: string = '#0066CC';
  private alertRed: string = '#D32F2F';
  private safeGreen: string = '#388E3C';
  private backgroundWhite: string = '#FFFFFF';
  private surfaceGrey: string = '#F5F5F5';
  private textDark: string = '#212121';
  private textGrey: string = '#757575';

  @Builder
  SimpleTopBar() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text('⚙')
          .fontSize(24)
          .fontColor(this.textDark)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(16)
        .fontColor(this.safeGreen)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.safeGreen)
        .margin({ left: 8 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({
      width: 1,
      color: '#80388E3C',
      radius: 50
    })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontColor(this.textGrey)
        .fontWeight(FontWeight.Medium)
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(this.textDark)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.textGrey)
          .margin({ left: 4, bottom: 12 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean = false) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? this.alertRed : this.primaryBlue)
        if (isWarning) {
          Circle()
            .width(6)
            .height(6)
            .fill(this.alertRed)
            .margin({ left: 8 })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textGrey)
      }
      .margin({ top: 12 })
    }
    .padding(16)
    .backgroundColor(this.surfaceGrey)
    .borderRadius(12)
    .layoutWeight(1)
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ℹ', false)
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true)
      }
      .width('100%')

      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '🔧', false)
        this.SensorCard('LIQUID N2', '88', '%', '🔄', false)
      }
      .width('100%')
    }
  }

  @Builder
  ActivityLogList() {
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry, index: number) => {
        Column() {
          Row() {
            Circle()
              .width(32)
              .height(32)
              .fill(this.surfaceGrey)
              .align(Alignment.Center)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.textDark)
              Text(log.time)
                .fontSize(11)
                .fontColor(this.textGrey)
            }
            .margin({ left: 12 })
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .alignItems(VerticalAlign.Center)

          Divider()
            .strokeWidth(1)
            .color(this.surfaceGrey)
        }
      }, (log: LogEntry) => log.time + log.message)
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
            .fontColor(this.textGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? this.textDark : this.alertRed)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(this.alertRed)
          .switchPointColor(this.backgroundWhite)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
      }
      .width('100%')
      .padding(24)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .backgroundColor(this.backgroundWhite)
    .shadow({ radius: 12, color: '#20000000', offsetY: -2 })
  }

  build() {
    Column() {
      // Top Bar
      this.SimpleTopBar()

      // Main Content
      Scroll() {
        Column() {
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
            .fontColor(this.textGrey)
            .letterSpacing(1.5)
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank()
            .height(8)

          this.ActivityLogList()
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundWhite)
  }
}

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}