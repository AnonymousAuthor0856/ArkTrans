@Entry
@Component
struct ClipboardHistoryApp {
  build() {
    RootScreen()
  }
}

// MARK: - AppTokens
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

  static readonly Typography = {
    display: { fontSize: 36, fontWeight: FontWeight.Bold },
    headline: { fontSize: 28, fontWeight: FontWeight.Medium },
    title: { fontSize: 22, fontWeight: FontWeight.Medium },
    body: { fontSize: 16, fontWeight: FontWeight.Normal },
    label: { fontSize: 14, fontWeight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Elevation = {
    level1: { radius: 3, dy: 1, opacity: 0.1 },
    level2: { radius: 6, dy: 2, opacity: 0.1 },
    level3: { radius: 10, dy: 4, opacity: 0.1 }
  }
}

// MARK: - Data Model
interface ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State sliderValue: number = 24.0

  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
    { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
    { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
    { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: 'File', timestamp: 'Yesterday', progress: 1.0 }
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Blank()
        Text('Clipboard History')
          .fontSize(AppTokens.Typography.title.fontSize)
          .fontWeight(AppTokens.Typography.title.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
        Blank()

        Button() {
          console.info('Clear button tapped')
        }
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ right: AppTokens.Spacing.md })
        .type(ButtonType.Normal)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .margin({ right: AppTokens.Spacing.md })
        .onClick(() => {
          console.info('Clear button tapped')
        })
        .attributeModifier(this.clearButtonModifier())
      }
      .width('100%')
      .height(56)
      .padding({ top: 0 })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 0.5, color: 'rgba(0,0,0,0.05)', offsetY: 0.5 })

      // Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.md,
          bottom: AppTokens.Spacing.md
        })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // Settings Pane
      SettingsPane({ sliderValue: $sliderValue })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
          offsetY: -AppTokens.Elevation.level2.dy
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  clearButtonModifier() {
    Column() {
      Text('Clear')
        .fontSize(AppTokens.Typography.label.fontSize)
        .fontWeight(AppTokens.Typography.label.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

// MARK: - ClipboardCard
@Component
struct ClipboardCard {
  @Prop item: ClipboardItem

  build() {
    Column({ space: 0 }) {
      Row({ space: AppTokens.Spacing.sm }) {
        // Icon placeholder
        Row()
          .width(24)
          .height(24)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.primary)

        Text(this.item.type)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppTokens.Spacing.sm })

      Text(this.item.content)
        .fontSize(AppTokens.Typography.body.fontSize)
        .fontWeight(AppTokens.Typography.body.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.md })

      // Custom Linear Progress
      Stack({ alignContent: Alignment.Start }) {
        // Track
        Row()
          .width('100%')
          .height(4)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

        // Progress
        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .borderRadius(AppTokens.Shapes.small)
          .backgroundColor(AppTokens.Colors.tertiary)
      }
      .width('100%')
      .height(4)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.surfaceVariant,
      radius: AppTokens.Shapes.large
    })
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      color: `rgba(0,0,0,${AppTokens.Elevation.level1.opacity})`,
      offsetY: AppTokens.Elevation.level1.dy
    })
  }
}

// MARK: - SettingsPane
@Component
struct SettingsPane {
  @Link sliderValue: number

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTokens.Typography.label.fontSize)
          .fontWeight(AppTokens.Typography.label.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(AppTokens.Typography.body.fontSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(AppTokens.Colors.primary)
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .width('100%')
        .onChange((value: number) => {
          this.sliderValue = value
        })
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}