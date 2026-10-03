@Entry
@Component
struct CryoGenApp {
  @State isLocked: boolean = true

  build() {
    Column() {
      // === Main Content Area ===
      Scroll() {
        Column({ space: 32 }) {
          // Top Bar
          Row() {
            Column() {
              Text('UNIT-04').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575')
              Text('CryoGen Monitor').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
            }
            Blank()
            Image($r('app.media.startIcon')).width(24).height(24)
          }.width('100%').padding({ left: 24, right: 24, top: 24, bottom: 12 }).height(56)

          // Status Badge
          Row({ space: 8 }) {
            Image($r('app.media.startIcon')).width(16).height(16)
            Text('SYSTEM NOMINAL').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#388E3C')
          }
            .borderRadius(50)
            .border({ width: 1, color: '#388E3C' })
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })

          // Temperature Display
          Column() {
            Text('CORE TEMPERATURE').fontSize(12).fontColor('#757575').fontWeight(FontWeight.Medium)
            Row({ verticalAlignment: VerticalAlign.Bottom }) {
              Text('-184.2').fontSize(64).fontWeight(FontWeight.Lighter).fontColor('#212121')
              Text('°C').fontSize(24).fontColor('#757575').margin({ bottom: 12, left: 4 })
            }
          }

          // Sensor Grid
          Column({ space: 12 }) {
            Row({ space: 12 }) {
              this.SensorCardComponent('PRESSURE', '1.02', 'Bar', false)
              this.SensorCardComponent('O2 LEVEL', '19.5', '%', true)
            }
            Row({ space: 12 }) {
              this.SensorCardComponent('POWER', 'Stable', 'AC', false)
              this.SensorCardComponent('LIQUID N2', '88', '%', false)
            }
          }

          // Maintenance Log Header
          Column() {
            Text('MAINTENANCE LOG').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575')
            Divider().color('#F5F5F5').margin({ top: 8 })
            
            // Log Items
            Column({ space: 8 }) {
              this.LogItem('08:00 AM', 'Auto-Cycle Complete', true)
              this.LogItem('07:45 AM', 'Pressure stabilized', true)
              this.LogItem('06:30 AM', 'Technician access', false)
              this.LogItem('02:15 AM', 'Nitrogen refill', true)
              this.LogItem('Yesterday', 'System Reboot', true)
            }
          }
          
          // Spacer for bottom bar clearance
          Column().height(100)
        }.width('100%').padding({ left: 24, right: 24, top: 16 })
      }.layoutWeight(1)

      // Bottom Control Bar
      Row({ verticalAlignment: VerticalAlign.Center }) {
        Column() {
          Text('MANUAL OVERRIDE').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.isLocked ? '#212121' : '#D32F2F')
        }
        
        Toggle({
          type: ToggleType.Switch,
          isOn: !this.isLocked
        })
        .onChange((isOn: boolean) => {
          this.isLocked = !isOn
        })
        .selectedColor('#D32F2F')
      }
      .width('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: '#1F000000' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  SensorCardComponent(title: string, value: string, unit: string, isWarning: boolean) {
    Column({ space: 12 }) {
      Row({ space: 8 }) {
        Image($r('app.media.startIcon')).width(20).height(20)
        if (isWarning) {
          Circle({ width: 6, height: 6 }).fill('#D32F2F')
        }
      }.width('100%').justifyContent(FlexAlign.SpaceBetween)

      Column() {
        Text(value).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
        Text(`${unit} ${title}`).fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
      }
    }
    .width('50%')
    .height(120)
    .padding(16)
    .backgroundColor('#F5F5F5')
    .borderRadius(12)
  }

  @Builder
  LogItem(time: string, message: string, isSystem: boolean) {
    Row({ space: 12 }) {
      Row({ verticalAlignment: VerticalAlign.Center, horizontalAlignment: HorizontalAlign.Center }) {
        Image($r('app.media.startIcon')).width(16).height(16)
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor('#F5F5F5')

      Column() {
        Text(message).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#212121')
        Text(time).fontSize(11).fontColor('#757575')
      }
    }
    .width('100%')
    .padding({ top: 4, bottom: 4 })
  }
}