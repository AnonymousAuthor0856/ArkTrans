// AppTokens
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
}

class AppTypography {
  static readonly displaySize: number = 45;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 24;
  static readonly headlineWeight: FontWeight = FontWeight.Semibold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
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
  static readonly level1Color: string = '#14000000';
  static readonly level1Radius: number = 2;
  static readonly level1Dy: number = 1;
  static readonly level2Color: string = '#1A000000';
  static readonly level2Radius: number = 4;
  static readonly level2Dy: number = 2;
  static readonly level3Color: string = '#1F000000';
  static readonly level3Radius: number = 8;
  static readonly level3Dy: number = 4;
}

// 注释工具按钮
@Component
struct AnnotationToolButton {
  icon: string = '';
  toolName: string = '';
  selectedTool: string = '';
  onClick: () => void = () => {};

  build() {
    Button({ type: ButtonType.Normal }) {
      Text(this.icon)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.toolName === this.selectedTool ? AppColors.onSecondary : AppColors.onSurface)
    }
    .width(40)
    .height(40)
    .backgroundColor(this.toolName === this.selectedTool ? AppColors.secondary : AppColors.surfaceVariant)
    .borderRadius(20)
    .onClick(() => {
      this.onClick();
    })
  }
}

@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  pages: number[] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  build() {
    Column() {
      // Top Bar (CenterAlignedTopAppBar)
      Row() {
        Button({ type: ButtonType.Normal }) {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.surfaceVariant)
        }

        Blank()

        Text('Document.pdf')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onBackground)

        Blank()

        Button({ type: ButtonType.Normal }) {
          Text('Share')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onPrimary)
            .padding({ top: AppSpacing.xs, bottom: AppSpacing.xs, left: AppSpacing.sm, right: AppSpacing.sm })
        }
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(56)
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)

      // Main content area (Row)
      Row() {
        // 左侧：页面网格 (LazyVerticalGrid)
        Grid() {
          ForEach(this.pages, (page: number) => {
            GridItem() {
              Button({ type: ButtonType.Normal }) {
                Text('' + page)
                  .fontSize(AppTypography.labelSize)
                  .fontWeight(AppTypography.labelWeight)
                  .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
              }
              .width('100%')
              .aspectRatio(0.7)
              .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .border({ width: this.selectedPage === page ? 2 : 0, color: AppColors.primary })
              .onClick(() => {
                this.selectedPage = page;
              })
            }
          }, (page: number) => '' + page)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.sm)
        .rowsGap(AppSpacing.sm)
        .width(150)
        .padding(AppSpacing.sm)

        // 右侧：主文档视图 (Box)
        Stack({ alignContent: Alignment.Center }) {
          // 主文档卡片
          Column() {
            Text('Page ' + this.selectedPage)
              .fontSize(AppTypography.headlineSize)
              .fontWeight(AppTypography.headlineWeight)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({ radius: AppShadows.level1Radius, color: AppShadows.level1Color, offsetX: 0, offsetY: AppShadows.level1Dy })

          // 注释工具列
          Column() {
            Column() {
              AnnotationToolButton({ icon: 'P', toolName: 'pen', selectedTool: this.selectedTool, onClick: () => { this.selectedTool = 'pen'; } })
              AnnotationToolButton({ icon: 'H', toolName: 'highlighter', selectedTool: this.selectedTool, onClick: () => { this.selectedTool = 'highlighter'; } })
              AnnotationToolButton({ icon: 'T', toolName: 'text', selectedTool: this.selectedTool, onClick: () => { this.selectedTool = 'text'; } })
              AnnotationToolButton({ icon: 'S', toolName: 'shape', selectedTool: this.selectedTool, onClick: () => { this.selectedTool = 'shape'; } })
            }
            .space(AppSpacing.sm)
            .padding(AppSpacing.sm)
            .backgroundColor('#CCFFFFFF')
            .borderRadius(AppShapes.large)
            .border({ width: 1, color: AppColors.outline })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Start)
          .padding(AppSpacing.md)
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .space(AppSpacing.md)
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
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
