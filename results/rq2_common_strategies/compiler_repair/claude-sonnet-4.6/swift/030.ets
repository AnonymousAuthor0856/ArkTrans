// Design Tokens
class ColorsClass {
  primary: string = '#FF007BFF';
  secondary: string = '#FF6C757D';
  tertiary: string = '#FF17A2B8';
  background: string = '#FFF8F9FA';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE9ECEF';
  outline: string = '#FFDEE2E6';
  success: string = '#FF28A745';
  warning: string = '#FFFFC107';
  error: string = '#FFDC3545';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FFFFFFFF';
  onBackground: string = '#FF212529';
  onSurface: string = '#FF212529';
}

class SpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
}

class ShapesClass {
  small: number = 4;
  medium: number = 8;
  large: number = 12;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

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
struct CustomProgressBar {
  @Prop progress: number = 0;
  tintColor: string = Colors.tertiary;
  trackColor: string = Colors.surfaceVariant;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(4)
        .borderRadius(Shapes.small)
        .backgroundColor(this.trackColor)

      Row()
        .width(`${this.progress * 100}%`)
        .height(4)
        .borderRadius(Shapes.small)
        .backgroundColor(this.tintColor)
    }
    .width('100%')
    .height(4)
  }
}

@Component
struct ClipboardCard {
  @Prop item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column({ space: 0 }) {
      Row({ space: Spacing.sm }) {
        Row()
          .width(24)
          .height(24)
          .borderRadius(Shapes.small)
          .backgroundColor(Colors.primary)

        Text(this.item.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)

        Blank()

        Text(this.item.timestamp)
          .fontSize(14)
          .fontColor(Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: Spacing.sm })

      Text(this.item.content)
        .fontSize(16)
        .fontColor(Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: Spacing.md })

      CustomProgressBar({
        progress: this.item.progress,
        tintColor: Colors.tertiary,
        trackColor: Colors.surfaceVariant
      })
    }
    .padding(Spacing.md)
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .border({ width: 1, color: Colors.surfaceVariant, radius: Shapes.large })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(14)
          .fontColor(Colors.onSurface)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .margin({ bottom: Spacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .selectedColor(Colors.primary)
        .trackColor(Colors.surfaceVariant)
        .width('100%')
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .padding(Spacing.lg)
    .width('100%')
    .backgroundColor(Colors.surface)
    .alignItems(HorizontalAlign.Start)
  }
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onBackground)

        Blank()

        Button('Clear')
          .fontSize(14)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.medium)
          .padding({ top: Spacing.sm, bottom: Spacing.sm, left: Spacing.md, right: Spacing.md })
          .onClick(() => {
            console.log('Clear button tapped');
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.md })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)
      .shadow({ radius: 2, color: '#0D000000', offsetX: 0, offsetY: 1 })

      // Scrollable content
      Scroll() {
        Column({ space: Spacing.md }) {
          ForEach(clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor(Colors.background)
      .scrollBar(BarState.Off)

      // Settings pane with top shadow
      Column() {
        Divider()
          .color('#1A000000')
          .strokeWidth(1)

        SettingsPane({ sliderValue: $sliderValue })
      }
      .backgroundColor(Colors.surface)
      .shadow({ radius: 6, color: '#1A000000', offsetX: 0, offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}