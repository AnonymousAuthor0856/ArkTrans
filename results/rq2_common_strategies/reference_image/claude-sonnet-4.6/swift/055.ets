// WorkoutPlanPage.ets
// SwiftUI RootScreen → ArkTS (ArkUI 声明式) 等价实现

// MARK: - AppTokens

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#3B82F6';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

// TypographyTokens：SwiftUI Font.system(size:weight:) → fontSize + fontWeight
class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;

  static readonly displayWeight: FontWeight = FontWeight.Bold;      // .bold
  static readonly headlineWeight: FontWeight = FontWeight.Medium;   // .semibold(600)
  static readonly titleWeight: FontWeight = FontWeight.Medium;      // .medium(500)
  static readonly bodyWeight: FontWeight = FontWeight.Regular;      // .regular
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

// ElevationMapping：Compose tonalElevation → ArkUI shadow
// 注意 ArkUI 中 offsetY 为屏幕坐标正向朝下，底部栏需要向上投影，故取负值。
class AppShadow {
  static readonly level1Radius: number = 4;
  static readonly level1OffsetY: number = 2;
  static readonly level1Color: string = '#1F0F172A';   // 0.12 alpha

  static readonly level2Radius: number = 8;
  static readonly level2OffsetY: number = 4;
  static readonly level2Color: string = '#240F172A';   // 0.14 alpha

  static readonly level3Radius: number = 12;
  static readonly level3OffsetY: number = 6;
  static readonly level3Color: string = '#290F172A';   // 0.16 alpha
}

@Entry
@Component
struct WorkoutPlanPage {
  // Material 默认尺寸常量（与 Compose 对齐）
  private readonly topBarHeight: number = 64;
  private readonly bottomBarHeight: number = 80;
  private readonly fabSize: number = 56;

  // MARK: - 1. CenterAlignedTopAppBar
  @Builder
  TopBar() {
    Column() {
      Text('Workout Plan')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onBackground)
    }
    .width('100%')
    .height(this.topBarHeight)
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.Center)
  }

  // MARK: - 2. 主内容（Column + verticalGradient）
  @Builder
  MainContent() {
    Column({ space: AppSpacing.lg }) {
      Text('Sign In to Continue')
        .fontSize(AppTypography.headlineSize)
        .fontWeight(AppTypography.headlineWeight)
        .fontColor(AppColors.onSurface)

      // Workout Preview Box → Box + background + border
      Column() {
        Text('Workout Preview')
          .fontSize(AppTypography.bodySize)
          .fontWeight(AppTypography.bodyWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(200)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .border({ width: 1, color: AppColors.outline })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // Authenticate Button → Button，width 为 fillMaxWidth(0.8f)
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Authenticate')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onPrimary)
      }
      .width('80%')
      .height(52)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.large)
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    // Brush.verticalGradient(secondary.copy(0.1f) → primary.copy(0.15f))
    .linearGradient({
      angle: 180, // 自上而下
      colors: [
        ['#1A38BDF8', 0.0], // secondary @ 10%
        ['#262563EB', 1.0]  // primary   @ 15%
      ]
    })
    .backgroundColor(AppColors.background)
  }

  // MARK: - 3. BottomAppBar
  @Builder
  BottomBar() {
    Row() {
      // Home 为选中态，且占满剩余空间居中（对应 SwiftUI 的 frame(maxWidth: .infinity)）
      Text('Home')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.primary)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Text('Plan')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)

      Text('Profile')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)
        .margin({ left: AppSpacing.lg })
    }
    .width('100%')
    .height(this.bottomBarHeight)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: AppShadow.level2Radius,
      color: AppShadow.level2Color,
      offsetX: 0,
      offsetY: -AppShadow.level2OffsetY // 向上投影
    })
  }

  // MARK: - 4. FloatingActionButton
  @Builder
  Fab() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text('+')
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(AppColors.onPrimary)
    }
    .width(this.fabSize)
    .height(this.fabSize)
    .backgroundColor(AppColors.primary)
    .borderRadius(this.fabSize / 2)
    .shadow({
      radius: AppShadow.level3Radius,
      color: AppShadow.level3Color,
      offsetX: 0,
      offsetY: AppShadow.level3OffsetY
    })
  }

  build() {
    // ZStack → Stack；FAB 层用撑满的 Column 做右下角定位
    Stack({ alignContent: Alignment.TopStart }) {
      // 底层：Scaffold 的 containerColor
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.background)

      // Scaffold 内容：顶部栏 / 内容 / 底部栏
      Column() {
        this.TopBar()
        this.MainContent()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // FAB 层：对齐右下角，距右侧 lg，距底部 bottomBarHeight + lg
      Column() {
        this.Fab()
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.End)
      .padding({
        right: AppSpacing.lg,
        bottom: this.bottomBarHeight + AppSpacing.lg
      })
      .hitTestBehavior(HitTestMode.Transparent) // 不拦截下层点击
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    // 对应 statusBarHidden(true) / 沉浸式全屏：内容扩展进系统安全区
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}