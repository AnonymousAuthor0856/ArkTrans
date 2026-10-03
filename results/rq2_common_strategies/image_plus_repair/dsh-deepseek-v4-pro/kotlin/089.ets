@Entry
@Component
struct MainPage {
  @State isLocked: boolean = true;
  private logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true }
  ];

  aboutToAppear(): void {
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 12 }) {
          this.StatusBadge()

          this.TemperatureDisplay()

          this.SensorGrid()

          Column({ space: 8 }) {
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(TextGrey)
              .letterSpacing(1.5)
              .width('100%')

            ForEach(this.logs, (log: LogEntry) => {
              this.LogRow(log)
            }, (log: LogEntry) => log.time + log.message)
          }
        }
        .padding({ left: 24, right: 24, top: 16, bottom: 24 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
      }

      Button({ type: ButtonType.Circle }) {
        Text('⚙')
          .fontSize(22)
          .fontColor(TextDark)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(56)
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  StatusBadge() {
    Row({ space: 8 }) {
      Text('✓')
        .fontSize(16)
        .fontColor(SafeGreen)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(SafeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: SafeGreenTrans })
    .borderRadius(50)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontColor(TextGrey)
        .fontWeight(FontWeight.Medium)

      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TextDark)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Normal)
          .fontColor(TextGrey)
          .padding({ bottom: 12, left: 4 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SensorGrid() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ⓘ', false)
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true)
      }
      .width('100%')

      Row({ space: 12 }) {
        this.SensorCard('POWER', 'Stable', 'AC', '🔧', false)
        this.SensorCard('LIQUID N2', '88', '%', '⟳', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? AlertRed : PrimaryBlue)

        if (isWarning) {
          Text('')
            .width(6)
            .height(6)
            .backgroundColor(AlertRed)
            .borderRadius(3)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
        Text(unit + '  ' + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGrey)
      }
    }
    .padding(16)
    .backgroundColor(SurfaceGrey)
    .borderRadius(12)
    .layoutWeight(1)
  }

  @Builder
  LogRow(log: LogEntry) {
    Column() {
      Row() {
        Text(log.isSystem ? '⟳' : '👤')
          .fontSize(16)
          .fontColor(TextGrey)
          .width(32)
          .height(32)
          .textAlign(TextAlign.Center)
          .backgroundColor(SurfaceGrey)
          .borderRadius(16)

        Column() {
          Text(log.message)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(TextDark)
          Text(log.time)
            .fontSize(11)
            .fontColor(TextGrey)
        }
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding({ top: 4, bottom: 4 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .color(SurfaceGrey)
        .strokeWidth(1)
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
            .fontColor(TextGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? TextDark : AlertRed)
        }
        .alignItems(HorizontalAlign.Start)

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(AlertRed)
          .switchPointColor(this.isLocked ? TextGrey : BackgroundWhite)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .backgroundColor(BackgroundWhite)
  }
}

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}

const PrimaryBlue: string = '#0066CC';
const AlertRed: string = '#D32F2F';
const SafeGreen: string = '#388E3C';
const SafeGreenTrans: string = '#80388E3C';
const BackgroundWhite: string = '#FFFFFF';
const SurfaceGrey: string = '#F5F5F5';
const TextDark: string = '#212121';
const TextGrey: string = '#757575';
