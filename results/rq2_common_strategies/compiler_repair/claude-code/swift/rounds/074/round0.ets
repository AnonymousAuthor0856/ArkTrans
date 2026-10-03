// AppTokens - design system tokens
namespace AppTokens {
  export class Colors {
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

  export class TypographyTokens {
    static readonly displaySize: number = 28
    static readonly displayWeight: number = FontWeight.Medium
    static readonly headlineSize: number = 20
    static readonly headlineWeight: number = FontWeight.Medium
    static readonly titleSize: number = 16
    static readonly titleWeight: number = FontWeight.Medium
    static readonly bodySize: number = 13
    static readonly bodyWeight: number = FontWeight.Normal
    static readonly labelSize: number = 11
    static readonly labelWeight: number = FontWeight.Medium
  }

  export class Shapes {
    static readonly small: number = 12
    static readonly medium: number = 16
    static readonly large: number = 20
  }

  export class Spacing {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 20
    static readonly xxl: number = 28
    static readonly xxxl: number = 40
  }

  export interface ShadowSpec {
    elevation: number
    radius: number
    dy: number
    opacity: number
  }

  export class ElevationMapping {
    static readonly level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
    static readonly level2: ShadowSpec = { elevation: 4, radius: 8, dy: 4, opacity: 0.16 }
    static readonly level3: ShadowSpec = { elevation: 8, radius: 12, dy: 6, opacity: 0.2 }
    static readonly level4: ShadowSpec = { elevation: 12, radius: 16, dy: 8, opacity: 0.24 }
    static readonly level5: ShadowSpec = { elevation: 16, radius: 20, dy: 10, opacity: 0.28 }
  }
}

// Zone data model
interface Zone {
  id: string
  name: string
  humidity: number
  temp: string
}

// StatusRow component
@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: string = AppTokens.Colors.secondary

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor('#00000000')
        .height(4)
        .borderRadius(2)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// ZoneRow component
@Component
struct ZoneRow {
  zone: Zone = { id: '', name: '', humidity: 0, temp: '' }

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTokens.TypographyTokens.titleSize)
          .fontWeight(AppTokens.TypographyTokens.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(this.zone.temp)
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .backgroundColor(AppTokens.Colors.surface)
        .height(4)
        .borderRadius(2)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.sm)
    .backgroundColor(AppTokens.Colors.surfaceVariant + '80')
    .borderRadius(AppTokens.Shapes.small)
  }
}

// Main entry screen
@Entry
@Component
struct RootScreen {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private zones: Zone[] = [
    { id: '1', name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { id: '2', name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { id: '3', name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top Bar
        Row() {
          Button('Dock')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .height('auto')

          Blank()

          Text('Smart Orbit Panel')
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Button('Alerts')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontColor(AppTokens.Colors.secondary)
            .backgroundColor(Color.Transparent)
            .height('auto')
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable content
        Scroll() {
          Column() {
            // Mode selection chips
            Row() {
              ForEach(this.modes, (mode: string) => {
                Button(mode)
                  .fontSize(AppTokens.TypographyTokens.labelSize)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding({
                    left: AppTokens.Spacing.md,
                    right: AppTokens.Spacing.md,
                    top: AppTokens.Spacing.sm,
                    bottom: AppTokens.Spacing.sm
                  })
                  .backgroundColor(
                    this.activeMode === mode
                      ? this.hexWithAlpha(AppTokens.Colors.primary, 0.15)
                      : AppTokens.Colors.surface
                  )
                  .borderRadius(AppTokens.Shapes.small)
                  .border({
                    width: 1,
                    color: this.activeMode === mode
                      ? Color.Transparent
                      : AppTokens.Colors.outline
                  })
                  .height('auto')
                  .onClick(() => {
                    this.activeMode = mode
                  })
                  .margin({ right: AppTokens.Spacing.sm })
              }, (mode: string) => mode)
            }
            .width('100%')
            .alignItems(VerticalAlign.Center)

            // Solar Wash card
            Column() {
              Text('Solar wash')
                .fontSize(AppTokens.TypographyTokens.headlineSize)
                .fontWeight(AppTokens.TypographyTokens.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)

              Text('Adjust orbital window glow')
                .fontSize(AppTokens.TypographyTokens.bodySize)
                .fontWeight(AppTokens.TypographyTokens.bodyWeight)
                .fontColor(this.hexWithAlpha(AppTokens.Colors.onSurface, 0.7))

              Slider({ value: this.solarLevel * 100, min: 0, max: 100, style: SliderStyle.OutSet })
                .blockColor(AppTokens.Colors.primary)
                .trackColor(AppTokens.Colors.surfaceVariant)
                .selectedColor(AppTokens.Colors.primary)
                .onChange((value: number) => {
                  this.solarLevel = value / 100
                })

              Row() {
                Text('0%')
                  .fontSize(AppTokens.TypographyTokens.labelSize)
                  .fontWeight(AppTokens.TypographyTokens.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                Blank()
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontSize(AppTokens.TypographyTokens.titleSize)
                  .fontWeight(AppTokens.TypographyTokens.titleWeight)
                  .fontColor(AppTokens.Colors.primary)
              }
              .width('100%')

              Text('Ambient glow')
                .fontSize(AppTokens.TypographyTokens.headlineSize)
                .fontWeight(AppTokens.TypographyTokens.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.sm })

              Slider({ value: this.ambientGlow * 100, min: 0, max: 100, style: SliderStyle.OutSet })
                .blockColor(AppTokens.Colors.secondary)
                .trackColor(AppTokens.Colors.surfaceVariant)
                .selectedColor(AppTokens.Colors.secondary)
                .onChange((value: number) => {
                  this.ambientGlow = value / 100
                })

              Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear })
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .height(4)
                .borderRadius(2)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.radius,
              color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level1.opacity + ')',
              offsetY: AppTokens.ElevationMapping.level1.dy
            })

            // Orbit Health card
            Column() {
              Text('Orbit health')
                .fontSize(AppTokens.TypographyTokens.headlineSize)
                .fontWeight(AppTokens.TypographyTokens.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)

              StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
              StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
              StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.radius,
              color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level1.opacity + ')',
              offsetY: AppTokens.ElevationMapping.level1.dy
            })

            // Deck Zones card
            Column() {
              Text('Deck zones')
                .fontSize(AppTokens.TypographyTokens.headlineSize)
                .fontWeight(AppTokens.TypographyTokens.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)

              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zone: zone })
              }, (zone: Zone) => zone.id)
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.radius,
              color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level1.opacity + ')',
              offsetY: AppTokens.ElevationMapping.level1.dy
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
          .space(AppTokens.Spacing.md)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom Bar
        Row() {
          Column() {
            Text('Grid draw')
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(AppTokens.TypographyTokens.labelWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('18.4 kWh')
              .fontSize(AppTokens.TypographyTokens.titleSize)
              .fontWeight(AppTokens.TypographyTokens.titleWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Engage eco hold')
            .fontSize(AppTokens.TypographyTokens.labelSize)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({
              left: AppTokens.Spacing.md,
              right: AppTokens.Spacing.md,
              top: AppTokens.Spacing.sm,
              bottom: AppTokens.Spacing.sm
            })
            .height('auto')
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm
        })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(0,0,0,' + AppTokens.ElevationMapping.level2.opacity + ')',
          offsetY: AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  private hexWithAlpha(hex: string, alpha: number): string {
    const r = parseInt(hex.slice(3, 5), 16)
    const g = parseInt(hex.slice(5, 7), 16)
    const b = parseInt(hex.slice(7, 9), 16)
    return `rgba(${r},${g},${b},${alpha})`
  }
}
