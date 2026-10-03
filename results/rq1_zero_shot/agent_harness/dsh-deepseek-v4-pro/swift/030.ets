// AppTokens
class AppColors {
  static readonly primary: string = '#007BFF';
  static readonly secondary: string = '#6C757D';
  static readonly tertiary: string = '#17A2B8';
  static readonly background: string = '#F8F9FA';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E9ECEF';
  static readonly outline: string = '#DEE2E6';
  static readonly success: string = '#28A745';
  static readonly warning: string = '#FFC107';
  static readonly error: string = '#DC3545';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#212529';
  static readonly onSurface: string = '#212529';
}

class AppTypography {
  static readonly displaySize: number = 36;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 28;
  static readonly headlineWeight: FontWeight = FontWeight.Semibold;
  static readonly titleSize: number = 22;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 16;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
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

class AppShadows {
  static readonly level1Color: string = '#1A000000';
  static readonly level1Radius: number = 3;
  static readonly level1Dy: number = 1;
  static readonly level2Color: string = '#1A000000';
  static readonly level2Radius: number = 6;
  static readonly level2Dy: number = 2;
  static readonly level3Color: string = '#1A000000';
  static readonly level3Radius: number = 10;
  static readonly level3Dy: number = 4;
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

// 自定义线性进度指示器
@Component
struct LinearProgress {
  progress: number = 0;
  color: string = '#000000';
  trackColor: string = '#CCCCCC';
  height: number = 4;
  radius: number = 4;

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(this.height)
        .backgroundColor(this.trackColor)
        .borderRadius(this.radius)
      Row()
        .width(Math.round(this.progress * 100) + '%')
        .height(this.height)
        .backgroundColor(this.color)
        .borderRadius(this.radius)
    }
    .width('100%')
    .height(this.height)
  }
}

// ClipboardCard
@Component
struct ClipboardCard {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  build() {
    Column() {
      Row() {
        Row()
          .width(24)
          .height(24)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)

        Text(this.item.type)
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .space(AppSpacing.sm)
      .padding({ bottom: AppSpacing.sm })

      Text(this.item.content)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .padding({ bottom: AppSpacing.md })

      LinearProgress({ progress: this.item.progress, color: AppColors.tertiary, trackColor: AppColors.surfaceVariant, height: 4, radius: AppShapes.small })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.surfaceVariant })
    .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })
  }
}

// SettingsPane
@Component
struct SettingsPane {
  @Prop sliderValue: number = 24;

  build() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text('' + Math.round(this.sliderValue))
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Semibold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding({ bottom: AppSpacing.sm })

      Slider({ value: this.sliderValue, min: 1, max: 72, step: 1 })
        .selectedColor(AppColors.primary)
        .onChange((value: number) => {
          this.sliderValue = value;
        })
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
  }
}

@Component
struct RootScreen {
  @State sliderValue: number = 24;
  safeAreaTop: number = 0;

  clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  build() {
    Column() {
      // 自定义顶部栏，模拟 CenterAlignedTopAppBar
      Row() {
        Blank()

        Text('Clipboard History')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onBackground)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Text('Clear')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onSurface)
            .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm, left: AppSpacing.md, right: AppSpacing.md })
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)
        }
        .padding({ right: AppSpacing.md })
        .onClick(() => {
          console.log('Clear button tapped');
        })
      }
      .width('100%')
      .height(56 + this.safeAreaTop)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: 0.5, color: '#0D000000', offsetX: 0, offsetY: 0.5 })

      // 内容区域，模拟 LazyColumn
      Scroll() {
        Column() {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => '' + item.id)
        }
        .width('100%')
        .space(AppSpacing.md)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      // 设置面板
      SettingsPane({ sliderValue: this.sliderValue })
        .backgroundColor(AppColors.surface)
        .shadow({ radius: AppShadows.level2Radius, color: AppShadows.level2Color, offsetX: 0, offsetY: -AppShadows.level2Dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
