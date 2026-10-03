// Index.ets

const NAME = "011*MusicPlayer*en";
const UI_TYPE = "Media";
const STYLE_THEME = "Retro Flat";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

class AppColors {
  primary: ResourceColor = 0xFFEF476F;
  secondary: ResourceColor = 0xFFFFD166;
  tertiary: ResourceColor = 0xFF06D6A0;
  background: ResourceColor = 0xFFFFFCF2;
  surface: ResourceColor = 0xFFFFF8E1;
  surfaceVariant: ResourceColor = 0xFFFCE7E7;
  outline: ResourceColor = 0xFFBDBDBD;
  success: ResourceColor = 0xFF06D6A0;
  warning: ResourceColor = 0xFFFFA600;
  error: ResourceColor = 0xFFD62828;
  onPrimary: ResourceColor = 0xFFFFFFFF;
  onSecondary: ResourceColor = 0xFF1F1F1F;
  onTertiary: ResourceColor = 0xFF1F1F1F;
  onBackground: ResourceColor = 0xFF1F1F1F;
  onSurface: ResourceColor = 0xFF1F1F1F;
}

class AppTypography {
  displaySize: Length = 30;
  displayWeight: FontWeight = FontWeight.Bold;
  titleSize: Length = 18;
  titleWeight: FontWeight = FontWeight.Medium;
  bodySize: Length = 14;
  bodyWeight: FontWeight = FontWeight.Normal;
  labelSize: Length = 12;
  labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  small: number = 6;
  medium: number = 12;
  large: number = 16;
}

class AppSpacing {
  xs: Length = 4;
  sm: Length = 8;
  md: Length = 12;
  lg: Length = 16;
  xl: Length = 24;
  xxl: Length = 32;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Typography: AppTypography = new AppTypography();
  static Shapes: AppShapes = new AppShapes();
  static Spacing: AppSpacing = new AppSpacing();
}

@Entry
@Component
struct RootScreen {
  @State knobX: number = 150;
  @State knobY: number = 150;

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text("Retro Music Player")
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(AppTokens.Typography.displayWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Content
      Column() {
        // Canvas Box
        Stack() {
          // Outer Circle
          Circle({ width: 240, height: 240 })
            .fill(Color.Transparent)
            .stroke(AppTokens.Colors.secondary)
            .strokeWidth(12)
            .position({ x: 20, y: 20 })

          // Knob
          Circle({ width: 40, height: 40 })
            .fill(AppTokens.Colors.primary)
            .position({ x: this.knobX - 20, y: this.knobY - 20 })
        }
        .width(280)
        .height(280)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 3, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
        .gesture(
          PanGesture()
            .onActionUpdate((event: GestureEvent) => {
              this.knobX = event.fingerList[0].localX;
              this.knobY = event.fingerList[0].localY;
            })
        )

        Text("Track: Summer Nights")
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.lg })

        Row() {
          Button("Play")
            .width(120)
            .height(48)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)

          Button("Pause")
            .width(120)
            .height(48)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)
        .margin({ top: AppTokens.Spacing.lg })

        Text(`Knob X:${Math.floor(this.knobX)} Y:${Math.floor(this.knobY)}`)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: AppTokens.Spacing.lg })

        Blank().height(AppTokens.Spacing.xxl)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}