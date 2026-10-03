// Design Tokens
class AppColors {
  static readonly primary: string = '#111827';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly secondary: string = '#6B7280';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly tertiary: string = '#2563EB';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly background: string = '#F9FAFB';
  static readonly onBackground: string = '#0B1220';
  static readonly surface: string = '#FFFFFF';
  static readonly onSurface: string = '#111827';
  static readonly surfaceVariant: string = '#F3F4F6';
  static readonly outline: string = '#E5E7EB';
}

class AppFonts {
  static readonly display: { size: number; weight: number } = { size: 22, weight: 600 };
  static readonly headline: { size: number; weight: number } = { size: 16, weight: 600 };
  static readonly title: { size: number; weight: number } = { size: 14, weight: 500 };
  static readonly body: { size: number; weight: number } = { size: 12, weight: 400 };
  static readonly label: { size: number; weight: number } = { size: 10, weight: 500 };
}

interface SocialItem {
  label: string;
  tint: string;
}

@Entry
@Component
struct SignInPage {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppColors.primary },
    { label: 'Continue with Google', tint: AppColors.tertiary },
    { label: 'Continue with GitHub', tint: AppColors.secondary }
  ];

  build() {
    Stack() {
      Scroll() {
        Column({ space: 0 }) {
          // Header
          Text('Sign in')
            .fontSize(AppFonts.display.size)
            .fontWeight(AppFonts.display.weight)
            .fontColor(AppColors.onSurface)
            .margin({ top: 36, bottom: 32 })

          // Login Card
          Column() {
            Text('Welcome back')
              .fontSize(AppFonts.headline.size)
              .fontWeight(AppFonts.headline.weight)
              .fontColor(AppColors.onSurface)
              .width('100%')
              .margin({ bottom: 12 })

            // Email Field
            Column() {
              Text('Email')
                .fontSize(AppFonts.label.size)
                .fontWeight(AppFonts.label.weight)
                .fontColor(AppColors.onSurface)
                .width('100%')
                .margin({ bottom: 4 })

              TextInput({ placeholder: '', text: this.email })
                .onChange((value: string) => { this.email = value; })
                .height(40)
                .width('100%')
                .fontSize(AppFonts.body.size)
                .fontColor(AppColors.onSurface)
                .backgroundColor(Color.White)
                .border({
                  width: 1,
                  color: AppColors.outline,
                  radius: 8
                })
                .padding({ left: 12, right: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })

            // Password Field
            Column() {
              Text('Password')
                .fontSize(AppFonts.label.size)
                .fontWeight(AppFonts.label.weight)
                .fontColor(AppColors.onSurface)
                .width('100%')
                .margin({ bottom: 4 })

              TextInput({ placeholder: '', text: this.password })
                .onChange((value: string) => { this.password = value; })
                .type(InputType.Password)
                .height(40)
                .width('100%')
                .fontSize(AppFonts.body.size)
                .fontColor(AppColors.onSurface)
                .backgroundColor(Color.White)
                .border({
                  width: 1,
                  color: AppColors.outline,
                  radius: 8
                })
                .padding({ left: 12, right: 12 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })

            // Links
            Row() {
              Text('Forgot password?')
                .fontSize(AppFonts.label.size)
                .fontWeight(AppFonts.label.weight)
                .fontColor(AppColors.tertiary)

              Blank()

              Text('Create account')
                .fontSize(AppFonts.label.size)
                .fontWeight(AppFonts.label.weight)
                .fontColor(AppColors.tertiary)
            }
            .width('100%')
            .margin({ top: 6, bottom: 8 })

            // Sign In Button
            Button('Sign in')
              .fontSize(AppFonts.title.size)
              .fontWeight(AppFonts.title.weight)
              .fontColor(AppColors.onPrimary)
              .width('100%')
              .height(40)
              .backgroundColor(AppColors.primary)
              .borderRadius(8)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding(16)
          .backgroundColor(AppColors.surface)
          .borderRadius(12)
          .border({
            width: 1,
            color: AppColors.outline
          })
          .shadow({
            radius: 4,
            color: 'rgba(0, 0, 0, 0.14)',
            offsetX: 0,
            offsetY: 1
          })
          .margin({ left: 16, right: 16 })

          // Divider
          Row() {
            Divider()
              .color(AppColors.outline)
              .strokeWidth(1)
              .layoutWeight(1)

            Text('Or continue with')
              .fontSize(AppFonts.label.size)
              .fontWeight(AppFonts.label.weight)
              .fontColor(AppColors.onSurface)
              .margin({ left: 8, right: 8 })

            Divider()
              .color(AppColors.outline)
              .strokeWidth(1)
              .layoutWeight(1)
          }
          .width('100%')
          .margin({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              Button(social.label)
                .fontSize(AppFonts.title.size)
                .fontWeight(AppFonts.title.weight)
                .fontColor(AppColors.onPrimary)
                .width('100%')
                .height(36)
                .backgroundColor(social.tint)
                .borderRadius(8)
            }, (social: SocialItem) => social.label)
          }
          .width('100%')
          .margin({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppFonts.label.size)
            .fontWeight(AppFonts.label.weight)
            .fontColor(AppColors.secondary)
            .textAlign(TextAlign.Center)
            .margin({ top: 16, left: 32, right: 32 })

          // Help section
          Row() {
            Column() {
              Text('Need help?')
                .fontSize(AppFonts.title.size)
                .fontWeight(AppFonts.title.weight)
                .fontColor(AppColors.onSurface)
                .margin({ bottom: 2 })

              Text('Contact support@example.com')
                .fontSize(AppFonts.body.size)
                .fontWeight(AppFonts.body.weight)
                .fontColor(AppColors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support')
              .fontSize(AppFonts.title.size)
              .fontWeight(AppFonts.title.weight)
              .fontColor(AppColors.onTertiary)
              .height(32)
              .padding({ left: 12, right: 12 })
              .backgroundColor(AppColors.tertiary)
              .borderRadius(8)
          }
          .width('100%')
          .padding(16)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .border({
            width: 1,
            color: AppColors.outline
          })
          .shadow({
            radius: 2,
            color: 'rgba(0, 0, 0, 0.10)',
            offsetX: 0,
            offsetY: 0.5
          })
          .margin({ top: 32, left: 16, right: 16 })

          // Bottom spacer
          Blank()
            .height(32)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.None)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
