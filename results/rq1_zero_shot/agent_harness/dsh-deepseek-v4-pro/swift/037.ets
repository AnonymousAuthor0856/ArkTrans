// 037.ets - translated from 037.swift (Monthly Budget / Pie Chart)

// MARK: - AppTokens & Colors

const CLEAR: string = '#00000000';

class AppTokensColors {
  static readonly primary: string = '#4A5568';
  static readonly secondary: string = '#718096';
  static readonly tertiary: string = '#A0AEC0';
  static readonly background: string = '#F7FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDF2F7';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#48BB78';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#F56565';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#1A202C';
  static readonly onBackground: string = '#1A202C';
  static readonly onSurface: string = '#1A202C';
}

class AppTokensTypography {
  static readonly displaySize: number = 36;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 24;
  static readonly headlineWeight: FontWeight = FontWeight.Semibold;
  static readonly titleSize: number = 18;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 16;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 14;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppTokensSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class AppTokensShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

class AppTokensElevation {
  static readonly level1: number = 1;
  static readonly level2: number = 4;
  static readonly level3: number = 8;
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly Typography = AppTokensTypography;
  static readonly Spacing = AppTokensSpacing;
  static readonly Shapes = AppTokensShapes;
  static readonly Elevation = AppTokensElevation;
}

// MARK: - Helpers

function formatCurrency(value: number): string {
  const abs = Math.abs(value);
  const rounded = abs.toFixed(2);
  const dot = rounded.indexOf('.');
  let intPart = dot >= 0 ? rounded.substring(0, dot) : rounded;
  const decPart = dot >= 0 ? rounded.substring(dot) : '.00';
  let withCommas = '';
  while (intPart.length > 3) {
    withCommas = ',' + intPart.substring(intPart.length - 3) + withCommas;
    intPart = intPart.substring(0, intPart.length - 3);
  }
  withCommas = intPart + withCommas;
  return (value < 0 ? '-' : '') + '$' + withCommas + decPart;
}

// MARK: - Models

class BudgetItem {
  id: string;
  name: string;
  value: number;
  gradientStart: string;
  gradientEnd: string;

  constructor(id: string, name: string, value: number, gradientStart: string, gradientEnd: string) {
    this.id = id;
    this.name = name;
    this.value = value;
    this.gradientStart = gradientStart;
    this.gradientEnd = gradientEnd;
  }
}

// MARK: - PieChart

@Component
struct PieChart {
  items: BudgetItem[];
  strokeWidth: number;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  totalValue(): number {
    let total = 0;
    for (let i = 0; i < this.items.length; i++) {
      total += this.items[i].value;
    }
    return total;
  }

  draw() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    const cx = w / 2;
    const cy = h / 2;
    const radius = Math.min(w, h) / 2 - this.strokeWidth / 2;
    const total = this.totalValue();
    let current = -Math.PI / 2;
    for (let i = 0; i < this.items.length; i++) {
      const item = this.items[i];
      const sweep = (item.value / total) * Math.PI * 2;
      const start = current;
      const end = current + sweep;
      const grad = this.ctx.createLinearGradient(0, 0, 0, h);
      grad.addColorStop(0, item.gradientStart);
      grad.addColorStop(1, item.gradientEnd);
      this.ctx.strokeStyle = grad;
      this.ctx.lineWidth = this.strokeWidth;
      this.ctx.beginPath();
      this.ctx.arc(cx, cy, radius, start, end);
      this.ctx.stroke();
      current = end;
    }
  }

  build() {
    Stack() {
      Canvas(this.ctx)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.draw();
        })

      Column({ space: 0 }) {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.secondary)
        Text(formatCurrency(this.totalValue()))
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(AppTokens.Typography.headlineWeight)
          .fontColor(AppTokens.Colors.primary)
      }
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - BudgetItemRow

@Component
struct BudgetItemRow {
  item: BudgetItem;

  build() {
    Row({ space: 0 }) {
      Row({ space: AppTokens.Spacing.md }) {
        Column()
          .width(20)
          .height(20)
          .linearGradient({ angle: 180, colors: [[this.item.gradientStart, 0.0], [this.item.gradientEnd, 1.0]] })
          .borderRadius(10)

        Text(this.item.name)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(AppTokens.Typography.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .alignItems(VerticalAlign.Center)
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
  }
}

// MARK: - CardView

@Component
struct CardView {
  item: BudgetItem;

  build() {
    Column() {
      BudgetItemRow({ item: this.item })
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
  }
}

// MARK: - BottomBarItem

@Component
struct BottomBarItem {
  text: string;
  active: boolean;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Column()
        .width(24)
        .height(24)
        .backgroundColor(this.active ? 'rgba(74,85,104,0.2)' : 'rgba(160,174,192,0.2)')
        .borderRadius(12)

      Text(this.text)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
  }
}

// MARK: - ContentView (Root View)

@Component
struct ContentView {
  private budgetData: BudgetItem[] = [
    new BudgetItem('1', 'Housing', 1250.00, '#63B3ED', '#4299E1'),
    new BudgetItem('2', 'Food', 480.50, '#4FD1C5', '#38B2AC'),
    new BudgetItem('3', 'Transport', 210.75, '#667EEA', '#5A67D8'),
    new BudgetItem('4', 'Entertainment', 150.00, '#ED64A6', '#D53F8C'),
    new BudgetItem('5', 'Utilities', 320.00, '#F6AD55', '#ED8936')
  ];

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(AppTokens.Typography.headlineWeight)
            .fontColor(AppTokens.Colors.primary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          Blank()
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            PieChart({ items: this.budgetData, strokeWidth: 20 })
              .width(240)
              .height(240)
              .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            // List Items
            Column({ space: AppTokens.Spacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                CardView({ item: item })
              }, (item: BudgetItem) => item.id)
            }

            // Bottom Spacer
            Row().height(AppTokens.Spacing.xxl + 80)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar & FAB Overlay
      Column() {
        Blank()
        Stack({ alignContent: Alignment.Top }) {
          // Bottom Bar Background
          Row({ space: 0 }) {
            BottomBarItem({ text: 'Home', active: true })
            Blank()
            BottomBarItem({ text: 'Reports', active: false })
            Blank()
            Column()
              .width(56)
              .height(56)
              .backgroundColor(CLEAR)
            Blank()
            BottomBarItem({ text: 'Goals', active: false })
            Blank()
            BottomBarItem({ text: 'Settings', active: false })
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .height(80)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -5 })

          // FAB
          Button() {
            Stack() {
              Column()
                .width(56)
                .height(56)
                .backgroundColor(AppTokens.Colors.primary)
                .borderRadius(28)
                .shadow({ radius: 4, color: 'rgba(0,0,0,0.33)', offsetX: 0, offsetY: 4 })

              Text('+')
                .fontSize(24)
                .fontWeight(FontWeight.Semibold)
                .fontColor(AppTokens.Colors.onPrimary)
            }
            .width(56)
            .height(56)
          }
          .type(ButtonType.Normal)
          .backgroundColor(CLEAR)
          .offset({ y: -28 })
          .onClick(() => {})
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Main Entry Point

@Entry
@Component
struct Index {
  build() {
    ContentView()
  }
}
