const NAME: string = '205_SmartOrbitPanel_en'
const UI_TYPE: string = 'SmartHome ControlPanel'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const DENSITY_SPACING: string = 'Compact'

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
  static readonly mutedText: ResourceColor = 'rgba(46, 41, 36, 0.70)'
  static readonly chipSelected: ResourceColor = 'rgba(217, 95, 2, 0.16)'
  static readonly zoneFill: ResourceColor = 'rgba(240, 227, 209, 0.50)'
  static readonly sliderTrack: ResourceColor = '#E6D8F6'
}

class AppTypography {
  static readonly display: number = 44
  static readonly headline: number = 40
  static readonly title: number = 30
  static readonly body: number = 26
  static readonly label: number = 22
  static readonly smallLabel: number = 20
}

class AppRadius {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
}

class AppSpacing {
  static readonly xs: number = 8
  static readonly sm: number = 16
  static readonly md: number = 24
  static readonly lg: number = 32
  static readonly xl: number = 40
  static readonly xxl: number = 56
}

interface Zone {
  name: string
  humidity: number
  temp: string
}

const MODES: string[] = ['Orbit', 'Eclipse', 'Manual']

const ZONES: Zone[] = [
  { name: 'Atrium', humidity: 45, temp: '72°F' },
  { name: 'Lab East', humidity: 62, temp: '68°F' },
  { name: 'Hab Deck', humidity: 30, temp: '70°F' }
]

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 60
  @State ambientGlow: number = 35

  @Builder
  TopBar() {
    Row() {
      Text('Dock')
        .width(120)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Start)

      Text('Smart Orbit Panel')
        .layoutWeight(1)
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)

      Text('Alerts')
        .width(120)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(112)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: 18 })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ModeChip(mode: string) {
    Text(mode)
      .width(mode === 'Orbit' ? 112 : 134)
      .height(62)
      .fontSize(AppTypography.label)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .borderRadius(AppRadius.large)
      .backgroundColor(this.activeMode === mode ? AppColors.chipSelected : AppColors.surface)
      .border({
        width: this.activeMode === mode ? 0 : 2,
        color: AppColors.outline
      })
      .onClick(() => {
        this.activeMode = mode
      })
  }

  @Builder
  ModeSelector() {
    Row({ space: AppSpacing.sm }) {
      ForEach(MODES, (mode: string) => {
        this.ModeChip(mode)
      }, (mode: string) => mode)
    }
    .width('100%')
  }

  @Builder
  SolarCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Solar wash')
        .width('100%')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Text('Adjust orbital window glow')
        .width('100%')
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.mutedText)

      Slider({
        value: this.solarLevel,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(72)
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.sliderTrack)
        .blockColor(AppColors.primary)
        .showTips(false)
        .onChange((value: number) => {
          this.solarLevel = value
        })

      Row() {
        Text('0%')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text(`${Math.round(this.solarLevel)}%`)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text('Ambient glow')
        .width('100%')
        .margin({ top: AppSpacing.sm })
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      Slider({
        value: this.ambientGlow,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .height(72)
        .selectedColor(AppColors.secondary)
        .trackColor(AppColors.sliderTrack)
        .blockColor(AppColors.secondary)
        .showTips(false)
        .onChange((value: number) => {
          this.ambientGlow = value
        })

      Progress({
        value: this.ambientGlow,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(4)
    }
    .width('100%')
    .height(522)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
  }

  @Builder
  HealthCard() {
    Column({ space: AppSpacing.md }) {
      Text('Orbit health')
        .width('100%')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      StatusRow({ label: 'Atmos mix', value: 74, accent: AppColors.secondary, track: AppColors.surface })
      StatusRow({ label: 'Hull temp', value: 42, accent: AppColors.primary, track: AppColors.surface })
      StatusRow({ label: 'Shield sync', value: 88, accent: AppColors.tertiary, track: AppColors.surface })
    }
    .width('100%')
    .height(297)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppRadius.large)
  }

  @Builder
  ZonesCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Deck zones')
        .width('100%')
        .fontSize(AppTypography.headline)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach(ZONES, (zone: Zone) => {
        ZoneRow({ zone: zone })
      }, (zone: Zone) => zone.name)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Grid draw')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text('18.4 kWh')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Engage eco hold')
        .width(256)
        .height(80)
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppRadius.large)
    }
    .width('100%')
    .height(128)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.ModeSelector()
          this.SolarCard()
          this.HealthCard()
          this.ZonesCard()
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: 48,
          bottom: AppSpacing.xl
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: ResourceColor = '#000000'
  track: ResourceColor = '#FFFFFF'

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppTypography.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)

        Text(`${Math.round(this.value)}%`)
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Progress({
        value: this.value,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(this.accent)
        .backgroundColor(this.track)
        .borderRadius(4)
    }
    .width('100%')
  }
}

@Component
struct ZoneRow {
  zone: Zone = { name: '', humidity: 0, temp: '' }

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text(this.zone.temp)
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Progress({
        value: this.zone.humidity,
        total: 100,
        type: ProgressType.Linear
      })
        .width('100%')
        .height(8)
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
        .borderRadius(4)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.zoneFill)
    .borderRadius(AppRadius.small)
  }
}