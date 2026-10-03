// ContentView.ets
// AuthLoginApp
// Created by hang on 2025/10/12.

// MARK: - Design Tokens
class AppTokens {
  static Colors = {
    primary: '#FF111827',
    onPrimary: '#FFFFFFFF',
    secondary: '#FF6B7280',
    onSecondary: '#FFFFFFFF',
    tertiary: '#FF2563EB',
    onTertiary: '#FFFFFFFF',
    background: '#FFF9FAFB',
    onBackground: '#FF0B1220',
    surface: '#FFFFFFFF',
    onSurface: '#FF111827',
    surfaceVariant: '#FFF3F4F6',
    outline: '#FFE5E7EB'
  }
  
  static Typography = {
    display: { size: 22, weight: FontWeight.Medium },
    headline: { size: 16, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 10, weight: FontWeight.Medium }
  }
  
  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  }
  
  static Shapes = {
    small: 4,
    medium: 8,
    large: 12
  }
}

// MARK: - Data Models
interface SocialItem {
  label: string
  tint: string
}

// MARK: - Main Content View
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
          Column() {
            Text('Welcome back')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .alignSelf(ItemAlign.Start)
              .margin({ bottom: 12 })

            // Email Field
            Column() {
              Text('Email')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: 4 })

              TextInput({ placeholder: '', controller: undefined })
                .onChange((value: string) => {
                  this.email = value
                })
                .type(InputType.Normal)
                .height(40)
                .padding({ left: 12, right: 12 })
                .borderRadius(AppTokens.Shapes.medium)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .backgroundColor(AppTokens.Colors.surface)
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })

            // Password Field
            Column() {
              Text('Password')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: 4 })

              TextInput({ placeholder: '' })
                .onChange((value: string) => {
                  this.password = value
                })
                .type(InputType.Password)
                .height(40)
                .padding({ left: 12, right: 12 })
                .borderRadius(AppTokens.Shapes.medium)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .backgroundColor(AppTokens.Colors.surface)
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 6 })

            // Links
            Row() {
              Button('Forgot password?') {}
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .height(14)

              Blank()

              Button('Create account') {}
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .height(14)
            }
            .width('100%')
            .margin({ top: 6, bottom: 8 })

            // Sign In Button
            Button('Sign in') {}
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
          }
          .padding(16)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .margin({ left: 16, right: 16 })
          .shadow({ radius: 4, color: '#24000000', offsetY: 1 })

          // Divider
          Row() {
            Column()
              .backgroundColor(AppTokens.Colors.outline)
              .height(1)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ left: 8, right: 8 })

            Column()
              .backgroundColor(AppTokens.Colors.outline)
              .height(1)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              Button(social.label) {}
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
                .width('100%')
                .height(36)
                .backgroundColor(social.tint)
                .borderRadius(AppTokens.Shapes.medium)
            })
          }
          .padding({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help section
          Row() {
            Column() {
              Text('Need help?')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: 2 })

              Text('Contact support@example.com')
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support') {}
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onTertiary)
              .height(32)
              .padding({ left: 12, right: 12 })
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(AppTokens.Shapes.medium)
          }
          .padding(16)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .borderWidth(1)
          .borderColor(AppTokens.Colors.outline)
          .margin({ top: 32, left: 16, right: 16 })
          .shadow({ radius: 2, color: '#1A000000', offsetY: 0.5 })

          // Bottom spacer
          Column().height(32)
        }
      }
      .width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
  }
}