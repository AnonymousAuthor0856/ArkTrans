import { display } from '@kit.ArkUI';

// AppTokens - using classes instead of object literals
class AppColorsClass {
  primary: string = '#FF2563EB';
  secondary: string = '#FF38BDF8';
  tertiary: string = '#FF3B82F6';
  background: string = '#FFF8FAFC';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE2E8F0';
  outline: string = '#FFCBD5E1';
  success: string = '#FF22C55E';
  warning: string = '#FFF59E0B';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FF0F172A';
  onTertiary: string = '#FFFFFFFF';
  onBackground: string = '#FF0F172A';
  onSurface: string = '#FF1E293B';
}

class AppSpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

class AppShapesClass {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

const AppColors = new AppColorsClass();
const AppSpacing = new AppSpacingClass();
const AppShapes = new AppShapesClass();

const topBarHeight: number = 64;
const bottomBarHeight: number = 80;
const fabSize: number = 56;

@Entry
@Component
struct RootScreen {
  @State screenWidth: number = 0;

  aboutToAppear() {
    const displayInfo = display.getDefaultDisplaySync();
    this.screenWidth = px2vp(displayInfo.width);
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 1. Main content layer
      Column({ space: AppSpacing.lg }) {
        // Top spacer
        Row()
          .height(topBarHeight)

        Text('Sign In to Continue')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.large
        })

        // Authenticate Button
        Button() {
          Text('Authenticate')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
        .width('80%')
        .height(52)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.large)
        .onClick(() => {})

        Blank()
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#1A38BDF8', 0.0],
          ['#262563EB', 1.0]
        ]
      })
      .backgroundColor(AppColors.background)
      .padding({ bottom: bottomBarHeight })
      .alignItems(HorizontalAlign.Center)

      // 2. Top Bar
      Row() {
        Text('Workout Plan')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(topBarHeight)
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.Center)
      .position({ x: 0, y: 0 })
      .zIndex(10)

      // 3. Bottom Bar
      Row({ space: 0 }) {
        Text('Home')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .layoutWeight(1)

        Text('Plan')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .layoutWeight(1)

        Text('Profile')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .width('100%')
      .height(bottomBarHeight)
      .backgroundColor(AppColors.surface)
      .shadow({
        color: '#290F172A',
        radius: 8,
        offsetY: 4
      })
      .position({ x: 0, y: 0 })
      .markAnchor({ x: 0, y: '-100%' })
      .zIndex(10)
      .alignItems(VerticalAlign.Center)

      // 4. FAB
      Button() {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
      }
      .width(fabSize)
      .height(fabSize)
      .backgroundColor(AppColors.primary)
      .borderRadius(fabSize / 2)
      .margin({
        right: AppSpacing.lg,
        bottom: bottomBarHeight + AppSpacing.lg
      })
      .zIndex(20)
      .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}