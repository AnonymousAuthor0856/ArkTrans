// 将 SwiftUI 源文件翻译为 ArkTS（HarmonyOS ArkUI）。
// 原文使用 SwiftUI 的 View/App/PreviewProvider 结构，这里映射为 ArkUI 的 @Component/@Entry/@Preview。

// MARK: - AppTokens
// 复制 Kotlin 的 AppTokens 结构，确保颜色、字体、形状和间距的原子级对应。
// ArkTS 不支持 Swift 的嵌套 struct 静态成员，因此将各嵌套 struct 拆分为独立的顶层 class。

// MARK: Colors
class AppColors {
  // 使用 #AARRGGBB 十六进制字符串创建颜色，与 Kotlin 0xFF... 格式的 Hex 值对应
  static readonly primary: string = '#FF2563EB';
  static readonly secondary: string = '#FF38BDF8';
  static readonly tertiary: string = '#FF3B82F6';
  static readonly background: string = '#FFF8FAFC';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFE2E8F0';
  static readonly outline: string = '#FFCBD5E1';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF0F172A';
  static readonly onTertiary: string = '#FFFFFFFF';
  static readonly onBackground: string = '#FF0F172A';
  static readonly onSurface: string = '#FF1E293B';
}

// MARK: TypographyTokens
// 将 Compose 的 TextStyle 映射到 ArkUI 的字号与字重
class FontToken {
  size: number;
  weight: FontWeight;
  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypography {
  static readonly display: FontToken = new FontToken(28, FontWeight.Bold);
  static readonly headline: FontToken = new FontToken(20, FontWeight.Medium); // SwiftUI .semibold → ArkUI 无 semibold，取 Medium 近似
  static readonly title: FontToken = new FontToken(16, FontWeight.Medium);
  static readonly body: FontToken = new FontToken(14, FontWeight.Regular);
  static readonly label: FontToken = new FontToken(12, FontWeight.Medium);
}

// MARK: Shapes
// 将 Compose 的 RoundedCornerShape 映射到 number（vp）
class AppShapes {
  static readonly small: number = 8; // 8.dp
  static readonly medium: number = 12; // 12.dp
  static readonly large: number = 16; // 16.dp
}

// MARK: Spacing
// 将 Compose 的 Dp 映射到 number（vp）
class AppSpacing {
  static readonly xs: number = 4; // 4.dp
  static readonly sm: number = 8; // 8.dp
  static readonly md: number = 12; // 12.dp
  static readonly lg: number = 16; // 16.dp
  static readonly xl: number = 24; // 24.dp
  static readonly xxl: number = 36; // 36.dp
}

// MARK: ElevationMapping
// 复制 ShadowSpec，用于模拟 Compose 的 tonalElevation
class ShadowSpec {
  elevation: number; // 阴影在 Z 轴上的偏移（通常影响强度和扩散）
  radius: number; // 阴影的模糊半径
  dy: number; // 阴影在 Y 轴上的偏移
  opacity: number; // 阴影的不透明度
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

// MARK: - RootScreen View (ContentView)
// 对应 Kotlin 的 RootScreen Composable 函数
@Component
struct RootScreen {
  // 定义常量以匹配 Material Design 组件的默认尺寸，确保布局一致性
  private topBarHeight: number = 64; // 对应 Compose CenterAlignedTopAppBar 的默认高度
  private bottomBarHeight: number = 80; // 对应 Compose BottomAppBar 的默认高度
  private fabSize: number = 56; // 对应 Compose FloatingActionButton 的默认尺寸

