/**
 * Monthly Budget — Cold Gradient (Finance)
 * ArkTS / HarmonyOS ArkUI  ·  single-file conversion of the Compose source
 * File name convention: Index.ets  (EntryAbility loads pages/Index)
 */

// ---------------------------------------------------------------------------
// Design tokens
// ---------------------------------------------------------------------------

class AppColors {
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

  /** Bottom-bar icon discs: 20% alpha versions of primary / tertiary. */
  static readonly primaryDisc: string = '#334A5568';
  static readonly tertiaryDisc: string = '#33A0AEC0';
}

class FontSize {
  static readonly display: number = 36;
  static readonly headline: number = 24;
  static readonly title: number = 18;
  static readonly body: number = 16;
  static readonly label: number = 14;
}

class Spacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class Radius {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

/** ShadowSpec(radius, dy, opacity) from the elevation table. */
class ShadowSpec {
  radius: number;
  offsetY: number;
  opacity: number;

  constructor(radius: number, offsetY: number, opacity: number) {
    this.radius = radius;
    this.offsetY = offsetY;
    this.opacity = opacity;
  }

  get color(): string {
    const alpha: number = Math.round(this.opacity * 255);
    const hex: string = alpha.toString(16).padStart(2, '0').toUpperCase();
    return '#' + hex + '000000';
  }
}

class Elevation {
  static readonly level1: ShadowSpec = new ShadowSpec(3, 1, 0.05);
  static readonly level2: ShadowSpec = new ShadowSpec(6, 2, 0.07);
  static readonly level3: ShadowSpec = new ShadowSpec(15, 5, 0.10);
}

// ---------------------------------------------------------------------------
// Model + data
// ---------------------------------------------------------------------------

class BudgetItem {
  name: string;
  value: number;
  colorStart: string;
  colorEnd: string;

  constructor(name: string, value: number, colorStart: string, colorEnd: string) {
    this.name = name;
    this.value = value;
    this.colorStart = colorStart;
    this.colorEnd = colorEnd;
  }
}

const BUDGET_DATA: BudgetItem[] = [
  new BudgetItem('Housing', 1250.00, '#63B3ED', '#4299E1'),   // gradient1
  new BudgetItem('Food', 480.50, '#4FD1C5', '#38B2AC'),       // gradient2
  new BudgetItem('Transport', 210.75, '#667EEA', '#5A67D8'),  // gradient3
  new BudgetItem('Entertainment', 150.00, '#ED64A6', '#D53F8C'), // gradient4
  new BudgetItem('Utilities', 320.00, '#F6AD55', '#ED8936')   // gradient5
];

function totalBudget(): number {
  let sum: number = 0;
  for (let i = 0; i < BUDGET_DATA.length; i++) {
    sum += BUDGET_DATA[i].value;
  }
  return sum;
}

/** Replaces java.text.NumberFormat.getCurrencyInstance(Locale.US). */
function formatCurrency(value: number): string {
  const negative: boolean = value < 0;
  const fixed: string = Math.abs(value).toFixed(2);
  const dot: number = fixed.indexOf('.');
  const intPart: string = fixed.substring(0, dot);
  const decPart: string = fixed.substring(dot + 1);

  let grouped: string = '';
  for (let i = 0; i < intPart.length; i++) {
    const remaining: number = intPart.length - i;
    grouped += intPart.charAt(i);
    if (remaining > 1 && (remaining - 1) % 3 === 0) {
      grouped += ',';
    }
  }
  return (negative ? '-$' : '$') + grouped + '.' + decPart;
}

// ---------------------------------------------------------------------------
// Donut chart
// ---------------------------------------------------------------------------

@Component
struct PieChartView {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  private chartSize: number = 240;
  private strokeWidth: number = 20;

