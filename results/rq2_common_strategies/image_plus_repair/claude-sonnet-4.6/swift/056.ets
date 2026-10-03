// App Tokens
class AppColorsClass {
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

const AppColors = new AppColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

// MealsPage Component
@Component
struct MealsPage {
  build() {
    Column({ space: Spacing.md }) {
      Text("Today's Meals")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach([0, 1, 2], (item: number) => {
        Stack() {
          Text(`Meal ${item + 1}`)
            .fontSize(14)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(80)
        .backgroundColor(AppColors.surface)
        .borderRadius(Shapes.medium)
        .border({ width: 1, color: AppColors.outline, radius: Shapes.medium })
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

// ChatPage Component
@Component
struct ChatPage {
  build() {
    Column({ space: Spacing.sm }) {
      Text("Diet Chat")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
        .alignSelf(ItemAlign.Start)

      ForEach([0, 1, 2, 3, 4], (item: number) => {
        Row() {
          if (item % 2 === 0) {
            Text(`Message ${item + 1}`)
              .fontSize(14)
              .fontColor(AppColors.onSurface)
              .padding(Spacing.md)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(Shapes.medium)
            Blank()
          } else {
            Blank()
            Text(`Message ${item + 1}`)
              .fontSize(14)
              .fontColor(AppColors.onPrimary)
              .padding(Spacing.md)
              .backgroundColor(AppColors.primary)
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

// StatsPage Component
@Component
struct StatsPage {
  build() {
    Column({ space: Spacing.md }) {
      Text("Weekly Calories")
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)

      ForEach([0, 1, 2, 3, 4, 5, 6], (item: number) => {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(24)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(Shapes.small)

          Row()
            .width(`${Math.min(0.3 + item * 0.1, 1.0) * 100}%`)
            .height(24)
            .backgroundColor(AppColors.primary)
            .borderRadius(Shapes.small)
        }
        .width('100%')
        .height(24)
      })

      Blank().height(Spacing.lg)

      Button("Share Report")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSecondary)
        .width('60%')
        .height(48)
        .backgroundColor(AppColors.secondary)
        .borderRadius(Shapes.large)
    }
    .padding(Spacing.lg)
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(Color.Transparent)
  }
}

// Root Screen
@Entry
@Component
struct RootScreen {
  @State selectedTab: number = 0;
  private tabs: string[] = ['Meals', 'Chat', 'Stats'];

  build() {
    Column() {
      Stack() {
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 180,
            colors: [
              ['#1A0EA5E9', 0.0],
              ['#1A6366F1', 1.0]
            ]
          })

        Column() {
          Row() {
            Text("Diet Log")
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.onBackground)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding(Spacing.lg)

          Column() {
            Row() {
              ForEach(this.tabs, (tab: string, index: number) => {
                Button({ type: ButtonType.Normal }) {
                  Text(tab)
                    .fontSize(14)
                    .fontColor(this.selectedTab === index ? AppColors.primary : AppColors.onSurface)
                    .padding({ top: Spacing.md, bottom: Spacing.md })
                    .width('100%')
                    .textAlign(TextAlign.Center)
                }
                .backgroundColor(Color.Transparent)
                .layoutWeight(1)
                .onClick(() => {
                  this.selectedTab = index;
                })
              })
            }
            .width('100%')

            Stack({ alignContent: Alignment.Start }) {
              Row()
                .width('100%')
                .height(2)
                .backgroundColor(AppColors.surfaceVariant)

              Row()
                .width(`${100 / this.tabs.length}%`)
                .height(2)
                .backgroundColor(AppColors.primary)
                .borderRadius(1)
                .translate({ x: `${this.selectedTab * (100 / this.tabs.length)}%` })
                .animation({
                  duration: 200,
                  curve: Curve.EaseInOut
                })
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
          .loop(false)
          .indicator(false)
          .duration(200)
          .curve(Curve.EaseInOut)
          .layoutWeight(1)
          .onChange((index: number) => {
            this.selectedTab = index;
          })
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}