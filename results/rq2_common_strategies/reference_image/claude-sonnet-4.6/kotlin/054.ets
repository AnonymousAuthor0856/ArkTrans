// Index.ets  —  079_HomeworkSubmit_en / Education Chart / Cold Gradient
const NAME: string = '079_HomeworkSubmit_en';
const UI_TYPE: string = 'Education Chart';
const STYLE_THEME: string = 'Cold Gradient';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppTokens {
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
  // primary.copy(alpha = 0.15f) / secondary.copy(alpha = 0.1f) for the cold vertical gradient
  static readonly primaryFade: string = '#260EA5E9';
  static readonly secondaryFade: string = '#1A6366F1';
  static readonly cardShadow: string = '#14000000';
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

class AppRadius {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppType {
  static readonly display: number = 26;
  static readonly headline: number = 18;
  static readonly title: number = 14;
  static readonly body: number = 12;
  static readonly label: number = 11;
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
struct Index {
  @State works: Homework[] = [
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
  HomeworkCard(item: Homework) {
    Column() {
      Column() {
      }
      .width(40)
      .height(40)
      .backgroundColor(AppTokens.tertiary)
      .borderRadius(AppRadius.small)
      .margin({ bottom: AppSpacing.sm })

      Text(item.title)
        .fontSize(AppType.title)
        .fontWeight(500)
        .fontColor(AppTokens.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)

      Text(item.status)
        .fontSize(AppType.label)
        .fontWeight(500)
        .fontColor(AppTokens.onSurface)
        .margin({ top: AppSpacing.xs })
        .textAlign(TextAlign.Center)
    }
    .layoutWeight(1)
    .aspectRatio(1)
    .padding(AppSpacing.md)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppRadius.medium)
    .border({ width: 1, color: AppTokens.outline })
    .shadow({
      radius: 2,
      color: AppTokens.cardShadow,
      offsetX: 0,
      offsetY: 1
    })
  }

  @Builder
  ProgressRow(item: ChartData) {
    Column() {
      Row() {
        Row() {
        }
        .width((item.progress * 100) + '%')
        .height('100%')
        .backgroundColor(AppTokens.primary)
        .borderRadius(AppRadius.small)
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.surfaceVariant)
      .borderRadius(AppRadius.small)
      .clip(true)
      .margin({ bottom: AppSpacing.sm })

      Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
        .fontSize(AppType.body)
        .fontColor(AppTokens.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // CenterAlignedTopAppBar
      Row() {
        Text('Homework Submit')
          .fontSize(AppType.display)
          .fontWeight(700)
          .fontColor(AppTokens.onBackground)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.surface)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .fontSize(AppType.headline)
            .fontWeight(600)
            .fontColor(AppTokens.onBackground)

          // LazyVerticalGrid(columns = GridCells.Fixed(2))
          Column({ space: AppSpacing.md }) {
            Row({ space: AppSpacing.md }) {
              this.HomeworkCard(this.works[0])
              this.HomeworkCard(this.works[1])
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)

            Row({ space: AppSpacing.md }) {
              this.HomeworkCard(this.works[2])
              this.HomeworkCard(this.works[3])
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
          }
          .width('100%')

          Text('Progress Chart')
            .fontSize(AppType.headline)
            .fontWeight(600)
            .fontColor(AppTokens.onBackground)

          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (item: ChartData) => {
              this.ProgressRow(item)
            }, (item: ChartData) => item.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          Button('Submit New HW')
            .type(ButtonType.Normal)
            .fontSize(AppType.title)
            .fontWeight(500)
            .fontColor(AppTokens.onSecondary)
            .backgroundColor(AppTokens.secondary)
            .height(40)
            .width('60%')
            .borderRadius(AppRadius.large)
            .margin({ top: AppSpacing.xs })
        }
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Start)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .linearGradient({
        angle: 180,
        colors: [[AppTokens.primaryFade, 0.0], [AppTokens.secondaryFade, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}