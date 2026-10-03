class AppColors {
  static readonly primary: string = '#111827'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly secondary: string = '#6B7280'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly tertiary: string = '#2563EB'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly background: string = '#F9FAFB'
  static readonly onBackground: string = '#0B1220'
  static readonly surface: string = '#FFFFFF'
  static readonly onSurface: string = '#111827'
  static readonly surfaceVariant: string = '#F3F4F6'
  static readonly outline: string = '#E5E7EB'
  static readonly error: string = '#DC2626'
}

class AppTypography {
  static readonly displayFontSize: number = 22
  static readonly displayFontWeight: FontWeight = FontWeight.Medium
  static readonly displayLineHeight: number = 28
  static readonly headlineFontSize: number = 16
  static readonly headlineFontWeight: FontWeight = FontWeight.Medium
  static readonly headlineLineHeight: number = 22
  static readonly titleFontSize: number = 14
  static readonly titleFontWeight: FontWeight = FontWeight.Medium
  static readonly titleLineHeight: number = 18
  static readonly bodyFontSize: number = 12
  static readonly bodyFontWeight: FontWeight = FontWeight.Normal
  static readonly bodyLineHeight: number = 16
  static readonly labelFontSize: number = 10
  static readonly labelFontWeight: FontWeight = FontWeight.Medium
  static readonly labelLineHeight: number = 14
}

class AppShapes {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 12
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

@Entry
@Component
struct AuthLogin {
  @State email: string = ''
  @State password: string = ''

  build() {
    Column() {
      Column() {
        Text('Sign in')
          .fontSize(AppTypography.displayFontSize)
          .fontWeight(AppTypography.displayFontWeight)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column() {
          this.WelcomeCard()
          this.DividerRow()
          this.SocialButtons()

          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTypography.labelFontSize)
            .fontWeight(AppTypography.labelFontWeight)
            .fontColor(AppColors.secondary)
            .margin({ top: AppSpacing.sm, bottom: AppSpacing.sm })

          this.HelpSurface()
        }
        .width('100%')
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  WelcomeCard() {
    Column() {
      Text('Welcome back')
        .fontSize(AppTypography.headlineFontSize)
        .fontWeight(AppTypography.headlineFontWeight)
        .fontColor(AppColors.onSurface)

      Column() {
        Text('Email')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ bottom: AppSpacing.md })

        TextInput({ placeholder: '', text: this.email })
          .width('100%')
          .height(44)
          .type(InputType.Normal)
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppShapes.medium
          })
          .padding({ left: 12, right: 12 })
          .fontSize(AppTypography.bodyFontSize)
          .onChange((value: string) => {
            this.email = value
          })

        Text('Password')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.lg, bottom: AppSpacing.md })

        TextInput({ placeholder: '', text: this.password })
          .width('100%')
          .height(44)
          .type(InputType.Password)
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppShapes.medium
          })
          .padding({ left: 12, right: 12 })
          .fontSize(AppTypography.bodyFontSize)
          .onChange((value: string) => {
            this.password = value
          })

        Row() {
          Text('Forgot password?')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary)

          Text('Create account')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: AppSpacing.sm })

        Button('Sign in')
          .width('100%')
          .height(44)
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(AppShapes.medium)
          .margin({ top: AppSpacing.lg })
          .onClick(() => {})
      }
      .width('100%')
      .margin({ top: AppSpacing.lg })
    }
    .width('100%')
    .padding(AppSpacing.xl)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.14)',
      offsetY: 1
    })
  }

  @Builder
  DividerRow() {
    Row() {
      Divider()
        .vertical(false)
        .strokeWidth(1)
        .color(AppColors.outline)
        .layoutWeight(1)

      Text('Or continue with')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ left: AppSpacing.md, right: AppSpacing.md })

      Divider()
        .vertical(false)
        .strokeWidth(1)
        .color(AppColors.outline)
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({
      top: AppSpacing.xl + AppSpacing.lg,
      bottom: AppSpacing.xl + AppSpacing.lg
    })
  }

  @Builder
  SocialButtons() {
    Column() {
      Button('Continue with Apple')
        .width('100%')
        .height(40)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .onClick(() => {})

      Button('Continue with Google')
        .width('100%')
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .fontColor(AppColors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .margin({ top: AppSpacing.sm })
        .onClick(() => {})

      Button('Continue with GitHub')
        .width('100%')
        .height(40)
        .backgroundColor(AppColors.secondary)
        .fontColor(AppColors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .margin({ top: AppSpacing.sm })
        .onClick(() => {})
    }
    .width('100%')
  }

  @Builder
  HelpSurface() {
    Row() {
      Column() {
        Text('Need help?')
          .fontSize(AppTypography.titleFontSize)
          .fontWeight(AppTypography.titleFontWeight)
          .fontColor(AppColors.onSurface)

        Text('Contact support@example.com')
          .fontSize(AppTypography.bodyFontSize)
          .fontWeight(AppTypography.bodyFontWeight)
          .fontColor(AppColors.onSurface)
          .margin({ top: AppSpacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Support')
        .height(36)
        .backgroundColor(AppColors.tertiary)
        .fontColor(AppColors.onTertiary)
        .fontSize(AppTypography.titleFontSize)
        .fontWeight(FontWeight.Medium)
        .borderRadius(AppShapes.medium)
        .padding({ left: 24, right: 24 })
        .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
  }
}
