import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: ResourceColor = 0xFF007BFF;
  static readonly secondary: ResourceColor = 0xFF6C757D;
  static readonly tertiary: ResourceColor = 0xFF17A2B8;
  static readonly background: ResourceColor = 0xFFF8F9FA;
  static readonly surface: ResourceColor = 0xFFFFFFFF;
  static readonly surfaceVariant: ResourceColor = 0xFFE9ECEF;
  static readonly outline: ResourceColor = 0xFFDEE2E6;
  static readonly success: ResourceColor = 0xFF28A745;
  static readonly warning: ResourceColor = 0xFFFFC107;
  static readonly error: ResourceColor = 0xFFDC3545;
  static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
  static readonly onSecondary: ResourceColor = 0xFFFFFFFF;
  static readonly onTertiary: ResourceColor = 0xFFFFFFFF;
  static readonly onBackground: ResourceColor = 0xFF212529;
  static readonly onSurface: ResourceColor = 0xFF212529;
}

class AppTypographyTokens {
  static readonly displaySize: number = 36;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 28;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleSize: number = 22;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 16;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 14;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.1);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.1);
}

// MARK: - Data Models
class ClipboardItem {
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

// MARK: - ClipboardCard Component
@Component
struct ClipboardCard {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column({ space: 0 }) {
      // Header row
      Row({ space: AppSpacing.sm }) {
        // Type icon box
        Column()
          .width(24)
          .height(24)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.primary)

        Text(this.item.type)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.sm })

      // Content text
      Text(this.item.content)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: AppSpacing.md })

      // Progress bar
      Stack({ alignContent: Alignment.Start }) {
        // Track
        Row()
          .width('100%')
          .height(4)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.surfaceVariant)

        // Progress fill
        Row()
          .width(`${this.item.progress * 100}%`)
          .height(4)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.tertiary)
      }
      .width('100%')
      .height(4)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.surfaceVariant, radius: AppShapes.large })
    .shadow({
      radius: AppElevationMapping.level1.radius,
      color: `rgba(0,0,0,${AppElevationMapping.level1.opacity})`,
      offsetX: 0,
      offsetY: AppElevationMapping.level1.dy
    })
  }
}

// MARK: - SettingsPane Component
@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .width('100%')
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: `rgba(0,0,0,${AppElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: -AppElevationMapping.level2.dy
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24.0;

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onBackground)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Text('Clear')
            .fontSize(AppTypographyTokens.labelSize)
            .fontWeight(AppTypographyTokens.labelWeight)
            .fontColor(AppColors.onSurface)
            .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm, left: AppSpacing.md, right: AppSpacing.md })
        }
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .margin({ right: AppSpacing.md })
        .onClick(() => {
          console.log('Clear button tapped');
        })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 0.5,
        color: 'rgba(0,0,0,0.05)',
        offsetX: 0,
        offsetY: 0.5
      })

      // Scrollable content area
      Scroll() {
        Column({ space: AppSpacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
        }
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)
      .layoutWeight(1)
      .width('100%')

      // Settings pane
      SettingsPane({ sliderValue: $sliderValue })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}