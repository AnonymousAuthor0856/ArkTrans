// App Tokens & Colors
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
  gradient1: string[];
  gradient2: string[];
  gradient3: string[];
  gradient4: string[];
  gradient5: string[];
}

interface SpacingTokens {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShapeTokens {
  small: number;
  medium: number;
  large: number;
}

const Colors: ColorTokens = {
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
  gradient1: ['#63B3ED', '#4299E1'],
  gradient2: ['#4FD1C5', '#38B2AC'],
  gradient3: ['#667EEA', '#5A67D8'],
  gradient4: ['#ED64A6', '#D53F8C'],
  gradient5: ['#F6AD55', '#ED8936'],
};

const Spacing: SpacingTokens = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
};

const Shapes: ShapeTokens = {
  small: 4,
  medium: 8,
  large: 16,
};

interface BudgetItem {
  id: number;
  name: string;
  value: number;
  gradient: string[];
}

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// Pie Chart Canvas Component
@Component
struct PieChartCanvas {
  @Prop items: BudgetItem[] = [];
  @Prop strokeWidth: number = 20;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawChart() {
    const ctx = this.context;
    const w = ctx.width;
    const h = ctx.height;
    const cx = w / 2;
    const cy = h / 2;
    const radius = Math.min(w, h) / 2 - this.strokeWidth / 2;

    ctx.clearRect(0, 0, w, h);

    const total = this.items.reduce((sum: number, item: BudgetItem) => sum + item.value, 0);
    let currentAngle = -Math.PI / 2;

    for (let i = 0; i < this.items.length; i++) {
      const item = this.items[i];
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
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.drawChart();
      })
  }
}

@Component
struct PieChartView {
  @Prop items: BudgetItem[] = [];
  @Prop strokeWidth: number = 20;

  get totalValue(): number {
    return this.items.reduce((sum: number, item: BudgetItem) => sum + item.value, 0);
  }

  build() {
    Stack() {
      PieChartCanvas({ items: this.items, strokeWidth: this.strokeWidth })
        .width(240)
        .height(240)

      Column({ space: 2 }) {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)

        Text(formatCurrency(this.totalValue))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
    .alignContent(Alignment.Center)
  }
}

@Component
struct BudgetItemRow {
  @Prop item: BudgetItem = { id: 0, name: '', value: 0, gradient: [] };

  build() {
    Row() {
      Row({ space: Spacing.md }) {
        Stack() {
        }
        .width(20)
        .height(20)
        .borderRadius(10)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [
            [this.item.gradient[0], 0.0],
            [this.item.gradient[1], 1.0]
          ]
        })

        Text(this.item.name)
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
    }
    .width('100%')
    .padding({
      top: Spacing.md,
      bottom: Spacing.md,
      left: Spacing.md,
      right: Spacing.md,
    })
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct CardView {
  @BuilderParam content: () => void = this.defaultBuilder;

  @Builder
  defaultBuilder() {
  }

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(Shapes.large)
    .shadow({
      radius: 3,
      color: '#0D000000',
      offsetX: 0,
      offsetY: 1,
    })
  }
}

@Component
struct BottomBarItem {
  @Prop text: string = '';
  @Prop active: boolean = false;

  build() {
    Column({ space: Spacing.xs }) {
      Stack() {
      }
      .width(24)
      .height(24)
      .borderRadius(12)
      .backgroundColor(this.active ? '#334A5568' : '#33A0AEC0')

      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? Colors.primary : Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct ContentView {
  private budgetData: BudgetItem[] = [
    { id: 1, name: 'Housing', value: 1250.00, gradient: Colors.gradient1 },
    { id: 2, name: 'Food', value: 480.50, gradient: Colors.gradient2 },
    { id: 3, name: 'Transport', value: 210.75, gradient: Colors.gradient3 },
    { id: 4, name: 'Entertainment', value: 150.00, gradient: Colors.gradient4 },
    { id: 5, name: 'Utilities', value: 320.00, gradient: Colors.gradient5 },
  ];

  @Builder
  budgetItemBuilder(item: BudgetItem) {
    CardView() {
      BudgetItemRow({ item: item })
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.primary)
            .padding({ top: Spacing.md, bottom: Spacing.md })
          Blank()
        }
        .width('100%')
        .backgroundColor(Colors.background)
        .justifyContent(FlexAlign.Center)

        // Scrollable Content
        Scroll() {
          Column({ space: Spacing.md }) {
            // Pie Chart
            PieChartView({ items: this.budgetData, strokeWidth: 20 })
              .width(240)
              .height(240)
              .margin({ top: Spacing.lg, bottom: Spacing.lg })

            // Budget Items
            Column({ space: Spacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                this.budgetItemBuilder(item)
              }, (item: BudgetItem) => item.id.toString())
            }
            .width('100%')

            // Bottom spacer
            Column() {
            }
            .height(Spacing.xxl + 80)
          }
          .padding({ left: Spacing.lg, right: Spacing.lg })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
        .align(Alignment.Top)
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
          Column() {
          }
          .width(56)
          Blank()
          BottomBarItem({ text: 'Goals', active: false })
          Blank()
          BottomBarItem({ text: 'Settings', active: false })
        }
        .width('100%')
        .height(80)
        .padding({ left: Spacing.lg, right: Spacing.lg })
        .backgroundColor(Colors.surface)
        .shadow({
          radius: 15,
          color: '#1A000000',
          offsetX: 0,
          offsetY: -5,
        })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        // FAB Button
        Button() {
          Text('+')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onPrimary)
        }
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(Colors.primary)
        .shadow({
          radius: 4,
          color: '#33000000',
          offsetX: 0,
          offsetY: 4,
        })
        .offset({ x: 0, y: -28 })
        .onClick(() => {
        })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}