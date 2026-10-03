// AppTokens - 颜色、排版、形状和间距常量
class AppTokens {
  static class Colors {
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

  static class TypographyTokens {
    static readonly display: { size: number; weight: FontWeight } = { size: 28, weight: FontWeight.Bold };
    static readonly headline: { size: number; weight: FontWeight } = { size: 20, weight: FontWeight.SemiBold };
    static readonly title: { size: number; weight: FontWeight } = { size: 16, weight: FontWeight.Medium };
    static readonly body: { size: number; weight: FontWeight } = { size: 14, weight: FontWeight.Regular };
    static readonly label: { size: number; weight: FontWeight } = { size: 12, weight: FontWeight.Medium };
  }

  static class Shapes {
    static readonly small: number = 8;
    static readonly medium: number = 12;
    static readonly large: number = 16;
  }

  static class Spacing {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 12;
    static readonly lg: number = 16;
    static readonly xl: number = 24;
    static readonly xxl: number = 36;
  }
}

// CustomTabRow - 自定义TabRow组件
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
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(this.selectedTabIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .layoutWeight(1)
            .height(48)
            .onClick(() => {
              this.selectedTabIndex = index;
            })
        }, (item: string) => item)
      }
      .width('100%')

      Stack() {
        Row() {
          ForEach(this.tabs, (_item: string, _index: number) => {
            Blank()
              .layoutWeight(1)
          }, (item: string) => item)
        }
        .width('100%')

        Row() {
          // 选中的tab下划线
          Blank()
            .layoutWeight(this.selectedTabIndex)
          Rectangle()
            .fill(AppTokens.Colors.primary)
            .height(2)
            .layoutWeight(1)
            .transition(TransitionEffect.OPACITY.animation({ duration: 200, curve: Curve.EaseInOut }))
          Blank()
            .layoutWeight(this.tabs.length - this.selectedTabIndex - 1)
        }
        .width('100%')
        .alignItems(VerticalAlign.Bottom)
      }
      .height(2)
      .width('100%')
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
  }
}

// OverviewPage - 概览页面
@Component
struct OverviewPage {
  build() {
    Column() {
      Text("Today's Steps: 8452")
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.md })

      Blank()
        .height(AppTokens.Spacing.lg)

      Button('Sync Device')
        .type(ButtonType.Normal)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
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
    .justifyContent(FlexAlign.Start)
  }
}

// RankingPage - 排名页面
@Component
struct RankingPage {
  private userList: string[] = ['User 1', 'User 2', 'User 3', 'User 4', 'User 5'];
  private stepList: number[] = [9000, 8500, 8000, 7500, 7000];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      ForEach(this.userList, (item: string, index: number) => {
        Row() {
          Text(item)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank()

          Text(`${this.stepList[index]} steps`)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
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
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}

// StatsPage - 统计页面
@Component
struct StatsPage {
  private weekDays: number[] = [0, 1, 2, 3, 4, 5, 6];

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Weekly Progress')
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .width('100%')

      ForEach(this.weekDays, (item: number, index: number) => {
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
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}

// RootScreen - 应用主界面
@Entry
@Component
struct RootScreen {
  @State selectedTabIndex: number = 0;
  private tabs: string[] = ['Overview', 'Ranking', 'Stats'];
  private tabBarController: TabsController = new TabsController();

  aboutToAppear(): void {
    this.tabBarController.changeIndex(this.selectedTabIndex);
  }

  onTabChange(index: number): void {
    this.selectedTabIndex = index;
    this.tabBarController.changeIndex(index);
  }

  build() {
    Column() {
      // 顶部标题区域
      Text('Step Challenge')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
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

      // 页面切换区域
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabBarController
      }) {
        TabContent() {
          OverviewPage()
        }

        TabContent() {
          RankingPage()
        }

        TabContent() {
          StatsPage()
        }
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
