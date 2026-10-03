class AppColors {
  static readonly primary: ResourceColor = '#007BFF';
  static readonly secondary: ResourceColor = '#6C757D';
  static readonly tertiary: ResourceColor = '#17A2B8';
  static readonly background: ResourceColor = '#F8F9FA';
  static readonly surface: ResourceColor = '#FFFFFF';
  static readonly surfaceVariant: ResourceColor = '#E9ECEF';
  static readonly outline: ResourceColor = '#DEE2E6';
  static readonly success: ResourceColor = '#28A745';
  static readonly warning: ResourceColor = '#FFC107';
  static readonly error: ResourceColor = '#DC3545';
  static readonly onPrimary: ResourceColor = '#FFFFFF';
  static readonly onSecondary: ResourceColor = '#FFFFFF';
  static readonly onTertiary: ResourceColor = '#FFFFFF';
  static readonly onBackground: ResourceColor = '#212529';
  static readonly onSurface: ResourceColor = '#212529';
}

class AppTextStyle {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypography {
  static readonly displayMedium: AppTextStyle = new AppTextStyle(36, FontWeight.Bold);
  static readonly headlineSmall: AppTextStyle = new AppTextStyle(28, FontWeight.SemiBold);
  static readonly titleMedium: AppTextStyle = new AppTextStyle(22, FontWeight.Medium);
  static readonly bodyMedium: AppTextStyle = new AppTextStyle(16, FontWeight.Regular);
  static readonly labelMedium: AppTextStyle = new AppTextStyle(14, FontWeight.Medium);
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.1);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.1);
}

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

@Component
struct LinearProgressBar {
  value: number = 0;
  tint: ResourceColor = AppColors.tertiary;
  track: ResourceColor = AppColors.surfaceVariant;

  private getProgressWidth(): string {
    const clamped: number = Math.max(0, Math.min(1, this.value));
    return `${clamped * 100}%`;
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(4)
        .backgroundColor(this.track)
        .borderRadius(AppShapes.small)

      Row()
        .width(this.getProgressWidth())
        .height(4)
        .backgroundColor(this.tint)
        .borderRadius(AppShapes.small)
    }
    .width('100%')
    .height(4)
  }
}

@Component
struct ClipboardCard {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column() {
      Row({ space: AppSpacing.sm }) {
        Row()
          .width(24)
          .height(24)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)

        Text(this.item.type)
          .fontSize(AppTypography.labelMedium.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTypography.labelMedium.size)
          .fontWeight(AppTypography.labelMedium.weight)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: AppSpacing.sm })

      Text(this.item.content)
        .width('100%')
        .fontSize(AppTypography.bodyMedium.size)
        .fontWeight(AppTypography.bodyMedium.weight)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .padding({ bottom: AppSpacing.md })

      LinearProgressBar({
        value: this.item.progress,
        tint: AppColors.tertiary,
        track: AppColors.surfaceVariant
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.surfaceVariant,
      radius: AppShapes.large
    })
    .shadow({
      radius: AppElevation.level1.radius,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }
}

@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTypography.labelMedium.size)
          .fontWeight(AppTypography.labelMedium.weight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(this.sliderValue.toFixed(0))
          .fontSize(AppTypography.bodyMedium.size)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ bottom: AppSpacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .blockColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .selectedColor(AppColors.primary)
        .showTips(false)
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
  }
}

@Entry
@Component
struct RootScreen {
  @State private sliderValue: number = 24;

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, 'Shared file: \'Q3_Report.pdf\'', 'File', 'Yesterday', 1.0)
  ];

  build() {
    Column() {
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(AppTypography.titleMedium.size)
          .fontWeight(AppTypography.titleMedium.weight)
          .fontColor(AppColors.onBackground)

        Blank()

        Button() {
          Text('Clear')
            .fontSize(AppTypography.labelMedium.size)
            .fontWeight(AppTypography.labelMedium.weight)
            .fontColor(AppColors.onSurface)
        }
        .type(ButtonType.Normal)
        .padding({
          top: AppSpacing.sm,
          bottom: AppSpacing.sm,
          left: AppSpacing.md,
          right: AppSpacing.md
        })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)
        .margin({ right: AppSpacing.md })
        .onClick(() => {
          console.info('Clear button tapped');
        })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: 0.5,
        color: 'rgba(0, 0, 0, 0.05)',
        offsetX: 0,
        offsetY: 0.5
      })

      Scroll() {
        Column({ space: AppSpacing.md }) {
          ForEach(
            this.clipboardItems,
            (item: ClipboardItem) => {
              ClipboardCard({ item: item })
            },
            (item: ClipboardItem) => item.id.toString()
          )
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.md
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      SettingsPane({ sliderValue: $sliderValue })
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevation.level2.radius,
          color: 'rgba(0, 0, 0, 0.10)',
          offsetX: 0,
          offsetY: -AppElevation.level2.dy
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}