// MARK: - AppTokens
class ColorTokens {
  primary: string = '#FF7B00'
  secondary: string = '#FFD166'
  background: string = '#FFF6E5'
  surface: string = '#FFFFFF'
  surfaceVariant: string = '#FFF0C1'
  outline: string = '#E0C080'
  onPrimary: string = '#FFFFFF'
  onSecondary: string = '#3E2723'
  onBackground: string = '#3E2723'
  onSurface: string = '#3E2723'
}

class FontStyle {
  size: number = 0
  weight: number = 0
}

class TypographyTokens {
  display: FontStyle = { size: 28, weight: FontWeight.Bold }
  headline: FontStyle = { size: 20, weight: FontWeight.SemiBold }
  title: FontStyle = { size: 16, weight: FontWeight.Medium }
  body: FontStyle = { size: 14, weight: FontWeight.Regular }
  label: FontStyle = { size: 12, weight: FontWeight.Medium }
  labelSize: number = 12
}

class ShapeTokens {
  small: number = 6
  medium: number = 10
  large: number = 14
}

class SpacingTokens {
  sm: number = 8
  md: number = 12
  lg: number = 16
}

class ElevationSpec {
  radius: number = 0
  y: number = 0
  opacity: number = 0
}

class ElevationTokens {
  level2: ElevationSpec = { radius: 8, y: 4, opacity: 0.12 }
}

class AppTokens {
  static readonly Colors: ColorTokens = new ColorTokens()
  static readonly Typography: TypographyTokens = new TypographyTokens()
  static readonly Shapes: ShapeTokens = new ShapeTokens()
  static readonly Spacing: SpacingTokens = new SpacingTokens()
  static readonly Elevation: ElevationTokens = new ElevationTokens()
}

// MARK: - ResultItem
interface ResultItem {
  id: number
  title: string
}

// MARK: - CardView
@Component
struct CardView {
  @Prop item: ResultItem = { id: 0, title: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Stack()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .font({ size: AppTokens.Typography.title.size, weight: AppTokens.Typography.title.weight })
        .fontColor(AppTokens.Colors.onSurface)

      Button('Add')
        .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
      offsetY: AppTokens.Elevation.level2.y,
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State query: string = ''
  @State isFocused: boolean = false
  @State knobX: number = 144
  @State knobY: number = 104
  @State canvasWidth: number = 300
  @State canvasHeight: number = 148
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  private results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' },
  ]

  private filterTexts: string[] = ['Popular', 'New', 'Discount', 'Premium']

  aboutToAppear(): void {
    this.canvasWidth = 300
    this.canvasHeight = 148
  }

  aboutToUpdate(): void {
    if (this.canvasWidth > 0 && this.canvasHeight > 0) {
      this.drawCanvas()
    }
  }

  private drawCanvas(): void {
    const ctx: CanvasRenderingContext2D = this.canvasCtx
    const w: number = this.canvasWidth
    const h: number = this.canvasHeight

    ctx.clearRect(0, 0, w, h)

    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    const cx: number = w / 2
    const cy: number = h / 2
    const gradient: CanvasGradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, 60)
    gradient.addColorStop(0, AppTokens.Colors.secondary)
    gradient.addColorStop(1, AppTokens.Colors.primary)
    ctx.fillStyle = gradient
    ctx.beginPath()
    ctx.arc(cx, cy, 60, 0, Math.PI * 2)
    ctx.fill()

    ctx.fillStyle = AppTokens.Colors.primary
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fill()
  }

  private handleTouch(event: TouchEvent): void {
    const touchList: TouchList = event.touches
    if (touchList.length === 0) {
      return
    }
    const touch: Object = touchList[0]
    const localX: number = (touch as Record<string, number>).localX ?? (touch as Record<string, number>).x
    const localY: number = (touch as Record<string, number>).localY ?? (touch as Record<string, number>).y

    if (event.type === TouchType.Down || event.type === TouchType.Move) {
      const minX: number = 16
      const maxX: number = Math.max(minX, this.canvasWidth - 16)
      const minY: number = 16
      const maxY: number = Math.max(minY, this.canvasHeight - 16)

      const clampedX: number = Math.max(minX, Math.min(maxX, localX))
      const clampedY: number = Math.max(minY, Math.min(maxY, localY))

      this.knobX = clampedX
      this.knobY = clampedY
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        TextInput({ placeholder: 'Search products', text: this.query })
          .font({ size: AppTokens.Typography.body.size, weight: AppTokens.Typography.body.weight })
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(62, 39, 35, 0.4)')
          .height(56)
          .backgroundColor(AppTokens.Colors.surface)
          .border({ width: 1, color: this.isFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .onFocus(() => {
            this.isFocused = true
          })
          .onBlur(() => {
            this.isFocused = false
          })
          .onChange((value: string) => {
            this.query = value
          })

        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filterTexts, (text: string) => {
            Button(text)
              .font({ size: AppTokens.Typography.label.size, weight: AppTokens.Typography.label.weight })
              .fontColor(AppTokens.Colors.onSecondary)
              .height(36)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
          }, (text: string) => text)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Stack() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.canvasWidth = Number(newValue.width)
              this.canvasHeight = Number(newValue.height)
              this.drawCanvas()
            })
            .onTouch((event: TouchEvent) => {
              this.handleTouch(event)
            })
        }
        .width('100%')
        .height(180)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .padding(AppTokens.Spacing.lg)

        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              CardView({ item: item })
            }
          }, (item: ResultItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.lg)
        .columnsGap(AppTokens.Spacing.lg)
        .width('100%')
        .padding({ bottom: 24 })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
