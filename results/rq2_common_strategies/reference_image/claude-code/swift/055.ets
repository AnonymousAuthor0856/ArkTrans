// MARK: - AppTokens
class AppTokens {
  static Colors = class {
    static readonly primary: string = '#FF2563EB'
    static readonly secondary: string = '#FF38BDF8'
    static readonly tertiary: string = '#FF3B82F6'
    static readonly background: string = '#FFF8FAFC'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surfaceVariant: string = '#FFE2E8F0'
    static readonly outline: string = '#FFCBD5E1'
    static readonly success: string = '#FF22C55E'
    static readonly warning: string = '#FFF59E0B'
    static readonly error: string = '#FFEF4444'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FF0F172A'
    static readonly onTertiary: string = '#FFFFFFFF'
    static readonly onBackground: string = '#FF0F172A'
    static readonly onSurface: string = '#FF1E293B'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 28
    static readonly displayWeight: FontWeight = FontWeight.Bold
    static readonly headlineSize: number = 20
    static readonly headlineWeight: FontWeight = FontWeight.Medium
    static readonly titleSize: number = 16
    static readonly titleWeight: FontWeight = FontWeight.Medium
    static readonly bodySize: number = 14
    static readonly bodyWeight: FontWeight = FontWeight.Normal
    static readonly labelSize: number = 12
    static readonly labelWeight: FontWeight = FontWeight.Medium
  }

  static Shapes = class {
    static readonly small: Length = 8
    static readonly medium: Length = 12
    static readonly large: Length = 16
  }

  static Spacing = class {
    static readonly xs: Length = 4
    static readonly sm: Length = 8
    static readonly md: Length = 12
    static readonly lg: Length = 16
    static readonly xl: Length = 24
    static readonly xxl: Length = 36
  }
}

// MARK: - RootScreen Component
@Entry
@Component
struct RootScreen {
  private readonly topBarHeight: number = 64
  private readonly bottomBarHeight: number = 80
  private readonly fabSize: number = 56

  build() {
    Stack() {
      // 1. Main content layer
      Column() {
        // Top spacer for top bar
        Blank().height(this.topBarHeight)

        Text('Sign In to Continue')
          .fontSize(AppTokens.TypographyTokens.headlineSize)
          .fontWeight(AppTokens.TypographyTokens.headlineWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.lg })

        // Workout Preview Box
        Stack() {
          Text('Workout Preview')
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .border({
          width: 1,
          color: AppTokens.Colors.outline,
          radius: AppTokens.Shapes.large
        })
        .margin({ bottom: AppTokens.Spacing.lg })

        // Authenticate Button
        Button('Authenticate')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)

        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
      .background(this.gradientBg())
      .backgroundColor(AppTokens.Colors.background)
      .padding({ bottom: this.bottomBarHeight })

      // 2. Custom top bar layer
      Column() {
        Text('Workout Plan')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(this.topBarHeight)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .position({ x: 0, y: 0 })

      // 3. Custom bottom bar layer
      Row() {
        Text('Home')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.primary)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Plan')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Profile')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(this.bottomBarHeight)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({
        radius: 8,
        color: AppTokens.Colors.onBackground,
        offsetY: 4,
        opacity: 0.14
      })
      .position({ x: 0, y: 0 })
      .alignSelf(ItemAlign.End)

      // 4. Floating Action Button
      Button('+')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(this.fabSize)
        .height(this.fabSize)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(this.fabSize / 2)
        .position({
          x: 0,
          y: 0
        })
        .margin({
          right: AppTokens.Spacing.lg,
          bottom: this.bottomBarHeight + AppTokens.Spacing.lg
        })
        .alignSelf(ItemAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  gradientBg() {
    Column()
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.secondary, 0.1],
          [AppTokens.Colors.primary, 0.15]
        ]
      })
  }
}
