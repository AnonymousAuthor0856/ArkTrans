// Index.ets

// MARK: - AppTokens
interface IColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface ITypographyToken {
  size: number;
  weight: FontWeight;
}

interface ITypographyTokens {
  display: ITypographyToken;
  headline: ITypographyToken;
  title: ITypographyToken;
  body: ITypographyToken;
  label: ITypographyToken;
}

interface IShapes {
  small: number;
  medium: number;
  large: number;
}

interface ISpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface IShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface IElevationMapping {
  level1: IShadowSpec;
  level2: IShadowSpec;
  level3: IShadowSpec;
}

class AppTokens {
  // MARK: Colors
  static readonly Colors: IColors = {
    primary: '#FF2563EB',
    secondary: '#FF38BDF8',
    tertiary: '#FF3B82F6',
    background: '#FFF8FAFC',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFCBD5E1',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0F172A',
    onSurface: '#FF1E293B'
  }

  // MARK: TypographyTokens
  static readonly TypographyTokens: ITypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  // MARK: Shapes
  static readonly Shapes: IShapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  // MARK: Spacing
  static readonly Spacing: ISpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  }

  // MARK: ElevationMapping
  static readonly ElevationMapping: IElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 4, radius: 8, dy: 4, opacity: 0.14 },
    level3: { elevation: 8, radius: 12, dy: 6, opacity: 0.16 }
  }
}

// MARK: - RootScreen View
@Component
struct RootScreen {
  private topBarHeight: number = 64;
  private bottomBarHeight: number = 80;
  private fabSize: number = 56;

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      // 1. 主要内容层
      Column({ space: AppTokens.Spacing.lg }) {
        // 顶部占位符
        Blank().height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTokens.TypographyTokens.headline.size)
          .fontWeight(AppTokens.TypographyTokens.headline.weight)
          .fontColor(AppTokens.Colors.onSurface)

        // Workout Preview Box
        Text('Workout Preview')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
          .textAlign(TextAlign.Center)

        // Authenticate Button
        Button('Authenticate')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)

        // 将内容推向顶部
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.secondary, 0.1], [AppTokens.Colors.primary, 0.15]]
      })
      .backgroundColor(AppTokens.Colors.background)

      // 2. 自定义顶部栏层
      Column() {
        Text('Workout Plan')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: 0, y: 0 })

      // 3. 自定义底部栏层
      Row() {
        Text('Home')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Plan')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: `rgba(15, 23, 42, ${AppTokens.ElevationMapping.level2.opacity})`,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })
      .position({ x: 0, y: '100%' })
      .markAnchor({ x: 0, y: '100%' })

      // 4. 浮动操作按钮 (FAB) 层
      Button('+')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(this.fabSize / 2)
        .margin({ right: AppTokens.Spacing.lg, bottom: this.bottomBarHeight + AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - App Entry Point
@Entry
struct WorkoutPlanApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}