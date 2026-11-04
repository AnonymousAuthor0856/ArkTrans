class SocialItem {
  label: string;
  tint: string;

  constructor(label: string, tint: string) {
    this.label = label;
    this.tint = tint;
  }
}

class LoginColors {
  static primary: string = '#111827';
  static onPrimary: string = '#FFFFFF';
  static secondary: string = '#6B7280';
  static tertiary: string = '#2563EB';
  static onTertiary: string = '#FFFFFF';
  static background: string = '#F9FAFB';
  static surface: string = '#FFFFFF';
  static onSurface: string = '#111827';
  static surfaceVariant: string = '#F3F4F6';
  static outline: string = '#E5E7EB';
}

@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', LoginColors.primary),
    new SocialItem('Continue with Google', LoginColors.tertiary),
    new SocialItem('Continue with GitHub', LoginColors.secondary)
  ];

  @Builder
  Field(label: string, value: string, onChange: (value: string) => void) {
    Column({ space: 6 }) {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(LoginColors.onSurface)
        .lineHeight(14)
      TextInput({ text: value })
        .fontSize(12)
        .fontColor(LoginColors.onSurface)
        .height(44)
        .width('100%')
        .backgroundColor(LoginColors.surface)
        .border({ width: 1, color: LoginColors.outline, radius: 4 })
        .onChange(onChange)
    }
    .width('100%')
  }

  @Builder
  SocialButton(item: SocialItem) {
    Button(item.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .fontColor(LoginColors.onPrimary)
      .backgroundColor(item.tint)
      .borderRadius(8)
      .height(40)
      .width('100%')
  }

  build() {
    Column() {
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(LoginColors.onSurface)
        .lineHeight(28)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(LoginColors.surface)

      Scroll() {
        Column({ space: 8 }) {
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(LoginColors.onSurface)
              .lineHeight(22)

            Column({ space: 6 }) {
              this.Field('Email', this.email, (value: string) => {
                this.email = value;
              })
              this.Field('Password', this.password, (value: string) => {
                this.password = value;
              })

              Row() {
                Text('Forgot password?')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(LoginColors.tertiary)
                  .lineHeight(14)
                Text('Create account')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(LoginColors.tertiary)
                  .lineHeight(14)
              }
              .width('100%')
              .padding({ top: 4 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')

            Button('Sign in')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(LoginColors.onPrimary)
              .backgroundColor(LoginColors.primary)
              .borderRadius(8)
              .height(44)
              .width('100%')
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .backgroundColor(LoginColors.surface)
          .border({ width: 1, color: LoginColors.outline, radius: 12 })
          .shadow({ radius: 4, color: '#24000000', offsetX: 0, offsetY: 1 })

          Row() {
            Divider().color(LoginColors.outline).strokeWidth(1).layoutWeight(1)
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(LoginColors.onSurface)
              .lineHeight(14)
              .margin({ left: 6, right: 6 })
            Divider().color(LoginColors.outline).strokeWidth(1).layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 12, right: 12 })
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.Center)

          Column({ space: 4 }) {
            ForEach(this.socials, (item: SocialItem) => {
              this.SocialButton(item)
            }, (item: SocialItem) => item.label)
          }
          .width('100%')

          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(LoginColors.secondary)
              .lineHeight(14)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .justifyContent(FlexAlign.Center)

          Blank().height(16)

          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(LoginColors.onSurface)
                .lineHeight(18)
              Text('Contact support@example.com')
                .fontSize(12)
                .fontColor(LoginColors.onSurface)
                .lineHeight(16)
            }
            .layoutWeight(1)

            Button('Support')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(LoginColors.onTertiary)
              .backgroundColor(LoginColors.tertiary)
              .borderRadius(8)
              .height(36)
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(LoginColors.surfaceVariant)
          .borderRadius(12)
          .shadow({ radius: 2, color: '#1A000000', offsetX: 0, offsetY: 1 })
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 24 })
      }
      .layoutWeight(1)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(LoginColors.background)
  }
}
