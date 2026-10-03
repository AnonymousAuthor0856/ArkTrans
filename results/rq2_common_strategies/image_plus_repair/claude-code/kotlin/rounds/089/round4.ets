@Entry
@Component
struct CryoGenMonitor {
  @State isLocked: boolean = true

  private readonly PrimaryBlue: string = '#0066CC'
  private readonly AlertRed: string = '#D32F2F'
  private readonly SafeGreen: string = '#388E3C'
  private readonly BackgroundWhite: string = '#FFFFFF'
  private readonly SurfaceGrey: string = '#F5F5F5'
  private readonly TextDark: string = '#212121'
  private readonly TextGrey: string = '#757575'

  build() {
    Column() {
      // Top Bar
      Row() {
        Column() {
          Text('UNIT-04')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.TextGrey)
          Text('CryoGen Monitor')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.TextDark)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Text('⚙')
          .fontSize(24)
          .fontColor(this.TextDark)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 24, bottom: 12, left: 24, right: 24 })

      Scroll() {
        Column() {
          // System Status Badge
          Row() {
            Text('✓')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.SafeGreen)
            Text('SYSTEM NOMINAL')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.SafeGreen)
              .margin({ left: 8 })
          }
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .border({ width: 1, color: this.SafeGreen + '80', radius: 50 })
          .alignItems(VerticalAlign.Center)
          .margin({ top: 16 })

          // Main Temperature Display
          Column() {
            Text('CORE TEMPERATURE')
              .fontSize(12)
              .fontColor(this.TextGrey)
              .fontWeight(FontWeight.Medium)
            Row() {
              Text('-184.2')
                .fontSize(64)
                .fontWeight(FontWeight.Lighter)
                .fontColor(this.TextDark)
                .letterSpacing(-2)
              Text('°C')
                .fontSize(24)
                .fontWeight(FontWeight.Normal)
                .fontColor(this.TextGrey)
                .margin({ bottom: 12, left: 4 })
            }
            .alignItems(VerticalAlign.Bottom)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .margin({ top: 32 })

          // Sensor Grid
          Column() {
            Row() {
              Column() {
                this.SensorCardBuilder('PRESSURE', '1.02', 'Bar', 'ℹ', false)
              }
              .layoutWeight(1)
              Column() {
                this.SensorCardBuilder('O2 LEVEL', '19.5', '%', '⚠', true)
              }
              .layoutWeight(1)
            }
            .width('100%')

            Row() {
              Column() {
                this.SensorCardBuilder('POWER', 'Stable', 'AC', '🔧', false)
              }
              .layoutWeight(1)
              Column() {
                this.SensorCardBuilder('LIQUID N2', '88', '%', '↻', false)
              }
              .layoutWeight(1)
            }
            .width('100%')
            .margin({ top: 12 })
          }
          .width('100%')
          .margin({ top: 32 })

          // Maintenance Log
          Text('MAINTENANCE LOG')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.TextGrey)
            .letterSpacing(1.5)
            .margin({ top: 24 })

          Column() {
            this.LogItemBuilder('08:00 AM', 'Auto-Cycle Complete', true)
            this.LogItemBuilder('07:45 AM', 'Pressure stabilized', true)
            this.LogItemBuilder('06:30 AM', 'Technician access', false)
            this.LogItemBuilder('02:15 AM', 'Nitrogen refill', true)
            this.LogItemBuilder('Yesterday', 'System Reboot', true)
          }
          .width('100%')
          .margin({ top: 8 })
        }
        .width('100%')
        .padding({ left: 24, right: 24, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(this.BackgroundWhite)

      // Bottom Control Bar
      Row() {
        Column() {
          Text('MANUAL OVERRIDE')
            .fontSize(10)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.TextGrey)
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? this.TextDark : this.AlertRed)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)

        Stack() {
          Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
            .selectedColor(this.AlertRed)
            .switchPointColor(this.BackgroundWhite)
            .onChange((isOn: boolean) => {
              this.isLocked = !isOn
            })
          Text(this.isLocked ? '🔒' : '⚠')
            .fontSize(12)
            .fontColor(this.isLocked ? this.TextGrey : this.AlertRed)
            .margin({ left: this.isLocked ? -14 : 14 })
        }
        .width(52)
        .height(28)
      }
      .width('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(this.BackgroundWhite)
      .shadow({
        radius: 12,
        color: '#1A000000',
        offsetY: -2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BackgroundWhite)
  }

  @Builder
  SensorCardBuilder(title: string, value: string, unit: string, icon: string, isWarning: boolean) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? this.AlertRed : this.PrimaryBlue)
        if (isWarning) {
          Circle({ width: 6, height: 6 })
            .fill(this.AlertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Top)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextDark)
        Text(unit + '  ' + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextGrey)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 12 })
    }
    .width('100%')
    .height(120)
    .padding(16)
    .backgroundColor(this.SurfaceGrey)
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  LogIconBuilder(isSystem: boolean) {
    Text(isSystem ? '↻' : '👤')
      .fontSize(16)
      .fontColor(this.TextGrey)
  }

  @Builder
  LogItemBuilder(time: string, message: string, isSystem: boolean) {
    Column() {
      Row() {
        Stack() {
          Circle({ width: 32, height: 32 })
            .fill(this.SurfaceGrey)
          this.LogIconBuilder(isSystem)
        }
        .width(32)
        .height(32)

        Column() {
          Text(message)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.TextDark)
          Text(time)
            .fontSize(11)
            .fontColor(this.TextGrey)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
      }
      .width('100%')
      .padding({ top: 4, bottom: 4 })
      .alignItems(VerticalAlign.Center)

      Divider()
        .strokeWidth(1)
        .color(this.SurfaceGrey)
        .margin({ top: 8 })
    }
    .width('100%')
  }
}
