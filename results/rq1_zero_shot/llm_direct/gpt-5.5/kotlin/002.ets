const NAME: string = '003_AuthLogin_en';
const UI_TYPE: string = 'Authentication Login';
const STYLE_THEME: string = 'Minimal Monochrome';
const LANG: string = 'en';
const BASELINE_SIZE: string = '1280x720';

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

class AppTypographyTokens {
  static readonly displaySize: number = 22;
  static readonly displayLineHeight: number = 28;
  static readonly headlineSize: number = 16;
  static readonly headlineLineHeight: number = 22;
  static readonly titleSize: number = 14;
  static readonly titleLineHeight: number = 18;
  static readonly bodySize: number = 12;
  static readonly bodyLineHeight: number = 16;
  static readonly labelSize: number = 10;
  static readonly labelLineHeight: number = 14;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 12;
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
}

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 2, 0.5, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(2, 4, 1, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(3, 6, 1.5, 0.16);
  static readonly level4: ShadowSpec = new ShadowSpec(4, 8, 2, 0.18);
  static readonly level5: ShadowSpec = new ShadowSpec(5, 10, 2.5, 0.20);
}

class AppTokens {
  static readonly Colors = AppColors;
  static readonly TypographyTokens = AppTypographyTokens;
  static readonly Shapes = AppShapes;
  static readonly Spacing = AppSpacing;
  static readonly ElevationMapping = AppElevationMapping;
}

class SocialItem {
  label: string;
  tint: string;

  constructor(label: string, tint: string) {
    this.label = label;
    this.tint = tint;
  }
}

@Entry
@Component
struct RootScreen {
  @State private email: string = '';
  @State private password: string = '';

  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', AppTokens.Colors.primary),
    new SocialItem('Continue with Google', AppTokens.Colors.tertiary),
    new SocialItem('Continue with GitHub', AppTokens.Colors.secondary)
  ];

  @Builder
  DisplayText(value: string) {
    Text(value)
      .fontSize(AppTokens.TypographyTokens.displaySize)
      .fontWeight(FontWeight.SemiBold)
      .lineHeight(AppTokens.TypographyTokens.displayLineHeight)
      .fontColor(AppTokens.Colors.onSurface)
  }

  @Builder
  HeadlineText(value: string) {
    Text(value)
      .fontSize(AppTokens.TypographyTokens.headlineSize)
      .fontWeight(FontWeight.SemiBold)
      .lineHeight(AppTokens.TypographyTokens.headlineLineHeight)
      .fontColor(AppTokens.Colors.onSurface)
  }

  @Builder
  TitleText(value: string, color: string = AppTokens.Colors.onSurface) {
    Text(value)
      .fontSize(AppTokens.TypographyTokens.titleSize)
      .fontWeight(FontWeight.Medium)
      .lineHeight(AppTokens.TypographyTokens.titleLineHeight)
      .fontColor(color)
  }

  @Builder
  BodyText(value: string, color: string = AppTokens.Colors.onSurface) {
    Text(value)
      .fontSize(AppTokens.TypographyTokens.bodySize)
      .fontWeight(FontWeight.Regular)
      .lineHeight(AppTokens.TypographyTokens.bodyLineHeight)
      .fontColor(color)
  }

  @Builder
  LabelText(value: string, color: string = AppTokens.Colors.onSurface) {
    Text(value)
      .fontSize(AppTokens.TypographyTokens.labelSize)
      .fontWeight(FontWeight.Medium)
      .lineHeight(AppTokens.TypographyTokens.labelLineHeight)
      .fontColor(color)
  }

  @Builder
  PrimaryButton(label: string, backgroundColor: string, contentColor: string, heightValue: number = 44) {
    Button(label)
      .width('100%')
      .height(heightValue)
      .backgroundColor(backgroundColor)
      .fontColor(contentColor)
      .fontSize(AppTokens.TypographyTokens.titleSize)
      .fontWeight(FontWeight.Medium)
      .borderRadius(AppTokens.Shapes.medium)
      .onClick(() => {
      })
  }

  build() {
    Column() {
      Row() {
        this.DisplayText('Sign in')
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          Column({ space: AppTokens.Spacing.lg }) {
            this.HeadlineText('Welcome back')

            Column({ space: AppTokens.Spacing.md }) {
              this.LabelText('Email')

              TextInput({ text: this.email })
                .width('100%')
                .height(44)
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surface)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline
                })
                .borderRadius(AppTokens.Shapes.medium)
                .padding({
                  left: AppTokens.Spacing.lg,
                  right: AppTokens.Spacing.lg
                })
                .onChange((value: string) => {
                  this.email = value;
                })

              this.LabelText('Password')

              TextInput({ text: this.password })
                .type(InputType.Password)
                .width('100%')
                .height(44)
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(FontWeight.Regular)
                .fontColor(AppTokens.Colors.onSurface)
                .backgroundColor(AppTokens.Colors.surface)
                .border({
                  width: 1,
                  color: AppTokens.Colors.outline
                })
                .borderRadius(AppTokens.Shapes.medium)
                .padding({
                  left: AppTokens.Spacing.lg,
                  right: AppTokens.Spacing.lg
                })
                .onChange((value: string) => {
                  this.password = value;
                })

              Row() {
                this.LabelText('Forgot password?', AppTokens.Colors.tertiary)
                Blank()
                this.LabelText('Create account', AppTokens.Colors.tertiary)
              }
              .width('100%')
              .padding({ top: AppTokens.Spacing.sm })
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            this.PrimaryButton('Sign in', AppTokens.Colors.primary, AppTokens.Colors.onPrimary, 44)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl,
            top: AppTokens.Spacing.xl,
            bottom: AppTokens.Spacing.xl
          })
          .alignItems(HorizontalAlign.Start)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({
            width: 1,
            color: AppTokens.Colors.outline
          })
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: '#24000000',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })

          Row() {
            Divider()
              .layoutWeight(1)
              .strokeWidth(1)
              .color(AppTokens.Colors.outline)

            Blank()
              .width(AppTokens.Spacing.md)

            this.LabelText('Or continue with', AppTokens.Colors.onSurface)

            Blank()
              .width(AppTokens.Spacing.md)

            Divider()
              .layoutWeight(1)
              .strokeWidth(1)
              .color(AppTokens.Colors.outline)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.socials, (item: SocialItem) => {
              this.PrimaryButton(item.label, item.tint, AppTokens.Colors.onPrimary, 40)
            }, (item: SocialItem) => item.label)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)

          Row() {
            this.LabelText('By continuing you agree to the Terms and Privacy Policy', AppTokens.Colors.secondary)
          }
          .width('100%')
          .padding({
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank()
            .height(AppTokens.Spacing.xxl)

          Row() {
            Column({ space: AppTokens.Spacing.xs }) {
              this.TitleText('Need help?', AppTokens.Colors.onSurface)
              this.BodyText('Contact support@example.com', AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support')
              .height(36)
              .backgroundColor(AppTokens.Colors.tertiary)
              .fontColor(AppTokens.Colors.onTertiary)
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .borderRadius(AppTokens.Shapes.medium)
              .onClick(() => {
              })
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.xl,
            right: AppTokens.Spacing.xl,
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: '#1A000000',
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.xl,
          right: AppTokens.Spacing.xl,
          top: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.lg
        })
        .alignItems(HorizontalAlign.Center)
      }
      .layoutWeight(1)
      .width('100%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}