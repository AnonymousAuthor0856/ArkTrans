@Entry
@Component
struct Index {
  @State email: string = '';
  @State password: string = '';
  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppColors.primary },
    { label: 'Continue with Google', tint: AppColors.tertiary },
    { label: 'Continue with GitHub', tint: AppColors.secondary }
  ];

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Sign in')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: 8 }) {
          // Card
          Column({ space: 8 }) {
            Text('Welcome back')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onSurface)

            Column({ space: 6 }) {
              Text('Email')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              TextInput({ text: this.email })
                .onChange((value: string) => {
                  this.email = value;
                })
                .fontSize(12)
                .height(44)
                .width('100%')
                .border({ width: 1, color: AppColors.outline })
                .borderRadius(4)
                .backgroundColor(AppColors.surface)
              Text('Password')
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              TextInput({ text: this.password })
                .onChange((value: string) => {
                  this.password = value;
                })
                .type(InputType.Password)
                .fontSize(12)
                .height(44)
                .width('100%')
                .border({ width: 1, color: AppColors.outline })
                .borderRadius(4)
                .backgroundColor(AppColors.surface)
              Row() {
                Text('Forgot password?')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.tertiary)
                Text('Create account')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.tertiary)
              }
              .width('100%')
              .padding({ top: 4 })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Button() {
              Text('Sign in')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
            .width('100%')
            .height(44)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
            .onClick(() => {
            })
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 12, bottom: 12 })
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(AppColors.surface)
          .border({ width: 1, color: AppColors.outline })
          .borderRadius(12)
          .shadow({ radius: 4, offsetY: 1, color: 'rgba(0,0,0,0.14)' })

          // Or continue with
          Row() {
            Divider()
              .strokeWidth(1)
              .color(AppColors.outline)
              .layoutWeight(1)
            Blank().width(6)
            Text('Or continue with')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Blank().width(6)
            Divider()
              .strokeWidth(1)
              .color(AppColors.outline)
              .layoutWeight(1)
          }
          .width('100%')
          .padding({ left: 12, right: 12 })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          // Social buttons
          Column({ space: 4 }) {
            ForEach(this.socials, (item: SocialItem) => {
              Button() {
                Text(item.label)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onPrimary)
              }
              .width('100%')
              .height(40)
              .backgroundColor(item.tint)
              .borderRadius(8)
              .onClick(() => {
              })
            }, (item: SocialItem) => item.label)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          // Terms
          Row() {
            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
          }
          .width('100%')
          .padding({ top: 4, bottom: 4 })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank().height(16)

          // Surface: help / support
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              Text('Contact support@example.com')
                .fontSize(12)
                .fontWeight(FontWeight.Normal)
                .fontColor(AppColors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Button() {
              Text('Support')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onTertiary)
            }
            .height(36)
            .backgroundColor(AppColors.tertiary)
            .borderRadius(8)
            .onClick(() => {
            })
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .shadow({ radius: 2, offsetY: 0.5, color: 'rgba(0,0,0,0.10)' })
        }
        .width('100%')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .alignItems(HorizontalAlign.Center)
      }
      .scrollable(ScrollDirection.Vertical)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

interface SocialItem {
  label: string;
  tint: string;
}

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
  static readonly success: string = '#16A34A';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#DC2626';
}
