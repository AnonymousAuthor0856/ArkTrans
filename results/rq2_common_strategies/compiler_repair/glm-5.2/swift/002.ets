// AuthLoginApp.ets

// MARK: - Design Tokens
class AppColors {
  primary: string = '#FF111827'
  onPrimary: string = '#FFFFFFFF'
  secondary: string = '#FF6B7280'
  onSecondary: string = '#FFFFFFFF'
  tertiary: string = '#FF2563EB'
  onTertiary: string = '#FFFFFFFF'
  background: string = '#FFF9FAFB'
  onBackground: string = '#FF0B1220'
  surface: string = '#FFFFFFFF'
  onSurface: string = '#FF111827'
  surfaceVariant: string = '#FFF3F4F6'
  outline: string = '#FFE5E7EB'
}

class AppTypography {
  display: FontConfig = { size: 22, weight: FontWeight.Medium }
  headline: FontConfig = { size: 16, weight: FontWeight.Medium }
  title: FontConfig = { size: 14, weight: FontWeight.Medium }
  body: FontConfig = { size: 12, weight: FontWeight.Normal }
  label: FontConfig = { size: 10, weight: FontWeight.Medium }
}

class AppTokens {
  static Colors: AppColors = new AppColors()
  static Typography: AppTypography = new AppTypography()
}

interface FontConfig {
  size: number
  weight: FontWeight
}

// MARK: - Data Models
class SocialItem {
  label: string
  tint: string

  constructor(label: string, tint: string) {
    this.label = label
    this.tint = tint
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State email: string = ''
  @State password: string = ''

  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', AppTokens.Colors.primary),
    new SocialItem('Continue with Google', AppTokens.Colors.tertiary),
    new SocialItem('Continue with GitHub', AppTokens.Colors.secondary)
  ]

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Scrollable Content
      Scroll() {
        Column() {
          // Header
          Text('Sign in')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 36, bottom: 32 })

          // Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .alignSelf(ItemAlign.Start)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: '', text: this.email })
                .onChange((value: string) => {
                  this.email = value
                })
                .height(40)
                .padding({ left: 12, right: 12 })
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .backgroundColor(AppTokens.Colors.surface)
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .alignSelf(ItemAlign.Start)

              TextInput({ placeholder: '', text: this.password })
                .type(InputType.Password)
                .onChange((value: string) => {
                  this.password = value
                })
                .height(40)
                .padding({ left: 12, right: 12 })
                .borderRadius(8)
                .border({ width: 1, color: AppTokens.Colors.outline })
                .backgroundColor(AppTokens.Colors.surface)
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            // Links
            Row() {
              Button('Forgot password?')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .backgroundColor(Color.Transparent)
                .padding(0)

              Blank()

              Button('Create account')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .backgroundColor(Color.Transparent)
                .padding(0)
            }
            .width('100%')
            .margin({ top: 6 })

            // Sign In Button
            Button('Sign in')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(8)
              .margin({ top: 8 })
          }
          .padding(16)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
          .margin({ left: 16, right: 16 })

          // Divider
          Row() {
            Divider()
              .color(AppTokens.Colors.outline)
              .height(1)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ left: 8, right: 8 })

            Divider()
              .color(AppTokens.Colors.outline)
              .height(1)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              Button(social.label)
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
                .width('100%')
                .height(36)
                .backgroundColor(social.tint)
                .borderRadius(8)
            })
          }
          .margin({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Text('Contact support@example.com')
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onTertiary)
              .height(32)
              .padding({ left: 12, right: 12 })
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(8)
          }
          .padding(16)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })
          .margin({ top: 32, left: 16, right: 16 })

          // Bottom spacer
          Column()
            .height(32)
        }
      }
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
  }
}