  private drawChart(): void {
    const ctx: CanvasRenderingContext2D = this.ctx;
    const size: number = this.chartSize;
    const stroke: number = this.strokeWidth;
    const radius: number = (size - stroke) / 2;
    const cx: number = size / 2;
    const cy: number = size / 2;
    const total: number = totalBudget();

    ctx.clearRect(0, 0, size, size);
    ctx.lineCap = 'butt';
    ctx.lineWidth = stroke;

    let startAngle: number = -Math.PI / 2;
    for (let i = 0; i < BUDGET_DATA.length; i++) {
      const item: BudgetItem = BUDGET_DATA[i];
      const sweep: number = (item.value / total) * Math.PI * 2;

      const gradient: CanvasGradient = ctx.createLinearGradient(0, cy - radius, 0, cy + radius);
      gradient.addColorStop(0, item.colorStart);
      gradient.addColorStop(1, item.colorEnd);

      ctx.beginPath();
      ctx.strokeStyle = gradient;
      ctx.arc(cx, cy, radius, startAngle, startAngle + sweep);
      ctx.stroke();

      startAngle += sweep;
    }
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Canvas(this.ctx)
        .width(this.chartSize)
        .height(this.chartSize)
        .onReady(() => {
          this.drawChart();
        })

      Column({ space: 2 }) {
        Text('Total Spent')
          .fontSize(FontSize.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
        Text(formatCurrency(totalBudget()))
          .fontSize(FontSize.headline)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width(this.chartSize)
    .height(this.chartSize)
  }
}

// ---------------------------------------------------------------------------
// Budget row card
// ---------------------------------------------------------------------------

@Component
struct BudgetRow {
  @Prop name: string;
  @Prop amount: number;
  @Prop colorStart: string;
  @Prop colorEnd: string;

  build() {
    Row() {
      Row({ space: Spacing.md }) {
        Row()
          .width(20)
          .height(20)
          .borderRadius(10)
          .linearGradient({
            angle: 180,
            colors: [[this.colorStart, 0.0], [this.colorEnd, 1.0]]
          })

        Text(this.name)
          .fontSize(FontSize.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(VerticalAlign.Center)

      Text(formatCurrency(this.amount))
        .fontSize(FontSize.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .padding({
      top: Spacing.md,
      bottom: Spacing.md,
      left: Spacing.md,
      right: Spacing.md
    })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(Radius.large)
    .shadow({
      radius: Elevation.level1.radius,
      color: Elevation.level1.color,
      offsetX: 0,
      offsetY: Elevation.level1.offsetY
    })
  }
}

// ---------------------------------------------------------------------------
// Chrome: top bar, FAB, bottom bar
// ---------------------------------------------------------------------------

@Component
struct AddFab {
  build() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Text('+')
        .fontSize(FontSize.headline + 4)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
    }
    .width(56)
    .height(56)
    .backgroundColor(AppColors.primary)
    .shadow({
      radius: Elevation.level3.radius,
      color: Elevation.level3.color,
      offsetX: 0,
      offsetY: Elevation.level3.offsetY
    })
    .margin({ right: Spacing.lg, bottom: Spacing.lg })
    .onClick(() => {
      // Add new expense
    })
  }
}

@Component
struct BottomBarItem {
  @Prop label: string;
  @Prop active: boolean;

  build() {
    Column({ space: Spacing.xs }) {
      Row()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(this.active ? AppColors.primaryDisc : AppColors.tertiaryDisc)

      Text(this.label)
        .fontSize(FontSize.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? AppColors.primary : AppColors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}

@Component
struct AppBottomBar {
  build() {
    Row() {
      BottomBarItem({ label: 'Home', active: true })
      BottomBarItem({ label: 'Reports', active: false })
      Blank().width(Spacing.xl)
      BottomBarItem({ label: 'Goals', active: false })
      BottomBarItem({ label: 'Settings', active: false })
    }
    .width('100%')
    .height(72)
    .padding({ left: Spacing.sm, right: Spacing.sm })
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: Elevation.level3.radius,
      color: Elevation.level3.color,
      offsetX: 0,
      offsetY: -2
    })
  }
}

@Component
struct AppTopBar {
  build() {
    Row() {
      Text('Monthly Budget')
        .fontSize(FontSize.headline)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }
}

// ---------------------------------------------------------------------------
// Root screen
// ---------------------------------------------------------------------------

@Entry
@Component
struct Index {
  build() {
    Column() {
      AppTopBar()

      Stack({ alignContent: Alignment.BottomEnd }) {
        List({ space: Spacing.md }) {
          ListItem() {
            Row() {
              PieChartView()
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .padding({ top: Spacing.md, bottom: Spacing.md })
          }

          ForEach(BUDGET_DATA, (item: BudgetItem) => {
            ListItem() {
              BudgetRow({
                name: item.name,
                amount: item.value,
                colorStart: item.colorStart,
                colorEnd: item.colorEnd
              })
            }
          }, (item: BudgetItem) => item.name)

          ListItem() {
            Row().width('100%').height(Spacing.xxl)
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg })
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)

        AddFab()
      }
      .width('100%')
      .layoutWeight(1)

      AppBottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}