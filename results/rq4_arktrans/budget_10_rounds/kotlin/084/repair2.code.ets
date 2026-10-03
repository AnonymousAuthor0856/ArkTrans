@Entry
@Component
struct Index {
  @State time: string = '00:45'
  @State target: string = 'Target: 300g'
  @State ratioValue: string = '1:15'
  @State ratioLabel: string = 'Ratio'
  @State beansValue: string = '20g'
  @State beansLabel: string = 'Beans'
  @State tempValue: string = '93°C'
  @State tempLabel: string = 'Temp'
  @State guideTitle: string = 'V60 Guide'
  @State coffeeName: string = 'Ethiopia Yirgacheffe'
  @State stepsTitle: string = 'Brewing Steps'
  @State stepTitle: string = 'Blooming Phase'
  @State stepWater: string = '60g'
  @State stepDesc: string = 'Pour water slowly over the grounds to saturate evenly.'
  @State stepTime: string = '0:30'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Header Row
        Row() {
          Column() {
            Text(this.guideTitle)
              .fontSize(32)
              .fontWeight(FontWeight.Bold)
              .fontStyle(FontStyle.Normal)
              .letterSpacing(-0.5)
              .lineHeight(40)
              .margin({ bottom: 4 })
            
            Text(this.coffeeName)
              .fontSize(16)
              .fontColor('#888888')
              .lineHeight(24)
          }
          
          Blank()
          
          Image($r('app.media.startIcon'))
            .width(32)
            .height(32)
            .objectFit(ImageFit.Contain)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 48, bottom: 24 })
        .alignItems(VerticalAlign.Top)

        // Timer Section
        Column() {
          Text(this.time)
            .fontSize(96)
            .fontWeight(FontWeight.Normal)
            .fontFamily('Monospace')
            .lineHeight(96)
            .margin({ bottom: 8 })
          
          Text(this.target)
            .fontSize(20)
            .fontColor('#888888')
            .lineHeight(28)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ top: 24, bottom: 32 })

        // Stats Row
        Row() {
          // Ratio Stat
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 48, height: 48 }).fill(Color.Transparent).borderWidth(1).borderColor('#E0E0E0')
              Image($r('app.media.startIcon')).width(20).height(20).opacity(0.5)
            }
            .width(48)
            .height(48)
            
            Blank().height(8)
            
            Text(this.ratioValue)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
            
            Text(this.ratioLabel)
              .fontSize(14)
              .fontColor('#888888')
              .textAlign(TextAlign.Center)
          }
          .alignItems(HorizontalAlign.Center)

          // Beans Stat
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 48, height: 48 }).fill(Color.Transparent).borderWidth(1).borderColor('#E0E0E0')
              Image($r('app.media.startIcon')).width(20).height(20).opacity(0.5)
            }
            .width(48)
            .height(48)
            
            Blank().height(8)
            
            Text(this.beansValue)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
            
            Text(this.beansLabel)
              .fontSize(14)
              .fontColor('#888888')
              .textAlign(TextAlign.Center)
          }
          .alignItems(HorizontalAlign.Center)

          // Temp Stat
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 48, height: 48 }).fill(Color.Transparent).borderWidth(1).borderColor('#E0E0E0')
              Image($r('app.media.startIcon')).width(20).height(20).opacity(0.5)
            }
            .width(48)
            .height(48)
            
            Blank().height(8)
            
            Text(this.tempValue)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
            
            Text(this.tempLabel)
              .fontSize(14)
              .fontColor('#888888')
              .textAlign(TextAlign.Center)
          }
          .alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ bottom: 32 })

        Divider().color('#F0F0F0').strokeWidth(1)

        // Brewing Steps
        Column() {
          Text(this.stepsTitle)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .margin({ top: 24, bottom: 16 })

          List({ space: 16 }) {
            ListItem() {
              Row() {
                // Step Indicator
                Column() {
                  Stack({ alignContent: Alignment.Center }) {
                    Circle({ width: 24, height: 24 }).fill('#000000')
                    Image($r('app.media.startIcon')).width(14).height(14).fillColor('#FFFFFF')
                  }
                  .width(24)
                  .height(24)
                  
                  Stack() {
                    Rect().width(1).height(60).fill('#F0F0F0')
                  }.width(1).height(60)
                }
                .alignItems(HorizontalAlign.Center)
                .padding({ end: 16, top: 4 })

                // Card Content
                Column() {
                  Row() {
                    Text(this.stepTitle)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                    
                    Blank()
                    
                    Text(this.stepWater)
                      .fontSize(16)
                      .fontWeight(FontWeight.Bold)
                      .fontFamily('Monospace')
                  }
                  .width('100%')
                  .margin({ bottom: 4 })

                  Text(this.stepDesc)
                    .fontSize(14)
                    .fontColor('#888888')
                    .lineHeight(20)
                    .margin({ bottom: 8 })

                  Text(this.stepTime)
                    .fontSize(12)
                    .fontColor('#888888')
                    .backgroundColor('#F5F5F5')
                    .borderRadius(4)
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                }
                .width('100%')
                .padding(16)
                .backgroundColor('#FFFFFF')
                .borderRadius(12)
                .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
              }
              .width('100%')
              .alignItems(VerticalAlign.Top)
            }
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')

      // Bottom Button
      Button() {
        Row() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor('#FFFFFF')
          
          Blank().width(8)
          
          Text('Start Brewing')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(64)
      .backgroundColor('#000000')
      .borderRadius(16)
      .margin({ left: 24, right: 24, bottom: 24 })
      .position({ x: 0, y: '100%' })
      .translate({ y: -80 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}