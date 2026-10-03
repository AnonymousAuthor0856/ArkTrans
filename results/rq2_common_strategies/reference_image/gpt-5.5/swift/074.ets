class AppColors {
  static readonly primary: string = '#FFD95F02'
  static readonly secondary: string = '#FF1B9AAA'
  static readonly tertiary: string = '#FFFEC601'
  static readonly background: string = '#FFF9F4EB'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFF0E3D1'
  static readonly surfaceVariantHalf: string = '#80F0E3D1'
  static readonly outline: string = '#FFE1CDB2'
  static readonly success: string = '#FF56C271'
  static readonly warning: string = '#FFF4A259'
  static readonly error: string = '#FFD7263D'
  static readonly onPrimary: string = '#FF1B1B1B'
  static readonly onSecondary: string = '#FF041012'
  static readonly onTertiary: string = '#FF1E1200'
  static readonly onBackground: string = '#FF2C2A29'
  static readonly onSurface: string = '#FF2E2924'
  static readonly onSurface70: string = '#B32E2924'
  static readonly sliderTrack: string = '#FFE1E1E1'
}

class AppFontSize {
  static readonly display: number = 28
  static readonly headline: number = 20
  static readonly title: number = 16
  static readonly body: number = 13
  static readonly label: number = 11
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
struct LinearBar {
  @Prop value: number = 0
  @Prop accent: string = AppColors.primary
  @Prop trackColor: string = AppColors.sliderTrack

  private barWidth(): string {
    const v: number = Math.max(0, Math.min(100, this.value))
    return `${v}%`
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {
      Row()
        .width('100%')
        .height(4)
        .backgroundColor(this.trackColor)
        .borderRadius(2)

      Row()
        .width(this.barWidth())
        .height(4)
        .backgroundColor(this.accent)
        .borderRadius(2)
    }
    .width('100%')
    .height(4)
  }
}

@Component
struct StatusRow {
  @Prop label: string = ''
  @Prop value: number = 0
  @Prop accent: string = AppColors.primary

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.label)
          .fontSize(AppFontSize.body)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(`${this.value.toFixed(0)}%`)
          .fontSize(AppFontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')

      LinearBar({
        value: this.value,
        accent: this.accent,
        trackColor: AppColors.sliderTrack
      })
    }
    .width('100%')
  }
}

@Component
struct ZoneRow {
  @Prop name: string = ''
  @Prop humidity: number = 0
  @Prop temp: string = ''

  build() {
    Column({ space: AppSpacing.xs }) {
      Row() {
        Text(this.name)
          .fontSize(AppFontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(this.temp)
          .fontSize(AppFontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      LinearBar({
        value: this.humidity,
        accent: AppColors.secondary,
        trackColor: AppColors.sliderTrack
      })
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surfaceVariantHalf)
    .borderRadius(AppShapes.small)
  }
}

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 60
  @State ambientGlow: number = 35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    new Zone('Atrium', 45, '72°F'),
    new Zone('Lab East', 62, '68°F'),
    new Zone('Hab Deck', 30, '70°F')
  ]

  @Builder
  private ModeChip(mode: string) {
    Text(mode)
      .fontSize(AppFontSize.label)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .padding({
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.sm,
        bottom: AppSpacing.sm
      })
      .backgroundColor(this.activeMode === mode ? '#26D95F02' : AppColors.surface)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .borderRadius(AppShapes.small)
      .onClick(() => {
        this.activeMode = mode
      })
  }

  @Builder
  private TopBar() {
    Row() {
      Text('Dock')
        .width(72)
        .fontSize(AppFontSize.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text('Smart Orbit Panel')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .fontSize(AppFontSize.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text('Alerts')
        .width(72)
        .textAlign(TextAlign.End)
        .fontSize(AppFontSize.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
    }
    .height(56)
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private SolarWashCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Solar wash')
        .width('100%')
        .fontSize(AppFontSize.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Text('Adjust orbital window glow')
        .width('100%')
        .fontSize(AppFontSize.body)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface70)

      Slider({
        value: this.solarLevel,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.sliderTrack)
        .blockColor(AppColors.surface)
        .showTips(false)
        .onChange((value: number) => {
          this.solarLevel = value
        })

      Row() {
        Text('0%')
          .fontSize(AppFontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Blank()

        Text(`${this.solarLevel.toFixed(0)}%`)
          .fontSize(AppFontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Text('Ambient glow')
        .width('100%')
        .fontSize(AppFontSize.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Slider({
        value: this.ambientGlow,
        min: 0,
        max: 100,
        step: 1,
        style: SliderStyle.OutSet
      })
        .width('100%')
        .selectedColor(AppColors.secondary)
        .trackColor(AppColors.sliderTrack)
        .blockColor(AppColors.surface)
        .showTips(false)
        .onChange((value: number) => {
          this.ambientGlow = value
        })

      LinearBar({
        value: this.ambientGlow,
        accent: AppColors.secondary,
        trackColor: AppColors.outline
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  private OrbitHealthCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Orbit health')
        .width('100%')
        .fontSize(AppFontSize.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      StatusRow({
        label: 'Atmos mix',
        value: 74,
        accent: AppColors.secondary
      })

      StatusRow({
        label: 'Hull temp',
        value: 42,
        accent: AppColors.primary
      })

      StatusRow({
        label: 'Shield sync',
        value: 88,
        accent: AppColors.tertiary
      })
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  private DeckZonesCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Deck zones')
        .width('100%')
        .fontSize(AppFontSize.headline)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      ForEach(this.zones, (zone: Zone) => {
        ZoneRow({
          name: zone.name,
          humidity: zone.humidity,
          temp: zone.temp
        })
      }, (zone: Zone) => zone.name)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  private BottomBar() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text('Grid draw')
          .fontSize(AppFontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text('18.4 kWh')
          .fontSize(AppFontSize.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('Engage eco hold')
        .fontSize(AppFontSize.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
          bottom: AppSpacing.sm
        })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
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
      radius: 8,
      color: '#29000000',
      offsetX: 0,
      offsetY: -4
    })
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
          .justifyContent(FlexAlign.Start)

          this.SolarWashCard()
          this.OrbitHealthCard()
          this.DeckZonesCard()
        }
        .width('100%')
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.sm,
          bottom: AppSpacing.xl
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}