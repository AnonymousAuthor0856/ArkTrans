// AppTokens: Design tokens for colors, typography, shapes, spacing, and elevation

class ColorTokens {
  primary: string = '#FF8B5CF6';
  secondary: string = '#FFD946EF';
  tertiary: string = '#FF3B82F6';
  background: string = '#FFF9F5FF';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFF1E9FE';
  outline: string = '#FFE3D7FE';
  success: string = '#FF22C55E';
  warning: string = '#FFFACC15';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FFFFFFFF';
  onBackground: string = '#FF1E1E1E';
  onSurface: string = '#FF1E1E1E';
}

class TypographyToken {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class TypographyTokens {
  display: TypographyToken = new TypographyToken(48, FontWeight.Bold);
  title: TypographyToken = new TypographyToken(18, FontWeight.Medium);
  body: TypographyToken = new TypographyToken(14, FontWeight.Normal);
  label: TypographyToken = new TypographyToken(42, FontWeight.Medium);
}

class ShapeTokens {
  small: number = 8;
  medium: number = 14;
  large: number = 22;
}

class SpacingTokens {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 32;
}

class ShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
  color: string;

  constructor(radius: number, dy: number, opacity: number, color: string) {
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = color;
  }
}

class ElevationTokens {
  level1: ShadowSpec = new ShadowSpec(4, 2, 0.14, '#24000000');
  level2: ShadowSpec = new ShadowSpec(8, 6, 0.18, '#2E000000');
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens();
  static readonly Typography: TypographyTokens = new TypographyTokens();
  static readonly Shapes: ShapeTokens = new ShapeTokens();
  static readonly Spacing: SpacingTokens = new SpacingTokens();
  static readonly Elevation: ElevationTokens = new ElevationTokens();
}

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background Gradient
      Column() {
        // Spacer to push content down below the status bar area
        Column()
          .height('8%')
          .width('100%');

        // Main Content Column
        Column({ space: AppTokens.Spacing.xl }) {
          // Sample Subtitle Line Surface
          Stack() {
            Text('Sample Subtitle Line')
              .fontSize(this.fontSize)
              .fontColor(AppTokens.Colors.onSurface)
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height(200)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({
            radius: AppTokens.Elevation.level2.radius,
            color: AppTokens.Elevation.level2.color,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level2.dy
          });

          // Font Size Label
          Text(`Font Size: ${Math.round(this.fontSize)}sp`)
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%');

          // Font Size Slider
          Slider({
            value: this.fontSize,
            min: 16,
            max: 48,
            step: 1,
            style: SliderStyle.OutSet
          })
            .blockColor(AppTokens.Colors.surface)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .selectedColor(AppTokens.Colors.primary)
            .width('100%')
            .onChange((value: number) => {
              this.fontSize = value;
            });

          // Sync Progress Label
          Text('Sync Progress')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .width('100%');

          // Linear Progress Indicator
          // ArkTS Progress component does not natively support custom track background color easily.
          // We wrap it in a Stack to simulate the track background.
          Stack({ alignContent: Alignment.Start }) {
            // Track Background
            Column()
              .width('100%')
              .height(6)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(3);

            // Progress Fill
            Column()
              .width(`${this.syncProgress * 100}%`)
              .height(6)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(3);
          }
          .width('100%')
          .height(6);

          // Buttons Row
          Row({ space: AppTokens.Spacing.md }) {
            // Sync + Button
            Button('Sync +', { type: ButtonType.Normal })
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .layoutWeight(1)
              .onClick(() => {
                this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
              });

            // Sync - Button
            Button('Sync -', { type: ButtonType.Normal })
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.medium)
              .height(48)
              .layoutWeight(1)
              .onClick(() => {
                this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
              });
          }
          .width('100%');
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .height('92%')
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

      // Top App Bar
      Column() {
        Text('Subtitle Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .height(56)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.background)
      .justifyContent(FlexAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}