import { window } from '@kit.ArkUI';

// --- App Tokens & Constants ---

const NAME = "008_EducationQuiz_en";
const UI_TYPE = "Education Quiz";
const STYLE_THEME = "Playful Pastel";
const LANG = "en";
const BASELINE_SIZE = "1280x720";

class AppTokens {
  static Colors = {
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

  static Shapes = {
    small: 6,
    medium: 8,
    large: 12
  };

  static ElevationMapping = {
    level1: 1,
    level2: 2,
    level3: 3,
    level4: 4,
    level5: 5
  };
}

interface QuestionUi {
  id: number;
  title: string;
  options: string[];
  answer: number;
}

// --- Components ---

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

  aboutToAppear() {
    // Hide navigation bar to match Android behavior
    let windowClass: window.Window = null;
    window.getMainWindow((err, data) => {
      if (err.code !== 0) {
        console.error('Failed to get main window. Cause:' + JSON.stringify(err));
        return;
      }
      windowClass = data;
      windowClass.setWindowLayoutFullScreen(true);
    });
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Row({ space: AppTokens.Spacing.sm }) {
          Rectangle()
            .width(20)
            .height(20)
            .fillColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.small)
          
          Text("Quiz")
            .fontSize(24)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .lineHeight(30)
        }
      }
      .width('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
      .backgroundColor(AppTokens.Colors.background)

      // Main Content Area
      if (this.completed) {
        Column() {
          Text("Quiz Completed")
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onSurface)
            .lineHeight(24)
          
          Spacer().height(AppTokens.Spacing.lg)
          
          Row() {
            Text(`Score: ${this.score}/${this.questions.length}`)
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.primary)
              .lineHeight(24)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .minHeight(120)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.large)
          
          Spacer().height(AppTokens.Spacing.lg)
          
          Button("Restart") {
            this.index = 0;
            this.selected = -1;
            this.score = 0;
            this.completed = false;
          }
          .width('100%')
          .height(44)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Shapes.large)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
        }
        .layoutWeight(1)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.xl })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      } else {
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Question Card
            Column() {
              Column({ space: AppTokens.Spacing.md }) {
                // Aspect Ratio Box
                Row() {
                  Text(`Question ${this.index + 1}/${this.questions.length}`)
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.onSurface)
                    .lineHeight(14)
                }
                .width('100%')
                .aspectRatio(2.8)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)

                Text(this.questions[this.index].title)
                  .fontSize(18)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(AppTokens.Colors.onSurface)
                  .lineHeight(24)

                // Options
                Column({ space: AppTokens.Spacing.sm }) {
                  ForEach(this.questions[this.index].options, (option: string, i: number) => {
                    const isActive = this.selected === i;
                    
                    Button(option) {
                      this.selected = i;
                    }
                    .width('100%')
                    .justifyContent(FlexAlign.Start)
                    .margin({ left: 12, right: 12, top: 8, bottom: 8 })
                    .backgroundColor(isActive ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                    .fontColor(isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
                    .fontSize(isActive ? 14 : 12)
                    .fontWeight(isActive ? FontWeight.Medium : FontWeight.Normal)
                    .borderRadius(AppTokens.Shapes.medium)
                    .borderWidth(1)
                    .borderColor(AppTokens.Colors.outline)
                  })
                }
              }
              .width('100%')
              .padding(AppTokens.Spacing.lg)
            }
            .width('100%')
            .minHeight(180)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
            .border({ width: 1, color: AppTokens.Colors.outline })

            // Selected Info Row
            Row() {
              Column() {
                Text("Selected")
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .lineHeight(14)
                
                Text(this.selected >= 0 ? this.questions[this.index].options[this.selected] : "None")
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .lineHeight(18)
              }
              
              Flex({ justifyContent: FlexAlign.End }) {
                Button("Skip") {
                  // Skip logic placeholder
                }
                .backgroundColor(AppTokens.Colors.surface)
                .fontColor(AppTokens.Colors.onSurface)
                .borderRadius(AppTokens.Shapes.small)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .fontSize(10)
                .fontWeight(FontWeight.Medium)
                .margin({ left: AppTokens.Spacing.sm })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            
            // Bottom padding for scroll
            Spacer().height(AppTokens.Spacing.xxxl)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })
        }
        .layoutWeight(1)
      }

      // Bottom Bar
      if (!this.completed) {
        Row() {
          Column() {
            Text("Progress")
              .fontSize(10)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .lineHeight(14)
            
            Progress({ value: this.selected >= 0 ? (this.index + 1) / this.questions.length : this.index / this.questions.length, total: 1 })
              .width(140)
              .height(6)
              .color(AppTokens.Colors.primary)
              .trackColor(AppTokens.Colors.surfaceVariant)
              .linear(true)
          }
          
          Row({ space: AppTokens.Spacing.sm }) {
            // Review Chip
            Button("Review") {
              const idx = this.flags.indexOf("Review");
              if (idx > -1) {
                this.flags.splice(idx, 1);
              } else {
                this.flags.push("Review");
              }
            }
            .backgroundColor(this.flags.includes("Review") ? AppTokens.Colors.secondary : AppTokens.Colors.surface)
            .fontColor(this.flags.includes("Review") ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
            .borderRadius(AppTokens.Shapes.small)
            .borderWidth(1)
            .borderColor(AppTokens.Colors.outline)
            .fontSize(10)
            .fontWeight(FontWeight.Medium)
            
            // Next/Finish Button
            Button(this.index < this.questions.length - 1 ? "Next" : "Finish") {
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
            .width(140)
            .height(44)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .borderRadius(AppTokens.Shapes.large)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
          }
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 10, color: 'rgba(0,0,0,0.1)', offsetY: -2 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}