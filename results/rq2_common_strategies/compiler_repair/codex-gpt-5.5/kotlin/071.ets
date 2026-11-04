class QuizQuestion {
  category: string;
  prompt: string;
  options: string[];
  hint: string;

  constructor(category: string, prompt: string, options: string[], hint: string) {
    this.category = category;
    this.prompt = prompt;
    this.options = options;
    this.hint = hint;
  }
}

class StreakCard {
  label: string;
  value: string;

  constructor(label: string, value: string) {
    this.label = label;
    this.value = value;
  }
}

class QuizColors {
  static readonly primary: string = '#FF8A2A';
  static readonly secondary: string = '#FFC857';
  static readonly background: string = '#FFF9F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE4CC';
  static readonly outline: string = '#E2B088';
  static readonly onPrimary: string = '#2C0D00';
  static readonly onSurface: string = '#311F10';
}

@Entry
@Component
struct Index {
  @State selectedIndex: number = -1;
  private question: QuizQuestion = new QuizQuestion(
    'Citrus crafts',
    'Which zest carrier gives the brightest aroma when infused cold?',
    ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    'Think surface area'
  );
  private streaks: StreakCard[] = [
    new StreakCard('Current streak', '5 days'),
    new StreakCard('Accuracy', '84%'),
    new StreakCard('Rank', 'Top 12%')
  ];

  @Builder
  TopBar() {
    Row() {
      Circle()
        .width(30)
        .height(30)
        .fill(QuizColors.surfaceVariant)

      Column() {
        Text('QuizForge')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onSurface)
        Text('Aroma sprint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3311F10')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle()
        .width(30)
        .height(30)
        .fill('#59FF8A2A')
    }
    .width('100%')
    .height(66)
    .padding({ left: 20, right: 20 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(QuizColors.background)
  }

  @Builder
  OptionChip(option: string, index: number) {
    Text(option)
      .width('100%')
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(QuizColors.onSurface)
      .padding(12)
      .backgroundColor(this.selectedIndex === index ? '#33FF8A2A' : QuizColors.surfaceVariant)
      .borderRadius(18)
      .border({ width: 1, color: this.selectedIndex === index ? QuizColors.primary : QuizColors.outline })
      .onClick(() => {
        this.selectedIndex = index;
      })
  }

  @Builder
  QuestionCard() {
    Column() {
      Row() {
        Text(this.question.category)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(QuizColors.onSurface)
          .layoutWeight(1)
        Text('45%')
          .fontSize(14)
          .fontColor(QuizColors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Progress({ value: 45, total: 100, type: ProgressType.Linear })
        .width('100%')
        .height(8)
        .color(QuizColors.primary)
        .backgroundColor(QuizColors.surfaceVariant)
        .margin({ top: 12 })

      Text(this.question.prompt)
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(QuizColors.onSurface)
        .width('100%')
        .margin({ top: 12 })

      ForEach(this.question.options, (option: string, index: number) => {
        Column() {
          this.OptionChip(option, index)
        }
        .margin({ top: 8 })
      }, (option: string) => option)

      Text('Hint: ' + this.question.hint)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.onSurface)
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .backgroundColor('#33FFC857')
        .borderRadius(10)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(QuizColors.surface)
    .borderRadius(28)
    .shadow({ radius: 8, color: '#2E000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  StreakBox(streak: StreakCard) {
    Column() {
      Text(streak.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3311F10')
        .textAlign(TextAlign.Center)
      Text(streak.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.onSurface)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(12)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(QuizColors.surfaceVariant)
    .borderRadius(18)
  }

  @Builder
  TrackerCard() {
    Column() {
      Text('Trackers')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(QuizColors.onSurface)
        .width('100%')
        .margin({ bottom: 8 })

      Row() {
        ForEach(this.streaks, (streak: StreakCard, index: number) => {
          Column() {
            this.StreakBox(streak)
          }
          .layoutWeight(1)
          .margin({ right: index === 2 ? 0 : 12 })
        }, (streak: StreakCard) => streak.label)
      }
      .width('100%')

      Button('Submit answer')
        .width('100%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(QuizColors.onPrimary)
        .backgroundColor(QuizColors.primary)
        .borderRadius(18)
        .margin({ top: 12 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(QuizColors.surface)
    .borderRadius(28)
    .shadow({ radius: 4, color: '#2E000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column() {
          this.QuestionCard()
          Column() { this.TrackerCard() }.margin({ top: 16 })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 36 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(QuizColors.background)
  }
}
