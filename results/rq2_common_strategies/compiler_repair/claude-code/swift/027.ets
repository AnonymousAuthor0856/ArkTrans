import promptAction from '@ohos.promptAction';

// MARK: - AppTokens Translation

namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#FFA0C4FF';
    export const secondary: ResourceColor = '#FFB7E4C7';
    export const tertiary: ResourceColor = '#FFFFDDC1';
    export const background: ResourceColor = '#FFF8F7FF';
    export const surface: ResourceColor = '#FFFFFFFF';
    export const surfaceVariant: ResourceColor = '#FFF0F0F5';
    export const outline: ResourceColor = '#FFD9D9E3';
    export const success: ResourceColor = '#FFB4E4C7';
    export const warning: ResourceColor = '#FFFFDDC1';
    export const error: ResourceColor = '#FFFFB4AB';
    export const onPrimary: ResourceColor = '#FF001D3D';
    export const onSecondary: ResourceColor = '#FF003720';
    export const onTertiary: ResourceColor = '#FF3E2800';
    export const onBackground: ResourceColor = '#FF1B1B1F';
    export const onSurface: ResourceColor = '#FF1B1B1F';
  }

  export namespace Typography {
    export const displaySize: number = 45;
    export const displayWeight: FontWeight = FontWeight.Bold;
    export const headlineSize: number = 24;
    export const headlineWeight: FontWeight = FontWeight.Medium;
    export const titleSize: number = 18;
    export const titleWeight: FontWeight = FontWeight.Medium;
    export const bodySize: number = 14;
    export const bodyWeight: FontWeight = FontWeight.Regular;
    export const labelSize: number = 12;
    export const labelWeight: FontWeight = FontWeight.Medium;
  }

  export namespace Shapes {
    export const small: number = 4;
    export const medium: number = 8;
    export const large: number = 12;
    export const circle: string = '50%';
  }

  export namespace Spacing {
    export const xs: Length = 4;
    export const sm: Length = 8;
    export const md: Length = 12;
    export const lg: Length = 16;
    export const xl: Length = 24;
  }

  export namespace Elevation {
    export const level1Radius: number = 2;
    export const level1Y: number = 1;
    export const level1Opacity: number = 0.08;
    export const level2Radius: number = 4;
    export const level2Y: number = 2;
    export const level2Opacity: number = 0.10;
    export const level3Radius: number = 8;
    export const level3Y: number = 4;
    export const level3Opacity: number = 0.12;
  }
}

// MARK: - AnnotationToolButton Component

@Component
struct AnnotationToolButton {
  @Link selectedTool: string;
  icon: string = '';
  toolName: string = '';

  private isSelected(): boolean {
    return this.toolName === this.selectedTool;
  }

  build() {
    Button(this.icon)
      .fontSize(17)
      .fontWeight(FontWeight.Bold)
      .fontColor(this.isSelected() ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .width(40)
      .height(40)
      .backgroundColor(this.isSelected() ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.circle)
      .type(ButtonType.Circle)
      .onClick(() => {
        this.selectedTool = this.toolName;
      })
  }
}

// MARK: - PageGridItem Component

@Component
struct PageGridItem {
  page: number = 1;
  @Link selectedPage: number;

  private isSelected(): boolean {
    return this.page === this.selectedPage;
  }

  build() {
    Text(this.page.toString())
      .fontSize(AppTokens.Typography.labelSize)
      .fontWeight(AppTokens.Typography.labelWeight)
      .fontColor(this.isSelected() ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .width('100%')
      .aspectRatio(0.7)
      .textAlign(TextAlign.Center)
      .backgroundColor(this.isSelected() ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .border({
        width: this.isSelected() ? 2 : 0,
        color: AppTokens.Colors.primary
      })
      .onClick(() => {
        this.selectedPage = this.page;
      })
  }
}

// MARK: - Page data model

interface PageItem {
  id: number;
  pageNum: number;
}

// MARK: - RootScreen Component

@Component
export struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';
  private pages: PageItem[] = [
    { id: 1, pageNum: 1 },
    { id: 2, pageNum: 2 },
    { id: 3, pageNum: 3 },
    { id: 4, pageNum: 4 },
    { id: 5, pageNum: 5 },
    { id: 6, pageNum: 6 },
    { id: 7, pageNum: 7 },
    { id: 8, pageNum: 8 },
    { id: 9, pageNum: 9 },
    { id: 10, pageNum: 10 },
    { id: 11, pageNum: 11 },
    { id: 12, pageNum: 12 }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon
        Circle()
          .width(24)
          .height(24)
          .fill(AppTokens.Colors.surfaceVariant)
          .onClick(() => {
            promptAction.showToast({ message: 'Navigation clicked', duration: 1000 });
          })

        Blank()

        Text('Document.pdf')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        // Share Button
        Button('Share')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .height('auto')
          .onClick(() => {
            promptAction.showToast({ message: 'Share clicked', duration: 1000 });
          })
      }
      .width('100%')
      .height(56)
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)

      // Main content area
      Row() {
        // Left side: page grid
        Grid() {
          ForEach(this.pages, (item: PageItem) => {
            GridItem() {
              PageGridItem({ page: item.pageNum, selectedPage: $selectedPage })
            }
          }, (item: PageItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.sm)
        .columnsGap(AppTokens.Spacing.sm)
        .width(150)
        .padding(AppTokens.Spacing.sm)
        .layoutDirection(GridDirection.Row)
        .height('100%')

        // Right side: document view with annotation tools
        Stack({ alignContent: Alignment.Start }) {
          // Main document card
          Text(`Page ${this.selectedPage}`)
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(AppTokens.Typography.headlineWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level1Radius,
              color: 'rgba(0, 0, 0, 0.08)',
              offsetY: AppTokens.Elevation.level1Y
            })

          // Annotation tools column
          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: $selectedTool
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: $selectedTool
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: $selectedTool
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: $selectedTool
            })
          }
          .width('auto')
          .padding(AppTokens.Spacing.sm)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .backgroundColor('rgba(255, 255, 255, 0.8)')
          .margin(AppTokens.Spacing.md)
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct SingleFileUIApp {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
