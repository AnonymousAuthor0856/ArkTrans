import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens (ArkTS Translation)

interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

export class AppTokens {
  static Colors: ColorTokens = {
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
    onSurface: '#1E293B'
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 26, weight: FontWeight.Bold },
    headline: { size: 18, weight: FontWeight.SemiBold },
    title: { size: 14, weight: FontWeight.Medium },
    body: { size: 12, weight: FontWeight.Regular },
    label: { size: 11, weight: FontWeight.Medium }
  };

  static Shapes: ShapeTokens = {
    small: 6.0,
    medium: 10.0,
    large: 14.0
  };

  static Spacing: SpacingTokens = {
    xs: 2.0,
    sm: 6.0,
    md: 10.0,
    lg: 14.0,
    xl: 20.0,
    xxl: 28.0
  };
}

// MARK: - Data Models

interface Homework {
  id: number;
  title: string;
  status: string;
}

interface ChartData {
  id: number;
  label: string;
  progress: number; // Float equivalent in JS/TS is number
}

// MARK: - AssignmentCard Component

@Component
struct AssignmentCard {
  @Prop homework: Homework;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // Icon Box
      Rect()
        .fill(AppTokens.Colors.tertiary)
        .width(40)
        .height(40)
        .borderRadius(AppTokens.Shapes.small)

      Text(this.homework.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Text(this.homework.status)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium })
    .aspectRatio(1.0)
  }
}

// MARK: - ChartProgressBar Component

@Component
struct ChartProgressBar {
  @Prop chartData: ChartData;

  build() {
    Column() {
      Row() {
        // Progress Bar Background
        Rect()
          .fill(AppTokens.Colors.primary)
          .width(`${this.chartData.progress * 100}%`)
          .borderRadius(AppTokens.Shapes.small)
        
        Blank() // Spacer
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)

      Text(`${this.chartData.label}: ${Math.round(this.chartData.progress * 100)}%`)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
  }
}

// MARK: - RootScreen (Main UI View)

@Entry
@Component
struct RootScreen {
  // Data for assignments
  private works: Homework[] = [
    { id: 1, title: "Linear Algebra HW1", status: "Submitted" },
    { id: 2, title: "Data Structures HW2", status: "Pending" },
    { id: 3, title: "Algorithm HW3", status: "Graded" },
    { id: 4, title: "Probability HW4", status: "Pending" }
  ];

  // Data for charts
  @State charts: ChartData[] = [
    { id: 1, label: "Week 1", progress: 0.7 },
    { id: 2, label: "Week 2", progress: 0.9 },
    { id: 3, label: "Week 3", progress: 0.5 },
    { id: 4, label: "Week 4", progress: 0.8 }
  ];

  build() {
    Stack() {
      // Background Color
      Rect()
        .fill(AppTokens.Colors.background)
        .position({ x: 0, y: 0 })
        .width('100%')
        .height('100%')

      Column() {
        // TopAppBar Equivalent
        Row() {
          Text("Homework Submit")
            .fontSize(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Main Content Area
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            Text("Assignments")
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onBackground)

            // LazyVerticalGrid Equivalent using Grid
            GridContainer() {
              ForEach(this.works, (item: Homework) => {
                GridItem() {
                  AssignmentCard({ homework: item })
                }
              })
            }
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('auto auto')
            .gap({ row: AppTokens.Spacing.md, column: AppTokens.Spacing.md })
            .padding({ bottom: AppTokens.Spacing.lg })

            Text("Progress Chart")
              .fontSize(AppTokens.TypographyTokens.headline.size)
              .fontWeight(AppTokens.TypographyTokens.headline.weight)
              .fontColor(AppTokens.Colors.onBackground)

            // LazyColumn Equivalent
            Column({ space: AppTokens.Spacing.sm }) {
              ForEach(this.charts, (item: ChartData) => {
                ChartProgressBar({ chartData: item })
              })
            }

            // Submit Button
            Button({ type: ButtonType.Capsule, stateEffect: true }) {
              Text("Submit New HW")
                .fontSize(AppTokens.TypographyTokens.title.size)
                .fontWeight(AppTokens.TypographyTokens.title.weight)
                .fontColor(AppTokens.Colors.onSecondary)
            }
            .onClick(() => {
              console.info("Submit New HW Tapped");
            })
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .height(40)
            .width('60%') // fillMaxWidth(0.6f) relative to parent padding
            .margin({ top: AppTokens.Spacing.lg })
          }
          .padding(AppTokens.Spacing.lg)
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(14, 165, 233, 0.15)', 'rgba(14, 165, 233, 0.15)'],
            ['rgba(99, 102, 241, 0.1)', 'rgba(99, 102, 241, 0.1)']
          ]
        })
      }
    }
    .width('100%')
    .height('100%')
    .systemBarProperties({ statusBarColor: AppTokens.Colors.background })
  }
}