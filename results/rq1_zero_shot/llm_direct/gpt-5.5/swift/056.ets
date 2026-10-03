class AppColors {
  static readonly primary = '#0EA5E9';
  static readonly secondary = '#6366F1';
  static readonly tertiary = '#06B6D4';
  static readonly background = '#F1F5F9';
  static readonly surface = '#FFFFFF';
  static readonly surfaceVariant = '#E2E8F0';
  static readonly outline = '#D1D5DB';
  static readonly success = '#22C55E';
  static readonly warning = '#F59E0B';
  static readonly error = '#EF4444';
  static readonly onPrimary = '#FFFFFF';
  static readonly onSecondary = '#FFFFFF';
  static readonly onTertiary = '#0F172A';
  static readonly onBackground = '#1E293B';
  static readonly onSurface = '#1E293B';

  static readonly primary10 = '#1A0EA5E9';
  static readonly secondary10 = '#1A6366F1';
}

class AppTypographyTokens {
  static readonly displaySize = 28;
  static readonly displayWeight = FontWeight.Bold;

  static readonly headlineSize = 20;
  static readonly headlineWeight = FontWeight.Medium;

  static readonly titleSize = 16;
  static readonly titleWeight = FontWeight.Medium;

  static readonly bodySize = 14;
  static readonly bodyWeight = FontWeight.Regular;

  static readonly labelSize = 12;
  static readonly labelWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small = 8;
  static readonly medium = 12;
  static readonly large = 16;
}

class AppSpacing {
  static readonly xs = 4;
  static readonly sm = 8;
  static readonly md = 12;
  static readonly lg = 16;
  static readonly xl = 24;
  static readonly xxl = 36;
}

@Entry
@Component
struct RootScreen {
  @State private selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [
            [AppColors.primary10, 0.0],
            [AppColors.secondary10, 1.0]
          ]
        })

      Column({ space: 0 }) {
        Row() {
          Text('Diet Log')
            .fontSize(AppTypographyTokens.displaySize)
            .fontWeight(AppTypographyTokens.displayWeight)
            .fontColor(AppColors.onBackground)
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .justifyContent(FlexAlign.Center)

        Column({ space: 0 }) {
          Row() {
            ForEach(this.tabs, (tab: string, index: number) => {
              Column() {
                Text(tab)
                  .fontSize(AppTypographyTokens.bodySize)
                  .fontWeight(AppTypographyTokens.bodyWeight)
                  .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
                  .textAlign(TextAlign.Center)
                  .width('100%')
                  .padding({
                    top: AppSpacing.md,
                    bottom: AppSpacing.md
                  })
              }
              .layoutWeight(1)
              .onClick(() => {
                this.selectedTab = index;
              })
            }, (tab: string) => tab)
          }
          .width('100%')

          Row() {
            ForEach(this.tabs, (_tab: string, index: number) => {
              Blank()
                .height(2)
                .layoutWeight(1)
                .backgroundColor(this.selectedTab === index ? AppColors.primary : Color.Transparent)
            }, (tab: string) => `indicator-${tab}`)
          }
          .width('100%')
        }
        .width('100%')
        .backgroundColor(AppColors.surface)

        Swiper() {
          MealsPage()

          ChatPage()

          StatsPage()
        }
        .index(this.selectedTab)
        .indicator(false)
        .loop(false)
        .duration(200)
        .layoutWeight(1)
        .onChange((index: number) => {
          this.selectedTab = index;
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct MealsPage {
  build() {
    Column({ space: AppSpacing.md }) {
      Text('Today\'s Meals')
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2], (it: number) => {
        Stack({ alignContent: Alignment.Center }) {
          Text(`Meal ${it + 1}`)
            .fontSize(AppTypographyTokens.bodySize)
            .fontWeight(AppTypographyTokens.bodyWeight)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline
        })
      }, (it: number) => it.toString())

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Diet Chat')
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text(`Message ${it + 1}`)
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(AppTypographyTokens.bodyWeight)
              .fontColor(AppColors.onSurface)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)

            Blank()
              .layoutWeight(1)
          } else {
            Blank()
              .layoutWeight(1)

            Text(`Message ${it + 1}`)
              .fontSize(AppTypographyTokens.bodySize)
              .fontWeight(AppTypographyTokens.bodyWeight)
              .fontColor(AppColors.onPrimary)
              .padding(AppSpacing.md)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
          }
        }
        .width('100%')
      }, (it: number) => it.toString())

      Blank()
        .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct StatsPage {
  private progress(index: number): number {
    return Math.max(0, Math.min(1, 0.3 + index * 0.1));
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Weekly Calories')
        .fontSize(AppTypographyTokens.headlineSize)
        .fontWeight(AppTypographyTokens.headlineWeight)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Blank()
            .width(`${this.progress(it) * 100}%`)
            .height(24)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.small)
      }, (it: number) => it.toString())

      Blank()
        .height(AppSpacing.lg)

      Button() {
        Text('Share Report')
          .fontSize(AppTypographyTokens.titleSize)
          .fontWeight(AppTypographyTokens.titleWeight)
          .fontColor(AppColors.onSecondary)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .type(ButtonType.Normal)
      .width('60%')
      .height(48)
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShapes.large)
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}