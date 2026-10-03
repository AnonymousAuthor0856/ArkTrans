import { LengthMetrics } from '@kit.ArkUI'

// Design tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#38BDF8'
    export const secondary: string = '#0EA5E9'
    export const tertiary: string = '#0369A1'
    export const background: string = '#F0F9FF'
    export const surface: string = '#FFFFFF'
    export const surfaceVariant: string = '#E0F2FE'
    export const outline: string = '#BFE0F4'
    export const success: string = '#16A34A'
    export const warning: string = '#F59E0B'
    export const error: string = '#DC2626'
    export const onPrimary: string = '#001F2F'
    export const onSecondary: string = '#FFFFFF'
    export const onTertiary: string = '#FFFFFF'
    export const onBackground: string = '#082F49'
    export const onSurface: string = '#082F49'
    export const onSurfaceMuted: string = '#082F49'
  }

  export namespace Typography {
    export const displaySize: number = 26
    export const titleSize: number = 16
    export const bodySize: number = 13
    export const labelSize: number = 11
  }

  export namespace Spacing {
    export const xs: number = 4
    export const sm: number = 8
    export const md: number = 12
    export const lg: number = 16
    export const xl: number = 24
    export const xxl: number = 32
  }

  export namespace Radius {
    export const small: number = 8
    export const medium: number = 12
    export const large: number = 20
  }
}

interface VideoItem {
  title: string
  duration: string
}

const videos: VideoItem[] = [
  { title: 'Nature Documentary', duration: '24:18' },
  { title: 'AI Explained', duration: '18:52' },
  { title: 'Space Travel', duration: '31:09' },
  { title: 'Modern Art Review', duration: '15:45' },
  { title: 'Retro Music Visuals', duration: '22:10' },
  { title: 'Daily News Recap', duration: '12:34' },
]

@Component
struct VideoCard {
  item: VideoItem = { title: '', duration: '' }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Thumbnail placeholder
      Stack() {
        Text('Thumbnail')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor('#99082F49')
      }
      .width('100%')
      .height(120)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Radius.small)
      .alignContent(Alignment.Center)

      // Title
      Text(this.item.title)
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')

      // Duration
      Text(this.item.duration)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3082F49')
        .width('100%')

      // Play button
      Button('Play')
        .width('100%')
        .height(40)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Radius.small)
        .onClick(() => {})
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .shadow({
      radius: 4,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

@Component
struct RootScreen {
  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Video Library')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Body with gradient background
      Column({ space: AppTokens.Spacing.md }) {
        Text('Explore the latest videos')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .width('100%')

        // Grid of video cards
        Grid() {
          ForEach(videos, (item: VideoItem) => {
            GridItem() {
              VideoCard({ item: item })
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.md)
        .rowsGap(AppTokens.Spacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}