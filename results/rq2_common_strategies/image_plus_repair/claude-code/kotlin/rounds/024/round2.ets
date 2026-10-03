// Retro Whiteboard - Productivity App
// Style: Retro Flat

interface ColorPalette {
  primary: string
  secondary: string
  tertiary: string
  background: string
  surface: string
  surfaceVariant: string
  outline: string
  success: string
  warning: string
  error: string
  onPrimary: string
  onSecondary: string
  onTertiary: string
  onBackground: string
  onSurface: string
}

class AppTokens {
  static Colors: ColorPalette = {
    primary: '#EF476F',
    secondary: '#FFD166',
    tertiary: '#06D6A0',
    background: '#FFFCF2',
    surface: '#FFFFFF',
    surfaceVariant: '#F7EDE2',
    outline: '#E5D4B1',
    success: '#06D6A0',
    warning: '#FFA600',
    error: '#D62828',
    onPrimary: '#FFFFFF',
    onSecondary: '#1E1E1E',
    onTertiary: '#1E1E1E',
    onBackground: '#1E1E1E',
    onSurface: '#1E1E1E'
  }
}

interface DrawPoint {
  x: number
  y: number
  color: string
}

@Entry
@Component
struct RetroWhiteboard {
  @State points: DrawPoint[] = []
  @State currentColor: string = AppTokens.Colors.primary
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  aboutToAppear() {
  }

  aboutToUpdate() {
    this.redrawCanvas()
  }

  private redrawCanvas() {
    this.ctx.clearRect(0, 0, 1000, 2000)
    this.points.forEach((p) => {
      this.ctx.beginPath()
      this.ctx.arc(p.x, p.y, 10, 0, Math.PI * 2)
      this.ctx.fillStyle = p.color
      this.ctx.fill()
    })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        // Top Bar
        Row() {
          Text('Retro Whiteboard')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(56)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.background)

        // Canvas Area
        Stack() {
          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.redrawCanvas()
            })
            .onTouch((event: TouchEvent) => {
              if (event.type === TouchType.Down || event.type === TouchType.Move) {
                const touch = event.touches[0]
                this.points.push({
                  x: touch.x,
                  y: touch.y,
                  color: this.currentColor
                })
              }
            })
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.background)
      }
      .width('100%')
      .height('100%')

      // Bottom Bar with color buttons
      Row() {
        Button('Red')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(16)
          .width(100)
          .height(60)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.primary
          })

        Button('Yellow')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSecondary)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(16)
          .width(100)
          .height(60)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.secondary
          })

        Button('Green')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(16)
          .width(100)
          .height(60)
          .onClick(() => {
            this.currentColor = AppTokens.Colors.tertiary
          })
      }
      .width('100%')
      .height(80)
      .backgroundColor('#FFF5F5')
      .justifyContent(FlexAlign.SpaceEvenly)
      .alignItems(VerticalAlign.Center)

      // Clear FAB
      Button('Clear')
        .fontSize(18)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(50)
        .width(100)
        .height(100)
        .margin({ right: 24, bottom: 120 })
        .shadow({
          radius: 12,
          color: '#33000000',
          offsetX: 0,
          offsetY: 4
        })
        .onClick(() => {
          this.points = []
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
