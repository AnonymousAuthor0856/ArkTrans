// Index.ets

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

class AppColors {
  primary: string = '#FF0EA5E9';
  secondary: string = '#FF6366F1';
  tertiary: string = '#FF06B6D4';
  background: string = '#FFF1F5F9';
  surface: string = '#FFFFFFFF';
  surfaceVariant: string = '#FFE2E8F0';
  outline: string = '#FFD1D5DB';
  success: string = '#FF10B981';
  warning: string = '#FFF59E0B';
  error: string = '#FFEF4444';
  onPrimary: string = '#FFFFFFFF';
  onSecondary: string = '#FFFFFFFF';
  onTertiary: string = '#FF0F172A';
  onBackground: string = '#FF1E293B';
  onSurface: string = '#FF1E293B';
}

class AppSpacing {
  xs: number = 2;
  sm: number = 6;
  md: number = 10;
  lg: number = 14;
  xl: number = 20;
  xxl: number = 28;
}

class AppTokens {
  static Colors: AppColors = new AppColors();
  static Spacing: AppSpacing = new AppSpacing();
}

@Entry
@Component
struct RootScreen {
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

  build() {
    Column() {
      // Top App Bar
      Text('Homework Submit')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding(16);

      // Main Content Area
      Column() {
        // Assignments Section
        Text('Assignments')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.md });

        // Grid equivalent using Grid Container
        Grid() {
          ForEach(this.works, (w: Homework) => {
            GridItem() {
              Column() {
                // Icon Box
                Column()
                  .width(40)
                  .height(40)
                  .backgroundColor(AppTokens.Colors.tertiary)
                  .borderRadius(6)
                  .margin({ bottom: AppTokens.Spacing.sm });

                Text(w.title)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .textAlign(TextAlign.Center);

                Text(w.status)
                  .fontSize(11)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)
                  .margin({ top: AppTokens.Spacing.xs });
              }
              .width('100%')
              .height('100%')
              .padding(AppTokens.Spacing.md)
              .justifyContent(FlexAlign.Center)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(10)
              .border({ width: 1, color: AppTokens.Colors.outline });
            }
          });
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.md)
        .columnsGap(AppTokens.Spacing.md)
        .height(280)
        .margin({ bottom: AppTokens.Spacing.lg });

        // Progress Chart Section
        Text('Progress Chart')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onBackground)
          .margin({ bottom: AppTokens.Spacing.md });

        // List equivalent
        Column() {
          ForEach(this.charts, (c: ChartData) => {
            Column() {
              Row() {
                // Progress Bar Fill
                Column()
                  .width(`${c.progress * 100}%`)
                  .height('100%')
                  .backgroundColor(AppTokens.Colors.primary)
                  .borderRadius(6);
              }
              .width('100%')
              .height(24)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(6);

              Text(`${c.label}: ${Math.round(c.progress * 100)}%`)
                .fontSize(12)
                .fontColor(AppTokens.Colors.onSurface)
                .margin({ top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.sm });
            }
          });
        }
        .margin({ bottom: AppTokens.Spacing.lg });

        // Submit Button
        Button('Submit New HW')
          .type(ButtonType.Capsule)
          .width('60%')
          .height(40)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.secondary)
          .fontColor(AppTokens.Colors.onSecondary);
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppTokens.Spacing.lg)
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background);
  }
}