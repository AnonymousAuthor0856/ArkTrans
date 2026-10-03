import { router } from '@kit.ArkUI'

// Design Tokens
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#38BDF8'
    export const secondary: string = '#0EA5E9'
    export const tertiary: string = '#0284C7'
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
    export const onSurfaceMuted: string = '#082F49B2'
  }

  export namespace Typography {
    export const displaySize: number = 28
    export const titleSize: number = 18
    export const bodySize: number = 14
    export const labelSize: number = 12
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

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = [
    'AI Insights',
    'Mindful Moments',
    'History Flash',
    'Tech Hour',
    'Design Flow'
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Podcasts')
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  SegmentedTabs() {
    Row() {
      ForEach(this.tabs, (label: string, index: number) => {
        Text(label)
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.selectedTab === index
            ? AppTokens.Colors.onPrimary
            : AppTokens.Colors.onSurface)
          .backgroundColor(this.selectedTab === index
            ? AppTokens.Colors.primary
            : AppTokens.Colors.surface)
          .borderRadius(AppTokens.Radius.small)
          .padding({
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm,
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md
          })
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .border({
            width: 1,
            color: AppTokens.Colors.outline,
            radius: AppTokens.Radius.small
          })
          .onClick(() => {
            this.selectedTab = index
          })
      })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.small)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Radius.small
    })
    .padding(2)
  }

  @Builder
  PodcastCard(podcastName: string) {
    Row() {
      Column() {
        Text(podcastName)
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ bottom: AppTokens.Spacing.xs })

        Text('30 min episode')
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurfaceMuted)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Play')
        .fontSize(AppTokens.Typography.labelSize)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(AppTokens.Radius.small)
        .height(36)
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg
        })
        .onClick(() => {
          this.showDialog = true
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .shadow({
      radius: 8,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  PlayingDialog() {
    if (this.showDialog) {
      Column() {
        Column() {
          Text('Playing Podcast')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ bottom: AppTokens.Spacing.sm })

          Text('Streaming audio...')
            .fontSize(AppTokens.Typography.bodySize)
            .fontColor(AppTokens.Colors.onSurfaceMuted)
            .margin({ bottom: AppTokens.Spacing.xl })

          Row() {
            Text('OK')
              .fontSize(AppTokens.Typography.labelSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.primary)
              .onClick(() => {
                this.showDialog = false
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.End)
        }
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Radius.large)
        .padding(AppTokens.Spacing.xl)
        .width('85%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#80000000')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .position({ x: 0, y: 0 })
      .onClick(() => {
        this.showDialog = false
      })
    }
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            this.SegmentedTabs()

            Column({ space: AppTokens.Spacing.md }) {
              ForEach(this.podcasts, (podcast: string) => {
                this.PodcastCard(podcast)
              })
            }
            .width('100%')
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.lg,
            bottom: AppTokens.Spacing.lg
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [AppTokens.Colors.surfaceVariant, 0.0],
          [AppTokens.Colors.background, 1.0]
        ]
      })

      this.PlayingDialog()
    }
    .width('100%')
    .height('100%')
  }
}