@Entry
@Component
struct Index {
  @State sliderValue: number = 24

  build() {
    Stack() {
      Column() {
        // Header
        Row() {
          Blank()
          Text('Clipboard History')
            .fontColor('#212529')
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
          Blank()
          Button('Clear')
            .backgroundColor('#E9ECEF')
            .fontColor('#212529')
            .borderRadius(8)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .margin({ right: 16 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 2, color: '#0A000000', offsetY: 1 })

        // Scrollable List
        Scroll() {
          Column() {
            // Item 1
            this.ClipboardItemCard(
              'Link',
              'https://www.example.com/modern-design',
              '5 min ago',
              0.3
            )
            // Item 2
            this.ClipboardItemCard(
              'Text',
              'Final project review notes have been updated.',
              '23 min ago',
              0.5
            )
            // Item 3
            this.ClipboardItemCard(
              'Color',
              '#007BFF',
              '1 hour ago',
              0.7
            )
            // Item 4
            this.ClipboardItemCard(
              'Text',
              'Meeting at 3 PM with the design team.',
              '3 hours ago',
              0.85
            )
            // Item 5
            this.ClipboardItemCard(
              'File',
              "Shared file: 'Q3_Report.pdf'",
              'Yesterday',
              0.2
            )
            
            // Bottom padding for scroll
            Column().width('100%').height(100)
          }
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .width('100%')
        }
        .layoutWeight(1)
        .backgroundColor('#F8F9FA')

        // Footer Settings
        Column() {
          Row() {
            Text('History Limit (Hours)')
              .fontColor('#212529')
              .fontSize(16)
            Blank()
            Text(`${this.sliderValue}`)
              .fontColor('#212529')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .margin({ bottom: 12 })

          Slider({
            value: this.sliderValue,
            min: 1,
            max: 72,
            step: 1
          })
          .trackColor('#E9ECEF')
          .selectedColor('#007BFF')
          .blockColor('#FFFFFF')
          .width('100%')
        }
        .width('100%')
        .padding(24)
        .backgroundColor('#FFFFFF')
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%')
  }

  @Builder
  ClipboardItemCard(type: string, content: string, time: string, progress: number) {
    Column() {
      Row() {
        // Icon Box
        Rect()
          .fill('#007BFF')
          .width(24)
          .height(24)
          .borderRadius(4)
        
        Text(type)
          .fontColor('#007BFF')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 8 })
        
        Blank()
        
        Text(time)
          .fontColor('#6C757D')
          .fontSize(14)
      }
      .width('100%')
      .margin({ bottom: 8 })

      Text(content)
        .fontColor('#212529')
        .fontSize(16)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 12 })

      Progress({
        value: progress * 100,
        total: 100,
        type: ProgressType.Linear
      })
      .width('100%')
      .height(4)
      .color('#17A2B8')
      .backgroundColor('#E9ECEF')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 8, color: '#0A000000', offsetY: 2 })
    .margin({ bottom: 16 })
  }
}