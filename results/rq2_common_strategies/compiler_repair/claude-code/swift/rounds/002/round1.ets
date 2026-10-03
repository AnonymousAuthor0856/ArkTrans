// MARK: - Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = 0x111827
    export const onPrimary: ResourceColor = Color.White
    export const secondary: ResourceColor = 0x6B7280
    export const onSecondary: ResourceColor = Color.White
    export const tertiary: ResourceColor = 0x2563EB
    export const onTertiary: ResourceColor = Color.White
    export const background: ResourceColor = 0xF9FAFB
    export const onBackground: ResourceColor = 0x0B1220
    export const surface: ResourceColor = Color.White
    export const onSurface: ResourceColor = 0x111827
    export const surfaceVariant: ResourceColor = 0xF3F4F6
    export const outline: ResourceColor = 0xE5E7EB
  }
}

// MARK: - Data Models
interface SocialItem {
  label: string
  tint: ResourceColor
}

// MARK: - Custom TextField Component
@Component
struct LoginTextField {
  @Link text: string
  @Prop placeholder: string = ''
  @Prop isPassword: boolean = false

  build() {
    TextInput({ placeholder: this.placeholder, text: this.text })
      .type(this.isPassword ? InputType.Password : InputType.Normal)
      .width('100%')
      .height(40)
      .padding({ left: 12, right: 12 })
      .fontSize(12)
      .fontColor(AppTokens.Colors.onSurface)
      .backgroundColor(Color.Transparent)
      .border({ width: 1, color: AppTokens.Colors.outline, radius: 8 })
      .onChange((value: string) => {
        this.text = value
      })
  }
}

// MARK: - Social Button Component
@Component
struct SocialButton {
  @Prop label: string = ''
  @Prop tint: ResourceColor = Color.Black
  onTap: () => void = () => {}

  build() {
    Button() {
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width('100%')
    .height(36)
    .backgroundColor(this.tint)
    .borderRadius(8)
    .onClick(() => this.onTap())
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State email: string = ''
  @State password: string = ''

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary }
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column({ space: 0 }) {
          // Header
          Text('Sign in')
            .fontSize(22)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 36, bottom: 32 })

          // Login Card
          Column() {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
              .width('100%')
              .margin({ bottom: 12 })
              .textAlign(TextAlign.Start)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              LoginTextField({ text: $email, placeholder: '', isPassword: false })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              LoginTextField({ text: $password, placeholder: '', isPassword: true })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 6 })

            // Links
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)

              Blank()

              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)
            }
            .width('100%')
            .margin({ top: 6, bottom: 8 })

            // Sign In Button
            Button('Sign in')
              .width('100%')
              .height(40)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(8)
              .margin({ top: 8 })
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.14)', offsetX: 0, offsetY: 1 })
          .margin({ left: 16, right: 16 })

          // Divider - Or continue with
          Row() {
            Divider()
              .vertical(false)
              .height(1)
              .color(AppTokens.Colors.outline)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ left: 8, right: 8 })

            Divider()
              .vertical(false)
              .height(1)
              .color(AppTokens.Colors.outline)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              SocialButton({
                label: social.label,
                tint: social.tint,
                onTap: () => {}
              })
            }, (social: SocialItem) => social.label)
          }
          .width('100%')
          .margin({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)

              Text('Contact support@example.com')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support')
              .height(32)
              .padding({ left: 12, right: 12 })
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onTertiary)
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(8)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 2, color: 'rgba(0, 0, 0, 0.10)', offsetX: 0, offsetY: 0.5 })
          .margin({ top: 32, left: 16, right: 16 })

          // Bottom spacer
          Blank()
            .height(32)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .height('100%')
  }
}
