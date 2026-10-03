interface Marker {
  id: string
  x: number
  y: number
  label: string
}

class AppColors {
  static readonly primary: ResourceColor = '#FF111111'
  static readonly secondary: ResourceColor = '#FF333333'
  static readonly tertiary: ResourceColor = '#FF777777'
  static readonly background: ResourceColor = '#FFFFFFFF'
  static readonly surface: ResourceColor = '#FFF9F9F9'
  static readonly surfaceVariant: ResourceColor = '#FFE5E5E5'
  static readonly outline: ResourceColor = '#FFCCCCCC'
  static readonly success: ResourceColor = '#FF16A34A'
  static readonly warning: ResourceColor = '#FFF59E0B'
  static readonly error: ResourceColor = '#FFDC2626'
  static readonly onPrimary: ResourceColor = '#FFFFFFFF'
  static readonly onSecondary: ResourceColor = '#FFFFFFFF'
  static readonly onTertiary: ResourceColor = '#FF111111'
  static readonly onBackground: ResourceColor = '#FF111111'
  static readonly onSurface: ResourceColor = '#FF111111'
}

class AppShapes {
  static readonly small: Length = 6
  static readonly medium: Length = 10
  static readonly large: Length = 14
}

class AppSpacing {
  static readonly sm: Length = 8
  static readonly md: Length = 12
  static readonly lg: Length = 16
  static readonly xl: Length = 24
  static readonly xxl: Length = 32
}

interface ElevationSpec {
  radius: number
  dy: number
  opacity: number
}

class AppElevation {
  static readonly level2: ElevationSpec = { radius: 8, dy: 4, opacity: 0.12 }
}

@Entry
@Component
struct RootScreen {
  @State @Watch('onMarkersChanged') markers: Marker[] = [
    { id: '1', x: 120, y: 200, label: 'Store A' },
    { id: '2', x: 360, y: 400, label: 'Store B' }
  ]

  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasCtx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings)
  @State canvasWidth: number = 0
  @State canvasHeight: number = 0

  onMarkersChanged(): void {
    this.drawCanvas()
  }

  private drawCanvas(): void {
    const ctx = this.canvasCtx
    const w: number = this.canvasWidth
    const h: number = this.canvasHeight
    if (w <= 0 || h <= 0) {
      return
    }
    ctx.clearRect(0, 0, w, h)
    ctx.fillStyle = '#E5E5E5'
    ctx.fillRect(0, 0, w, h)
    ctx.fillStyle = '#111111'
    for (let i = 0; i < this.markers.length; i++) {
      const m: Marker = this.markers[i]
      ctx.beginPath()
      ctx.arc(m.x, m.y, 14, 0, Math.PI * 2)
      ctx.fill()
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppSpacing.lg }) {
        Text('Product Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')

        Column({ space: AppSpacing.md }) {
          Stack()
            .width('100%')
            .height(160)
            .backgroundColor(AppColors.surfaceVariant)

          Text('Monochrome Bag')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text('A minimalist and timeless design piece.')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(AppColors.tertiary)

          Text('$79.00')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)

          Button('Add to Cart')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .width('100%')
            .height(48)
            .backgroundColor(AppColors.primary)
            .fontColor(AppColors.onPrimary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              console.info('Add to Cart tapped!')
            })
        }
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppElevation.level2.opacity})`,
          offsetX: 0,
          offsetY: AppElevation.level2.dy
        })

        Stack() {
          Canvas(this.canvasCtx)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
            .onAreaChange((_oldArea: Area, newArea: Area) => {
              this.canvasWidth = newArea.width as number
              this.canvasHeight = newArea.height as number
              this.drawCanvas()
            })
        }
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .width('100%')
        .height(240)

        Row({ space: AppSpacing.md }) {
          Button('Add Marker')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              const newMarker: Marker = {
                id: Date.now().toString(),
                x: Math.floor(Math.random() * 400) + 50,
                y: Math.floor(Math.random() * 300) + 50,
                label: 'New'
              }
              this.markers.push(newMarker)
            })

          Button('Clear')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .layoutWeight(1)
            .height(44)
            .backgroundColor(AppColors.tertiary)
            .fontColor(AppColors.onTertiary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.markers = []
            })
        }
        .width('100%')
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .height('100%')
    }
    .backgroundColor(AppColors.background)
    .width('100%')
    .height('100%')
  }
}
