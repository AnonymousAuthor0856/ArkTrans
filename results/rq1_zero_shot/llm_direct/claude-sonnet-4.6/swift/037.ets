import { curves } from '@kit.ArkUI';

// MARK: - App Tokens & Colors
namespace AppTokens {
  export namespace Colors {
    export const primary = '#4A5568';
    export const secondary = '#718096';
    export const tertiary = '#A0AEC0';
    export const background = '#F7FAFC';
    export const surface = '#FFFFFF';
    export const surfaceVariant = '#EDF2F7';
    export const outline = '#E2E8F0';
    export const success = '#48BB78';
    export const warning = '#F59E0B';
    export const error = '#F56565';
    export const onPrimary = '#FFFFFF';
    export const onSecondary = '#FFFFFF';
    export const onTertiary = '#1A202C';
    export const onBackground = '#1A202C';
    export const onSurface = '#1A202C';

    export const gradient1: [string, string] = ['#63B3ED', '#4299E1'];
    export const gradient2: [string, string] = ['#4FD1C5', '#38B2AC'];
    export const gradient3: [string, string] = ['#667EEA', '#5A67D8'];
    export const gradient4: [string, string] = ['#ED64A6', '#D53F8C'];
    export const gradient5: [string, string] = ['#F6AD55', '#ED8936'];
  }

  export namespace Spacing {
    export const xs = 4;
    export const sm = 8;
    export const md = 16;
    export const lg = 24;
    export const xl = 32;
    export const xxl = 48;
  }

  export namespace Shapes {
    export const small = 4;
    export const medium = 8;
    export const large = 16;
  }
}

// MARK: - Models
interface BudgetItem {
  id: string;
  name: string;
  value: number;
  gradient: [string, string];
}

// MARK: - Helpers
function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// MARK: - Pie Chart Canvas Component
@Component
struct PieChart {
  @Prop items: BudgetItem[] = [];
  @Prop strokeWidth: number = 20;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  get totalValue(): number {
    return this.items.reduce((sum, item) => sum + item.value, 0);
  }

  drawChart() {
    const ctx = this.context;
    const w = ctx.width;
    const h = ctx.height;
    const cx = w / 2;
    const cy = h / 2;
    const radius = Math.min(w, h) / 2 - this.strokeWidth / 2;

    ctx.clearRect(0, 0, w, h);

    let currentAngle = -Math.PI / 2;
    const total = this.totalValue;

    for (const item of this.items) {
      const sweep = (item.value / total) * 2 * Math.PI;
      const endAngle = currentAngle + sweep;

      const grad = ctx.createLinearGradient(cx, cy - radius, cx, cy + radius);
      grad.addColorStop(0, item.gradient[0]);
      grad.addColorStop(1, item.gradient[1]);

      ctx.beginPath();
      ctx.arc(cx, cy, radius, currentAngle, endAngle);
      ctx.strokeStyle = grad;
      ctx.lineWidth = this.strokeWidth;
      ctx.stroke();

      currentAngle = endAngle;
    }
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawChart();
        })

      Column({ space: 2 }) {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)

        Text(formatCurrency(this.totalValue))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

// MARK: - Budget Item Row
@Component
struct BudgetItemRow {
  @Prop item: BudgetItem = { id: '', name: '', value: 0, gradient: ['#000', '#000'] };

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Column()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [[this.item.gradient[0], 0.0], [this.item.gradient[1], 1.0]]
          })

        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md,
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - Card View
@Component
struct CardView {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 3,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// MARK: - Bottom Bar Item
@Component
struct BottomBarItem {
  @Prop text: string = '';
  @Prop active: boolean = false;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Column()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active
          ? AppTokens.Colors.primary + '33'
          : AppTokens.Colors.tertiary + '33')

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}

// MARK: - Main Content View
@Entry
@Component
struct ContentView {
  private budgetData: BudgetItem[] = [
    { id: '1', name: 'Housing', value: 1250.00, gradient: AppTokens.Colors.gradient1 },
    { id: '2', name: 'Food', value: 480.50, gradient: AppTokens.Colors.gradient2 },
    { id: '3', name: 'Transport', value: 210.75, gradient: AppTokens.Colors.gradient3 },
    { id: '4', name: 'Entertainment', value: 150.00, gradient: AppTokens.Colors.gradient4 },
    { id: '5', name: 'Utilities', value: 320.00, gradient: AppTokens.Colors.gradient5 },
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.primary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          Blank()
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)
        .justifyContent(FlexAlign.Center)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            PieChart({ items: this.budgetData, strokeWidth: 20 })
              .width(240)
              .height(240)
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            Column({ space: AppTokens.Spacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                CardView() {
                  BudgetItemRow({ item: item })
                }
              }, (item: BudgetItem) => item.id)
            }
            .width('100%')

            Column()
              .height(AppTokens.Spacing.xxl + 80)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .alignItems(HorizontalAlign.Center)
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)

      // Bottom Bar + FAB Overlay
      Stack({ alignContent: Alignment.Top }) {
        // Bottom Bar
        Row() {
          BottomBarItem({ text: 'Home', active: true })
          Blank()
          BottomBarItem({ text: 'Reports', active: false })
          Blank()
          Column()
            .width(56)
            .height(1)
            .backgroundColor(Color.Transparent)
          Blank()
          BottomBarItem({ text: 'Goals', active: false })
          Blank()
          BottomBarItem({ text: 'Settings', active: false })
        }
        .width('100%')
        .height(80)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .alignItems(VerticalAlign.Center)
        .shadow({
          radius: 15,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -5
        })

        // FAB
        Button() {
          Text('+')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppTokens.Colors.primary)
        .shadow({
          radius: 4,
          color: '#33000000',
          offsetX: 0,
          offsetY: 4
        })
        .offset({ x: 0, y: -28 })
        .onClick(() => {})
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}