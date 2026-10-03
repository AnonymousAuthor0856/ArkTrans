@Entry
@Component
struct CryoGenMonitorScreen {
  @State isLocked: boolean = true

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Bottom }
    // children: 2
    Stack({ alignContent: Alignment.Bottom }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column({ space: 0 }) {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: { top: 24, bottom: 12, left: 24, right: 24 }, backgroundColor: '#FFFFFF' }
        // children: 3
        Row() {
          // === Column ===
          // props: { space: 0 }
          // modifier: { alignItems: ItemAlign.Start }
          // children: 2
          Column({ space: 0 }) {
            // === Text ===
            // props: { text: 'UNIT-04' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#757575' }
            Text('UNIT-04').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575')
            // === Text ===
            // props: { text: 'CryoGen Monitor' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#212121' }
            Text('CryoGen Monitor').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
          }.alignItems(HorizontalAlign.Start)

          // === Blank ===
          Blank()

          // === Button ===
          // modifier: { width: 24, height: 24, type: ButtonType.Circle, backgroundColor: 'transparent' }
          // children: 1
          Button() {
            // === Image ===
            // modifier: { width: 24, height: 24, src: $r('app.media.startIcon'), objectFit: ImageFit.Contain }
            Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
          }.type(ButtonType.Circle).backgroundColor('transparent')
        }

        // === Scroll ===
        // props: { scrollBar: BarState.Off }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 0 }
          // modifier: { width: '100%', padding: { left: 24, right: 24 } }
          // children: 9
          Column({ space: 0 }) {
            // === Blank ===
            // modifier: { height: 16 }
            Blank().height(16)

            // === Row ===
            // props: { space: 8 }
            // modifier: { padding: { left: 12, right: 12, top: 6, bottom: 6 }, borderColor: '#388E3C', borderWidth: 1, borderRadius: 50, borderStyle: BorderStyle.Solid }
            // children: 2
            Row({ space: 8 }) {
              // === Text ===
              // props: { text: '✓' }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Bold, color: '#388E3C' }
              Text('✓').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#388E3C')
              // === Text ===
              // props: { text: 'SYSTEM NOMINAL' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#388E3C' }
              Text('SYSTEM NOMINAL').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#388E3C')
            }.padding({ left: 12, right: 12, top: 6, bottom: 6 }).borderRadius(50).borderWidth(1).borderColor('#388E3C').borderStyle(BorderStyle.Solid)

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === Column ===
            // props: { space: 0 }
            // modifier: { alignItems: ItemAlign.Start }
            // children: 2
            Column({ space: 0 }) {
              // === Text ===
              // props: { text: 'CORE TEMPERATURE' }
              // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#757575' }
              Text('CORE TEMPERATURE').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#757575')
              // === Row ===
              // props: { space: 4 }
              // modifier: { verticalAlign: VerticalAlign.Top }
              // children: 2
              Row({ space: 4 }) {
                // === Text ===
                // props: { text: '-184.2' }
                // modifier: { fontSize: 64, fontWeight: FontWeight.Lighter, color: '#212121', letterSpacing: -2 }
                Text('-184.2').fontSize(64).fontWeight(FontWeight.Lighter).fontColor('#212121').letterSpacing(-2)
                // === Text ===
                // props: { text: '°C' }
                // modifier: { fontSize: 24, fontWeight: FontWeight.Normal, color: '#757575' }
                Text('°C').fontSize(24).fontWeight(FontWeight.Normal).fontColor('#757575')
              }.alignItems(VerticalAlign.Top)
            }.alignItems(HorizontalAlign.Start)

            // === Blank ===
            // modifier: { height: 32 }
            Blank().height(32)

            // === Column ===
            // props: { space: 12 }
            // modifier: { width: '100%' }
            // children: 2
            Column({ space: 12 }) {
              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%' }
              // children: 2
              Row({ space: 12 }) {
                // === SensorCard ===
                // props: { title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false }
                // modifier: { layoutWeight: 1 }
                SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false }).layoutWeight(1)
                // === SensorCard ===
                // props: { title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true }
                // modifier: { layoutWeight: 1 }
                SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true }).layoutWeight(1)
              }

              // === Row ===
              // props: { space: 12 }
              // modifier: { width: '100%' }
              // children: 2
              Row({ space: 12 }) {
                // === SensorCard ===
                // props: { title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false }
                // modifier: { layoutWeight: 1 }
                SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false }).layoutWeight(1)
                // === SensorCard ===
                // props: { title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false }
                // modifier: { layoutWeight: 1 }
                SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false }).layoutWeight(1)
              }
            }

            // === Blank ===
            // modifier: { height: 24 }
            Blank().height(24)

            // === Text ===
            // props: { text: 'MAINTENANCE LOG' }
            // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#757575', letterSpacing: 1.5 }
            Text('MAINTENANCE LOG').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575').letterSpacing(1.5)

            // === Blank ===
            // modifier: { height: 8 }
            Blank().height(8)

            // === ActivityLogList ===
            ActivityLogList()

            // === Blank ===
            // modifier: { height: 100 }
            Blank().height(100)
          }.padding({ left: 24, right: 24 })
        }.scrollBar(BarState.Off).layoutWeight(1)
      }

      // === BottomControlBar ===
      BottomControlBar({ isLocked: this.isLocked, onToggle: () => { this.isLocked = !this.isLocked } })
    }.width('100%').height('100%')
  }
}

