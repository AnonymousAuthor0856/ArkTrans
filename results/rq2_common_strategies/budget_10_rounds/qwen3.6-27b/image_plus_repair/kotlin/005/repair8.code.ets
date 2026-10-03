import { promptAction } from '@kit.ArkUI';

// --- Data Models & Tokens ---

interface QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;
}

interface AppColors {
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
}

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
    primary: '#7C3AED',
    secondary: '#22C55E',
    tertiary: '#F97316',
    background: '#FAFAFF',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#16A34A',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#111827',
    onBackground: '#0B1220',
    onSurface: '#0B1220'
  } as AppColors,
  Spacing: {
    xs: 2,
    sm: 4,
    md: 6,
    lg: 8,
    xl: 12,
    xxl: 16,
    xxxl: 24
  } as AppSpacing,
  Shapes: {
    small: 6,
    medium: 8,
    large: 12
  } as AppShapes
};

@Entry
@Component
struct RootScreen {
  @State questions: QuestionUi[] = [
    { id: 1, title: "Which planet is known as the Red Planet?", options: ["Earth", "Mars", "Venus", "Jupiter"], answer: 1 },
    { id: 2, title: "What is the chemical symbol for water?", options: ["H2O", "CO2", "NaCl", "O2"], answer: 0 },
    { id: 3, title: "Who wrote Hamlet?", options: ["Charles Dickens", "Mark Twain", "William Shakespeare", "Jane Austen"], answer: 2 },
    { id: 4, title: "What is the largest mammal?", options: ["African Elephant", "Blue Whale", "Giraffe", "Hippopotamus"], answer: 1 }
  ];
  @State index: number = 0;
  @State selected: number = -1;
  @State score: number = 0;
  @State completed: boolean = false;
  @State flags: string[] = [];

  build() {
    Column() {
      // Top Bar
      Row() {
        Row() {
          Text('Quiz')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onSurface)
            .margin({ left: AppTokens.Spacing.sm })
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      if (this.completed) {
        this.CompletedView()
      } else {
        this.QuizView()
      }

      // Bottom Bar
      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  CompletedView() {
    Column() {
      Text("Quiz Completed")
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onSurface)
      
      Text(`Score: ${this.score}/${this.questions.length}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.primary)
        .margin({ top: AppTokens.Spacing.lg })
        .padding(AppTokens.Spacing.md)
        .borderRadius(AppTokens.Shapes.large)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .width('80%')
        .textAlign(TextAlign.Center)

      Button("Restart")
        .type(ButtonType.Normal)
        .backgroundColor(AppTokens.Colors.secondary)
        .fontColor(AppTokens.Colors.onSecondary)
        .borderRadius(AppTokens.Shapes.large)
        .height(44)
        .width('100%')
        .margin({ top: AppTokens.Spacing.lg })
        .onClick(() => {
          this.index = 0;
          this.selected = -1;
          this.score = 0;
          this.completed = false;
        })
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })
  }

  @Builder
  QuizView() {
    Column() {
      // Question Card
      Column() {
        // Image Placeholder / Header
        Row() {
          Text(`Question ${this.index + 1}/${this.questions.length}`)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .aspectRatio(2.8)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

        Text(this.questions[this.index].title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ top: AppTokens.Spacing.md })
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        // Options
        Column() {
          ForEach(this.questions[this.index].options, (option: string, i: number) => {
            this.OptionChip(option, i)
          })
        }
        .margin({ top: AppTokens.Spacing.md })
        .width('100%')
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
      .borderRadius(AppTokens.Shapes.large)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: 4 })
      .border({ width: 1, color: AppTokens.Colors.outline })

      // Selected Info Row
      Row() {
        Column() {
          Text("Selected")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          
          Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : "None")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
        }
        
        Blank()

        Button("Skip")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.surface)
          .fontColor(AppTokens.Colors.onSurface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .borderRadius(AppTokens.Shapes.small)
          .height(36)
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.lg })
    }
    .layoutWeight(1)
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.xxxl })
  }

  @Builder
  OptionChip(text: string, index: number) {
    Button(text)
      .type(ButtonType.Capsule)
      .backgroundColor(this.selected === index ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .fontColor(this.selected === index ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .borderRadius(AppTokens.Shapes.medium)
      .height(44)
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })
      .onClick(() => {
        this.selected = index;
      })
  }

  @Builder
  BottomBar() {
    Column() {
      Row() {
        Column() {
          Text("Progress")
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
          
          Progress({ value: this.completed ? 100 : ((this.index + (this.selected >= 0 ? 1 : 0)) * 100 / this.questions.length), total: 100 })
            .width(140)
            .height(6)
            .color(AppTokens.Colors.primary)
            .trackColor(AppTokens.Colors.surfaceVariant)
            .margin({ top: AppTokens.Spacing.xs })
        }

        Blank()

        Button("Review")
          .type(ButtonType.Capsule)
          .backgroundColor(this.flags.includes("Review") ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
          .fontColor(this.flags.includes("Review") ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
          .border({ width: 1, color: AppTokens.Colors.outline })
          .borderRadius(AppTokens.Shapes.small)
          .height(36)
          .margin({ right: AppTokens.Spacing.sm })
          .onClick(() => {
            if (this.flags.includes("Review")) {
              this.flags = this.flags.filter(f => f !== "Review");
            } else {
              this.flags.push("Review");
            }
          })

        Button(this.index < this.questions.length - 1 ? "Next" : "Finish")
          .type(ButtonType.Capsule)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.large)
          .height(44)
          .width(140)
          .onClick(() => {
            if (!this.completed) {
              if (this.selected === this.questions[this.index].answer) {
                this.score++;
              }
              if (this.index < this.questions.length - 1) {
                this.index++;
                this.selected = -1;
              } else {
                this.completed = true;
              }
            }
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.05)', offsetY: -2 })
  }
}