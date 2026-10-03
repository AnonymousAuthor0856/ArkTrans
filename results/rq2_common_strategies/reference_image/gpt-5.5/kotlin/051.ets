class AppColors {
  static primary: string = '#00FFFF'
  static secondary: string = '#00B4FF'
  static background: string = '#0A0A1A'
  static surface: string = '#141436'
  static surfaceVariant: string = '#1E1E4A'
  static success: string = '#00FFAA'
  static onPrimary: string = '#0A0A1A'
  static onSurface: string = '#FFFFFF'
}

class AppSpacing {
  static sm: number = 6
  static md: number = 10
  static lg: number = 16
  static xl: number = 24
}

class AppRadius {
  static large: number = 22
}

interface NavItem {
  label: string
  selected: boolean
}

@Entry
@Component
struct Index {
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true))
  private stations: string[] = ['A', 'B', 'C', 'D', 'E', 'F']
  private departures: string[] = ['08:45 • Line 1', '09:10 • Line 2', '09:30 • Line 3']
  private navItems: NavItem[] = [
    { label: 'Routes', selected: true },
    { label: 'Planner', selected: false },
    { label: 'Tickets', selected: false },
    { label: 'Profile', selected: false }
  ]

  private drawMetroLine(): void {
    const canvasWidth: number = this.canvasContext.width
    const canvasHeight: number = this.canvasContext.height

    if (canvasWidth <= 0 || canvasHeight <= 0) {
      return
    }

    const inset: number = 10
    const usableWidth: number = canvasWidth - inset * 2
    const step: number = usableWidth / (this.stations.length - 1)

    this.canvasContext.clearRect(0, 0, canvasWidth, canvasHeight)

    const gradient: CanvasGradient = this.canvasContext.createLinearGradient(0, 0, canvasWidth, 0)
    gradient.addColorStop(0, AppColors.secondary)
    gradient.addColorStop(1, AppColors.primary)

    this.canvasContext.beginPath()
    for (let i = 0; i < this.stations.length; i++) {
      const x: number = inset + i * step
      const y: number = i % 2 === 0 ? canvasHeight / 4 : canvasHeight * 3 / 4

      if (i === 0) {
        this.canvasContext.moveTo(x, y)
      } else {
        this.canvasContext.lineTo(x, y)
      }
    }

    this.canvasContext.lineWidth = 6
    this.canvasContext.strokeStyle = gradient
    this.canvasContext.stroke()

    for (let i = 0; i < this.stations.length; i++) {
      const x: number = inset + i * step
      const y: number = i % 2 === 0 ? canvasHeight / 4 : canvasHeight * 3 / 4

      this.canvasContext.beginPath()
      this.canvasContext.arc(x, y, 16, 0, Math.PI * 2)
      this.canvasContext.fillStyle = AppColors.primary
      this.canvasContext.fill()

      this.canvasContext.beginPath()
      this.canvasContext.arc(x, y, 6, 0, Math.PI * 2)
      this.canvasContext.fillStyle = AppColors.background
      this.canvasContext.fill()
    }
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: AppSpacing.lg }) {
          Text('Metro Planner')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primary)

          Stack() {
            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawMetroLine()
              })
          }
          .width('100%')
          .height(260)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppRadius.large)
          .clip(true)

          Column({ space: AppSpacing.sm }) {
            Text('Next Departures')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .margin({ bottom: 4 })

            ForEach(this.departures, (item: string) => {
              Row() {
                Text(item)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .fontColor(AppColors.onSurface)

                Text('On Time')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.success)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (item: string) => item)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppRadius.large)

          Blank()
            .height(AppSpacing.md)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: 20,
          bottom: AppSpacing.lg
        })
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [AppColors.background, 0.0],
            [AppColors.surfaceVariant, 0.5],
            [AppColors.background, 1.0]
          ]
        })

        Row() {
          ForEach(this.navItems, (item: NavItem) => {
            Text(item.label)
              .fontSize(14)
              .fontWeight(FontWeight.Normal)
              .fontColor(item.selected ? AppColors.secondary : AppColors.onSurface)
          }, (item: NavItem) => item.label)
        }
        .width('100%')
        .height(80)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.surface)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .backgroundColor(AppColors.primary)
      .margin({ right: AppSpacing.lg, bottom: 96 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}