class ShadowSpec {
  radius: number
  x: number
  y: number
  opacity: number

  constructor(radius: number, x: number, y: number, opacity: number) {
    this.radius = radius
    this.x = x
    this.y = y
    this.opacity = opacity
  }
}

class AppTokens {
  static Colors = class {
    static readonly primary: string = '#FF06B6D4'
    static readonly secondary: string = '#FF3B82F6'
    static readonly tertiary: string = '#FF8B5CF6'
    static readonly background: string = '#FFF0F9FF'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surface90: string = '#E6FFFFFF'
    static readonly surfaceVariant: string = '#FFE0F2FE'
    static readonly outline: string = '#FFBAE6FD'
    static readonly success: string = '#FF22C55E'
    static readonly warning: string = '#FFFACC15'
    static readonly error: string = '#FFEF4444'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FFFFFFFF'
    static readonly onTertiary: string = '#FFFFFFFF'
    static readonly onBackground: string = '#FF0F172A'
    static readonly onSurface: string = '#FF0F172A'
  }

  static TypographyTokens = class {
    static readonly displaySize: number = 28
    static readonly titleSize: number = 18
    static readonly bodySize: number = 14
    static readonly labelSize: number = 12
  }

  static Shapes = class {
    static readonly small: number = 6
    static readonly medium: number = 12
    static readonly large: number = 20
  }

  static Spacing = class {
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 32
  }

  static ElevationMapping = class {
    static readonly level1: ShadowSpec = new ShadowSpec(4, 0, 2, 0.12)
    static readonly level2: ShadowSpec = new ShadowSpec(8, 0, 4, 0.18)
  }
}

class Marker {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Component
struct InvoiceScannerSwitch {
  @Link isOn: boolean

  build() {
    Stack({ alignContent: this.isOn ? Alignment.End : Alignment.Start }) {
      Circle()
        .width(26)
        .height(26)
        .fill(this.isOn ? AppTokens.Colors.secondary : AppTokens.Colors.outline)
        .margin(2)
    }
    .width(50)
    .height(30)
    .borderRadius(15)
    .backgroundColor(this.isOn ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .onClick(() => {
      animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
        this.isOn = !this.isOn
      })
    })
  }
}

@Entry
@Component
struct RootScreen {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  @State private markers: Marker[] = [
    new Marker(120, 200, 'A1'),
    new Marker(300, 400, 'B2'),
    new Marker(520, 600, 'C3')
  ]

  @State private scanning: boolean = false

  private rgba(hex: string, opacity: number): string {
    const value: string = hex.replace('#', '')
    const r: number = parseInt(value.substring(2, 4), 16)
    const g: number = parseInt(value.substring(4, 6), 16)
    const b: number = parseInt(value.substring(6, 8), 16)
    return `rgba(${r}, ${g}, ${b}, ${opacity})`
  }

  private randomInRange(min: number, max: number): number {
    return Math.floor(Math.random() * (max - min + 1)) + min
  }

  private drawCanvas(): void {
    const width: number = this.canvasContext.width
    const height: number = this.canvasContext.height

    if (width <= 0 || height <= 0) {
      return
    }

    this.canvasContext.clearRect(0, 0, width, height)

    const centerX: number = width / 2
    const centerY: number = height / 2
    const radius: number = Math.min(width, height) / 2.5

    this.canvasContext.beginPath()
    this.canvasContext.fillStyle = AppTokens.Colors.surfaceVariant
    this.canvasContext.arc(centerX, centerY, radius, 0, Math.PI * 2)
    this.canvasContext.fill()

    this.markers.forEach((marker: Marker) => {
      this.canvasContext.beginPath()
      this.canvasContext.fillStyle = AppTokens.Colors.primary
      this.canvasContext.arc(marker.x, marker.y, 12, 0, Math.PI * 2)
      this.canvasContext.fill()
    })
  }

  build() {
    Column({ space: 0 }) {
      Text('Invoice Scanner')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .onReady(() => {
              this.drawCanvas()
            })
        }
        .width('100%')
        .height(400)
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surface90)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetX: AppTokens.ElevationMapping.level2.x,
          offsetY: AppTokens.ElevationMapping.level2.y
        })

        Row() {
          Text('Scanning Active')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          InvoiceScannerSwitch({ isOn: $scanning })
        }
        .width('100%')

        Button({ type: ButtonType.Normal }) {
          Text('Add Marker')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width('100%')
        .height(48)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.primary)
        .onClick(() => {
          if (this.scanning) {
            const newMarkers: Marker[] = this.markers.concat([
              new Marker(
                this.randomInRange(80, 580),
                this.randomInRange(150, 650),
                `N${this.markers.length + 1}`
              )
            ])

            this.markers = newMarkers
            this.drawCanvas()
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 180,
        colors: [
          [this.rgba(AppTokens.Colors.secondary, 0.3), 0.0],
          [AppTokens.Colors.background, 0.5],
          [this.rgba(AppTokens.Colors.primary, 0.3), 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}