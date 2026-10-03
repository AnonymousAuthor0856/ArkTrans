interface SocialItem {
  label: string
  tint: string
}

const AppTokens = {
  Colors: {
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
    outline: '#E5E7EB'
  },
  Typography: {
    displaySize: 22,
    displayWeight: 600,
    headlineSize: 16,
    headlineWeight: 600,
    titleSize: 14,
    titleWeight: 500,
    bodySize: 12,
    bodyWeight: 400,
    labelSize: 10,
    labelWeight: 500
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  },
  Shapes: {
    small: 4,
    medium: 8,
    large: 12
  }
}

@Entry
@Component
struct ContentView {
  @State private email: string = ''
  @State private password: string = ''

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary }
  ]

  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          Text('Sign in')
            .fontSize(AppTokens.Typography.displaySize)
            .fontWeight(AppTokens.Typography.displayWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 36, bottom: 32 })

          Column() {
            Column({ space: 12 }) {
              Text('Welcome back')
                .fontSize(AppTokens.Typography.headlineSize)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')

              Column({ space: 4 }) {
                Text('Email')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width('100%')

                TextInput({ text: this.email })
                  .width('100%')
                  .height(40)
                  .padding({ left: 12, right: 12 })
                  .backgroundColor(AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.medium)
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .caretColor(AppTokens.Colors.tertiary)
                  .onChange((value: string) => {
                    this.email = value
                  })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)

              Column({ space: 4 }) {
                Text('Password')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width('100%')

                TextInput({ text: this.password })
                  .type(InputType.Password)
                  .width('100%')
                  .height(40)
                  .padding({ left: 12, right: 12 })
                  .backgroundColor(AppTokens.Colors.surface)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .borderRadius(AppTokens.Shapes.medium)
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .caretColor(AppTokens.Colors.tertiary)
                  .onChange((value: string) => {
                    this.password = value
                  })
              }
              .width('100%')
              .alignItems(HorizontalAlign.Start)

              Row() {
                Text('Forgot password?')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .onClick(() => {
                  })

                Blank()

                Text('Create account')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .onClick(() => {
                  })
              }
              .width('100%')
              .margin({ top: 6 })

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('Sign in')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .margin({ top: 8 })
              .onClick(() => {
              })
            }
            .width('100%')
            .padding(16)
            .alignItems(HorizontalAlign.Start)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          Row() {
            Divider()
              .vertical(false)
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(AppTokens.Typography.labelWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ left: 8, right: 8 })

            Divider()
              .vertical(false)
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })

          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text(social.label)
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .width('100%')
              .height(36)
              .backgroundColor(social.tint)
              .borderRadius(AppTokens.Shapes.medium)
              .onClick(() => {
              })
            }, (social: SocialItem) => social.label)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .width('100%')
            .padding({ left: 32, right: 32 })
            .margin({ top: 16 })

          Column() {
            Row() {
              Column({ space: 2 }) {
                Text('Need help?')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width('100%')

                Text('Contact support@example.com')
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .width('100%')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('Support')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onTertiary)
              }
              .height(32)
              .padding({ left: 12, right: 12 })
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(AppTokens.Shapes.medium)
              .onClick(() => {
              })
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)
            .padding(16)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
          .margin({ top: 32 })

          Blank()
            .height(32)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}