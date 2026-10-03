@Entry
@Component
struct RootScreen {
  // AppTokens - Colors
  private static readonly primary: string = '#2563EB'
  private static readonly secondary: string = '#38BDF8'
  private static readonly tertiary: string = '#60A5FA'
  private static readonly background: string = '#E6F0FF'
  private static readonly surface: string = '#FFFFFF'
  private static readonly surfaceVariant: string = '#E2E8F0'
  private static readonly outline: string = '#CBD5E1'
  private static readonly success: string = '#22C55E'
  private static readonly warning: string = '#F59E0B'
  private static readonly error: string = '#EF4444'
  private static readonly onPrimary: string = '#FFFFFF'
  private static readonly onSecondary: string = '#0F172A'
  private static readonly onTertiary: string = '#FFFFFF'
  private static readonly onBackground: string = '#0F172A'
  private static readonly onSurface: string = '#1E293B'

  // AppTokens - Spacing
  private static readonly spacingXs: number = 4
  private static readonly spacingSm: number = 8
  private static readonly spacingMd: number = 12
  private static readonly spacingLg: number = 16
  private static readonly spacingXl: number = 24
  private static readonly spacingXxl: number = 36

  // AppTokens - Shapes
  private static readonly shapeSmall: number = 8
  private static readonly shapeMedium: number = 12
  private static readonly shapeLarge: number = 16

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon (Left)
        Button() {
          // Action
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(RootScreen.primary)
        .margin({ left: RootScreen.spacingLg })

        Blank()

        // Title
        Text('Sleep Cycle')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(RootScreen.onBackground)

        Blank()

        // Actions Icon (Right)
        Button() {
          // Action
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(RootScreen.secondary)
        .margin({ right: RootScreen.spacingLg })
      }
      .width('100%')
      .height(56)
      .backgroundColor(RootScreen.surface)
      .alignItems(VerticalAlign.Center)

      // Main Content Area
      Column() {
        Blank()

        // Central Emoji Box
        Column() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor(RootScreen.surface)
        .border({
          width: 2,
          color: RootScreen.outline
        })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)

        // Welcome Back Text
        Text('Welcome Back')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(RootScreen.onSurface)
          .margin({ top: RootScreen.spacingXl })

        // Description Text
        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(RootScreen.onSurface)
          .textAlign(TextAlign.Center)
          .margin({ top: RootScreen.spacingSm })

        // Sign In Button
        Button() {
          // Action
        }
        .width('80%')
        .height(52)
        .backgroundColor(RootScreen.primary)
        .borderRadius(RootScreen.shapeLarge)
        .margin({ top: RootScreen.spacingXl })
        .justifyContent(FlexAlign.Center)

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({
        left: RootScreen.spacingLg,
        right: RootScreen.spacingLg
      })
      .backgroundColor(RootScreen.background)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(RootScreen.background)
  }
}