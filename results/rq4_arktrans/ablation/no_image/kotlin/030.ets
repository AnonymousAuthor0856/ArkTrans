@Entry
@Component
struct Index {
  @State item: string = 'Sample Item'
  @State itemType: string = 'Text'
  @State itemTimestamp: string = '2 mins ago'
  @State itemContent: string = 'This is a sample clipboard content that might be long.'
  @State syncProgress: number = 0.3
  @State historyLimitHours: string = '24'
  @State sliderValue: number = 24
  @State fontSize: number = 24
  @State clipboardHistoryTitle: string = 'Clipboard History'
  @State clearButtonText: string = 'Clear'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column({ space: 0 }) {
        List({ space: 12 }) {
          ListItem() {
            Column() {
              Column({ space: 0 }) {
                Row({ space: 8 }) {
                  Stack({ alignContent: Alignment.Center }) {
                    // Box equivalent
                  }.width(24).height(24).backgroundColor('#007BFF').borderRadius(4)
                  
                  Text(this.itemType)
                    .fontColor('#007BFF')
                    .fontWeight(FontWeight.Bold)
                    .fontSize(14)
                  
                  Blank().layoutWeight(1)
                  
                  Text(this.itemTimestamp)
                    .fontColor('#6C757D')
                    .fontSize(14)
                }.alignItems(VerticalAlign.Center)

                Blank().height(8)

                Text(this.itemContent)
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .fontSize(16)

                Blank().height(12)

                Progress({
                  value: this.syncProgress,
                  total: 1,
                  type: ProgressType.Linear
                })
                  .width('100%')
                  .height(4)
                  .color('#17A2B8')
                  .backgroundColor(Color.Gray)
                  .borderRadius(2)
              }.padding(12)
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })

        Column() {
          Column({ space: 0 }) {
            Row({ space: 0 }) {
              Text('History Limit (Hours)')
                .fontColor('#212529')
                .fontSize(14)
              
              Blank().layoutWeight(1)
              
              Text(this.sliderValue.toString())
                .fontColor('#212529')
                .fontWeight(FontWeight.Medium)
                .fontSize(16)
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')

            Slider({
              value: this.sliderValue,
              min: 1,
              max: 72,
              step: 1
            })
            .width('100%')
            .onChange((value: number) => {
              this.sliderValue = value
              this.historyLimitHours = value.toString()
            })
          }
          .padding(16)
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: -2 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ top: 56 }) // Offset for TopAppBar

      // CenterAlignedTopAppBar Equivalent
      Row() {
        Text(this.clipboardHistoryTitle)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        
        Button(this.clearButtonText) {
          Text(this.clearButtonText)
            .fontSize(14)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#E9ECEF')
        .fontColor('#212529')
        .borderRadius(8)
        .padding({ end: 12 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F8F9FA')
      .position({ x: 0, y: 0 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
  }
}