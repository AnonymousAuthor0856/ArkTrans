// MARK: - AppTokens

class ColorsTokens {
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

class TypographyTokens {
  displaySize: number = 26;
  headlineSize: number = 18;
  titleSize: number = 14;
  bodySize: number = 12;
  labelSize: number = 11;
}

class ShapesTokens {
  small: number = 6;
  medium: number = 10;
  large: number = 14;
}

class SpacingTokens {
  xs: number = 2;
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

class AppTokensClass {
  Colors: ColorsTokens = new ColorsTokens();
  Typography: TypographyTokens = new TypographyTokens();
  Shapes: ShapesTokens = new ShapesTokens();
  Spacing: SpacingTokens = new SpacingTokens();
}

const AppTokens: AppTokensClass = new AppTokensClass();

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
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
      }
      .width(40)
      .height(40)
      .backgroundColor(AppTokens.Colors.tertiary)
      .borderRadius(AppTokens.Shapes.small)

      Text(this.homework.title)
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.homework.status)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .padding(AppTokens.Spacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium,
    })
  }
}

// MARK: - ChartProgressBar Component

@Component
struct ChartProgressBar {
  chartData: ChartData = new ChartData(0, '', 0);

  build() {
    Column({ space: 4 }) {
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Row()
          .width(`${this.chartData.progress * 100}%`)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(24)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
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
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      .justifyContent(FlexAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Main Content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Assignments Section
          Text('Assignments')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // 2-column grid for assignments
          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                AssignmentCard({ homework: w })
              }
            }, (w: Homework) => w.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .width('100%')
          .margin({ bottom: AppTokens.Spacing.lg })

          // Progress Chart Section
          Text('Progress Chart')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // Chart bars
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ chartData: c })
            }, (c: ChartData) => c.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Submit Button
          Row() {
            Button('Submit New HW')
              .fontSize(AppTokens.Typography.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('60%')
              .height(40)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: AppTokens.Spacing.lg })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#260EA5E9', 0.0],
          ['#1A6366F1', 1.0],
        ],
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}