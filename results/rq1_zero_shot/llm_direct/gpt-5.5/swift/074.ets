class AppColors {
  static readonly primary: ResourceColor = '#D95F02'
  static readonly secondary: ResourceColor = '#1B9AAA'
  static readonly tertiary: ResourceColor = '#FEC601'
  static readonly background: ResourceColor = '#F9F4EB'
  static readonly surface: ResourceColor = '#FFFFFF'
  static readonly surfaceVariant: ResourceColor = '#F0E3D1'
  static readonly outline: ResourceColor = '#E1CDB2'
  static readonly success: ResourceColor = '#56C271'
  static readonly warning: ResourceColor = '#F4A259'
  static readonly error: ResourceColor = '#D7263D'
  static readonly onPrimary: ResourceColor = '#1B1B1B'
  static readonly onSecondary: ResourceColor = '#041012'
  static readonly onTertiary: ResourceColor = '#1E1200'
  static readonly onBackground: ResourceColor = '#2C2A29'
  static readonly onSurface: ResourceColor = '#2E2924'
}

class TypographySpec {
  size: number
  weight: FontWeight

  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppTypography {
  static readonly display: TypographySpec = new TypographySpec(28, FontWeight.SemiBold)
  static readonly headline: TypographySpec = new TypographySpec(20, FontWeight.SemiBold)
  static readonly title: TypographySpec = new TypographySpec(16, FontWeight.Medium)
  static readonly body: TypographySpec = new TypographySpec(13, FontWeight.Regular)
  static readonly label: TypographySpec = new TypographySpec(11, FontWeight.Medium)
}

class AppShapes {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 20
  static readonly xxl: number = 28
  static readonly xxxl: number = 40
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

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 4, 2, 0.12)
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.16)
  static readonly level3: ShadowSpec = new ShadowSpec(8, 12, 6, 0.20)
  static readonly level4: ShadowSpec = new ShadowSpec(12, 16, 8, 0.24)
  static readonly level5: ShadowSpec = new ShadowSpec(16, 20, 10, 0.28)
}

class Zone {
  name: string
  humidity: number
  temp: string

  constructor(name: string, humidity: number, temp: string) {
    this.name = name
    this.humidity = humidity
    this.temp = temp
  }
}

@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: ResourceColor = AppColors.primary

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppTypography.body.size)
          .fontWeight(AppTypography.body.weight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(`${Math.floor(this.value * 100)}%`)
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({
        value: this.value * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(4)
        .color(this.accent)
        .backgroundColor(AppColors.surface)
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
  }
}

@Component
struct ZoneRow {
  zone: Zone = new Zone('', 0, '')

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(this.zone.temp)
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Progress({
        value: this.zone.humidity * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(4)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor('rgba(240, 227, 209, 0.5)')
    .borderRadius(AppShapes.small)
  }
}

@Entry
@Component
struct SmartOrbitPanelApp {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']

  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ]

  @Builder
  TopBar() {
    Row() {
      Button('Dock', { type: ButtonType.Normal, stateEffect: false })
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
        .padding(0)

      Blank()

      Text('Smart Orbit Panel')
        .fontSize(AppTypography.title.size)
        .fontWeight(AppTypography.title.weight)
        .fontColor(AppColors.onSurface)

      Blank()

      Button('Alerts', { type: ButtonType.Normal, stateEffect: false })
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
        .padding(0)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  ModeChips() {
    Row({ space: AppSpacing.sm }) {
      ForEach(this.modes, (mode: string) => {
        Text(mode)
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onSurface)
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            bottom: AppSpacing.sm
          })
          .backgroundColor(this.activeMode === mode ? 'rgba(217, 95, 2, 0.15)' : AppColors.surface)
          .border({
            width: 1,
            color: AppColors.outline,
            radius: AppShapes.small
          })
          .onClick(() => {
            this.activeMode = mode
          })
      }, (mode: string) => mode)
    }
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  @Builder
  SolarWashCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Solar wash')
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)

      Text('Adjust orbital window glow')
        .fontSize(AppTypography.body.size)
        .fontWeight(AppTypography.body.weight)
        .fontColor('rgba(46, 41, 36, 0.7)')

      Slider({
        value: this.solarLevel,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .blockColor(AppColors.primary)
        .onChange((value: number) => {
          this.solarLevel = value
        })

      Row() {
        Text('0%')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(`${Math.floor(this.solarLevel * 100)}%`)
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Text('Ambient glow')
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)

      Slider({
        value: this.ambientGlow,
        min: 0,
        max: 1,
        step: 0.01,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppColors.secondary)
        .trackColor(AppColors.surfaceVariant)
        .blockColor(AppColors.secondary)
        .onChange((value: number) => {
          this.ambientGlow = value
        })

      Progress({
        value: this.ambientGlow * 100,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(4)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(2)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppElevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }

  @Builder
  OrbitHealthCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Orbit health')
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)

      StatusRow({
        label: 'Atmos mix',
        value: 0.74,
        accent: AppColors.secondary
      })

      StatusRow({
        label: 'Hull temp',
        value: 0.42,
        accent: AppColors.primary
      })

      StatusRow({
        label: 'Shield sync',
        value: 0.88,
        accent: AppColors.tertiary
      })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppElevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }

  @Builder
  DeckZonesCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Deck zones')
        .fontSize(AppTypography.headline.size)
        .fontWeight(AppTypography.headline.weight)
        .fontColor(AppColors.onSurface)

      ForEach(this.zones, (zone: Zone) => {
        ZoneRow({ zone: zone })
      }, (zone: Zone) => zone.name)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppElevation.level1.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Grid draw')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onSurface)

        Text('18.4 kWh')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Engage eco hold', { type: ButtonType.Normal, stateEffect: false })
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
    }
    .width('100%')
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevation.level2.radius,
      color: `rgba(0, 0, 0, ${AppElevation.level2.opacity})`,
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.ModeChips()
          this.SolarWashCard()
          this.OrbitHealthCard()
          this.DeckZonesCard()
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}