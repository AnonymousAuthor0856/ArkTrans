@Entry
@Component
struct Index {
  @State isLocked: boolean = false

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === ZStack (Background) ===
      Stack() {
        // CryoColors Background
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor('#FFFFFF')
          .hitTestBehavior(HitTestMode.None)

        // === VStack (Main Content) ===
        Column({ space: 0 }) {
          // === HStack (Header) ===
          Row() {
            // === VStack (Title Group) ===
            Column({ space: 0 }) {
              Text('UNIT-04')
                .fontColor('#757575')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
              
              Text('CryoGen Monitor')
                .fontColor('#212121')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
            }

            Blank()

            // === Button ===
            Button()
              .type(ButtonType.Capsule)
              .backgroundColor('#E0E0E0')
              .width(32)
              .height(32)
          }
          .width('100%')
          .height(56)
          .padding({ left: 24, right: 24 })

          // === ScrollView ===
          Scroll() {
            // === VStack (Scroll Content) ===
            Column({ space: 0 }) {
              Blank().height(16)

              // Status Badge
              Row({ space: 8 }) {
                Image($r('app.media.startIcon')) // Placeholder for checkmark
                  .width(14)
                  .height(14)
                  .fillColor('#388E3D')
                
                Text('SYSTEM NOMINAL')
                  .fontColor('#388E3D')
                  .fontSize(12)
                  .fontWeight(FontWeight.Bold)
              }
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .borderRadius(50)
              .border({ width: 1, color: '#388E3D', radius: 50 })
              .opacity(0.5) // Approximating stroke opacity effect on border

              Blank().height(32)

              // Core Temperature Section
              Column({ space: 0 }) {
                Text('CORE TEMPERATURE')
                  .fontColor('#757575')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                
                Row({ space: 4 }) {
                  Text('-184.2')
                    .letterSpacing(-2)
                    .fontColor('#212121')
                    .fontSize(64)
                    .fontWeight(FontWeight.Lighter)
                  
                  Text('°C')
                    .fontColor('#757575')
                    .fontSize(24)
                    .fontWeight(FontWeight.Regular)
                }
              }

              Blank().height(32)

              // Sensor Cards Grid
              Column({ space: 12 }) {
                Row({ space: 12 }) {
                  this.SensorCardComponent({ title: 'PRESSURE', value: '1.02', unit: 'Bar', iconName: 'info.circle.fill', isWarning: false })
                  this.SensorCardComponent({ title: 'O2 LEVEL', value: '19.5', unit: '%', iconName: 'exclamationmark.triangle.fill', isWarning: true })
                }
                Row({ space: 12 }) {
                  this.SensorCardComponent({ title: 'POWER', value: 'Stable', unit: 'AC', iconName: 'wrench.and.screwdriver.fill', isWarning: false })
                  this.SensorCardComponent({ title: 'LIQUID N2', value: '88', unit: '%', iconName: 'arrow.clockwise', isWarning: false })
                }
              }

              Blank().height(24)

              // Maintenance Log Header
              Text('MAINTENANCE LOG')
                .letterSpacing(1.5)
                .fontColor('#757575')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)

              Blank().height(8)

              // Maintenance Log List
              Column({ space: 8 }) {
                ForEach([
                  { message: 'System Check Complete', time: '10:00 AM', isSystem: true },
                  { message: 'Filter Replacement', time: 'Yesterday', isSystem: false },
                  { message: 'Pressure Calibration', time: '2 Days Ago', isSystem: false }
                ], (item: MaintenanceLogItem) => {
                  Column({ space: 0 }) {
                    Row({ space: 12 }) {
                      Stack() {
                        Circle()
                          .width(32)
                          .height(32)
                          .fill('#F4F4F4')
                        
                        Image($r('app.media.startIcon')) // Placeholder for icon
                          .width(16)
                          .height(16)
                          .fillColor('#757575')
                      }

                      Column({ space: 2 }) {
                        Text(item.message)
                          .fontColor('#212121')
                          .fontSize(14)
                          .fontWeight(FontWeight.Medium)
                        
                        Text(item.time)
                          .fontColor('#757575')
                          .fontSize(11)
                      }

                      Blank()
                    }
                    .padding({ top: 4, bottom: 4 })
                  }
                })
              }

              Blank().height(100)
            }
            .padding({ left: 24, right: 24 })
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)

        // === Bottom Sheet / Manual Override ===
        Column({ space: 0 }) {
          Rect()
            .width('100%')
            .height(1)
            .fill(Color.White)
            .shadow({ radius: 2, color: '#1A000000', offsetY: -2 }) // Black with 0.1 opacity approx
        
          Row({ space: 0 }) {
            Column({ space: 2 }) {
              Text('MANUAL OVERRIDE')
                .fontColor('#757575')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
              
              Text(this.isLocked ? 'LOCKED' : 'ACTIVE')
                .fontColor(this.isLocked ? '#212121' : '#D32D2D')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
            }

            Blank()

            Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
              .onChange((isOn: boolean) => {
                this.isLocked = !isOn
              })
              .selectedColor('#D32D2D')
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#FFFFFF')
          .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
        }
      }
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SensorCardComponent(params: SensorCardParams) {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Image($r('app.media.startIcon')) // Placeholder
          .width(20)
          .height(20)
          .fillColor(params.isWarning ? '#D32D2D' : '#757575')
        
        Text(params.title)
          .fontColor('#757575')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
      }

      Row({ space: 4 }) {
        Text(params.value)
          .fontColor('#212121')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
        
        Text(params.unit)
          .fontColor('#757575')
          .fontSize(14)
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FAFAFA')
    .borderRadius(12)
  }
}

interface SensorCardParams {
  title: string;
  value: string;
  unit: string;
  iconName: string;
  isWarning: boolean;
}

interface MaintenanceLogItem {
  message: string;
  time: string;
  isSystem: boolean;
}