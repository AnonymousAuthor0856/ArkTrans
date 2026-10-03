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

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 6;
  static readonly lg: number = 8;
  static readonly xl: number = 12;
  static readonly xxl: number = 16;
  static readonly xxxl: number = 24;
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
struct MainActivity {
  @State email: string = '';
  @State password: string = '';
  private socials: SocialItem[] = [
    new SocialItem('Continue with Apple', AppColors.primary),
    new SocialItem('Continue with Google', AppColors.tertiary),
    new SocialItem('Continue with GitHub', AppColors.secondary)
  ];

  @Builder
  LabelText(text: string): void {
    Text(text)
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface);
  }

  @Builder
  AuthField(value: string, placeholder: string, isPassword: boolean): void {
    TextInput({ text: value, placeholder: placeholder })
      .type(isPassword ? InputType.Password : InputType.Email)
      .fontSize(12)
      .fontColor(AppColors.onSurface)
      .backgroundColor(AppColors.surface)
      .border({ width: 1, color: AppColors.outline })
      .borderRadius(8)
      .height(44)
      .width('100%')
      .onChange((next: string) => {
        if (isPassword) {
          this.password = next;
        } else {
          this.email = next;
        }
      });
  }

  @Builder
  LoginCard(): void {
    Column({ space: AppSpacing.lg }) {
      Text('Welcome back')
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface);

      Column({ space: AppSpacing.md }) {
        this.LabelText('Email');
        this.AuthField(this.email, '', false);
        this.LabelText('Password');
        this.AuthField(this.password, '', true);

        Row() {
          Text('Forgot password?')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary);
          Blank();
          Text('Create account')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.tertiary);
        }
        .width('100%')
        .padding({ top: AppSpacing.sm })
        .alignItems(VerticalAlign.Center);
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start);

      Button('Sign in')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(44);
    }
    .width('100%')
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.xl, bottom: AppSpacing.xl })
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  DividerLabel(): void {
    Row({ space: AppSpacing.md }) {
      Divider().layoutWeight(1).strokeWidth(1).color(AppColors.outline);
      Text('Or continue with')
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Divider().layoutWeight(1).strokeWidth(1).color(AppColors.outline);
    }
    .width('100%')
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  SocialButtons(): void {
    Column({ space: AppSpacing.sm }) {
      ForEach(this.socials, (item: SocialItem) => {
        Button(item.label)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(item.tint)
          .borderRadius(8)
          .width('100%')
          .height(40);
      }, (item: SocialItem) => item.label)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center);
  }

  @Builder
  SupportCard(): void {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Need help?')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface);
        Text('Contact support@example.com')
          .fontSize(12)
          .fontColor(AppColors.onSurface);
      }
      .alignItems(HorizontalAlign.Start);

      Blank();

      Button('Support')
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onTertiary)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(8)
        .height(36);
    }
    .width('100%')
    .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.lg })
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1A000000', offsetY: 0.5 })
    .alignItems(VerticalAlign.Center);
  }

  build() {
    Column() {
      Text('Sign in')
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.surface);

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.LoginCard();
          this.DividerLabel();
          this.SocialButtons();
          Text('By continuing you agree to the Terms and Privacy Policy')
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm });
          Blank().height(AppSpacing.xxl);
          this.SupportCard();
        }
        .width('100%')
        .padding({ left: AppSpacing.xl, right: AppSpacing.xl, top: AppSpacing.lg, bottom: AppSpacing.xxl })
        .alignItems(HorizontalAlign.Center);
      }
      .layoutWeight(1);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
