// MARK: - AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#FF7B00',
    secondary: '#FFD166',
    background: '#FFF6E5',
    surface: '#FFFFFF',
    surfaceVariant: '#FFF0C1',
    outline: '#E0C080',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.SemiBold },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
    labelSize: 12,
  }

  static readonly Shapes = {
    small: 6,
    medium: 10,
    large: 14,
  }

  static readonly Spacing = {
    sm: 8,
    md: 12,
    lg: 16,
  }

  static readonly Elevation = {
    level2: { radius: 8, y: 4, opacity: 0.12 },
  }
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
      // Image placeholder
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
  @State canvasWidth: number = 0
  @State canvasHeight: number = 0
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private startX: number = 0
  private startY: number = 0

  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => ({
    id: i,
    title: `Result ${i + 1}`,
  }))

  private filterTexts: string[] = ['Popular', 'New', 'Discount', 'Premium']

  aboutToAppear(): void {
    // Initialize canvas size to a reasonable default
    this.canvasWidth = 300
    this.canvasHeight = 148
  }

  aboutToUpdate(): void {
    if (this.canvasWidth > 0 && this.canvasHeight > 0) {
      this.drawCanvas()
    }
  }

  private drawCanvas(): void {
    const ctx = this.canvasCtx
    const w = this.canvasWidth
    const h = this.canvasHeight

    ctx.clearRect(0, 0, w, h)

    // surfaceVariant background
    ctx.fillStyle = AppTokens.Colors.surfaceVariant
    ctx.fillRect(0, 0, w, h)

    // radial gradient circle
    const cx = w / 2
    const cy = h / 2
    const gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, 60)
    gradient.addColorStop(0, AppTokens.Colors.secondary)
    gradient.addColorStop(1, AppTokens.Colors.primary)
    ctx.fillStyle = gradient
    ctx.beginPath()
    ctx.arc(cx, cy, 60, 0, Math.PI * 2)
    ctx.fill()

    // draggable knob
    ctx.fillStyle = AppTokens.Colors.primary
    ctx.beginPath()
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    ctx.fill()
  }

  private handleTouch(event: TouchEvent): void {
    const touch = event.touches[0]
    if (!touch) return

    if (event.type === TouchType.Down) {
      this.startX = this.knobX
      this.startY = this.knobY
    }

    if (event.type === TouchType.Down || event.type === TouchType.Move) {
      const localX = touch.localX ?? touch.x
      const localY = touch.localY ?? touch.y

      // Clamp knob within canvas bounds (radius = 16)
      const minX = 16
      const maxX = Math.max(minX, this.canvasWidth - 16)
      const minY = 16
      const maxY = Math.max(minY, this.canvasHeight - 16)

      const clampedX = Math.max(minX, Math.min(maxX, localX))
      const clampedY = Math.max(minY, Math.min(maxY, localY))

      this.knobX = clampedX
      this.knobY = clampedY
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppTokens.Spacing.md }) {
        // Title
        Text('Retro Filter Search')
          .font({ size: AppTokens.Typography.display.size, weight: AppTokens.Typography.display.weight })
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Search TextField
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

        // Filter buttons row
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

        // Canvas area with draggable knob
        Stack() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
            .onAreaChange((_oldValue: Area, newValue: Area) => {
              this.canvasWidth = newValue.width as number
              this.canvasHeight = newValue.height as number
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

        // Results grid
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
