import { router } from '@kit.ArkUI';

// --- Theme Colors ---
const PrimaryBlue = '#0066CC';
const AlertRed = '#D32F2F';
const SafeGreen = '#388E3C';
const BackgroundWhite = '#FFFFFF';
const SurfaceGrey = '#F5F5F5';
const TextDark = '#212121';
const TextGrey = '#757575';

interface LogEntry {
  time: string;
  message: string;
  isSystem: boolean;
}

@Entry
@Component
struct CryoGenApp {
  build() {
    Column() {
      SimpleTopBar()
      Scroll() {
        Column() {
          MainContent()
        }
        .width('100%')
      }
      .layoutWeight(1)
      BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
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
          .fontColor(TextGrey)
        Text('CryoGen Monitor')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
      }
      .alignItems(HorizontalAlign.Start)

      Button({ type: ButtonType.Circle }) {
        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(TextDark)
      }
      .width(40)
      .height(40)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BackgroundWhite)
  }
}

@Component
struct SystemStatusBadge {
  build() {
    Row() {
      Image($r('app.media.ic_check'))
        .width(16)
        .height(16)
        .fillColor(SafeGreen)
      Blank().width(8)
      Text('SYSTEM NOMINAL')
        .fontColor(SafeGreen)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
    }
    .alignItems(VerticalAlign.Center)
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: '#60388E3C', radius: 50 })
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
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
          .alignSelf(ItemAlign.End)
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
          iconRes: $r('app.media.ic_info'),
          isWarning: false
        })
        SensorCard({
          title: 'O2 LEVEL',
          value: '19.5',
          unit: '%',
          iconRes: $r('app.media.ic_warning'),
          isWarning: true
        })
      }
      .width('100%')

      Row({ space: 12 }) {
        SensorCard({
          title: 'POWER',
          value: 'Stable',
          unit: 'AC',
          iconRes: $r('app.media.ic_build'),
          isWarning: false
        })
        SensorCard({
          title: 'LIQUID N2',
          value: '88',
          unit: '%',
          iconRes: $r('app.media.ic_refresh'),
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
  iconRes: Resource = $r('app.media.ic_info');
  isWarning: boolean = false;

  build() {
    Column() {
      Row() {
        Image(this.iconRes)
          .width(20)
          .height(20)
          .fillColor(this.isWarning ? AlertRed : PrimaryBlue)
        if (this.isWarning) {
          Circle({ width: 6, height: 6 })
            .fill(AlertRed)
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
          .fontColor(TextDark)
        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextGrey)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .backgroundColor(SurfaceGrey)
    .borderRadius(12)
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ActivityLogList {
  private logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true },
  ];

  build() {
    Column() {
      ForEach(this.logs, (log: LogEntry) => {
        Column() {
          Row() {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 32, height: 32 })
                .fill(SurfaceGrey)
              Image(log.isSystem ? $r('app.media.ic_refresh') : $r('app.media.ic_person'))
                .width(16)
                .height(16)
                .fillColor(TextGrey)
            }
            .width(32)
            .height(32)

            Blank().width(12)

            Column() {
              Text(log.message)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(TextDark)
              Text(log.time)
                .fontSize(11)
                .fontColor(TextGrey)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .padding({ top: 4, bottom: 4 })

          Divider()
            .color(SurfaceGrey)
            .strokeWidth(1)
        }
      })
    }
    .width('100%')
  }
}

@Component
struct MainContent {
  build() {
    Column() {
      Blank().height(16)
      SystemStatusBadge()
      Blank().height(32)
      MainTemperatureDisplay()
      Blank().height(32)
      SensorGrid()
      Blank().height(24)
      Text('MAINTENANCE LOG')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(TextGrey)
        .letterSpacing(1.5)
      Blank().height(8)
      ActivityLogList()
      Blank().height(16)
    }
    .width('100%')
    .padding({ left: 24, right: 24 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true;

  build() {
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
        .onChange((isOn: boolean) => {
          this.isLocked = !isOn;
        })
        .selectedColor(AlertRed)
        .switchPointColor(BackgroundWhite)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BackgroundWhite)
    .shadow({ radius: 12, color: '#1A000000', offsetY: -2 })
  }
}