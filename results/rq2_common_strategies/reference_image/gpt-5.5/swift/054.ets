class AppTokens {
  static readonly primary: ResourceColor = 0xFF0EA5E9;
  static readonly secondary: ResourceColor = 0xFF6366F1;
  static readonly tertiary: ResourceColor = 0xFF06B6D4;
  static readonly background: ResourceColor = 0xFFF1F5F9;
  static readonly surface: ResourceColor = 0xFFFFFFFF;
  static readonly surfaceVariant: ResourceColor = 0xFFE2E8F0;
  static readonly outline: ResourceColor = 0xFFD1D5DB;
  static readonly success: ResourceColor = 0xFF10B981;
  static readonly warning: ResourceColor = 0xFFF59E0B;
  static readonly error: ResourceColor = 0xFFEF4444;
  static readonly onPrimary: ResourceColor = 0xFFFFFFFF;
  static readonly onSecondary: ResourceColor = 0xFFFFFFFF;
  static readonly onTertiary: ResourceColor = 0xFF0F172A;
  static readonly onBackground: ResourceColor = 0xFF1E293B;
  static readonly onSurface: ResourceColor = 0xFF1E293B;

  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;
  static readonly labelSize: number = 11;

  static readonly smallRadius: number = 6;
  static readonly mediumRadius: number = 10;
  static readonly largeRadius: number = 14;

  static readonly xs: number = 2;
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
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

@Component
struct AssignmentCard {
  homework: Homework = new Homework(0, '', '');

  build() {
    Column() {
      Blank()
        .height(10)

      Blank()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.tertiary)
        .borderRadius(AppTokens.smallRadius)

      Blank()
        .layoutWeight(1)

      Text(this.homework.title)
        .fontSize(AppTokens.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Center)
        .width('100%')

      Text(this.homework.status)
        .fontSize(AppTokens.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: AppTokens.sm })
    }
    .width('100%')
    .aspectRatio(1)
    .padding(AppTokens.md)
    .backgroundColor(AppTokens.surface)
    .borderRadius(AppTokens.mediumRadius)
    .border({
      width: 1,
      color: AppTokens.outline,
      radius: AppTokens.mediumRadius
    })
  }
}

@Component
struct ChartProgressBar {
  chartData: ChartData = new ChartData(0, '', 0);

  build() {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Blank()
          .width('100%')
          .height(24)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.smallRadius)

        Blank()
          .width(`${this.chartData.progress * 100}%`)
          .height(24)
          .backgroundColor(AppTokens.primary)
          .borderRadius(AppTokens.smallRadius)
      }
      .width('100%')
      .height(24)
      .clip(true)

      Text(`${this.chartData.label}: ${Math.floor(this.chartData.progress * 100)}%`)
        .fontSize(AppTokens.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.onSurface)
        .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}

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

  build() {
    Column() {
      Row() {
        Text('Homework Submit')
          .fontSize(AppTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.onBackground)
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.surface)

      Scroll() {
        Column({ space: AppTokens.lg }) {
          Text('Assignments')
            .fontSize(AppTokens.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.onBackground)
            .width('100%')

          Column({ space: AppTokens.md }) {
            Row({ space: AppTokens.md }) {
              AssignmentCard({ homework: this.works[0] })
                .layoutWeight(1)

              AssignmentCard({ homework: this.works[1] })
                .layoutWeight(1)
            }
            .width('100%')

            Row({ space: AppTokens.md }) {
              AssignmentCard({ homework: this.works[2] })
                .layoutWeight(1)

              AssignmentCard({ homework: this.works[3] })
                .layoutWeight(1)
            }
            .width('100%')
          }
          .width('100%')
          .margin({ bottom: AppTokens.lg })

          Text('Progress Chart')
            .fontSize(AppTokens.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.onBackground)
            .width('100%')

          Column({ space: AppTokens.sm }) {
            ForEach(this.charts, (item: ChartData) => {
              ChartProgressBar({ chartData: item })
            }, (item: ChartData) => item.id.toString())
          }
          .width('100%')

          Button('Submit New HW')
            .fontSize(AppTokens.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSecondary)
            .backgroundColor(AppTokens.secondary)
            .borderRadius(AppTokens.largeRadius)
            .width('60%')
            .height(40)
            .margin({ top: AppTokens.lg })
        }
        .width('100%')
        .padding(AppTokens.lg)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          [0x260EA5E9, 0.0],
          [0x1A6366F1, 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}