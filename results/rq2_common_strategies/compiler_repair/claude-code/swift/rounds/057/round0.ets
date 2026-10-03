import window from '@ohos.window';
import common from '@ohos.app.ability.common';

class AppTokens {
  static readonly Colors = {
    primary: Color('#2563EB'),
    secondary: Color('#38BDF8'),
    tertiary: Color('#60A5FA'),
    background: Color('#E6F0FF'),
    surface: Color('#FFFFFF'),
    surfaceVariant: Color('#E2E8F0'),
    outline: Color('#CBD5E1'),
    success: Color('#22C55E'),
    warning: Color('#F59E0B'),
    error: Color('#EF4444'),
    onPrimary: Color('#FFFFFF'),
    onSecondary: Color('#0F172A'),
    onTertiary: Color('#FFFFFF'),
    onBackground: Color('#0F172A'),
    onSurface: Color('#1E293B')
  };

  static readonly Typography = {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    headlineSize: 20,
    headlineWeight: FontWeight.SemiBold,
    titleSize: 16,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Regular,
    labelSize: 12,
    labelWeight: FontWeight.Medium
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36
  };
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
  build() {
    Row() {
      NavIcon()
        .margin({ left: AppTokens.Spacing.lg })

      Blank()

      Text('Sleep Cycle')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(AppTokens.Typography.displayWeight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      ActionIcon()
        .margin({ right: AppTokens.Spacing.lg })
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

@Entry
@Component
struct SleepCycleApp {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  aboutToAppear(): void {
    window.getLastWindow(this.context, (err, win) => {
      if (win && !err) {
        win.setWindowSystemBarProperties({
          statusBarColor: '#00000000',
          isStatusBarVisible: false
        });
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
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
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
