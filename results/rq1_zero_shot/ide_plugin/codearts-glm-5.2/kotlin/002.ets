const AppColors = {
  primary: '#111827',
  onPrimary: '#FFFFFF',
  secondary: '#6B7280',
  onSecondary: '#FFFFFF',
  tertiary: '#2563EB',
  onTertiary: '#FFFFFF',
  background: '#F9FAFB',
  onBackground: '#0B1220',
  surface: '#FFFFFF',
  onSurface: '#111827',
  surfaceVariant: '#F3F4F6',
  outline: '#E5E7EB',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626'
}

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 6,
  lg: 8,
  xl: 12,
  xxl: 16,
  xxxl: 24
}

interface SocialItem {
  label: string
  tint: string
}

@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''
  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: '#111827' },
    { label: 'Continue with Google', tint: '#2563EB' },
    { label: 'Continue with GitHub', tint: '#6B7280' }
  ]

  build() {
    Column() {
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.LoginCard()

          this.DividerRow()

          this.SocialButtons()

          this.TermsRow()

          Blank().height(AppSpacing.xxl)

          this.SupportCard()
        }
        .width('100%')
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  LoginCard() {
    Column({ space: AppSpacing.lg }) {
      Text('Welcome back')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Column({ space: AppSpacing.md }) {
        Text('Email')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        TextInput(this.email)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .width('100%')
          .height(44)
          .onChange((value: string) => {
            this.email = value
          })

        Text('Password')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        TextInput(this.password)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline, radius: 4 })
          .width('100%')
          .height(44)
          .onChange((value: string) => {
            this.password = value
          })

        Row() {
          Text('Forgot password?')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary)
          Text('Create account')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary)
        }
        .width('100%')
        .padding({ top: AppSpacing.sm })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')

      Button('Sign in')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(44)
    }
    .width('100%')
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.xl, bottom: AppSpacing.xl })
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
  }

  @Builder
  DividerRow() {
    Row() {
      Row()
        .layoutWeight(1)
        .height(1)
        .backgroundColor(AppColors.outline)
      Text('Or continue with')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ left: AppSpacing.md, right: AppSpacing.md })
      Row()
        .layoutWeight(1)
        .height(1)
        .backgroundColor(AppColors.outline)
    }
    .width('100%')
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SocialButtons() {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.socials, (item: SocialItem, index: number) => {
        Button(item.label)
          .type(ButtonType.Normal)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(item.tint)
          .borderRadius(8)
          .width('100%')
          .height(40)
      }, (item: SocialItem, index: number) => index.toString())
    }
    .width('100%')
  }

  @Builder
  TermsRow() {
    Row() {
      Text('By continuing you agree to the Terms and Privacy Policy')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
    }
    .width('100%')
    .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  SupportCard() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Need help?')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Contact support@example.com')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Support')
        .type(ButtonType.Normal)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onTertiary)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(8)
        .height(36)
    }
    .width('100%')
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(12)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}