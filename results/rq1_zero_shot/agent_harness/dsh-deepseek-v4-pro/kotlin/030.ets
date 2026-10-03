const Colors = {
  primary: '#007BFF',
  secondary: '#6C757D',
  tertiary: '#17A2B8',
  background: '#F8F9FA',
  surface: '#FFFFFF',
  surfaceVariant: '#E9ECEF',
  outline: '#DEE2E6',
  success: '#28A745',
  warning: '#FFC107',
  error: '#DC3545',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#212529',
  onSurface: '#212529'
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24
};

interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

@Component
struct ClipboardCard {
  @Prop type: string = '';
  @Prop content: string = '';
  @Prop timestamp: string = '';
  @Prop progress: number = 0;

  build() {
    Column() {
      Row({ space: Spacing.sm }) {
        Column()
          .width(24)
          .height(24)
          .borderRadius(4)
          .backgroundColor(Colors.primary)
        Text(this.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(0.25)
          .fontColor(Colors.primary)
        Blank().layoutWeight(1)
        Text(this.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.25)
          .fontColor(Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Blank().height(Spacing.sm)

      Text(this.content)
        .fontSize(16)
        .lineHeight(24)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .fontColor(Colors.onSurface)

      Blank().height(Spacing.md)

      Progress({ value: Math.round(this.progress * 100), total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(Colors.tertiary)
        .backgroundColor(Colors.surfaceVariant)
    }
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(12)
    .border({ width: 1, color: Colors.surfaceVariant })
    .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.10)', offsetY: 1 })
  }
}

@Component
struct SettingsPane {
  @Prop sliderValue: number = 24;
  onSliderChange: (value: number) => void = () => {};

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.25)
          .fontColor(Colors.onSurface)
        Blank().layoutWeight(1)
        Text(Math.floor(this.sliderValue).toString())
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({ value: this.sliderValue, min: 1, max: 72, step: 1, style: SliderStyle.OutSet })
        .width('100%')
        .blockColor(Colors.primary)
        .selectedColor(Colors.primary)
        .trackColor(Colors.surfaceVariant)
        .onChange((value: number) => {
          this.onSliderChange(value);
        })
    }
    .width('100%')
    .padding(Spacing.lg)
    .backgroundColor(Colors.surface)
    .shadow({ radius: 6, color: 'rgba(0, 0, 0, 0.10)', offsetY: 2 })
  }
}

@Entry
@Component
struct Index {
  @State clipboardItems: ClipboardItem[] = [
    { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
    { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
    { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
    { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: 'File', timestamp: 'Yesterday', progress: 1.0 }
  ];
  @State sliderValue: number = 24;

  build() {
    Column() {
      Row() {
        Blank().layoutWeight(1)
        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Blank().layoutWeight(1)
        Button('Clear')
          .backgroundColor(Colors.surfaceVariant)
          .fontColor(Colors.onSurface)
          .fontSize(14)
          .letterSpacing(0.25)
          .borderRadius(8)
          .onClick(() => {})
          .margin({ right: Spacing.md })
      }
      .width('100%')
      .height(64)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.background)

      Scroll() {
        Column({ space: Spacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ type: item.type, content: item.content, timestamp: item.timestamp, progress: item.progress })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      SettingsPane({ sliderValue: this.sliderValue, onSliderChange: (value: number) => { this.sliderValue = value; } })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
