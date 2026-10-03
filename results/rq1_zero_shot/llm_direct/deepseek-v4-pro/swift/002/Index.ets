@Entry
@Component
struct LoginPage {
  @State email: string = ''
  @State password: string = ''

  // Design tokens
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
    outline: '#E5E7EB'
  }

  private readonly socials: Array<{ label: string, tint: string }> = [
    { label: 'Continue with Apple', tint: '#111827' },
    { label: 'Continue with Google', tint: '#2563EB' },
    { label: 'Continue with GitHub', tint: '#6B7280' }
  ]

  @Builder
  LoginTextField(placeholder: string, isPassword: boolean, value: string, onChange: (value: string) => void) {
    if (isPassword) {
      TextInput({ placeholder: placeholder, text: value })
        .type(InputType.Password)
        .height(40)
        .padding({ left: 12, right: 12 })
        .fontSize(12)
        .fontColor(this.colors.onSurface)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: this.colors.outline, radius: 8 })
        .onChange((value: string) => {
          onChange(value)
        })
    } else {
      TextInput({ placeholder: placeholder, text: value })
        .type(InputType.Normal)
        .height(40)
        .padding({ left: 12, right: 12 })
        .fontSize(12)
        .fontColor(this.colors.onSurface)
        .backgroundColor(Color.Transparent)
        .border({ width: 1, color: this.colors.outline, radius: 8 })
        .onChange((value: string) => {
          onChange(value)
        })
    }
  }

  @Builder
  SocialButton(label: string, tint: string) {
    Button(label) {
      // Action
    }
    .width('100%')
    .height(36)
    .fontSize(14)
    .fontWeight(FontWeight.Medium)
    .fontColor(this.colors.onPrimary)
    .backgroundColor(tint)
    .borderRadius(8)
  }

  build() {
    Column() {
      Scroll() {
        Column() {
          // Header
          Text('Sign in')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(this.colors.onSurface)
            .margin({ top: 36, bottom: 32 })

          // Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(this.colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              this.LoginTextField('', false, this.email, (value: string) => {
                this.email = value
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              this.LoginTextField('', true, this.password, (value: string) => {
                this.password = value
              })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Links
            Row() {
              Button('Forgot password?') {
                // Action
              }
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.tertiary)
              .backgroundColor(Color.Transparent)

              Blank()

              Button('Create account') {
                // Action
              }
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.tertiary)
              .backgroundColor(Color.Transparent)
            }
            .width('100%')
            .margin({ top: 6 })

            // Sign In Button
            Button('Sign in') {
              // Action
            }
            .width('100%')
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onPrimary)
            .backgroundColor(this.colors.primary)
            .borderRadius(8)
            .margin({ top: 8 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.colors.surface)
          .borderRadius(12)
          .border({ width: 1, color: this.colors.outline })
          .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.14)', offsetY: 1 })
          .margin({ left: 16, right: 16 })
          .alignItems(HorizontalAlign.Start)

          // Divider
          Row() {
            Divider()
              .strokeWidth(1)
              .color(this.colors.outline)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
              .margin({ left: 8, right: 8 })

            Divider()
              .strokeWidth(1)
              .color(this.colors.outline)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: { label: string, tint: string }) => {
              this.SocialButton(social.label, social.tint)
            }, (social: { label: string, tint: string }) => social.label)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.onSurface)

              Text('Contact support@example.com')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .fontColor(this.colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support') {
              // Action
            }
            .height(32)
            .padding({ left: 12, right: 12 })
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onTertiary)
            .backgroundColor(this.colors.tertiary)
            .borderRadius(8)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(this.colors.surfaceVariant)
          .borderRadius(12)
          .border({ width: 1, color: this.colors.outline })
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.10)', offsetY: 0.5 })
          .margin({ top: 32, left: 16, right: 16 })

          // Bottom spacer
          Blank()
            .height(32)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}