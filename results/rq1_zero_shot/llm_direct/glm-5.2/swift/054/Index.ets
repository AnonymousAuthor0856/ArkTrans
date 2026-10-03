// AppTokens
class AppTokens {
  static readonly Colors = {
    primary: '#0EA5E9',
    secondary: '#6366F1',
    tertiary: '#06B6D4',
    background: '#F1F5F9',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#D1D5DB',
    success: '#10B981',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#1E293B',
    onSurface: '#1E293B'
  };

  static readonly TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Medium },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Normal },
    label: { size: 11, weight: FontWeight.Medium }
  };

  static readonly Shapes = {
    small: 6.0,
    medium: 10.0,
    large: 14.0
  };

  static readonly Spacing = {
    xs: 2.0,
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };
}

// Data Models
class Homework {
  id: number;
  title: string;
  status: string;

  constructor(id: number, title: string, status: string) {
    this.id = id;
    this.title = title;
    this.status = status;
  }
}

class ChartData {
  id: number;
  label: string;
  progress: number;

  constructor(id: number, label: string, progress: number) {
    this.id = id;
    this.label = label;
    this.progress = progress;
  }
}

// RootScreen
@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ];

  private charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8)
  ];

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text('Homework Submit')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground);
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .backgroundColor(AppTokens.Colors.surface);

      // Main Content Area
      Scroll() {
        Column() {
          Text('Assignments')
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.lg });

          // Grid for Assignments
          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                AssignmentCard({ homework: w });
              }
            })
          }
          .rowsTemplate('1fr 1fr')
          .columnsTemplate('1fr 1fr')
          .padding({ bottom: AppTokens.Spacing.lg })
          .height(220);

          Text('Progress Chart')
            .fontSize(AppTokens.TypographyTokens.headline.size)
            .fontWeight(AppTokens.TypographyTokens.headline.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.sm });

          // Chart List
          Column() {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ chartData: c });
            })
          }
          .width('100%');

          // Submit Button
          Button('Submit New HW') {
            console.log('Submit New HW Tapped');
          }
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSecondary)
          .width('60%')
          .height(40)
          .backgroundColor(AppTokens.Colors.secondary)
          .borderRadius(AppTokens.Shapes.large)
          .margin({ top: AppTokens.Spacing.lg });
        }
        .padding(AppTokens.Spacing.lg);
      }
      .layoutWeight(1)
      .backgroundColor(AppTokens.Colors.background);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}

// AssignmentCard Component
@Component
struct AssignmentCard {
  private homework: Homework;

  build() {
    Column() {
      // Icon Box
      Column()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small);

      // Spacer
      Column().height(AppTokens.Spacing.sm);

      Text(this.homework.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.xs });

      Text(this.homework.status)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium });
  }
}

// ChartProgressBar Component
@Component
struct ChartProgressBar {
  private chartData: ChartData;

  build() {
    Column() {
      // Progress Bar
      Stack({ align: Alignment.Start }) {
        // Background
        Column()
          .width('100%')
          .height(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small);

        // Foreground
        Column()
          .width(`${this.chartData.progress * 100}%`)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small);
      }
      .width('100%')
      .height(24)
      .margin({ bottom: AppTokens.Spacing.xs });

      // Label
      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .width('100%')
    .margin({ bottom: AppTokens.Spacing.sm });
  }
}