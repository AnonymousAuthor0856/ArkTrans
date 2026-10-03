import { curves } from '@kit.ArkUI'

// ─── Design Tokens ───────────────────────────────────────────────────────────
namespace AppTokens {
  export namespace Colors {
    export const primary = '#0EA5E9'
    export const secondary = '#6366F1'
    export const tertiary = '#06B6D4'
    export const background = '#F1F5F9'
    export const surface = '#FFFFFF'
    export const surfaceVariant = '#E2E8F0'
    export const outline = '#D1D5DB'
    export const success = '#22C55E'
    export const warning = '#F59E0B'
    export const error = '#EF4444'
    export const onPrimary = '#FFFFFF'
    export const onSecondary = '#FFFFFF'
    export const onTertiary = '#0F172A'
    export const onBackground = '#1E293B'
    export const onSurface = '#1E293B'
  }

  export namespace Spacing {
    export const xs = 4
    export const sm = 8
    export const md = 12
    export const lg = 16
    export const xl = 24
    export const xxl = 36
  }
}

// ─── Meals Page ──────────────────────────────────────────────────────────────
@Component
struct MealsPage {
  private meals: string[] = ['Meal 1', 'Meal 2', 'Meal 3']

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach(this.meals, (meal: string) => {
        Row() {
          Text(meal)
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(12)
        .border({ width: 1, color: AppTokens.Colors.outline })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// ─── Chat Page ───────────────────────────────────────────────────────────────
@Component
struct ChatPage {
  private messages: number[] = [0, 1, 2, 3, 4]

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Diet Chat')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach(this.messages, (idx: number) => {
        Row() {
          if (idx % 2 !== 0) {
            Blank()
          }
          Text(`Message ${idx + 1}`)
            .fontSize(14)
            .fontColor(idx % 2 === 0 ? AppTokens.Colors.onSurface : AppTokens.Colors.onPrimary)
            .padding(AppTokens.Spacing.md)
            .backgroundColor(idx % 2 === 0 ? AppTokens.Colors.surfaceVariant : AppTokens.Colors.primary)
            .borderRadius(12)
          if (idx % 2 === 0) {
            Blank()
          }
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      })
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}

// ─── Stats Page ──────────────────────────────────────────────────────────────
@Component
struct StatsPage {
  private days: number[] = [0, 1, 2, 3, 4, 5, 6]

  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text('Weekly Calories')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)

      ForEach(this.days, (idx: number) => {
        Stack({ alignContent: Alignment.Start }) {
          // Background track
          Row()
            .width('100%')
            .height(24)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(8)

          // Fill bar
          Row()
            .width(`${Math.min((0.3 + idx * 0.1) * 100, 100)}%`)
            .height(24)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height(24)
      })

      Blank().height(AppTokens.Spacing.lg)

      Button('Share Report')
        .width('60%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(16)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

// ─── Root Screen ─────────────────────────────────────────────────────────────
@Entry
@Component
struct RootScreen {
  @State private selectedTab: number = 0
  private tabs: string[] = ['Meals', 'Chat', 'Stats']
  private tabController: TabsController = new TabsController()

  build() {
    Column() {
      // ── Header ──
      Row() {
        Text('Diet Log')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding(AppTokens.Spacing.lg)

      // ── Tab Bar ──
      Row() {
        ForEach(this.tabs, (tab: string, index: number) => {
          Column() {
            Text(tab)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index
                ? AppTokens.Colors.primary
                : AppTokens.Colors.onSurface)
              .padding({ top: 12, bottom: 10 })

            // Active indicator
            Row()
              .width(this.selectedTab === index ? '100%' : 0)
              .height(2)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(1)
              .animation({ duration: 200, curve: curves.easeOut() })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedTab = index
            this.tabController.changeIndex(index)
          })
        })
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.surface)
      .border({ width: { bottom: 1 }, color: AppTokens.Colors.outline })

      // ── Pager ──
      Tabs({ index: this.selectedTab, controller: this.tabController }) {
        TabContent() {
          MealsPage()
        }

        TabContent() {
          ChatPage()
        }

        TabContent() {
          StatsPage()
        }
      }
      .layoutWeight(1)
      .barHeight(0)
      .animationDuration(250)
      .onChange((index: number) => {
        this.selectedTab = index
      })
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        ['#1A0EA5E9', 0.0],
        ['#1A6366F1', 1.0]
      ]
    })
    .backgroundColor(AppTokens.Colors.background)
  }
}