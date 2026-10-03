// ClipboardHistory.ets
// ArkTS (HarmonyOS) 版：SwiftUI -> ArkTS 转换
// 入口为 @Entry 组件；如需隐藏状态栏，已在 aboutToAppear 中处理。

import window from '@ohos.window';

// MARK: - AppTokens
// 集中管理设计令牌，保证与 SwiftUI/Compose 端一致的原子化修改能力。
export class AppColors {
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

export class AppTypographyTokens {
  static readonly displaySize: number = 36;
  static readonly headlineSize: number = 28;
  static readonly titleSize: number = 22;
  static readonly bodySize: number = 16;
  static readonly labelSize: number = 14;

  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineWeight: FontWeight = FontWeight.Bold;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

export class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

export class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

// 阴影规范，用于精确匹配 Compose 的 elevation
export class ShadowSpec {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

export class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.1);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.1);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.1);

  // 把 ShadowSpec 转换为 ArkTS 的 ShadowOptions
  static toShadowOptions(spec: ShadowSpec, offsetY: number): ShadowOptions {
    return {
      radius: spec.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: offsetY
    };
  }
}

// MARK: - Data Models
export class ClipboardItem {
  readonly id: number;
  readonly content: string;
  readonly type: string;
  readonly timestamp: string;
  readonly progress: number;

  constructor(id: number, content: string, type: string, timestamp: string, progress: number) {
    this.id = id;
    this.content = content;
    this.type = type;
    this.timestamp = timestamp;
    this.progress = progress;
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State sliderValue: number = 24;

  private clipboardItems: ClipboardItem[] = [
    new ClipboardItem(1, 'https://www.example.com/modern-design', 'Link', '5 min ago', 0.2),
    new ClipboardItem(2, 'Final project review notes have been updated.', 'Text', '23 min ago', 0.5),
    new ClipboardItem(3, '#007BFF', 'Color', '1 hour ago', 0.8),
    new ClipboardItem(4, 'Meeting at 3 PM with the design team.', 'Text', '3 hours ago', 0.9),
    new ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", 'File', 'Yesterday', 1.0)
  ];

  aboutToAppear(): void {
    // 全屏布局 + 隐藏状态栏，对应 SwiftUI 的 .ignoresSafeArea + .statusBarHidden(true)
    try {
      window.getLastWindow(getContext(this)).then((win: window.Window) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarEnable([]);
      }).catch((err: Error) => {
        console.error(`setWindowLayoutFullScreen failed: ${err.message}`);
      });
    } catch (e) {
      console.error(`window api unavailable: ${e}`);
    }
  }

  // MARK: TopAppBar
  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Clipboard History')
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(AppTypographyTokens.titleWeight)
        .fontColor(AppColors.onBackground)

      Row() {
        Blank()
        Text('Clear')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.onSurface)
          .padding({
            top: AppSpacing.sm,
            bottom: AppSpacing.sm,
            left: AppSpacing.md,
            right: AppSpacing.md
          })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
            console.info('Clear button tapped');
          })
      }
      .width('100%')
      .padding({ right: AppSpacing.md })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 1, color: '#0D000000', offsetX: 0, offsetY: 1 })
  }

  // MARK: SettingsPane
  @Builder
  SettingsPane() {
    Column() {
      Row() {
        Text('History Limit (Hours)')
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(`${Math.round(this.sliderValue)}`)
          .fontSize(AppTypographyTokens.bodySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .padding({ bottom: AppSpacing.sm })

      Slider({
        value: this.sliderValue,
        min: 1,
        max: 72,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .blockColor(AppColors.surface)
        .onChange((value: number, mode: SliderChangeMode) => {
          this.sliderValue = value;
        })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .shadow(ElevationMapping.toShadowOptions(ElevationMapping.level2, -ElevationMapping.level2.dy))
  }

  build() {
    Column() {
      // 顶部栏
      this.TopBar()

      // 内容区域（LazyColumn 等价物）
      Scroll() {
        Column({ space: AppSpacing.md }) {
          ForEach(this.clipboardItems, (item: ClipboardItem) => {
            ClipboardCard({ item: item })
          }, (item: ClipboardItem) => item.id.toString())
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
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      // 底部设置面板
      this.SettingsPane()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - ClipboardCard
@Component
struct ClipboardCard {
  item: ClipboardItem = new ClipboardItem(0, '', '', '', 0);

  // 自定义线性进度条，对应 Compose 的 LinearProgressIndicator(trackColor = ...)
  @Builder
  LinearProgress(fraction: number) {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(4)
        .borderRadius(AppShapes.small)
        .backgroundColor(AppColors.surfaceVariant)

      Row()
        .width(`${Math.min(1, Math.max(0, fraction)) * 100}%`)
        .height(4)
        .borderRadius(AppShapes.small)
        .backgroundColor(AppColors.tertiary)
    }
    .width('100%')
    .height(4)
  }

  build() {
    Column() {
      Row() {
        Row()
          .width(24)
          .height(24)
          .borderRadius(AppShapes.small)
          .backgroundColor(AppColors.primary)

        Text(this.item.type)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .margin({ left: AppSpacing.sm })

        Blank()

        Text(this.item.timestamp)
          .fontSize(AppTypographyTokens.labelSize)
          .fontWeight(AppTypographyTokens.labelWeight)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .margin({ bottom: AppSpacing.sm })

      Text(this.item.content)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(AppColors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ bottom: AppSpacing.md })

      this.LinearProgress(this.item.progress)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.surfaceVariant })
    .shadow(ElevationMapping.toShadowOptions(ElevationMapping.level1, ElevationMapping.level1.dy))
  }
}