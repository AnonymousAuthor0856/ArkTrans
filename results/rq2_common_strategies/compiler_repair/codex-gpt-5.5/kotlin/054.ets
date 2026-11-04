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

class HomeworkColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#06B6D4';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';
}

@Entry
@Component
struct Index {
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

  @Builder
  HomeworkTile(work: Homework) {
    Column() {
      Text('')
        .width(40)
        .height(40)
        .backgroundColor(HomeworkColors.tertiary)
        .borderRadius(6)

      Text(work.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(HomeworkColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .width('100%')
        .margin({ top: 6 })

      Text(work.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(HomeworkColors.onSurface)
        .margin({ top: 4 })
    }
    .width('100%')
    .aspectRatio(1)
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(HomeworkColors.surface)
    .borderRadius(10)
    .border({ width: 1, color: HomeworkColors.outline })
  }

  @Builder
  ChartRow(item: ChartData) {
    Column() {
      Stack({ alignContent: Alignment.Start }) {
        Text('')
          .width('100%')
          .height(24)
          .backgroundColor(HomeworkColors.surfaceVariant)
          .borderRadius(6)
        Text('')
          .width((item.progress * 100).toString() + '%')
          .height(24)
          .backgroundColor(HomeworkColors.primary)
          .borderRadius(6)
      }
      .width('100%')
      .height(24)

      Text(item.label + ': ' + Math.round(item.progress * 100).toString() + '%')
        .fontSize(12)
        .fontColor(HomeworkColors.onSurface)
        .width('100%')
        .margin({ top: 4 })
    }
    .width('100%')
  }

  build() {
    Column() {
      Text('Homework Submit')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(HomeworkColors.onBackground)
        .width('100%')
        .height(56)
        .textAlign(TextAlign.Center)

      Scroll() {
        Column() {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(HomeworkColors.onBackground)
            .width('100%')
            .margin({ bottom: 14 })

          Grid() {
            ForEach(this.works, (work: Homework) => {
              GridItem() {
                this.HomeworkTile(work)
              }
            }, (work: Homework) => work.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(10)
          .rowsGap(10)
          .width('100%')
          .height(330)
          .margin({ bottom: 14 })

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(HomeworkColors.onBackground)
            .width('100%')
            .margin({ bottom: 10 })

          ForEach(this.charts, (item: ChartData) => {
            Column() {
              this.ChartRow(item)
            }
            .margin({ bottom: 8 })
          }, (item: ChartData) => item.id.toString())

          Button('Submit New HW')
            .width('60%')
            .height(40)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(HomeworkColors.onSecondary)
            .backgroundColor(HomeworkColors.secondary)
            .borderRadius(14)
            .alignSelf(ItemAlign.Center)
            .margin({ top: 10, bottom: 24 })
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 14, right: 14 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
    })
    .backgroundColor(HomeworkColors.background)
  }
}
