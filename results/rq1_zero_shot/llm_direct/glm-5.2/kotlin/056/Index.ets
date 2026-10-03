// AppTokens.ets
export class AppTokens {
  static readonly Colors = {
    primary: '#FF0EA5E9',
    secondary: '#FF6366F1',
    tertiary: '#FF06B6D4',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF22C55E',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF1E293B',
    onSurface: '#FF1E293B',
  };

  static readonly TypographyTokens = {
    display: { fontSize: 28, fontWeight: FontWeight.Bold },
    headline: { fontSize: 20, fontWeight: FontWeight.Medium },
    title: { fontSize: 16, fontWeight: FontWeight.Medium },
    body: { fontSize: 14, fontWeight: FontWeight.Normal },
    label: { fontSize: 12, fontWeight: FontWeight.Medium },
  };

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  };

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 36,
  };
}

// MainPages.ets
@Entry
@Component
export struct RootScreen {
  @State currentIndex: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];
  private controller: TabsController = new TabsController();

  build() {
    Column() {
      // Header
      Column() {
        Text('Diet Log')
          .fontSize(AppTokens.TypographyTokens.display.fontSize)
          .fontWeight(AppTokens.TypographyTokens.display.fontWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg });
      }
      .width('100%')
      .alignItems(HorizontalAlign.Center);

      // Tabs
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.controller }) {
        ForEach(this.tabs, (title: string, index: number) => {
          TabContent() {
            if (index === 0) {
              MealsPage();
            } else if (index === 1) {
              ChatPage();
            } else {
              StatsPage();
            }
          }
          .tabBar(this.TabBuilder(title, index))
        }, (title: string) => title)
      }
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .barMode(BarMode.Fixed)
      .barWidth('100%')
      .layoutWeight(1)
      .vertical(false)
      .scrollable(true)
    }
    .width('100%')
    .height('100%')
    .linearGradient({
      angle: 180,
      colors: [
        [AppTokens.Colors.primary, 0.1],
        [AppTokens.Colors.secondary, 0.1]
      ]
    });
  }

  @Builder
  TabBuilder(title: string, index: number) {
    Column() {
      Text(title)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
        .fontColor(this.currentIndex === index ? AppTokens.Colors.primary : AppTokens.Colors.onSurface)
        .margin({ top: 8, bottom: 8 });
    }
    .width('100%')
    .height(48)
    .justifyContent(FlexAlign.Center);
  }
}

@Component
export struct MealsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Today's Meals")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start);

      ForEach([1, 2, 3], (item: number) => {
        Row() {
          Text(`Meal ${item}`)
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(AppTokens.TypographyTokens.body.fontSize);
        }
        .width('100%')
        .height(80)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.surface)
        .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
        .justifyContent(FlexAlign.Center);
      }, (item: number) => item.toString());
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg);
  }
}

@Component
export struct ChatPage {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface)
        .alignSelf(ItemAlign.Start);

      ForEach([1, 2, 3, 4, 5], (item: number) => {
        Row() {
          Row() {
            Text(`Message ${item}`)
              .fontColor(item % 2 === 0 ? AppTokens.Colors.onSurface : AppTokens.Colors.onPrimary)
              .fontSize(AppTokens.TypographyTokens.body.fontSize);
          }
          .padding(AppTokens.Spacing.md)
          .borderRadius(AppTokens.Shapes.medium)
          .backgroundColor(item % 2 === 0 ? AppTokens.Colors.surfaceVariant : AppTokens.Colors.primary);
        }
        .width('100%')
        .margin({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .justifyContent(item % 2 === 0 ? FlexAlign.Start : FlexAlign.End);
      }, (item: number) => item.toString());
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg);
  }
}

@Component
export struct StatsPage {
  build() {
    Column({ space: AppTokens.Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(AppTokens.TypographyTokens.headline.fontSize)
        .fontWeight(AppTokens.TypographyTokens.headline.fontWeight)
        .fontColor(AppTokens.Colors.onSurface);

      ForEach([1, 2, 3, 4, 5, 6, 7], (item: number) => {
        Row() {
          Row()
            .width(`${Math.min(30 + item * 10, 100)}%`)
            .height('100%')
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small);
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small);
      }, (item: number) => item.toString());

      Blank().height(AppTokens.Spacing.lg);

      Button("Share Report")
        .width('60%')
        .height(48)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .fontSize(AppTokens.TypographyTokens.title.fontSize)
        .fontWeight(AppTokens.TypographyTokens.title.fontWeight);
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Center);
  }
}