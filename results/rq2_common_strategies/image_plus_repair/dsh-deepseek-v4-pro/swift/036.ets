// ArkTS (HarmonyOS ArkUI) translation of 036.swift
// Source: SwiftUI crypto market demo.

// MARK: - AppTokens Definition

// Dp (Density-independent pixel) equivalent for easy scaling; in ArkUI sizes are in vp/fp units.

// Colors as ARGB hex strings (0xFFRRGGBB format, assuming full opacity).
class AppTokensColors {
  static readonly primary: string = '#FFFFA8A8';
  static readonly secondary: string = '#FFFFE1A8';
  static readonly tertiary: string = '#FFA8FFE1';
  static readonly background: string = '#FFFFFCF5';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFF7F7F7';
  static readonly outline: string = '#FFE2E2E2';
  static readonly success: string = '#FF22C55E';
  static readonly warning: string = '#FFF59E0B';
  static readonly error: string = '#FFEF4444';
  static readonly onPrimary: string = '#FF1E1E1E';
  static readonly onSecondary: string = '#FF1E1E1E';
  static readonly onTertiary: string = '#FF1E1E1E';
  static readonly onBackground: string = '#FF1E1E1E';
  static readonly onSurface: string = '#FF1E1E1E';
}

class TypographyTokens {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class ShapesTokens {
  static readonly small: number = 6;
  static readonly medium: number = 12;
  static readonly large: number = 20;
}

class SpacingTokens {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
}

class ShadowSpec {
  elevation: number; // Not directly used for ArkUI shadow, but kept for reference
  radius: number;
  dy: number;
  opacity: number; // Kotlin's Float mapped to number
  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.18);
}

// MARK: - Custom Styles

// Custom linear progress to visually match Android's LinearProgressIndicator.
@Component
struct LinearProgress {
  @Prop value: number = 0;
  @Prop tint: string = '#000000';
  @Prop track: string = '#000000';

  build() {
    Stack({ alignContent: Alignment.Start }) {
      // Track: half of height 8.dp
      Row()
        .width('100%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.track)

      // Fill tinted bar
      Row()
        .width((Math.round(this.value * 100)).toString() + '%')
        .height(8)
        .borderRadius(4)
        .backgroundColor(this.tint)
    }
    .width('100%')
  }
}

// Custom switch toggle to visually match Android's Switch.
@Component
struct CustomSwitchToggle {
  @Link isOn: boolean;
  @Prop checkedThumbColor: string = '#FFFFE1A8';
  @Prop uncheckedThumbColor: string = '#FFE2E2E2';

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Thumb circle, inset slightly from the capsule edge
      Row()
        .width(27)
        .height(27)
        .borderRadius(14)
        .backgroundColor(this.isOn ? this.checkedThumbColor : this.uncheckedThumbColor)
        .shadow({ radius: 2, offsetY: 1, color: 'rgba(0,0,0,0.1)' })
        .offset({ x: this.isOn ? 10 : -10 })
    }
    .width(51)
    .height(31)
    .borderRadius(16)
    .backgroundColor(this.isOn ? AppTokensColors.primary : AppTokensColors.surfaceVariant)
    .onClick(() => {
      this.isOn = !this.isOn;
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
  }
}

// Custom chip view to match Android's FilterChip.
@Component
struct FilterChipView {
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Button(this.text)
      .fontSize(TypographyTokens.labelSize)
      .fontWeight(TypographyTokens.labelWeight)
      .fontColor(AppTokensColors.onPrimary)
      .backgroundColor(this.isSelected ? AppTokensColors.primary : AppTokensColors.surfaceVariant)
      .borderRadius(ShapesTokens.small)
      .padding({ left: SpacingTokens.md, right: SpacingTokens.md, top: SpacingTokens.sm, bottom: SpacingTokens.sm })
      .onClick(() => {
        this.action();
      })
  }
}

// MARK: - RootScreen View

