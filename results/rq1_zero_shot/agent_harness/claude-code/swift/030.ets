// Design tokens
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
    onSurface: '#212529'
  };

  static Typography = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.Medium },
    title: { size: 22, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static Elevation = {
    level1: { radius: 3, y: 1, opacity: 0.1 },
    level2: { radius: 6, y: 2, opacity: 0.1 },
    level3: { radius: 10, y: 4, opacity: 0.1 }
  };
}

// Data model
interface ClipboardItem {
  id: number;
  content: string;
  type: string;
  timestamp: string;
  progress: number;
}

// Custom linear progress component
@Component
struct CustomLinearProgress {
  @Prop progress: number = 0;
  @Prop tint: string = AppTokens.Colors.tertiary;
  @Prop track: string = AppTokens.Colors.surfaceVariant;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track
      Rect()
        .width('100%')
        .height(4)
        .fill(this.track)
        .borderRadius(AppTokens.Shapes.small)
      // Progress bar
      Rect()
        .width(`${this.progress * 100}%`)
        .height(4)
        .fill(this.tint)
        .borderRadius(AppTokens.Shapes.small)
    }
    .width('100%')
    .height(4)
  }
}

// ClipboardCard component
@Component
struct ClipboardCard {
  @Prop item: ClipboardItem;

  build() {
    Column() {
      // Header row: type badge + type label + spacer + timestamp
      Row() {
        // Color badge
        Rect()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)

        Text(this.item.type)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .margin({ left: AppTokens.Spacing.sm })

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      // Content text
      Text(this.item.content)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.md })

      // Progress bar
      CustomLinearProgress({ progress: this.item.progress })
        .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.surfaceVariant })
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level1.y
    })
  }
}

// SettingsPane component
@Component
struct SettingsPane {
  @Link sliderValue: number;

  build() {
    Column() {
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
        .selectedColor(AppTokens.Colors.primary)
        .trackColor(AppTokens.Colors.surfaceVariant)
        .onChange((value: number) => {
          this.sliderValue = Math.round(value);
        })
        .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
  }
}

// RootScreen - main screen
@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;

  private clipboardItems: ClipboardItem[] = [
    { id: 1, content: 'https://www.example.com/modern-design', type: 'Link', timestamp: '5 min ago', progress: 0.2 },
    { id: 2, content: 'Final project review notes have been updated.', type: 'Text', timestamp: '23 min ago', progress: 0.5 },
    { id: 3, content: '#007BFF', type: 'Color', timestamp: '1 hour ago', progress: 0.8 },
    { id: 4, content: 'Meeting at 3 PM with the design team.', type: 'Text', timestamp: '3 hours ago', progress: 0.9 },
    { id: 5, content: "Shared file: 'Q3_Report.pdf'", type: 'File', timestamp: 'Yesterday', progress: 1.0 }
  ];

  build() {
    Column() {
      // Top app bar
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        Button('Clear')
          .fontSize(AppTokens.Typography.label.size)
          .fontColor(AppTokens.Colors.onSurface)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm,
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md
          })
          .margin({ right: AppTokens.Spacing.md })
          .onClick(() => {
            console.info('Clear button tapped');
          })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 0.5,
        color: 'rgba(0, 0, 0, 0.05)',
        offsetX: 0,
        offsetY: 0.5
      })

      // Scrollable content area
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
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background)
      .scrollBar(BarState.Off)

      // Settings pane at bottom
      SettingsPane({ sliderValue: $sliderValue })
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
          offsetX: 0,
          offsetY: -AppTokens.Elevation.level2.y
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
