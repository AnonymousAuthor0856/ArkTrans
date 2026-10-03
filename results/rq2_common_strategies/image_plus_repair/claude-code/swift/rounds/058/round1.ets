// AppTokens - 应用设计令牌
namespace AppTokens {
  export class Colors {
    static readonly primary: string = '#111827';
    static readonly secondary: string = '#374151';
    static readonly tertiary: string = '#6B7280';
    static readonly background: string = '#F9FAFB';
    static readonly surface: string = '#FFFFFF';
    static readonly surfaceVariant: string = '#E5E7EB';
    static readonly outline: string = '#D1D5DB';
    static readonly success: string = '#16A34A';
    static readonly warning: string = '#F59E0B';
    static readonly error: string = '#EF4444';
    static readonly onPrimary: string = '#FFFFFF';
    static readonly onSecondary: string = '#FFFFFF';
    static readonly onTertiary: string = '#111827';
    static readonly onBackground: string = '#111827';
    static readonly onSurface: string = '#1F2937';
  }

  export class TypographyTokens {
    static readonly displaySize: number = 28;
    static readonly displayWeight: FontWeight = FontWeight.Bold;
    static readonly headlineSize: number = 20;
    static readonly headlineWeight: FontWeight = FontWeight.SemiBold;
    static readonly titleSize: number = 16;
    static readonly titleWeight: FontWeight = FontWeight.Medium;
    static readonly bodySize: number = 14;
    static readonly bodyWeight: FontWeight = FontWeight.Regular;
    static readonly labelSize: number = 12;
    static readonly labelWeight: FontWeight = FontWeight.Medium;
  }

  export class Shapes {
    static readonly small: number = 8;
    static readonly medium: number = 12;
    static readonly large: number = 16;
  }

  export class Spacing {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 36;
  }
}

// 自定义TabRow组件
@Component
struct CustomTabRow {
  tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  @Link selectedTabIndex: number;

  build() {
    Column() {
      Row() {
        ForEach(this.tabs, (item: string, index: number) => {
          Button(item)
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .fontSize(AppTokens.TypographyTokens.titleSize)
            .fontWeight(AppTokens.TypographyTokens.titleWeight)
            .fontColor(this.selectedTabIndex === index ?
              AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.selectedTabIndex = index;
            })
        }, (item: string) => item)
      }
      .width('100%')

      // Tab下划线指示器
      Row() {
        ForEach(this.tabs, (item: string, index: number) => {
          Column() {
            if (this.selectedTabIndex === index) {
              Rectangle()
                .fill(AppTokens.Colors.primary)
                .width('100%')
                .height(2)
            }
          }
          .layoutWeight(1)
          .height(2)
        }, (item: string) => item)
      }
      .width('100%')
      .height(2)
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// 概览页面
@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Sync Device')
        .type(ButtonType.Normal)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.large)
        .width('60%')
        .height(48)

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center)
  }
}

// 排名页面
@Component
struct RankingPage {
  private userList: string[] = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5'];
  private stepList: number[] = [9000, 8500, 8000, 7500, 7000];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach(this.userList, (item: string, index: number) => {
        Row() {
          Text(item)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`${this.stepList[index]} steps`)
            .fontSize(AppTokens.TypographyTokens.bodySize)
            .fontWeight(AppTokens.TypographyTokens.bodyWeight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)
      }, (item: string) => item)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Start)
  }
}

// 统计页面
@Component
struct StatsPage {
  private dayIndices: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.TypographyTokens.headlineSize)
        .fontWeight(AppTokens.TypographyTokens.headlineWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      ForEach(this.dayIndices, (item: number, index: number) => {
        Stack({ alignContent: Alignment.CenterStart }) {
          Row() {
          }
          .width('100%')
          .height(20)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

          Row() {
          }
          .width(`${Math.min(30 + index * 10, 100)}%`)
          .height(20)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
        }
        .width('100%')
        .height(20)
      }, (item: number) => item.toString())

      Blank()
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .justifyContent(FlexAlign.Start)
  }
}

// 应用主界面
@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private tabsController: TabsController = new TabsController();

  build() {
    Column() {
      // 顶部标题区域
      Text('Step Challenge')
        .fontSize(AppTokens.TypographyTokens.displaySize)
        .fontWeight(AppTokens.TypographyTokens.displayWeight)
        .fontColor(AppTokens.Colors.onBackground)
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)

      // 自定义TabRow
      CustomTabRow({
        tabs: this.tabs,
        selectedTabIndex: $selectedTabIndex
      })

      // 页面内容区域
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        TabContent() {
          OverviewPage()
        }
        .tabBar('')

        TabContent() {
          RankingPage()
        }
        .tabBar('')

        TabContent() {
          StatsPage()
        }
        .tabBar('')
      }
      .barMode(BarMode.Fixed)
      .barHeight(0)
      .animationDuration(300)
      .onChange((index: number) => {
        this.selectedTabIndex = index;
      })
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}
