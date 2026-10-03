import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens Translation
const AppColors = {
  primary: '#A0C4FF',
  secondary: '#B7E4C7',
  tertiary: '#FFDDC1',
  background: '#F8F7FF',
  surface: '#FFFFFF',
  surfaceVariant: '#F0F0F5',
  outline: '#D9D9E3',
  success: '#B4E4C7',
  warning: '#FFDDC1',
  error: '#FFB4AB',
  onPrimary: '#001D3D',
  onSecondary: '#003720',
  onTertiary: '#3E2800',
  onBackground: '#1B1B1F',
  onSurface: '#1B1B1F',
};

const AppTypography = {
  display: { size: 45, weight: FontWeight.Bold },
  headline: { size: 24, weight: FontWeight.Medium },
  title: { size: 18, weight: FontWeight.Medium },
  body: { size: 14, weight: FontWeight.Normal },
  label: { size: 12, weight: FontWeight.Medium },
};

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
};

const AppElevation = {
  level1: { radius: 2, dy: 1, opacity: 0.08 },
  level2: { radius: 4, dy: 2, opacity: 0.10 },
  level3: { radius: 8, dy: 4, opacity: 0.12 },
};

// MARK: - Reusable Components

@Component
struct AnnotationToolButton {
  icon: string = '';
  toolName: string = '';
  @Link selectedTool: string;
  onClick: () => void = () => {};

  build() {
    Button() {
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
    .type(ButtonType.Normal)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State selectedPage: number = 1;
  @State selectedTool: string = 'pen';

  private pages: number[] = Array.from({ length: 12 }, (_, i) => i + 1);

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Row({ space: AppSpacing.sm }) {
        Button() {
          Circle()
            .width(24)
            .height(24)
            .fill(AppColors.surfaceVariant)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .width(24)
        .height(24)

        Blank()

        Text('Document.pdf')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onBackground)

        Blank()

        Button('Share')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(4)
          .padding({
            top: AppSpacing.xs,
            bottom: AppSpacing.xs,
            left: AppSpacing.sm,
            right: AppSpacing.sm
          })
          .type(ButtonType.Normal)
      }
      .width('100%')
      .height(56)
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Row({ space: AppSpacing.md }) {
        // Left side: Page grid
        Scroll() {
          Grid() {
            ForEach(this.pages, (page: number) => {
              GridItem() {
                Button() {
                  Stack({ alignContent: Alignment.Center }) {
                    Column()
                      .width('100%')
                      .aspectRatio(0.7)
                      .backgroundColor(this.selectedPage === page ? AppColors.primary : AppColors.surfaceVariant)
                      .borderRadius(8)
                      .border(this.selectedPage === page
                        ? { width: 2, color: AppColors.primary, radius: 8 }
                        : { width: 0, color: Color.Transparent, radius: 8 })

                    Text(page.toString())
                      .fontSize(AppTypography.label.size)
                      .fontWeight(AppTypography.label.weight)
                      .fontColor(this.selectedPage === page ? AppColors.onPrimary : AppColors.onSurface)
                  }
                  .width('100%')
                  .aspectRatio(0.7)
                }
                .type(ButtonType.Normal)
                .backgroundColor(Color.Transparent)
                .width('100%')
                .onClick(() => {
                  this.selectedPage = page;
                })
              }
            }, (page: number) => page.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.sm)
          .rowsGap(AppSpacing.sm)
          .width('100%')
          .padding(AppSpacing.sm)
        }
        .width(150)
        .height('100%')
        .scrollBar(BarState.Off)

        // Right side: Main document view
        Stack({ alignContent: Alignment.Center }) {
          // Main document card
          Stack({ alignContent: Alignment.Center }) {
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(12)
              .shadow({
                radius: AppElevation.level1.radius,
                color: `rgba(0,0,0,${AppElevation.level1.opacity})`,
                offsetX: 0,
                offsetY: AppElevation.level1.dy
              })

            Text(`Page ${this.selectedPage}`)
              .fontSize(AppTypography.headline.size)
              .fontWeight(AppTypography.headline.weight)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height('100%')

          // Annotation tools column
          Column({ space: AppSpacing.sm }) {
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
          .padding(AppSpacing.sm)
          .backgroundColor('rgba(255,255,255,0.8)')
          .borderRadius(12)
          .border({ width: 1, color: AppColors.outline, radius: 12 })
          .alignSelf(ItemAlign.Start)
          .margin({ left: AppSpacing.md, top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .layoutWeight(1)
        .height('100%')
      }
      .padding({ left: AppSpacing.md, right: AppSpacing.md })
      .width('100%')
      .layoutWeight(1)
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}