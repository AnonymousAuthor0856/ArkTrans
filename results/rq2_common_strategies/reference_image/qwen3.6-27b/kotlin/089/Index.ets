@Entry
@Component
struct CryoGenMonitor {
  @State isLocked: boolean = true;

  build() {
    Column() {
      // Main Scrollable Content
      Scroll() {
        Column({ space: 24 }) {
          // Top Bar
          this.buildTopBar();

          // Status Badge
          this.buildStatusBadge();

          // Temperature Display
          this.buildTemperatureDisplay();

          // Sensor Grid
          this.buildSensorGrid();

          // Maintenance Log
          this.buildMaintenanceLog();
          
          // Bottom Spacer to prevent content from being hidden behind the fixed bar
          Blank().height(100)
        }
        .padding({ left: 24, right: 24, top: 50, bottom: 24 })
      }
      .layoutWeight(1)
      .backgroundColor(Color.White)

      // Fixed Bottom Control Bar
      this.buildBottomControlBar();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  buildTopBar() {
    Row() {
      Column() {
        Text('UNIT-04')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
        Text('CryoGen Monitor')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
          .margin({ top: 4 })
      }
      
      Blank()

      Button('', { type: ButtonType.Circle })
        .width(48)
        .height(48)
        .backgroundColor(Color.Transparent)
        .stateEffect(false)
        .onClick(() => {})
        .build() {
          Image($r('app.media.ic_settings')) // Placeholder for Settings Icon
            .width(24)
            .height(24)
            .fillColor('#212121')
        }
    }
    .width('100%')
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  buildStatusBadge() {
    Row() {
      // Checkmark Icon (Simulated with text or image)
      Text('✓') 
        .fontSize(16)
        .fontColor('#388E3C')
        .fontWeight(FontWeight.Bold)
      
      Text('SYSTEM NOMINAL')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#388E3C')
        .margin({ left: 8 })
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .borderRadius(50)
    .border({ width: 1, color: '#388E3C', radius: 50 })
    .opacity(0.9)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  @Builder
  buildTemperatureDisplay() {
    Column() {
      Text('CORE TEMPERATURE')
        .fontSize(12)
        .fontColor('#757575')
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.5)
      
      Row() {
        Text('-184.2')
          .fontSize(64)
          .fontWeight(FontWeight.Light)
          .fontColor('#212121')
          .letterSpacing(-2)
        
        Text('°C')
          .fontSize(24)
          .fontColor('#757575')
          .margin({ bottom: 12, left: 4 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
  }

  @Builder
  buildSensorGrid() {
    Column({ space: 12 }) {
      // Row 1
      Row({ space: 12 }) {
        this.buildSensorCard('PRESSURE', '1.02', 'Bar', false, $r('app.media.ic_info'))
        this.buildSensorCard('O2 LEVEL', '19.5', '%', true, $r('app.media.ic_warning'))
      }
      .width('100%')

      // Row 2
      Row({ space: 12 }) {
        this.buildSensorCard('POWER', 'Stable', 'AC', false, $r('app.media.ic_build'))
        this.buildSensorCard('LIQUID N2', '88', '%', false, $r('app.media.ic_refresh'))
      }
      .width('100%')
    }
  }

  @Builder
  buildSensorCard(title: string, value: string, unit: string, isWarning: boolean, iconRes: Resource) {
    Column() {
      Row() {
        Image(iconRes)
          .width(20)
          .height(20)
          .fillColor(isWarning ? '#D32F2F' : '#0066CC')
        
        Blank()

        if (isWarning) {
          Circle({ width: 6, height: 6 })
            .fill('#D32F2F')
        }
      }
      .width('100%')

      Column({ space: 4 }) {
        Text(value)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212121')
        
        Text(`${unit} ${title}`)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
      }
    }
    .width('50%')
    .height(120)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
    .padding(16)
  }

  @Builder
  buildMaintenanceLog() {
    Column() {
      Text('MAINTENANCE LOG')
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#757575')
        .letterSpacing(1.5)
        .margin({ bottom: 12 })

      // List of logs
      ForEach([
        { time: '08:00 AM', msg: 'Auto-Cycle Complete', type: 'sys' },
        { time: '07:45 AM', msg: 'Pressure stabilized', type: 'sys' },
        { time: '06:30 AM', msg: 'Technician access', type: 'usr' },
        { time: '02:15 AM', msg: 'Nitrogen refill', type: 'sys' },
        { time: 'Yesterday', msg: 'System Reboot', type: 'sys' }
      ], (item: any) => {
        Row() {
          // Icon Container
          Row() {
             // Using a generic circle for icon placeholder as specific icons aren't standard in base ArkTS without library
             Circle({ width: 16, height: 16 })
               .fill('#757575')
          }
          .width(32)
          .height(32)
          .backgroundColor('#F5F5F5')
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Column() {
            Text(item.msg)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#212121')
            Text(item.time)
              .fontSize(11)
              .fontColor('#757575')
          }
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .padding({ top: 8, bottom: 8 })
        .borderWidth({ bottom: 1 })
        .borderColor('#F5F5F5')
      })
    }
  }

  @Builder
  buildBottomControlBar() {
    Row() {
      Column() {
        Text('MANUAL OVERRIDE')
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
        Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isLocked ? '#212121' : '#D32F2F')
          .margin({ top: 4 })
      }

      Blank()

      // Custom Switch Implementation
      Row() {
        if (!this.isLocked) {
           // Warning Icon when active
           Image($r('app.media.ic_warning'))
             .width(16)
             .height(16)
             .fillColor(Color.White)
        } else {
           // Lock Icon when locked
           Image($r('app.media.ic_lock'))
             .width(16)
             .height(16)
             .fillColor(Color.White)
        }
      }
      .width(40)
      .height(24)
      .borderRadius(12)
      .backgroundColor(this.isLocked ? '#757575' : '#D32F2F')
      .onClick(() => {
        this.isLocked = !this.isLocked;
      })
      .shadow({ radius: 2, color: '#00000020', offsetY: 2 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(Color.White)
    .shadow({ radius: 12, color: '#00000010', offsetY: -4 })
  }
}