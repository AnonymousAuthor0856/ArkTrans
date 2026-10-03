import promptAction from '@ohos.promptAction'

// MARK: - AppTokens
// Design system tokens translated from SwiftUI/Kotlin AppTokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#D95F02'
    export const secondary: string = '#1B9AAA'
    export const tertiary: string = '#FEC601'
    export const background: string = '#F9F4EB'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#F0E3D1'
    export const outline: string = '#E1CDB2'
    export const success: string = '#56C271'
    export const warning: string = '#F4A259'
    export const error: string = '#D7263D'
    export const onPrimary: string = '#1B1B1B'
    export const onSecondary: string = '#041012'
    export const onTertiary: string = '#1E1200'
    export const onBackground: string = '#2C2A29'
    export const onSurface: string = '#2E2924'
  }

  export namespace Typography {
    export const displaySize: number = 28
    export const displayWeight: number = 600 // semibold
    export const headlineSize: number = 20
    export const headlineWeight: number = 600
    export const titleSize: number = 16
    export const titleWeight: number = 500 // medium
    export const bodySize: number = 13
    export const bodyWeight: number = 400 // regular
    export const labelSize: number = 11
    export const labelWeight: number = 500
  }

  export namespace Shapes {
    export const small: number = 12
    export const medium: number = 16
    export const large: number = 20
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 20
    export const xxl: number = 28
    export const xxxl: number = 40
  }

  export interface ShadowSpec {
    elevation: number
    radius: number
    dy: number
    opacity: number
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 2, radius: 4, dy: 2, opacity: 0.12 }
    export const level2: ShadowSpec = { elevation: 4, radius: 8, dy: 4, opacity: 0.16 }
    export const level3: ShadowSpec = { elevation: 8, radius: 12, dy: 6, opacity: 0.2 }
    export const level4: ShadowSpec = { elevation: 12, radius: 16, dy: 8, opacity: 0.24 }
    export const level5: ShadowSpec = { elevation: 16, radius: 20, dy: 10, opacity: 0.28 }
  }
}

// MARK: - Data Models
interface Zone {
  id: string
  name: string
  humidity: number
  temp: string
}

// MARK: - Reusable Components

// StatusRow: label + percentage + linear progress bar
@Component
struct StatusRow {
  label: string = ''
  value: number = 0
  accent: string = AppTokens.Colors.secondary

  build() {
    Column() {
      Row() {
        Text(this.label)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(`${Math.round(this.value * 100)}%`)
          .fontSize(AppTokens.Typography.labelSize + 5)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(this.accent)
      }
      .width('100%')

      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear })
        .color(this.accent)
        .backgroundColor(Color.White)
        .height(6)
        .borderRadius(3)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// ZoneRow: zone name + temp + humidity progress bar
@Component
struct ZoneRow {
  zone: Zone = { id: '', name: '', humidity: 0, temp: '' }

