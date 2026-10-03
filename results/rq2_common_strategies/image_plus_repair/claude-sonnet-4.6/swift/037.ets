// App Tokens
class ColorTokens {
  static primary: string = '#4A5568';
  static secondary: string = '#718096';
  static tertiary: string = '#A0AEC0';
  static background: string = '#F7FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#EDF2F7';
  static outline: string = '#E2E8F0';
  static success: string = '#48BB78';
  static warning: string = '#F59E0B';
  static error: string = '#F56565';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#FFFFFF';
  static onTertiary: string = '#1A202C';
  static onBackground: string = '#1A202C';
  static onSurface: string = '#1A202C';
}

class GradientPair {
  start: string = '';
  end: string = '';
}

class GradientTokens {
  static gradient1: GradientPair = { start: '#63B3ED', end: '#4299E1' } as GradientPair;
  static gradient2: GradientPair = { start: '#4FD1C5', end: '#38B2AC' } as GradientPair;
  static gradient3: GradientPair = { start: '#667EEA', end: '#5A67D8' } as GradientPair;
  static gradient4: GradientPair = { start: '#ED64A6', end: '#D53F8C' } as GradientPair;
  static gradient5: GradientPair = { start: '#F6AD55', end: '#ED8936' } as GradientPair;
}

class SpacingTokens {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 16;
  static lg: number = 24;
  static xl: number = 32;
  static xxl: number = 48;
}

class ShapeTokens {
  static small: number = 4;
  static medium: number = 8;
  static large: number = 16;
}

interface BudgetItem {
  id: number;
  name: string;
  value: number;
  gradientStart: string;
  gradientEnd: string;
}

const budgetData: BudgetItem[] = [
  { id: 1, name: 'Housing', value: 1250.00, gradientStart: GradientTokens.gradient1.start, gradientEnd: GradientTokens.gradient1.end },
  { id: 2, name: 'Food', value: 480.50, gradientStart: GradientTokens.gradient2.start, gradientEnd: GradientTokens.gradient2.end },
  { id: 3, name: 'Transport', value: 210.75, gradientStart: GradientTokens.gradient3.start, gradientEnd: GradientTokens.gradient3.end },
  { id: 4, name: 'Entertainment', value: 150.00, gradientStart: GradientTokens.gradient4.start, gradientEnd: GradientTokens.gradient4.end },
  { id: 5, name: 'Utilities', value: 320.00, gradientStart: GradientTokens.gradient5.start, gradientEnd: GradientTokens.gradient5.end },
];

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

function getTotalValue(): number {
  return budgetData.reduce((sum, item) => sum + item.value, 0);
}

interface SliceData {
  startAngle: number;
  sweepAngle: number;
  gradientStart: string;
  gradientEnd: string;
}

function computeSlices(): SliceData[] {
  const total = getTotalValue();
  let currentAngle = -90;
  const result: SliceData[] = [];
  for (const item of budgetData) {
    const sweep = (item.value / total) * 360;
    const slice: SliceData = {
      startAngle: currentAngle,
      sweepAngle: sweep,
      gradientStart: item.gradientStart,
      gradientEnd: item.gradientEnd,
    };
    result.push(slice);
    currentAngle += sweep;
  }
  return result;
}

@Component
struct PieChartCanvas {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private chartSize: number = 240;
  private strokeWidth: number = 22;

  drawChart() {
    const ctx = this.context;
    ctx.clearRect(0, 0, this.chartSize, this.chartSize);
    const cx = this.chartSize / 2;
    const cy = this.chartSize / 2;
    const radius = (this.chartSize - this.strokeWidth * 2) / 2;
    const slices = computeSlices();

    for (const slice of slices) {
      const startRad = (slice.startAngle * Math.PI) / 180;
      const endRad = ((slice.startAngle + slice.sweepAngle) * Math.PI) / 180;

      const midAngle = slice.startAngle + slice.sweepAngle / 2;
      const midRad = (midAngle * Math.PI) / 180;
      const gx1 = cx + Math.cos(midRad - Math.PI / 2) * radius;
      const gy1 = cy + Math.sin(midRad - Math.PI / 2) * radius;
      const gx2 = cx + Math.cos(midRad + Math.PI / 2) * radius;
      const gy2 = cy + Math.sin(midRad + Math.PI / 2) * radius;

      const gradient = ctx.createLinearGradient(gx1, gy1, gx2, gy2);
      gradient.addColorStop(0, slice.gradientStart);
      gradient.addColorStop(1, slice.gradientEnd);

      ctx.beginPath();
      ctx.arc(cx, cy, radius, startRad, endRad, false);
      ctx.strokeStyle = gradient;
      ctx.lineWidth = this.strokeWidth;
      ctx.lineCap = 'butt';
      ctx.stroke();
    }
  }