@Entry
@Component
struct RootScreen {
  @State selectedChip: string = 'BTC';
  @State progress: number = 0.6; // Kotlin's Float maps to number for the progress
  @State isAutoUpdate: boolean = true;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private drawWave(): void {
    const w: number = this.context.width;
    const h: number = this.context.height;
    const step: number = w / 30;
    const initialPrevY: number = h / 2; // Initial prevY from Kotlin code

    this.context.beginPath();
    // Start the path at the point corresponding to (x - step, prevY) for i=0
    this.context.moveTo(-step, initialPrevY);
    for (let i: number = 0; i <= 30; i++) { // Loop from 0 to 30 (inclusive)
      const x: number = i * step;
      const y: number = h / 2 + Math.sin(i * Math.PI / 6 + this.progress * Math.PI) * (h / 3);
      this.context.lineTo(x, y); // Add line segment
    }
    this.context.lineWidth = 5;
    this.context.strokeStyle = AppTokensColors.primary;
    this.context.stroke();
  }

  build() {
    Stack() { // Overall Stack for the base background color and main content stack
      // Base background color (Scaffold's containerColor and TopAppBar's containerColor)
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokensColors.background)

      Column({ space: 0 }) { // Main content stack, spacing 0 to control padding manually
        // Top Bar (mimics CenterAlignedTopAppBar)
        Text('Crypto Market')
          .fontSize(TypographyTokens.displaySize)
          .fontWeight(TypographyTokens.displayWeight)
          .fontColor(AppTokensColors.onSurface)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: SpacingTokens.lg, bottom: SpacingTokens.lg }) // Vertical padding for visual height
          .backgroundColor(AppTokensColors.background) // Top bar's specific background color

        // Content area (mimics Column with padding and background gradient)
        Column({ space: SpacingTokens.lg }) { // Corresponds to Column's verticalArrangement
          // Filter Chips Row
          Row({ space: SpacingTokens.md }) { // Corresponds to Row's horizontalArrangement
            ForEach(['BTC', 'ETH', 'SOL', 'ADA'], (chipText: string) => {
              FilterChipView({
                text: chipText,
                isSelected: this.selectedChip === chipText,
                action: () => {
                  this.selectedChip = chipText;
                }
              })
            }, (chipText: string) => chipText)
          }

          // Chart Surface
          Stack() { // Used for applying background, corner radius, and shadow
            Column()
              .width('100%')
              .height('100%')
              .borderRadius(ShapesTokens.large)
              .backgroundColor(AppTokensColors.surface) // Surface background color
              .shadow({
                radius: ElevationMapping.level2.radius,
                offsetY: ElevationMapping.level2.dy,
                color: 'rgba(0,0,0,' + ElevationMapping.level2.opacity.toString() + ')'
              })

            // Canvas for drawing the waveform
            Canvas(this.context)
              .width('100%')
              .height('100%')
              .padding(SpacingTokens.lg) // Padding inside the Surface for the Canvas
              .onReady(() => {
                this.drawWave();
              })
          }
          .width('100%')
          .height(260) // fillMaxWidth().height(260.dp)

          // Price Variation Text
          Text('Price Variation')
            .fontSize(TypographyTokens.titleSize)
            .fontWeight(TypographyTokens.titleWeight)
            .fontColor(AppTokensColors.primary)

          // Linear Progress Indicator
          LinearProgress({
            value: this.progress,
            tint: AppTokensColors.primary,
            track: AppTokensColors.surfaceVariant
          })
          .width('100%')
          .height(8) // height(8.dp)

          // Auto Update Row
          Row() {
            Text('Auto Update')
              .fontSize(TypographyTokens.bodySize)
              .fontWeight(TypographyTokens.bodyWeight)
              .fontColor(AppTokensColors.onSurface)

            Blank() // Pushes the toggle to the right

            CustomSwitchToggle({
              isOn: $isAutoUpdate,
              checkedThumbColor: AppTokensColors.secondary,
              uncheckedThumbColor: AppTokensColors.outline
            })
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1) // fillMaxSize() for the content area
        .padding(SpacingTokens.lg) // Corresponds to padding(AppTokens.Spacing.lg) on the Column
        .linearGradient({
          direction: GradientDirection.Bottom, // Vertical gradient background
          colors: [
            ['#4DFFE1A8', 0.0],
            ['#FFFFFCF5', 0.5],
            ['#4DA8FFE1', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // Hide the status bar for the entire view
  }
}
