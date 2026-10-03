// AppTokens.ets
// Centralized design tokens for atomic modifications and cross-platform consistency.

export class AppTokens {
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
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.Medium },
    title: { size: 22, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
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

  static readonly ElevationMapping = {
    level1: { elevation: 1, radius: 3, dy: 1, opacity: 0.1 },
    level2: { elevation: 3, radius: 6, dy: 2, opacity: 0.1 },
    level3: { elevation: 6, radius: 10, dy: 4, opacity: 0.1 }
  }
}

// Data Model
export class ClipboardItem {
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

// Custom Linear Progress Component to match Compose's trackColor
@Component
export struct CustomLinearProgress {
  private progress: number = 0;
  private tint: string = AppTokens.Colors.tertiary;
  private track: string = AppTokens.Colors.surfaceVariant;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track background
      Column()
        .width('100%')
        .height(4)
        .backgroundColor(this.track)
        .borderRadius(AppTokens.Shapes.small)

      // Progress fill
      Column()
        .width(`${this.progress * 100}%`)
        .height(4)
        .backgroundColor(this.tint)
        .borderRadius(AppTokens.Shapes.small)
    }
    .width('100%')
    .height(4)
  }
}

// ClipboardCard Component
@Component
export struct ClipboardCard {
  private item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column({ space: 0 }) {
      // Header Row
      Row({ space: AppTokens.Spacing.sm }) {
        // Icon Box
        Column()
          .width(24)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)

        Blank() // Pushes subsequent elements to the end

        Text(this.item.timestamp)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      // Content Text
      Text(this.item.content)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.md })

      // Progress Bar
      CustomLinearProgress({ progress: this.item.progress })
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

// SettingsPane Component
@Component
export struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(AppTokens.Typography.body.size)
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

// RootScreen Component
@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24.0;

  private clipboardItems: Array<ClipboardItem> = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  build() {
    Column() {
      // Custom Top App Bar
      Row() {
        Blank() // Left spacer for centering

        Text('Clipboard History')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank() // Right spacer for centering

        Button('Clear') {
          console.log('Clear button tapped');
        }
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .margin({ right: AppTokens.Spacing.md })
      }
      .width('100%')
      .height(56)
      .padding({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.sm }) // Padding for status bar avoidance
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 0.5,
        color: 'rgba(0,0,0,0.05)',
        offsetX: 0,
        offsetY: 0.5
      })

      // Scrollable Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // Settings Pane
      SettingsPane({ sliderValue: $sliderValue })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: 0,
          offsetY: -AppTokens.ElevationMapping.level2.dy // Shadow points upwards
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.System], [SafeAreaEdge.Top]) // Extends content to top edge
  }
}