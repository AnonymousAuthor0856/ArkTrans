import { window } from '@kit.ArkUI';

// MARK: - AppTokens
class AppTokens {
  static Colors = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFDF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    outline: '#FCC2D7',
    success: '#4ADE80',
    warning: '#FACC15',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  };

  static TypographyTokens = {
    display: { size: 30, weight: FontWeight.Bold },
    title: { size: 20, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  };

  static ElevationMapping = {
    level1: { radius: 4, y: 2, opacity: 0.12 },
    level2: { radius: 8, y: 4, opacity: 0.18 }
  };
}

@Entry
@Component
struct RootScreen {
  @State knobPosition: Point = { x: 140, y: 140 };
  @State isRunning: boolean = false;
  private centerPoint: Point = { x: 140, y: 140 };
  private trackRadius: number = 90;

  build() {
    Column() {
      // Top Bar with less space above
      Row()
        .width('100%')
        .height(64)
        .backgroundColor(AppTokens.Colors.background)
        .justifyContent(FlexAlign.Start)
        .padding({ left: AppTokens.Spacing.lg })
        .child((_) => {
          Text("Pomodoro Timer")
            .font-size(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        })

      // Main Content
      Column() {
        // Timer Circle with two concentric circles
        Stack() {
          // Outer circle (background)
          Circle()
            .fill(AppTokens.Colors.surfaceVariant)
            .width(280)
            .height(280)
            .shadow({
              radius: AppTokens.ElevationMapping.level2.radius,
              color: Color.Black.opacity(AppTokens.ElevationMapping.level2.opacity),
              offsetX: 0,
              offsetY: AppTokens.ElevationMapping.level2.y
            })

          // Middle circle (secondary) - smaller radius
          Circle()
            .fill(Color(AppTokens.Colors.secondary).opacity(0.4))
            .width(180)
            .height(180)

          // Knob (draggable)
          Circle()
            .fill(AppTokens.Colors.primary)
            .width(60)
            .height(60)
            .position(this.knobPosition)
            .gesture(
              DragGesture()
                .onActionEnd((event: GestureEvent) => {
                  if (event) {
                    const vectorX = event.endX - this.centerPoint.x;
                    const vectorY = event.endY - this.centerPoint.y;
                    const distance = Math.sqrt(vectorX * vectorX + vectorY * vectorY);
                    
                    if (distance > 0) {
                      const normalizedX = vectorX / distance;
                      const normalizedY = vectorY / distance;
                      
                      this.knobPosition = {
                        x: this.centerPoint.x + normalizedX * this.trackRadius,
                        y: this.centerPoint.y + normalizedY * this.trackRadius
                      };
                    }
                  }
                })
            )
        }
        .width(280)
        .height(280)

        // Focus Mode Text
        Text(this.isRunning ? "Focus Mode ON" : "Focus Mode OFF")
          .font-size(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)
          .margin({ top: AppTokens.Spacing.xl })

        // Start/Stop Buttons
        Row() {
          Button("Start", { type: ButtonType.Circle })
            .width(90)
            .height(90)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .font-size(AppTokens.TypographyTokens.body.size)
            .onClick(() => {
              this.isRunning = true;
            })

          Button("Stop", { type: ButtonType.Circle })
            .width(90)
            .height(90)
            .backgroundColor(AppTokens.Colors.tertiary)
            .fontColor(AppTokens.Colors.onSecondary)
            .font-size(AppTokens.TypographyTokens.body.size)
            .margin({ left: AppTokens.Spacing.lg })
            .onClick(() => {
              this.isRunning = false;
            })
        }
        .margin({ top: AppTokens.Spacing.xl })

        // Progress Bar
        Row() {
          // Track
          Capsule()
            .fill(AppTokens.Colors.surfaceVariant)
            .height(8)
            .width('100%')

          // Progress - fixed at approximately 40% as shown in original image
          Capsule()
            .fill(AppTokens.Colors.primary)
            .height(8)
            .width('40%')
        }
        .alignItems(VerticalAlign.Top)
        .margin({ top: AppTokens.Spacing.xl })
      }
      .padding({ top: AppTokens.Spacing.lg })
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}