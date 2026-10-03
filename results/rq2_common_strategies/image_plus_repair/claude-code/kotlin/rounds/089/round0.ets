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

        Image($r('sys.media.ohos_ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor(this.TextDark)
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
            Image($r('sys.media.ohos_ic_public_yes'))
              .width(16)
              .height(16)
              .fillColor(this.SafeGreen)
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
              this.SensorCardBuilder(
                'PRESSURE', '1.02', 'Bar',
                $r('sys.media.ohos_ic_public_info'),
                false
              )
              .layoutWeight(1)
              this.SensorCardBuilder(
                'O2 LEVEL', '19.5', '%',
                $r('sys.media.ohos_ic_public_warning'),
                true
              )
              .layoutWeight(1)
            }
            .width('100%')

            Row() {
              this.SensorCardBuilder(
                'POWER', 'Stable', 'AC',
                $r('sys.media.ohos_ic_public_tools'),
                false
              )
              .layoutWeight(1)
              this.SensorCardBuilder(
                'LIQUID N2', '88', '%',
                $r('sys.media.ohos_ic_public_refresh'),
                false
              )
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

        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked }) {
          Image(this.isLocked
            ? $r('sys.media.ohos_ic_public_lock')
            : $r('sys.media.ohos_ic_public_warning'))
            .width(16)
            .height(16)
        }
        .selectedColor(this.AlertRed)
        .switchPointColor(this.BackgroundWhite)
        .color(this.SurfaceGrey)
        .onChange((isOn: boolean) => {
          this.isLocked = !isOn
        })
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
  SensorCardBuilder(title: string, value: string, unit: string, icon: Resource, isWarning: boolean) {
    Column() {
      Row() {
        Image(icon)
          .width(20)
          .height(20)
          .fillColor(isWarning ? this.AlertRed : this.PrimaryBlue)
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
    .padding(16)
    .backgroundColor(this.SurfaceGrey)
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  LogItemBuilder(time: string, message: string, isSystem: boolean) {
    Column() {
      Row() {
        Circle({ width: 32, height: 32 })
          .fill(this.SurfaceGrey)
          .overlay(
            Image(isSystem
              ? $r('sys.media.ohos_ic_public_refresh')
              : $r('sys.media.ohos_ic_public_user_profile'))
              .width(16)
              .height(16)
              .fillColor(this.TextGrey)
          )

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
