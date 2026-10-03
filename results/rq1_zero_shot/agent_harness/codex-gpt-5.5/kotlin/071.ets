const NAME: string = "163*QuizForge*en";
const UI_TYPE: string = "Quiz";
const STYLE_THEME: string = "Citrus Pop";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const COLOR_PALETTE: string = "primary:#FF8A2A secondary:#FFC857 tertiary:#68D672 background:#FFF9F2 surface:#FFFFFF surfaceVariant:#FFE4CC outline:#E2B088 success:#2AC28B warning:#FFB347 error:#F45B69 onPrimary:#2C0D00 onSecondary:#301A00 onTertiary:#083919 onBackground:#1E1205 onSurface:#311F10";
const DENSITY_SPACING: string = "Compact";
const COMPLEXITY: string = "QuestionCard,OptionChip,Progress";
const EXTRA: string = "Citrus quiz forge with cards, chips, and timed progress";

class AppColors {
  static readonly primary: string = '#FF8A2A';
  static readonly secondary: string = '#FFC857';
  static readonly background: string = '#FFF9F2';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFE4CC';
  static readonly outline: string = '#E2B088';
  static readonly onPrimary: string = '#2C0D00';
  static readonly onSurface: string = '#311F10';
}

class AppSpacing {
  static readonly xxs: number = 4;
  static readonly xs: number = 8;
  static readonly sm: number = 12;
  static readonly md: number = 16;
  static readonly lg: number = 20;
}

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

@Entry
@Component
struct MainActivity {
  @State selectedIndex: number = -1;
  private progress: number = 0.45;
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
      Blank().width(30).height(30).backgroundColor(AppColors.surfaceVariant).borderRadius(15)
      Column() {
        Text('QuizForge')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Aroma sprint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      Blank().width(30).height(30).backgroundColor('#59FF8A2A').borderRadius(15)
    }
    .width('100%')
    .height(68)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  QuestionCard() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Text(this.question.category)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('45%')
          .fontSize(14)
          .fontColor(AppColors.secondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
        .width('100%')
        .color(AppColors.primary)
        .backgroundColor(AppColors.surfaceVariant)

      Text(this.question.prompt)
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Column({ space: AppSpacing.xs }) {
        ForEach(this.question.options, (option: string, index: number) => {
          Text(option)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .width('100%')
            .padding(AppSpacing.sm)
            .backgroundColor(this.selectedIndex === index ? '#33FF8A2A' : AppColors.surfaceVariant)
            .borderRadius(18)
            .border({ width: 1, color: this.selectedIndex === index ? AppColors.primary : AppColors.outline })
            .onClick(() => {
              this.selectedIndex = index;
            })
        })
      }
      .width('100%')

      Text(`Hint: ${this.question.hint}`)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor('#33FFC857')
        .borderRadius(10)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(28)
    .shadow({ radius: 8, color: '#38000000', offsetY: 4 })
  }

  @Builder
  TrackerCard() {
    Column({ space: AppSpacing.xs }) {
      Text('Trackers')
        .fontSize(22)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(AppColors.onSurface)
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        ForEach(this.streaks, (streak: StreakCard) => {
          Column({ space: AppSpacing.xxs }) {
            Text(streak.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .opacity(0.7)
              .textAlign(TextAlign.Center)
            Text(streak.value)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)
          }
          .layoutWeight(1)
          .padding(AppSpacing.sm)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(18)
        })
      }
      .width('100%')

      Button('Submit answer')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('100%')
        .height(46)
        .backgroundColor(AppColors.primary)
        .borderRadius(18)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(28)
    .shadow({ radius: 4, color: '#30000000', offsetY: 2 })
  }

  build() {
    Column() {
      this.TopBar()
      Scroll() {
        Column({ space: AppSpacing.md }) {
          this.QuestionCard()
          this.TrackerCard()
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
