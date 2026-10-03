// AppTokens.ts
export const AppTokens = {
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
  },
  TypographyTokens: {
    display: { size: 26, weight: 700 }, // bold
    headline: { size: 18, weight: 600 }, // semibold
    title: { size: 14, weight: 500 }, // medium
    body: { size: 12, weight: 400 }, // regular
    label: { size: 11, weight: 500 } // medium
  },
  Shapes: {
    small: 6,
    medium: 10,
    large: 14
  },
  Spacing: {
    xs: 2,
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    xxl: 28
  }
};

// Data Models
export interface Homework {
  id: number;
  title: string;
  status: string;
}

export interface ChartData {
  id: number;
  label: string;
  progress: number;
}

// AssignmentCard.ets
import { AppTokens } from './AppTokens';
import { Homework } from './AppTokens';

@Component
export struct AssignmentCard {
  homework: Homework;

  build() {
    Column() {
      // Icon Box
      Row() {
        Rectangle()
          .fill(AppTokens.Colors.tertiary)
          .width(40)
          .height(40)
          .borderRadius(AppTokens.Shapes.small)
      }
      .justifyContent(FlexAlign.Center)
      
      Spacer()

      Text(this.homework.title)
        .font-size(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
      
      Text(this.homework.status)
        .font-size(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .height('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .aspectRatio(1)
  }
}

// ChartProgressBar.ets
import { AppTokens } from './AppTokens';
import { ChartData } from './AppTokens';

@Component
export struct ChartProgressBar {
  chartData: ChartData;

  build() {
    Column() {
      // Progress Bar Container
      Row() {
        // Filled Part
        Rectangle()
          .fill(AppTokens.Colors.primary)
          .width(`${this.chartData.progress * 100}%`)
          .borderRadius(AppTokens.Shapes.small)
        
        Spacer()
      }
      .width('100%')
      .height(24)
      .backgroundColor(AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)

      // Label
      Text(`${this.chartData.label}: ${Math.round(this.chartData.progress * 100)}%`)
        .font-size(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: 4 }) // Small gap between bar and text
    }
  }
}

// RootScreen.ets (Main Entry)
import { AppTokens } from './AppTokens';
import { Homework, ChartData } from './AppTokens';
import { AssignmentCard } from './AssignmentCard';
import { ChartProgressBar } from './ChartProgressBar';

@Entry
@Component
struct RootScreen {
  // Data initialization
  private works: Homework[] = [
    { id: 1, title: "Linear Algebra HW1", status: "Submitted" },
    { id: 2, title: "Data Structures HW2", status: "Pending" },
    { id: 3, title: "Algorithm HW3", status: "Graded" },
    { id: 4, title: "Probability HW4", status: "Pending" }
  ];

  @State charts: ChartData[] = [
    { id: 1, label: "Week 1", progress: 0.7 },
    { id: 2, label: "Week 2", progress: 0.9 },
    { id: 3, label: "Week 3", progress: 0.5 },
    { id: 4, label: "Week 4", progress: 0.8 }
  ];

  build() {
    Stack() {
      // Background Gradient
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [
            ['rgba(14, 165, 233, 0.15)', 0],
            ['rgba(99, 102, 241, 0.1)', 1]
          ]
        })

      Column() {
        // TopAppBar
        Row() {
          Text("Homework Submit")
            .font-size(AppTokens.TypographyTokens.display.size)
            .fontWeight(AppTokens.TypographyTokens.display.weight)
            .fontColor(AppTokens.Colors.onBackground)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)

        // Main Content Area
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            
            // Assignments Section
            Column() {
              Text("Assignments")
                .font-size(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onBackground)
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: AppTokens.Spacing.md })

              GridContainer() {
                ForEach(this.works, (item: Homework) => {
                  GridItem() {
                    AssignmentCard(homework: item)
                  }
                })
              }
              .columnsTemplate('1fr 1fr')
              .rowsTemplate('auto auto')
              .gap(AppTokens.Spacing.md)
              .width('100%')
            }
            .alignSelf(ItemAlign.Start)

            // Progress Chart Section
            Column({ space: AppTokens.Spacing.sm }) {
              Text("Progress Chart")
                .font-size(AppTokens.TypographyTokens.headline.size)
                .fontWeight(AppTokens.TypographyTokens.headline.weight)
                .fontColor(AppTokens.Colors.onBackground)
                .alignSelf(ItemAlign.Start)

              ForEach(this.charts, (item: ChartData) => {
                ChartProgressBar(chartData: item)
              })
            }
            .alignSelf(ItemAlign.Start)

            // Submit Button
            Button("Submit New HW") {
              console.info("Submit New HW Tapped");
            }
            .width('60%') // Approximate fillMaxWidth(0.6f) relative to padded container
            .height(40)
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onSecondary)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.large)
            .margin({ top: AppTokens.Spacing.lg })
          }
          .padding(AppTokens.Spacing.lg)
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}