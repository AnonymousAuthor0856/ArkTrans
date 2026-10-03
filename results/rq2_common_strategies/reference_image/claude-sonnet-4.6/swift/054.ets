// ============================================================================
//  Index.ets — "Homework Submit" (ArkTS / HarmonyOS ArkUI translation)
//  Drop into:  entry/src/main/ets/pages/Index.ets
// ============================================================================

// ---------------------------------------------------------------------------
//  Design tokens
// ---------------------------------------------------------------------------
class AppColors {
  static readonly primary: string = '#0EA5E9';
  static readonly secondary: string = '#6366F1';
  static readonly tertiary: string = '#06B6D4';
  static readonly background: string = '#F1F5F9';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#D1D5DB';
  static readonly success: string = '#10B981';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#0F172A';
  static readonly onBackground: string = '#1E293B';
  static readonly onSurface: string = '#1E293B';

  // primary @15% over the background, secondary @10%  -> 0x26 / 0x1A ARGB
  static readonly gradientTop: string = '#260EA5E9';
  static readonly gradientBottom: string = '#1A6366F1';
}

class AppType {
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 18;
  static readonly titleSize: number = 14;
  static readonly bodySize: number = 12;
  static readonly labelSize: number = 11;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 6;
  static readonly md: number = 10;
  static readonly lg: number = 14;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
}

// ---------------------------------------------------------------------------
//  Data models
// ---------------------------------------------------------------------------
interface Homework {
  id: number;
  title: string;
  status: string;
}

interface ChartData {
  id: number;
  label: string;
  progress: number; // 0.0 .. 1.0
}

// ---------------------------------------------------------------------------
//  Root screen
// ---------------------------------------------------------------------------
@Entry
@Component
struct Index {
  private works: Homework[] = [
    { id: 1, title: 'Linear Algebra HW1', status: 'Submitted' },
    { id: 2, title: 'Data Structures HW2', status: 'Pending' },
    { id: 3, title: 'Algorithm HW3', status: 'Graded' },
    { id: 4, title: 'Probability HW4', status: 'Pending' }
  ];

  @State charts: ChartData[] = [
    { id: 1, label: 'Week 1', progress: 0.70 },
    { id: 2, label: 'Week 2', progress: 0.90 },
    { id: 3, label: 'Week 3', progress: 0.50 },
    { id: 4, label: 'Week 4', progress: 0.80 }
  ];

  build() {
    Column() {
      // ---------------- Top app bar ----------------
      Row() {
        Text('Homework Submit')
          .fontSize(AppType.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
      .backgroundColor(AppColors.surface)

      // ---------------- Scrollable content ----------------
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Text('Assignments')
            .fontSize(AppType.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)

          // LazyVerticalGrid(GridCells.Fixed(2))
          Grid() {
            ForEach(this.works, (w: Homework) => {
              GridItem() {
                AssignmentCard({ homework: w })
              }
            }, (w: Homework) => w.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.md)
          .rowsGap(AppSpacing.md)
          .width('100%')

          Text('Progress Chart')
            .fontSize(AppType.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onBackground)
            .margin({ top: AppSpacing.sm })

          // LazyColumn -> plain Column
          Column({ space: AppSpacing.sm }) {
            ForEach(this.charts, (c: ChartData) => {
              ChartProgressBar({ chartData: c })
            }, (c: ChartData) => c.id.toString())
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)

          // ---------------- Submit button ----------------
          Row() {
            Button('Submit New HW')
              .fontSize(AppType.titleSize)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSecondary)
              .backgroundColor(AppColors.secondary)
              .borderRadius(AppShapes.large)
              .height(40)
              .width('60%')
              .onClick(() => {
                console.info('Submit New HW Tapped');
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ top: AppSpacing.lg })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding(AppSpacing.lg)
      }
      .scrollBar(BarState.Off)
      .scrollable(ScrollDirection.Vertical)
      .layoutWeight(1)
      .width('100%')
      // Brush.verticalGradient(primary 15% -> secondary 10%)
      .linearGradient({
        angle: 180,
        colors: [[AppColors.gradientTop, 0.0], [AppColors.gradientBottom, 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// ---------------------------------------------------------------------------
//  Assignment card
// ---------------------------------------------------------------------------
@Component
struct AssignmentCard {
  @Prop homework: Homework;

  build() {
    Column({ space: AppSpacing.sm }) {
      // Box(40.dp, tertiary, corner 6)
      Row()
        .width(40)
        .height(40)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.small)

      Blank()

      Text(this.homework.title)
        .fontSize(AppType.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(2)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.homework.status)
        .fontSize(AppType.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .aspectRatio(1)                       // aspectRatio(1f)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .border({ width: 1, color: AppColors.outline })   // border(1.dp, outline, medium)
  }
}

// ---------------------------------------------------------------------------
//  Progress bar row
// ---------------------------------------------------------------------------
@Component
struct ChartProgressBar {
  @Prop chartData: ChartData;

  build() {
    Column() {
      // Track
      Row() {
        // Filled portion
        Row()
          .width(`${this.chartData.progress * 100}%`)
          .height('100%')
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .justifyContent(FlexAlign.Start)

      Text(`${this.chartData.label}: ${Math.round(this.chartData.progress * 100)}%`)
        .fontSize(AppType.bodySize)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
  }
}