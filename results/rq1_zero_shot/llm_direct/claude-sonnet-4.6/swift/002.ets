import { router } from '@kit.ArkUI';

// Design Tokens
const AppTokens = {
  Colors: {
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
    outline: '#FFE5E7EB',
  },
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24,
  },
};

interface SocialItem {
  label: string;
  tint: string;
}

@Entry
@Component
struct ContentView {
  @State email: string = '';
  @State password: string = '';
  @State showPassword: boolean = false;

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary },
  ];

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
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: 36, bottom: 32 })

          // Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .width('100%')
              .textAlign(TextAlign.Start)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              TextInput({ text: this.email, placeholder: '' })
                .onChange((value: string) => {
                  this.email = value;
                })
                .width('100%')
                .height(40)
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surface)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline,
                  radius: 8,
                })
                .padding({ left: 12, right: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .width('100%')
                .textAlign(TextAlign.Start)

              TextInput({ text: this.password, placeholder: '' })
                .type(InputType.Password)
                .onChange((value: string) => {
                  this.password = value;
                })
                .width('100%')
                .height(40)
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surface)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline,
                  radius: 8,
                })
                .padding({ left: 12, right: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            // Links Row
            Row() {
              Text('Forgot password?')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)
                .onClick(() => {})

              Blank()

              Text('Create account')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.tertiary)
                .onClick(() => {})
            }
            .width('100%')
            .margin({ top: 6 })

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
              .onClick(() => {})
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: 12,
          })
          .shadow({
            radius: 4,
            color: '#24000000',
            offsetX: 0,
            offsetY: 1,
          })
          .margin({ left: 16, right: 16 })
          .alignItems(HorizontalAlign.Start)

          // Divider Row
          Row() {
            Divider()
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ left: 8, right: 8 })

            Divider()
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })
          .padding({ left: 16, right: 16 })

          // Social Buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              Button(social.label)
                .width('100%')
                .height(36)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onPrimary)
                .backgroundColor(social.tint)
                .borderRadius(8)
                .onClick(() => {})
            }, (social: SocialItem) => social.label)
          }
          .width('100%')
          .padding({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help Section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .textAlign(TextAlign.Start)

              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
                .textAlign(TextAlign.Start)
            }
            .alignItems(HorizontalAlign.Start)
            .layoutWeight(1)

            Button('Support')
              .height(32)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onTertiary)
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(8)
              .padding({ left: 12, right: 12 })
              .onClick(() => {})
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: 12,
          })
          .shadow({
            radius: 2,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 1,
          })
          .margin({ top: 32, left: 16, right: 16 })
          .alignItems(VerticalAlign.Center)

          // Bottom Spacer
          Column()
            .height(32)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }
}