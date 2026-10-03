@Entry
@Component
struct Index {
  @State teaName: string = 'Green Tea'
  @State tempValue: string = '80°C'
  @State timeValue: string = '3 min'
  @State amountValue: string = '250ml'

  build() {
    Stack() {
      Column({ space: 0 }) {
        // HeaderSection
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('Tea Master')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.Black)
            
            Text('Perfect brew, every time')
              .fontSize(12)
              .fontColor(Color.Gray)
          }
          
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.Black)
          }
          .backgroundColor(Color.Transparent)
        }
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Blank().height(32)

        // BrewingVisualizer
        Stack({ alignContent: Alignment.Center }) {
          Stack({ alignContent: Alignment.Center }) {
            Column({ space: 0 }) {
              Image($r('app.media.startIcon'))
                .width(48)
                .height(48)
                .fillColor('#8D6E63')
              
              Blank().height(8)
              
              Text(this.teaName)
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width(180)
          .height(180)
          .borderRadius(90)
          .backgroundColor('#F5F5F5')
        }
        .width(220)
        .height(220)

        Blank().height(40)

        // BrewStatsRow
        Row({ space: 0 }) {
          // InfoItem TEMP
          Column({ space: 0 }) {
            Text('TEMP')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor(Color.Gray)
            
            Blank().height(4)
            
            Text(this.tempValue)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Center)

          Divider()
            .vertical(true)
            .strokeWidth(1)
            .height(20)
            .color('#E0E0E0')

          // InfoItem TIME
          Column({ space: 0 }) {
            Text('TIME')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor(Color.Gray)
            
            Blank().height(4)
            
            Text(this.timeValue)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Center)

          Divider()
            .vertical(true)
            .strokeWidth(1)
            .height(20)
            .color('#E0E0E0')

          // InfoItem AMOUNT
          Column({ space: 0 }) {
            Text('AMOUNT')
              .fontSize(11)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
              .fontColor(Color.Gray)
            
            Blank().height(4)
            
            Text(this.amountValue)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(40)

        // TeaSelector
        Column({ space: 0 }) {
          Text('Select Variety')
            .fontSize(14)
            .fontColor(Color.Black)
            .padding({ left: 4, bottom: 12 })

          List({ space: 12 }) {
            ListItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Green Tea')
                    .fontSize(14)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(Color.Black)
                }
                .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(50)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
              .border({ width: 1, color: '#E0E0E0' })
            }
            ListItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Black Tea')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Color.Black)
                }
                .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(50)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
              .border({ width: 1, color: '#E0E0O0' })
            }
            ListItem() {
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Oolong')
                    .fontSize(14)
                    .fontWeight(FontWeight.Normal)
                    .fontColor(Color.Black)
                }
                .padding({ left: 20, right: 20, top: 10, bottom: 10 })
              }
              .backgroundColor('#FFFFFF')
              .borderRadius(50)
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
              .border({ width: 1, color: '#E0E0E0' })
            }
          }
          .width('100%')
          .listDirection(Axis.Horizontal)
          .padding({ left: 4, right: 4 })
        }
        .width('100%')

        Blank().layoutWeight(1)

        // StartBrewButton
        Button() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(20)
              .height(20)
              .fillColor(Color.White)
            
            Blank().width(8)
            
            Text('START TIMER')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
        }
        .width('100%')
        .height(56)
        .backgroundColor(Color.Black)
        .borderRadius(16)
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      .padding(24)
    }
    .width('100%')
    .height('100%')
  }
}