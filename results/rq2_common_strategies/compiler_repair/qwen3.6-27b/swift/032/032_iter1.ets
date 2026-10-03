import { BusinessError } from '@kit.BasicServicesKit';
import { common, window } from '@kit.ArkUI';

// MARK: - AppTokens
// Encapsulates all design tokens for the application, facilitating centralized management and modification.
export class AppTokens {
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
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32
  };
}

interface Point {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  // @State variables correspond to Kotlin's mutableStateOf, used to manage UI state.
  // markerPosition initial value (200f, 400f) directly mapped to Point(x: 200, y: 400),
  // assuming they are points in the Canvas internal coordinate system.
  @State markerPosition: Point = { x: 200, y: 400 };
  @State progress: number = 0.4;

  build() {
    // Top-level ZStack simulates the content area of Scaffold and handles background gradient.
    Stack({ alignContent: Alignment.Top }) {
      // Background gradient, corresponding to Kotlin's Brush.verticalGradient
      Column() {
        Blank()
      }
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(255, 195, 0, 0.2)', 0],
          ['#FFFBF2', 0.5],
          ['rgba(255, 165, 0, 0.2)', 1]
        ]
      })
      .width('100%')
      .height('100%')
      .position({ x: 0, y: 0 })

      // VStack simulates the structure of Scaffold: top bar + main content area
      Column() {
        // Top bar, corresponding to Kotlin's CenterAlignedTopAppBar
        Row() {
          Text("Transfer Wizard")
            .font({ size: AppTokens.TypographyTokens.display.size, weight: AppTokens.TypographyTokens.display.weight })
            .fontColor(AppTokens.Colors.onSurface)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56) // Standard AppBar height
        .backgroundColor(AppTokens.Colors.background)

        // Main content area, using GridContainer or just a flexible column to get available space dimensions
        // In ArkTS, we often use Flex or Column with layoutWeight to fill remaining space
        Column() {
          // ZStack corresponds to Kotlin's Box, used to overlay Canvas and bottom controls
          Stack({ alignContent: Alignment.Center }) {
            // Canvas view, used for custom drawing of circles
            Canvas(this.renderContext)
              .draw((context: CanvasRenderingContext2D, size: Size) => {
                const center = { x: size.width / 2, y: size.height / 2 };

                // Draw large background circle, corresponding to Kotlin's drawCircle(radius = 260f)
                context.beginPath();
                context.arc(center.x, center.y, 260, 0, 2 * Math.PI);
                context.fillStyle = AppTokens.Colors.surfaceVariant;
                context.fill();

                // Draw marker circle, corresponding to Kotlin's drawCircle(radius = 20f, center = markerPosition)
                context.beginPath();
                context.arc(this.markerPosition.x, this.markerPosition.y, 20, 0, 2 * Math.PI);
                context.fillStyle = AppTokens.Colors.primary;
                context.fill();
              })
              .padding(AppTokens.Spacing.xl)
              .layoutWeight(1) // Fill available vertical space
              .width('100%')

            // Bottom content area (Transfer Progress, progress bar, buttons)
            // VStack corresponds to Kotlin's Column, and sets spacing
            Column({ space: AppTokens.Spacing.lg }) {
              Text("Transfer Progress")
                .font({ size: AppTokens.TypographyTokens.title.size, weight: AppTokens.TypographyTokens.title.weight })
                .fontColor(AppTokens.Colors.onSurface)

              // Linear progress bar, using custom style
              Progress({ value: this.progress, total: 1.0, type: ProgressType.Linear })
                .width('80%') // Width fills 80%, corresponding to Kotlin's .fillMaxWidth(0.8f)
                .height(8) // Corresponds to Kotlin's 8.dp
                .trackColor(AppTokens.Colors.surfaceVariant)
                .color(AppTokens.Colors.primary)

              // Button row, corresponding to Kotlin's Row, and sets spacing
              Row({ space: AppTokens.Spacing.md }) {
                // "+" button
                Button() {
                  Text("+")
                    .font({ size: 24, weight: FontWeight.Bold })
                    .width(64)
                    .height(64)
                    .textAlign(TextAlign.Center)
                    .lineHeight(64)
                }
                .onClick(() => {
                  this.progress = Math.min(this.progress + 0.1, 1.0); // Corresponds to Kotlin's coerceAtMost
                })
                .backgroundColor(AppTokens.Colors.primary)
                .foregroundColor(AppTokens.Colors.onPrimary)
                .borderRadius(32) // Clip to circle, corresponding to Kotlin's CircleShape

                // "-" button
                Button() {
                  Text("-")
                    .font({ size: 24, weight: FontWeight.Bold })
                    .width(64)
                    .height(64)
                    .textAlign(TextAlign.Center)
                    .lineHeight(64)
                }
                .onClick(() => {
                  this.progress = Math.max(this.progress - 0.1, 0.0); // Corresponds to Kotlin's coerceAtLeast
                })
                .backgroundColor(AppTokens.Colors.secondary)
                .foregroundColor(AppTokens.Colors.onSecondary)
                .borderRadius(32) // Clip to circle
              }
            }
            // Align VStack to bottom, corresponding to Kotlin's .align(Alignment.BottomCenter)
            .alignRules({
              bottom: { align: VerticalAlign.Bottom, anchor: '__container__' },
              center: { align: HorizontalAlign.Center, anchor: '__container__' }
            })
            // Bottom padding, corresponding to Kotlin's .padding(bottom = AppTokens.Spacing.xxl)
            .padding({ bottom: AppTokens.Spacing.xxl })
          }
        }
        .layoutWeight(1) // Fill remaining vertical space
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // Overall background color, visible where gradient doesn't cover
    .systemBarProperties({ safeArea: SafeAreaType.NONE }) // Ignore all safe areas, achieve full screen
  }
  
  private renderContext: CanvasRenderingContext2D = new CanvasRenderingContext2D();
}