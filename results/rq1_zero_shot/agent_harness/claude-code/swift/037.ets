// App Tokens & Colors
class AppTokens {
  static class Colors {
    static readonly primary: string = '#4A5568';
    static readonly secondary: string = '#718096';
    static readonly tertiary: string = '#A0AEC0';
    static readonly background: string = '#F7FAFC';
    static readonly surface: string = '#FFFFFFFF';
    static readonly surfaceVariant: string = '#EDF2F7';
    static readonly outline: string = '#E2E8F0';
    static readonly success: string = '#48BB78';
    static readonly warning: string = '#F59E0B';
    static readonly error: string = '#F56565';
    static readonly onPrimary: string = '#FFFFFFFF';
    static readonly onSecondary: string = '#FFFFFFFF';
    static readonly onTertiary: string = '#1A202C';
    static readonly onBackground: string = '#1A202C';
    static readonly onSurface: string = '#1A202C';
  }

  static class Gradients {
    static readonly gradient1: string[] = ['#63B3ED', '#4299E1'];
    static readonly gradient2: string[] = ['#4FD1C5', '#38B2AC'];
    static readonly gradient3: string[] = ['#667EEA', '#5A67D8'];
    static readonly gradient4: string[] = ['#ED64A6', '#D53F8C'];
    static readonly gradient5: string[] = ['#F6AD55', '#ED8936'];
  }

  static class Typography {
    static readonly displaySize: number = 36;
    static readonly headlineSize: number = 24;
    static readonly titleSize: number = 18;
    static readonly bodySize: number = 16;
    static readonly labelSize: number = 14;
  }

  static class Spacing {
    static readonly xs: number = 4;
    static readonly sm: number = 8;
    static readonly md: number = 16;
    static readonly lg: number = 24;
    static readonly xl: number = 32;
    static readonly xxl: number = 48;
  }

  static class Shapes {
    static readonly small: number = 4;
    static readonly medium: number = 8;
    static readonly large: number = 16;
  }
}

// Budget Item Model
class BudgetItem {
  id: string;
  name: string;
  value: number;
  gradient: string[];

  constructor(name: string, value: number, gradient: string[]) {
    this.id = name;
    this.name = name;
    this.value = value;
    this.gradient = gradient;
  }
}

// Helper: format currency
function formatCurrency(value: number): string {
  return '$' + value.toFixed(2);
}

// Pie Slice Data
interface SliceData {
  startAngle: number;
  endAngle: number;
  gradient: string[];
}

function computeSlices(items: BudgetItem[]): SliceData[] {
  const totalValue = items.reduce((sum, item) => sum + item.value, 0);
  let currentAngle = -90;
  const result: SliceData[] = [];
  for (const item of items) {
    const sweep = (item.value / totalValue) * 360;
    result.push({
      startAngle: currentAngle,
      endAngle: currentAngle + sweep,
      gradient: item.gradient
    });
    currentAngle += sweep;
  }
  return result;
}

// Budget Item Row Component
@Component
struct BudgetItemRow {
  item: BudgetItem;

  build() {
    Row() {
      Row() {
        Circle({ width: 20, height: 20 })
          .fill(this.item.gradient)
        Text(this.item.name)
          .fontSize(AppTokens.Typography.bodySize)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .margin({ right: AppTokens.Spacing.md })

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.titleSize)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md,
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md
    })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 3,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// Bottom Bar Item Component
@Component
struct BottomBarItem {
  text: string;
  active: boolean;

  build() {
    Column() {
      Circle({ width: 24, height: 24 })
        .fill(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .opacity(this.active ? 0.2 : 0.2)
      Text(this.text)
        .fontSize(AppTokens.Typography.labelSize)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// Pie Chart Component
@Component
struct PieChart {
  items: BudgetItem[];
  strokeWidth: number = 20;
  @State totalValue: number = 0;
  @State slices: SliceData[] = [];

  aboutToAppear() {
    this.totalValue = this.items.reduce((sum, item) => sum + item.value, 0);
    this.slices = computeSlices(this.items);
  }

  build() {
    Stack() {
      Canvas(this.drawPie.bind(this))
        .width('100%')
        .height('100%')

      Column() {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.labelSize)
          .fontColor(AppTokens.Colors.secondary)
        Text(formatCurrency(this.totalValue))
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Center)
  }

  drawPie(ctx: CanvasRenderingContext2D) {
    const w = 240;
    const h = 240;
    const centerX = w / 2;
    const centerY = h / 2;
    const radius = (Math.min(w, h) - this.strokeWidth) / 2;

    ctx.lineWidth = this.strokeWidth;
    ctx.lineCap = 'butt';

    for (const slice of this.slices) {
      const startRad = (slice.startAngle * Math.PI) / 180;
      const endRad = (slice.endAngle * Math.PI) / 180;

      const grad = ctx.createLinearGradient(centerX, centerY - radius, centerX, centerY + radius);
      grad.addColorStop(0, slice.gradient[0]);
      grad.addColorStop(1, slice.gradient[1]);

      ctx.beginPath();
      ctx.arc(centerX, centerY, radius, startRad, endRad, false);
      ctx.strokeStyle = grad;
      ctx.stroke();
    }
  }
}

// Main Content View
@Entry
@Component
struct BudgetPieApp {
  @State budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, AppTokens.Gradients.gradient1),
    new BudgetItem('Food', 480.50, AppTokens.Gradients.gradient2),
    new BudgetItem('Transport', 210.75, AppTokens.Gradients.gradient3),
    new BudgetItem('Entertainment', 150.00, AppTokens.Gradients.gradient4),
    new BudgetItem('Utilities', 320.00, AppTokens.Gradients.gradient5)
  ];

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.primary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          Blank()
        }
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column() {
            // Pie Chart
            PieChart({ items: this.budgetData, strokeWidth: 20 })
              .width(240)
              .height(240)
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            // List Items
            Column() {
              ForEach(this.budgetData, (item: BudgetItem) => {
                BudgetItemRow({ item: item })
                  .margin({ bottom: AppTokens.Spacing.md })
              }, (item: BudgetItem) => item.id)
            }
            .width('100%')

            // Bottom spacer
            Blank()
              .height(AppTokens.Spacing.xxl + 80)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar & FAB Overlay
      Column() {
        Blank()

        Stack() {
          // Bottom Bar Background
          Row() {
            BottomBarItem({ text: 'Home', active: true })
            Blank()
            BottomBarItem({ text: 'Reports', active: false })
            Blank()
            // Placeholder for FAB space
            Blank()
              .width(56)
            Blank()
            BottomBarItem({ text: 'Goals', active: false })
            Blank()
            BottomBarItem({ text: 'Settings', active: false })
          }
          .width('100%')
          .height(80)
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: 15,
            color: 'rgba(0, 0, 0, 0.1)',
            offsetX: 0,
            offsetY: -5
          })

          // FAB
          Button() {
            Stack() {
              Circle({ width: 56, height: 56 })
                .fill(AppTokens.Colors.primary)
              Text('+')
                .fontSize(28)
                .fontWeight(FontWeight.SemiBold)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(56)
            .height(56)
            .alignContent(Alignment.Center)
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.Transparent)
          .shadow({ radius: 4, offsetY: 4 })
          .margin({ bottom: 28 })
        }
        .width('100%')
        .alignContent(Alignment.TopCenter)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
