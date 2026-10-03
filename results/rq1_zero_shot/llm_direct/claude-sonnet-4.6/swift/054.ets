import { LengthMetrics } from '@kit.ArkUI';

// MARK: - AppTokens

namespace AppTokens {
  export namespace Colors {
    export const primary = '#0EA5E9';
    export const secondary = '#6366F1';
    export const tertiary = '#06B6D4';
    export const background = '#F1F5F9';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#E2E8F0';
    export const outline = '#D1D5DB';
    export const success = '#10B981';
    export const warning = '#F59E0B';
    export const error = '#EF4444';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#FFFFFF';
    export const onTertiary = '#0F172A';
    export const onBackground = '#1E293B';
    export const onSurface = '#1E293B';
  }

  export namespace Typography {
    export const displaySize = 26;
    export const headlineSize = 18;
    export const titleSize = 14;
    export const bodySize = 12;
    export const labelSize = 11;
  }

  export namespace Shapes {
    export const small = 6;
    export const medium = 10;
    export const large = 14;
  }

  export namespace Spacing {
    export const xs = 2;
    export const sm = 6;
    export const md = 10;
    export const lg = 14;
    export const xl = 20;
    export const xxl = 28;
  }
}

// MARK: - Data Models

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

// MARK: - AssignmentCard Component

@Component
struct AssignmentCard {
  homework: Homework = { id: 0, title: '', status: '' };

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Stack() {
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

      Text(this.homework.status)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.medium
    })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .aspectRatio(1.0)
  }
}

// MARK: - ChartProgressBar Component

@Component
struct ChartProgressBar {
  chartData: ChartData = { id: 0, label: '', progress: 0 };

  build() {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Start }) {
        Row() {
        }
        .width('100%')
        .height(24)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.small)

        Row() {
        }
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
        .margin({ top: 2 })
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
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ];

  @State private charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 }
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

          // Grid - 2 columns
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

          // Chart Bars
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ chartData: c })
            }, (c: ChartData) => c.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // Submit Button
          Button('Submit New HW')
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .width('60%')
            .height(40)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ top: AppTokens.Spacing.lg })
            .onClick(() => {
              console.info('Submit New HW Tapped');
            })
        }
        .padding(AppTokens.Spacing.lg)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .layoutWeight(1)
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
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}