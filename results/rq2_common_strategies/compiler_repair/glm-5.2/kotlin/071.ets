// Index.ets
interface DesignColors {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface DesignShapes {
  small: number;
  medium: number;
  large: number;
}

interface DesignSpacing {
  xxs: number;
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface DesignElevationMapping {
  level1: ShadowSpec;
  level2: ShadowSpec;
  level3: ShadowSpec;
  level4: ShadowSpec;
  level5: ShadowSpec;
}

class DesignTokens {
  static Colors: DesignColors = {
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

  static Shapes: DesignShapes = {
    small: 10,
    medium: 18,
    large: 28
  };

  static Spacing: DesignSpacing = {
    xxs: 4,
    xs: 8,
    sm: 12,
    md: 16,
    lg: 20,
    xl: 28,
    xxl: 36,
    xxxl: 46
  };

  static ElevationMapping: DesignElevationMapping = {
    level1: { elevation: 2, radius: 4, dy: 2, opacity: 0.18 } as ShadowSpec,
    level2: { elevation: 6, radius: 8, dy: 4, opacity: 0.22 } as ShadowSpec,
    level3: { elevation: 12, radius: 12, dy: 6, opacity: 0.26 } as ShadowSpec,
    level4: { elevation: 18, radius: 18, dy: 8, opacity: 0.3 } as ShadowSpec,
    level5: { elevation: 26, radius: 26, dy: 12, opacity: 0.34 } as ShadowSpec
  };
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
struct RootScreen {
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
  private progress: number = 0.45;

  build() {
    Column() {
      // Top App Bar
      Row() {
        // Navigation Icon
        Circle({ width: 30, height: 30 })
          .fill(DesignTokens.Colors.surfaceVariant)
          .margin({ left: DesignTokens.Spacing.md });

        // Title
        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface);
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(DesignTokens.Colors.onSurface)
            .opacity(0.7);
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center);

        // Action Icon
        Circle({ width: 30, height: 30 })
          .fill(DesignTokens.Colors.primary)
          .opacity(0.35)
          .margin({ right: DesignTokens.Spacing.md });
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center);

      // Scrollable Content
      Scroll() {
        Column() {
          // Question Card
          Column() {
            Row() {
              Text(this.question.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface);
              Text('45%')
                .fontSize(14)
                .fontColor(DesignTokens.Colors.secondary);
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            // Linear Progress Indicator
            Progress({ value: this.progress * 100, total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(DesignTokens.Colors.primary)
              .backgroundColor(DesignTokens.Colors.surfaceVariant)
              .margin({ top: DesignTokens.Spacing.sm });

            Text(this.question.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onSurface)
              .margin({ top: DesignTokens.Spacing.sm });

            // Options
            Column({ space: DesignTokens.Spacing.xs }) {
              ForEach(this.question.options, (option: string, index: number) => {
                Row() {
                  Text(option)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.Colors.onSurface);
                }
                .width('100%')
                .padding(DesignTokens.Spacing.sm)
                .borderRadius(DesignTokens.Shapes.medium)
                .backgroundColor(this.selectedIndex === index ? DesignTokens.Colors.primary : DesignTokens.Colors.surfaceVariant)
                .opacity(this.selectedIndex === index ? 0.2 : 1.0)
                .border({
                  width: 1,
                  color: this.selectedIndex === index ? DesignTokens.Colors.primary : DesignTokens.Colors.outline,
                  radius: DesignTokens.Shapes.medium
                })
                .onClick(() => {
                  this.selectedIndex = index;
                });
              });
            }
            .margin({ top: DesignTokens.Spacing.sm });

            // Hint Box
            Row() {
              Text(`Hint: ${this.question.hint}`)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.Colors.onSurface);
            }
            .padding({ left: DesignTokens.Spacing.sm, right: DesignTokens.Spacing.sm, top: DesignTokens.Spacing.xs, bottom: DesignTokens.Spacing.xs })
            .borderRadius(DesignTokens.Shapes.small)
            .backgroundColor(DesignTokens.Colors.secondary)
            .opacity(0.2)
            .margin({ top: DesignTokens.Spacing.sm });
          }
          .padding(DesignTokens.Spacing.md)
          .borderRadius(DesignTokens.Shapes.large)
          .backgroundColor(DesignTokens.Colors.surface)
          .shadow({
            radius: DesignTokens.ElevationMapping.level2.radius,
            color: `rgba(0,0,0,${DesignTokens.ElevationMapping.level2.opacity})`,
            offsetX: 0,
            offsetY: DesignTokens.ElevationMapping.level2.dy
          });

          // Trackers Card
          Column() {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.Medium)
              .fontColor(DesignTokens.Colors.onSurface);

            Row({ space: DesignTokens.Spacing.sm }) {
              ForEach(this.streaks, (streak: StreakCard) => {
                Column() {
                  Text(streak.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.Colors.onSurface)
                    .opacity(0.7);
                  Text(streak.value)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(DesignTokens.Colors.onSurface);
                }
                .layoutWeight(1)
                .padding(DesignTokens.Spacing.sm)
                .borderRadius(DesignTokens.Shapes.medium)
                .backgroundColor(DesignTokens.Colors.surfaceVariant)
                .alignItems(HorizontalAlign.Center)
                .justifyContent(FlexAlign.Center);
              });
            }
            .width('100%')
            .margin({ top: DesignTokens.Spacing.xs });

            Button('Submit answer')
              .type(ButtonType.Capsule)
              .width('100%')
              .backgroundColor(DesignTokens.Colors.primary)
              .fontColor(DesignTokens.Colors.onPrimary)
              .margin({ top: DesignTokens.Spacing.xs });
          }
          .padding(DesignTokens.Spacing.md)
          .borderRadius(DesignTokens.Shapes.large)
          .backgroundColor(DesignTokens.Colors.surface)
          .shadow({
            radius: DesignTokens.ElevationMapping.level1.radius,
            color: `rgba(0,0,0,${DesignTokens.ElevationMapping.level1.opacity})`,
            offsetX: 0,
            offsetY: DesignTokens.ElevationMapping.level1.dy
          })
          .margin({ top: DesignTokens.Spacing.md });
        }
        .padding({ left: DesignTokens.Spacing.lg, right: DesignTokens.Spacing.lg, top: DesignTokens.Spacing.sm, bottom: DesignTokens.Spacing.sm });
      }
      .layoutWeight(1)
      .backgroundColor(DesignTokens.Colors.background)
      .align(Alignment.Top);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.Colors.background);
  }
}