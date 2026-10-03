/**
 * RootScreen.ets
 * ArkTS (HarmonyOS ArkUI) translation of the SwiftUI document-annotation screen.
 *
 * Mapping notes:
 *   SwiftUI Color(hex:)        -> ArkTS '#RRGGBB' color strings
 *   SwiftUI Font.system(...)   -> .fontSize() + .fontWeight()
 *   SwiftUI Shapes.circle      -> Circle() / .borderRadius(20) on a 40x40 box
 *   SwiftUI Shapes.small/med/lg-> .borderRadius(4 / 8 / 12)
 *   SwiftUI shadow(...)        -> .shadow({ radius, color, offsetX, offsetY })
 *   SwiftUI LazyVGrid(2 cols)  -> Scroll + Column of Rows (2 cells per row)
 *   SwiftUI Box(contentAlign)  -> Stack({ alignContent: Alignment.Start })
 *   SwiftUI Scaffold/TopAppBar -> Column + fixed-height Row
 */

// MARK: - Design tokens (AppTokens equivalent)

class AppColors {
  static readonly primary: string = '#A0C4FF';
  static readonly secondary: string = '#B7E4C7';
  static readonly tertiary: string = '#FFDDC1';
  static readonly background: string = '#F8F7FF';
  static readonly surface: string = '#FFFFFF';
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
  // surface.copy(alpha = 0.8f)
  static readonly surfaceOverlay: string = '#CCFFFFFF';
  static readonly transparent: string = '#00000000';
}

class AppTypography {
  static readonly displaySize: number = 45;
  static readonly headlineSize: number = 24;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
  static readonly iconSize: number = 17;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class AppShapes {
  static readonly smallRadius: number = 4;
  static readonly mediumRadius: number = 8;
  static readonly largeRadius: number = 12;
}

/** ElevationMapping.level1 -> SwiftUI shadow parameters */
class AppElevation {
  static readonly level1Radius: number = 2;
  static readonly level1OffsetY: number = 1;
  static readonly level1Color: string = '#14000000';
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';

  // 12 pages laid out as 6 rows of 2, matching GridCells.Fixed(2)
  private pageRows: number[][] = [
    [1, 2],
    [3, 4],
    [5, 6],
    [7, 8],
    [9, 10],
    [11, 12]
  ];

  // MARK: Reusable annotation tool button

  @Builder
  ToolButton(icon: string, toolName: string) {
    Text(icon)
      .fontSize(AppTypography.iconSize)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.selectedTool === toolName ? AppColors.onSecondary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor(this.selectedTool === toolName ? AppColors.secondary : AppColors.surfaceVariant)
      .onClick(() => {
        this.selectedTool = toolName;
      })
  }

  // MARK: Page thumbnail

  @Builder
  PageThumb(page: number) {
    Column() {
      Text(page.toString())
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('100%')
    .aspectRatio(0.7)
    .borderRadius(AppShapes.mediumRadius)
    .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
    .borderWidth(this.selectedPage === page ? 2 : 0)
    .borderColor(AppColors.primary)
    .onClick(() => {
      this.selectedPage = page;
    })
  }

  // MARK: Top app bar

  @Builder
  TopBar() {
    Row({ space: AppSpacing.sm }) {
      // Navigation icon: leading circular placeholder
      Circle()
        .width(24)
        .height(24)
        .fill(AppColors.surfaceVariant)

      // Title, weighted so it sits centered between the icon and the action
      Text('Document.pdf')
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      // Action: Share button
      Text('Share')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({
          left: AppSpacing.sm,
          right: AppSpacing.sm,
          top: AppSpacing.xs,
          bottom: AppSpacing.xs
        })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.smallRadius)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(56)
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  // MARK: Page list (left rail)

  @Builder
  PageRail() {
    Scroll() {
      Column({ space: AppSpacing.sm }) {
        ForEach(this.pageRows, (row: number[]) => {
          Row({ space: AppSpacing.sm }) {
            ForEach(row, (page: number) => {
              this.PageThumb(page)
            }, (page: number) => page.toString())
          }
          .width('100%')
        }, (row: number[]) => row[0].toString())
      }
      .width('100%')
      .padding(AppSpacing.sm)
    }
    .width(150)
    .height('100%')
    .scrollBar(BarState.Off)
  }

  // MARK: Document canvas (right side)

  @Builder
  DocumentCanvas() {
    Stack({ alignContent: Alignment.Start }) {
      // Document card with level-1 elevation
      Column() {
        Text(`Page ${this.selectedPage}`)
          .fontSize(AppTypography.headlineSize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.largeRadius)
      .shadow({
        radius: AppElevation.level1Radius,
        color: AppElevation.level1Color,
        offsetX: 0,
        offsetY: AppElevation.level1OffsetY
      })

      // Floating annotation tool column
      Column({ space: AppSpacing.sm }) {
        this.ToolButton('P', 'pen')
        this.ToolButton('H', 'highlighter')
        this.ToolButton('T', 'text')
        this.ToolButton('S', 'shape')
      }
      .padding(AppSpacing.sm)
      .backgroundColor(AppColors.surfaceOverlay)
      .borderRadius(AppShapes.largeRadius)
      .borderWidth(1)
      .borderColor(AppColors.outline)
      .margin({ left: AppSpacing.md })
    }
    .width('100%')
    .height('100%')
    .layoutWeight(1)
  }

  // MARK: Screen

  build() {
    Column() {
      this.TopBar()

      Row({ space: AppSpacing.md }) {
        this.PageRail()
        this.DocumentCanvas()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}