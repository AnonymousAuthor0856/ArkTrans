// AppTokens.ets
export class AppTokens {
  static Colors: Record<string, ResourceColor> = {
    primary: '#FF0EA5E9',
    secondary: '#FF6366F1',
    tertiary: '#FF06B6D4',
    background: '#FFF1F5F9',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFE2E8F0',
    outline: '#FFD1D5DB',
    success: '#FF10B981',
    warning: '#FFF59E0B',
    error: '#FFEF4444',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FF0F172A',
    onBackground: '#FF1E293B',
    onSurface: '#FF1E293B'
  };

  static TypographyTokens: Record<string, (string | number | FontWeight)[]> = {
    display: ['sans-serif', 26, FontWeight.Bold],
    headline: ['sans-serif', 18, FontWeight.Medium],
    title: ['sans-serif', 14, FontWeight.Medium],
    body: ['sans-serif', 12, FontWeight.Normal],
    label: ['sans-serif', 11, FontWeight.Medium]
  };

  static Shapes: Record<string, number> = {
    small: 6.0,
    medium: 10.0,
    large: 14.0
  };

  static Spacing: Record<string, number> = {
    xs: 2.0,
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };
}

// Data Models
export class Homework {
  id: number;
  title: string;
  status: string;

  constructor(id: number, title: string, status: string) {
    this.id = id;
    this.title = title;
    this.status = status;
  }
}

export class ChartData {
  id: number;
  label: string;
  progress: number;

  constructor(id: number, label: string, progress: number) {
    this.id = id;
    this.label = label;
    this.progress = progress;
  }
}

// Helper function to apply typography styles
@Extend(Text)
function typography(styleConfig: (string | number | FontWeight)[]) {
  .fontFamily(styleConfig[0] as string)
  .fontSize(styleConfig[1] as number)
  .fontWeight(styleConfig[2] as FontWeight)
}

// RootScreen Component
@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    new Homework(1, "Linear Algebra HW1", "Submitted"),
    new Homework(2, "Data Structures HW2", "Pending"),
    new Homework(3, "Algorithm HW3", "Graded"),
    new Homework(4, "Probability HW4", "Pending")
  ];

  @State private charts: ChartData[] = [
    new ChartData(1, "Week 1", 0.7),
    new ChartData(2, "Week 2", 0.9),
    new ChartData(3, "Week 3", 0.5),
    new ChartData(4, "Week 4", 0.8)
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background color for the entire screen
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // TopAppBar Equivalent
        Row() {
          Text("Homework Submit")
            .typography(AppTokens.TypographyTokens.display)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Main Content Area
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            Text("Assignments")
              .typography(AppTokens.TypographyTokens.headline)
              .fontColor(AppTokens.Colors.onBackground)

            // LazyVerticalGrid Equivalent
            Grid() {
              ForEach(this.works, (w: Homework) => {
                GridItem() {
                  AssignmentCard({ homework: w })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(AppTokens.Spacing.md)
            .rowsGap(AppTokens.Spacing.md)
            .padding({ bottom: AppTokens.Spacing.lg })

            Text("Progress Chart")
              .typography(AppTokens.TypographyTokens.headline)
              .fontColor(AppTokens.Colors.onBackground)

            // LazyColumn Equivalent
            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.charts, (c: ChartData) => {
                ChartProgressBar({ chartData: c })
              })
            }

            // Submit Button
            Button("Submit New HW", { type: ButtonType.Capsule })
              .onClick(() => {
                console.info("Submit New HW Tapped");
              })
              .typography(AppTokens.TypographyTokens.title)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('60%')
              .height(40)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .margin({ top: AppTokens.Spacing.lg })
          }
          .padding(AppTokens.Spacing.lg)
          .alignItems(HorizontalAlign.Start)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .linearGradient({
          angle: 180,
          colors: [
            [AppTokens.Colors.primary as string, 0.15],
            [AppTokens.Colors.secondary as string, 0.1]
          ]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// AssignmentCard Component
@Component
struct AssignmentCard {
  private homework: Homework = new Homework(0, "", "");

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Box equivalent
      Column()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small)

      // Spacer
      Blank().layoutWeight(1)

      Text(this.homework.title)
        .typography(AppTokens.TypographyTokens.title)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.homework.status)
        .typography(AppTokens.TypographyTokens.label)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
  }
}

// ChartProgressBar Component
@Component
struct ChartProgressBar {
  private chartData: ChartData = new ChartData(0, "", 0);

  build() {
    Column() {
      // Row equivalent for progress bar
      Stack({ alignContent: Alignment.Start }) {
        Column()
          .width(`${this.chartData.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .typography(AppTokens.TypographyTokens.body)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 0 })
    }
    .alignItems(HorizontalAlign.Start)
  }
}