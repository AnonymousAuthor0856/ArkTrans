class AppTokens {
  static Colors = class {
    static readonly primary: ResourceColor = '#111827';
    static readonly onPrimary: ResourceColor = '#FFFFFF';
    static readonly secondary: ResourceColor = '#6B7280';
    static readonly onSecondary: ResourceColor = '#FFFFFF';
    static readonly tertiary: ResourceColor = '#2563EB';
    static readonly onTertiary: ResourceColor = '#FFFFFF';
    static readonly background: ResourceColor = '#F9FAFB';
    static readonly onBackground: ResourceColor = '#0B1220';
    static readonly surface: ResourceColor = '#FFFFFF';
    static readonly onSurface: ResourceColor = '#111827';
    static readonly surfaceVariant: ResourceColor = '#F3F4F6';
    static readonly outline: ResourceColor = '#E5E7EB';
  };

  static Typography = class {
    static readonly displaySize: number = 22;
    static readonly displayWeight: FontWeight = FontWeight.SemiBold;

    static readonly headlineSize: number = 16;
    static readonly headlineWeight: FontWeight = FontWeight.SemiBold;

    static readonly titleSize: number = 14;
    static readonly titleWeight: FontWeight = FontWeight.Medium;

    static readonly bodySize: number = 12;
    static readonly bodyWeight: FontWeight = FontWeight.Regular;

    static readonly labelSize: number = 10;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  };

  static Spacing = class {
    static readonly xs: number = 2;
    static readonly sm: number = 4;
    static readonly md: number = 6;
    static readonly lg: number = 8;
    static readonly xl: number = 12;
    static readonly xxl: number = 16;
    static readonly xxxl: number = 24;
  };

  static Shapes = class {
    static readonly small: number = 4;
    static readonly medium: number = 8;
    static readonly large: number = 12;
  };
}

interface SocialItem {
  label: string;
  tint: ResourceColor;
}

@Entry
@Component
struct ContentView {
  @State private email: string = '';
  @State private password: string = '';

  private socials: SocialItem[] = [
    { label: 'Continue with Apple', tint: AppTokens.Colors.primary },
    { label: 'Continue with Google', tint: AppTokens.Colors.tertiary },
    { label: 'Continue with GitHub', tint: AppTokens.Colors.secondary }
  ];

  build() {
    Navigation() {
      Stack() {
        Scroll() {
          Column({ space: 0 }) {
            Text('Sign in')
              .fontSize(AppTokens.Typography.displaySize)
              .fontWeight(AppTokens.Typography.displayWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ top: 36, bottom: 32 })

            Column({ space: 12 }) {
              Text('Welcome back')
                .fontSize(AppTokens.Typography.headlineSize)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Column({ space: 4 }) {
                Text('Email')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                TextInput({ text: this.email })
                  .height(40)
                  .width('100%')
                  .padding({ left: 12, right: 12 })
                  .backgroundColor(Color.Transparent)
                  .border({
                    width: 1,
                    color: AppTokens.Colors.outline,
                    radius: AppTokens.Shapes.medium
                  })
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .onChange((value: string) => {
                    this.email = value;
                  })
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')

              Column({ space: 4 }) {
                Text('Password')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)

                TextInput({ text: this.password })
                  .type(InputType.Password)
                  .height(40)
                  .width('100%')
                  .padding({ left: 12, right: 12 })
                  .backgroundColor(Color.Transparent)
                  .border({
                    width: 1,
                    color: AppTokens.Colors.outline,
                    radius: AppTokens.Shapes.medium
                  })
                  .fontSize(AppTokens.Typography.bodySize)
                  .fontWeight(AppTokens.Typography.bodyWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .onChange((value: string) => {
                    this.password = value;
                  })
              }
              .alignItems(HorizontalAlign.Start)
              .width('100%')

              Row() {
                Text('Forgot password?')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .onClick(() => {
                  })

                Blank()

                Text('Create account')
                  .fontSize(AppTokens.Typography.labelSize)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.tertiary)
                  .onClick(() => {
                  })
              }
              .width('100%')
              .padding({ top: 6 })

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('Sign in')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onPrimary)
              }
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .margin({ top: 8 })
              .onClick(() => {
              })
            }
            .alignItems(HorizontalAlign.Start)
            .width('calc(100% - 32vp)')
            .padding(16)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline
            })
            .shadow({
              radius: 4,
              color: '#24000000',
              offsetX: 0,
              offsetY: 1
            })

            Row() {
              Divider()
                .vertical(false)
                .color(AppTokens.Colors.outline)
                .strokeWidth(1)
                .layoutWeight(1)

              Text('Or continue with')
                .fontSize(AppTokens.Typography.labelSize)
                .fontWeight(AppTokens.Typography.labelWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding({ left: 8, right: 8 })

              Divider()
                .vertical(false)
                .color(AppTokens.Colors.outline)
                .strokeWidth(1)
                .layoutWeight(1)
            }
            .width('100%')
            .padding({
              top: 16,
              bottom: 16,
              left: 16,
              right: 16
            })

            Column({ space: 6 }) {
              ForEach(this.socials, (social: SocialItem) => {
                Button({ type: ButtonType.Normal, stateEffect: true }) {
                  Text(social.label)
                    .fontSize(AppTokens.Typography.titleSize)
                    .fontWeight(AppTokens.Typography.titleWeight)
                    .fontColor(AppTokens.Colors.onPrimary)
                }
                .width('100%')
                .height(36)
                .backgroundColor(social.tint)
                .borderRadius(AppTokens.Shapes.medium)
                .onClick(() => {
                })
              }, (social: SocialItem) => social.label)
            }
            .width('100%')
            .padding({ left: 16, right: 16 })

            Text('By continuing you agree to the Terms and Privacy Policy')
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(AppTokens.Typography.labelWeight)
              .fontColor(AppTokens.Colors.secondary)
              .textAlign(TextAlign.Center)
              .width('100%')
              .padding({
                top: 16,
                left: 32,
                right: 32
              })

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

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('Support')
                  .fontSize(AppTokens.Typography.titleSize)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.onTertiary)
              }
              .height(32)
              .padding({ left: 12, right: 12 })
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(AppTokens.Shapes.medium)
              .onClick(() => {
              })
            }
            .width('calc(100% - 32vp)')
            .padding(16)
            .margin({ top: 32 })
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline
            })
            .shadow({
              radius: 2,
              color: '#1A000000',
              offsetX: 0,
              offsetY: 0.5
            })

            Blank()
              .height(32)
          }
          .width('100%')
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)
    }
    .mode(NavigationMode.Stack)
    .hideTitleBar(true)
    .hideToolBar(true)
    .width('100%')
    .height('100%')
  }
}