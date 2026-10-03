//
//  ContentView.ets
//  AuthLoginApp
//

// MARK: - Design Tokens
interface AppColors {
  primary: string;
  onPrimary: string;
  secondary: string;
  onSecondary: string;
  tertiary: string;
  onTertiary: string;
  background: string;
  onBackground: string;
  surface: string;
  onSurface: string;
  surfaceVariant: string;
  outline: string;
}

interface FontSpec {
  size: number;
  weight: FontWeight;
}

interface AppTypography {
  display: FontSpec;
  headline: FontSpec;
  title: FontSpec;
  body: FontSpec;
  label: FontSpec;
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static readonly Colors: AppColors = {
    primary: '#111827',
    onPrimary: '#FFFFFF',
    secondary: '#6B7280',
    onSecondary: '#FFFFFF',
    tertiary: '#2563EB',
    onTertiary: '#FFFFFF',
    background: '#F9FAFB',
    onBackground: '#0B1220',
    surface: '#FFFFFF',
    onSurface: '#111827',
    surfaceVariant: '#F3F4F6',
    outline: '#E5E7EB'
  };

  static readonly Typography: AppTypography = {
    display: { size: 22, weight: FontWeight.Semibold },
    headline: { size: 16, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 10, weight: FontWeight.Medium }
  };

  static readonly Spacing: AppSpacing = {
    xs: 2, sm: 4, md: 6, lg: 8, xl: 12, xxl: 16, xxxl: 24
  };

  static readonly Shapes: AppShapes = {
    small: 4, medium: 8, large: 12
  };
}

// MARK: - Data Models
class SocialItem {
  label: string;
  tint: string;

  constructor(label: string, tint: string) {
    this.label = label;
    this.tint = tint;
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  @State email: string = '';
  @State password: string = '';

  socials: SocialItem[] = [
    new SocialItem('Continue with Apple', AppTokens.Colors.primary),
    new SocialItem('Continue with Google', AppTokens.Colors.tertiary),
    new SocialItem('Continue with GitHub', AppTokens.Colors.secondary)
  ];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Scroll() {
        Column({ space: 0 }) {
          // Header
          Text('Sign in')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .padding({ top: 36, bottom: 32 })

          // Login Card
          Column({ space: 12 }) {
            Text('Welcome back')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onSurface)

            // Email Field
            Column({ space: 4 }) {
              Text('Email')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: '', text: this.email })
                .height(40)
                .padding({ left: 12, right: 12 })
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(8)
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => { this.email = value; })
            }
            .alignItems(HorizontalAlign.Start)

            // Password Field
            Column({ space: 4 }) {
              Text('Password')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.onSurface)

              TextInput({ placeholder: '', text: this.password })
                .type(InputType.Password)
                .height(40)
                .padding({ left: 12, right: 12 })
                .border({ width: 1, color: AppTokens.Colors.outline })
                .borderRadius(8)
                .fontSize(AppTokens.Typography.body.size)
                .fontColor(AppTokens.Colors.onSurface)
                .onChange((value: string) => { this.password = value; })
            }
            .alignItems(HorizontalAlign.Start)

            // Links
            Row() {
              Button('Forgot password?')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .backgroundColor('#00000000')
                .onClick(() => {})

              Blank()

              Button('Create account')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.tertiary)
                .backgroundColor('#00000000')
                .onClick(() => {})
            }
            .padding({ top: 6 })

            // Sign In Button
            Button('Sign in')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width('100%')
              .height(40)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(8)
              .padding({ top: 8 })
              .onClick(() => {})
          }
          .alignItems(HorizontalAlign.Start)
          .padding(16)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.14)', offsetX: 0, offsetY: 1 })
          .padding({ left: 16, right: 16 })

          // Divider
          Row() {
            Row().height(1).backgroundColor(AppTokens.Colors.outline).layoutWeight(1)
            Text('Or continue with')
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .padding({ left: 8, right: 8 })
            Row().height(1).backgroundColor(AppTokens.Colors.outline).layoutWeight(1)
          }
          .padding({ top: 16, bottom: 16, left: 16, right: 16 })

          // Social buttons
          Column({ space: 6 }) {
            ForEach(this.socials, (social: SocialItem) => {
              Button(social.label)
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onPrimary)
                .width('100%')
                .height(36)
                .backgroundColor(social.tint)
                .borderRadius(8)
                .onClick(() => {})
            }, (social: SocialItem) => social.label)
          }
          .padding({ left: 16, right: 16 })

          // Terms and Privacy
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.secondary)
            .textAlign(TextAlign.Center)
            .padding({ top: 16, left: 32, right: 32 })

          // Help section
          Row() {
            Column({ space: 2 }) {
              Text('Need help?')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSurface)

              Text('Contact support@example.com')
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button('Support')
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onTertiary)
              .height(32)
              .padding({ left: 12, right: 12 })
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(8)
              .onClick(() => {})
          }
          .alignItems(VerticalAlign.Center)
          .padding(16)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(12)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .shadow({ radius: 2, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 0.5 })
          .padding({ top: 32, left: 16, right: 16 })

          // Bottom spacer
          Blank()
            .height(32)
        }
      }
    }
  }
}
