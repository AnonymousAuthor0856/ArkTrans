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

class ClipboardColors {
  static primary: string = '#007BFF';
  static secondary: string = '#6C757D';
  static tertiary: string = '#17A2B8';
  static background: string = '#F8F9FA';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E9ECEF';
  static outline: string = '#DEE2E6';
  static onPrimary: string = '#FFFFFF';
  static onSurface: string = '#212529';
}

@Entry
@Component
struct Index {
  @State sliderValue: number = 24;

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 20),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 50),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 80),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 90),
    new ClipboardItem(5, 'Shared file: \'Q3_Report.pdf\'', 'File', 'Yesterday', 100)
  ];

  @Builder
  ClipboardCard(item: ClipboardItem) {
    Column() {
      Row() {
        Text('')
          .width(24)
          .height(24)
          .backgroundColor(ClipboardColors.primary)
          .borderRadius(4)
        Text(item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(ClipboardColors.primary)
          .margin({ left: 8 })
        Blank()
        Text(item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ClipboardColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(item.content)
        .fontSize(16)
        .fontColor(ClipboardColors.onSurface)
        .lineHeight(24)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ top: 8 })

      Progress({ value: item.progress, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(ClipboardColors.tertiary)
        .backgroundColor(ClipboardColors.surfaceVariant)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(ClipboardColors.surface)
    .border({ width: 1, color: ClipboardColors.surfaceVariant, radius: 12 })
    .borderRadius(12)
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }

  @Builder
  SettingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ClipboardColors.onSurface)
        Blank()
        Text(Math.floor(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(ClipboardColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
        .width('100%')
        .selectedColor(ClipboardColors.primary)
        .trackColor(ClipboardColors.surfaceVariant)
        .blockColor(ClipboardColors.primary)
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ClipboardColors.surface)
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }

  build() {
    Column() {
      Row() {
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(ClipboardColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(ClipboardColors.onSurface)
          .height(36)
          .backgroundColor(ClipboardColors.surfaceVariant)
          .borderRadius(8)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(ClipboardColors.background)

      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            Column() {
              this.ClipboardCard(item)
            }
            .width('100%')
            .margin({ bottom: 12 })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .layoutWeight(1)

      this.SettingsPane()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ClipboardColors.background)
  }
}
