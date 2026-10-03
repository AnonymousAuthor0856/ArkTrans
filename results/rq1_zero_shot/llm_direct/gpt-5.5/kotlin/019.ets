const NAME: string = '019SubtitleEditoren'
const UI_TYPE: string = 'Media'
const STYLE_THEME: string = 'Clay Morph'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

namespace AppTokens {
  export namespace Colors {
    export const primary: ResourceColor = '#8B5CF6'
    export const secondary: ResourceColor = '#D946EF'
    export const tertiary: ResourceColor = '#3B82F6'
    export const background: ResourceColor = '#F9F5FF'
    export const surface: ResourceColor = '#FFFFFF'
    export const surfaceVariant: ResourceColor = '#F1E9FE'
    export const outline: ResourceColor = '#E3D7FE'
    export const success: ResourceColor = '#22C55E'
    export const warning: ResourceColor = '#FACC15'
    export const error: ResourceColor = '#EF4444'
    export const onPrimary: ResourceColor = '#FFFFFF'
    export const onSecondary: ResourceColor = '#FFFFFF'
    export const onTertiary: ResourceColor = '#FFFFFF'
    export const onBackground: ResourceColor = '#1E1E1E'
    export const onSurface: ResourceColor = '#1E1E1E'
  }

  export namespace TypographyTokens {
    export const displaySize: number = 28
    export const titleSize: number = 18
    export const bodySize: number = 14
    export const labelSize: number = 12
  }

  export namespace Shapes {
    export const small: number = 8
    export const medium: number = 14
    export const large: number = 22
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }

  export interface ShadowSpec {
    elevation: number
    radius: number
    dy: number
    opacity: number
  }

  export namespace ElevationMapping {
    export const level1: ShadowSpec = { elevation: 4, radius: 8, dy: 2, opacity: 0.14 }
    export const level2: ShadowSpec = { elevation: 8, radius: 12, dy: 6, opacity: 0.18 }
  }
}

@Entry
@Component
struct RootScreen {
  @State private fontSize: number = 24
  @State private syncProgress: number = 0.3

  build() {
    Column() {
      Row() {
        Text('Subtitle Editor')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.lg }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(200)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)
        .shadow({
          radius: AppTokens.ElevationMapping.level2.radius,
          color: 'rgba(0, 0, 0, 0.18)',
          offsetX: 0,
          offsetY: AppTokens.ElevationMapping.level2.dy
        })

        Text(`Font Size: ${Math.floor(this.fontSize)}sp`)
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Slider({
          value: this.fontSize,
          min: 16,
          max: 48,
          step: 1,
          style: SliderStyle.OutSet
        })
          .width('100%')
          .blockColor(AppTokens.Colors.secondary)
          .trackColor(AppTokens.Colors.surfaceVariant)
          .selectedColor(AppTokens.Colors.primary)
          .onChange((value: number) => {
            this.fontSize = value
          })

        Text('Sync Progress')
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        Progress({
          value: this.syncProgress * 100,
          total: 100,
          type: ProgressType.Linear
        })
          .width('100%')
          .height(6)
          .color(AppTokens.Colors.primary)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(3)

        Row({ space: AppTokens.Spacing.md }) {
          Button('Sync +')
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.min(this.syncProgress + 0.1, 1)
            })

          Button('Sync -')
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .borderRadius(AppTokens.Shapes.medium)
            .onClick(() => {
              this.syncProgress = Math.max(this.syncProgress - 0.1, 0)
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 0.5],
          [AppTokens.Colors.surface, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}