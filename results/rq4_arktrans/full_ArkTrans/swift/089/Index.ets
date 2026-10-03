@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column().width('100%').height('100%').backgroundColor('#FFFFFF')

      // Main Content
      Column() {
        // Header Row
        Row() {
          Column() {
            Text('UNIT-04').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575')
            Text('CryoGen Monitor').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#212121')
          }
          Blank()
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.backgroundColor(Color.Transparent)
        }.width('100%').height(56).padding({ left: 24, right: 24 })

        // Scrollable Area
        Scroll() {
          Column() {
            Blank().height(16)

            // System Status Badge
            Row() {
              Image($r('app.media.startIcon')).width(14).height(14).fillColor('#388E3D')
              Text('SYSTEM NOMINAL').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#388E3D')
            }.width('auto').padding({ left: 12, right: 12, top: 6, bottom: 6 }).borderRadius(50)
              .border({ width: 1, color: '#388E3D', radius: 50, style: BorderStyle.Solid })

            Blank().height(32)

            // Core Temperature
            Column() {
              Text('CORE TEMPERATURE').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#757575')
              Row() {
                Text('-184.2').fontSize(64).fontWeight(FontWeight.Lighter).fontColor('#212121').letterSpacing(-2)
                Text('°C').fontSize(24).fontWeight(FontWeight.Regular).fontColor('#757575')
              }
            }

            Blank().height(32)

            // Sensor Grid
            Column({ space: 12 }) {
              Row({ space: 12 }) {
                this.SensorCard({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false })
                this.SensorCard({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true })
              }
              Row({ space: 12 }) {
                this.SensorCard({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false })
                this.SensorCard({ title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false })
              }
            }

            Blank().height(24)

            // Maintenance Log
            Text('MAINTENANCE LOG').fontSize(12).fontWeight(FontWeight.Bold).fontColor('#757575').letterSpacing(1.5)
            Blank().height(8)

            Column({ space: 8 }) {
              ForEach([
                { message: 'Auto-Cycle Complete', time: '08:00 AM', isSystem: true },
                { message: 'Filter Replacement', time: 'Yesterday', isSystem: false }
              ], (item: LogItem) => {
                Column() {
                  Row({ space: 12 }) {
                    Stack() {
                      Circle().width(32).height(32).fill('#F4F4F4')
                      Image($r('app.media.startIcon')).width(16).height(16).fillColor('#757575')
                    }
                    Column({ space: 2 }) {
                      Text(item.message).fontSize(14).fontWeight(FontWeight.Medium).fontColor('#212121')
                      Text(item.time).fontSize(11).fontColor('#757575')
                    }
                    Blank()
                  }.padding({ top: 4, bottom: 4 })
                }
              })
            }

            Blank().height(100)
          }.padding({ left: 24, right: 24 })
        }.layoutWeight(1)
      }.width('100%').height('100%')

      // Bottom Overlay Panel
      Column() {
        Rect().width('100%').height(1).fill('#FFFFFF')
          .shadow({ radius: 2, color: '#1A000000', offsetY: -2 })
        
        Row({ space: 12 }) {
          Column({ space: 2 }) {
            Text('MANUAL OVERRIDE').fontSize(10).fontWeight(FontWeight.Bold).fontColor('#757575')
            Text(this.isLocked ? 'LOCKED' : 'ACTIVE').fontSize(14).fontWeight(FontWeight.Bold)
              .fontColor(this.isLocked ? '#212121' : '#D32D2D')
          }
          Blank()
          Toggle({ type: ToggleType.Switch })
            .onChange((isOn: boolean) => {
              this.isLocked = !isOn
            })
            .selectedColor('#D32D2D')
        }.width('100%').padding(24).backgroundColor('#FFFFFF')
          .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
      }
    }.width('100%').height('100%')
  }

  @Builder
  SensorCard(props: SensorCardProps) {
    Column({ space: 8 }) {
      Row({ space: 12 }) {
        Stack() {
          if (props.isWarning) {
            Circle().width(8).height(8).fill('#D32D2D')
          } else {
            Image($r('app.media.startIcon')).width(24).height(24).fillColor('#1976D2')
          }
        }
        Column({ space: 4 }) {
          Text(props.value).fontSize(24).fontWeight(FontWeight.Bold).fontColor('#212121')
          Text(`${props.unit} ${props.title}`).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#757575')
        }
      }
    }.width('100%').padding(16).backgroundColor('#F4F4F4').borderRadius(16)
  }
}

interface SensorCardProps {
  title: string;
  value: string;
  unit: string;
  iconName: string;
  isWarning: boolean;
}

interface LogItem {
  message: string;
  time: string;
  isSystem: boolean;
}