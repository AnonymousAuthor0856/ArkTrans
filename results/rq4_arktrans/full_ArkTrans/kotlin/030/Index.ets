@Entry
@Component
struct Index {
  @State syncProgress: number = 0.3
  @State sliderValue: number = 24

  build() {
    Stack({ alignContent: Alignment.Top }) {
      Column() {
        // === Header (Top App Bar) ===
        Row() {
          Text('Clipboard History')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1C1C1E')
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          
          Button('Clear')
            .backgroundColor('#E5E5EA')
            .borderRadius(8)
            .height(36)
            .margin({ right: 16, top: 4 })
            .width(80)
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 8 })
        .alignItems(VerticalAlign.Center)

        // === List Content ===
        List({ space: 12 }) {
          ListItem() { this.buildCard('Link', '5 min ago', 'https://www.example.com/modern-design', 0.3) }
          ListItem() { this.buildCard('Text', '23 min ago', 'Final project review notes have been updated.', 0.5) }
          ListItem() { this.buildCard('Color', '1 hour ago', '#007BFF', 0.75) }
          ListItem() { this.buildCard('Text', '3 hours ago', 'Meeting at 3 PM with the design team.', 0.9) }
          ListItem() { this.buildCard('File', 'Yesterday', 'Project_Assets_v2.zip', 0.2) }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })

        // === Settings Pane ===
        Column() {
          Row() {
            Text('History Limit (Hours)')
              .fontSize(16)
              .fontColor('#1C1C1E')
              .layoutWeight(1)
            
            Text(this.sliderValue.toString())
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#1C1C1E')
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          Slider({
            value: this.sliderValue,
            min: 1,
            max: 72,
            step: 1
          })
            .width('100%')
            .selectedColor('#007AFF')
            .trackColor('#E5E5EA')
            .blockColor('#007AFF')
            .onChange((value: number) => {
              this.sliderValue = value
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 16, bottom: 32 })
        .backgroundColor('#F2F2F7')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F9FA')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildCard(type: string, timestamp: string, content: string, progress: number) {
    Column() {
      Column() {
        Row() {
          // Icon Box
          Stack({ alignContent: Alignment.Center }) {
            Rect().width(24).height(24).fill('#007AFF').borderRadius(4)
          }
          
          Text(type)
            .fontSize(14)
            .fontWeight(FontWeight.Bold)
            .fontColor('#007AFF')
            .margin({ left: 8 })
          
          Blank().layoutWeight(1)
          
          Text(timestamp)
            .fontSize(14)
            .fontColor('#8E8E93')
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)

        Text(content)
          .fontSize(16)
          .fontColor('#1C1C1E')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 8 })
          .width('100%')

        Progress({
          value: progress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(4)
          .color('#17A2B8')
          .backgroundColor('#E9ECEF')
          .margin({ top: 12 })
      }
      .width('100%')
      .padding(12)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
  }
}