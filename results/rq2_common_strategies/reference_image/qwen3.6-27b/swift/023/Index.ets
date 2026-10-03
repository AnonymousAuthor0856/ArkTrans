// entry/src/main/ets/pages/PomodoroTimerPage.ets

@Entry
@Component
struct PomodoroTimerPage {
  @State knobPosition: Point = { x: 140, y: 140 }
  @State isRunning: boolean = false

  // AppTokens equivalent
  private readonly COLORS = {
    primary: '#FF8FAB',
    secondary: '#B4E3D0',
    tertiary: '#FFD6A5',
    background: '#FFFDF9',
    surface: '#FFFFFF',
    surfaceVariant: '#FDE2E4',
    outline: '#FC C2D7',
    success: '#4ADE80',
    warning: '#FACC15',
    error: '#FB7185',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }

  private readonly TYPOGRAPHY = {
    display: { size: 30, weight: FontWeight.Bold },
    title: { size: 20, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  private readonly SPACING = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Pomodoro Timer')
          .font({ size: this.TYPOGRAPHY.display.size, weight: this.TYPOGRAPHY.display.weight })
          .foregroundColor(Color(this.COLORS.onSurface))
      }
      .width('100%')
      .height(64)
      .backgroundColor(Color(this.COLORS.background))

      // Main Content
      Column() {
        // Timer Circle with two concentric circles
        Stack() {
          // Outer circle (background)
          Circle()
            .fill(Color(this.COLORS.surfaceVariant))
            .width(280)
            .height(280)
            .shadow({ radius: 8, color: 'rgba(0,0,0,0.18)', offsetY: 4 })

          // Middle circle (secondary) - smaller radius
          Circle()
            .fill(Color(this.COLORS.secondary).withOpacity(0.4))
            .width(180)
            .height(180)

          // Knob (draggable)
          Circle()
            .fill(Color(this.COLORS.primary))
            .width(60)
            .height(60)
            .position({ x: this.knobPosition.x, y: this.knobPosition.y })
            .gesture(
              DragGesture()
                .onAction((event: GestureEvent) => {
                  const center = { x: 140, y: 140 }
                  const vector = {
                    x: event.offsetX - center.x,
                    y: event.offsetY - center.y
                  }
                  const distance = Math.sqrt(vector.x * vector.x + vector.y * vector.y)
                  if (distance > 0) {
                    const normalizedVector = {
                      x: vector.x / distance,
                      y: vector.y / distance
                    }
                    const trackRadius = 90
                    this.knobPosition = {
                      x: center.x + normalizedVector.x * trackRadius,
                      y: center.y + normalizedVector.y * trackRadius
                    }
                  }
                })
            )
        }
        .width(280)
        .height(280)

        // Focus Mode Text
        Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
          .font({ size: this.TYPOGRAPHY.title.size, weight: this.TYPOGRAPHY.title.weight })
          .foregroundColor(this.isRunning ? Color(this.COLORS.success) : Color(this.COLORS.error))
          .margin({ top: this.SPACING.xl })

        // Start/Stop Buttons
        Row() {
          Button('Start') {
            this.isRunning = true
          }
          .font({ size: this.TYPOGRAPHY.body.size, weight: this.TYPOGRAPHY.body.weight })
          .foregroundColor(Color(this.COLORS.onPrimary))
          .width(90)
          .height(90)
          .backgroundColor(Color(this.COLORS.primary))
          .borderRadius(45)

          Button('Stop') {
            this.isRunning = false
          }
          .font({ size: this.TYPOGRAPHY.body.size, weight: this.TYPOGRAPHY.body.weight })
          .foregroundColor(Color(this.COLORS.onSecondary))
          .width(90)
          .height(90)
          .backgroundColor(Color(this.COLORS.tertiary))
          .borderRadius(45)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: this.SPACING.xl })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Capsule()
            .fill(Color(this.COLORS.surfaceVariant))
            .height(8)

          // Progress - fixed at approximately 40% as shown in original image
          Capsule()
            .fill(Color(this.COLORS.primary))
            .width('40%')
            .height(8)
        }
        .width('100%')
        .padding({ left: this.SPACING.lg, right: this.SPACING.lg })
        .margin({ top: this.SPACING.xl })
      }
      .padding({ top: this.SPACING.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color(this.COLORS.background))
  }
}