// MARK: - Components

@Component
struct SimpleTopBar {
  build() {
    // === Row ===
    // props: { space: 0 }
    // modifier: { width: '100%', height: 56 }
    // children: 3
    Row() {
      // === Column ===
      // props: { space: 0 }
      // modifier: { alignItems: ItemAlign.Start }
      // children: 2
      Column({ space: 0 }) {
        // === Text ===
        // props: { text: 'UNIT-04' }
        // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#757575' }
        Text('UNIT-04').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575')
        // === Text ===
        // props: { text: 'CryoGen Monitor' }
        // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#212121' }
        Text('CryoGen Monitor').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
      }.alignItems(HorizontalAlign.Start)

      // === Blank ===
      Blank()

      // === Button ===
      // modifier: { width: 24, height: 24, type: ButtonType.Circle, backgroundColor: 'transparent' }
      // children: 1
      Button() {
        // === Image ===
        // modifier: { width: 24, height: 24, src: $r('app.media.startIcon'), objectFit: ImageFit.Contain }
        Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
      }.type(ButtonType.Circle).backgroundColor('transparent')
    }
  }
}

@Component
struct SystemStatusBadge {
  build() {
    // === Row ===
    // props: { space: 8 }
    // modifier: { padding: { left: 12, right: 12, top: 6, bottom: 6 }, borderColor: '#388E3C', borderWidth: 1, borderRadius: 50, borderStyle: BorderStyle.Solid }
    // children: 2
    Row({ space: 8 }) {
      // === Text ===
      // props: { text: '✓' }
      // modifier: { fontSize: 14, fontWeight: FontWeight.Bold, color: '#388E3C' }
      Text('✓').fontSize(14).fontWeight(FontWeight.Bold).fontColor('#388E3C')
      // === Text ===
      // props: { text: 'SYSTEM NOMINAL' }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Bold, color: '#388E3C' }
      Text('SYSTEM NOMINAL').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#388E3C')
    }.padding({ left: 12, right: 12, top: 6, bottom: 6 }).borderRadius(50).borderWidth(1).borderColor('#388E3C').borderStyle(BorderStyle.Solid)
  }
}

