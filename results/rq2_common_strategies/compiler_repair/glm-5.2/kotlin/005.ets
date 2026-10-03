// Index.ets

interface QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokens {
  static Colors = {
    primary: '#FF7C3AED',
    secondary: '#FF22C55E',
    tertiary: '#FFF97316',
    background: '#FFFAFAFF',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFF1F5F9',
    outline: '#FFE2E8F0',
    success: '#FF16A34A',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FF0F172A',
    onTertiary: '#FF111827',
    onBackground: '#FF0B1220',
    onSurface: '#FF0B1220'
  };

  static Typography = {
    display: { fontSize: 24, fontWeight: FontWeight.Medium, lineHeight: 30 },
    headline: { fontSize: 18, fontWeight: FontWeight.Medium, lineHeight: 24 },
    title: { fontSize: 14, fontWeight: FontWeight.Medium, lineHeight: 18 },
    body: { fontSize: 12, fontWeight: FontWeight.Normal, lineHeight: 16 },
    label: { fontSize: 10, fontWeight: FontWeight.Medium, lineHeight: 14 }
  };

  static Shapes = {
    small: 6,
    medium: 8,
    large: 12
  };

  static Spacing = {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  };

  static ElevationMapping: Record<string, ShadowSpec> = {
    level1: { elevation: 1, radius: 2, dy: 0.5, opacity: 0.12 },
    level2: { elevation: 2, radius: 4, dy: 1, opacity: 0.14 },
    level3: { elevation: 3, radius: 6, dy: 1.5, opacity: 0.16 },
    level4: { elevation: 4, radius: 8, dy: 2, opacity: 0.18 },
    level5: { elevation: 5, radius: 10, dy: 2.5, opacity: 0.2 }
  };
}

@Entry
@Component
struct RootScreen {
  @State index: number = 0;
  @State selected: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State flags: string[] = [];

  private questions: QuestionUi[] = [
    { id: 1, title: 'Which planet is known as the Red Planet?', options: ['Earth', 'Mars', 'Venus', 'Jupiter'], answer: 1 },
    { id: 2, title: 'What is the chemical symbol for water?', options: ['H2O', 'CO2', 'NaCl', 'O2'], answer: 0 },
    { id: 3, title: 'Who wrote Hamlet?', options: ['Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'], answer: 2 },
    { id: 4, title: 'What is the largest mammal?', options: ['African Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'], answer: 1 }
  ];

  private toggleReview() {
    const idx = this.flags.indexOf('Review');
    if (idx >= 0) {
      this.flags.splice(idx, 1);
    } else {
      this.flags.push('Review');
    }
  }

  private nextQuestion() {
    if (!this.completed) {
      if (this.selected === this.questions[this.index].answer) {
        this.score += 1;
      }
      if (this.index < this.questions.length - 1) {
        this.index += 1;
        this.selected = -1;
      } else {
        this.completed = true;
      }
    }
  }

  private restart() {
    this.index = 0;
    this.selected = -1;
    this.score = 0;
    this.completed = false;
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Row() {
          Row()
            .width(20)
            .height(20)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          Text('Quiz')
            .fontSize(AppTokens.Typography.display.fontSize)
            .fontWeight(AppTokens.Typography.display.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Content
      if (this.completed) {
        Column() {
          Text('Quiz Completed')
            .fontSize(AppTokens.Typography.headline.fontSize)
            .fontWeight(AppTokens.Typography.headline.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Blank().height(AppTokens.Spacing.lg)

          Row() {
            Text(`Score: ${this.score}/${this.questions.length}`)
              .fontSize(AppTokens.Typography.headline.fontSize)
              .fontWeight(AppTokens.Typography.headline.fontWeight)
              .fontColor(AppTokens.Colors.primary)
          }
          .width('100%')
          .height(120)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          .justifyContent(FlexAlign.Center)
          .alignItems(VerticalAlign.Center)

          Blank().height(AppTokens.Spacing.lg)

          Button('Restart')
            .type(ButtonType.Capsule)
            .width('100%')
            .height(44)
            .backgroundColor(AppTokens.Colors.secondary)
            .fontColor(AppTokens.Colors.onSecondary)
            .onClick(() => this.restart())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Scroll() {
          Column() {
            // Question Card
            Column() {
              Row() {
                Text(`Question ${this.index + 1}/${this.questions.length}`)
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
              }
              .width('100%')
              .aspectRatio(2.8)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .justifyContent(FlexAlign.Center)
              .alignItems(VerticalAlign.Center)

              Text(this.questions[this.index].title)
                .fontSize(AppTokens.Typography.headline.fontSize)
                .fontWeight(AppTokens.Typography.headline.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.md })

              ForEach(this.questions[this.index].options, (option: string, i: number) => {
                Text(option)
                  .fontSize(this.selected === i ? AppTokens.Typography.title.fontSize : AppTokens.Typography.body.fontSize)
                  .fontWeight(this.selected === i ? AppTokens.Typography.title.fontWeight : AppTokens.Typography.body.fontWeight)
                  .fontColor(this.selected === i ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                  .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                  .backgroundColor(this.selected === i ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.medium)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .margin({ top: AppTokens.Spacing.sm })
                  .width('100%')
                  .textAlign(TextAlign.Center)
                  .onClick(() => {
                    this.selected = i;
                  })
              })
            }
            .width('100%')
            .padding(AppTokens.Spacing.lg)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`, offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })

            // Selected Row
            Row() {
              Column() {
                Text('Selected')
                  .fontSize(AppTokens.Typography.label.fontSize)
                  .fontWeight(AppTokens.Typography.label.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : 'None')
                  .fontSize(AppTokens.Typography.title.fontSize)
                  .fontWeight(AppTokens.Typography.title.fontWeight)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs })
              }
              .alignItems(HorizontalAlign.Start)

              Text('Skip')
                .fontSize(AppTokens.Typography.label.fontSize)
                .fontWeight(AppTokens.Typography.label.fontWeight)
                .fontColor(AppTokens.Colors.onSurface)
                .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.small)
                .border({ width: 1, color: AppTokens.Colors.outline })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ top: AppTokens.Spacing.lg })
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
        }
        .layoutWeight(1)
        .align(Alignment.TopStart)
        .backgroundColor(AppTokens.Colors.background)
      }

      // Bottom Bar
      Row() {
        Column() {
          Text('Progress')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(AppTokens.Colors.onSurface)
          Progress({ value: this.completed ? this.questions.length : (this.index + (this.selected >= 0 ? 1 : 0)), total: this.questions.length, type: ProgressType.Linear })
            .width(140)
            .height(6)
            .color(AppTokens.Colors.primary)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Row() {
          Text('Review')
            .fontSize(AppTokens.Typography.label.fontSize)
            .fontWeight(AppTokens.Typography.label.fontWeight)
            .fontColor(this.flags.includes('Review') ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
            .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .backgroundColor(this.flags.includes('Review') ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.small)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .onClick(() => this.toggleReview())

          Button(this.index < this.questions.length - 1 ? 'Next' : (this.completed ? 'Done' : 'Finish'))
            .type(ButtonType.Capsule)
            .width(140)
            .height(44)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .margin({ left: AppTokens.Spacing.sm })
            .onClick(() => this.nextQuestion())
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: AppTokens.ElevationMapping.level3.radius, color: `rgba(0,0,0,${AppTokens.ElevationMapping.level3.opacity})`, offsetX: 0, offsetY: AppTokens.ElevationMapping.level3.dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}