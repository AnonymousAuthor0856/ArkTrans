import { curves } from '@kit.ArkUI';

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

  build() {
    Column() {
      // Top Bar
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
          Text('⚙')
            .fontSize(20)
            .fontColor(TextDark)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
      }
      .width('100%')
      .padding({ top: 24, bottom: 12, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Status Badge
          Row() {
            Text('✓')
              .fontSize(14)
              .fontColor(SafeGreen)
              .margin({ right: 8 })
            Text('SYSTEM NOMINAL')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(SafeGreen)
          }
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .border({ width: 1, color: '#60388E3C', radius: 50 })
          .alignItems(VerticalAlign.Center)
          .alignSelf(ItemAlign.Start)
          .margin({ left: 24 })

          // Spacer
          Blank().height(32)

          // Main Temperature Display
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
                .fontColor(TextGrey)
                .margin({ bottom: 12, left: 4 })
            }
            .alignItems(VerticalAlign.Bottom)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding({ left: 24, right: 24 })

          // Spacer
          Blank().height(32)

          // Sensor Grid
          Column({ space: 12 }) {
            Row({ space: 12 }) {
              // Pressure Card
              Column() {
                Row() {
                  Text('ℹ')
                    .fontSize(18)
                    .fontColor(PrimaryBlue)
                  Blank()
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)

                Blank().height(12)

                Column() {
                  Text('1.02')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(TextDark)
                  Text('Bar  PRESSURE')
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

              // O2 Level Card (Warning)
              Column() {
                Row() {
                  Text('⚠')
                    .fontSize(18)
                    .fontColor(AlertRed)
                  Circle()
                    .width(6)
                    .height(6)
                    .fill(AlertRed)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .alignItems(VerticalAlign.Center)

                Blank().height(12)

                Column() {
                  Text('19.5')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(TextDark)
                  Text('%  O2 LEVEL')
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
            .width('100%')

            Row({ space: 12 }) {
              // Power Card
              Column() {
                Row() {
                  Text('🔧')
                    .fontSize(18)
                    .fontColor(PrimaryBlue)
                  Blank()
                }
                .width('100%')

                Blank().height(12)

                Column() {
                  Text('Stable')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(TextDark)
                  Text('AC  POWER')
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

              // Liquid N2 Card
              Column() {
                Row() {
                  Text('↻')
                    .fontSize(20)
                    .fontColor(PrimaryBlue)
                  Blank()
                }
                .width('100%')

                Blank().height(12)

                Column() {
                  Text('88')
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(TextDark)
                  Text('%  LIQUID N2')
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
            .width('100%')
          }
          .padding({ left: 24, right: 24 })
          .width('100%')

          // Spacer
          Blank().height(24)

          // Maintenance Log Title
          Text('MAINTENANCE LOG')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(TextGrey)
            .letterSpacing(1.5)
            .padding({ left: 24 })
            .alignSelf(ItemAlign.Start)

          Blank().height(8)

          // Activity Log List
          Column() {
            ForEach(this.logs, (log: LogEntry) => {
              Column() {
                Row() {
                  Stack() {
                    Circle()
                      .width(32)
                      .height(32)
                      .fill(SurfaceGrey)
                    Text(log.isSystem ? '↻' : '👤')
                      .fontSize(14)
                      .fontColor(TextGrey)
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
          .padding({ left: 24, right: 24 })
          .width('100%')

          Blank().height(100)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Control Bar
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
          .switchPointColor(this.isLocked ? TextGrey : BackgroundWhite)
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(BackgroundWhite)
      .shadow({ radius: 12, color: '#20000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }
}