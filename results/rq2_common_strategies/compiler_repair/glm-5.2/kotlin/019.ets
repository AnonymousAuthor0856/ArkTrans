// Index.ets

const NAME: string = "019SubtitleEditoren";
const UI_TYPE: string = "Media";
const STYLE_THEME: string = "Clay Morph";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  primary: ResourceColor = 0xFF8B5CF6;
  secondary: ResourceColor = 0xFFD946EF;
  tertiary: ResourceColor = 0xFF3B82F6;
  background: ResourceColor = 0xFFF9F5FF;
  surface: ResourceColor = 0xFFFFFFFF;
  surfaceVariant: ResourceColor = 0xFFF1E9FE;
  outline: ResourceColor = 0xFFE3D7FE;
  success: ResourceColor = 0xFF22C55E;
  warning: ResourceColor = 0xFFFACC15;
  error: ResourceColor = 0xFFEF4444;
  onPrimary: ResourceColor = 0xFFFFFFFF;
  onSecondary: ResourceColor = 0xFFFFFFFF;
  onTertiary: ResourceColor = 0xFFFFFFFF;
  onBackground: ResourceColor = 0xFF1E1E1E;
  onSurface: ResourceColor = 0xFF1E1E1E;
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class AppShapes {
  small: number = 8;
  medium: number = 14;
  large: number = 22;
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
  level1: ShadowSpec = new ShadowSpec(4, 8, 2, 0.14);
  level2: ShadowSpec = new ShadowSpec(8, 12, 6, 0.18);
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
  static Shapes: AppShapes = new AppShapes();
  static ElevationMapping: AppElevationMapping = new AppElevationMapping();
}

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 24;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Subtitle Editor")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background);

      // Content
      Scroll() {
        Column() {
          // Sample Subtitle Surface
          Column() {
            Text("Sample Subtitle Line")
              .fontSize(this.fontSize)
              .fontColor(AppTokens.Colors.onSurface)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.ElevationMapping.level2.radius,
            color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level2.dy
          })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center);

          // Font Size Label
          Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm });

          // Font Size Slider
          Slider({
            value: this.fontSize,
            min: 16,
            max: 48,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.secondary)
            .selectedColor(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .onChange((value: number, mode: SliderChangeMode) => {
              this.fontSize = value;
            });

          // Sync Progress Label
          Text("Sync Progress")
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.sm });

          // Linear Progress Indicator
          Progress({ value: this.syncProgress * 100, total: 100, type: ProgressType.Linear })
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .width('100%')
            .height(6)
            .borderRadius(3);

          // Sync Buttons Row
          Row() {
            Button("Sync +")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .layoutWeight(1)
              .onClick(() => {
                this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
              });

            Button("Sync -")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .layoutWeight(1)
              .margin({ left: AppTokens.Spacing.md })
              .onClick(() => {
                this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
              });
          }
          .width('100%')
          .margin({ top: AppTokens.Spacing.lg });
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg);
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top);
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.surfaceVariant, 0.0],
        [AppTokens.Colors.background, 0.5],
        [AppTokens.Colors.surface, 1.0]
      ]
    });
  }
}