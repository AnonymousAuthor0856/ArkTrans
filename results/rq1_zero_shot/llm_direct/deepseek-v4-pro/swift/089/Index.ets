@Entry
@Component
struct CryoGenMonitorScreen {
  @State isLocked: boolean = true

  // Colors
  private primaryBlue: string = '#0066CC'
  private alertRed: string = '#D32F2F'
  private safeGreen: string = '#388E3C'
  private backgroundWhite: string = '#FFFFFF'
  private surfaceGrey: string = '#F5F5F5'
  private textDark: string = '#212121'
  private textGrey: string = '#757575'

  @Builder
  SimpleTopBar() {
    Row() {
      Column({ space: 0 }) {
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

      Text('⚙')
        .fontSize(24)
        .fontColor(this.textDark)
    }
    .width('100%')
    .height(56)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SystemStatusBadge() {
    Row({ space: 8 }) {
      Text('✓')
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.safeGreen)
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.safeGreen)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: this.safeGreen, radius: 50 })
  }

  @Builder
  MainTemperatureDisplay() {
    Column({ space: 0 }) {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.textGrey)
      Row({ space: 4 }) {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Light)
          .fontColor(this.textDark)
        Text('°C')
          .fontSize(24)
          .fontWeight(FontWeight.Regular)
          .fontColor(this.textGrey)
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean) {
    Column({ space: 0 }) {
      Row() {
        Text(icon)
          .fontSize(20)
          .fontColor(isWarning ? this.alertRed : this.primaryBlue)
        Blank()
        if (isWarning) {
          Circle()
            .fill(this.alertRed)
            .width(6)
            .height(6)
        }
      }
      .width('100%')

      Blank()
        .height(12)

      Column({ space: 0 }) {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textDark)
        Text(`${unit}  ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.textGrey)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .layoutWeight(1)
    .backgroundColor(this.surfaceGrey)
    .borderRadius(12)
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
        this.SensorCard('LIQUID N2', '88', '%', '↻', false)
      }
      .width('100%')
    }
    .width('100%')
  }

  @Builder
  ActivityLogList() {
    Column({ space: 8 }) {
      this.LogRow('08:00 AM', 'Auto-Cycle Complete', true)
      this.LogRow('07:45 AM', 'Pressure stabilized', true)
      this.LogRow('06:30 AM', 'Technician access', false)
      this.LogRow('02:15 AM', 'Nitrogen refill', true)
      this.LogRow('Yesterday', 'System Reboot', true)
    }
    .width('100%')
  }

  @Builder
  LogRow(time: string, message: string, isSystem: boolean) {
    Column({ space: 0 }) {
      Row({ space: 12 }) {
        Stack() {
          Circle()
            .fill(this.surfaceGrey)
            .width(32)
            .height(32)
          Text(isSystem ? 'ⓘ' : '🔧')
            .fontSize(16)
            .fontColor(this.textGrey)
        }
        .width(32)
        .height(32)

        Column({ space: 2 }) {
          Text(message)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.textDark)
          Text(time)
            .fontSize(11)
            .fontColor(this.textGrey)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
      }
      .width('100%')
      .padding({ top: 4, bottom: 4 })

      Divider()
        .color(this.surfaceGrey)
        .strokeWidth(1)
    }
    .width('100%')
  }

  @Builder
  BottomControlBar() {
    Column({ space: 0 }) {
      Divider()
        .color('#E0E0E0')
        .strokeWidth(1)

      Row() {
        Column({ space: 2 }) {
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
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn
          })
      }
      .width('100%')
      .padding(24)
      .backgroundColor(this.backgroundWhite)
    }
    .width('100%')
    .backgroundColor(this.backgroundWhite)
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column({ space: 0 }) {
        // Top Bar
        Column({ space: 0 }) {
          this.SimpleTopBar()
        }
        .width('100%')
        .padding({ top: 24, bottom: 12, left: 24, right: 24 })
        .backgroundColor(this.backgroundWhite)

        // Scrollable Content
        Scroll() {
          Column({ space: 0 }) {
            Blank().height(16)

            this.SystemStatusBadge()

            Blank().height(32)

            this.MainTemperatureDisplay()

            Blank().height(32)

            this.SensorGrid()

            Blank().height(24)

            Text('MAINTENANCE LOG')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.textGrey)
              .letterSpacing(1.5)

            Blank().height(8)

            this.ActivityLogList()

            Blank().height(100)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundWhite)

      // Bottom Bar
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundWhite)
  }
}