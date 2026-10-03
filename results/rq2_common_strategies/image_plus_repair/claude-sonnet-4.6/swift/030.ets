// Design Tokens
const primaryColor: string = '#007BFF';
const secondaryColor: string = '#6C757D';
const tertiaryColor: string = '#17A2B8';
const backgroundColor: string = '#F8F9FA';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#E9ECEF';
const onBackgroundColor: string = '#212529';
const onSurfaceColor: string = '#212529';

const spacingXs: number = 4;
const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 16;
const spacingXl: number = 24;

const shapeSmall: number = 4;
const shapeMedium: number = 8;
const shapeLarge: number = 12;

class ClipboardItem {
  id: number = 0;
  content: string = '';
  type: string = '';
  timestamp: string = '';
  progress: number = 0;

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id;
    this.content = content;
    this.type = type;
    this.timestamp = timestamp;
    this.progress = progress;
  }
}

const clipboardItems: ClipboardItem[] = [
  new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
  new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
  new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
  new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
  new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0),
]

@Component
struct ClipboardCardComponent {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column({ space: 0 }) {
      Row({ space: spacingSm }) {
        Stack() {
        }
        .width(24)
        .height(24)
        .borderRadius(shapeSmall)
        .backgroundColor(primaryColor)

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(primaryColor)

        Blank()

        Text(this.item.timestamp)
          .fontSize(14)
          .fontColor(secondaryColor)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: spacingSm })

      Text(this.item.content)
        .fontSize(16)
        .fontColor(onSurfaceColor)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: spacingMd })

      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(4)
          .borderRadius(shapeSmall)
          .backgroundColor(surfaceVariantColor)

        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .borderRadius(shapeSmall)
          .backgroundColor(tertiaryColor)
      }
      .width('100%')
      .height(4)
    }
    .padding(spacingMd)
    .width('100%')
    .backgroundColor(surfaceColor)
    .borderRadius(shapeLarge)
    .border({ width: 1, color: surfaceVariantColor, radius: shapeLarge })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SettingsPaneComponent {
  @Link sliderValue: number;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontColor(onSurfaceColor)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(onSurfaceColor)
      }
      .width('100%')
      .margin({ bottom: spacingSm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .selectedColor(primaryColor)
        .trackColor(surfaceVariantColor)
        .blockColor(surfaceColor)
        .width('100%')
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .padding(spacingLg)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;

  build() {
    Column({ space: 0 }) {
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(onBackgroundColor)

        Blank()

        Button('Clear')
          .fontSize(14)
          .fontColor(onSurfaceColor)
          .backgroundColor(surfaceVariantColor)
          .borderRadius(shapeMedium)
          .padding({ top: spacingSm, bottom: spacingSm, left: spacingMd, right: spacingMd })
          .onClick(() => {
            console.log('Clear button tapped');
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: spacingLg, right: spacingMd })
      .backgroundColor(surfaceColor)
      .shadow({ radius: 2, color: '#0D000000', offsetX: 0, offsetY: 1 })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: spacingMd }) {
          ForEach(clipboardItems, (item: ClipboardItem) => {
            ClipboardCardComponent({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .padding({ left: spacingLg, right: spacingLg, top: spacingMd, bottom: spacingMd })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(backgroundColor)
      .scrollBar(BarState.Off)

      Column() {
        SettingsPaneComponent({ sliderValue: $sliderValue })
      }
      .backgroundColor(surfaceColor)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}