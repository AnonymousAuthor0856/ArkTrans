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

class DesignTokens {
  static readonly primary: string = '#FF8A2A';
  static readonly secondary: string = '#FFC857';
  static readonly tertiary: string = '#68D672';
  static readonly background: string = '#FFF9F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE4CC';
  static readonly outline: string = '#E2B088';
  static readonly onPrimary: string = '#2C0D00';
  static readonly onSurface: string = '#311F10';
  static readonly onSurfaceDim: string = '#B3311F10';
  static readonly primarySoft: string = '#33FF8A2A';
  static readonly primarySofter: string = '#59FF8A2A';
  static readonly secondarySoft: string = '#33FFC857';
}

@Entry
@Component
struct RootScreen {
  @State selectedIndex: number = -1;

  private question: QuizQuestion = {
    category: 'Citrus crafts',
    prompt: 'Which zest carrier gives the brightest aroma when infused cold?',
    options: ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    hint: 'Think surface area'
  };

  private streaks: StreakCard[] = [
    { label: 'Current streak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ];

  @Builder
  TopBar() {
    Stack({ alignContent: Alignment.Center }) {
      Column() {
        Text('QuizForge')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.onSurface)
        Text('Aroma sprint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.onSurfaceDim)
      }
      Row() {
        Column() {
        }
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor(DesignTokens.surfaceVariant)
        .onClick(() => {})

        Column() {
        }
        .width(30)
        .height(30)
        .borderRadius(15)
        .backgroundColor(DesignTokens.primarySofter)
        .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .padding({ top: 12, bottom: 12 })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 16 }) {
          Column({ space: 12 }) {
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.onSurface)
              Text('45%')
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(DesignTokens.secondary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Progress({ value: 45, total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(DesignTokens.primary)

            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.onSurface)

            Column({ space: 8 }) {
              ForEach(this.question.options, (option: string, index: number) => {
                Column() {
                  Text(option)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.onSurface)
                }
                .width('100%')
                .borderRadius(18)
                .backgroundColor(this.selectedIndex === index ? DesignTokens.primarySoft : DesignTokens.surfaceVariant)
                .border({ width: 1, color: this.selectedIndex === index ? DesignTokens.primary : DesignTokens.outline })
                .padding(12)
                .onClick(() => {
                  this.selectedIndex = index;
                })
              }, (option: string, index: number): string => option + '_' + index.toString())
            }

            Column() {
              Text('Hint: ' + this.question.hint)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.onSurface)
            }
            .borderRadius(10)
            .backgroundColor(DesignTokens.secondarySoft)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          }
          .padding(16)
          .borderRadius(28)
          .backgroundColor(DesignTokens.surface)
          .shadow({ radius: 8, color: '#38000000', offsetY: 4 })
          .width('100%')

          Column({ space: 8 }) {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.onSurface)

            Row({ space: 12 }) {
              ForEach(this.streaks, (streak: StreakCard, index: number) => {
                Column({ space: 4 }) {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.onSurfaceDim)
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.onSurface)
                }
                .layoutWeight(1)
                .borderRadius(18)
                .backgroundColor(DesignTokens.surfaceVariant)
                .padding(12)
                .alignItems(HorizontalAlign.Center)
              }, (streak: StreakCard, index: number): string => streak.label + '_' + index.toString())
            }
            .width('100%')

            Button('Submit answer')
              .width('100%')
              .height(40)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.onPrimary)
              .backgroundColor(DesignTokens.primary)
              .borderRadius(18)
              .onClick(() => {})
          }
          .padding(16)
          .borderRadius(28)
          .backgroundColor(DesignTokens.surface)
          .shadow({ radius: 4, color: '#2E000000', offsetY: 2 })
          .width('100%')
        }
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.background)
  }
}
