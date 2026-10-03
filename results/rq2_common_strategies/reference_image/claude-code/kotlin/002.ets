@Entry
@Component
struct AuthLogin {
  @State email: string = ''
  @State password: string = ''

  private readonly colors = {
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
    error: '#DC2626'
  }

  private readonly typography = {
    display: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28 },
    headline: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 }
  }

  private readonly shapes = { small: 4, medium: 8, large: 12 }
  private readonly spacing = { xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24 }

  build() {
    Column() {
      // Top bar - "Sign in"
      Column() {
        Text('Sign in')
          .fontSize(this.typography.display.fontSize)
          .fontWeight(this.typography.display.fontWeight)
          .fontColor(this.colors.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)

      // Scrollable content
      Scroll() {
        Column() {
          // Welcome card
          this.WelcomeCard()

          // Divider row
          this.DividerRow()

          // Social login buttons
          this.SocialButtons()

          // Terms text
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(this.typography.label.fontSize)
            .fontWeight(this.typography.label.fontWeight)
            .fontColor(this.colors.secondary)
            .margin({ top: this.spacing.sm, bottom: this.spacing.sm })

          // Need help surface
          this.HelpSurface()
        }
        .width('100%')
        .padding({ left: this.spacing.xl, right: this.spacing.xl, top: this.spacing.lg, bottom: this.spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }

  @Builder
  WelcomeCard() {
    Column() {
      Text('Welcome back')
        .fontSize(this.typography.headline.fontSize)
        .fontWeight(this.typography.headline.fontWeight)
        .fontColor(this.colors.onSurface)

      Column() {
        Text('Email')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .margin({ bottom: this.spacing.md })

        TextInput({ placeholder: '', text: this.email })
          .width('100%')
          .height(44)
          .type(InputType.Normal)
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: this.colors.outline,
            radius: this.shapes.medium
          })
          .padding({ left: 12, right: 12 })
          .fontSize(this.typography.body.fontSize)
          .onChange((value: string) => {
            this.email = value
          })

        Text('Password')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .margin({ top: this.spacing.lg, bottom: this.spacing.md })

        TextInput({ placeholder: '', text: this.password })
          .width('100%')
          .height(44)
          .type(InputType.Password)
          .backgroundColor(Color.Transparent)
          .border({
            width: 1,
            color: this.colors.outline,
            radius: this.shapes.medium
          })
          .padding({ left: 12, right: 12 })
          .fontSize(this.typography.body.fontSize)
          .onChange((value: string) => {
            this.password = value
          })

        Row() {
          Text('Forgot password?')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.tertiary)

          Text('Create account')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.tertiary)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: this.spacing.sm })

        Button('Sign in')
          .width('100%')
          .height(44)
          .backgroundColor(this.colors.primary)
          .fontColor(this.colors.onPrimary)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .borderRadius(this.shapes.medium)
          .margin({ top: this.spacing.lg })
          .onClick(() => {})
      }
      .width('100%')
      .margin({ top: this.spacing.lg })
    }
    .width('100%')
    .padding(this.spacing.xl)
    .backgroundColor(this.colors.surface)
    .borderRadius(this.shapes.large)
    .border({
      width: 1,
      color: this.colors.outline
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
        .color(this.colors.outline)
        .layoutWeight(1)

      Text('Or continue with')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .margin({ left: this.spacing.md, right: this.spacing.md })

      Divider()
        .vertical(false)
        .strokeWidth(1)
        .color(this.colors.outline)
        .layoutWeight(1)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({
      top: this.spacing.xl + this.spacing.lg,
      bottom: this.spacing.xl + this.spacing.lg
    })
  }

  @Builder
  SocialButtons() {
    Column() {
      Button('Continue with Apple')
        .width('100%')
        .height(40)
        .backgroundColor(this.colors.primary)
        .fontColor(this.colors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(this.shapes.medium)
        .onClick(() => {})

      Button('Continue with Google')
        .width('100%')
        .height(40)
        .backgroundColor(this.colors.tertiary)
        .fontColor(this.colors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(this.shapes.medium)
        .margin({ top: this.spacing.sm })
        .onClick(() => {})

      Button('Continue with GitHub')
        .width('100%')
        .height(40)
        .backgroundColor(this.colors.secondary)
        .fontColor(this.colors.onPrimary)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .borderRadius(this.shapes.medium)
        .margin({ top: this.spacing.sm })
        .onClick(() => {})
    }
    .width('100%')
  }

  @Builder
  HelpSurface() {
    Row() {
      Column() {
        Text('Need help?')
          .fontSize(this.typography.title.fontSize)
          .fontWeight(this.typography.title.fontWeight)
          .fontColor(this.colors.onSurface)

        Text('Contact support@example.com')
          .fontSize(this.typography.body.fontSize)
          .fontWeight(this.typography.body.fontWeight)
          .fontColor(this.colors.onSurface)
          .margin({ top: this.spacing.xs })
      }
      .alignItems(HorizontalAlign.Start)

      Button('Support')
        .height(36)
        .backgroundColor(this.colors.tertiary)
        .fontColor(this.colors.onTertiary)
        .fontSize(this.typography.title.fontSize)
        .fontWeight(FontWeight.Medium)
        .borderRadius(this.shapes.medium)
        .padding({ left: 24, right: 24 })
        .onClick(() => {})
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding({ left: this.spacing.xl, right: this.spacing.xl, top: this.spacing.lg, bottom: this.spacing.lg })
    .backgroundColor(this.colors.surfaceVariant)
    .borderRadius(this.shapes.large)
  }
}
