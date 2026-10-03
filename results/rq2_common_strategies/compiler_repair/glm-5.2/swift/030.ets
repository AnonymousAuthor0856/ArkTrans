// AppTokens.ets
// Centralized management of all design tokens for atomic modifications and consistency.

export class AppTokens {
  static Colors: Record<string, string> = {
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

  static TypographyTokens: Record<string, FontToken> = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.Medium },
    title: { size: 22, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  }

  static Shapes: Record<string, number> = {
    small: 4,
    medium: 8,
    large: 12
  }

  static Spacing: Record<string, number> = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.1 },
    level2: { elevation: 3, radius: 6, dy: 2, opacity: 0.1 },
    level3: { elevation: 6, radius: 10, dy: 4, opacity: 0.1 }
  }
}

interface FontToken {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

// Data Model
export interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

// Helper function to format font shorthand
function fontToken(token: FontToken): object {
  return { size: `${token.size}fp`, weight: token.weight };
}

@Component
export struct ClipboardCard {
  private item: ClipboardItem = {
    id: 0,
    content: '',
    type: '',
    timestamp: '',
    progress: 0
  };

  build() {
    Column({ space: 0 }) {
      // Top Row: Icon, Type, Timestamp
      Row({ space: AppTokens.Spacing.sm }) {
        // Simulated Box + clip + background
        Text('')
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .font(fontToken(AppTokens.TypographyTokens.label))
          .fontColor(AppTokens.Colors.primary)
          .fontWeight(FontWeight.Bold)

        // Spacer
        Blank()

        Text(this.item.timestamp)
          .font(fontToken(AppTokens.TypographyTokens.label))
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      // Content Text
      Text(this.item.content)
        .font(fontToken(AppTokens.TypographyTokens.body))
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .margin({ bottom: AppTokens.Spacing.md })

      // Linear Progress Indicator
      // Using a custom Row to simulate track and progress
      Row() {
        Column() {
          Text('')
            .width(`${this.item.progress * 100}%`)
            .height(4)
            .backgroundColor(AppTokens.Colors.tertiary)
            .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(4)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height(4)
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
    .shadow({
      radius: AppTokens.ElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level1.dy
    })
  }
}

@Component
export struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .font(fontToken(AppTokens.TypographyTokens.label))
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .font(fontToken(AppTokens.TypographyTokens.body))
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
        .blockColor(AppTokens.Colors.surface)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .selectedColor(AppTokens.Colors.primary)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value;
        })
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24.0;

  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: "https://www.example.com/modern-design", type: "Link", timestamp: "5 min ago", progress: 0.2 },
    { id: 2, content: "Final project review notes have been updated.", type: "Text", timestamp: "23 min ago", progress: 0.5 },
    { id: 3, content: "#007BFF", type: "Color", timestamp: "1 hour ago", progress: 0.8 },
    { id: 4, content: "Meeting at 3 PM with the design team.", type: "Text", timestamp: "3 hours ago", progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: "File", timestamp: "Yesterday", progress: 1.0 }
  ];

  build() {
    Column() {
      // Custom Top App Bar
      Row() {
        Blank() // Left spacer for centering

        Text('Clipboard History')
          .font(fontToken(AppTokens.TypographyTokens.title))
          .fontColor(AppTokens.Colors.onBackground)

        Blank() // Right spacer for centering

        Button('Clear')
          .onClick(() => {
            console.log('Clear button tapped');
          })
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .padding({ top: 36 }) // Safe area approximation for status bar
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 0.5, color: 'rgba(0,0,0,0.05)', offsetY: 0.5 })

      // Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          })
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)

      // Settings Pane
      SettingsPane({ sliderValue: $sliderValue })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetY: -AppTokens.ElevationMapping.level2.dy
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}