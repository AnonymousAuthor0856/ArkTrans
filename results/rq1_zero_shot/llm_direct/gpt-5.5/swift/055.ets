class AppColors {
  static readonly primary: ResourceColor = 0xFF2563EB;
  static readonly secondary: ResourceColor = 0xFF38BDF8;
  static readonly tertiary: ResourceColor = 0xFF3B82F6;
  static readonly background: ResourceColor = 0xFFF8FAFC;
  static readonly surface: ResourceColor = 0xFFFFFFFF;
  static readonly surfaceVariant: ResourceColor = 0xFFE2E8F0;
  static readonly outline: ResourceColor = 0xFFCBD5E1;
  static readonly success: ResourceColor = 0xFF22C55E;
  static readonly warning: ResourceColor = 0xFFF59E0B;
  static readonly error: ResourceColor = 0xFFEF4444;
  static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
  static readonly onSecondary: ResourceColor = 0xFF0F172A;
  static readonly onTertiary: ResourceColor = 0xFFFFFFFF;
  static readonly onBackground: ResourceColor = 0xFF0F172A;
  static readonly onSurface: ResourceColor = 0xFF1E293B;
}

class AppTypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: number = 700;

  static readonly headlineSize: number = 20;
  static readonly headlineWeight: number = 600;

  static readonly titleSize: number = 16;
  static readonly titleWeight: number = 500;

  static readonly bodySize: number = 14;
  static readonly bodyWeight: number = 400;

  static readonly labelSize: number = 12;
  static readonly labelWeight: number = 500;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
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
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.16);
}

@Entry
@Component
struct RootScreen {
  private readonly topBarHeight: number = 64;
  private readonly bottomBarHeight: number = 80;
  private readonly fabSize: number = 56;

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Workout Plan')
            .fontSize(AppTypographyTokens.displaySize)
            .fontWeight(AppTypographyTokens.displayWeight)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .height(this.topBarHeight)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)

        Column({ space: AppSpacing.lg }) {
          Text('Sign In to Continue')
            .fontSize(AppTypographyTokens.headlineSize)
            .fontWeight(AppTypographyTokens.headlineWeight)
            .fontColor(AppColors.onSurface)

          Stack({ alignContent: Alignment.Center }) {
            Text('Workout Preview')
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(AppTypographyTokens.bodyWeight)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppShapes.large
          })

          Button() {
            Text('Authenticate')
              .fontSize(AppTypographyTokens.titleSize)
              .fontWeight(AppTypographyTokens.titleWeight)
              .fontColor(AppColors.onPrimary)
          }
          .type(ButtonType.Normal)
          .width('80%')
          .height(52)
          .padding(0)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick(() => {
          })

          Blank()
            .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg
        })
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppColors.background)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [0x1A38BDF8, 0.0],
            [0x262563EB, 1.0]
          ]
        })

        Row() {
          Text('Home')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppColors.primary)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Text('Plan')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)

          Text('Profile')
            .fontSize(AppTypographyTokens.titleSize)
            .fontWeight(AppTypographyTokens.titleWeight)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .layoutWeight(1)
        }
        .width('100%')
        .height(this.bottomBarHeight)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: AppElevationMapping.level2.radius,
          color: 0x240F172A,
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button() {
        Text('+')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(AppTypographyTokens.displayWeight)
          .fontColor(AppColors.onPrimary)
      }
      .type(ButtonType.Normal)
      .width(this.fabSize)
      .height(this.fabSize)
      .padding(0)
      .backgroundColor(AppColors.primary)
      .borderRadius(this.fabSize / 2)
      .margin({
        right: AppSpacing.lg,
        bottom: this.bottomBarHeight + AppSpacing.lg
      })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}