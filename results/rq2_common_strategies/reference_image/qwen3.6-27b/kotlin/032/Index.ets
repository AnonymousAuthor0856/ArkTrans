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

class AppTokens {
  static Colors = {
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

  static TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    title: { fontSize: 18, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };

  static ElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.12 } as ShadowSpec,
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.16 } as ShadowSpec
  };
}

// --- Main Entry Component ---

@Entry
@Component
struct Index {
  @State progress: number = 0.4;
  private markerPosition: Point = { x: 200, y: 400 }; // Initial position similar to Kotlin Offset(200f, 400f)

  build() {
    Column() {
      // Top Bar Area (Simulating Scaffold TopBar)
      Row() {
        Text("Transfer Wizard")
          .fontStyle(AppTokens.TypographyTokens.display)
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
        Canvas(this)
          .width('100%')
          .height('100%')
          .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl })

        // Bottom Controls Column
        Column({ space: AppTokens.Spacing.lg }) {
          Text("Transfer Progress")
            .fontStyle(AppTokens.TypographyTokens.title)
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
  drawCanvas(context: CanvasRenderingContext2D, size: Size) {
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