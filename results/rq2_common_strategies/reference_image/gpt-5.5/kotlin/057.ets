const NAME: string = '086_SleepCycle_en'
const UI_TYPE: string = 'Health Auth'
const STYLE_THEME: string = 'Modern Blue'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class AppColors {
  static readonly primary: string = '#2563EB'
  static readonly secondary: string = '#38BDF8'
  static readonly tertiary: string = '#60A5FA'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#E2E8F0'
  static readonly outline: string = '#CBD5E1'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#0F172A'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#1E293B'
  static readonly secondaryGradient: string = '#2638BDF8'
  static readonly primaryGradient: string = '#1A2563EB'
}

class AppTypography {
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 16
  static readonly body: number = 14
  static readonly label: number = 12
}

class AppShape {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 36
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14)
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16)
}

@Component
struct CircleIconButton {
  symbol: string = ''
  bg: string = AppColors.primary
  fg: string = AppColors.onPrimary

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.symbol)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.fg)
        .textAlign(TextAlign.Center)
    }
    .width(24)
    .height(24)
    .borderRadius(12)
    .backgroundColor(this.bg)
    .onClick(() => {
    })
  }
}

@Component
struct TopAppBar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Sleep Cycle')
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)

      Row() {
        CircleIconButton({
          symbol: '<',
          bg: AppColors.primary,
          fg: AppColors.onPrimary
        })

        CircleIconButton({
          symbol: '?',
          bg: AppColors.secondary,
          fg: AppColors.onSecondary
        })
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct SleepAvatar {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text('😴')
        .fontSize(48)
        .textAlign(TextAlign.Center)
    }
    .width(160)
    .height(160)
    .borderRadius(80)
    .backgroundColor(AppColors.surface)
    .border({
      width: 2,
      color: AppColors.outline
    })
  }
}

@Component
struct SignInButton {
  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text('Sign In')
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
    }
    .width('80%')
    .height(52)
    .borderRadius(AppShape.large)
    .backgroundColor(AppColors.primary)
    .onClick(() => {
    })
  }
}

@Component
struct RootScreen {
  build() {
    Column() {
      TopAppBar()

      Column({ space: AppSpacing.xl }) {
        SleepAvatar()

        Text('Welcome Back')
          .fontSize(AppTypography.headline)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        SignInButton()
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppColors.secondaryGradient, 0.0],
          [AppColors.primaryGradient, 1.0]
        ]
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}