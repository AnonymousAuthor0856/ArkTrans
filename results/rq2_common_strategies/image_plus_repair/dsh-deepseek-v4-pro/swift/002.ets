// ContentView.ets
// AuthLoginApp
//
// Created by hang on 2025/10/12
//

// MARK: - Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#111827'
    export const onPrimary: string = '#FFFFFF'
    export const secondary: string = '#6B7280'
    export const onSecondary: string = '#FFFFFF'
    export const tertiary: string = '#2563EB'
    export const onTertiary: string = '#FFFFFF'
    export const background: string = '#F9FAFB'
    export const onBackground: string = '#0B1220'
    export const surface: string = '#FFFFFF'
    export const onSurface: string = '#111827'
    export const surfaceVariant: string = '#F3F4F6'
    export const outline: string = '#E5E7EB'
  }

  export namespace Typography {
    export const displaySize: number = 22
    export const displayWeight: FontWeight = FontWeight.Bold
    export const headlineSize: number = 16
    export const headlineWeight: FontWeight = FontWeight.Bold
    export const titleSize: number = 14
    export const titleWeight: FontWeight = FontWeight.Medium
    export const bodySize: number = 12
    export const bodyWeight: FontWeight = FontWeight.Regular
    export const labelSize: number = 10
    export const labelWeight: FontWeight = FontWeight.Medium
  }

  export namespace Spacing {
    export const xs: number = 2
    export const sm: number = 4
    export const md: number = 6
    export const lg: number = 8
    export const xl: number = 12
    export const xxl: number = 16
    export const xxxl: number = 24
  }

  export namespace Shapes {
    export const small: number = 4
    export const medium: number = 8
    export const large: number = 12
  }
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
    Navigation() {
      Stack({ alignContent: Alignment.TopStart }) {
        Scroll() {
          Column({ space: 0 }) {
            // Header - 增加下方空白
            Text('Sign in')
              .fontSize(AppTokens.Typography.displaySize)
              .fontWeight(AppTokens.Typography.displayWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ top: 36, bottom: 32 })

            // Login Card
            Column({ space: 12 }) {
              Text('Welcome back')
                .fontSize(AppTokens.Typography.headlineSize)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)

              // Email Field
              Column({ space: 4 }) {
                Text('Email')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                TextInput({ placeholder: '', text: $$this.email })
                  .height(40)
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding({ left: 12, right: 12 })
                  .borderRadius(AppTokens.Shapes.medium)
                  .border({ width: 1, color: AppTokens.Colors.outline })
              }
              .alignItems(HorizontalAlign.Start)

              // Password Field
              Column({ space: 4 }) {
                Text('Password')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                TextInput({ placeholder: '', text: $$this.password })
                  .type(InputType.Password)
                  .height(40)
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding({ left: 12, right: 12 })
                  .borderRadius(AppTokens.Shapes.medium)
                  .border({ width: 1, color: AppTokens.Colors.outline })
              }
              .alignItems(HorizontalAlign.Start)

              // Links
              Row() {
                Button('Forgot password?')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .backgroundColor(Color.Transparent)

                Blank()

                Button('Create account')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .backgroundColor(Color.Transparent)
              }
              .width('100%')
              .padding({ top: 6 })

              // Sign In Button
              Button() {
                Text('Sign in')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onPrimary)
                  .width('100%')
                  .height(40)
              }
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(8)
              .padding({ top: 8 })
            }
            .padding(16)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
            .padding({ left: 16, right: 16 })
            .alignItems(HorizontalAlign.Start)

            // Divider
            Row() {
              Row()
                .layoutWeight(1)
                .height(1)
                .backgroundColor(AppTokens.Colors.outline)

              Text('Or continue with')
                .fontSize(AppTokens.Typography.labelSize)
                .fontWeight(AppTokens.Typography.labelWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding({ left: 8, right: 8 })

              Row()
                .layoutWeight(1)
                .height(1)
                .backgroundColor(AppTokens.Colors.outline)
            }
            .width('100%')
            .padding({ top: 16, bottom: 16, left: 16, right: 16 })

            // Social buttons
            Column({ space: 6 }) {
              ForEach(this.socials, (social: SocialItem) => {
                Button() {
                  Text(social.label)
                    .fontSize(AppTokens.Typography.titleSize)
                    .fontWeight(AppTokens.Typography.titleWeight)
                    .fontColor(AppTokens.Colors.onPrimary)
                    .width('100%')
                    .height(36)
                }
                .width('100%')
                .height(36)
                .backgroundColor(social.tint)
                .borderRadius(8)
              }, (social: SocialItem) => social.label)
            }
            .padding({ left: 16, right: 16 })

            // Terms and Privacy
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(AppTokens.Typography.labelWeight)
              .fontColor(AppTokens.Colors.secondary)
              .textAlign(TextAlign.Center)
              .padding({ top: 16, left: 32, right: 32 })

            // Help section
            Row() {
              Column({ space: 2 }) {
                Text('Need help?')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                Text('Contact support@example.com')
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .alignItems(HorizontalAlign.Start)

              Blank()

              Button() {
                Text('Support')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onTertiary)
                  .height(32)
                  .padding({ left: 12, right: 12 })
              }
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(8)
            }
            .padding(16)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(12)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })
            .padding({ top: 32, left: 16, right: 16 })

            // Bottom spacer
            Blank()
              .height(32)
          }
          .width('100%')
        }
        .width('100%')
        .height('100%')
        .align(Alignment.TopStart)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .hideTitleBar(true)
    .mode(NavigationMode.Stack)
  }
}

// MARK: - Preview (SwiftUI PreviewProvider has no ArkTS equivalent;
// previews are handled by the DevEco Studio Previewer)
