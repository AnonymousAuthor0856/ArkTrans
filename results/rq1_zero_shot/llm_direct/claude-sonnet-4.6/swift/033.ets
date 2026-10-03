import { router } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FF06B6D4';
  static readonly secondary: string = '#FF3B82F6';
  static readonly tertiary: string = '#FF8B5CF6';
  static readonly background: string = '#FFF0F9FF';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE0F2FE';
  static readonly outline: string = '#FFBAE6FD';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFFACC15';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FFFFFFFF';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FF0F172A';
  static readonly onSurface: string = '#FF0F172A';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

@Entry
@Component
struct RootScreen {
  @State spending: number = 500.0;
  private goal: number = 1000.0;

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Stack() {
        Text('Bill Calendar')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.background)
      .alignContent(Alignment.Center)

      // Main Content
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          // Surface Card
          Stack() {
            Column({ space: 0 }) {
              Text('Current Spending')
                .fontSize(AppTypography.titleSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)

              Blank()

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(AppTypography.displaySize)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)

              Blank()

              // Linear Progress Indicator
              Stack({ alignContent: Alignment.Start }) {
                // Track
                Row()
                  .width('100%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(AppColors.surfaceVariant)

                // Progress
                Row()
                  .width(`${(this.spending / this.goal) * 100}%`)
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(AppColors.primary)
              }
              .width('100%')
              .height(8)
            }
            .width('100%')
            .height('100%')
            .padding(AppSpacing.lg)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .height(160)
          .borderRadius(AppShapes.large)
          .backgroundColor('#E6FFFFFF')
          .shadow({
            radius: 8,
            color: '#1F000000',
            offsetX: 0,
            offsetY: 4
          })

          // Adjust Spending Label
          Text('Adjust Spending')
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            style: SliderStyle.OutSet
          })
            .width('100%')
            .trackColor(AppColors.surfaceVariant)
            .selectedColor(AppColors.primary)
            .blockColor(AppColors.secondary)
            .onChange((value: number) => {
              this.spending = value;
            })

          // Reset Button
          Button('Reset')
            .width('100%')
            .height(48)
            .fontSize(AppTypography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.spending = 0.0;
            })
        }
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#4D3B82F6', 0.0],
          [AppColors.background, 0.5],
          ['#3306B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}