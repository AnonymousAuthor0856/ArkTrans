const Colors = {
  primary: '#FF8A2A',
  secondary: '#FFC857',
  tertiary: '#68D672',
  background: '#FFF9F2',
  surface: '#FFFFFF',
  surfaceVariant: '#FFE4CC',
  outline: '#E2B088',
  success: '#2AC28B',
  warning: '#FFB347',
  error: '#F45B69',
  onPrimary: '#2C0D00',
  onSecondary: '#301A00',
  onTertiary: '#083919',
  onBackground: '#1E1205',
  onSurface: '#311F10'
};

const Spacing = { xxs: 4, xs: 8, sm: 12, md: 16, lg: 20, xl: 28, xxl: 36, xxxl: 46 };
const Shapes = { small: 10, medium: 18, large: 28 };

interface QuizQuestion {
  category: string;
  prompt: string;
  options: string[];
  hint: string;
}

interface StreakCard {
  label: string;
  value: string;
}

const question: QuizQuestion = {
  category: 'Citrus crafts',
  prompt: 'Which zest carrier gives the brightest aroma when infused cold?',
  options: ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
  hint: 'Think surface area'
};

const streaks: StreakCard[] = [
  { label: 'Current streak', value: '5 days' },
  { label: 'Accuracy', value: '84%' },
  { label: 'Rank', value: 'Top 12%' }
];

@Entry
@Component
struct Index {
  @State selectedIndex: number = -1;

  build() {
    Column() {
      Row() {
        Stack() {
        }
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor(Colors.surfaceVariant)

        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3311F10')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Stack() {
        }
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor('#59FF8A2A')
      }
      .width('100%')
      .height(56)
      .padding({ left: 12, right: 12 })

      Scroll() {
        Column({ space: Spacing.md }) {
          Column() {
            Column({ space: Spacing.sm }) {
              Row() {
                Text(question.category)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Text('45%')
                  .fontSize(14)
                  .fontColor(Colors.secondary)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Progress({ value: 45, total: 100, type: ProgressType.Linear })
                .color(Colors.primary)
                .width('100%')

              Text(question.prompt)
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              Column({ space: Spacing.xs }) {
                ForEach(question.options, (option: string, index: number) => {
                  Column() {
                    Text(option)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                  }
                  .width('100%')
                  .borderRadius(Shapes.medium)
                  .backgroundColor(this.selectedIndex === index ? '#33FF8A2A' : Colors.surfaceVariant)
                  .border({ width: 1, color: this.selectedIndex === index ? Colors.primary : Colors.outline })
                  .padding(Spacing.sm)
                  .onClick(() => {
                    this.selectedIndex = index;
                  })
                }, (option: string, index: number) => index.toString())
              }

              Column() {
                Text('Hint: ' + question.hint)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
              }
              .borderRadius(Shapes.small)
              .backgroundColor('#33FFC857')
              .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
            }
            .padding(Spacing.md)
          }
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 8, color: '#22000000', offsetY: 4 })

          Column() {
            Column({ space: Spacing.xs }) {
              Text('Trackers')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor(Colors.onSurface)

              Row({ space: Spacing.sm }) {
                ForEach(streaks, (streak: StreakCard) => {
                  Column({ space: Spacing.xxs }) {
                    Text(streak.label)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#B3311F10')
                    Text(streak.value)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(Colors.onSurface)
                  }
                  .layoutWeight(1)
                  .borderRadius(Shapes.medium)
                  .backgroundColor(Colors.surfaceVariant)
                  .padding(Spacing.sm)
                  .alignItems(HorizontalAlign.Center)
                }, (streak: StreakCard) => streak.label)
              }

              Button('Submit answer')
                .width('100%')
                .backgroundColor(Colors.primary)
                .fontColor(Colors.onPrimary)
                .borderRadius(Shapes.medium)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
            }
            .padding(Spacing.md)
          }
          .borderRadius(Shapes.large)
          .backgroundColor(Colors.surface)
          .shadow({ radius: 4, color: '#18000000', offsetY: 2 })
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
