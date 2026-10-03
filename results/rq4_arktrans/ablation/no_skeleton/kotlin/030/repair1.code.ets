interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

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
    Column() {
      // Top Bar
      Row() {
        Text("Clipboard History")
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button("Clear")
          .backgroundColor('#E9ECEF')
          .fontColor('#212529')
          .borderRadius(8)
          .margin({ right: 16 })
          .height(36)
          .width(80)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .alignItems(VerticalAlign.Center)

      // List
      List({ space: 12 }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            this.ClipboardCard(item)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      // Settings Pane
      this.SettingsPane()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
  }

  @Builder
  ClipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        // Icon Box
        Row()
          .width(24)
          .height(24)
          .backgroundColor('#007BFF')
          .borderRadius(4)

        Text(item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.25)
          .fontColor('#007BFF')
          .margin({ left: 8 })

        Blank()

        Text(item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.25)
          .fontColor('#6C757D')
      }
      .width('100%')

      Text(item.content)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .lineHeight(24)
        .fontColor('#212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 })

      // Progress Bar
      Stack() {
        // Track
        Row()
          .width('100%')
          .height(4)
          .backgroundColor('#E9ECEF')
          .borderRadius(4)

        // Fill
        Row()
          .width(`${item.progress * 100}%`)
          .height(4)
          .backgroundColor('#17A2B8')
          .borderRadius(4)
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E9ECEF' })
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.1)', offsetY: 1 })
  }

  @Builder
  SettingsPane() {
    Column() {
      Row() {
        Text("History Limit (Hours)")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.25)
          .fontColor('#212529')

        Blank()

        Text(`${this.sliderValue}`)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212529')
      }
      .width('100%')

      Slider({ value: this.sliderValue, min: 1, max: 72 })
        .width('100%')
        .blockColor('#007BFF')
        .trackColor('#E9ECEF')
        .selectedColor('#007BFF')
        .showTips(false)
        .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
  }
}