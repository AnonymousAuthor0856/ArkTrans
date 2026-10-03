interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
  progressTrack: string;
}

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

@Entry
@Component
struct QuizForgePage {
  @State selectedIndex: number = -1
  private progress: number = 0.45

  private readonly colors: ColorTokens = {
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
    onSurface: '#311F10',
    progressTrack: '#E8D5F8'
  }

  private readonly question: QuizQuestion = {
    category: 'Citrus crafts',
    prompt: 'Which zest carrier gives the brightest aroma when infused cold?',
    options: ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip'],
    hint: 'Think surface area'
  }

  private readonly streaks: StreakCard[] = [
    { label: 'Current streak', value: '5 days' },
    { label: 'Accuracy', value: '84%' },
    { label: 'Rank', value: 'Top 12%' }
  ]

  @Builder
  TopBar() {
    Row() {
      Circle({ width: 30, height: 30 })
        .fill(this.colors.surfaceVariant)

      Column() {
        Text('QuizForge')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
        Text('Aroma sprint')
          .fontSize(14)
          .fontColor(this.colors.onSurface)
          .opacity(0.7)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Circle({ width: 30, height: 30 })
        .fill(this.colors.primary)
        .opacity(0.35)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 24, bottom: 16 })
  }

  @Builder
  QuestionCard() {
    Column() {
      Row() {
        Text(this.question.category)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.onSurface)
          .layoutWeight(1)
        Text('45%')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.colors.secondary)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Stack() {
        Progress({ value: 100, total: 100, type: ProgressType.Linear })
          .color(this.colors.progressTrack)
          .height(8)
          .borderRadius(4)
        Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
          .color(this.colors.primary)
          .height(8)
          .borderRadius(4)
      }
      .width('100%')
      .margin({ top: 12, bottom: 16 })

      Text(this.question.prompt)
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)
        .lineHeight(34)

      Column({ space: 10 }) {
        ForEach(this.question.options, (option: string, index: number) => {
          Text(option)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.colors.onSurface)
            .width('100%')
            .padding({ left: 18, right: 18, top: 16, bottom: 16 })
            .borderRadius(28)
            .backgroundColor(this.selectedIndex === index
              ? this.colors.primary + '33'
              : this.colors.surfaceVariant)
            .border({
              width: 1.5,
              color: this.selectedIndex === index
                ? this.colors.primary
                : this.colors.outline,
              radius: 28
            })
            .onClick(() => {
              this.selectedIndex = index
            })
        }, (option: string, index: number) => index.toString())
      }
      .width('100%')
      .margin({ top: 20 })

      Text('Hint: ' + this.question.hint)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.colors.onSurface)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .borderRadius(16)
        .backgroundColor(this.colors.secondary + '33')
        .margin({ top: 18 })
    }
    .width('100%')
    .padding(20)
    .borderRadius(36)
    .backgroundColor('#FFF1E0')
  }

  @Builder
  TrackersCard() {
    Column() {
      Text('Trackers')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.colors.onSurface)

      Row({ space: 12 }) {
        ForEach(this.streaks, (streak: StreakCard) => {
          Column({ space: 4 }) {
            Text(streak.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
              .opacity(0.7)
              .textAlign(TextAlign.Center)
            Text(streak.value)
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.colors.onSurface)
              .margin({ top: 4 })
          }
          .layoutWeight(1)
          .padding({ left: 8, right: 8, top: 16, bottom: 16 })
          .borderRadius(24)
          .backgroundColor(this.colors.surfaceVariant)
          .alignItems(HorizontalAlign.Center)
          .justifyContent(FlexAlign.Center)
        }, (streak: StreakCard) => streak.label)
      }
      .width('100%')
      .margin({ top: 12 })
    }
    .width('100%')
    .padding(20)
    .borderRadius(36)
    .backgroundColor('#FFF1E0')
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 20 }) {
          this.QuestionCard()
          this.TrackersCard()
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 4, bottom: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.background)
  }
}
