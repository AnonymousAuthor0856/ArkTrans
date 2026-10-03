const AppColors = {
  primary: '#D95F02',
  secondary: '#1B9AAA',
  tertiary: '#FEC601',
  background: '#F9F4EB',
  surface: '#FFFFFF',
  surfaceVariant: '#F0E3D1',
  outline: '#E1CDB2',
  success: '#56C271',
  warning: '#F4A259',
  error: '#D7263D',
  onPrimary: '#1B1B1B',
  onSecondary: '#041012',
  onTertiary: '#1E1200',
  onBackground: '#2C2A29',
  onSurface: '#2E2924',
  onSurfaceAlpha70: '#B32E2924',
  primaryAlpha15: '#26D95F02',
  surfaceVariantAlpha50: '#80F0E3D1',
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  xxl: 28,
  xxxl: 40,
}

const AppShapes = {
  small: 12,
  medium: 16,
  large: 20,
}

class Zone {
  name: string = ''
  humidity: number = 0
  temp: string = ''
  constructor(name: string, humidity: number, temp: string) {
    this.name = name
    this.humidity = humidity
    this.temp = temp
  }
}

@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F'),
  ]

  @Builder
  FilterChipBuilder(mode: string) {
    Text(mode)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .backgroundColor(this.activeMode === mode ? AppColors.primaryAlpha15 : AppColors.surface)
      .borderRadius(AppShapes.small)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .onClick(() => {
        this.activeMode = mode
      })
  }

  @Builder
  StatusRowBuilder(label: string, value: number, accent: string) {
    Column() {
      Row() {
        Text(label)
          .fontSize(13)
          .fontColor(AppColors.onSurface)
        Text(`${Math.round(value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(accent)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: Math.round(value * 100), total: 100, type: ProgressType.Linear })
        .width('100%')
        .color(accent)
        .backgroundColor(AppColors.surface)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .margin({ top: AppSpacing.sm })
  }

  @Builder
  ZoneRowBuilder(zone: Zone) {
    Column() {
      Row() {
        Text(zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Progress({ value: Math.round(zone.humidity * 100), total: 100, type: ProgressType.Linear })
        .width('100%')
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .backgroundColor(AppColors.surfaceVariantAlpha50)
    .borderRadius(AppShapes.small)
    .padding(AppSpacing.sm)
    .margin({ top: AppSpacing.sm })
  }

  build() {
    Column() {
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column() {
          Row() {
            ForEach(this.modes, (mode: string) => {
              this.FilterChipBuilder(mode)
            }, (mode: string) => mode)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)

          Column() {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor(AppColors.onSurfaceAlpha70)
              .margin({ top: AppSpacing.sm })

            Slider({ value: this.solarLevel, min: 0, max: 1, step: 0.01 })
              .width('100%')
              .blockColor(AppColors.primary)
              .trackColor(AppColors.surfaceVariant)
              .selectedColor(AppColors.primary)
              .margin({ top: AppSpacing.sm })
              .onChange((value: number) => {
                this.solarLevel = value
              })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: AppSpacing.xs })

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .margin({ top: AppSpacing.sm })

            Slider({ value: this.ambientGlow, min: 0, max: 1, step: 0.01 })
              .width('100%')
              .blockColor(AppColors.secondary)
              .trackColor(AppColors.surfaceVariant)
              .selectedColor(AppColors.secondary)
              .margin({ top: AppSpacing.sm })
              .onChange((value: number) => {
                this.ambientGlow = value
              })

            Progress({ value: Math.round(this.ambientGlow * 100), total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(AppColors.secondary)
              .backgroundColor(AppColors.surfaceVariant)
              .margin({ top: AppSpacing.sm })
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })

          Column() {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            this.StatusRowBuilder('Atmos mix', 0.74, AppColors.secondary)
            this.StatusRowBuilder('Hull temp', 0.42, AppColors.primary)
            this.StatusRowBuilder('Shield sync', 0.88, AppColors.tertiary)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })

          Column() {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            ForEach(this.zones, (zone: Zone) => {
              this.ZoneRowBuilder(zone)
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      Row() {
        Column() {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primary)
            .margin({ top: AppSpacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Button('Engage eco hold') {
          Text('Engage eco hold')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
        }
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .height(40)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}