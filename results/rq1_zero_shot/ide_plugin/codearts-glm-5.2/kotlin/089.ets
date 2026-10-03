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

class AppTokens {
  static readonly Colors = {
    primaryBlue: '#FF0066CC',
    alertRed: '#FFD32F2F',
    safeGreen: '#FF388E3C',
    safeGreen50: '#80388E3C',
    backgroundWhite: '#FFFFFFFF',
    surfaceGrey: '#FFF5F5F5',
    textDark: '#FF212121',
    textGrey: '#FF757575',
    transparent: '#00000000'
  }
}

@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true

  private logs: LogEntry[] = [
    new LogEntry('08:00 AM', 'Auto-Cycle Complete', true),
    new LogEntry('07:45 AM', 'Pressure stabilized', true),
    new LogEntry('06:30 AM', 'Technician access', false),
    new LogEntry('02:15 AM', 'Nitrogen refill', true),
    new LogEntry('Yesterday', 'System Reboot', true)
  ]

  build() {
    Column() {
      Row() {
        Column() {
          Text('UNIT-04')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.textGrey)
          Text('CryoGen Monitor')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.textDark)
        }
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(24)
          .fontColor(AppTokens.Colors.textDark)
      }
      .width('100%')
      .height(56)
      .padding({ top: 24, bottom: 12, left: 24, right: 24 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Row() {
          Text('✓')
            .fontSize(16)
            .fontColor(AppTokens.Colors.safeGreen)
          Text('SYSTEM NOMINAL')
            .fontColor(AppTokens.Colors.safeGreen)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 8 })
        }
        .border({ width: 1, color: AppTokens.Colors.safeGreen50, radius: 50 })
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .alignItems(VerticalAlign.Center)

        Column() {
          Text('CORE TEMPERATURE')
            .fontSize(12)
            .fontColor(AppTokens.Colors.textGrey)
            .fontWeight(FontWeight.Medium)
          Row() {
            Text('-184.2')
              .fontSize(64)
              .fontWeight(FontWeight.Light)
              .fontColor(AppTokens.Colors.textDark)
              .letterSpacing(-2)
            Text('°C')
              .fontSize(24)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppTokens.Colors.textGrey)
              .padding({ bottom: 12, left: 4 })
          }
          .alignItems(VerticalAlign.Bottom)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 32 })

        Column() {
          Row() {
            SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', icon: 'ℹ', isWarning: false })
              .layoutWeight(1)
            SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', icon: '⚠', isWarning: true })
              .layoutWeight(1)
              .margin({ left: 12 })
          }
          .width('100%')

          Row() {
            SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', icon: '🔧', isWarning: false })
              .layoutWeight(1)
            SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', icon: '↻', isWarning: false })
              .layoutWeight(1)
              .margin({ left: 12 })
          }
          .width('100%')
          .margin({ top: 12 })
        }
        .margin({ top: 32 })

        Text('MAINTENANCE LOG')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.textGrey)
          .letterSpacing(1.5)
          .margin({ top: 24 })
      }
      .width('100%')
      .padding({ left: 24, right: 24, top: 16 })

      List({ space: 8 }) {
        ForEach(this.logs, (log: LogEntry) => {
          ListItem() {
            Column() {
              Row() {
                Row() {
                  Text(log.isSystem ? 'ℹ' : '🔧')
                    .fontSize(16)
                    .fontColor(AppTokens.Colors.textGrey)
                }
                .width(32)
                .height(32)
                .borderRadius(16)
                .backgroundColor(AppTokens.Colors.surfaceGrey)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Column() {
                  Text(log.message)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.textDark)
                  Text(log.time)
                    .fontSize(11)
                    .fontColor(AppTokens.Colors.textGrey)
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 12 })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .padding({ top: 4, bottom: 4 })

              Divider()
                .color(AppTokens.Colors.surfaceGrey)
                .strokeWidth(1)
            }
          }
        })
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 24, right: 24 })
      .margin({ top: 8 })

      Row() {
        Column() {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.textGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? AppTokens.Colors.textDark : AppTokens.Colors.alertRed)
        }
        .alignItems(HorizontalAlign.Start)

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .selectedColor(AppTokens.Colors.alertRed)
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn
          })
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 12, color: '#1F000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.backgroundWhite)
  }
}

@Component
struct SensorCard {
  @Prop title: string
  @Prop value: string
  @Prop unit: string
  @Prop icon: string
  @Prop isWarning: boolean = false

  build() {
    Column() {
      Row() {
        Text(this.icon)
          .fontSize(20)
          .fontColor(this.isWarning ? AppTokens.Colors.alertRed : AppTokens.Colors.primaryBlue)
        if (this.isWarning) {
          Text('')
            .width(6)
            .height(6)
            .borderRadius(3)
            .backgroundColor(AppTokens.Colors.alertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(this.value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.textDark)
        Text(`${this.unit}  ${this.title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.textGrey)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 12 })
    }
    .padding(16)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surfaceGrey)
  }
}