  build() {
    Column() {
      Row() {
        Text(this.zone.name)
          .fontSize(AppTokens.Typography.titleSize + 6)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Blank()
        Text(this.zone.temp)
          .fontSize(AppTokens.Typography.labelSize + 8)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .width('100%')

      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear })
        .color(AppTokens.Colors.secondary)
        .backgroundColor('#E5E5EA')
        .height(6)
        .borderRadius(3)
    }
    .width('100%')
    .padding(AppTokens.Spacing.sm)
    .backgroundColor('rgba(240, 227, 209, 0.5)')
    .borderRadius(AppTokens.Shapes.small)
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - Main Screen
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
        // MARK: Top Bar
        Row() {
          Button('Dock')
            .fontSize(AppTokens.Typography.labelSize + 6)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              promptAction.showToast({ message: 'Dock' })
            })
          Blank()
          Text('Smart Orbit Panel')
            .fontSize(AppTokens.Typography.titleSize + 14)
            .fontWeight(AppTokens.Typography.titleWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Blank()
          Button('Alerts')
            .fontSize(AppTokens.Typography.labelSize + 6)
            .fontColor(AppTokens.Colors.secondary)
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              promptAction.showToast({ message: 'Alerts' })
            })
        }
        .width('100%')
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // MARK: Scrollable Content
        Scroll() {
          Column() {
            // Mode selection chips
            Row() {
              ForEach(this.modes, (mode: string) => {
                Button(mode)
                  .fontSize(AppTokens.Typography.labelSize + 8)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .padding({
                    left: AppTokens.Spacing.md + 4,
                    right: AppTokens.Spacing.md + 4,
                    top: AppTokens.Spacing.sm + 4,
                    bottom: AppTokens.Spacing.sm + 4
                  })
                  .backgroundColor(
                    this.activeMode === mode
                      ? 'rgba(217, 95, 2, 0.15)'
                      : AppTokens.Colors.surface
                  )
                  .borderRadius(AppTokens.Shapes.small)
                  .border({
                    width: 1,
                    color: this.activeMode === mode ? 'rgba(217, 95, 2, 0.3)' : AppTokens.Colors.outline
                  })
                  .onClick(() => {
                    this.activeMode = mode
                  })
              }, (mode: string) => mode)
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            // Solar Wash Card
            Column() {
              Text('Solar wash')
                .fontSize(AppTokens.Typography.headlineSize + 14)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.sm })

              Text('Adjust orbital window glow')
                .fontSize(AppTokens.Typography.bodySize + 10)
                .fontWeight(AppTokens.Typography.bodyWeight)
                .fontColor('rgba(46, 41, 36, 0.7)')
                .margin({ bottom: AppTokens.Spacing.md })

              // Solar Slider
              Slider({
                value: this.solarLevel * 100,
                min: 0,
                max: 100,
                step: 1,
                style: SliderStyle.OutSet
              })
                .blockColor(AppTokens.Colors.surface)
                .trackColor('#E5E5EA')
                .selectedColor(AppTokens.Colors.primary)
                .height(40)
                .onChange((value: number) => {
                  this.solarLevel = value / 100
                })
                .margin({ bottom: AppTokens.Spacing.sm })

              // Slider labels
              Row() {
                Text('0%')
                  .fontSize(AppTokens.Typography.labelSize + 6)
                  .fontWeight(AppTokens.Typography.labelWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                Blank()
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontSize(AppTokens.Typography.titleSize + 20)
                  .fontWeight(AppTokens.Typography.titleWeight)
                  .fontColor(AppTokens.Colors.primary)
              }
              .width('100%')
              .margin({ bottom: AppTokens.Spacing.md })

              // Ambient Glow
              Text('Ambient glow')
                .fontSize(AppTokens.Typography.headlineSize + 14)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.sm })

              // Ambient Glow Slider
              Slider({
                value: this.ambientGlow * 100,
                min: 0,
                max: 100,
                step: 1,
                style: SliderStyle.OutSet
              })
                .blockColor(AppTokens.Colors.surface)
                .trackColor('#E5E5EA')
                .selectedColor(AppTokens.Colors.secondary)
                .height(40)
                .onChange((value: number) => {
                  this.ambientGlow = value / 100
                })
                .margin({ bottom: AppTokens.Spacing.sm })

              // Linear progress bar for ambient glow
              Progress({
                value: this.ambientGlow * 100,
                total: 100,
                type: ProgressType.Linear
              })
                .color(AppTokens.Colors.secondary)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .height(6)
                .borderRadius(3)
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg + 4)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
              offsetY: AppTokens.ElevationMapping.level1.dy
            })
            .alignItems(HorizontalAlign.Start)

            // Orbit Health Card
            Column() {
              Text('Orbit health')
                .fontSize(AppTokens.Typography.headlineSize + 16)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.sm })

              StatusRow({ label: 'Atmos mix', value: 0.74, accent: AppTokens.Colors.secondary })
                .margin({ bottom: AppTokens.Spacing.sm })
              StatusRow({ label: 'Hull temp', value: 0.42, accent: AppTokens.Colors.primary })
                .margin({ bottom: AppTokens.Spacing.sm })
              StatusRow({ label: 'Shield sync', value: 0.88, accent: AppTokens.Colors.tertiary })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg + 4)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
              offsetY: AppTokens.ElevationMapping.level1.dy
            })
            .alignItems(HorizontalAlign.Start)

            // Deck Zones Card
            Column() {
              Text('Deck zones')
                .fontSize(AppTokens.Typography.headlineSize + 16)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ bottom: AppTokens.Spacing.sm })

              ForEach(this.zones, (zone: Zone) => {
                ZoneRow({ zone: zone })
                  .margin({ bottom: AppTokens.Spacing.xs })
              }, (zone: Zone) => zone.id)
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg + 4)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({
              radius: AppTokens.ElevationMapping.level1.radius,
              color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level1.opacity})`,
              offsetY: AppTokens.ElevationMapping.level1.dy
            })
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // MARK: Bottom Bar
        Row() {
          Column() {
            Text('Grid draw')
              .fontSize(AppTokens.Typography.labelSize + 6)
              .fontWeight(AppTokens.Typography.labelWeight)
              .fontColor(AppTokens.Colors.onSurface)
            Text('18.4 kWh')
              .fontSize(AppTokens.Typography.titleSize + 16)
              .fontWeight(AppTokens.Typography.titleWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Engage eco hold')
            .fontSize(AppTokens.Typography.labelSize + 8)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .padding({
              left: AppTokens.Spacing.md + 4,
              right: AppTokens.Spacing.md + 4,
              top: AppTokens.Spacing.sm + 4,
              bottom: AppTokens.Spacing.sm + 4
            })
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              promptAction.showToast({ message: 'Engage eco hold' })
            })
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
          color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
          offsetY: -AppTokens.ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
