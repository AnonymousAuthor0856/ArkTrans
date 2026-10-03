import { drawing } from '@kit.ArkGraphics2D';

// ── tokens ──────────────────────────────────────────────────────────────────

const Colors = {
  primary: '#4A5568',
  secondary: '#718096',
  tertiary: '#A0AEC0',
  background: '#F7FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#EDF2F7',
  outline: '#E2E8F0',
  success: '#48BB78',
  warning: '#F59E0B',
  error: '#F56565',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#1A202C',
  onBackground: '#1A202C',
  onSurface: '#1A202C',

  // gradient pairs [start, end]
  gradient1: ['#63B3ED', '#4299E1'],
  gradient2: ['#4FD1C5', '#38B2AC'],
  gradient3: ['#667EEA', '#5A67D8'],
  gradient4: ['#ED64A6', '#D53F8C'],
  gradient5: ['#F6AD55', '#ED8936'],
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
};

// ── data ────────────────────────────────────────────────────────────────────

interface BudgetItem {
  name: string;
  value: number;
  gradient: string[];
}

const budgetData: BudgetItem[] = [
  { name: 'Housing', value: 1250.00, gradient: Colors.gradient1 },
  { name: 'Food', value: 480.50, gradient: Colors.gradient2 },
  { name: 'Transport', value: 210.75, gradient: Colors.gradient3 },
  { name: 'Entertainment', value: 150.00, gradient: Colors.gradient4 },
  { name: 'Utilities', value: 320.00, gradient: Colors.gradient5 },
];

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// ── PieChart ─────────────────────────────────────────────────────────────────

@Component
struct PieChart {
  @Prop items: BudgetItem[] = [];
  chartSize: number = 240;
  strokeWidth: number = 20;

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(new RenderingContextSettings(true))
        .width(this.chartSize)
        .height(this.chartSize)
        .onReady((ctx: CanvasRenderingContext2D) => {
          this.drawChart(ctx);
        })

      Column({ space: 2 }) {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)

        Text(formatCurrency(this.items.reduce((s, i) => s + i.value, 0)))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(this.chartSize)
    .height(this.chartSize)
  }

  private drawChart(ctx: CanvasRenderingContext2D) {
    const total = this.items.reduce((s, i) => s + i.value, 0);
    const cx = this.chartSize / 2;
    const cy = this.chartSize / 2;
    const radius = (this.chartSize - this.strokeWidth) / 2;
    let startAngle = -Math.PI / 2;

    this.items.forEach((item) => {
      const sweep = (item.value / total) * 2 * Math.PI;
      const endAngle = startAngle + sweep;

      const grad = ctx.createLinearGradient(cx, cy - radius, cx, cy + radius);
      grad.addColorStop(0, item.gradient[0]);
      grad.addColorStop(1, item.gradient[1]);

      ctx.beginPath();
      ctx.arc(cx, cy, radius, startAngle, endAngle);
      ctx.strokeStyle = grad;
      ctx.lineWidth = this.strokeWidth;
      ctx.lineCap = 'butt';
      ctx.stroke();

      startAngle = endAngle;
    });
  }
}

// ── BudgetItemRow ─────────────────────────────────────────────────────────────

@Component
struct BudgetItemRow {
  @Prop item: BudgetItem = { name: '', value: 0, gradient: [] };

  build() {
    Row() {
      Row({ space: Spacing.md }) {
        // colour dot
        Column()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [
              [this.hexToNum(this.item.gradient[0]), 0.0],
              [this.hexToNum(this.item.gradient[1]), 1.0],
            ],
          })

        Text(this.item.name)
          .fontSize(16)
          .fontColor(Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .padding({ vertical: Spacing.md, left: Spacing.md, right: Spacing.md })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  private hexToNum(hex: string): number {
    return parseInt('FF' + hex.replace('#', ''), 16);
  }
}

// ── BottomBarItem ─────────────────────────────────────────────────────────────

@Component
struct BottomBarItem {
  @Prop label: string = '';
  @Prop active: boolean = false;

  build() {
    Column({ space: Spacing.xs }) {
      Column()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active
          ? this.withAlpha(Colors.primary, 0.2)
          : this.withAlpha(Colors.tertiary, 0.2))

      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? Colors.primary : Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }

  private withAlpha(hex: string, alpha: number): string {
    const a = Math.round(alpha * 255).toString(16).padStart(2, '0').toUpperCase();
    return '#' + a + hex.replace('#', '');
  }
}

// ── RootScreen ────────────────────────────────────────────────────────────────

@Entry
@Component
struct RootScreen {
  build() {
    Column() {
      // ── TopBar ──
      Row() {
        Text('Monthly Budget')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)

      // ── Scrollable body ──
      Scroll() {
        Column({ space: Spacing.md }) {
          // Pie chart
          PieChart({ items: budgetData, chartSize: 240, strokeWidth: 20 })
            .margin({ top: Spacing.md, bottom: Spacing.lg })

          // Budget cards
          ForEach(budgetData, (item: BudgetItem) => {
            Column() {
              BudgetItemRow({ item: item })
            }
            .width('100%')
            .borderRadius(16)
            .backgroundColor(Colors.surface)
            .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })
          }, (item: BudgetItem) => item.name)

          // Bottom spacer
          Column().height(Spacing.xxl)
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center)
        .padding({ left: Spacing.lg, right: Spacing.lg })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      // ── BottomBar ──
      Stack({ alignContent: Alignment.BottomEnd }) {
        Row() {
          BottomBarItem({ label: 'Home', active: true })
          BottomBarItem({ label: 'Reports', active: false })

          // spacer for FAB
          Column().width(Spacing.xl)

          BottomBarItem({ label: 'Goals', active: false })
          BottomBarItem({ label: 'Settings', active: false })
        }
        .width('100%')
        .height(64)
        .padding({ left: Spacing.sm, right: Spacing.sm })
        .justifyContent(FlexAlign.SpaceAround)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Colors.surface)
        .shadow({ radius: 15, color: '#1A000000', offsetY: -2 })

        // FAB
        Text('+')
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .shadow({ radius: 6, color: '#12000000', offsetY: 2 })
          .margin({ right: Spacing.lg, bottom: Spacing.xl })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}