@Component
struct MainTemperatureDisplay {
  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { alignItems: ItemAlign.Start }
    // children: 2
    Column({ space: 0 }) {
      // === Text ===
      // props: { text: 'CORE TEMPERATURE' }
      // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, color: '#757575' }
      Text('CORE TEMPERATURE').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#757575')
      // === Row ===
      // props: { space: 4 }
      // modifier: { verticalAlign: VerticalAlign.Top }
      // children: 2
      Row({ space: 4 }) {
        // === Text ===
        // props: { text: '-184.2' }
        // modifier: { fontSize: 64, fontWeight: FontWeight.Lighter, color: '#212121', letterSpacing: -2 }
        Text('-184.2').fontSize(64).fontWeight(FontWeight.Lighter).fontColor('#212121').letterSpacing(-2)
        // === Text ===
        // props: { text: '°C' }
        // modifier: { fontSize: 24, fontWeight: FontWeight.Normal, color: '#757575' }
        Text('°C').fontSize(24).fontWeight(FontWeight.Normal).fontColor('#757575')
      }.alignItems(VerticalAlign.Top)
    }.alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SensorGrid {
  build() {
    // === Column ===
    // props: { space: 12 }
    // modifier: { width: '100%' }
    // children: 2
    Column({ space: 12 }) {
      // === Row ===
      // props: { space: 12 }
      // modifier: { width: '100%' }
      // children: 2
      Row({ space: 12 }) {
        // === SensorCard ===
        // props: { title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false }
        // modifier: { layoutWeight: 1 }
        SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false }).layoutWeight(1)
        // === SensorCard ===
        // props: { title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true }
        // modifier: { layoutWeight: 1 }
        SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true }).layoutWeight(1)
      }

      // === Row ===
      // props: { space: 12 }
      // modifier: { width: '100%' }
      // children: 2
      Row({ space: 12 }) {
        // === SensorCard ===
        // props: { title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false }
        // modifier: { layoutWeight: 1 }
        SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false }).layoutWeight(1)
        // === SensorCard ===
        // props: { title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false }
        // modifier: { layoutWeight: 1 }
        SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false }).layoutWeight(1)
      }
    }
  }
}

@Component
struct SensorCard {
  @Prop title: string
  @Prop value: string
  @Prop unit: string
  @Prop iconName: string
  @Prop isWarning: boolean

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%', padding: 16, backgroundColor: '#F5F5F5', borderRadius: 12 }
    // children: 3
    Column({ space: 0 }) {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 3
      Row() {
        // === Image ===
        // modifier: { width: 20, height: 20, src: $r('app.media.startIcon'), objectFit: ImageFit.Contain }
        Image($r('app.media.startIcon')).width(20).height(20).objectFit(ImageFit.Contain)
        // === Blank ===
        Blank()
        // === Circle ===
        // modifier: { width: 6, height: 6, fill: this.isWarning ? '#D32F2F' : 'transparent' }
        Circle().width(6).height(6).fill(this.isWarning ? '#D32F2F' : 'transparent')
      }

      // === Blank ===
      // modifier: { height: 12 }
      Blank().height(12)

      // === Column ===
      // props: { space: 0 }
      // modifier: { alignItems: ItemAlign.Start }
      // children: 2
      Column({ space: 0 }) {
        // === Text ===
        // props: { text: this.value }
        // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#212121' }
        Text(this.value).fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
        // === Text ===
        // props: { text: `${this.unit} ${this.title}` }
        // modifier: { fontSize: 10, fontWeight: FontWeight.Bold, color: '#757575' }
        Text(`${this.unit} ${this.title}`).fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
      }.alignItems(HorizontalAlign.Start)
    }.padding(16).backgroundColor('#F5F5F5').borderRadius(12)
  }
}

@Component
struct ActivityLogList {
  private logs: LogEntry[] = [
    { time: '08:00 AM', message: 'Auto-Cycle Complete', isSystem: true },
    { time: '07:45 AM', message: 'Pressure stabilized', isSystem: true },
    { time: '06:30 AM', message: 'Technician access', isSystem: false },
    { time: '02:15 AM', message: 'Nitrogen refill', isSystem: true },
    { time: 'Yesterday', message: 'System Reboot', isSystem: true }
  ]

