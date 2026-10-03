// AppTokens.ets
export class AppColors {
  primary: ResourceColor = '#FF06B6D4';
  secondary: ResourceColor = '#FF3B82F6';
  tertiary: ResourceColor = '#FF8B5CF6';
  background: ResourceColor = '#FFF0F9FF';
  surface: ResourceColor = '#CCFFFFFF';
  surfaceVariant: ResourceColor = '#FFE0F2FE';
  outline: ResourceColor = '#FFBAE6FD';
  success: ResourceColor = '#FF22C55E';
  warning: ResourceColor = '#FFFACC15';
  error: ResourceColor = '#FFEF4444';
  onPrimary: ResourceColor = '#FFFFFFFF';
  onSecondary: ResourceColor = '#FFFFFFFF';
  onTertiary: ResourceColor = '#FFFFFFFF';
  onBackground: ResourceColor = '#FF0F172A';
  onSurface: ResourceColor = '#FF0F172A';
}

export class AppTypography {
  display: TextStyle = { fontSize: 28, fontWeight: FontWeight.Bold };
  title: TextStyle = { fontSize: 18, fontWeight: FontWeight.Medium };
  body: TextStyle = { fontSize: 14, fontWeight: FontWeight.Normal };
  label: TextStyle = { fontSize: 12, fontWeight: FontWeight.Medium };
}

export class AppShapes {
  small: number = 6;
  medium: number = 12;
  large: number = 20;
}

export class AppSpacing {
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

export class ShadowSpec {
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

export class AppElevation {
  level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

export class AppTokens {
  static Colors: AppColors = new AppColors();
  static Typography: AppTypography = new AppTypography();
  static Shapes: AppShapes = new AppShapes();
  static Spacing: AppSpacing = new AppSpacing();
  static Elevation: AppElevation = new AppElevation();
}

// RootScreen.ets
@Entry
@Component
struct RootScreen {
  @State spending: number = 500.0;
  private goal: number = 1000.0;

  build() {
    Column() {
      // Top Bar
      Column() {
        Text('Bill Calendar')
          .fontSize(AppTokens.Typography.display.fontSize)
          .fontWeight(AppTokens.Typography.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface as string)
      }
      .width('100%')
      .height(56)
      .padding({ top: 10 })
      .backgroundColor(AppTokens.Colors.background as string)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Surface Card
          Column() {
            Column() {
              Text('Current Spending')
                .fontSize(AppTokens.Typography.title.fontSize)
                .fontWeight(AppTokens.Typography.title.fontWeight)
                .fontColor(AppTokens.Colors.primary as string)
              
              // Spacer equivalent
              Blank()
              
              Text(`$${Math.floor(this.spending)} / $${Math.floor(this.goal)}`)
                .fontSize(AppTokens.Typography.display.fontSize)
                .fontWeight(AppTokens.Typography.display.fontWeight)
                .fontColor(AppTokens.Colors.onSurface as string)
              
              // Spacer equivalent
              Blank()

              // LinearProgressIndicator
              Progress({ value: this.spending, total: this.goal, type: ProgressType.Linear })
                .style({ strokeWidth: 8 })
                .color(AppTokens.Colors.primary as string)
                .backgroundColor(AppTokens.Colors.surfaceVariant as string)
                .width('100%')
                .margin({ top: 8 })
            }
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .height(160)
          .borderRadius(AppTokens.Shapes.large)
          .backgroundColor(AppTokens.Colors.surface as string)
          .shadow({
            radius: AppTokens.Elevation.level2.radius,
            color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level2.dy
          })

          Text('Adjust Spending')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface as string)

          // Slider
          Slider({
            value: this.spending,
            min: 0,
            max: 2000,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.secondary as string)
            .selectedColor(AppTokens.Colors.primary as string)
            .trackColor(AppTokens.Colors.surfaceVariant as string)
            .onChange((value: number, mode: SliderChangeMode) => {
              this.spending = value;
            })

          // Button
          Button('Reset', { type: ButtonType.Normal })
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(AppTokens.Colors.onTertiary as string)
            .width('100%')
            .height(48)
            .backgroundColor(AppTokens.Colors.tertiary as string)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.spending = 0.0;
            })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        angle: 180,
        colors: [
          [AppTokens.Colors.secondary as string, 0.3],
          [AppTokens.Colors.background as string, 1.0],
          [AppTokens.Colors.primary as string, 0.2]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background as string)
  }
}