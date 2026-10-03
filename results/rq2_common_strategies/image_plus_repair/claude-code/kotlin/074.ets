// Smart Orbit Panel - ArkTS implementation
// Converted from Kotlin Compose

class AppTokensColors {
  static readonly primary: string = '#FFD95F02'
  static readonly secondary: string = '#FF1B9AAA'
  static readonly tertiary: string = '#FFFEC601'
  static readonly background: string = '#FFF9F4EB'
  static readonly surface: string = '#FFFFFFFF'
  static readonly surfaceVariant: string = '#FFF0E3D1'
  static readonly outline: string = '#FFE1CDB2'
  static readonly success: string = '#FF56C271'
  static readonly warning: string = '#FFF4A259'
  static readonly error: string = '#FFD7263D'
  static readonly onPrimary: string = '#FF1B1B1B'
  static readonly onSecondary: string = '#FF041012'
  static readonly onTertiary: string = '#FF1E1200'
  static readonly onBackground: string = '#FF2C2A29'
  static readonly onSurface: string = '#FF2E2924'
}

class AppTokensSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 20
  static readonly xxl: number = 28
  static readonly xxxl: number = 40
}

class AppTokensRadius {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
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
  accent: string = AppTokensColors.secondary

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontColor(AppTokensColors.onSurface)
          .layoutWeight(1)
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')
      .margin({ bottom: AppTokensSpacing.xs })

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppTokensColors.surface)
        .height(8)
        .borderRadius(4)
        .width('100%')
    }
    .width('100%')
  }
}

@Component
struct ZoneRow {
  zone: Zone = new Zone('', 0, '')

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokensColors.onSurface)
          .layoutWeight(1)
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokensColors.primary)
      }
      .width('100%')
      .margin({ bottom: AppTokensSpacing.xs })

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppTokensColors.secondary)
        .backgroundColor(AppTokensColors.surface)
        .height(8)
        .borderRadius(4)
        .width('100%')
    }
    .width('100%')
    .padding(AppTokensSpacing.sm)
    .backgroundColor('rgba(240, 227, 209, 0.5)')
    .borderRadius(AppTokensRadius.small)
  }
}

@Component
struct FilterChip {
  label: string = ''
  selected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppTokensColors.onSurface)
      .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.sm + 2, bottom: AppTokensSpacing.sm + 2 })
      .backgroundColor(this.selected ? 'rgba(217, 95, 2, 0.15)' : AppTokensColors.surface)
      .borderRadius(AppTokensRadius.small)
      .border({ width: this.selected ? 0 : 1, color: AppTokensColors.outline })
      .onClick(() => {
        this.onSelect()
      })
  }
}

@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    new Zone('Atrium', 0.45, '72°F'),
    new Zone('Lab East', 0.62, '68°F'),
    new Zone('Hab Deck', 0.30, '70°F')
  ]

  aboutToAppear(): void {}

  build() {
    Column() {
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokensColors.onSurface)
          .layoutWeight(1)

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokensColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokensColors.secondary)
          .layoutWeight(1)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.xl + 12, bottom: AppTokensSpacing.lg + 4 })
      .backgroundColor(AppTokensColors.surface)

      Scroll() {
        Column() {
          Row() {
            ForEach(this.modes, (mode: string) => {
              FilterChip({
                label: mode,
                selected: this.activeMode === mode,
                onSelect: () => { this.activeMode = mode }
              })
            }, (mode: string) => mode)
          }
          .width('100%')
          .margin({ top: AppTokensSpacing.sm, bottom: AppTokensSpacing.xs })

          Column() {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokensColors.onSurface)

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor('rgba(46, 41, 36, 0.7)')
              .margin({ top: AppTokensSpacing.xs })

            Stack({ alignContent: Alignment.Center }) {
              Row()
                .width('100%')
                .height(24)
                .backgroundColor('rgba(230, 220, 245, 0.8)')
                .borderRadius(12)

              Row()
                .width(`${this.solarLevel * 100}%`)
                .height(24)
                .backgroundColor(AppTokensColors.primary)
                .borderRadius(12)
                .alignSelf(ItemAlign.Start)

              Slider({ value: this.solarLevel * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
                .blockColor(AppTokensColors.primary)
                .trackColor(Color.Transparent)
                .selectedColor(Color.Transparent)
                .width('100%')
                .height(40)
                .onChange((value: number) => {
                  this.solarLevel = value / 100
                })
            }
            .width('100%')
            .height(40)
            .margin({ top: AppTokensSpacing.sm })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokensColors.onSurface)
                .layoutWeight(1)
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokensColors.primary)
            }
            .width('100%')
            .margin({ top: AppTokensSpacing.xs })

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokensColors.onSurface)
              .margin({ top: AppTokensSpacing.md })

            Stack({ alignContent: Alignment.Center }) {
              Row()
                .width('100%')
                .height(24)
                .backgroundColor('rgba(230, 220, 245, 0.8)')
                .borderRadius(12)

              Row()
                .width(`${this.ambientGlow * 100}%`)
                .height(24)
                .backgroundColor(AppTokensColors.secondary)
                .borderRadius(12)
                .alignSelf(ItemAlign.Start)

              Slider({ value: this.ambientGlow * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
                .blockColor(AppTokensColors.secondary)
                .trackColor(Color.Transparent)
                .selectedColor(Color.Transparent)
                .width('100%')
                .height(40)
                .onChange((value: number) => {
                  this.ambientGlow = value / 100
                })
            }
            .width('100%')
            .height(40)
            .margin({ top: AppTokensSpacing.sm })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .color(AppTokensColors.secondary)
              .backgroundColor(AppTokensColors.surfaceVariant)
              .height(8)
              .borderRadius(4)
              .width('100%')
              .margin({ top: AppTokensSpacing.sm })
          }
          .width('100%')
          .padding(AppTokensSpacing.lg)
          .backgroundColor(AppTokensColors.surface)
          .borderRadius(AppTokensRadius.large)
          .margin({ top: AppTokensSpacing.sm })

          Column() {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokensColors.onSurface)
              .margin({ bottom: AppTokensSpacing.sm })

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokensColors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokensColors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokensColors.tertiary })
          }
          .width('100%')
          .padding(AppTokensSpacing.lg)
          .backgroundColor(AppTokensColors.surfaceVariant)
          .borderRadius(AppTokensRadius.large)
          .margin({ top: AppTokensSpacing.md })

          Column() {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokensColors.onSurface)
              .margin({ bottom: AppTokensSpacing.sm })

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .padding(AppTokensSpacing.lg)
          .backgroundColor(AppTokensColors.surface)
          .borderRadius(AppTokensRadius.large)
          .margin({ top: AppTokensSpacing.md })
        }
        .width('100%')
        .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, bottom: AppTokensSpacing.lg })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')

      Row() {
        Column() {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokensColors.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokensColors.primary)
            .margin({ top: AppTokensSpacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Engage eco hold')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokensColors.onPrimary)
          .backgroundColor(AppTokensColors.primary)
          .borderRadius(AppTokensRadius.medium)
          .height(44)
          .padding({ left: AppTokensSpacing.xl, right: AppTokensSpacing.xl })
      }
      .width('100%')
      .padding({ left: AppTokensSpacing.lg, right: AppTokensSpacing.lg, top: AppTokensSpacing.sm + 4, bottom: AppTokensSpacing.sm + 28 })
      .backgroundColor(AppTokensColors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokensColors.background)
  }
}
