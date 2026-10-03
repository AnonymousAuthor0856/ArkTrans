import window from '@ohos.window';
import common from '@ohos.app.ability.common';

class AppTokensColors {
  primary: ResourceColor = '#2563EB';
  secondary: ResourceColor = '#38BDF8';
  tertiary: ResourceColor = '#60A5FA';
  background: ResourceColor = '#E6F0FF';
  surface: ResourceColor = '#FFFFFF';
  surfaceVariant: ResourceColor = '#E2E8F0';
  outline: ResourceColor = '#CBD5E1';
  success: ResourceColor = '#22C55E';
  warning: ResourceColor = '#F59E0B';
  error: ResourceColor = '#EF4444';
  onPrimary: ResourceColor = '#FFFFFF';
  onSecondary: ResourceColor = '#0F172A';
  onTertiary: ResourceColor = '#FFFFFF';
  onBackground: ResourceColor = '#0F172A';
  onSurface: ResourceColor = '#1E293B';
}

class AppTokensTypography {
  displaySize: number = 28;
  displayWeight: FontWeight = FontWeight.Bold;
  headlineSize: number = 20;
  headlineWeight: FontWeight = FontWeight.SemiBold;
  titleSize: number = 16;
  titleWeight: FontWeight = FontWeight.Medium;
  bodySize: number = 14;
  bodyWeight: FontWeight = FontWeight.Regular;
  labelSize: number = 12;
  labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensShapes {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

class AppTokensSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

class AppTokens {
  static readonly Colors: AppTokensColors = new AppTokensColors();
  static readonly Typography: AppTokensTypography = new AppTokensTypography();
  static readonly Shapes: AppTokensShapes = new AppTokensShapes();
  static readonly Spacing: AppTokensSpacing = new AppTokensSpacing();
}

interface MarginPadding {
  left?: Length;
  right?: Length;
  top?: Length;
  bottom?: Length;
}

@Component
struct NavIcon {
  build() {
    Button() {
      Text('<')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(AppTokens.Colors.onPrimary)
    }
    .width(24)
    .height(24)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.primary)
    .padding(0)
  }
}

@Component
struct ActionIcon {
  build() {
    Button() {
      Text('?')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(AppTokens.Colors.onSecondary)
    }
    .width(24)
    .height(24)
    .borderRadius(12)
    .backgroundColor(AppTokens.Colors.secondary)
    .padding(0)
  }
}

@Component
struct TopBar {
  private marginLeft: MarginPadding = { left: AppTokens.Spacing.lg };
  private marginRight: MarginPadding = { right: AppTokens.Spacing.lg };

  build() {
    Row() {
      NavIcon()
        .margin(this.marginLeft)

      Blank()

      Text('Sleep Cycle')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(AppTokens.Typography.displayWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      ActionIcon()
        .margin(this.marginRight)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct EmojiCircle {
  build() {
    Stack({ alignContent: Alignment.Center }) {
      Circle()
        .width(160)
        .height(160)
        .fill(AppTokens.Colors.surface)
        .stroke(AppTokens.Colors.outline)
        .strokeWidth(2)
      Text('😴')
        .fontSize(48)
    }
    .width(160)
    .height(160)
  }
}

interface PaddingConfig {
  left?: Length;
  right?: Length;
  top?: Length;
  bottom?: Length;
}

@Entry
@Component
struct SleepCycleApp {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private contentPadding: PaddingConfig = {
    left: AppTokens.Spacing.lg,
    right: AppTokens.Spacing.lg
  };

  aboutToAppear(): void {
    window.getLastWindow(this.context, (err: BusinessError, win: window.Window | undefined) => {
      if (win && !err) {
        let props: window.SystemBarProperties = {
          statusBarColor: '#00000000',
          isStatusBarVisible: false
        };
        win.setWindowSystemBarProperties(props);
      }
    });
  }

  build() {
    Column() {
      TopBar()

      Column({ space: AppTokens.Spacing.xl }) {
        Blank()

        EmojiCircle()

        Text('Welcome Back')
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(AppTokens.Typography.headlineWeight)
          .fontColor(AppTokens.Colors.onSurface)

        Text('Track your sleep patterns and improve rest quality.')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)

        Button('Sign In')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('80%')
          .height(52)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.large)

        Blank()
      }
      .width('100%')
      .layoutWeight(1)
      .padding(this.contentPadding)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.background, 0.0],
          [AppTokens.Colors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
