// AppTokens
class AppTokens {
  static readonly Colors: Record<string, string> = {
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
    onSurface: '#1E1E1E'
  }

  static readonly Typography: Record<string, TypographyStyle> = {
    display: { fontSize: 30, fontWeight: FontWeight.Bold },
    title: { fontSize: 20, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium }
  }

  static readonly Spacing: Record<string, number> = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly Elevation: Record<string, ShadowSpec> = {
    level2: { radius: 8, y: 4, opacity: 0.18 }
  }
}

interface TypographyStyle {
  fontSize: number;
  fontWeight: FontWeight;
}

interface ShadowSpec {
  radius: number;
  y: number;
  opacity: number;
}

// RootScreen
@Entry
@Component
struct RootScreen {
  @State knobPositionX: number = 140;
  @State knobPositionY: number = 140;
  @State isRunning: boolean = false;

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Spacer
        Column()
          .width('100%')
          .height(AppTokens.Spacing.lg)

        // Top Bar
        Row() {
          Text('Pomodoro Timer')
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

        // Main Content
        Column({ space: AppTokens.Spacing.xl }) {
          // Timer Circle with concentric circles
          Stack() {
            // Outer circle (background)
            Circle({ width: 280, height: 280 })
              .fill(AppTokens.Colors.surfaceVariant)
              .shadow({
                radius: AppTokens.Elevation.level2.radius,
                color: `rgba(0,0,0,${AppTokens.Elevation.level2.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.Elevation.level2.y
              })

            // Middle circle (secondary)
            Circle({ width: 180, height: 180 })
              .fill(AppTokens.Colors.secondary)
              .opacity(0.4)

            // Knob (draggable)
            Circle({ width: 60, height: 60 })
              .fill(AppTokens.Colors.primary)
              .position({ x: this.knobPositionX - 30, y: this.knobPositionY - 30 }) // Center offset
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    // Calculate angle and position to keep knob on the track
                    const centerX = 140;
                    const centerY = 140;
                    const locX = event.fingerList[0].localX;
                    const locY = event.fingerList[0].localY;
                    
                    const vectorX = locX - centerX;
                    const vectorY = locY - centerY;
                    const distance = Math.sqrt(vectorX * vectorX + vectorY * vectorY);
                    
                    const trackRadius = 90;
                    if (distance > 0) {
                      const normX = vectorX / distance;
                      const normY = vectorY / distance;
                      
                      this.knobPositionX = centerX + normX * trackRadius;
                      this.knobPositionY = centerY + normY * trackRadius;
                    }
                  })
              )
          }
          .width(280)
          .height(280)
          .margin({ top: AppTokens.Spacing.lg })

          // Focus Mode Text
          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(AppTokens.Typography.title.fontSize)
            .fontWeight(AppTokens.Typography.title.fontWeight)
            .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)

          // Start/Stop Buttons
          Row({ space: AppTokens.Spacing.lg }) {
            // Start Button
            Button('Start', { type: ButtonType.Circle })
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontWeight(AppTokens.Typography.body.fontWeight)
              .fontColor(AppTokens.Colors.onPrimary)
              .width(90)
              .height(90)
              .backgroundColor(AppTokens.Colors.primary)
              .onClick(() => {
                this.isRunning = true;
              })

            // Stop Button
            Button('Stop', { type: ButtonType.Circle })
              .fontSize(AppTokens.Typography.body.fontSize)
              .fontWeight(AppTokens.Typography.body.fontWeight)
              .fontColor(AppTokens.Colors.onSecondary)
              .width(90)
              .height(90)
              .backgroundColor(AppTokens.Colors.tertiary)
              .onClick(() => {
                this.isRunning = false;
              })
          }

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Track
            // Using Row with borderRadius to simulate Capsule
            Row()
              .width('100%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppTokens.Colors.surfaceVariant)

            // Progress (approx 40%)
            Row()
              .width('40%')
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}