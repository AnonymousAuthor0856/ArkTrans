class AppColors {
  static readonly primary: ResourceColor = '#FF8C00'
  static readonly secondary: ResourceColor = '#FFC107'
  static readonly tertiary: ResourceColor = '#FFE082'
  static readonly background: ResourceColor = '#FFF8E1'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#FFECB3'
  static readonly outline: ResourceColor = '#D7CCC8'
  static readonly success: ResourceColor = '#4CAF50'
  static readonly warning: ResourceColor = '#FFB300'
  static readonly error: ResourceColor = '#E53935'
  static readonly onPrimary: ResourceColor = '#3E2723'
  static readonly onSecondary: ResourceColor = '#3E2723'
  static readonly onBackground: ResourceColor = '#3E2723'
  static readonly onSurface: ResourceColor = '#3E2723'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly displayWeight: FontWeight = FontWeight.Bold

  static readonly titleSize: number = 18
  static readonly titleWeight: FontWeight = FontWeight.Medium

  static readonly bodySize: number = 14
  static readonly bodyWeight: FontWeight = FontWeight.Regular

  static readonly labelSize: number = 12
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppShapes {
  static readonly small: number = 6
  static readonly medium: number = 10
  static readonly large: number = 16
}

class AppSpacing {
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
  color: ResourceColor

  constructor(elevation: number, radius: number, dy: number, opacity: number, color: ResourceColor) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
    this.color = color
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.1, '#1A3E2723')
  static readonly level2: ShadowSpec = new ShadowSpec(6, 8, 4, 0.15, '#263E2723')
  static readonly level3: ShadowSpec = new ShadowSpec(10, 12, 6, 0.18, '#2E3E2723')
}

class Pin {
  id: string
  x: number
  y: number
  label: string

  constructor(x: number, y: number, label: string) {
    this.id = `${Date.now()}-${Math.random()}`
    this.x = x
    this.y = y
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State private pins: Pin[] = [
    new Pin(150, 250, 'Group A'),
    new Pin(350, 420, 'Group B'),
    new Pin(520, 310, 'Group C')
  ]

  private addGroup(): void {
    const randomX = Math.floor(Math.random() * 450) + 100
    const randomY = Math.floor(Math.random() * 300) + 150
    this.pins = [...this.pins, new Pin(randomX, randomY, 'New')]
  }

  private clearGroups(): void {
    this.pins = []
  }

  build() {
    Stack() {
      Column({ space: AppSpacing.lg }) {
        Text('Retro Group Buy')
          .fontSize(AppTypography.displaySize)
          .fontWeight(AppTypography.displayWeight)
          .fontColor(AppColors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        Column({ space: AppSpacing.md }) {
          Text('Live Deals Map')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.onSurface)

          Stack({ alignContent: Alignment.TopStart }) {
            ForEach(this.pins, (pin: Pin) => {
              Circle()
                .width(28)
                .height(28)
                .fill(AppColors.primary)
                .position({
                  x: pin.x - 14,
                  y: pin.y - 14
                })
            }, (pin: Pin) => pin.id)
          }
          .width('100%')
          .height(220)
          .padding(8)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .clip(true)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevationMapping.level2.elevation,
          color: AppElevationMapping.level2.color,
          offsetX: 0,
          offsetY: AppElevationMapping.level2.dy
        })

        Blank()
          .height(AppSpacing.sm)

        Row({ space: AppSpacing.md }) {
          Button('Add Group', { type: ButtonType.Normal, stateEffect: true })
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onSecondary)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.addGroup()
            })

          Button('Clear', { type: ButtonType.Normal, stateEffect: true })
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onPrimary)
            .height(48)
            .layoutWeight(1)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
              this.clearGroups()
            })
        }
        .width('100%')

        Column({ space: AppSpacing.sm }) {
          Text('Active Groups')
            .fontSize(AppTypography.titleSize)
            .fontWeight(AppTypography.titleWeight)
            .fontColor(AppColors.primary)

          ForEach(this.pins, (pin: Pin) => {
            Row() {
              Text(pin.label)
                .fontSize(AppTypography.bodySize)
                .fontWeight(AppTypography.bodyWeight)
                .fontColor(AppColors.onSurface)

              Blank()
                .layoutWeight(1)

              Circle()
                .width(14)
                .height(14)
                .fill(AppColors.primary)
            }
            .width('100%')
          }, (pin: Pin) => pin.id)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.large)
        .shadow({
          radius: AppElevationMapping.level1.elevation,
          color: AppElevationMapping.level1.color,
          offsetX: 0,
          offsetY: AppElevationMapping.level1.dy
        })

        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}