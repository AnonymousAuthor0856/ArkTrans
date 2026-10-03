import { display } from '@kit.ArkUI';

// Color constants
const PRIMARY = '#0EA5E9';
const SECONDARY = '#6366F1';
const TERTIARY = '#06B6D4';
const BACKGROUND = '#F1F5F9';
const SURFACE = '#FFFFFF';
const SURFACE_VARIANT = '#E2E8F0';
const OUTLINE = '#D1D5DB';
const ON_BACKGROUND = '#1E293B';
const ON_SURFACE = '#1E293B';
const ON_SECONDARY = '#FFFFFF';

// Spacing constants
const SPACING_XS = 2;
const SPACING_SM = 6;
const SPACING_MD = 10;
const SPACING_LG = 14;
const SPACING_XL = 20;
const SPACING_XXL = 28;

// Shape constants
const SHAPE_SMALL = 6;
const SHAPE_MEDIUM = 10;
const SHAPE_LARGE = 14;

// Data models
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

@Entry
@Component
struct RootScreen {
  @State private works: Homework[] = [
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

  @Builder
  AssignmentCard(homework: Homework) {
    Column({ space: SPACING_SM }) {
      Row()
        .width(40)
        .height(40)
        .backgroundColor(TERTIARY)
        .borderRadius(SHAPE_SMALL)

      Text(homework.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)

      Text(homework.status)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE)
    }
    .width('100%')
    .height('100%')
    .padding(SPACING_MD)
    .backgroundColor(SURFACE)
    .borderRadius(SHAPE_MEDIUM)
    .border({
      width: 1,
      color: OUTLINE,
      radius: SHAPE_MEDIUM
    })
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ChartProgressBar(chartData: ChartData) {
    Column({ space: 0 }) {
      Stack({ alignContent: Alignment.Start }) {
        Row()
          .width('100%')
          .height(24)
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(SHAPE_SMALL)

        Row()
          .width(`${chartData.progress * 100}%`)
          .height(24)
          .backgroundColor(PRIMARY)
          .borderRadius(SHAPE_SMALL)
      }
      .width('100%')
      .height(24)

      Text(`${chartData.label}: ${Math.floor(chartData.progress * 100)}%`)
        .fontSize(12)
        .fontWeight(FontWeight.Regular)
        .fontColor(ON_SURFACE)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column({ space: 0 }) {
      // Top App Bar
      Row() {
        Text('Homework Submit')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(ON_BACKGROUND)
      }
      .width('100%')
      .padding({
        top: SPACING_LG,
        bottom: SPACING_LG,
        left: SPACING_LG,
        right: SPACING_LG
      })
      .backgroundColor(SURFACE)

      // Main Content Area
      Scroll() {
        Column({ space: SPACING_LG }) {
          Text('Assignments')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(ON_BACKGROUND)

          // Grid of assignment cards
          Grid() {
            ForEach(this.works, (item: Homework) => {
              GridItem() {
                this.AssignmentCard(item)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(SPACING_MD)
          .rowsGap(SPACING_MD)
          .width('100%')

          Text('Progress Chart')
            .fontSize(18)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(ON_BACKGROUND)

          // Chart progress bars
          Column({ space: SPACING_SM }) {
            ForEach(this.charts, (item: ChartData) => {
              this.ChartProgressBar(item)
            })
          }
          .width('100%')

          // Submit Button
          Button('Submit New HW')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(ON_SECONDARY)
            .width('60%')
            .height(40)
            .backgroundColor(SECONDARY)
            .borderRadius(SHAPE_LARGE)
            .margin({ top: SPACING_LG })
            .onClick(() => {
              console.log('Submit New HW Tapped');
            })
        }
        .width('100%')
        .padding(SPACING_LG)
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        angle: 180,
        colors: [[PRIMARY, 0.15], [SECONDARY, 0.1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}