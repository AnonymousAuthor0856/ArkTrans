import { window } from '@kit.ArkUI';

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

  static readonly gradient1: GradientColors = new GradientColors('#63B3ED', '#4299E1');
  static readonly gradient2: GradientColors = new GradientColors('#4FD1C5', '#38B2AC');
  static readonly gradient3: GradientColors = new GradientColors('#667EEA', '#5A67D8');
  static readonly gradient4: GradientColors = new GradientColors('#ED64A6', '#D53F8C');
  static readonly gradient5: GradientColors = new GradientColors('#F6AD55', '#ED8936');
}

class AppTypography {
  static readonly displaySize: number = 36;
  static readonly headlineSize: number = 24;
  static readonly titleSize: number = 18;
  static readonly bodySize: number = 16;
  static readonly labelSize: number = 14;

  static readonly displayWeight: number = 700;
  static readonly headlineWeight: number = 600;
  static readonly titleWeight: number = 500;
  static readonly bodyWeight: number = 400;
  static readonly labelWeight: number = 500;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class AppShapes {
  static readonly small: number = 4;
  static readonly medium: number = 8;
  static readonly large: number = 16;
}

class AppElevation {
  static readonly level1: number = 1;
  static readonly level2: number = 4;
  static readonly level3: number = 8;
}

class AppTokens {
  static readonly Colors = AppColors;
  static readonly Typography = AppTypography;
  static readonly Spacing = AppSpacing;
  static readonly Shapes = AppShapes;
  static readonly Elevation = AppElevation;
}

class GradientColors {
  start: string;
  end: string;

  constructor(start: string, end: string) {
    this.start = start;
    this.end = end;
  }
}

class BudgetItem {
  id: string;
  name: string;
  value: number;
  gradient: GradientColors;

  constructor(name: string, value: number, gradient: GradientColors) {
    this.id = `${name}-${value}`;
    this.name = name;
    this.value = value;
    this.gradient = gradient;
  }
}

function colorWithOpacity(hex: string, opacity: number): string {
  const value = hex.replace('#', '');
  const r = parseInt(value.substring(0, 2), 16);
  const g = parseInt(value.substring(2, 4), 16);
  const b = parseInt(value.substring(4, 6), 16);
  return `rgba(${r}, ${g}, ${b}, ${opacity})`;
}

function formatCurrency(value: number): string {
  const fixed = value.toFixed(2);
  const parts = fixed.split('.');
  let integer = parts[0];
  const decimal = parts[1];

  let result = '';
  while (integer.length > 3) {
    result = `,${integer.slice(-3)}${result}`;
    integer = integer.slice(0, integer.length - 3);
  }
  result = `${integer}${result}`;

  return `$${result}.${decimal}`;
}

@Builder
function EmptyBuilder() {
}

@Entry
@Component
struct BudgetPieApp {
  private budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, AppTokens.Colors.gradient1),
    new BudgetItem('Food', 480.50, AppTokens.Colors.gradient2),
    new BudgetItem('Transport', 210.75, AppTokens.Colors.gradient3),
    new BudgetItem('Entertainment', 150.00, AppTokens.Colors.gradient4),
    new BudgetItem('Utilities', 320.00, AppTokens.Colors.gradient5)
  ];

  aboutToAppear(): void {
    window.getLastWindow(getContext(this)).then((win: window.Window) => {
      win.setWindowLayoutFullScreen(true);
      win.setWindowSystemBarEnable([]);
      win.setWindowBackgroundColor(AppTokens.Colors.background);
    });
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Blank()

          Text('Monthly Budget')
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(AppTokens.Typography.headlineWeight)
            .fontColor(AppTokens.Colors.primary)
            .padding({
              top: AppTokens.Spacing.md,
              bottom: AppTokens.Spacing.md
            })

          Blank()
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.background)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            PieChart({
              items: this.budgetData,
              strokeWidth: 20
            })
              .width(240)
              .height(240)
              .margin({
                top: AppTokens.Spacing.lg,
                bottom: AppTokens.Spacing.lg
              })

            Column({ space: AppTokens.Spacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                CardView() {
                  BudgetItemRow({ item: item })
                }
              }, (item: BudgetItem) => item.id)
            }
            .width('100%')

            Blank()
              .height(AppTokens.Spacing.xxl + 80)
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Blank()

        Stack({ alignContent: Alignment.Top }) {
          Row() {
            BottomBarItem({
              text: 'Home',
              active: true
            })

            Blank()

            BottomBarItem({
              text: 'Reports',
              active: false
            })

            Blank()

            Blank()
              .width(56)

            Blank()

            BottomBarItem({
              text: 'Goals',
              active: false
            })

            Blank()

            BottomBarItem({
              text: 'Settings',
              active: false
            })
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
            color: colorWithOpacity('#000000', 0.1),
            offsetX: 0,
            offsetY: -5
          })

          Button() {
            Stack() {
              Circle()
                .width(56)
                .height(56)
                .fill(AppTokens.Colors.primary)
                .shadow({
                  radius: 4,
                  color: colorWithOpacity('#000000', 0.25),
                  offsetX: 0,
                  offsetY: 4
                })

              Text('+')
                .fontSize(30)
                .fontWeight(AppTokens.Typography.headlineWeight)
                .fontColor(AppTokens.Colors.onPrimary)
                .offset({ y: -2 })
            }
            .width(56)
            .height(56)
          }
          .width(56)
          .height(56)
          .padding(0)
          .backgroundColor(Color.Transparent)
          .buttonStyle(ButtonStyle.Normal)
          .offset({ y: -28 })
        }
        .width('100%')
        .height(80)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

