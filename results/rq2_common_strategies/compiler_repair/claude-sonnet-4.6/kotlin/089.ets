import { router } from '@kit.ArkUI';

// Theme Colors
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
  @State isLocked: boolean = true;

  private logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true },
  ];

  @Builder
  SimpleTopBar() {
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

      Text('⚙')
        .fontSize(24)
        .fontColor(TextDark)
        .padding(8)
    }
    .width('100%')
    .padding({ top: 24, bottom: 12, left: 24, right: 24 })
    .height(80)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BackgroundWhite)
  }

  @Builder
  SystemStatusBadge() {
    Row() {
      Text('✓')
        .fontSize(14)
        .fontColor(SafeGreen)
        .margin({ right: 8 })
      Text('SYSTEM NOMINAL')
        .fontColor(SafeGreen)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: '#60388E3C', radius: 50 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  MainTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontColor(TextGrey)
        .fontWeight(FontWeight.Medium)
        .margin({ bottom: 4 })
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Lighter)
          .fontColor(TextDark)
          .letterSpacing(-2)
        Text('°C')
          .fontSize(24)
          .fontColor(TextGrey)
          .margin({ bottom: 12, left: 4 })
          .alignSelf(ItemAlign.End)
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
          .fontSize(18)
          .fontColor(isWarning ? AlertRed : PrimaryBlue)
        if (isWarning) {
          Circle({ width: 6, height: 6 })
            .fill(AlertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(12)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextDark)
        Text(`${unit}  ${title}`)
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
        this.SensorCard('LIQUID N2', '88', '%', '↻', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  ActivityLogList() {
    List({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        ListItem() {
          Column() {
            Row() {
              Stack() {
                Circle({ width: 32, height: 32 })
                  .fill(SurfaceGrey)
                Text(log.isSystem ? '↻' : '👤')
                  .fontSize(14)
                  .fontColor(TextGrey)
              }
              .width(32)
              .height(32)
              .margin({ right: 12 })

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
          .width('100%')
        }
      })
    }
    .width('100%')
    .layoutWeight(1)
    .divider({ strokeWidth: 0 })
  }

  @Builder
  BottomControlBar() {
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

      Row() {
        Text(this.isLocked ? '🔒' : '⚠')
          .fontSize(12)
          .fontColor(this.isLocked ? TextGrey : BackgroundWhite)
          .margin({ right: 4 })
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
          .selectedColor(AlertRed)
          .switchPointColor(BackgroundWhite)
          .width(50)
          .height(28)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(BackgroundWhite)
    .shadow({ radius: 12, color: '#20000000', offsetY: -2 })
  }

  build() {
    Column() {
      // Top Bar
      this.SimpleTopBar()

      // Main Content
      Column() {
        Scroll() {
          Column() {
            // Status Badge
            this.SystemStatusBadge()

            Blank().height(32)

            // Temperature Display
            this.MainTemperatureDisplay()

            Blank().height(32)

            // Sensor Grid
            this.SensorGrid()

            Blank().height(24)

            // Log Title
            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(TextGrey)
              .letterSpacing(1.5)

            Blank().height(8)

            // Log List
            Column({ space: 0 }) {
              ForEach(this.logs, (log: LogEntry) => {
                Column() {
                  Row() {
                    Stack() {
                      Circle({ width: 32, height: 32 })
                        .fill(SurfaceGrey)
                      Text(log.isSystem ? '↻' : '👤')
                        .fontSize(14)
                        .fontColor(TextGrey)
                    }
                    .width(32)
                    .height(32)
                    .margin({ right: 12 })

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
                  .padding({ top: 8, bottom: 8 })

                  Divider()
                    .color(SurfaceGrey)
                    .strokeWidth(1)
                }
                .width('100%')
              })
            }
            .width('100%')
            .margin({ bottom: 16 })
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .backgroundColor(BackgroundWhite)

      // Bottom Bar
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }
}