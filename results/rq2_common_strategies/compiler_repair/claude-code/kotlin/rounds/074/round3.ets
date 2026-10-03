// 205_SmartOrbitPanel_en
// UI_TYPE: SmartHome ControlPanel
// STYLE_THEME: Retro Flat
// LANG: en
// BASELINE_SIZE: 720x1280
// DENSITY_SPACING: Compact
// COMPLEXITY: Includes Slider and ProgressBar to tune orbit lighting, monitor zones and provide flat retro meters.
// EXTRA: Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts.

// AppTokens - Colors
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
}

// AppTokens - Spacing
class AppSpacing {
  static readonly xs: Length = 4
  static readonly sm: Length = 8
  static readonly md: Length = 12
  static readonly lg: Length = 16
  static readonly xl: Length = 20
  static readonly xxl: Length = 28
  static readonly xxxl: Length = 40
}

// AppTokens - Shapes (corner radius in vp)
class AppShapes {
  static readonly small: Length = 12
  static readonly medium: Length = 16
  static readonly large: Length = 20
}

interface ZoneData {
  name: string
  humidity: number
  temp: string
}

// StatusRow component
@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: string = ''

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(13)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(AppColors.surface)
        .width('100%')
        .height(4)
    }
    .width('100%')
    .space(AppSpacing.xs)
  }
}

// ZoneRow component
@Component
struct ZoneRow {
  zone: ZoneData = { name: '', humidity: 0, temp: '' }

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Text(this.zone.temp)
          .fontSize(11)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surface)
        .width('100%')
        .height(4)
    }
    .width('100%')
    .padding(AppSpacing.sm)
    .backgroundColor(AppColors.surfaceVariant + '80')
    .borderRadius(AppShapes.small)
    .space(AppSpacing.xs)
  }
}

// Filter chip component
@Component
struct FilterChip {
  label: string = ''
  selected: boolean = false
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(11)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.selected ? this.hexWithAlpha(AppColors.primary, 0.15) : AppColors.surface)
      .borderRadius(AppShapes.small)
      .onClick(() => this.onSelect())
  }

  hexWithAlpha(hex: string, alpha: number): string {
    const a = Math.round(alpha * 255).toString(16).padStart(2, '0')
    return hex + a
  }
}

// Top Bar component
@Component
struct TopBar {
  build() {
    Row() {
      Text('Dock')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding(AppSpacing.sm)

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
        .padding(AppSpacing.sm)
    }
    .width('100%')
    .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: 12, bottom: 12 })
    .backgroundColor(AppColors.surface)
  }
}

// Bottom Bar component
@Component
struct BottomBar {
  build() {
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
      }
      .space(AppSpacing.xs)
      .layoutWeight(1)

      Button('Engage eco hold')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#1A000000', offsetY: 4 })
  }
}

// Solar wash card content
@Component
struct SolarWashCard {
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  build() {
    Column() {
      Text('Solar wash')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)

      Text('Adjust orbital window glow')
        .fontSize(13)
        .fontColor(AppColors.onSurface + 'B3')

      Slider({
        value: this.solarLevel * 100,
        min: 0,
        max: 100,
        style: SliderStyle.OutSet
      })
        .blockColor(AppColors.primary)
        .selectedColor(AppColors.primary)
        .trackColor(AppColors.surfaceVariant)
        .onChange((value: number) => {
          this.solarLevel = value / 100
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

      Text('Ambient glow')
        .fontSize(20)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.sm })

      Slider({
        value: this.ambientGlow * 100,
        min: 0,
        max: 100,
        style: SliderStyle.OutSet
      })
        .blockColor(AppColors.secondary)
        .selectedColor(AppColors.secondary)
        .trackColor(AppColors.surfaceVariant)
        .onChange((value: number) => {
          this.ambientGlow = value / 100
        })

      Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
        .color(AppColors.secondary)
        .backgroundColor(AppColors.surfaceVariant)
        .width('100%')
        .height(4)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .gap(AppSpacing.sm)
  }
}

// Main entry
@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: ZoneData[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ]

  build() {
    Column() {
      TopBar()

      Scroll() {
        Column() {
          // Mode filter chips
          Row() {
            ForEach(this.modes, (mode: string) => {
              FilterChip({
                label: mode,
                selected: this.activeMode === mode,
                onSelect: () => {
                  this.activeMode = mode
                }
              })
            }, (mode: string) => mode)
          }
          .width('100%')
          .gap(AppSpacing.sm)

          // Solar wash card
          Column() {
            SolarWashCard()
          }
          .width('100%')
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({ radius: 4, color: '#14000000', offsetY: 2 })

          // Orbit health card
          Column() {
            Text('Orbit health')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppColors.secondary })
            StatusRow({ label: 'Hull temp', value: 0.42, accent: AppColors.primary })
            StatusRow({ label: 'Shield sync', value: 0.88, accent: AppColors.tertiary })
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.large)
          .gap(AppSpacing.sm)

          // Deck zones card
          Column() {
            Text('Deck zones')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            ForEach(this.zones, (zone: ZoneData) => {
              ZoneRow({ zone: zone })
            }, (zone: ZoneData) => zone.name)
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .shadow({ radius: 4, color: '#14000000', offsetY: 2 })
          .gap(AppSpacing.sm)
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .gap(AppSpacing.md)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
