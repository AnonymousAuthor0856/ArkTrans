interface Zone {
  name: string
  humidity: number
  temp: string
}

const NAME: string = '205_SmartOrbitPanel_en'
const UI_TYPE: string = 'SmartHome ControlPanel'
const STYLE_THEME: string = 'Retro Flat'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'
const DENSITY_SPACING: string = 'Compact'
const COMPLEXITY: string =
  'Includes Slider and ProgressBar to tune orbit lighting, monitor zones and provide flat retro meters.'
const EXTRA: string =
  'Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts.'

class AppColors {
  static readonly primary: string = '#D95F02'
  static readonly secondary: string = '#1B9AAA'
  static readonly tertiary: string = '#FEC601'
  static readonly background: string = '#F9F4EB'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F0E3D1'
  static readonly outline: string = '#E1CDB2'
  static readonly success: string = '#56C271'
  static readonly warning: string = '#F4A259'
  static readonly error: string = '#D7263D'
  static readonly onPrimary: string = '#1B1B1B'
  static readonly onSecondary: string = '#041012'
  static readonly onTertiary: string = '#1E1200'
  static readonly onBackground: string = '#2C2A29'
  static readonly onSurface: string = '#2E2924'
  static readonly primaryAlpha15: string = 'rgba(217, 95, 2, 0.15)'
  static readonly onSurfaceAlpha70: string = 'rgba(46, 41, 36, 0.70)'
  static readonly surfaceVariantAlpha50: string = 'rgba(240, 227, 209, 0.50)'
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

class AppShapes {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
}

@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ]

  @Builder
  TitleText(value: string) {
    Text(value)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .lineHeight(22)
      .fontColor(AppColors.onSurface)
  }

  @Builder
  HeadlineText(value: string) {
    Text(value)
      .fontSize(20)
      .fontWeight(FontWeight.SemiBold)
      .lineHeight(28)
      .fontColor(AppColors.onSurface)
  }

  @Builder
  BodyText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(13)
      .fontWeight(FontWeight.Regular)
      .lineHeight(18)
      .fontColor(color)
  }

  @Builder
  LabelText(value: string, color: string = AppColors.onSurface) {
    Text(value)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .lineHeight(16)
      .fontColor(color)
  }

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Smart Orbit Panel')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .lineHeight(22)
        .fontColor(AppColors.onSurface)

      Row() {
        Button('Dock', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(Color.Transparent)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(AppShapes.small)

        Blank()

        Button('Alerts', { type: ButtonType.Normal, stateEffect: true })
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .backgroundColor(Color.Transparent)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Grid draw')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .lineHeight(16)
          .fontColor(AppColors.onSurface)

        Text('18.4 kWh')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .lineHeight(22)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Start)

      Button('Engage eco hold')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 8,
      color: 'rgba(0, 0, 0, 0.16)',
      offsetX: 0,
      offsetY: -4
    })
  }

  @Builder
  ModeChip(mode: string) {
    Text(mode)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .lineHeight(16)
      .fontColor(AppColors.onSurface)
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .backgroundColor(this.activeMode === mode ? AppColors.primaryAlpha15 : AppColors.surface)
      .border({
        width: 1,
        color: this.activeMode === mode ? AppColors.primary : AppColors.outline
      })
      .borderRadius(AppShapes.small)
      .onClick(() => {
        this.activeMode = mode
      })
  }

  @Builder
  LinearMeter(value: number, accent: string, track: string) {
    Progress({
      value: Math.round(value * 100),
      total: 100,
      type: ProgressType.Linear
    })
      .width('100%')
      .height(6)
      .color(accent)
      .backgroundColor(track)
      .borderRadius(3)
  }

  @Builder
  StatusRow(label: string, value: number, accent: string) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(label)
          .fontSize(13)
          .fontWeight(FontWeight.Regular)
          .lineHeight(18)
          .fontColor(AppColors.onSurface)

        Text(`${Math.floor(value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .lineHeight(16)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      this.LinearMeter(value, accent, AppColors.surface)
    }
    .width('100%')
  }

  @Builder
  ZoneRow(zone: Zone) {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .lineHeight(22)
          .fontColor(AppColors.onSurface)

        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .lineHeight(16)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      this.LinearMeter(zone.humidity, AppColors.secondary, AppColors.surface)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surfaceVariantAlpha50)
    .borderRadius(AppShapes.small)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.md }) {
          Row({ space: AppSpacing.sm }) {
            ForEach(this.modes, (mode: string) => {
              this.ModeChip(mode)
            }, (mode: string) => mode)
          }
          .width('100%')

          Column({ space: AppSpacing.sm }) {
            this.HeadlineText('Solar wash')
            this.BodyText('Adjust orbital window glow', AppColors.onSurfaceAlpha70)

            Slider({
              value: this.solarLevel,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .blockColor(AppColors.primary)
              .selectedColor(AppColors.primary)
              .trackColor(AppColors.surfaceVariant)
              .onChange((value: number) => {
                this.solarLevel = value
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .lineHeight(16)
                .fontColor(AppColors.onSurface)

              Text(`${Math.floor(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .lineHeight(22)
                .fontColor(AppColors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)

            this.HeadlineText('Ambient glow')

            Slider({
              value: this.ambientGlow,
              min: 0,
              max: 1,
              step: 0.01,
              style: SliderStyle.OutSet
            })
              .width('100%')
              .blockColor(AppColors.secondary)
              .selectedColor(AppColors.secondary)
              .trackColor(AppColors.surfaceVariant)
              .onChange((value: number) => {
                this.ambientGlow = value
              })

            this.LinearMeter(this.ambientGlow, AppColors.secondary, AppColors.surfaceVariant)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)

          Column({ space: AppSpacing.sm }) {
            this.HeadlineText('Orbit health')
            this.StatusRow('Atmos mix', 0.74, AppColors.secondary)
            this.StatusRow('Hull temp', 0.42, AppColors.primary)
            this.StatusRow('Shield sync', 0.88, AppColors.tertiary)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)

          Column({ space: AppSpacing.sm }) {
            this.HeadlineText('Deck zones')

            ForEach(this.zones, (zone: Zone) => {
              this.ZoneRow(zone)
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}