interface ShadowSpec {
  radius: number
  y: number
  opacity: number
}

class AppTokens {
  static readonly Colors = {
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

  static readonly TypographyTokens = {
    displaySize: 30,
    displayWeight: FontWeight.Bold,
    titleSize: 20,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Regular,
    labelSize: 12,
    labelWeight: FontWeight.Medium
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24
  }

  static readonly ElevationMapping = {
    level1: {
      radius: 4,
      y: 2,
      opacity: 0.12
    } as ShadowSpec,
    level2: {
      radius: 8,
      y: 4,
      opacity: 0.18
    } as ShadowSpec
  }
}

@Entry
@Component
struct RootScreen {
  @State private knobX: number = 140
  @State private knobY: number = 140
  @State private isRunning: boolean = false

  private dragStartX: number = 140
  private dragStartY: number = 140

  private updateKnobPosition(rawX: number, rawY: number): void {
    const centerX: number = 140
    const centerY: number = 140
    const vectorX: number = rawX - centerX
    const vectorY: number = rawY - centerY
    const distance: number = Math.sqrt(vectorX * vectorX + vectorY * vectorY)

    if (distance <= 0) {
      return
    }

    const trackRadius: number = 90
    this.knobX = centerX + vectorX / distance * trackRadius
    this.knobY = centerY + vectorY / distance * trackRadius
  }

  build() {
    Stack() {
      Column() {
        Blank()
          .height(AppTokens.Spacing.lg)

        Row() {
          Text('Pomodoro Timer')
            .fontSize(AppTokens.TypographyTokens.displaySize)
            .fontWeight(AppTokens.TypographyTokens.displayWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

        Column({ space: AppTokens.Spacing.xl }) {
          Stack() {
            Circle()
              .width(280)
              .height(280)
              .fill(AppTokens.Colors.surfaceVariant)
              .shadow({
                radius: AppTokens.ElevationMapping.level2.radius,
                color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
                offsetX: 0,
                offsetY: AppTokens.ElevationMapping.level2.y
              })

            Circle()
              .width(180)
              .height(180)
              .fill(AppTokens.Colors.secondary)
              .opacity(0.4)

            Circle()
              .width(60)
              .height(60)
              .fill(AppTokens.Colors.primary)
              .position({
                x: this.knobX - 30,
                y: this.knobY - 30
              })
              .gesture(
                PanGesture()
                  .onActionStart(() => {
                    this.dragStartX = this.knobX
                    this.dragStartY = this.knobY
                  })
                  .onActionUpdate((event: GestureEvent) => {
                    this.updateKnobPosition(
                      this.dragStartX + event.offsetX,
                      this.dragStartY + event.offsetY
                    )
                  })
              )
          }
          .width(280)
          .height(280)

          Text(this.isRunning ? 'Focus Mode ON' : 'Focus Mode OFF')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(this.isRunning ? AppTokens.Colors.success : AppTokens.Colors.error)

          Row({ space: AppTokens.Spacing.lg }) {
            Button() {
              Text('Start')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(AppTokens.Colors.primary)
            .type(ButtonType.Normal)
            .onClick(() => {
              this.isRunning = true
            })

            Button() {
              Text('Stop')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(AppTokens.Colors.onSecondary)
            }
            .width(90)
            .height(90)
            .borderRadius(45)
            .backgroundColor(AppTokens.Colors.tertiary)
            .type(ButtonType.Normal)
            .onClick(() => {
              this.isRunning = false
            })
          }

          Stack({ alignContent: Alignment.Start }) {
            Capsule()
              .width('100%')
              .height(8)
              .fill(AppTokens.Colors.surfaceVariant)

            Capsule()
              .width('40%')
              .height(8)
              .fill(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(8)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
        }
        .width('100%')
        .padding({
          top: AppTokens.Spacing.lg
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}