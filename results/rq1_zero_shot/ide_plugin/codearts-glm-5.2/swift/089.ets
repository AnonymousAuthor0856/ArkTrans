class CryoColors {
  static readonly primaryBlue: string = '#FF0066CC'
  static readonly alertRed: string = '#FFD32F2F'
  static readonly safeGreen: string = '#FF388E3C'
  static readonly white: string = '#FFFFFFFF'
  static readonly surfaceGrey: string = '#FFF5F5F5'
  static readonly textDark: string = '#FF212121'
  static readonly textGrey: string = '#FF757575'
  static readonly safeGreen50: string = '#80388E3C'
}

class LogEntry {
  time: string
  message: string
  isSystem: boolean

  constructor(time: string, message: string, isSystem: boolean) {
    this.time = time
    this.message = message
    this.isSystem = isSystem
  }
}

@Entry
@Component
struct Index {
  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true),
  ]

  build() {
    Stack() {
      Column() {
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
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text('⚙')
            .fontSize(24)
            .fontColor(CryoColors.textDark)
        }
        .height(56)
        .padding({ left: 24, right: 24, top: 24, bottom: 12 })
        .backgroundColor(CryoColors.white)

        Scroll() {
          Column() {
            Blank().height(16)

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
            .border({ width: 1, color: CryoColors.safeGreen50, radius: 50 })

            Blank().height(32)

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

                Text('°C')
                  .fontSize(24)
                  .fontColor(CryoColors.textGrey)
                  .margin({ left: 4 })
              }
              .alignItems(VerticalAlign.Bottom)
            }
            .alignItems(HorizontalAlign.Start)

            Blank().height(32)

            Column() {
              Row() {
                SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'ⓘ', isWarning: false })
                SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: '⚠', isWarning: true })
              }
              Row() {
                SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: '🔧', isWarning: false })
                SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', iconName: '↻', isWarning: false })
              }
            }

            Blank().height(24)

            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(CryoColors.textGrey)

            Blank().height(8)

            ForEach(this.logs, (log: LogEntry) => {
              Column() {
                Row() {
                  Stack() {
                    Circle({ width: 32, height: 32 })
                      .fill(CryoColors.surfaceGrey)
                    Text(log.isSystem ? 'ⓘ' : '🔧')
                      .fontSize(16)
                      .fontColor(CryoColors.textGrey)
                  }

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
                  .layoutWeight(1)

                  Blank()
                }
                .padding({ top: 4, bottom: 4 })

                Column() { Blank() }
                  .width('100%')
                  .height(1)
                  .backgroundColor(CryoColors.surfaceGrey)
              }
            })

            Blank().height(100)
          }
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      BottomControlBar()
    }
    .backgroundColor(CryoColors.white)
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)
  }
}

@Component
struct SensorCard {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop unit: string = ''
  @Prop iconName: string = ''
  @Prop isWarning: boolean = false

  build() {
    Column() {
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

      Blank().height(12)

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
      .alignItems(HorizontalAlign.Start)
    }
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(CryoColors.surfaceGrey)
    .borderRadius(12)
    .alignItems(HorizontalAlign.Start)
    .margin({ right: 12, bottom: 12 })
  }
}

@Component
struct BottomControlBar {
  @State isLocked: boolean = true

  build() {
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
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
        .selectedColor(CryoColors.alertRed)
        .onChange((isOn: boolean) => {
          this.isLocked = !isOn
        })
    }
    .padding(24)
    .backgroundColor(CryoColors.white)
    .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
    .width('100%')
  }
}