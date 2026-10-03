// Homework Submit - Education Chart UI
// Converted from Kotlin Compose to ArkTS

import prompt from '@ohos.promptAction';

// Design Tokens
const AppColors = {
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

const AppTypography = {
  display: { fontSize: 26, fontWeight: FontWeight.Bold },
  headline: { fontSize: 18, fontWeight: FontWeight.SemiBold },
  title: { fontSize: 14, fontWeight: FontWeight.Medium },
  body: { fontSize: 12, fontWeight: FontWeight.Normal },
  label: { fontSize: 11, fontWeight: FontWeight.Medium },
};

const AppShapes = {
  small: 6,
  medium: 10,
  large: 14,
};

const AppSpacing = {
  xs: 2,
  sm: 6,
  md: 10,
  lg: 14,
  xl: 20,
  xxl: 28,
};

// Data models
@Observed
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

@Observed
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

// Homework Card Component
@Component
struct HomeworkCard {
  work: Homework = new Homework(0, '', '');

  build() {
    Column() {
      Row()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.small)

      Blank()
        .height(AppSpacing.sm)

      Text(this.work.title)
        .fontSize(AppTypography.title.fontSize)
        .fontWeight(AppTypography.title.fontWeight)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.work.status)
        .fontSize(AppTypography.label.fontSize)
        .fontWeight(AppTypography.label.fontWeight)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline })
  }
}

// Progress Bar Row Component
@Component
struct ProgressBarItem {
  chart: ChartData = new ChartData(0, '', 0);

  build() {
    Column() {
      Row() {
        Row()
          .width(`${this.chart.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)

      Text(`${this.chart.label}: ${Math.floor(this.chart.progress * 100)}%`)
        .fontSize(AppTypography.body.fontSize)
        .fontWeight(AppTypography.body.fontWeight)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
  }
}

// Main Entry
@Entry
@Component
struct RootScreen {
  @State works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending'),
  ];

  @State charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8),
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Homework Submit')
          .fontSize(AppTypography.display.fontSize)
          .fontWeight(AppTypography.display.fontWeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)

      // Main content
      Scroll() {
        Column() {
          // Assignments Section
          Text('Assignments')
            .fontSize(AppTypography.headline.fontSize)
            .fontWeight(AppTypography.headline.fontWeight)
            .fontColor(AppColors.onBackground)
            .width('100%')

          // 2-column grid of homework cards
          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                HomeworkCard({ work: work })
              }
              .aspectRatio(1)
            }, (work: Homework) => work.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .rowsGap(AppSpacing.md)
          .columnsGap(AppSpacing.md)
          .width('100%')
          .margin({ top: AppSpacing.md, bottom: AppSpacing.lg })

          // Progress Chart Section
          Text('Progress Chart')
            .fontSize(AppTypography.headline.fontSize)
            .fontWeight(AppTypography.headline.fontWeight)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Column() {
            ForEach(this.charts, (chart: ChartData) => {
              ProgressBarItem({ chart: chart })
            }, (chart: ChartData) => chart.id.toString())
          }
          .width('100%')
          .margin({ top: AppSpacing.sm })

          // Submit Button
          Button('Submit New HW')
            .width('60%')
            .height(40)
            .fontSize(AppTypography.title.fontSize)
            .fontWeight(AppTypography.title.fontWeight)
            .fontColor(AppColors.onSecondary)
            .backgroundColor(AppColors.secondary)
            .borderRadius(AppShapes.large)
            .margin({ top: AppSpacing.lg })
            .onClick(() => {
              prompt.showToast({ message: 'Submit New HW' });
            })
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [
        ['rgba(14, 165, 233, 0.15)', 0.0],
        ['rgba(99, 102, 241, 0.10)', 1.0],
      ],
    })
  }
}
