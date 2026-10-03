@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24
  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ]

  build() {
    Column({ space: 0 }) {
      // Top bar
      Row({ space: 0 }) {
        Blank().layoutWeight(1)
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FF212529')
        Blank().layoutWeight(1)
        Button() {
          Text('Clear')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF212529')
            .padding({ top: 8, bottom: 8, left: 12, right: 12 })
        }
        .backgroundColor('#FFE9ECEF')
        .borderRadius(8)
        .margin({ right: 12 })
      }
      .width('100%')
      .height(56)
      .padding({ top: 44 }) // approximate safe area top
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 0.5, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 0.5 })

      // Content list
      List({ space: 12 }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            Column({ space: 0 }) {
              // Header row: type icon + type text + timestamp
              Row({ space: 8 }) {
                // Type icon box
                Text('')
                  .width(24)
                  .height(24)
                  .backgroundColor('#FF007BFF')
                  .borderRadius(4)
                Text(item.type)
                  .fontSize(14)
                  .fontWeight(FontWeight.Bold)
                  .foregroundColor('#FF007BFF')
                Blank().layoutWeight(1)
                Text(item.timestamp)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF6C757D')
              }
              .width('100%')
              .margin({ bottom: 8 })

              // Content text
              Text(item.content)
                .fontSize(16)
                .fontWeight(FontWeight.Regular)
                .foregroundColor('#FF212529')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
                .width('100%')
                .margin({ bottom: 12 })

              // Progress bar
              Progress({ value: item.progress, total: 1, type: ProgressType.Linear })
                .width('100%')
                .height(4)
                .color('#FF17A2B8')
                .backgroundColor('#FFE9ECEF')
                .borderRadius(4)
            }
            .width('100%')
            .padding(12)
            .backgroundColor('#FFFFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#FFE9ECEF' })
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 1 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#FFF8F9FA')

      // Settings pane
      Column({ space: 8 }) {
        Row({ space: 0 }) {
          Text('History Limit (Hours)')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FF212529')
          Blank().layoutWeight(1)
          Text(this.sliderValue.toFixed(0))
            .fontSize(16)
            .fontWeight(FontWeight.Bold) // Changed from Semibold to Bold
            .foregroundColor('#FF212529')
        }
        .width('100%')

        Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
          .width('100%')
          .onChange((value: number) => {
            this.sliderValue = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 6, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8F9FA')
  }
}

interface ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number
}