  build() {
    Canvas(this.context)
      .width(this.chartSize)
      .height(this.chartSize)
      .onReady(() => {
        this.drawChart();
      })
  }
}

@Component
struct BudgetItemRow {
  item: BudgetItem = budgetData[0];

  build() {
    Row() {
      Row({ space: SpacingTokens.md }) {
        Circle()
          .width(20)
          .height(20)
          .fill(this.item.gradientStart)

        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(ColorTokens.onSurface)
      }

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColorTokens.onSurface)
    }
    .width('100%')
    .padding({
      top: SpacingTokens.md,
      bottom: SpacingTokens.md,
      left: SpacingTokens.md,
      right: SpacingTokens.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct CardView {
  @BuilderParam content: () => void = this.defaultBuilder;

  @Builder
  defaultBuilder() {}

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(ColorTokens.surface)
    .borderRadius(ShapeTokens.large)
    .shadow({
      radius: 3,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BottomBarItem {
  label: string = '';
  active: boolean = false;

  build() {
    Column({ space: SpacingTokens.xs }) {
      Circle()
        .width(24)
        .height(24)
        .fill(this.active ? '#334A5568' : '#33A0AEC0')

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? ColorTokens.primary : ColorTokens.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct ContentView {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(ColorTokens.background)

      // Main content
      Column() {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(ColorTokens.primary)
            .padding({ top: SpacingTokens.md, bottom: SpacingTokens.md })
          Blank()
        }
        .width('100%')
        .backgroundColor(ColorTokens.background)
        .justifyContent(FlexAlign.Center)

        // Scrollable Content
        Scroll() {
          Column({ space: SpacingTokens.md }) {
            // Pie Chart
            Stack() {
              PieChartCanvas()

              Column({ space: 2 }) {
                Text('Total Spent')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(ColorTokens.secondary)

                Text(formatCurrency(getTotalValue()))
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(ColorTokens.primary)
              }
              .alignItems(HorizontalAlign.Center)
            }
            .width(240)
            .height(240)
            .margin({ top: SpacingTokens.lg, bottom: SpacingTokens.lg })

            // Budget Items
            Column({ space: SpacingTokens.md }) {
              ForEach(budgetData, (item: BudgetItem) => {
                CardView() {
                  BudgetItemRow({ item: item })
                }
              }, (item: BudgetItem) => item.id.toString())
            }
            .width('100%')

            // Bottom spacer
            Column()
              .height(SpacingTokens.xxl + 80)
          }
          .padding({ left: SpacingTokens.lg, right: SpacingTokens.lg })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      // Bottom Bar + FAB Overlay
      Stack({ alignContent: Alignment.Top }) {
        // Bottom Bar
        Row() {
          BottomBarItem({ label: 'Home', active: true })
          Blank()
          BottomBarItem({ label: 'Reports', active: false })
          Blank()
          Column().width(56)
          Blank()
          BottomBarItem({ label: 'Goals', active: false })
          Blank()
          BottomBarItem({ label: 'Settings', active: false })
        }
        .width('100%')
        .height(80)
        .padding({ left: SpacingTokens.lg, right: SpacingTokens.lg })
        .backgroundColor(ColorTokens.surface)
        .shadow({
          radius: 15,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -5
        })
        .alignItems(VerticalAlign.Center)

        // FAB
        Stack() {
          Circle()
            .width(56)
            .height(56)
            .fill(ColorTokens.primary)
            .shadow({
              radius: 4,
              color: '#40000000',
              offsetX: 0,
              offsetY: 4
            })

          Text('+')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(ColorTokens.onPrimary)
            .textAlign(TextAlign.Center)
            .margin({ bottom: 2 })
        }
        .width(56)
        .height(56)
        .offset({ y: -28 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}