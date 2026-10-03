const NAME: string = "079_HomeworkSubmit_en";
const UI_TYPE: string = "Education Chart";
const STYLE_THEME: string = "Cold Gradient";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#06B6D4';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';
  static readonly onSecondary: string = '#FFFFFF';
}

class AppSpacing {
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
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
struct MainActivity {
  private works: Homework[] = [
    new Homework(1, 'Linear Algebra HW1', 'Submitted'),
    new Homework(2, 'Data Structures HW2', 'Pending'),
    new Homework(3, 'Algorithm HW3', 'Graded'),
    new Homework(4, 'Probability HW4', 'Pending')
  ];

  @State charts: ChartData[] = [
    new ChartData(1, 'Week 1', 0.7),
    new ChartData(2, 'Week 2', 0.9),
    new ChartData(3, 'Week 3', 0.5),
    new ChartData(4, 'Week 4', 0.8)
  ];

  @Builder
  HomeworkCard(work: Homework) {
    Column() {
      Blank()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(6)

      Text(work.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .margin({ top: AppSpacing.sm })

      Text(work.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .opacity(0.78)
        .margin({ top: 4 })
    }
    .width('100%')
    .aspectRatio(1)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  ProgressRow(chart: ChartData) {
    Column({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Start }) {
        Blank()
          .width('100%')
          .height(24)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(6)
        Blank()
          .width(`${Math.round(chart.progress * 100)}%`)
          .height(24)
          .backgroundColor(AppColors.primary)
          .borderRadius(6)
      }
      .width('100%')
      .height(24)

      Text(`${chart.label}: ${Math.floor(chart.progress * 100)}%`)
        .fontSize(12)
        .fontColor(AppColors.onSurface)
        .width('100%')
    }
    .width('100%')
  }

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(64)
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppColors.background)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                this.HomeworkCard(work)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .width('100%')

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .width('100%')

          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (chart: ChartData) => {
              this.ProgressRow(chart)
            })
          }
          .width('100%')

          Button('Submit New HW')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSecondary)
            .height(40)
            .width('60%')
            .backgroundColor(AppColors.secondary)
            .borderRadius(14)
            .alignSelf(ItemAlign.Center)
        }
        .width('100%')
        .padding(AppSpacing.lg)
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .linearGradient({
        angle: 180,
        colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
      })
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
