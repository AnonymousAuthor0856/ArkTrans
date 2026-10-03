// AppTokens
class AppColorsClass {
  primary: string = '#FF06B6D4';
  secondary: string = '#FF3B82F6';
  tertiary: string = '#FF8B5CF6';
  background: string = '#FFF0F9FF';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE0F2FE';
  outline: string = '#FFBAE6FD';
  success: string = '#FF22C55E';
  warning: string = '#FFFACC15';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FFFFFFFF';
  onBackground: string = '#FF0F172A';
  onSurface: string = '#FF0F172A';
}

class AppSpacingClass {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppShapesClass {
  small: number = 6;
  medium: number = 12;
  large: number = 20;
}

const AppColors = new AppColorsClass();
const AppSpacing = new AppSpacingClass();
const AppShapes = new AppShapesClass();

@Entry
@Component
struct RootScreen {
  @State spending: number = 500;
  private goal: number = 1000;

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Stack() {
        Text('Bill Calendar')
          .fontSize(28)
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
                .fontSize(18)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)
                .alignSelf(ItemAlign.Start)

              Blank()

              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.onSurface)
                .alignSelf(ItemAlign.Start)

              Blank()

              // Progress Bar
              Stack({ alignContent: Alignment.Start }) {
                // Track
                Row()
                  .width('100%')
                  .height(8)
                  .borderRadius(4)
                  .backgroundColor(AppColors.surfaceVariant)

                // Progress
                Row()
                  .width(`${Math.min((this.spending / this.goal) * 100, 100)}%`)
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
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .height(160)
          .borderRadius(AppShapes.large)
          .backgroundColor('#E6FFFFFF')
          .shadow({
            radius: 8,
            color: '#2E000000',
            offsetX: 0,
            offsetY: 4
          })

          // Adjust Spending Label
          Text('Adjust Spending')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .alignSelf(ItemAlign.Start)

          // Slider
          Column({ space: 0 }) {
            Slider({
              value: this.spending,
              min: 0,
              max: 2000,
              style: SliderStyle.OutSet
            })
              .trackColor(AppColors.surfaceVariant)
              .selectedColor(AppColors.primary)
              .blockColor(AppColors.secondary)
              .width('100%')
              .onChange((value: number) => {
                this.spending = value;
              })
          }
          .width('100%')
          .borderRadius(4)
          .backgroundColor('#80E0F2FE')

          // Reset Button
          Button('Reset')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .width('100%')
            .height(48)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.spending = 0;
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
          ['#FFF0F9FF', 0.5],
          ['#3306B6D4', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}