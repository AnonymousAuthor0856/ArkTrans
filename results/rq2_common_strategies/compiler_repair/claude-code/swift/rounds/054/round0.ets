namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF0EA5E9';
    export const secondary: string = '#FF6366F1';
    export const tertiary: string = '#FF06B6D4';
    export const background: string = '#FFF1F5F9';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE2E8F0';
    export const outline: string = '#FFD1D5DB';
    export const success: string = '#FF10B981';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FFFFFFFF';
    export const onTertiary: string = '#FF0F172A';
    export const onBackground: string = '#FF1E293B';
    export const onSurface: string = '#FF1E293B';
  }

  export namespace Shapes {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }

  export namespace Spacing {
    export const xs: number = 2;
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 14;
    export const xl: number = 20;
    export const xxl: number = 28;
  }
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
  homework: Homework;

  build() {
    Column() {
      Column()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.small)

      Text(this.homework.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Text(this.homework.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .aspectRatio(1)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .space(AppTokens.Spacing.sm)
  }
}

@Component
struct ChartProgressBar {
  chartData: ChartData;

  build() {
    Column() {
      Stack({ alignContent: Alignment.CenterStart }) {
        Column()
          .width('100%')
          .height('100%')
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Column()
          .width(`${this.chartData.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .height(24)

      Text(`${this.chartData.label}: ${Math.round(this.chartData.progress * 100)}%`)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .space(0)
  }
}

@Entry
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
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        Row() {
          Text('Homework Submit')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg, left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        Scroll() {
          Column() {
            Text('Assignments')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onBackground)
              .margin({ bottom: AppTokens.Spacing.lg })

            Grid() {
              ForEach(this.works, (w: Homework) => {
                GridItem() {
                  AssignmentCard({ homework: w })
                }
              }, (w: Homework) => w.id)
            }
            .columnsTemplate('1fr 1fr')
            .columnsGap(AppTokens.Spacing.md)
            .rowsGap(AppTokens.Spacing.md)
            .margin({ bottom: AppTokens.Spacing.lg })

            Text('Progress Chart')
              .fontSize(18)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onBackground)
              .margin({ bottom: AppTokens.Spacing.md })

            Column() {
              ForEach(this.charts, (c: ChartData) => {
                ChartProgressBar({ chartData: c })
              }, (c: ChartData) => c.id)
            }
            .width('100%')
            .space(AppTokens.Spacing.sm)
            .alignItems(HorizontalAlign.Start)

            Button('Submit New HW')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSecondary)
              .width('60%')
              .height(40)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.large)
              .margin({ top: AppTokens.Spacing.lg })
              .alignSelf(ItemAlign.Center)
              .onClick(() => {
                console.info('Submit New HW Tapped');
              })
          }
          .width('100%')
          .padding(AppTokens.Spacing.lg)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [['#260EA5E9', 0.0], ['#1A6366F1', 1.0]]
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
