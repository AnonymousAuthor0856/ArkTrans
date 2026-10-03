// MARK: - AppTokens (Kotlin to Swift Translation)

interface FontStyle {
  size: number;
  weight: FontWeight;
}

interface ShadowSpec {
  radius: number;
  x: number;
  y: number;
  opacity: number;
}

class AppTokens {
  static readonly Colors: Record<string, string> = {
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
    onSurface: '#1E293B',
  };

  static readonly Typography: Record<string, FontStyle> = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.Semibold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium },
  };

  static readonly Shapes: Record<string, number> = {
    small: 6,
    medium: 10,
    large: 14,
  };

  static readonly Spacing: Record<string, number> = {
    xs: 2,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28,
  };

  static readonly ElevationMapping: Record<string, ShadowSpec> = {
    level1: { radius: 2, x: 0, y: 1, opacity: 0.1 },
    level2: { radius: 4, x: 0, y: 2, opacity: 0.14 },
    level3: { radius: 6, x: 0, y: 3, opacity: 0.16 },
  };
}

interface Homework {
  id: number;
  title: string;
  status: string;
}

interface ChartData {
  id: number;
  label: string;
  progress: number;
}

@Component
struct AssignmentCard {
  homework: Homework = { id: 0, title: '', status: '' };

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small)

      Blank()

      Text(this.homework.title)
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
      Text(this.homework.status)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .aspectRatio(1.0)
  }
}

@Component
struct ChartProgressBar {
  chartData: ChartData = { id: 0, label: '', progress: 0 };

  build() {
    Column() {
      Row() {
        Row()
          .width((this.chartData.progress * 100) + '%')
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
        Blank()
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)

      Text(this.chartData.label + ': ' + Math.floor(this.chartData.progress * 100) + '%')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct RootScreen {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ];

  @State charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
  ];

  build() {
    Stack() {
      Column() {
        // TopAppBar
        Row() {
          Text('Homework Submit')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Main content area
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            Text('Assignments')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onBackground)

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
            .padding({ bottom: AppTokens.Spacing.lg })

            Text('Progress Chart')
              .fontSize(AppTokens.Typography.headline.size)
              .fontWeight(AppTokens.Typography.headline.weight)
              .fontColor(AppTokens.Colors.onBackground)

            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.charts, (c: ChartData) => {
                ChartProgressBar({ chartData: c })
              }, (c: ChartData) => c.id.toString())
            }

            Button() {
              Text('Submit New HW')
                .fontSize(AppTokens.Typography.title.size)
                .fontWeight(AppTokens.Typography.title.weight)
                .fontColor(AppTokens.Colors.onSecondary)
                .width('100%')
            }
            .width('60%')
            .height(40)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .alignSelf(ItemAlign.Center)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              console.log('Submit New HW Tapped');
            })
          }
          .alignItems(HorizontalAlign.Start)
          .padding(AppTokens.Spacing.lg)
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            ['#260EA5E9', 0.0],
            ['#1A6366F1', 1.0]
          ]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    // Custom UIHostingController + statusBarHidden handled full-screen display in SwiftUI.
    RootScreen()
  }
}
