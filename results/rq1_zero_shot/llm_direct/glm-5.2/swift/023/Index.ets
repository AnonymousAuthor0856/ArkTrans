import { Length, ResourceColor } from '@ohos.arkui.UIComponent';
import { common } from '@ohos.arkui.UIAbilityContext';

class AppTokens {
  static readonly Colors: Record<string, ResourceColor> = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFCF9',
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
    onSurface: '#1E1E1E',
  };

  static readonly TypographyTokens: Record<string, Record<string, number | string>> = {
    display: { size: 30, weight: FontWeight.Bold },
    title: { size: 20, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
  };

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
  };

  static readonly ElevationMapping: Record<string, Record<string, number>> = {
    level1: { radius: 4, y: 2, opacity: 0.12 },
    level2: { radius: 8, y: 4, opacity: 0.18 },
  };
}

@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 140;
  @State knobPositionY: number = 140;
  @State isRunning: boolean = false;

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(Number(AppTokens.TypographyTokens.display.size))
            .fontWeight(Number(AppTokens.TypographyTokens.display.weight))
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.background)
        .margin({ top: AppTokens.Spacing.lg })

        // Main Content
        Column({ space: AppTokens.Spacing.xl }) {
          // Timer Circle
          Stack() {
            // Outer circle
            Circle()
              .width(280)
              .height(280)
              .fill(AppTokens.Colors.surfaceVariant)
              .shadow({
                radius: AppTokens.ElevationMapping.level2.radius,
                color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level2.y,
              })

            // Middle circle
            Circle()
              .width(180)
              .height(180)
              .fill(AppTokens.Colors.secondary)
              .opacity(0.4)

            // Knob
            Circle()
              .width(60)
              .height(60)
              .fill(AppTokens.Colors.primary)
              .markAnchor('50%', '50%')
              .position({ x: this.knobPositionX, y: this.knobPositionY })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    const center = { x: 140, y: 140 };
                    const vectorX = event.fingerList[0].localX - center.x;
                    const vectorY = event.fingerList[0].localY - center.y;
                    const distance = Math.sqrt(vectorX * vectorX + vectorY * vectorY);
                    const normalizedX = vectorX / distance;
                    const normalizedY = vectorY / distance;
                    const trackRadius = 90;
                    this.knobPositionX = center.x + normalizedX * trackRadius;
                    this.knobPositionY = center.y + normalizedY * trackRadius;
                  })
              )
          }
          .width(280)
          .height(280)

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(Number(AppTokens.TypographyTokens.title.size))
            .fontWeight(Number(AppTokens.TypographyTokens.title.weight))
            .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)

          // Start/Stop Buttons
          Row({ space: AppTokens.Spacing.lg }) {
            Button('Start')
              .fontSize(Number(AppTokens.TypographyTokens.body.size))
              .fontWeight(Number(AppTokens.TypographyTokens.body.weight))
              .fontColor(AppTokens.Colors.onPrimary)
              .width(90)
              .height(90)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = true;
              })

            Button('Stop')
              .fontSize(Number(AppTokens.TypographyTokens.body.size))
              .fontWeight(Number(AppTokens.TypographyTokens.body.weight))
              .fontColor(AppTokens.Colors.onSecondary)
              .width(90)
              .height(90)
              .backgroundColor(AppTokens.Colors.tertiary)
              .borderRadius(45)
              .onClick(() => {
                this.isRunning = false;
              })
          }

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            Capsule()
              .width('100%')
              .height(8)
              .color(AppTokens.Colors.surfaceVariant)

            // Progress
            Capsule()
              .width('40%')
              .height(8)
              .color(AppTokens.Colors.primary)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}