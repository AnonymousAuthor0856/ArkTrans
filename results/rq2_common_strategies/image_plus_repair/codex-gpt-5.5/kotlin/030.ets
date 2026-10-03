interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

@Entry
@Component
struct Index {
  @State private historyLimit: number = 24;

  private readonly items: ClipboardItem[] = [
    {
      id: 1,
      content: 'https://www.example.com/modern-design',
      type: 'Link',
      timestamp: '5 min ago',
      progress: 0.2
    },
    {
      id: 2,
      content: 'Final project review notes have been updated.',
      type: 'Text',
      timestamp: '23 min ago',
      progress: 0.5
    },
    {
      id: 3,
      content: '#007BFF',
      type: 'Color',
      timestamp: '1 hour ago',
      progress: 0.8
    },
    {
      id: 4,
      content: 'Meeting at 3 PM with the design team.',
      type: 'Text',
      timestamp: '3 hours ago',
      progress: 0.9
    },
    {
      id: 5,
      content: "Shared file: 'Q3_Report.pdf'",
      type: 'File',
      timestamp: 'Yesterday',
      progress: 1.0
    }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Row() {
          Text('Clipboard History')
            .fontSize(36)
            .fontWeight(FontWeight.Bold)
            .fontColor('#212529')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Button('Clear', { type: ButtonType.Normal })
            .width(164)
            .height(80)
            .margin({ left: 18 })
            .borderRadius(16)
            .backgroundColor('#E9ECEF')
            .fontColor('#212529')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .onClick(() => {
              this.historyLimit = 24;
            });
        }
        .width('100%')
        .height(128)
        .padding({ left: 32, right: 32 })
        .alignItems(VerticalAlign.Center);

        List({ space: 24 }) {
          ForEach(this.items, (item: ClipboardItem) => {
            ListItem() {
              this.clipboardCard(item);
            }
          }, (item: ClipboardItem) => item.id.toString());
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 32, right: 32, top: 24, bottom: 220 })
        .scrollBar(BarState.Off)
        .divider({ strokeWidth: 0 });
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8F9FA');

      this.settingsPane();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA');
  }

  @Builder
  private clipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        Blank()
          .width(48)
          .height(48)
          .borderRadius(8)
          .backgroundColor('#007BFF');

        Text(item.type)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007BFF')
          .margin({ left: 16 });

        Blank().layoutWeight(1);

        Text(item.timestamp)
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6C757D')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis });
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center);

      Text(item.content)
        .width('100%')
        .margin({ top: 20 })
        .fontSize(32)
        .fontColor('#212529')
        .lineHeight(48)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis });

      this.progressBar(item.progress);
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(24)
    .border({ width: 2, color: '#E9ECEF' })
    .shadow({ radius: 5, color: '#22000000', offsetX: 0, offsetY: 2 });
  }

  @Builder
  private progressBar(progress: number) {
    Row() {
      Row()
        .height(8)
        .layoutWeight(progress)
        .borderRadius(4)
        .backgroundColor('#17A2B8');

      Row()
        .height(8)
        .layoutWeight(Math.max(0.001, 1 - progress))
        .margin({ left: 8 })
        .borderRadius(4)
        .backgroundColor('#E9ECEF');

      Circle({ width: 8, height: 8 })
        .fill('#17A2B8')
        .margin({ left: -12 });
    }
    .width('100%')
    .height(8)
    .margin({ top: 24 })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  private settingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529');

        Blank().layoutWeight(1);

        Text(this.historyLimit.toFixed(0))
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212529');
      }
      .width('100%')
      .height(48)
      .alignItems(VerticalAlign.Center);

      Slider({
        value: this.historyLimit,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(48)
        .margin({ top: 16 })
        .blockColor('#007BFF')
        .trackColor('#E9ECEF')
        .selectedColor('#007BFF')
        .onChange((value: number) => {
          this.historyLimit = value;
        });
    }
    .width('100%')
    .height(200)
    .padding({ left: 32, right: 32, top: 32, bottom: 24 })
    .backgroundColor('#EAF4FF')
    .shadow({ radius: 8, color: '#22000000', offsetX: 0, offsetY: -2 })
    .align(Alignment.Bottom);
  }
}
