import { BusinessError } from '@kit.BasicServicesKit'

// --- Design Tokens & Constants ---

interface AppColors {
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

interface AppSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface AppShapes {
  small: number;
  medium: number;
  large: number;
}

interface AppTokensConfig {
  Colors: AppColors;
  Spacing: AppSpacing;
  Shapes: AppShapes;
}

const AppTokens: AppTokensConfig = {
  Colors: {
    primary: '#0F172A',
    secondary: '#475569',
    tertiary: '#94A3B8',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#0F172A',
    onBackground: '#0F172A',
    onSurface: '#0F172A'
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  }
}

// --- Data Models ---

interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number; // 0.0 to 1.0
  statusColor: string;
}

interface ChartData {
  label: string;
  value: number; // 0.0 to 1.0
}

// --- Mock Data ---

const PRODUCTIVITY_ITEMS: ProductivityItem[] = [
  { id: 1, title: "Form Batch #A-102", status: "Completed", progress: 1.0, statusColor: AppTokens.Colors.success },
  { id: 2, title: "Invoice Set #B-231", status: "In Progress", progress: 0.75, statusColor: AppTokens.Colors.warning },
  { id: 3, title: "Document Scan #C-456", status: "Pending", progress: 0.1, statusColor: AppTokens.Colors.secondary },
  { id: 4, title: "Form Batch #A-103", status: "Completed", progress: 1.0, statusColor: AppTokens.Colors.success },
  { id: 5, title: "Data Entry #D-789", status: "Failed", progress: 0.4, statusColor: AppTokens.Colors.error }
];

const CHART_DATA: ChartData[] = [
  { label: "Mon", value: 0.6 },
  { label: "Tue", value: 0.8 },
  { label: "Wed", value: 0.5 },
  { label: "Thu", value: 1.0 },
  { label: "Fri", value: 0.7 },
  { label: "Sat", value: 0.4 },
  { label: "Sun", value: 0.2 }
];

const FILTERS: string[] = ["Daily", "Weekly", "Monthly"];

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = "Weekly";

  build() {
    Column() {
      // Top Bar
      Row() {
        // Navigation Icon Placeholder
        Button() {
          Circle({ width: 24, height: 24 })
            .fill(AppTokens.Colors.outline)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Handle back or menu
        })

        Text("Productivity Check")
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .margin({ left: 16, right: 16 })

        // Action Icon Placeholder
        Button() {
          Circle({ width: 24, height: 24 })
            .fill(AppTokens.Colors.outline)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderWidth(0)
        .onClick(() => {
          // Handle actions
        })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(FILTERS, (filter: string) => {
              Button(filter)
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedFilter === filter ? AppTokens.Colors.primary : AppTokens.Colors.surface)
                .borderWidth(1)
                .borderColor(AppTokens.Colors.outline)
                .borderRadius(AppTokens.Shapes.small)
                .margin({ right: 8 })
                .onClick(() => {
                  this.selectedFilter = filter;
                })
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: AppTokens.Spacing.lg })

          // Weekly Throughput Chart Card
          Column() {
            Text("Weekly Throughput")
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .margin({ bottom: AppTokens.Spacing.md })

            // Chart Area
            Column() {
              // Bars
              Row() {
                ForEach(CHART_DATA, (data: ChartData) => {
                  Column() {
                    // Empty space above bar to push it down based on value
                    Blank()
                      .layoutWeight(1 - data.value)
                    
                    // The Bar itself
                    Rect({ width: '60%', height: '100%' })
                      .fill(AppTokens.Colors.primary)
                      .borderRadius({ topLeft: AppTokens.Shapes.small, topRight: AppTokens.Shapes.small })
                  }
                  .layoutWeight(1)
                  .height(150)
                  .justifyContent(FlexAlign.End)
                })
              }
              .width('100%')
              
              // Labels
              Row() {
                ForEach(CHART_DATA, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppTokens.Colors.secondary)
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                })
              }
              .width('100%')
              .margin({ top: AppTokens.Spacing.sm })
            }
            .width('100%')
          }
          .width('100%')
          .padding(AppTokens.Spacing.md)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.large)
          .shadow({ radius: 10, color: '#0000001A', offsetY: 4 }) // Approximation of elevation
          .margin({ bottom: AppTokens.Spacing.lg })

          // Productivity List
          List({ space: AppTokens.Spacing.md }) {
            ForEach(PRODUCTIVITY_ITEMS, (item: ProductivityItem) => {
              ListItem() {
                Column() {
                  // Header: Title and Status
                  Row() {
                    Text(item.title)
                      .fontSize(18)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.onSurface)
                      .layoutWeight(1)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    Row() {
                      Circle({ width: 10, height: 10 })
                        .fill(item.statusColor)
                        .margin({ right: AppTokens.Spacing.sm })
                      
                      Text(item.status)
                        .fontSize(14)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(item.statusColor)
                    }
                    .alignItems(VerticalAlign.Center)
                  }
                  .width('100%')
                  .margin({ bottom: AppTokens.Spacing.md })

                  // Progress Bar
                  Row() {
                    // Custom Progress Indicator
                    Stack({ alignContent: Alignment.Start }) {
                      // Track
                      Rect({ width: '100%', height: 8 })
                        .fill(AppTokens.Colors.surfaceVariant)
                        .borderRadius(4)
                      
                      // Fill
                      Rect({ width: `${Math.round(item.progress * 100)}%`, height: 8 })
                        .fill(item.statusColor)
                        .borderRadius(4)
                    }
                    .layoutWeight(1)
                    .margin({ right: AppTokens.Spacing.sm })

                    Text(`${Math.round(item.progress * 100)}%`)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(AppTokens.Colors.secondary)
                      .textAlign(TextAlign.End)
                      .width(40)
                  }
                  .width('100%')
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .padding(AppTokens.Spacing.md)
                .backgroundColor(AppTokens.Colors.surface)
                .borderRadius(AppTokens.Shapes.medium)
                .border({ width: 1, color: AppTokens.Colors.outline })
              }
            })
          }
          .width('100%')
          .layoutWeight(1)
        }
        .width('100%')
        .padding(AppTokens.Spacing.md)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar / Submit Button
      Column() {
        Button("Submit New Form")
          .type(ButtonType.Normal)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .height(56)
          .width('100%')
          .onClick(() => {
            // Handle submit
          })
      }
      .width('100%')
      .padding(AppTokens.Spacing.md)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 10, color: '#0000001A', offsetY: -4 }) // Shadow upwards for bottom bar feel if needed, or just standard
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}