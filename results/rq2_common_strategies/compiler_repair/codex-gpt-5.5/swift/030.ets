class ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id
    this.content = content
    this.type = type
    this.timestamp = timestamp
    this.progress = progress
  }
}

@Entry
@Component
struct Index {
  @State sliderValue: number = 24

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ]

  @Builder
  ProgressBar(progress: number) {
    Stack({ alignContent: Alignment.Start }) {
      Rect()
        .width('100%')
        .height(4)
        .radius(4)
        .fill('#E9ECEF')
      Rect()
        .width(`${Math.max(0, Math.min(100, progress * 100))}%`)
        .height(4)
        .radius(4)
        .fill('#17A2B8')
    }
    .width('100%')
    .height(4)
  }

  @Builder
  ClipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        Rect()
          .width(24)
          .height(24)
          .radius(4)
          .fill('#007BFF')

        Text(item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007BFF')
          .margin({ left: 8 })

        Blank()

        Text(item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6C757D')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 8 })

      Text(item.content)
        .fontSize(16)
        .fontColor('#212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: 12 })

      this.ProgressBar(item.progress)
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E9ECEF', radius: 12 })
    .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
  }

  @Builder
  SettingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')

        Blank()

        Text(this.sliderValue.toFixed(0))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212529')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 8 })

      Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
        .blockColor('#007BFF')
        .selectedColor('#007BFF')
        .trackColor('#E9ECEF')
        .onChange((value: number) => {
          this.sliderValue = value
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
  }

  build() {
    Column() {
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .textAlign(TextAlign.Center)

        Blank()

        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .height(36)
          .backgroundColor('#E9ECEF')
          .borderRadius(8)
          .padding({ left: 12, right: 12 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 1, color: '#0D000000', offsetY: 1 })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            Column() {
              this.ClipboardCard(item)
            }
            .margin({ bottom: 12 })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .backgroundColor('#F8F9FA')
      .scrollBar(BarState.Off)

      Column() {
        this.SettingsPane()
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 6, color: '#29000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
  }
}
