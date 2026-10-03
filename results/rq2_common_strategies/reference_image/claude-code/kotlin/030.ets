@Entry
@Component
struct ClipboardHistoryPage {
  @State sliderValue: number = 24

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ]

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Clipboard History')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212529')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .backgroundColor('#E9ECEF')
          .borderRadius(8)
          .height(40)
          .padding({ left: 16, right: 16 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFF')

      // Clipboard List
      List() {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            this.ClipboardCardBuilder(item)
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F8F9FA')

      // Settings Pane
      Column() {
        Row() {
          Text('History Limit (Hours)')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#212529')

          Text(Math.round(this.sliderValue).toString())
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#212529')
            .layoutWeight(1)
            .textAlign(TextAlign.End)
        }
        .width('100%')

        Slider({
          value: this.sliderValue,
          min: 1,
          max: 72,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor('#007BFF')
          .trackColor('#E9ECEF')
          .selectedColor('#007BFF')
          .width('100%')
          .margin({ top: 8 })
          .onChange((value: number) => {
            this.sliderValue = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#EBF4FF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
  }

  @Builder
  ClipboardCardBuilder(item: ClipboardItem) {
    Column() {
      // Header row: icon, type, timestamp
      Row() {
        Row() {
          Rect()
            .width(48)
            .height(48)
            .fill('#007BFF')
            .borderRadius(8)

          Text(item.type)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007BFF')
            .margin({ left: 8 })
        }
        .layoutWeight(1)

        Text(item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6C757D')
      }
      .width('100%')

      // Content
      Text(item.content)
        .fontSize(16)
        .fontColor('#212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 })
        .width('100%')

      // Progress bar
      Row() {
        // Progress fill
        Rect()
          .height(8)
          .fill('#17A2B8')
          .borderRadius({ topLeft: 4, bottomLeft: 4 })
          .width(item.progress * 100 + '%')

        // Progress track remaining
        if (item.progress < 1.0) {
          Rect()
            .height(8)
            .fill('#E9ECEF')
            .borderRadius({ topRight: 4, bottomRight: 4 })
            .width((1 - item.progress) * 100 + '%')
        }
      }
      .width('100%')
      .margin({ top: 12 })

      // Progress thumb dot
      Row() {
        Circle()
          .width(8)
          .height(8)
          .fill('#17A2B8')
          .margin({ left: item.progress * 100 + '%' })
      }
      .width('100%')
      .margin({ top: -4 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .border({ width: 1, color: '#DEE2E6' })
    .shadow({ radius: 4, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
    .margin({ bottom: 12 })
  }
}

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
