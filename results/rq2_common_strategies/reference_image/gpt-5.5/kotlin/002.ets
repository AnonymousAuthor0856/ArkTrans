const NAME: string = '003_AuthLogin_en'
const UI_TYPE: string = 'Authentication Login'
const STYLE_THEME: string = 'Minimal Monochrome'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

class AppColors {
  static readonly primary: string = '#111827'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly secondary: string = '#6B7280'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly tertiary: string = '#2563EB'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly background: string = '#F9FAFB'
  static readonly onBackground: string = '#0B1220'
  static readonly surface: string = '#FFFFFF'
  static readonly onSurface: string = '#111827'
  static readonly surfaceVariant: string = '#F3F4F6'
  static readonly outline: string = '#E5E7EB'
  static readonly success: string = '#16A34A'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#DC2626'
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 6
  static readonly lg: number = 8
  static readonly xl: number = 12
  static readonly xxl: number = 16
  static readonly xxxl: number = 24
}

class AppRadius {
  static readonly small: number = 4
  static readonly medium: number = 8
  static readonly large: number = 12
}

interface SocialItem {
  label: string
  tint: string
}

@Entry
@Component
struct Index {
  @State email: string = ''
  @State password: string = ''

  socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppColors.primary },
    { label: 'Continue with Google', tint: AppColors.tertiary },
    { label: 'Continue with GitHub', tint: AppColors.secondary }
  ]

  @Builder
  LabelText(label: string) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .lineHeight(14)
      .fontColor(AppColors.onSurface)
  }

  @Builder
  FormInput(label: string, value: string, passwordField: boolean) {
    Text(label)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .lineHeight(14)
      .fontColor(AppColors.onSurface)

    TextInput({ text: value })
      .width('100%')
      .height(56)
      .fontSize(12)
      .fontWeight(FontWeight.Regular)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surface)
      .border({
        width: 1,
        color: AppColors.outline,
        radius: AppRadius.medium
      })
      .padding({
        left: AppSpacing.lg,
        right: AppSpacing.lg
      })
      .onChange((text: string) => {
        if (passwordField) {
          this.password = text
        } else {
          this.email = text
        }
      })
  }

  @Builder
  PrimaryButton(label: string, color: string, heightValue: number = 44, widthValue: Length = '100%') {
    Button(label, { type: ButtonType.Normal, stateEffect: true })
      .width(widthValue)
      .height(heightValue)
      .borderRadius(AppRadius.medium)
      .backgroundColor(color)
      .fontColor(AppColors.onPrimary)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
      })
  }

  @Builder
  SocialButton(item: SocialItem) {
    Button(item.label, { type: ButtonType.Normal, stateEffect: true })
      .width('100%')
      .height(40)
      .borderRadius(AppRadius.medium)
      .backgroundColor(item.tint)
      .fontColor(AppColors.onPrimary)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .onClick(() => {
      })
  }

  build() {
    Column() {
      Row() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .lineHeight(28)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(88)
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Column({ space: AppSpacing.lg }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .lineHeight(22)
              .fontColor(AppColors.onSurface)

            Column({ space: AppSpacing.md }) {
              this.FormInput('Email', this.email, false)
              this.FormInput('Password', this.password, true)

              Row() {
                Text('Forgot password?')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(14)
                  .fontColor(AppColors.tertiary)

                Text('Create account')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(14)
                  .fontColor(AppColors.tertiary)
              }
              .width('100%')
              .padding({ top: AppSpacing.sm })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            this.PrimaryButton('Sign in', AppColors.primary, 44)
          }
          .width('100%')
          .padding({
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.xl,
            bottom: AppSpacing.xl
          })
          .backgroundColor(AppColors.surface)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppRadius.large
          })
          .borderRadius(AppRadius.large)
          .shadow({
            radius: 4,
            color: '#24000000',
            offsetX: 0,
            offsetY: 1
          })
          .alignItems(HorizontalAlign.Start)

          Row() {
            Divider()
              .vertical(false)
              .strokeWidth(1)
              .color(AppColors.outline)
              .layoutWeight(1)

            Blank()
              .width(AppSpacing.md)

            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .lineHeight(14)
              .fontColor(AppColors.onSurface)

            Blank()
              .width(AppSpacing.md)

            Divider()
              .vertical(false)
              .strokeWidth(1)
              .color(AppColors.outline)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({
            left: AppSpacing.xl,
            right: AppSpacing.xl
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.socials, (item: SocialItem) => {
              this.SocialButton(item)
            }, (item: SocialItem) => item.label)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .lineHeight(14)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .padding({
            top: AppSpacing.sm,
            bottom: AppSpacing.sm
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank()
            .height(AppSpacing.xxl)

          Row() {
            Column({ space: AppSpacing.xs }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .lineHeight(18)
                .fontColor(AppColors.onSurface)

              Text('Contact support@example.com')
                .fontSize(12)
                .fontWeight(FontWeight.Regular)
                .lineHeight(16)
                .fontColor(AppColors.onSurface)
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Start)

            Button('Support', { type: ButtonType.Normal, stateEffect: true })
              .width(98)
              .height(36)
              .borderRadius(AppRadius.medium)
              .backgroundColor(AppColors.tertiary)
              .fontColor(AppColors.onTertiary)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
              })
          }
          .width('100%')
          .padding({
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            top: AppSpacing.lg,
            bottom: AppSpacing.lg
          })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.large)
          .shadow({
            radius: 2,
            color: '#1A000000',
            offsetX: 0,
            offsetY: 0.5
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .width('100%')
        .padding({
          left: AppSpacing.xl,
          right: AppSpacing.xl,
          top: AppSpacing.lg,
          bottom: AppSpacing.xxl
        })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}