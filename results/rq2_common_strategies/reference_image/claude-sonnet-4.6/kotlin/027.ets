// Index.ets
// 028_PDFAnnotator_en — ArkTS port of the Kotlin Compose screen

const NAME: string = '028_PDFAnnotator_en';
const UI_TYPE: string = 'Productivity';
const STYLE_THEME: string = 'Soft Pastel';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#A0C4FF';
  static readonly secondary: string = '#B7E4C7';
  static readonly tertiary: string = '#FFDDC1';
  static readonly background: string = '#F8F7FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceAlpha80: string = '#CCFFFFFF';
  static readonly surfaceVariant: string = '#F0F0F5';
  static readonly outline: string = '#D9D9E3';
  static readonly success: string = '#B4E4C7';
  static readonly warning: string = '#FFDDC1';
  static readonly error: string = '#FFB4AB';
  static readonly onPrimary: string = '#001D3D';
  static readonly onSecondary: string = '#003720';
  static readonly onTertiary: string = '#3E2800';
  static readonly onBackground: string = '#1B1B1F';
  static readonly onSurface: string = '#1B1B1F';
}

class AppTypography {
  static readonly displaySize: number = 45;
  static readonly headlineSize: number = 24;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
  static readonly bodyLineHeight: number = 20;
  static readonly labelLetterSpacing: number = 0.5;
}

class AppShapes {
  static readonly smallRadius: number = 4;
  static readonly mediumRadius: number = 8;
  static readonly largeRadius: number = 12;
  static readonly pillRadius: number = 20;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ShadowSpec {
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

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 1, 0.08);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 4, 2, 0.10);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 8, 4, 0.12);

  static level1Shadow(): ShadowOptions {
    const s: ShadowSpec = AppElevationMapping.level1;
    return { radius: s.radius, color: '#14000000', offsetX: 0, offsetY: s.dy };
  }
}

interface ToolItem {
  icon: string;
  name: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';

  private pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  private tools: ToolItem[] = [
    { icon: 'P', name: 'pen' },
    { icon: 'H', name: 'highlighter' },
    { icon: 'T', name: 'text' },
    { icon: 'S', name: 'shape' }
  ];

  build() {
    Column() {
      this.TopAppBar()

      Row() {
        this.PageGrid()
        this.PreviewPane()
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(VerticalAlign.Top)
      .padding(AppSpacing.md)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  TopAppBar() {
    Stack({ alignContent: Alignment.Center }) {
      Row() {
        Circle()
          .width(40)
          .height(40)
          .fill(AppColors.surfaceVariant)

        Button('Share')
          .fontSize(AppTypography.labelSize)
          .fontWeight(500)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .height(40)
          .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
          .borderRadius(AppShapes.pillRadius)
          .onClick(() => {
          })
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text('Document.pdf')
        .fontSize(AppTypography.titleSize)
        .fontWeight(500)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  PageGrid() {
    Grid() {
      ForEach(this.pages, (page: number) => {
        GridItem() {
          Column() {
            Text(page.toString())
              .fontSize(AppTypography.labelSize)
              .fontWeight(500)
              .letterSpacing(AppTypography.labelLetterSpacing)
              .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
          }
          .width('100%')
          .aspectRatio(0.7)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(AppShapes.mediumRadius)
          .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
          .border({
            width: this.selectedPage === page ? 2 : 0,
            color: AppColors.primary,
            radius: AppShapes.mediumRadius
          })
          .onClick(() => {
            this.selectedPage = page;
          })
        }
      }, (page: number) => page.toString())
    }
    .columnsTemplate('1fr 1fr')
    .columnsGap(AppSpacing.sm)
    .rowsGap(AppSpacing.sm)
    .width(150)
    .height('100%')
    .padding(AppSpacing.sm)
    .scrollBar(BarState.Off)
  }

  @Builder
  PreviewPane() {
    Stack({ alignContent: Alignment.Start }) {
      Column() {
        Text(`Page ${this.selectedPage}`)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(600)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.largeRadius)
      .shadow(AppElevationMapping.level1Shadow())

      this.ToolPalette()
    }
    .layoutWeight(1)
    .height('100%')
    .margin({ left: AppSpacing.md })
  }

  @Builder
  ToolPalette() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.tools, (tool: ToolItem) => {
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Text(tool.icon)
            .fontSize(AppTypography.bodySize)
            .fontWeight(700)
            .fontColor(this.selectedTool === tool.name ? AppColors.onSecondary : AppColors.onSurface)
        }
        .width(40)
        .height(40)
        .padding(0)
        .backgroundColor(this.selectedTool === tool.name ? AppColors.secondary : AppColors.surfaceVariant)
        .onClick(() => {
          this.selectedTool = tool.name;
        })
      }, (tool: ToolItem) => tool.name)
    }
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surfaceAlpha80)
    .borderRadius(AppShapes.largeRadius)
    .border({ width: 1, color: AppColors.outline, radius: AppShapes.largeRadius })
    .margin({ left: AppSpacing.md })
  }
}