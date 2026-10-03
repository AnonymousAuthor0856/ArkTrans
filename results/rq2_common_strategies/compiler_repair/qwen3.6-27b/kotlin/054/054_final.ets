import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

// Token Definitions
interface AppTokenColors {
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

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

const AppTokens = {
  Colors: {
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
  } as AppTokenColors,
  Spacing: {
    xs: 2,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  } as AppTokenSpacing,
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  } as AppTokenShapes
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

@Entry
@Component
struct RootScreen {
  @State works: Homework[] = [
    { id: 1, title: "Linear Algebra HW1", status: "Submitted" },
    { id: 2, title: "Data Structures HW2", status: "Pending" },
    { id: 3, title: "Algorithm HW3", status: "Graded" },
    { id: 4, title: "Probability HW4", status: "Pending" }
  ]

  @State charts: ChartData[] = [
    { id: 1, label: "Week 1", progress: 0.7 },
    { id: 2, label: "Week 2", progress: 0.9 },
    { id: 3, label: "Week 3", progress: 0.5 },
    { id: 4, label: "Week 4", progress: 0.8 }
  ]

  build() {
    Column() {
      // Top Bar Area (Simulating Scaffold TopBar)
      Row() {
        Text("Homework Submit")
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)

      // Main Content Area
      Column() {
        // Assignments Section
        Text("Assignments")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.lg })

        CustomGridContainer({ works: this.works })
          .width('100%')
          .margin({ top: AppTokens.Spacing.sm })

        // Progress Chart Section
        Text("Progress Chart")
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ top: AppTokens.Spacing.lg })

        List({ space: AppTokens.Spacing.sm }) {
          ForEach(this.charts, (item: ChartData) => {
            ListItem() {
              Column() {
                Row() {
                  Row()
                    .width(`${item.progress * 100}%`)
                    .height(24)
                    .backgroundColor(AppTokens.Colors.primary)
                    .borderRadius(AppTokens.Shapes.small)
                }
                .width('100%')
                .height(24)
                .backgroundColor(AppTokens.Colors.surfaceVariant)
                .borderRadius(AppTokens.Shapes.small)

                Text(`${item.label}: ${Math.round(item.progress * 100)}%`)
                  .fontSize(12)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: 4 })
              }
              .padding(AppTokens.Spacing.sm)
            }
          })
        }
        .width('100%')
        .layoutWeight(1)

        // Button
        Button("Submit New HW")
          .width('60%')
          .height(40)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary)
          .borderRadius(AppTokens.Shapes.large)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .linearGradient({
        angle: 90,
        colors: [
          ['rgba(14, 165, 233, 0.15)', 0],
          ['rgba(99, 102, 241, 0.1)', 1]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CustomGridContainer {
  @Prop works: Homework[] = []

  aboutToAppear(): void {
    // Initialize if needed, though passed via prop usually better in ArkTS components without state for simple display
  }

  build() {
    Grid() {
      ForEach(this.works, (work: Homework) => {
        GridItem() {
          this.HomeworkCard(work)
        }
      })
    }
    .columnsTemplate('1fr 1fr')
    .rowsGap(AppTokens.Spacing.md)
    .columnsGap(AppTokens.Spacing.md)
  }

  @Builder
  HomeworkCard(work: Homework) {
    Column() {
      Row() {
        Circle()
          .width(40)
          .height(40)
          .fill(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Blank().height(AppTokens.Spacing.sm)

      Text(work.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(work.status)
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
  }
}