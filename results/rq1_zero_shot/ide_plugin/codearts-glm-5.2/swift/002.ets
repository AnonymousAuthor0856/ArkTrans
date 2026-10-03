class AppTokens {
  static readonly Colors = {
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
}

class SocialItem {
  label: string
  tint: string

  constructor(label: string, tint: string) {
    this.label = label
    this.tint = tint
  }
}

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
    Scroll() {
      Column() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: 36, bottom: 32 })

        Column() {
          Text('Welcome back')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Column() {
            Text('Email')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            TextInput({ text: this.email })
              .width('100%')
              .height(40)
              .padding({ left: 12, right: 12 })
              .borderRadius(8)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface)
              .onChange((value: string) => {
                this.email = value
              })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 12 })

          Column() {
            Text('Password')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            TextInput({ text: this.password })
              .type(InputType.Password)
              .width('100%')
              .height(40)
              .padding({ left: 12, right: 12 })
              .borderRadius(8)
              .border({ width: 1, color: AppTokens.Colors.outline })
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface)
              .onChange((value: string) => {
                this.password = value
              })
          }
          .alignItems(HorizontalAlign.Start)
          .margin({ top: 12 })

          Row() {
            Text('Forgot password?')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.tertiary)
            Text('Create account')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.tertiary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ top: 6 })

          Text('Sign in')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%')
            .height(40)
            .textAlign(TextAlign.Center)
            .borderRadius(8)
            .backgroundColor(AppTokens.Colors.primary)
            .margin({ top: 8 })
        }
        .alignItems(HorizontalAlign.Start)
        .padding(16)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })
        .margin({ left: 16, right: 16 })

        Row() {
          Column()
            .layoutWeight(1)
            .height(1)
            .backgroundColor(AppTokens.Colors.outline)
          Text('Or continue with')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .padding({ left: 8, right: 8 })
          Column()
            .layoutWeight(1)
            .height(1)
            .backgroundColor(AppTokens.Colors.outline)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .margin({ top: 16, bottom: 16, left: 16, right: 16 })

        Column() {
          ForEach(this.socials, (social: SocialItem) => {
            Text(social.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .width('100%')
              .height(36)
              .textAlign(TextAlign.Center)
              .borderRadius(8)
              .backgroundColor(social.tint)
              .margin({ bottom: 6 })
          })
        }
        .margin({ left: 16, right: 16 })

        Text('By continuing you agree to the Terms and Privacy Policy')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .textAlign(TextAlign.Center)
          .margin({ top: 16, left: 32, right: 32 })

        Row() {
          Column() {
            Text('Need help?')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text('Contact support@example.com')
              .fontSize(12)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('Support')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onTertiary)
            .height(32)
            .padding({ left: 12, right: 12 })
            .borderRadius(8)
            .backgroundColor(AppTokens.Colors.tertiary)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .padding(16)
        .borderRadius(12)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 0.5 })
        .alignItems(VerticalAlign.Center)
        .margin({ top: 32, left: 16, right: 16 })

        Column()
          .height(32)
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .scrollBar(BarState.Off)
  }
}