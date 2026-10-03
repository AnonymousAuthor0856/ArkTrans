// MARK: - AppTokens

class AppColors {
  primary: string = '#0EA5E9';
  secondary: string = '#6366F1';
  tertiary: string = '#06B6D4';
  background: string = '#F1F5F9';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#E2E8F0';
  outline: string = '#D1D5DB';
  success: string = '#10B981';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#FFFFFF';
  onTertiary: string = '#0F172A';
  onBackground: string = '#1E293B';
  onSurface: string = '#1E293B';
}

class AppSpacing {
  xs: number = 2;
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

class AppShapes {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

const Colors = new AppColors();
const Spacing = new AppSpacing();
const Shapes = new AppShapes();

// MARK: - Data Models

class Homework {
  id: number = 0;
  title: string = '';
  status: string = '';

  constructor(id: number, title: string, status: string) {
    this.id = id;
    this.title = title;
    this.status = status;
  }
}

class ChartData {
  id: number = 0;
  label: string = '';
  progress: number = 0;

  constructor(id: number, label: string, progress: number) {
    this.id = id;
    this.label = label;
    this.progress = progress;
  }
}

// MARK: - AssignmentCard Component

@Component
struct AssignmentCard {
  homework: Homework = new Homework(0, '', '');

  build() {
    Column({ space: Spacing.sm }) {
      Column()
        .width(40)
        .height(40)
        .backgroundColor(Colors.tertiary)
        .borderRadius(Shapes.small)

      Text(this.homework.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)

      Text(this.homework.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.medium)
    .border({ width: 1, color: Colors.outline, radius: Shapes.medium })
  }
}

// MARK: - ChartProgressBar Component

@Component
struct ChartProgressBar {
  chartData: ChartData = new ChartData(0, '', 0);

  build() {
    Column({ space: 2 }) {
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(24)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Shapes.small)

        Row()
          .width(`${this.chartData.progress * 100}%`)
          .height(24)
          .backgroundColor(Colors.primary)
          .borderRadius(Shapes.small)
      }
      .width('100%')
      .height(24)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending'),
  ];

  @State private charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8),
  ];

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: Spacing.lg, bottom: Spacing.lg })
      .backgroundColor(Colors.surface)

      // Main Content
      Scroll() {
        Column({ space: Spacing.lg }) {
          // Assignments Section
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .width('100%')

          // 2-column grid for assignments
          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                AssignmentCard({ homework: w })
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(Spacing.md)
          .rowsGap(Spacing.md)
          .width('100%')

          // Progress Chart Section
          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onBackground)
            .width('100%')

          // Chart bars
          Column({ space: Spacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ chartData: c })
            })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Submit Button
          Row() {
            Button('Submit New HW')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSecondary)
              .width('60%')
              .height(40)
              .backgroundColor(Colors.secondary)
              .borderRadius(Shapes.large)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: Spacing.lg })
        }
        .padding(Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}