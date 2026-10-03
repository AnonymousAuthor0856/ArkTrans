import { router } from '@kit.ArkUI';

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
  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
    { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
    { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
    { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: 'File', timestamp: 'Yesterday', progress: 1.0 },
  ];

  @State sliderValue: number = 24;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')
          .backgroundColor('#E9ECEF')
          .borderRadius(8)
          .height(36)
          .padding({ left: 16, right: 16 })
          .margin({ right: 12 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Divider
      Divider()
        .color('#DEE2E6')
        .strokeWidth(1)

      // Clipboard List
      List({ space: 12 }) {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor('#F8F9FA')

      // Settings Pane
      SettingsPane({
        sliderValue: this.sliderValue,
        onSliderChange: (val: number) => {
          this.sliderValue = val;
        }
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F9FA')
  }
}

@Component
struct ClipboardCard {
  item: ClipboardItem = { id: 0, content: '', type: '', timestamp: '', progress: 0 };

  build() {
    Column() {
      // Header row
      Row() {
        // Icon box
        Row()
          .width(24)
          .height(24)
          .borderRadius(4)
          .backgroundColor('#007BFF')

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#007BFF')
          .margin({ left: 8 })

        Blank()

        Text(this.item.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6C757D')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      // Content text
      Text(this.item.content)
        .fontSize(16)
        .fontColor('#212529')
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ top: 8 })

      // Progress bar
      Stack({ alignContent: Alignment.Start }) {
        // Track
        Row()
          .width('100%')
          .height(4)
          .borderRadius(4)
          .backgroundColor('#E9ECEF')

        // Active track
        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .borderRadius(4)
          .backgroundColor('#17A2B8')
      }
      .width('100%')
      .height(4)
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
    .border({ width: 1, color: '#E9ECEF' })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

@Component
struct SettingsPane {
  @State sliderValue: number = 24;
  onSliderChange: (val: number) => void = () => {};

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor('#212529')

        Blank()

        Text(Math.round(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#212529')
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .trackColor('#E9ECEF')
        .selectedColor('#007BFF')
        .blockColor('#007BFF')
        .onChange((value: number) => {
          this.sliderValue = value;
          this.onSliderChange(value);
        })
        .margin({ top: 4 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
  }
}