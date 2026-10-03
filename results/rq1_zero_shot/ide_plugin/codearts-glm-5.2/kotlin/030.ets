const NAME = '031_ClipboardHistory_en'
const UI_TYPE = 'Productivity'
const STYLE_THEME = 'Modern Blue'
const LANG = 'en'
const BASELINE_SIZE = '720x1280'

class AppTokens {
  static Colors = {
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
    onSurface: '#212529',
  }

  static TypographyTokens = {
    display: { fontSize: 36, fontWeight: FontWeight.Bold },
    headline: { fontSize: 28, fontWeight: FontWeight.Medium },
    title: { fontSize: 22, fontWeight: FontWeight.Medium },
    body: { fontSize: 16, fontWeight: FontWeight.Normal, lineHeight: 24 },
    label: { fontSize: 14, fontWeight: FontWeight.Medium },
  }

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12,
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  }

  static ElevationMapping = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.1 },
    level2: { elevation: 3, radius: 6, dy: 2, opacity: 0.1 },
    level3: { elevation: 6, radius: 10, dy: 4, opacity: 0.1 },
  }
}

interface ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24

  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
    { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
    { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
    { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: 'File', timestamp: 'Yesterday', progress: 1.0 },
  ]

  build() {
    Column() {
      Row() {
        Text('Clipboard History')
          .fontSize(AppTokens.TypographyTokens.title.fontSize)
          .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Button('Clear')
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .fontColor(AppTokens.Colors.onSurface)
          .borderRadius(AppTokens.Shapes.medium)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .height(36)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      List() {
        ForEach(this.clipboardItems, (item: ClipboardItem) => {
          ListItem() {
            ClipboardCard({ item: item })
          }
        }, (item: ClipboardItem) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)

      SettingsPane({ sliderValue: this.sliderValue, onSliderChange: (v: number) => { this.sliderValue = v } })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct ClipboardCard {
  private item: ClipboardItem = { id: 0, content: '', type: '', timestamp: '', progress: 0 }

  build() {
    Column() {
      Row() {
        Column()
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.sm })

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.item.content)
        .fontSize(AppTokens.TypographyTokens.body.fontSize)
        .fontWeight(AppTokens.TypographyTokens.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ top: AppTokens.Spacing.sm })
        .width('100%')

      Progress({ value: this.item.progress * 100, total: 100, type: ProgressType.Linear })
        .style({ strokeWidth: 4 })
        .color(AppTokens.Colors.tertiary)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .width('100%')
        .margin({ top: AppTokens.Spacing.md })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
    .shadow({ radius: AppTokens.ElevationMapping.level1.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`, offsetY: AppTokens.ElevationMapping.level1.dy })
  }
}

@Component
struct SettingsPane {
  @Prop sliderValue: number
  onSliderChange: (v: number) => void = () => {}

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTokens.TypographyTokens.label.fontSize)
          .fontWeight(AppTokens.TypographyTokens.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(Math.floor(this.sliderValue).toString())
          .fontSize(AppTokens.TypographyTokens.body.fontSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet,
      })
        .blockColor(AppTokens.Colors.primary)
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .width('100%')
        .onChange((value: number, mode: SliderChangeMode) => {
          this.onSliderChange(value)
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}