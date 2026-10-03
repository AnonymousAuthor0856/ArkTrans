// Smart Orbit Panel - ArkTS implementation
// Converted from Kotlin Compose

class AppTokens {
  static class Colors {
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

  static class Spacing {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 20
    static readonly xxl: number = 28
    static readonly xxxl: number = 40
  }

  static class Radius {
    static readonly small: number = 12
    static readonly medium: number = 16
    static readonly large: number = 20
  }
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
  accent: string = AppTokens.Colors.secondary

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppTokens.Colors.surface)
        .height(8)
        .borderRadius(4)
        .width('100%')
    }
    .width('100%')
    .gap(AppTokens.Spacing.xs)
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
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .height(8)
        .borderRadius(4)
        .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.sm)
    .backgroundColor('rgba(240, 227, 209, 0.5)')
    .borderRadius(AppTokens.Radius.small)
    .gap(AppTokens.Spacing.xs)
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
      .fontColor(AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm + 2, bottom: AppTokens.Spacing.sm + 2 })
      .backgroundColor(this.selected ? 'rgba(217, 95, 2, 0.15)' : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Radius.small)
      .border({ width: this.selected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => this.onSelect())
  }
}

@Component
struct CustomSlider {
  value: number = 0
  accentColor: string = AppTokens.Colors.primary
  onChange: (value: number) => void = () => {}

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Track background
      Row()
        .width('100%')
        .height(24)
        .backgroundColor('rgba(230, 220, 245, 0.8)')
        .borderRadius(12)

      // Active track
      Row()
        .width(`${this.value * 100}%`)
        .height(24)
        .backgroundColor(this.accentColor)
        .borderRadius(12)
        .alignSelf(ItemAlign.Start)

      // Thumb
      Circle()
        .width(10)
        .height(10)
        .fill(this.accentColor)
        .translate({ x: 0 })
        .alignSelf(ItemAlign.Center)
        .offset({ x: `${this.value * 100}%` })

      Slider({ value: this.value * 100, min: 0, max: 100, step: 1, style: SliderStyle.OutSet })
        .blockColor(this.accentColor)
        .trackColor(Color.Transparent)
        .selectedColor(Color.Transparent)
        .width('100%')
        .height(40)
        .onChange((value: number) => {
          this.onChange(value / 100)
        })
    }
    .width('100%')
    .height(40)
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

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Dock')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)

        Text('Smart Orbit Panel')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('Alerts')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .layoutWeight(1)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.xl + 12, bottom: AppTokens.Spacing.lg + 4 })
      .backgroundColor(AppTokens.Colors.surface)

      Scroll() {
        Column() {
          // Mode filter chips
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
          .gap(AppTokens.Spacing.sm)
          .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.xs })

          // Solar wash & Ambient glow card
          Column() {
            Text('Solar wash')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)

            Text('Adjust orbital window glow')
              .fontSize(13)
              .fontColor('rgba(46, 41, 36, 0.7)')
              .margin({ top: AppTokens.Spacing.xs })

            CustomSlider({
              value: this.solarLevel,
              accentColor: AppTokens.Colors.primary,
              onChange: (val: number) => { this.solarLevel = val }
            })
            .margin({ top: AppTokens.Spacing.sm })

            Row() {
              Text('0%')
                .fontSize(11)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.onSurface)
                .layoutWeight(1)
              Text(`${Math.round(this.solarLevel * 100)}%`)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppTokens.Colors.primary)
            }
            .width('100%')
            .margin({ top: AppTokens.Spacing.xs })

            Text('Ambient glow')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ top: AppTokens.Spacing.md })

            CustomSlider({
              value: this.ambientGlow,
              accentColor: AppTokens.Colors.secondary,
              onChange: (val: number) => { this.ambientGlow = val }
            })
            .margin({ top: AppTokens.Spacing.sm })

            Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
              .color(AppTokens.Colors.secondary)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .height(8)
              .borderRadius(4)
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.large)
          .margin({ top: AppTokens.Spacing.sm })

          // Orbit health card
          Column() {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.xs })

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.large)
          .margin({ top: AppTokens.Spacing.md })

          // Deck zones card
          Column() {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.xs })

            ForEach(this.zones, (zone: Zone) => {
              ZoneRow({ zone: zone })
            }, (zone: Zone) => zone.name)
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.large)
          .margin({ top: AppTokens.Spacing.md })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')

      // Bottom bar
      Row() {
        Column() {
          Text('Grid draw')
            .fontSize(11)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          Text('18.4 kWh')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.primary)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Button('Engage eco hold')
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.medium)
          .height(44)
          .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl })
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm + 4, bottom: AppTokens.Spacing.sm + 28 })
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
