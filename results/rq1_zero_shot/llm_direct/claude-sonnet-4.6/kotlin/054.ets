import { curves } from '@kit.ArkUI';

// Token definitions
namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#0EA5E9';
    export const secondary: string = '#6366F1';
    export const tertiary: string = '#06B6D4';
    export const background: string = '#F1F5F9';
    export const surface: string = '#FFFFFF';
    export const surfaceVariant: string = '#E2E8F0';
    export const outline: string = '#D1D5DB';
    export const success: string = '#10B981';
    export const warning: string = '#F59E0B';
    export const error: string = '#EF4444';
    export const onPrimary: string = '#FFFFFF';
    export const onSecondary: string = '#FFFFFF';
    export const onTertiary: string = '#0F172A';
    export const onBackground: string = '#1E293B';
    export const onSurface: string = '#1E293B';
    export const primaryAlpha15: string = '#260EA5E9';
    export const secondaryAlpha10: string = '#1A6366F1';
  }

  export namespace Typography {
    export const displaySize: number = 26;
    export const headlineSize: number = 18;
    export const titleSize: number = 14;
    export const bodySize: number = 12;
    export const labelSize: number = 11;
  }

  export namespace Spacing {
    export const xs: number = 2;
    export const sm: number = 6;
    export const md: number = 10;
    export const lg: number = 14;
    export const xl: number = 20;
    export const xxl: number = 28;
  }

  export namespace Radius {
    export const small: number = 6;
    export const medium: number = 10;
    export const large: number = 14;
  }
}

interface HomeworkItem {
  id: number;
  title: string;
  status: string;
}

interface ChartItem {
  id: number;
  label: string;
  progress: number;
}

@Entry
@Component
struct RootScreen {
  private works: HomeworkItem[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' },
  ];

  @State charts: ChartItem[] = [
    { id: 1, label: 'Week 1', progress: 0.7 },
    { id: 2, label: 'Week 2', progress: 0.9 },
    { id: 3, label: 'Week 3', progress: 0.5 },
    { id: 4, label: 'Week 4', progress: 0.8 },
  ];

  @Builder
  HomeworkCard(item: HomeworkItem) {
    Column({ space: AppTokens.Spacing.sm }) {
      Box()
        .width(40)
        .height(40)
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Radius.small)

      Text(item.title)
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(item.status)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Radius.medium })
  }

  @Builder
  ChartRow(item: ChartItem) {
    Column({ space: 2 }) {
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(24)
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.small)

        Row()
          .width(`${item.progress * 100}%`)
          .height(24)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Radius.small)
      }
      .width('100%')
      .height(24)

      Text(`${item.label}: ${Math.floor(item.progress * 100)}%`)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Homework Submit')
          .fontSize(AppTokens.Typography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(AppTokens.Colors.surface)

      // Main content
      Scroll() {
        Column({ space: AppTokens.Spacing.lg }) {
          // Assignments section title
          Text('Assignments')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // Homework Grid
          Grid() {
            ForEach(this.works, (item: HomeworkItem) => {
              GridItem() {
                this.HomeworkCard(item)
              }
            }, (item: HomeworkItem) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppTokens.Spacing.md)
          .rowsGap(AppTokens.Spacing.md)
          .width('100%')
          .height(280)

          // Progress Chart section title
          Text('Progress Chart')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onBackground)
            .width('100%')

          // Chart rows
          Column({ space: AppTokens.Spacing.sm }) {
            ForEach(this.charts, (item: ChartItem) => {
              this.ChartRow(item)
            }, (item: ChartItem) => item.id.toString())
          }
          .width('100%')

          // Submit Button
          Button('Submit New HW')
            .width('60%')
            .height(40)
            .fontSize(AppTokens.Typography.titleSize)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Radius.large)
            .alignSelf(ItemAlign.Center)

          Blank().height(AppTokens.Spacing.lg)
        }
        .width('100%')
        .padding(AppTokens.Spacing.lg)
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
      .backgroundColor(AppTokens.Colors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}