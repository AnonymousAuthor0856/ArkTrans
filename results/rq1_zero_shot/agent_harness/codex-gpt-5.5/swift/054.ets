class AppColors {
  static primary: string = '#0EA5E9';
  static secondary: string = '#6366F1';
  static tertiary: string = '#06B6D4';
  static background: string = '#F1F5F9';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E2E8F0';
  static outline: string = '#D1D5DB';
  static success: string = '#10B981';
  static warning: string = '#F59E0B';
  static error: string = '#EF4444';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#0F172A';
  static onBackground: string = '#1E293B';
  static onSurface: string = '#1E293B';
}

class AppSpacing {
  static xs: number = 2;
  static sm: number = 6;
  static md: number = 10;
  static lg: number = 14;
  static xl: number = 20;
  static xxl: number = 28;
}

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

@Entry
@Component
struct RootScreen {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ];

  @State private charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8)
  ];

  @Builder
  private AssignmentCard(homework: Homework) {
    Column({ space: AppSpacing.sm }) {
      Rect()
        .width(40)
        .height(40)
        .fill(AppColors.tertiary)
        .radius(6)
      Text(homework.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
      Text(homework.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .padding(AppSpacing.md)
    .width('100%')
    .aspectRatio(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private ChartProgressBar(chartData: ChartData) {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Start }) {
        Rect()
          .width('100%')
          .height(24)
          .fill(AppColors.surfaceVariant)
          .radius(6)
        Rect()
          .width(`${chartData.progress * 100}%`)
          .height(24)
          .fill(AppColors.primary)
          .radius(6)
      }
      .width('100%')
      .height(24)

      Text(`${chartData.label}: ${Math.floor(chartData.progress * 100)}%`)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column({ space: 0 }) {
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.surface)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                this.AssignmentCard(work)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .width('100%')
          .padding({ bottom: AppSpacing.lg })

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (chart: ChartData) => {
              this.ChartProgressBar(chart)
            })
          }
          .width('100%')

          Row() {
            Button('Submit New HW')
              .width('60%')
              .height(40)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(14)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ top: AppSpacing.lg })
        }
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#0EA5E926')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
