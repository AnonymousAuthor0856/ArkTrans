// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF007BFF'
  static readonly secondary: string = '#FF6C757D'
  static readonly tertiary: string = '#FF17A2B8'
  static readonly background: string = '#FFF8F9FA'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFE9ECEF'
  static readonly outline: string = '#FFDEE2E6'
  static readonly success: string = '#FF28A745'
  static readonly warning: string = '#FFFFC107'
  static readonly error: string = '#FFDC3545'
  static readonly onPrimary: string = '#FFFFFFFF'
  static readonly onSecondary: string = '#FFFFFFFF'
  static readonly onTertiary: string = '#FFFFFFFF'
  static readonly onBackground: string = '#FF212529'
  static readonly onSurface: string = '#FF212529'
}

class AppTypographyTokens {
  static readonly display: Font = { size: 36, weight: FontWeight.Bold }
  static readonly headline: Font = { size: 28, weight: FontWeight.Medium }
  static readonly title: Font = { size: 22, weight: FontWeight.Medium }
  static readonly body: Font = { size: 16, weight: FontWeight.Regular }
  static readonly label: Font = { size: 14, weight: FontWeight.Medium }
}

class AppShapes {
  static readonly small: Length = 4
  static readonly medium: Length = 8
  static readonly large: Length = 12
}

class AppSpacing {
  static readonly xs: Length = 4
  static readonly sm: Length = 8
  static readonly md: Length = 12
  static readonly lg: Length = 16
  static readonly xl: Length = 24
}

class AppElevation {
  static readonly level1: ShadowOptions = { radius: 3, offsetY: 1, color: 'rgba(0,0,0,0.1)' }
  static readonly level2: ShadowOptions = { radius: 6, offsetY: 2, color: 'rgba(0,0,0,0.1)' }
  static readonly level3: ShadowOptions = { radius: 10, offsetY: 4, color: 'rgba(0,0,0,0.1)' }
}

// MARK: - Data Models
interface ClipboardItem {
  id: number
  content: string
  type: string
  timestamp: string
  progress: number
}

// MARK: - ClipboardCard Component
@Component
struct ClipboardCard {
  @Prop item: ClipboardItem

  build() {
    Column() {
      Row() {
        Row() {
        }
        .width(24)
        .height(24)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)

        Text(this.item.type)
          .font(AppTypographyTokens.label)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .margin({ left: AppSpacing.sm })

        Blank()

        Text(this.item.timestamp)
          .font(AppTypographyTokens.label)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .margin({ bottom: AppSpacing.sm })

      Text(this.item.content)
        .font(AppTypographyTokens.body)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: AppSpacing.md })

      Progress({ value: this.item.progress * 100, total: 100, type: ProgressType.Linear })
        .color(AppColors.tertiary)
        .backgroundColor(AppColors.surfaceVariant)
        .height(4)
        .borderRadius(AppShapes.small)
        .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.surfaceVariant })
    .shadow(AppElevation.level1)
  }
}

// MARK: - SettingsPane Component
@Component
struct SettingsPane {
  @Link sliderValue: number

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .font(AppTypographyTokens.label)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(this.sliderValue.toFixed(0))
          .font(AppTypographyTokens.body)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .margin({ bottom: AppSpacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .blockColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 6, offsetY: -2, color: 'rgba(0,0,0,0.1)' })
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24

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
          .font(AppTypographyTokens.title)
          .fontColor(AppColors.onBackground)

        Blank()

        Button('Clear')
          .font(AppTypographyTokens.label)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm, left: AppSpacing.md, right: AppSpacing.md })
          .margin({ right: AppSpacing.md })
          .onClick(() => {
            console.info('Clear button tapped')
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 0.5, offsetY: 0.5, color: 'rgba(0,0,0,0.05)' })

      // Scrollable content area
      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      // Settings Pane
      SettingsPane({ sliderValue: $sliderValue })
        .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
