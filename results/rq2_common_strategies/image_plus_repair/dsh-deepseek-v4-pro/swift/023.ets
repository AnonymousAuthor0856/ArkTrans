// MARK: - AppTokens

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

class Colors {
  static readonly primary: string = '#FF8FAB';
  static readonly secondary: string = '#B4E3D0';
  static readonly tertiary: string = '#FFD6A5';
  static readonly background: string = '#FFFCF9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FDE2E4';
  static readonly outline: string = '#FCC2D7';
  static readonly success: string = '#4ADE80';
  static readonly warning: string = '#FACC15';
  static readonly error: string = '#FB7185';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#1E1E1E';
  static readonly onTertiary: string = '#1E1E1E';
  static readonly onBackground: string = '#1E1E1E';
  static readonly onSurface: string = '#1E1E1E';
}

class TypographyTokens {
  static readonly display: TypographyToken = { size: 30, weight: FontWeight.Bold };
  static readonly title: TypographyToken = { size: 20, weight: FontWeight.Medium };
  static readonly body: TypographyToken = { size: 14, weight: FontWeight.Regular };
  static readonly label: TypographyToken = { size: 12, weight: FontWeight.Medium };
}

class Spacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

class ElevationMapping {
  static readonly level1: ShadowSpec = { radius: 4, y: 2, opacity: 0.12 };
  static readonly level2: ShadowSpec = { radius: 8, y: 4, opacity: 0.18 };
}

// Builds a translucent black color string from an opacity value (0..1).
function blackWithOpacity(opacity: number): string {
  let alpha: number = Math.round(opacity * 255);
  let hex: string = alpha.toString(16);
  if (hex.length < 2) {
    hex = '0' + hex;
  }
  return '#000000' + hex.toUpperCase();
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State knobPositionX: number = 140;
  @State knobPositionY: number = 140;
  @State isRunning: boolean = false;

  build() {
    Stack() {
      // Background color (ignores safe area)
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(Colors.background)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      Column({ space: 0 }) {
        // Top Bar with less space above
        Blank()
          .height(Spacing.lg)

        Row() {
          Text('Pomodoro Timer')
            .fontSize(TypographyTokens.display.size)
            .fontWeight(TypographyTokens.display.weight)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(64)
        .backgroundColor(Colors.background)

        // Main Content
        Column({ space: Spacing.xl }) {
          // Timer Circle with two concentric circles
          Stack() {
            // Outer circle (background)
            Circle()
              .fill(Colors.surfaceVariant)
              .width(280)
              .height(280)
              .shadow({
                radius: ElevationMapping.level2.radius,
                color: blackWithOpacity(ElevationMapping.level2.opacity),
                offsetX: 0,
                offsetY: ElevationMapping.level2.y
              })

            // Middle circle (secondary) - smaller radius
            Circle()
              .fill(Colors.secondary)
              .fillOpacity(0.4)
              .width(180)
              .height(180) // 缩小绿色圆的半径

            // Knob (draggable)
            Circle()
              .fill(Colors.primary)
              .width(60)
              .height(60)
              .position({ x: this.knobPositionX - 30, y: this.knobPositionY - 30 })
              .gesture(
                PanGesture({ fingers: 1 })
                  .onActionUpdate((event: GestureEvent) => {
                    // Calculate angle and position to keep knob on the track
                    const center: number = 140;
                    const vectorX: number = event.offsetX;
                    const vectorY: number = event.offsetY;
                    const distance: number = Math.sqrt(vectorX * vectorX + vectorY * vectorY);
                    const normalizedX: number = distance === 0 ? 0 : vectorX / distance;
                    const normalizedY: number = distance === 0 ? 0 : vectorY / distance;

                    // Keep knob on the track (radius = 90 for 180 diameter circle)
                    const trackRadius: number = 90;
                    this.knobPositionX = center + normalizedX * trackRadius;
                    this.knobPositionY = center + normalizedY * trackRadius;
                  })
              )
          }
          .width(280)
          .height(280)

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(TypographyTokens.title.size)
            .fontWeight(TypographyTokens.title.weight)
            .fontColor(this.isRunning ? Colors.success : Colors.error)

          // Start/Stop Buttons
          Row({ space: Spacing.lg }) {
            Button() {
              Text('Start')
                .fontSize(TypographyTokens.body.size)
                .fontWeight(TypographyTokens.body.weight)
                .fontColor(Colors.onPrimary)
            }
            .width(90)
            .height(90)
            .backgroundColor(Colors.primary)
            .borderRadius(45)
            .onClick(() => { this.isRunning = true; })

            Button() {
              Text('Stop')
                .fontSize(TypographyTokens.body.size)
                .fontWeight(TypographyTokens.body.weight)
                .fontColor(Colors.onSecondary)
            }
            .width(90)
            .height(90)
            .backgroundColor(Colors.tertiary)
            .borderRadius(45)
            .onClick(() => { this.isRunning = false; })
          }

          // Progress Bar - fixed to match original design (approx 40% filled)
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Row()
              .width('100%')
              .height(8)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(4)

            // Progress - fixed at approximately 40% as shown in original image
            Row()
              .width('40%') // 40% of the width
              .height(8)
              .backgroundColor(Colors.primary)
              .borderRadius(4)
          }
          .padding({ left: Spacing.lg, right: Spacing.lg })
        }
        .padding({ top: Spacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    // statusBar(hidden: true) is configured at the window level in ArkUI
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct PomodoroTimerApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}
