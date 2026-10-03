import { curves } from '@kit.ArkUI';

// AppTokens - using explicit class declarations instead of object literals
class ColorsClass {
  primary: string = '#0EA5E9';
  secondary: string = '#6366F1';
  tertiary: string = '#06B6D4';
  background: string = '#F1F5F9';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E2E8F0';
  outline: string = '#D1D5DB';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#0F172A';
  onBackground: string = '#1E293B';
  onSurface: string = '#1E293B';
}

class SpacingClass {
  xs: number = 4;
  sm: number = 8;
  md: number = 12;
  lg: number = 16;
  xl: number = 24;
  xxl: number = 36;
}

class ShapesClass {
  small: number = 8;
  medium: number = 12;
  large: number = 16;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

function coerce(value: number, min: number, max: number): number {
  return Math.max(min, Math.min(value, max));
}

@Component
struct MealsPage {
  build() {
    Column({ space: Spacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .width('100%')

      ForEach([0, 1, 2], (it: number) => {
        Stack() {
          Text(`Meal ${it + 1}`)
            .fontSize(14)
            .fontColor(Colors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.medium)
        .border({ width: 1, color: Colors.outline, radius: Shapes.medium })
        .alignContent(Alignment.Center)
      })

      Blank()
    }
    .padding(Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct ChatPage {
  build() {
    Column({ space: Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .width('100%')

      ForEach([0, 1, 2, 3, 4], (it: number) => {
        Row() {
          if (it % 2 === 0) {
            Text(`Message ${it + 1}`)
              .fontSize(14)
              .fontColor(Colors.onSurface)
              .padding(Spacing.md)
              .backgroundColor(Colors.surfaceVariant)
              .borderRadius(Shapes.medium)
            Blank()
          } else {
            Blank()
            Text(`Message ${it + 1}`)
              .fontSize(14)
              .fontColor(Colors.onPrimary)
              .padding(Spacing.md)
              .backgroundColor(Colors.primary)
              .borderRadius(Shapes.medium)
          }
        }
        .width('100%')
      })

      Blank()
    }
    .padding(Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Color.Transparent)
  }
}

@Component
struct StatsPage {
  build() {
    Column({ space: Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)

      ForEach([0, 1, 2, 3, 4, 5, 6], (it: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width(`${coerce(0.3 + it * 0.1, 0, 1) * 100}%`)
            .height(24)
            .backgroundColor(Colors.primary)
            .borderRadius(Shapes.small)
        }
        .width('100%')
        .height(24)
        .backgroundColor(Colors.surfaceVariant)
        .borderRadius(Shapes.small)
      })

      Blank()
        .height(Spacing.lg)

      Button("Share Report")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(Colors.secondary)
        .borderRadius(Shapes.large)
    }
    .padding(Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.Transparent)
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];
  private tabController: TabsController = new TabsController();

  build() {
    Column() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              ['#1A0EA5E9', 0.0],
              ['#1A6366F1', 1.0]
            ]
          })

        Column({ space: 0 }) {
          Row() {
            Text("Diet Log")
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(Colors.onBackground)
          }
          .width('100%')
          .padding(Spacing.lg)
          .justifyContent(FlexAlign.Center)

          Column({ space: 0 }) {
            Row({ space: 0 }) {
              ForEach(this.tabs, (tab: string, index: number) => {
                Text(tab)
                  .fontSize(14)
                  .fontColor(this.selectedTab === index ? Colors.primary : Colors.onSurface)
                  .padding({ top: Spacing.md, bottom: Spacing.md })
                  .layoutWeight(1)
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    this.selectedTab = index;
                    this.tabController.changeIndex(index);
                  })
              })
            }
            .width('100%')

            Row()
              .width(`${100 / this.tabs.length}%`)
              .height(2)
              .backgroundColor(Colors.primary)
              .borderRadius(1)
              .offset({ x: `${this.selectedTab * (100 / this.tabs.length)}%` })
              .animation({
                duration: 200,
                curve: curves.interpolatingSpring(0, 1, 228, 30),
              })
          }
          .width('100%')
          .backgroundColor(Colors.surface)

          Tabs({ barPosition: BarPosition.End, controller: this.tabController, index: this.selectedTab }) {
            TabContent() {
              MealsPage()
            }
            .tabBar('')

            TabContent() {
              ChatPage()
            }
            .tabBar('')

            TabContent() {
              StatsPage()
            }
            .tabBar('')
          }
          .barHeight(0)
          .layoutWeight(1)
          .onChange((index: number) => {
            this.selectedTab = index;
          })
          .animationDuration(200)
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}