@Entry
@Component
struct Index {
  @State timer: string = '00:45'
  @State targetWeight: string = '300g'
  @State ratioValue: string = '1:15'
  @State ratioLabel: string = 'Ratio'
  @State beansValue: string = '20g'
  @State beansLabel: string = 'Beans'
  @State tempValue: string = '93°C'
  @State tempLabel: string = 'Temp'
  @State stepsTitle: string = 'Brewing Steps'
  @State guideTitle: string = 'V60 Guide'
  @State coffeeName: string = 'Ethiopia Yirgacheffe'
  @State startButtonText: string = 'Start Brewing'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // Header Timer Section
        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text(this.timer)
              .fontSize(48)
              .fontWeight(FontWeight.Normal)
              .fontColor(Color.Black)
            Text('Target: ' + this.targetWeight)
              .fontSize(14)
              .fontColor(Color.Gray)
          }.alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .padding({ top: 24, bottom: 24 })

        // Stats Row
        Row() {
          // Stat Item 1: Ratio
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor(Color.Gray)
            }
            .width(48)
            .height(48)
            .border({ width: 1, color: Color.Gray })
            .borderRadius(24)

            Blank().height(8)

            Text(this.ratioValue)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
            Text(this.ratioLabel)
              .fontSize(12)
              .fontColor(Color.Gray)
          }.alignItems(HorizontalAlign.Center)

          // Stat Item 2: Beans
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor(Color.Gray)
            }
            .width(48)
            .height(48)
            .border({ width: 1, color: Color.Gray })
            .borderRadius(24)

            Blank().height(8)

            Text(this.beansValue)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
            Text(this.beansLabel)
              .fontSize(12)
              .fontColor(Color.Gray)
          }.alignItems(HorizontalAlign.Center)

          // Stat Item 3: Temp
          Column() {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
                .fillColor(Color.Gray)
            }
            .width(48)
            .height(48)
            .border({ width: 1, color: Color.Gray })
            .borderRadius(24)

            Blank().height(8)

            Text(this.tempValue)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Black)
            Text(this.tempLabel)
              .fontSize(12)
              .fontColor(Color.Gray)
          }.alignItems(HorizontalAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .padding({ bottom: 32 })

        Divider().color('#F0F0F0')
        Blank().height(24)

        Text(this.stepsTitle)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .padding({ bottom: 16 })

        List({ space: 16 }) {
          ListItem() {
            // Step Card
            Row() {
              // Left Indicator
              Column() {
                Stack({ alignContent: Alignment.Center }) {
                  Text('1')
                    .fontSize(12)
                    .fontColor(Color.White)
                }
                .width(24)
                .height(24)
                .backgroundColor(Color.Gray) // Placeholder for conditional logic
                .borderRadius(12)

                Stack()
                  .width(1)
                  .height(60)
                  .backgroundColor('#F0F0F0')
              }
              .alignItems(HorizontalAlign.Center)
              .padding({ end: 16, top: 4 })

              // Content Card
              Column() {
                Column() {
                  Row() {
                    Text('Step Title')
                      .fontWeight(FontWeight.Bold)
                      .layoutWeight(1)
                    Text('300g')
                      .fontWeight(FontWeight.Bold)
                      .fontFamily('monospace')
                  }.width('100%')

                  Blank().height(4)

                  Text('Description of the step goes here.')
                    .fontColor(Color.Gray)

                  Blank().height(8)

                  Stack({ alignContent: Alignment.Start }) {
                    Text('00:45')
                      .fontSize(12)
                      .fontColor(Color.Gray)
                  }
                  .backgroundColor('#F5F5F5')
                  .borderRadius(4)
                  .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                }
                .padding(16)
              }
              .width('100%')
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            }
            .alignItems(VerticalAlign.Top)
            .width('100%')
          }

          ListItem() {
            Column() {
              Blank().height(80)
            }
          }
        }
        .width('100%')
        .layoutWeight(1)
      }
      .padding({ left: 24, right: 24 })
      .width('100%')
      .height('100%')

      // "V60 Guide" Row
      Row() {
        Column() {
          Text(this.guideTitle)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(-0.5)
            .fontColor(Color.Black)
          Text(this.coffeeName)
            .fontSize(14)
            .fontColor(Color.Gray)
        }
        
        Button() {
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .fillColor(Color.Black)
        }
        .type(ButtonType.Circle)
        .backgroundColor(Color.Transparent)
      }
      .alignItems(VerticalAlign.Center)
      .width('100%')
      .padding({ left: 24, right: 24, top: 48, bottom: 48 })
      .position({ x: 0, y: 0 }) 

      // "Start Brewing" Button Box
      Stack({ alignContent: Alignment.Center }) {
        Button() {
          Row() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor(Color.White)
            
            Blank().width(8)
            
            Text(this.startButtonText)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
          }
        }
        .height(64)
        .width('100%')
        .backgroundColor(Color.Black)
        .borderRadius(16)
      }
      .width('100%')
      .padding(24)
      .alignContent(Alignment.Bottom) // Align to bottom of stack
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}