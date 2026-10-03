@Entry
@Component
struct Index {
  @State isLocked: boolean = true

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Top Bar
        Row() {
          Column() {
            Text('UNIT-04')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
            Text('CryoGen Monitor')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#212121')
              .margin({ top: 2 })
          }
          Blank()
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#212121')
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 12 })
        .alignItems(VerticalAlign.Center)

        // System Status Badge
        Row() {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .fillColor('#4CAF50')
          Text('SYSTEM NOMINAL')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#4CAF50')
            .margin({ left: 8 })
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)
        .alignItems(VerticalAlign.Center)
        .borderRadius(50)
        .border({ width: 1, color: '#A5D6A7' })
        .padding({ left: 12, right: 12, top: 6, bottom: 6 })
        .margin({ top: 16 })

        // Core Temperature
        Column() {
          Text('CORE TEMPERATURE')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#757575')
          
          Row() {
            Text('-184.2')
              .fontSize(64)
              .fontWeight(FontWeight.Normal)
              .fontColor('#212121')
              .letterSpacing(-2)
            
            Text('°C')
              .fontSize(24)
              .fontWeight(FontWeight.Normal)
              .fontColor('#757575')
              .margin({ left: 4, bottom: 12 })
          }
          .alignItems(VerticalAlign.Bottom)
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ top: 32 })

        // Sensor Grid
        Column({ space: 12 }) {
          Row({ space: 12 }) {
            // Pressure Card
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .fillColor('#1976D2')
                Blank()
              }.width('100%')
              
              Text('1.02')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#212121')
                .margin({ top: 12 })
                
              Text('Bar PRESSURE')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#757575')
            }
            .layoutWeight(1)
            .backgroundColor('#F5F5F5')
            .borderRadius(12)
            .padding(16)

            // O2 Level Card
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .fillColor('#D32F2F')
                Blank()
                Circle({ width: 6, height: 6 })
                  .fill('#D32F2F')
              }.width('100%')
              
              Text('19.5')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#212121')
                .margin({ top: 12 })
                
              Text('% O2 LEVEL')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#757575')
            }
            .layoutWeight(1)
            .backgroundColor('#F5F5F5')
            .borderRadius(12)
            .padding(16)
          }.width('100%')

          Row({ space: 12 }) {
            // Power Card
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .fillColor('#1976D2')
                Blank()
              }.width('100%')
              
              Text('Stable')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#212121')
                .margin({ top: 12 })
                
              Text('AC POWER')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#757575')
            }
            .layoutWeight(1)
            .backgroundColor('#F5F5F5')
            .borderRadius(12)
            .padding(16)

            // Liquid N2 Card
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(20)
                  .height(20)
                  .fillColor('#1976D2')
                Blank()
              }.width('100%')
              
              Text('88')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#212121')
                .margin({ top: 12 })
                
              Text('% LIQUID N2')
                .fontSize(10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#757575')
            }
            .layoutWeight(1)
            .backgroundColor('#F5F5F5')
            .borderRadius(12)
            .padding(16)
          }.width('100%')
        }
        .margin({ top: 32 })

        // Maintenance Log Header
        Text('MAINTENANCE LOG')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(1.5)
          .margin({ top: 24 })

        // Activity Log List (Mocked with static items based on screenshot style)
        List({ space: 8 }) {
          ListItem() {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(16)
                  .height(16)
                  .fillColor('#757575')
              }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#F5F5F5')
              
              Column() {
                Text('System check completed')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#212121')
                Text('10 mins ago')
                  .fontSize(11)
                  .fontColor('#757575')
              }
              .margin({ left: 12 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .padding({ top: 4, bottom: 4 })
          }
          ListItem() {
            Divider().color('#E0E0E0')
          }
          ListItem() {
            Row() {
              Stack({ alignContent: Alignment.Center }) {
                Image($r('app.media.startIcon'))
                  .width(16)
                  .height(16)
                  .fillColor('#757575')
              }
              .width(32)
              .height(32)
              .borderRadius(16)
              .backgroundColor('#F5F5F5')
              
              Column() {
                Text('Filter replaced')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#212121')
                Text('2 hours ago')
                  .fontSize(11)
                  .fontColor('#757575')
              }
              .margin({ left: 12 })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .padding({ top: 4, bottom: 4 })
          }
        }
        .width('100%')
        .layoutWeight(1)
        
      }
      .width('100%')
      .height('100%')
      .padding({ left: 24, right: 24 })

      // Bottom Control Bar
      Column() {
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
          Toggle({ type: ToggleType.Switch, isOn: !this.isLocked })
            .onChange((isOn: boolean) => {
              this.isLocked = !isOn
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .padding(24)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: '#1A000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
  }
}