// entry/src/main/ets/pages/Index.ets

import { router } from '@kit.ArkUI';

// --- App Tokens & Theme Constants ---

const NAME = "033TransferWizarden";
const UI_TYPE = "Finance";
const STYLE_THEME = "Warm Gradient";
const LANG = "en";
const BASELINE_SIZE = "720x1280";

interface ShadowSpec {
  elevation: number; // in vp
  radius: number;    // in vp
  dy: number;        // in vp
  opacity: number;   // 0-1
}

interface TypographyToken {
  fontSize: number;
  fontWeight: FontWeight;
}

class Point {
  x: number;
  y: number;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

interface ColorMap {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyMap {
  display: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface SpacingMap {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ElevationMap {
  level1: ShadowSpec;
  level2: ShadowSpec;
}

class AppTokens {
  static Colors: ColorMap = {
    primary: '#FFA500',
    secondary: '#FFC300',
    tertiary: '#FFE066',
    background: '#FFFBF2',
    surface: '#FFFFFF',
    surfaceVariant: '#FFEED6',
    outline: '#F1C27D',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static TypographyTokens: TypographyMap = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Spacing: SpacingMap = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping: ElevationMap = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 }
  };
}

// --- Main Entry Component ---

@Entry
@Component
struct Index {
  @State progress: number = 0.4;
  private markerPosition: Point = new Point(200, 400); // Initial position similar to Kotlin Offset(200f, 400f)

  build() {
    Column() {
      // Top Bar Area (Simulating Scaffold TopBar)
      Row() {
        Text("Transfer Wizard")
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      Stack({ alignContent: Alignment.Bottom }) {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [AppTokens.Colors.secondary, 0.2],
              [AppTokens.Colors.background, 0.5],
              [AppTokens.Colors.primary, 0.2]
            ]
          })

        // Canvas Layer
        Canvas(this.drawCanvas)
          .width('100%')
          .height('100%')
          .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl })

        // Bottom Controls Column
        Column({ space: AppTokens.Spacing.lg }) {
          Text("Transfer Progress")
            .fontSize(AppTokens.TypographyTokens.title.fontSize)
            .fontWeight(AppTokens.TypographyTokens.title.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)

          // Linear Progress Indicator
          Row() {
            if (this.progress > 0) {
              Row()
                .width(`${this.progress * 100}%`)
                .height(8)
                .borderRadius(4)
                .backgroundColor(AppTokens.Colors.primary)
            }
          }
          .width('80%')
          .height(8)
          .borderRadius(4)
          .backgroundColor(AppTokens.Colors.surfaceVariant)

          // Action Buttons
          Row({ space: AppTokens.Spacing.md }) {
            Button("+")
              .type(ButtonType.Capsule)
              .backgroundColor(AppTokens.Colors.primary)
              .fontColor(AppTokens.Colors.onPrimary)
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

            Button("-")
              .type(ButtonType.Capsule)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
          }
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: AppTokens.Spacing.xxl })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  // Canvas Drawing Logic
  drawCanvas(context: CanvasRenderingContext2D): void {
    const size = context.canvasSize;
    const centerX = size.width / 2;
    const centerY = size.height / 2;

    // Draw large background circle
    context.beginPath();
    context.arc(centerX, centerY, 260, 0, 2 * Math.PI, false);
    context.fillStyle = AppTokens.Colors.surfaceVariant;
    context.fill();

    // Draw small marker dot
    context.beginPath();
    context.arc(this.markerPosition.x, this.markerPosition.y, 20, 0, 2 * Math.PI, false);
    context.fillStyle = AppTokens.Colors.primary;
    context.fill();
  }
}