@Component
struct PieChart {
  items: BudgetItem[] = [];
  strokeWidth: number = 20;

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  private totalValue(): number {
    let total = 0;
    this.items.forEach((item: BudgetItem) => {
      total += item.value;
    });
    return total;
  }

  private drawChart(): void {
    const size = 240;
    const center = size / 2;
    const radius = center - this.strokeWidth / 2;
    const total = this.totalValue();

    this.context.clearRect(0, 0, size, size);

    if (total <= 0) {
      return;
    }

    let currentAngle = -Math.PI / 2;

    this.items.forEach((item: BudgetItem) => {
      const sweep = item.value / total * Math.PI * 2;
      const gradient = this.context.createLinearGradient(0, 0, 0, size);
      gradient.addColorStop(0, item.gradient.start);
      gradient.addColorStop(1, item.gradient.end);

      this.context.beginPath();
      this.context.lineWidth = this.strokeWidth;
      this.context.lineCap = 'butt';
      this.context.strokeStyle = gradient;
      this.context.arc(center, center, radius, currentAngle, currentAngle + sweep, false);
      this.context.stroke();

      currentAngle += sweep;
    });
  }

  build() {
    Stack() {
      Canvas(this.context)
        .width(240)
        .height(240)
        .onReady(() => {
          this.drawChart();
        })

      Column() {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.secondary)

        Text(formatCurrency(this.totalValue()))
          .fontSize(AppTokens.Typography.headlineSize)
          .fontWeight(AppTokens.Typography.headlineWeight)
          .fontColor(AppTokens.Colors.primary)
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

@Component
struct CardView {
  @BuilderParam content: () => void = EmptyBuilder;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: 3,
      color: colorWithOpacity('#000000', 0.05),
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BudgetItemRow {
  item: BudgetItem = new BudgetItem('', 0, AppTokens.Colors.gradient1);

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Circle()
          .width(20)
          .height(20)
          .linearGradient({
            angle: 180,
            colors: [
              [this.item.gradient.start, 0],
              [this.item.gradient.end, 1]
            ]
          })

        Text(this.item.name)
          .fontSize(AppTokens.Typography.bodySize)
          .fontWeight(AppTokens.Typography.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
      }

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(AppTokens.Typography.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md,
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md
    })
  }
}

@Component
struct BottomBarItem {
  text: string = '';
  active: boolean = false;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle()
        .width(24)
        .height(24)
        .fill(colorWithOpacity(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary, 0.2))

      Text(this.text)
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
    .alignItems(HorizontalAlign.Center)
  }
}