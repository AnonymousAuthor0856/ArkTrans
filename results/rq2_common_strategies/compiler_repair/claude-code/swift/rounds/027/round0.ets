import promptAction from '@ohos.promptAction';

// MARK: - AppTokens Translation
// Design tokens for consistent UI elements: colors, typography, shapes, spacing, elevation.

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
    export function display(): FontAttr {
      return { size: 45, weight: FontWeight.Bold };
    }
    export function headline(): FontAttr {
      return { size: 24, weight: FontWeight.Medium };
    }
    export function title(): FontAttr {
      return { size: 18, weight: FontWeight.Medium };
    }
    export function body(): FontAttr {
      return { size: 14, weight: FontWeight.Regular };
    }
    export function label(): FontAttr {
      return { size: 12, weight: FontWeight.Medium };
    }
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
    export const level1 = { radius: 2, y: 1, opacity: 0.08 };
    export const level2 = { radius: 4, y: 2, opacity: 0.10 };
    export const level3 = { radius: 8, y: 4, opacity: 0.12 };
  }
}

interface FontAttr {
  size: number;
  weight: number | FontWeight;
}

// MARK: - AnnotationToolButton Component
// A reusable circular button for annotation tools.

@Component
struct AnnotationToolButton {
  @Link selectedTool: string;
  icon: string = '';
  toolName: string = '';
  onClick: () => void = () => {};

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
        this.onClick();
      })
  }
}

// MARK: - PageGridItem Component
// A single page thumbnail in the grid.

@Component
struct PageGridItem {
  page: number = 1;
  @Link selectedPage: number;

  private isSelected(): boolean {
    return this.page === this.selectedPage;
  }

  build() {
    Text(this.page.toString())
      .fontSize(AppTokens.Typography.label().size)
      .fontWeight(AppTokens.Typography.label().weight as FontWeight)
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

// MARK: - RootScreen Component
// The main UI screen.

@Component
export struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';

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
          .fontSize(AppTokens.Typography.title().size)
          .fontWeight(AppTokens.Typography.title().weight as FontWeight)
          .fontColor(AppTokens.Colors.onBackground)

        Blank()

        // Share Button
        Button('Share')
          .fontSize(AppTokens.Typography.label().size)
          .fontWeight(AppTokens.Typography.label().weight as FontWeight)
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
          ForEach(Array.from({ length: 12 }, (_, i) => i + 1), (page: number) => {
            GridItem() {
              PageGridItem({ page: page, selectedPage: $selectedPage })
            }
          }, (page: number) => page.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.sm)
        .columnsGap(AppTokens.Spacing.sm)
        .width(150)
        .padding(AppTokens.Spacing.sm)
        .layoutDirection(GridDirection.Row)
        .height('100%')

        // Right side: document view with annotation tools
        Stack({ alignContent: Alignment.CenterStart }) {
          // Main document card
          Text(`Page ${this.selectedPage}`)
            .fontSize(AppTokens.Typography.headline().size)
            .fontWeight(AppTokens.Typography.headline().weight as FontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%')
            .height('100%')
            .textAlign(TextAlign.Center)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.Elevation.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
              offsetY: AppTokens.Elevation.level1.y
            })

          // Annotation tools column
          Column() {
            AnnotationToolButton({
              icon: 'P',
              toolName: 'pen',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'pen'; }
            })
            AnnotationToolButton({
              icon: 'H',
              toolName: 'highlighter',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'highlighter'; }
            })
            AnnotationToolButton({
              icon: 'T',
              toolName: 'text',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'text'; }
            })
            AnnotationToolButton({
              icon: 'S',
              toolName: 'shape',
              selectedTool: $selectedTool,
              onClick: () => { this.selectedTool = 'shape'; }
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
    RootScreen()
  }
}