  build() {
    // === Column ===
    // props: { space: 8 }
    // modifier: { width: '100%' }
    // children: 5
    Column({ space: 8 }) {
      ForEach(this.logs, (log: LogEntry) => {
        // === Column ===
        // props: { space: 0 }
        // modifier: { width: '100%' }
        // children: 2
        Column({ space: 0 }) {
          // === Row ===
          // props: { space: 12 }
          // modifier: { width: '100%', padding: { top: 4, bottom: 4 } }
          // children: 3
          Row({ space: 12 }) {
            // === Stack ===
            // props: { alignContent: Alignment.Center }
            // modifier: { width: 32, height: 32 }
            // children: 2
            Stack({ alignContent: Alignment.Center }) {
              // === Circle ===
              // modifier: { width: 32, height: 32, fill: '#F5F5F5' }
              Circle().width(32).height(32).fill('#F5F5F5')
              // === Image ===
              // modifier: { width: 16, height: 16, src: $r('app.media.startIcon'), objectFit: ImageFit.Contain }
              Image($r('app.media.startIcon')).width(16).height(16).objectFit(ImageFit.Contain)
            }

            // === Column ===
            // props: { space: 2 }
            // modifier: { alignItems: ItemAlign.Start }
            // children: 2
            Column({ space: 2 }) {
              // === Text ===
              // props: { text: log.message }
              // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: '#212121' }
              Text(log.message).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#212121')
              // === Text ===
              // props: { text: log.time }
              // modifier: { fontSize: 11, color: '#757575' }
              Text(log.time).fontSize(11).fontColor('#757575')
            }.alignItems(HorizontalAlign.Start)

            // === Blank ===
            Blank()
          }.padding({ top: 4, bottom: 4 })

          // === Divider ===
          // modifier: { width: '100%', color: '#F5F5F5' }
          Divider().color('#F5F5F5')
        }
      })
    }
  }
}

interface LogEntry {
  time: string
  message: string
  isSystem: boolean
}

@Component
struct BottomControlBar {
  @Prop isLocked: boolean
  @ObjectLink onToggle: () => void

  build() {
    // === Column ===
    // props: { space: 0 }
    // modifier: { width: '100%' }
    // children: 2
    Column({ space: 0 }) {
      // === Rectangle ===
      // modifier: { width: '100%', height: 1, fill: '#FFFFFF', shadow: { radius: 2, color: '#1A000000', offsetX: 0, offsetY: -2 } }
      Rect().width('100%').height(1).fill('#FFFFFF').shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: -2 })

      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%', padding: 24, backgroundColor: '#FFFFFF', shadow: { radius: 12, color: '#1A000000', offsetX: 0, offsetY: -4 } }
      // children: 3
      Row() {
        // === Column ===
        // props: { space: 2 }
        // modifier: { alignItems: ItemAlign.Start }
        // children: 2
        Column({ space: 2 }) {
          // === Text ===
          // props: { text: 'MANUAL OVERRIDE' }
          // modifier: { fontSize: 10, fontWeight: FontWeight.Bold, color: '#757575' }
          Text('MANUAL OVERRIDE').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
          // === Text ===
          // props: { text: this.isLocked ? 'LOCKED' : 'ACTIVE' }
          // modifier: { fontSize: 14, fontWeight: FontWeight.Bold, color: this.isLocked ? '#212121' : '#D32F2F' }
          Text(this.isLocked ? 'LOCKED' : 'ACTIVE').fontSize(14).fontWeight(FontWeight.Bold).fontColor(this.isLocked ? '#212121' : '#D32F2F')
        }.alignItems(HorizontalAlign.Start)

        // === Blank ===
        Blank()

        // === Toggle ===
        // props: { type: ToggleType.Switch, isOn: !this.isLocked }
        // modifier: { onChange: () => { this.onToggle() } }
        Toggle({ type: ToggleType.Switch, isOn: !this.isLocked }).onChange(() => { this.onToggle() })
      }.padding(24).backgroundColor('#FFFFFF').shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: -4 })
    }
  }
}