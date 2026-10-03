// Retro Filter Search - ArkTS conversion of Kotlin Compose code

@Entry
@Component
struct RetroFilterSearch {
  @State query: string = ''
  @State knobX: number = 160
  @State knobY: number = 120
  @State results: ResultItem[] = this.initResults()
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  private initResults(): ResultItem[] {
    let arr: ResultItem[] = []
    for (let i = 0; i < 6; i++) {
      arr.push(new ResultItem(i, `Result ${i + 1}`))
    }
    return arr
  }

  aboutToAppear(): void {
    // Initialize knob to center-ish of canvas area
    this.knobX = 160
    this.knobY = 120
  }

  private drawCanvas(): void {
    const ctx = this.canvasCtx
    const w = this.canvasWidth
    const h = this.canvasHeight

    // Draw surfaceVariant background rect
    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    // Draw radial gradient circle (center)
    const cx = w / 2
    const cy = h / 2
    const r = 80
    const grad = ctx.createRadialGradient(cx, cy, 0, cx, cy, r)
    grad.addColorStop(0, AppTokens.Colors.secondary)
    grad.addColorStop(1, AppTokens.Colors.primary)
    ctx.fillStyle = grad
    ctx.beginPath()
    ctx.arc(cx, cy, r, 0, Math.PI * 2)
    ctx.fill()

    // Draw draggable knob circle
    ctx.fillStyle = AppTokens.Colors.primary
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fill()
  }

  build() {
    Column() {
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .margin({ bottom: AppTokens.Spacing.md })

      // Search TextField
      TextInput({ placeholder: 'Search products', text: this.query })
        .width('100%')
        .height(48)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .placeholderColor(AppTokens.Colors.onSurface + '66')
        .fontColor(AppTokens.Colors.onSurface)
        .padding({ left: 12, right: 12 })
        .defaultFocus(false)
        .onChange((val: string) => {
          this.query = val
        })
        .margin({ bottom: AppTokens.Spacing.md })

      // Filter buttons row
      Row() {
        ForEach(['Popular', 'New', 'Discount', 'Premium'], (label: string) => {
          Button(label)
            .height(36)
            .borderRadius(AppTokens.Shapes.small)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .margin({ right: AppTokens.Spacing.sm })
            .onClick(() => {})
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppTokens.Spacing.md })

      // Canvas area with draggable knob
      Stack() {
        Canvas(this.canvasCtx)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawCanvas()
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = event.localX
                this.knobY = event.localY
                this.drawCanvas()
              })
          )
      }
      .width('100%')
      .height(180)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .padding(16)
      .margin({ bottom: AppTokens.Spacing.md })
      .onAreaChange((oldArea: Area, newArea: Area) => {
        this.canvasWidth = newArea.width as number - 32
        this.canvasHeight = newArea.height as number - 32
      })

      // Result grid
      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            this.ResultCard(item)
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppTokens.Spacing.lg)
      .rowsGap(AppTokens.Spacing.lg)
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .padding(AppTokens.Spacing.lg)
  }

  @Builder
  ResultCard(item: ResultItem) {
    Column() {
      // Product image placeholder
      Column() {
      }
      .width(96)
      .height(96)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.medium)
      .margin({ bottom: AppTokens.Spacing.sm })

      Text(item.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      Button('Add')
        .width('100%')
        .height(36)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: '#000000',
      offsetY: AppTokens.ElevationMapping.level2.dy,
      fill: false
    })
  }
}

class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF7B00'
    export const secondary: string = '#FFD166'
    export const background: string = '#FFF6E5'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#FFF0C1'
    export const outline: string = '#E0C080'
    export const onPrimary: string = '#FFFFFF'
    export const onSecondary: string = '#3E2723'
    export const onBackground: string = '#3E2723'
    export const onSurface: string = '#3E2723'
  }

  export namespace Shapes {
    export const small: number = 6
    export const medium: number = 10
    export const large: number = 14
  }

  export namespace Spacing {
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
  }

  export interface ShadowSpec {
    elevation: number
    radius: number
    dy: number
    opacity: number
  }

  export namespace ElevationMapping {
    export const level2: ShadowSpec = {
      elevation: 4,
      radius: 8,
      dy: 4,
      opacity: 0.12
    }
  }
}
