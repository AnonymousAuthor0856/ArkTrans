// MARK: - AppTokens (Equivalent to Kotlin AppTokens object)
interface ColorTokens { [key: string]: string }
interface FontToken { size: number; weight: FontWeight }
interface TypographyTokens { [key: string]: FontToken }
interface NumberTokens { [key: string]: number }
interface ShadowSpec { elevation: number; radius: number; dy: number; opacity: number }
interface ElevationTokens { [key: string]: ShadowSpec }

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#FF8C00',
    secondary: '#FFC107',
    tertiary: '#FFE082',
    background: '#FFF8E1',
    surface: '#FFFFFF',
    surfaceVariant: '#FFECB3',
    outline: '#D7CCC8',
    success: '#4CAF50',
    warning: '#FFB300',
    error: '#E53935',
    onPrimary: '#3E2723',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  }

  static readonly Typography: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes: NumberTokens = {
    small: 6, medium: 10, large: 16
  }

  static readonly Spacing: NumberTokens = {
    sm: 6, md: 10, lg: 16, xl: 24
  }

  static readonly ElevationMapping: ElevationTokens = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.1 },
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.15 },
    level3: { elevation: 10, radius: 12, dy: 6, opacity: 0.18 }
  }
}

// MARK: - Pin Data Model
class Pin {
  id: number
  x: number
  y: number
  label: string

  constructor(x: number = 0, y: number = 0, label: string = '') {
    this.id = Pin.nextId++
    this.x = x
    this.y = y
    this.label = label
  }

  private static nextId: number = 0
}

// MARK: - RootScreen
@Entry
@Component
struct Index {
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)

  drawMap(): void {
    this.ctx.fillStyle = AppTokens.Colors.primary
    for (const pin of this.pins) {
      this.ctx.beginPath()
      this.ctx.arc(pin.x, pin.y, 14, 0, Math.PI * 2)
      this.ctx.fill()
    }
  }

  build() {
    Stack() {
      // 背景色。
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTokens.Typography.display.size)
          .fontWeight(AppTokens.Typography.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Card: Live Deals Map
        Column({ space: AppTokens.Spacing.md }) {
          Text('Live Deals Map')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Column() {
            Canvas(this.ctx)
              .width('100%')
              .height('100%')
              .onReady(() => {
                this.drawMap()
              })
          }
          .width('100%')
          .height(220)
          .padding(8)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.elevation,
          color: 'rgba(62, 39, 35, 0.15)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Blank().height(AppTokens.Spacing.sm)

        // 按钮行。
        Row({ space: AppTokens.Spacing.md }) {
          Button('Add Group')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              const randomX = Math.floor(Math.random() * 450) + 100
              const randomY = Math.floor(Math.random() * 300) + 150
              this.pins.push(new Pin(randomX, randomY, 'New'))
            })

          Button('Clear')
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.pins = []
            })
        }
        .width('100%')

        // Card: Active Groups
        Column({ space: AppTokens.Spacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.primary)

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTokens.Typography.body.size)
                .fontWeight(AppTokens.Typography.body.weight)
                .fontColor(AppTokens.Colors.onSurface)
              Blank()
              Circle({ width: 14, height: 14 })
                .fill(AppTokens.Colors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }, (pin: Pin) => pin.id.toString())
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding(AppTokens.Spacing.lg)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level1.elevation,
          color: 'rgba(62, 39, 35, 0.1)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level1.dy
        })

        Blank()
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}
