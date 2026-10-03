// Monthly Budget App - ArkTS

// Color utility
function hexToColor(hex: string): ResourceColor {
  return hex as ResourceColor;
}

// Budget item model
interface BudgetItem {
  name: string;
  value: number;
  color: string;
}

// Format currency
function formatCurrency(value: number): string {
  return '$' + value.toLocaleString('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  });
}

// App tokens
class AppTokens {
  static Colors = class {
    static primary: string = '#4A5568';
    static secondary: string = '#718096';
    static tertiary: string = '#A0AEC0';
    static background: string = '#F7FAFC';
    static surface: string = '#FFFFFF';
    static onSurface: string = '#1A202C';
    static onPrimary: string = '#FFFFFF';
  };

  static Gradients = class {
    static gradient1: string[] = ['#63B3ED', '#4299E1'];
    static gradient2: string[] = ['#4FD1C5', '#38B2AC'];
    static gradient3: string[] = ['#667EEA', '#5A67D8'];
    static gradient4: string[] = ['#ED64A6', '#D53F8C'];
    static gradient5: string[] = ['#F6AD55', '#ED8936'];
  };

  static Spacing = class {
    static xs: number = 4;
    static sm: number = 8;
    static md: number = 16;
    static lg: number = 24;
    static xl: number = 32;
    static xxl: number = 48;
  };

  static Shapes = class {
    static large: number = 16;
  };

  static Typography = class {
    static headlineSize: number = 30;
    static titleSize: number = 28;
    static bodySize: number = 22;
    static labelSize: number = 20;
    static numberSize: number = 34;
  };
}

// Pie chart data
const budgetData: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, color: '#4299E1' },
  { name: 'Food', value: 480.50, color: '#38B2AC' },
  { name: 'Transport', value: 210.75, color: '#5A67D8' },
  { name: 'Entertainment', value: 150.00, color: '#D53F8C' },
  { name: 'Utilities', value: 320.00, color: '#ED8936' }
];

// Compute total
function getTotal(): number {
  let total: number = 0;
  for (let i: number = 0; i < budgetData.length; i++) {
    total += budgetData[i].value;
  }
  return total;
}

// Donut chart component
@Component
struct DonutChart {
  private totalValue: number = getTotal();
  private strokeWidth: number = 24;
  private chartSize: number = 300;

  // Compute slice angles (in radians, starting from -PI/2 = top)
  private getSlices(): { startAngle: number; sweepAngle: number; color: string }[] {
    let slices: { startAngle: number; sweepAngle: number; color: string }[] = [];
    let current: number = -Math.PI / 2;
    for (let i: number = 0; i < budgetData.length; i++) {
      let sweep: number = (budgetData[i].value / this.totalValue) * Math.PI * 2;
      slices.push({ startAngle: current, sweepAngle: sweep, color: budgetData[i].color });
      current += sweep;
    }
    return slices;
  }

  build() {
    Stack() {
      // Draw each donut slice
      ForEach(this.getSlices(), (slice: { startAngle: number; sweepAngle: number; color: string }, index: number) => {
        CanvasDraw({
          startAngle: slice.startAngle,
          sweepAngle: slice.sweepAngle,
          color: slice.color,
          size: this.chartSize,
          strokeWidth: this.strokeWidth
        })
      }, (slice: { startAngle: number; sweepAngle: number; color: string }, index: number) => index.toString())

      // Center text
      Column() {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.labelSize)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ bottom: 4 })
        Text(formatCurrency(this.totalValue))
          .fontSize(AppTokens.Typography.titleSize + 4)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
    }
    .width(this.chartSize)
    .height(this.chartSize)
  }
}

// Canvas drawing for each pie slice
@Component
struct CanvasDraw {
  startAngle: number = 0;
  sweepAngle: number = 0;
  color: string = '#000000';
  size: number = 300;
  strokeWidth: number = 24;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  aboutToAppear() {
    this.drawSlice();
  }

  aboutToUpdate() {
    this.drawSlice();
  }

  drawSlice() {
    let ctx: CanvasRenderingContext2D = this.context;
    ctx.clearRect(0, 0, this.size, this.size);

    let centerX: number = this.size / 2;
    let centerY: number = this.size / 2;
    let radius: number = (this.size - this.strokeWidth) / 2;

    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, this.startAngle, this.startAngle + this.sweepAngle);
    ctx.strokeStyle = this.color;
    ctx.lineWidth = this.strokeWidth;
    ctx.lineCap = 'butt';
    ctx.stroke();
  }

  build() {
    Canvas(this.context)
      .width(this.size)
      .height(this.size)
  }
}

// Budget item row
@Component
struct BudgetItemRow {
  item: BudgetItem;

  build() {
    Row() {
      Row() {
        Circle({ width: 28, height: 28 })
          .fill(this.item.color)
          .margin({ right: AppTokens.Spacing.md })
        Text(this.item.name)
          .fontSize(AppTokens.Typography.bodySize + 8)
          .fontColor(AppTokens.Colors.onSurface)
      }

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.bodySize + 14)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .padding({
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md,
      top: AppTokens.Spacing.md + 4,
      bottom: AppTokens.Spacing.md + 4
    })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 6,
      color: '#1A000000',
      offsetX: 0,
      offsetY: 2
    })
  }
}

// Bottom bar item
@Component
struct BottomBarItem {
  text: string;
  active: boolean = false;

  build() {
    Column() {
      Circle({ width: 36, height: 36 })
        .fill(this.active ? (AppTokens.Colors.tertiary as string) : (AppTokens.Colors.tertiary as string))
        .opacity(this.active ? 0.5 : 0.2)
        .margin({ bottom: AppTokens.Spacing.xs })
      Text(this.text)
        .fontSize(AppTokens.Typography.labelSize + 6)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Center)
  }
}

// Main page
@Entry
@Component
struct MonthlyBudgetPage {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Title
        Row() {
          Text('Monthly Budget')
            .fontSize(44)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.lg })

        // Scrollable content
        Scroll() {
          Column() {
            // Donut chart
            Row() {
              DonutChart()
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            // Budget items list
            Column() {
              ForEach(budgetData, (item: BudgetItem, index: number) => {
                BudgetItemRow({ item: item })
                  .margin({ bottom: index < budgetData.length - 1 ? AppTokens.Spacing.md : 0 })
              }, (item: BudgetItem, index: number) => index.toString())
            }
            .width('100%')
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Bottom spacer
            Blank()
              .height(AppTokens.Spacing.xxl + 100)
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')

      // Bottom bar + FAB
      Column() {
        Blank()

        Stack({ alignContent: Alignment.Top }) {
          // Bottom bar
          Row() {
            BottomBarItem({ text: 'Home', active: true })
              .layoutWeight(1)
            BottomBarItem({ text: 'Reports', active: false })
              .layoutWeight(1)
            // Placeholder for FAB
            Column()
              .width(80)
              .layoutWeight(1)
            BottomBarItem({ text: 'Goals', active: false })
              .layoutWeight(1)
            BottomBarItem({ text: 'Settings', active: false })
              .layoutWeight(1)
          }
          .width('100%')
          .height(100)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: 20,
            color: '#1A000000',
            offsetX: 0,
            offsetY: -6
          })
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

          // FAB
          Button() {
            Text('+')
              .fontSize(44)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontWeight(FontWeight.Bold)
          }
          .width(76)
          .height(76)
          .borderRadius(38)
          .backgroundColor(AppTokens.Colors.primary)
          .shadow({
            radius: 10,
            color: '#40000000',
            offsetX: 0,
            offsetY: 4
          })
          .margin({ top: -38 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
