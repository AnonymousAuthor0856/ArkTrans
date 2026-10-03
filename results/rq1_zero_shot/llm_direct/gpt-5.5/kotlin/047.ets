const NAME: string = '061*GroupBuy*en'
const UI_TYPE: string = 'ECommerce'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

class ColorTokens {
  static readonly primary: string = '#FF8C00'
  static readonly secondary: string = '#FFC107'
  static readonly tertiary: string = '#FFE082'
  static readonly background: string = '#FFF8E1'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#FFECB3'
  static readonly outline: string = '#D7CCC8'
  static readonly success: string = '#4CAF50'
  static readonly warning: string = '#FFB300'
  static readonly error: string = '#E53935'
  static readonly onPrimary: string = '#3E2723'
  static readonly onSecondary: string = '#3E2723'
  static readonly onBackground: string = '#3E2723'
  static readonly onSurface: string = '#3E2723'
}

class TypographyTokens {
  static readonly displaySize: number = 28
  static readonly titleSize: number = 18
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12
}

class ShapeTokens {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class SpacingTokens {
  static readonly sm: number = 6
  static readonly md: number = 10
  static readonly lg: number = 16
  static readonly xl: number = 24
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15)
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18)
}

class AppTokens {
  static readonly Colors = ColorTokens
  static readonly TypographyTokens = TypographyTokens
  static readonly Shapes = ShapeTokens
  static readonly Spacing = SpacingTokens
  static readonly ElevationMapping = ElevationMapping
}

class Pin {
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private addGroup(): void {
    const x: number = Math.floor(Math.random() * 450) + 100
    const y: number = Math.floor(Math.random() * 300) + 150
    this.pins = [...this.pins, new Pin(x, y, 'New')]
  }

  private clearGroups(): void {
    this.pins = []
  }

  @Builder
  ActiveGroupRow(pin: Pin) {
    Row() {
      Text(pin.label)
        .fontSize(AppTokens.TypographyTokens.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)

      Circle({ width: 14, height: 14 })
        .fill(AppTokens.Colors.primary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Retro Group Buy')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Live Deals Map')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)

        Stack({ alignContent: Alignment.TopStart }) {
          ForEach(this.pins, (pin: Pin, index: number) => {
            Circle({ width: 28, height: 28 })
              .fill(AppTokens.Colors.primary)
              .position({
                x: pin.x - 14,
                y: pin.y - 14
              })
          }, (pin: Pin, index: number) => `${pin.label}-${pin.x}-${pin.y}-${index}`)
        }
        .width('100%')
        .height(220)
        .padding(8)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
        .clip(true)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level2.radius,
        color: '#26000000',
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level2.dy
      })

      Blank()
        .height(AppTokens.Spacing.sm)

      Row() {
        Button() {
          Text('Add Group')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
        }
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          this.addGroup()
        })

        Blank()
          .width(AppTokens.Spacing.md)

        Button() {
          Text('Clear')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {
          this.clearGroups()
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Column({ space: AppTokens.Spacing.sm }) {
        Text('Active Groups')
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        ForEach(this.pins, (pin: Pin, index: number) => {
          this.ActiveGroupRow(pin)
        }, (pin: Pin, index: number) => `${pin.label}-${pin.x}-${pin.y}-${index}`)
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({
        radius: AppTokens.ElevationMapping.level1.radius,
        color: '#1A000000',
        offsetX: 0,
        offsetY: AppTokens.ElevationMapping.level1.dy
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.background)
  }
}