  build() {
    // 使用 Stack 来模拟 Scaffold 的分层布局：内容层、顶部栏、底部栏、浮动按钮
    Stack() {
      // 1. 主要内容层：填充整个屏幕，但为顶部和底部栏预留空间
      Column({ space: AppSpacing.lg }) { // Column 的 verticalArrangement = spacedBy(AppSpacing.lg)
        // 顶部占位符，避免内容被自定义顶部栏遮挡
        Blank().height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTypography.headline.size)
          .fontWeight(AppTypography.headline.weight)
          .fontColor(AppColors.onSurface)

        // Workout Preview Box
        Stack() { // 对应 Box
          Text('Workout Preview')
            .fontSize(AppTypography.body.size)
            .fontWeight(AppTypography.body.weight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%') // fillMaxWidth()
        .height(200) // height(200.dp)
        .backgroundColor(AppColors.surface) // background(AppColors.surface)
        .borderRadius(AppShapes.large) // shape = AppShapes.large
        .border({ width: 1, color: AppColors.outline }) // border(1.dp, AppColors.outline, AppShapes.large)

        // Authenticate Button
        Button() {
          Text('Authenticate')
            .fontSize(AppTypography.title.size)
            .fontWeight(AppTypography.title.weight)
            .fontColor(AppColors.onPrimary) // contentColor
        }
        .type(ButtonType.Normal)
        .width('80%') // fillMaxWidth(0.8f)
        .height(52) // height(52.dp)
        .backgroundColor(AppColors.primary) // containerColor
        .borderRadius(AppShapes.large) // shape
        // 注意：在 SwiftUI 中，Button 的 frame 和 background 顺序很重要，先设置 Text 的 frame 和背景，
        // 再设置 Button 的 frame 和背景。ArkUI 的 Button 已自带 label 容器，因此背景、圆角直接应用于 Button 本身。

        Blank() // 将内容推向顶部，保持垂直居中或顶部对齐
      }
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: this.bottomBarHeight }) // Column 的 padding(AppSpacing.lg) 与为底部栏预留空间
      .width('100%')
      .height('100%') // fillMaxSize()
      // background(Brush.verticalGradient(...))：secondary.copy(alpha=0.1) → primary.copy(alpha=0.15)
      .linearGradient({
        angle: 180,
        colors: [['#1A38BDF8', 0.0], ['#262563EB', 1.0]]
      })

      // 2. 自定义顶部栏层
      Column() {
        Column() { // 对应 CenterAlignedTopAppBar
          Text('Workout Plan')
            .fontSize(AppTypography.display.size)
            .fontWeight(AppTypography.display.weight)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .height(this.topBarHeight)
        .backgroundColor(AppColors.surface)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Start) // 将顶部栏对齐到 Stack 的顶部

      // 3. 自定义底部栏层
      Column() {
        Column() { // 对应 BottomAppBar
          Row() { // spacing: 0，因为 SpaceBetween 管理间距
            Text('Home')
              .fontSize(AppTypography.title.size)
              .fontWeight(AppTypography.title.weight)
              .fontColor(AppColors.primary) // Home 是选中状态，使用 primary 颜色
            Text('Plan')
              .fontSize(AppTypography.title.size)
              .fontWeight(AppTypography.title.weight)
              .fontColor(AppColors.onSurface)
            Text('Profile')
              .fontSize(AppTypography.title.size)
              .fontWeight(AppTypography.title.weight)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween) // Arrangement.SpaceBetween
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg }) // padding(horizontal = AppSpacing.lg)
          .height(this.bottomBarHeight) // 设置底部栏高度
        }
        .width('100%')
        .backgroundColor(AppColors.surface) // containerColor
        // 模拟 tonalElevation，使用 shadow 修饰符（onBackground.opacity(level2.opacity)）
        .shadow({
          radius: AppElevation.level2.radius,
          color: '#240F172A',
          offsetY: AppElevation.level2.dy
        })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End) // 将底部栏对齐到 Stack 的底部

      // 4. 浮动操作按钮 (FAB) 层
      Column() {
        Button() { // 对应 FloatingActionButton
          Text('+')
            .fontSize(AppTypography.display.size)
            .fontWeight(AppTypography.display.weight)
            .fontColor(AppColors.onPrimary) // contentColor
        }
        .type(ButtonType.Circle) // shape = CircleShape
        .width(this.fabSize)
        .height(this.fabSize) // 尺寸
        .backgroundColor(AppColors.primary) // containerColor
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
      .alignItems(HorizontalAlign.End)
      // 定位 FAB：距离右侧 AppSpacing.lg，距离底部 (bottomBarHeight + AppSpacing.lg)
      // 这样 FAB 会在底部栏上方，并与屏幕边缘保持 AppSpacing.lg 的间距
      .padding({ right: AppSpacing.lg, bottom: this.bottomBarHeight + AppSpacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background) // 整个 Stack 的背景色
    // 让内容填充整个屏幕，忽略安全区（对应 statusBarHidden(true) 的全屏沉浸式效果）
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity 和 AppTheme，以及 SwiftUI 的 @main WorkoutPlanApp: App
@Entry
@Component
struct WorkoutPlanApp {
  build() {
    // @Entry 组件的 build 根节点必须是内置容器组件，因此用 Stack 包裹页面内容 RootScreen。
    // 再次确认隐藏状态栏（通过 expandSafeArea 在 RootScreen 内实现），确保在整个应用生命周期内生效
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// 预览提供一个 Xcode Canvas 预览（对应 RootScreen_Previews: PreviewProvider）
@Preview
@Component
struct RootScreenPreview {
  build() {
    Stack() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
