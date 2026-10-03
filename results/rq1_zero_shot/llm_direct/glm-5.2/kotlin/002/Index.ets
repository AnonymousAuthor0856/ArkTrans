// AppTokens: Design tokens for colors, typography, shapes, spacing, and elevation.
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
    outline: '#FFE5E7EB',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFDC2626'
  };

  static readonly Typography = {
    display: { fontSize: 22, fontWeight: FontWeight.Medium, lineHeight: 28 },
    headline: { fontSize: 16, fontWeight: FontWeight.Medium, lineHeight: 22 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 }
  };

  static readonly Shapes = {
    small: 4,
    medium: 8,
    large: 12
  };

  static readonly Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static readonly ElevationMapping = {
    level1: 1,
    level2: 2,
    level3: 3,
    level4: 4,
    level5: 5
  };
}

// Model for social login buttons
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
  @State email: string = '';
  @State password: string = '';

  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', AppTokens.Colors.primary),
    new SocialItem('Continue with Google', AppTokens.Colors.tertiary),
    new SocialItem('Continue with GitHub', AppTokens.Colors.secondary)
  ];

  build() {
    Column() {
      // Top App Bar
      Text('Sign in')
        .fontSize(AppTokens.Typography.display.fontSize)
        .fontWeight(AppTokens.Typography.display.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg });

      // Scrollable Content Area
      Scroll() {
        Column() {
          // Login Card
          Column() {
            Text('Welcome back')
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.lg });

            // Email Field
            Text('Email')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md });

            TextInput({ text: this.email, placeholder: '' })
              .onChange((value: string) => {
                this.email = value;
              })
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontColor(AppTokens.Colors.onSurface)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.small)
              .height(44)
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md });

            // Password Field
            Text('Password')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md });

            TextInput({ text: this.password, placeholder: '' })
              .type(InputType.Password)
              .onChange((value: string) => {
                this.password = value;
              })
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontColor(AppTokens.Colors.onSurface)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.small)
              .height(44)
              .width('100%');

            // Forgot Password / Create Account Row
            Row() {
              Text('Forgot password?')
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(AppTokens.Colors.tertiary);

              Text('Create account')
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(AppTokens.Colors.tertiary);
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.lg });

            // Sign In Button
            Button('Sign in')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(44)
              .width('100%');
          }
          .width('100%')
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: AppTokens.ElevationMapping.level2, color: '#14000000', offsetX: 0, offsetY: 1 });

          // Divider Section
          Row() {
            Divider()
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1);

            Text('Or continue with')
              .fontSize(AppTokens.Typography.label.fontSize)
              .fontWeight(AppTokens.Typography.label.fontWeight)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md });

            Divider()
              .color(AppTokens.Colors.outline)
              .strokeWidth(1)
              .layoutWeight(1);
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.lg });

          // Social Buttons
          ForEach(this.socials, (social: SocialItem) => {
            Button(social.label)
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(social.tint)
              .borderRadius(AppTokens.Shapes.medium)
              .height(40)
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.sm });
          });

          // Terms Text
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xxl });

          // Support Card
          Row() {
            Column() {
              Text('Need help?')
                .fontSize(AppTokens.Typography.title.fontSize)
                .fontWeight(AppTokens.Typography.title.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.xs });

              Text('Contact support@example.com')
                .fontSize(AppTokens.Typography.body.fontSize)
                .fontWeight(AppTokens.Typography.body.fontWeight)
                .fontColor(AppTokens.Colors.onSurface);
            }
            .alignItems(HorizontalAlign.Start);

            Button('Support')
              .fontSize(AppTokens.Typography.title.fontSize)
              .fontWeight(AppTokens.Typography.title.fontWeight)
              .fontColor(AppTokens.Colors.onTertiary)
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(36);
          }
          .width('100%')
          .padding({ horizontal: AppTokens.Spacing.xl, vertical: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .shadow({ radius: AppTokens.ElevationMapping.level1, color: '#1A000000', offsetX: 0, offsetY: 0.5 });
        }
        .width('100%')
        .padding({ horizontal: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xxl });
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}