import { hilog } from '@kit.PerformanceAnalysisKit';
import { display } from '@kit.ArkUI';
import { window } from '@kit.ArkUI';

// DesignTokens
class DesignTokens {
  static readonly Colors = {
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

  static readonly Spacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 36,
    xxxl: 46
  };

  static readonly Shapes = {
    small: 10,
    medium: 18,
    large: 28
  };
}

// Data models
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
struct RootScreen {
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
      // Navigation icon
      Row() {
        Circle()
          .width(30)
          .height(30)
          .fill(DesignTokens.Colors.surfaceVariant)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Title
      Column() {
        Text('QuizForge')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Text('Aroma sprint')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#4D311F10')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Action icon
      Row() {
        Circle()
          .width(30)
          .height(30)
          .fill('#59FF8A2A')
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: 4, right: 4 })
    .backgroundColor(DesignTokens.Colors.background)
  }

  @Builder
  OptionChip(option: string, index: number) {
    Row() {
      Text(option)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({
      left: DesignTokens.Spacing.sm,
      right: DesignTokens.Spacing.sm,
      top: DesignTokens.Spacing.sm,
      bottom: DesignTokens.Spacing.sm
    })
    .backgroundColor(this.selectedIndex === index ?
      '#33FF8A2A' : DesignTokens.Colors.surfaceVariant)
    .borderRadius(DesignTokens.Shapes.medium)
    .border({
      width: 1,
      color: this.selectedIndex === index ?
        DesignTokens.Colors.primary : DesignTokens.Colors.outline
    })
    .onClick(() => {
      this.selectedIndex = index;
    })
  }

  @Builder
  QuestionCard() {
    Column({ space: DesignTokens.Spacing.sm }) {
      // Header row
      Row() {
        Text(this.question.category)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
        Blank()
        Text('45%')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(DesignTokens.Colors.secondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Progress bar
      Progress({ value: this.progress, total: 1.0 })
        .width('100%')
        .height(8)
        .color(DesignTokens.Colors.primary)
        .backgroundColor(DesignTokens.Colors.surfaceVariant)
        .borderRadius(4)

      // Prompt
      Text(this.question.prompt)
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
        .lineHeight(28)

      // Options
      Column({ space: DesignTokens.Spacing.xs }) {
        ForEach(this.question.options, (option: string, index: number) => {
          this.OptionChip(option, index)
        }, (option: string, index: number) => `${option}_${index}`)
      }

      // Hint
      Row() {
        Text(`Hint: ${this.question.hint}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.Colors.onSurface)
      }
      .padding({
        left: DesignTokens.Spacing.sm,
        right: DesignTokens.Spacing.sm,
        top: DesignTokens.Spacing.xs,
        bottom: DesignTokens.Spacing.xs
      })
      .backgroundColor('#33FFC857')
      .borderRadius(DesignTokens.Shapes.small)
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({
      radius: 8,
      color: '#38000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  StreakItem(streak: StreakCard) {
    Column({ space: DesignTokens.Spacing.xxs }) {
      Text(streak.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#4D311F10')
      Text(streak.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
    }
    .layoutWeight(1)
    .padding(DesignTokens.Spacing.sm)
    .backgroundColor(DesignTokens.Colors.surfaceVariant)
    .borderRadius(DesignTokens.Shapes.medium)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TrackersCard() {
    Column({ space: DesignTokens.Spacing.xs }) {
      Text('Trackers')
        .fontSize(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onSurface)
        .lineHeight(28)

      Row({ space: DesignTokens.Spacing.sm }) {
        ForEach(this.streaks, (streak: StreakCard) => {
          this.StreakItem(streak)
        }, (streak: StreakCard) => `${streak.label}_${streak.value}`)
      }
      .width('100%')

      Button('Submit answer')
        .width('100%')
        .height(48)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.Colors.onPrimary)
        .backgroundColor(DesignTokens.Colors.primary)
        .borderRadius(DesignTokens.Shapes.medium)
        .onClick(() => {
          hilog.info(0x0000, 'QuizForge', 'Submit answer clicked');
        })
    }
    .width('100%')
    .padding(DesignTokens.Spacing.md)
    .backgroundColor(DesignTokens.Colors.surface)
    .borderRadius(DesignTokens.Shapes.large)
    .shadow({
      radius: 4,
      color: '#2E000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: DesignTokens.Spacing.md }) {
          this.QuestionCard()
          this.TrackersCard()
        }
        .width('100%')
        .padding({
          left: DesignTokens.Spacing.lg,
          right: DesignTokens.Spacing.lg,
          top: DesignTokens.Spacing.sm,
          bottom: DesignTokens.Spacing.sm
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background)
  }
}