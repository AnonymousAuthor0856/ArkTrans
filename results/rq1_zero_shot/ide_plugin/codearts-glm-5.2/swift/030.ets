class AppTokens {
  static readonly Colors = {
    primary: '#FF007BFF',
    secondary: '#FF6C757D',
    tertiary: '#FF17A2B8',
    background: '#FFF8F9FA',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE9ECEF',
    outline: '#FFDEE2E6',
    success: '#FF28A745',
    warning: '#FFFFC107',
    error: '#FFDC3545',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF212529',
    onSurface: '#FF212529'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }
}

class ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id
    this.content = content
    this.type = type
    this.timestamp = timestamp
    this.progress = progress
  }
}

@Component
struct ClipboardCard {
  @Prop content: string
  @Prop type: string
  @Prop timestamp: string
  @Prop progress: number

  build() {
    Column() {
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(4)
          .backgroundColor(AppTokens.Colors.primary)

        Text(this.type)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: 8 })

        Blank()

        Text(this.timestamp)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .margin({ bottom: 8 })

      Text(this.content)
        .fontSize(16)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: 12 })

      Progress({ value: this.progress, total: 1, type: ProgressType.Linear })
        .width('100%')
        .height(4)
        .color(AppTokens.Colors.tertiary)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.surface)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
    .shadow({ radius: 3, color: '#1A000000', offsetX: 0, offsetY: 1 })
  }
}

@Entry
@Component
struct ClipboardHistory {
  @State sliderValue: number = 24.0

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, 'Shared file: \'Q3_Report.pdf\'', 'File', 'Yesterday', 1.0)
  ]

  build() {
    Column() {
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Text('Clear')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .borderRadius(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)

      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ content: item.content, type: item.type, timestamp: item.timestamp, progress: item.progress })
              .margin({ bottom: 12 })
          })
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Row() {
          Text('History Limit (Hours)')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Text(`${Math.floor(this.sliderValue)}`)
            .fontSize(16)
            .fontWeight(FontWeight.Semibold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .margin({ bottom: 8 })

        Slider({
          value: this.sliderValue,
          min: 1,
          max: 72,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.primary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .onChange((value: number, mode: SliderChangeMode) => {
            this.sliderValue = value
          })
      }
      .width('100%')
      .padding(16)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}