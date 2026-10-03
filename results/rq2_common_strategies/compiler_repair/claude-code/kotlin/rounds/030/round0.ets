@Entry
@Component
struct ClipboardHistoryPage {
  @State sliderValue: number = 24;

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF212529')
        Blank()
        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF212529')
          .backgroundColor('#FFE9ECEF')
          .borderRadius(8)
          .height(36)
      }
      .width('100%')
      .padding({ left: 16, right: 12, top: 12, bottom: 12 })
      .backgroundColor('#FFFFFFFF')

      // Clipboard List
      List() {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .divider({ strokeWidth: 0, color: Color.Transparent })

      // Settings Pane
      Column() {
        Row() {
          Text('History Limit (Hours)')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FF212529')
          Blank()
          Text(this.sliderValue.toFixed(0))
            .fontSize(16)
            .fontWeight(FontWeight.SemiBold)
            .fontColor('#FF212529')
        }
        .width('100%')

        Slider({
          value: this.sliderValue,
          min: 1,
          max: 72,
          step: 1,
          style: SliderStyle.OutSet
        })
          .blockColor('#FF007BFF')
          .selectedColor('#FF007BFF')
          .trackColor('#FFE9ECEF')
          .onChange((value: number) => {
            this.sliderValue = value;
          })
          .width('100%')
          .margin({ top: 8 })
      }
      .width('100%')
      .padding(16)
      .backgroundColor('#FFFFFFFF')
      .shadow({
        radius: 6,
        color: 'rgba(0, 0, 0, 0.1)',
        offsetY: 2
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8F9FA')
  }
}

@Component
struct ClipboardCard {
  @ObjectLink item: ClipboardItem;

  build() {
    Column() {
      Row() {
        // Type indicator box
        Row()
          .width(24)
          .height(24)
          .backgroundColor('#FF007BFF')
          .borderRadius(4)

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FF007BFF')
          .margin({ left: 8 })

        Blank()

        Text(this.item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF6C757D')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.item.content)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor('#FF212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: 8 })

      // Progress bar
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(4)
          .backgroundColor('#FFE9ECEF')
          .borderRadius(4)

        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .backgroundColor('#FF17A2B8')
          .borderRadius(4)
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFFFF')
    .borderRadius(12)
    .border({
      width: 1,
      color: '#FFE9ECEF'
    })
    .shadow({
      radius: 3,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetY: 1
    })
  }
}

class ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id;
    this.content = content;
    this.type = type;
    this.timestamp = timestamp;
    this.progress = progress;
  }
}
