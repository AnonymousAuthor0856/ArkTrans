class AppTokens {
  static readonly Colors = {
    primary: '#FF00FFFF',
    secondary: '#FF00B4FF',
    tertiary: '#FF8A2BE2',
    background: '#FF0A0A1A',
    surface: '#FF141436',
    surfaceVariant: '#FF1E1E4A',
    outline: '#FF2E2E5C',
    success: '#FF00FFAA',
    warning: '#FFFFCC00',
    error: '#FFFF4444',
    onPrimary: '#FF0A0A1A',
    onSecondary: '#FFFFFFFF',
    onBackground: '#FFFFFFFF',
    onSurface: '#FFFFFFFF',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 14,
    large: 22,
  }
  static readonly Spacing = {
    sm: 6,
    md: 10,
    lg: 16,
    xl: 24,
    xxl: 36,
  }
}

@Entry
@Component
struct RootScreen {
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))

  private drawCanvas() {
    const ctx = this.canvasContext
    const w = 276
    const h = 240
    const count = this.stations.length
    const step = w / (count - 1)

    ctx.clearRect(0, 0, w, h)

    ctx.beginPath()
    for (let i = 0; i < count; i++) {
      const x = i * step
      const y = i % 2 === 0 ? h / 4 : h * 3 / 4
      if (i === 0) {
        ctx.moveTo(x, y)
      } else {
        ctx.lineTo(x, y)
      }
    }
    const grad = ctx.createLinearGradient(0, 0, w, 0)
    grad.addColorStop(0, AppTokens.Colors.secondary)
    grad.addColorStop(1, AppTokens.Colors.primary)
    ctx.strokeStyle = grad
    ctx.lineWidth = 6
    ctx.stroke()

    for (let i = 0; i < count; i++) {
      const x = i * step
      const y = i % 2 === 0 ? h / 4 : h * 3 / 4
      ctx.fillStyle = AppTokens.Colors.primary
      ctx.beginPath()
      ctx.arc(x, y, 16, 0, Math.PI * 2)
      ctx.fill()
      ctx.fillStyle = AppTokens.Colors.background
      ctx.beginPath()
      ctx.arc(x, y, 6, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: AppTokens.Spacing.lg }) {
        Text('Metro Planner')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(260)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.large)
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

        Column({ space: AppTokens.Spacing.sm }) {
          Text('Next Departures')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.secondary)

          ForEach(this.departures, (d: string) => {
            Row() {
              Text(d)
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1)

              Text('On Time')
                .fontSize(AppTokens.Typography.label.size)
                .fontWeight(AppTokens.Typography.label.weight)
                .fontColor(AppTokens.Colors.success)
            }
            .width('100%')
          })
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({ radius: 8, color: '#262E2E5C', offsetY: 4 })
        .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: 56 })
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.Colors.background, 0.0], [AppTokens.Colors.surfaceVariant, 0.5], [AppTokens.Colors.background, 1.0]]
      })

      Stack({ alignContent: Alignment.BottomEnd }) {
        Button('+')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width(56)
          .height(56)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(28)
          .margin({ right: AppTokens.Spacing.lg, bottom: 56 + AppTokens.Spacing.lg })
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Text('Routes')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.secondary)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Planner')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Tickets')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)

          Text('Profile')
            .fontSize(AppTokens.Typography.body.size)
            .fontWeight(AppTokens.Typography.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}