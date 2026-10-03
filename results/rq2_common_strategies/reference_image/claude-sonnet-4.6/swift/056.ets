// ============================================================
// RootScreen.ets  —  entry page (register in main_pages.json)
// ============================================================

import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { AppColors, AppShapes, AppSpacing, AppTypographyTokens } from './AppTokens';

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  @State tabWidth: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];
  private swiperController: SwiperController = new SwiperController();

  aboutToAppear(): void {
    // Status bar hidden == navigation bar is the only enabled system bar.
    window.getLastWindow(getContext(this))
      .then((win: window.Window) => {
        win.setWindowSystemBarEnable(['navigation']);
      })
      .catch((err: BusinessError) => {
        console.error(`setWindowSystemBarEnable failed: ${err.code}`);
      });
  }

  @Builder
  tabItem(index: number, name: string) {
    Column() {
      Text(name)
        .fontSize(AppTypographyTokens.bodySize)
        .fontWeight(AppTypographyTokens.bodyWeight)
        .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
    }
    .height(48)
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.selectedTab = index;
      this.swiperController.changeIndex(index);
    })
  }

  build() {
    Column() {
      // ---- Title ----
      Text('Diet Log')
        .fontSize(AppTypographyTokens.displaySize)
        .fontWeight(AppTypographyTokens.displayWeight)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(AppSpacing.lg)

      // ---- Tab row + animated indicator ----
      Column() {
        Stack({ alignContent: Alignment.BottomStart }) {
          Row() {
            ForEach(this.tabs, (name: string, index: number) => {
              this.tabItem(index, name);
            }, (name: string, index: number) => `${index}-${name}`)
          }
          .width('100%')

          Column()
            .width(this.tabWidth)
            .height(2)
            .backgroundColor(AppColors.primary)
            .offset({ x: this.tabWidth * this.selectedTab })
            .animation({ duration: 200, curve: Curve.EaseInOut })
        }
        .width('100%')
        .onAreaChange((oldValue: Area, newValue: Area) => {
          this.tabWidth = parseFloat(newValue.width.toString()) / this.tabs.length;
        })
      }
      .width('100%')
      .backgroundColor(AppColors.surface)

      // ---- Pager ----
      Swiper(this.swiperController) {
        MealsPage()
        ChatPage()
        StatsPage()
      }
      .index(this.selectedTab)
      .loop(false)
      .indicator(false)
      .duration(200)
      .layoutWeight(1)
      .onChange((index: number) => {
        this.selectedTab = index;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      angle: 180, // top -> bottom, same as SwiftUI startPoint .top / endPoint .bottom
      colors: [[0x1A0EA5E9, 0.0], [0x1A6366F1, 1.0]] // primary 10% -> secondary 10%
    })
  }
}

// ============================================================
// MealsPage
// ============================================================

@Component
struct MealsPage {
  private meals: number[] = [1, 2, 3];

  build() {
    Column({ space: AppSpacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach(this.meals, (item: number) => {
        Stack() {
          Text(`Meal ${item}`)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({ width: 1, color: AppColors.outline })
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(Color.Transparent)
  }
}

// ============================================================
// ChatPage
// ============================================================

@Component
struct ChatPage {
  private messages: number[] = [1, 2, 3, 4, 5];

  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach(this.messages, (item: number) => {
        Row() {
          Text(`Message ${item}`)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(item % 2 === 1 ? AppColors.onSurface : AppColors.onPrimary)
            .padding(AppSpacing.md)
            .backgroundColor(item % 2 === 1 ? AppColors.surfaceVariant : AppColors.primary)
            .borderRadius(AppShapes.medium)
        }
        .width('100%')
        .justifyContent(item % 2 === 1 ? FlexAlign.Start : FlexAlign.End)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(Color.Transparent)
  }
}

// ============================================================
// StatsPage
// ============================================================

@Component
struct StatsPage {
  private days: number[] = [1, 2, 3, 4, 5, 6, 7];

  private barPercent(index: number): number {
    const factor: number = Math.min(1, 0.3 + index * 0.1);
    return Math.round(factor * 100);
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)

      ForEach(this.days, (item: number) => {
        Row() {
          Column()
            .height('100%')
            .width(`${this.barPercent(item - 1)}%`)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
      }, (item: number) => item.toString())

      Button('Share Report')
        .type(ButtonType.Normal)
        .fontSize(AppTypographyTokens.titleSize)
        .fontWeight(AppTypographyTokens.titleWeight)
        .fontColor(AppColors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .borderRadius(AppShapes.large)
        .margin({ top: AppSpacing.lg })
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(Color.Transparent)
  }
}