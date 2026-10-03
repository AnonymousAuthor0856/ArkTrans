class AppColors {
  static readonly primary: string = '#FF7B00'
  static readonly secondary: string = '#FFD166'
  static readonly background: string = '#FFF6E5'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFF0C1'
  static readonly outline: string = '#E0C080'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
  static readonly onSurfacePlaceholder: string = '#663E2723'
  static readonly shadow: string = '#1F000000'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 20
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 14
}

class AppSpacing {
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
}

class ResultItem {
  id: number
  title: string

  constructor(id: number, title: string) {
    this.id = id
    this.title = title
  }
}

@Component
struct ResultCard {
  @Prop title: string

  build() {
    Column({ space: AppSpacing.sm }) {
      Blank()
        .width(96)
        .height(96)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(this.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Add')
          .fontSize(AppTypography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width('100%')
      .height(48)
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 8,
      color: AppColors.shadow,
      offsetX: 0,
      offsetY: 4
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State private query: string = ''
  @State private isTextFieldFocused: boolean = false
  @State private knobX: number = 144
  @State private knobY: number = 104

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  private canvasWidth: number = 0
  private canvasHeight: number = 0

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium']
  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ]

  private toNumber(value: Length): number {
    let result: number = Number(value)
    if (isNaN(result)) {
      result = parseFloat(value.toString())
    }
    return isNaN(result) ? 0 : result
  }

  private clamp(value: number, minValue: number, maxValue: number): number {
    return Math.max(minValue, Math.min(value, maxValue))
  }

  private drawCanvas(): void {
    if (this.canvasWidth <= 0 || this.canvasHeight <= 0) {
      return
    }

    this.canvasContext.clearRect(0, 0, this.canvasWidth, this.canvasHeight)

    this.canvasContext.fillStyle = AppColors.surfaceVariant
    this.canvasContext.fillRect(0, 0, this.canvasWidth, this.canvasHeight)

    const centerX: number = this.canvasWidth / 2
    const centerY: number = this.canvasHeight / 2
    const radialGradient: CanvasGradient =
      this.canvasContext.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60)

    radialGradient.addColorStop(0, AppColors.secondary)
    radialGradient.addColorStop(1, AppColors.primary)

    this.canvasContext.beginPath()
    this.canvasContext.arc(centerX, centerY, 60, 0, Math.PI * 2)
    this.canvasContext.fillStyle = radialGradient
    this.canvasContext.fill()

    this.canvasContext.beginPath()
    this.canvasContext.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2)
    this.canvasContext.fillStyle = AppColors.primary
    this.canvasContext.fill()
  }

  build() {
    Scroll() {
      Column({ space: AppSpacing.md }) {
        Text('Retro Filter Search')
          .width('100%')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Start)

        TextInput({
          placeholder: 'Search products',
          text: this.query
        })
          .width('100%')
          .height(56)
          .fontSize(AppTypography.bodySize)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurfacePlaceholder)
          .placeholderFont({
            size: AppTypography.bodySize,
            weight: FontWeight.Regular
          })
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.medium)
          .border({
            width: 1,
            color: this.isTextFieldFocused ? AppColors.primary : AppColors.outline
          })
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg
          })
          .caretColor(AppColors.primary)
          .onChange((value: string) => {
            this.query = value
          })
          .onFocus(() => {
            this.isTextFieldFocused = true
          })
          .onBlur(() => {
            this.isTextFieldFocused = false
          })

        Row({ space: AppSpacing.sm }) {
          ForEach(this.filters, (text: string) => {
            Button({ type: ButtonType.Normal, stateEffect: true }) {
              Text(text)
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSecondary)
            }
            .height(36)
            .padding({
              left: AppSpacing.md,
              right: AppSpacing.md
            })
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.small)
          }, (text: string) => text)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        Column() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.canvasWidth = this.toNumber(newValue.width)
              this.canvasHeight = this.toNumber(newValue.height)
              this.knobX = this.clamp(this.knobX, 16, Math.max(16, this.canvasWidth - 16))
              this.knobY = this.clamp(this.knobY, 16, Math.max(16, this.canvasHeight - 16))
              this.drawCanvas()
            })
            .onTouch((event: TouchEvent) => {
              if ((event.type === TouchType.Down || event.type === TouchType.Move) &&
                event.touches.length > 0) {
                const touch: TouchObject = event.touches[0]
                this.knobX = this.clamp(touch.x, 16, Math.max(16, this.canvasWidth - 16))
                this.knobY = this.clamp(touch.y, 16, Math.max(16, this.canvasHeight - 16))
                this.drawCanvas()
              }
            })
        }
        .width('100%')
        .height(180)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)

        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              ResultCard({ title: item.title })
            }
          }, (item: ResultItem) => item.id.toString())
        }
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.lg)
        .rowsGap(AppSpacing.lg)
        .padding({ bottom: 24 })
      }
      .width('100%')
      .padding(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .scrollBar(BarState.Off)
  }
}