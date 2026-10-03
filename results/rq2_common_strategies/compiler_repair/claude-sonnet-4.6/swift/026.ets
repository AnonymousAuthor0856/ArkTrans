// AppTokens
class AppColorsClass {
  primary: number = 0xFF38BDF8;
  secondary: number = 0xFFA78BFA;
  tertiary: number = 0xFF7DD3FC;
  background: number = 0xFFF1F5F9;
  surface: number = 0xFFFFFFFF;
  surfaceVariant: number = 0xFFE2E8F0;
  outline: number = 0xFFCBD5E1;
  success: number = 0xFF22C55E;
  warning: number = 0xFFF59E0B;
  error: number = 0xFFEF4444;
  onPrimary: number = 0xFFFFFFFF;
  onSecondary: number = 0xFF1E1E1E;
  onTertiary: number = 0xFF1E1E1E;
  onBackground: number = 0xFF1E1E1E;
  onSurface: number = 0xFF1E1E1E;
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
  @State scrollOffsetY: number = 0;

  build() {
    Column() {
      // Top App Bar
      Text('Glass Doc Reader')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({
          top: 20,
          bottom: AppSpacing.lg,
          left: AppSpacing.lg,
          right: AppSpacing.lg
        })
        .backgroundColor(AppColors.background)

      // Main content area
      Stack({ alignContent: Alignment.Center }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [0xCCE2E8F0, 0.0],
              [0xFFF1F5F9, 0.5],
              [0xCCE2E8F0, 1.0],
            ]
          })

        // Document card
        Column({ space: AppSpacing.md }) {
          Text('Document Reader')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .width('100%')

          ForEach([0, 1, 2, 3, 4, 5, 6, 7], (index: number) => {
            Text(`This is a sample line of text content number ${index + 1}.`)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
              .width('100%')
          })

          Blank()
        }
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .width('90%')
        .height(400)
        .backgroundColor('rgba(255,255,255,0.7)')
        .borderRadius(AppShapes.large)
        .shadow({
          color: 'rgba(0,0,0,0.18)',
          radius: 8,
          offsetX: 0,
          offsetY: 4,
        })
        .translate({ y: this.scrollOffsetY / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.scrollOffsetY = event.offsetY;
            })
            .onActionEnd(() => {
              // keep last offset
            })
        )
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}