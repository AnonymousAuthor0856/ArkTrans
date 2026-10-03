@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true;

  private readonly PrimaryBlue: ResourceColor = '#0066CC';
  private readonly AlertRed: ResourceColor = '#D32F2F';
  private readonly SafeGreen: ResourceColor = '#388E3C';
  private readonly BackgroundWhite: ResourceColor = '#FFFFFF';
  private readonly SurfaceGrey: ResourceColor = '#F5F5F5';
  private readonly TextDark: ResourceColor = '#212121';
  private readonly TextGrey: ResourceColor = '#757575';

  build() {
    Column() {
      // Top Bar
      this.SimpleTopBar()

      // Main Content
      Scroll() {
        Column() {
          // Status Header
          this.SystemStatusBadge()

          // Big Temperature Display
          this.MainTemperatureDisplay()

          // Grid of Sensor Cards
          this.SensorGrid()

          // Activity Log Title
          Text('MAINTENANCE LOG')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.TextGrey)
            .letterSpacing(1.5)
            .margin({ top: 24, bottom: 8 })

          // Activity Log List
          this.ActivityLogList()
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Control Bar
      this.BottomControlBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.BackgroundWhite)
  }

  @Builder
  SimpleTopBar() {
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

      // Settings Icon Button
      Button() {
        Text('⚙')
          .fontSize(22)
          .fontColor(this.TextDark)
      }
      .type(ButtonType.Circle)
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
  SystemStatusBadge() {
    Row() {
      // Check Icon
      Text('✓')
        .fontSize(14)
        .fontColor(this.SafeGreen)
        .fontWeight(FontWeight.Bold)

      Text('SYSTEM NOMINAL')
        .fontColor(this.SafeGreen)
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .margin({ left: 8 })
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .border({ width: 1, color: 'rgba(56, 142, 60, 0.5)', radius: 50 })
    .margin({ top: 16 })
  }

  @Builder
  MainTemperatureDisplay() {
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
          .margin({ left: 4, bottom: 12 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .margin({ top: 32 })
  }

  @Builder
  SensorGrid() {
    Column() {
      Row() {
        this.SensorCard('PRESSURE', '1.02', 'Bar', 'ⓘ', false)
          .layoutWeight(1)
        this.SensorCard('O2 LEVEL', '19.5', '%', '⚠', true)
          .layoutWeight(1)
      }
      .width('100%')

      Row() {
        this.SensorCard('POWER', 'Stable', 'AC', '⚒', false)
          .layoutWeight(1)
        this.SensorCard('LIQUID N2', '88', '%', '⟳', false)
          .layoutWeight(1)
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .margin({ top: 32 })
  }

  @Builder
  SensorCard(title: string, value: string, unit: string, icon: string, isWarning: boolean) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(18)
          .fontColor(isWarning ? this.AlertRed : this.PrimaryBlue)

        if (isWarning) {
          Circle({ width: 6, height: 6 })
            .fill(this.AlertRed)
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column() {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextDark)
        Text(unit + '  ' + title)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.TextGrey)
      }
      .alignItems(HorizontalAlign.Start)
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(this.SurfaceGrey)
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  ActivityLogList() {
    Column() {
      this.LogItem('08:00 AM', 'Auto-Cycle Complete', true)
      this.LogDivider()
      this.LogItem('07:45 AM', 'Pressure stabilized', true)
      this.LogDivider()
      this.LogItem('06:30 AM', 'Technician access', false)
      this.LogDivider()
      this.LogItem('02:15 AM', 'Nitrogen refill', true)
      this.LogDivider()
      this.LogItem('Yesterday', 'System Reboot', true)
    }
    .width('100%')
  }

  @Builder
  LogItem(time: string, message: string, isSystem: boolean) {
    Row() {
      // Icon Circle
      Stack() {
        Circle({ width: 32, height: 32 })
          .fill(this.SurfaceGrey)
        Text(isSystem ? 'ⓘ' : '⚒')
          .fontSize(14)
          .fontColor(this.TextGrey)
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
  }

  @Builder
  LogDivider() {
    Divider()
      .color(this.SurfaceGrey)
      .strokeWidth(1)
      .margin({ left: 44 })
  }

  @Builder
  BottomControlBar() {
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
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      // Switch with thumb content
      Stack() {
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
          .onChange((isOn: boolean) => {
            this.isLocked = !isOn;
          })
          .selectedColor(this.AlertRed)
          .switchPointColor(this.BackgroundWhite)
          .width(52)
          .height(32)
      }
      .width(52)
      .height(32)
    }
    .width('100%')
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(this.BackgroundWhite)
    .shadow({ radius: 12, color: 'rgba(0,0,0,0.08)', offsetY: -2 })
  }
}
