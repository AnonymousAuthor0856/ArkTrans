// ArkTS translation of 037.swift (SwiftUI -> ArkUI / HarmonyOS).
// Original: a "Monthly Budget" pie-chart screen with a custom bottom bar and FAB.

// MARK: - Custom Hosting Controller to hide status bar
// NOTE: UIHostingController / UIViewControllerRepresentable are UIKit bridge types with
// no direct ArkUI equivalent. In HarmonyOS the status bar is controlled via
// window.setWindowSystemBarEnable / windowStage properties instead of a hosting controller.

// MARK: - Color Hex helper (maps SwiftUI `extension Color { init(hex:) }`)

function colorFromHex(hex: number): string {
  const r: number = (hex >> 16) & 0xff;
  const g: number = (hex >> 8) & 0xff;
  const b: number = hex & 0xff;
  return '#' + hexPair(r) + hexPair(g) + hexPair(b);
}

function hexPair(v: number): string {
  let s: string = v.toString(16);
  if (s.length < 2) {
    s = '0' + s;
  }
  return s;
}

// MARK: - App Tokens & Colors
// NOTE: SwiftUI's LinearGradient is mapped to AppGradient (ArkUI already has a LinearGradient type).

class AppGradient {
  colors: string[] = [];
  constructor(colors: string[]) {
    this.colors = colors;
  }
}

class Colors {
  readonly primary: string = colorFromHex(0x4A5568);
  readonly secondary: string = colorFromHex(0x718096);
  readonly tertiary: string = colorFromHex(0xA0AEC0);
  readonly background: string = colorFromHex(0xF7FAFC);
  readonly surface: string = colorFromHex(0xFFFFFF);
  readonly surfaceVariant: string = colorFromHex(0xEDF2F7);
  readonly outline: string = colorFromHex(0xE2E8F0);
  readonly success: string = colorFromHex(0x48BB78);
  readonly warning: string = colorFromHex(0xF59E0B);
  readonly error: string = colorFromHex(0xF56565);
  readonly onPrimary: string = colorFromHex(0xFFFFFF);
  readonly onSecondary: string = colorFromHex(0xFFFFFF);
  readonly onTertiary: string = colorFromHex(0x1A202C);
  readonly onBackground: string = colorFromHex(0x1A202C);
  readonly onSurface: string = colorFromHex(0x1A202C);

  // Gradients
  readonly gradient1: AppGradient = new AppGradient([colorFromHex(0x63B3ED), colorFromHex(0x4299E1)]);
  readonly gradient2: AppGradient = new AppGradient([colorFromHex(0x4FD1C5), colorFromHex(0x38B2AC)]);
  readonly gradient3: AppGradient = new AppGradient([colorFromHex(0x667EEA), colorFromHex(0x5A67D8)]);
  readonly gradient4: AppGradient = new AppGradient([colorFromHex(0xED64A6), colorFromHex(0xD53F8C)]);
  readonly gradient5: AppGradient = new AppGradient([colorFromHex(0xF6AD55), colorFromHex(0xED8936)]);
}

class AppFont {
  size: number;
  weight: FontWeight;
  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class Typography {
  // NOTE: SwiftUI .semibold has no exact ArkUI FontWeight; mapped to Bold (closest).
  readonly display: AppFont = new AppFont(36, FontWeight.Bold);
  readonly headline: AppFont = new AppFont(24, FontWeight.Bold);
  readonly title: AppFont = new AppFont(18, FontWeight.Medium);
  readonly body: AppFont = new AppFont(16, FontWeight.Regular);
  readonly label: AppFont = new AppFont(14, FontWeight.Medium);
}

class Spacing {
  readonly xs: number = 4;
  readonly sm: number = 8;
  readonly md: number = 16;
  readonly lg: number = 24;
  readonly xl: number = 32;
  readonly xxl: number = 48;
}

class Shapes {
  readonly small: number = 4;
  readonly medium: number = 8;
  readonly large: number = 16;
}

class Elevation {
  readonly level1: number = 1;
  readonly level2: number = 4;
  readonly level3: number = 8;
}

class AppTokens {
  static readonly Colors = new Colors();
  static readonly Typography = new Typography();
  static readonly Spacing = new Spacing();
  static readonly Shapes = new Shapes();
  static readonly Elevation = new Elevation();
}

// MARK: - Models

class BudgetItem {
  static counter: number = 0;
  id: string;
  name: string;
  value: number;
  gradient: AppGradient;
  constructor(name: string, value: number, gradient: AppGradient) {
    this.id = 'item-' + BudgetItem.counter++;
    this.name = name;
    this.value = value;
    this.gradient = gradient;
  }
}

class SliceData {
  id: string;
  start: number;
  end: number;
  gradient: AppGradient;
  constructor(id: string, start: number, end: number, gradient: AppGradient) {
    this.id = id;
    this.start = start;
    this.end = end;
    this.gradient = gradient;
  }
}

// MARK: - Helpers

function formatCurrency(value: number): string {
  let fixed: string = value.toFixed(2);
  let parts: string[] = fixed.split('.');
  let intPart: string = parts[0];
  let result: string = '';
  while (intPart.length > 3) {
    result = ',' + intPart.substring(intPart.length - 3) + result;
    intPart = intPart.substring(0, intPart.length - 3);
  }
  return '$' + intPart + result + '.' + parts[1];
}

function polarPoint(cx: number, cy: number, r: number, angleDeg: number): number[] {
  let rad: number = angleDeg * Math.PI / 180;
  let x: number = cx + r * Math.cos(rad);
  let y: number = cy + r * Math.sin(rad);
  return [x, y];
}

// MARK: - Components

@Component
struct PieSlice {
  startAngle: number = -90;
  endAngle: number = 0;
  color: string = '#000000';
  strokeWidth: number = 20;

  build() {
    Path()
      .commands(this.buildCommands())
      .stroke(this.color)
      .strokeWidth(this.strokeWidth)
      .strokeLineCap(LineCapStyle.Butt)
      .fillOpacity(0)
  }

  buildCommands(): string {
    let cx: number = 120;
    let cy: number = 120;
    let r: number = 100;
    let p1: number[] = polarPoint(cx, cy, r, this.startAngle);
    let p2: number[] = polarPoint(cx, cy, r, this.endAngle);
    let diff: number = this.endAngle - this.startAngle;
    if (diff < 0) {
      diff = -diff;
    }
    let largeArc: number = diff > 180 ? 1 : 0;
    return 'M ' + p1[0] + ' ' + p1[1] + ' A ' + r + ' ' + r + ' 0 ' + largeArc + ' 1 ' + p2[0] + ' ' + p2[1];
  }
}

@Component
struct PieChart {
  items: BudgetItem[] = [];
  strokeWidth: number = 20;

  build() {
    Stack() {
      ForEach(this.computeSlices(), (slice: SliceData) => {
        PieSlice({ startAngle: slice.start, endAngle: slice.end, color: slice.gradient.colors[0], strokeWidth: this.strokeWidth })
      }, (slice: SliceData) => slice.id)

      Column({ space: 0 }) {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
        Text(formatCurrency(this.totalValue()))
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.primary)
      }
    }
  }

  computeSlices(): SliceData[] {
    let total: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      total += this.items[i].value;
    }
    let currentAngle: number = -90;
    let result: SliceData[] = [];
    for (let i = 0; i < this.items.length; i++) {
      let item: BudgetItem = this.items[i];
      let sweep: number = total > 0 ? (item.value / total) * 360 : 0;
      result.push(new SliceData('slice-' + i, currentAngle, currentAngle + sweep, item.gradient));
      currentAngle += sweep;
    }
    return result;
  }

  totalValue(): number {
    let total: number = 0;
    for (let i = 0; i < this.items.length; i++) {
      total += this.items[i].value;
    }
    return total;
  }
}

@Component
struct CardView {
  @BuilderParam content: () => void = this.emptyContent;

  @Builder
  emptyContent() {
  }

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
  }
}

@Component
struct BudgetItemRow {
  item: BudgetItem = new BudgetItem('', 0, new AppGradient([]));

  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Circle()
          .fill(this.item.gradient.colors[0])
          .width(20)
          .height(20)
        Text(this.item.name)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }
      Blank()
      Text(formatCurrency(this.item.value))
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .padding(AppTokens.Spacing.md)
  }
}

@Component
struct BottomBarItem {
  text: string = '';
  active: boolean = false;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle()
        .fill(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .opacity(0.2)
        .width(24)
        .height(24)
      Text(this.text)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
  }
}

// MARK: - Main Entry Point
// NOTE: SwiftUI `@main struct BudgetPieApp: App` maps to `@Entry @Component` in ArkUI.

@Entry
@Component
struct ContentView {
  // Data
  budgetData: BudgetItem[] = [
    new BudgetItem('Housing', 1250.00, AppTokens.Colors.gradient1),
    new BudgetItem('Food', 480.50, AppTokens.Colors.gradient2),
    new BudgetItem('Transport', 210.75, AppTokens.Colors.gradient3),
    new BudgetItem('Entertainment', 150.00, AppTokens.Colors.gradient4),
    new BudgetItem('Utilities', 320.00, AppTokens.Colors.gradient5)
  ];

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

      // Main content
      Column({ space: 0 }) {
        // Top Bar - starts from the top of the screen
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.primary)
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          Blank()
        }
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
                CardView() {
                  BudgetItemRow({ item: item })
                }
              }, (item: BudgetItem) => item.id)
            }

            // Bottom Spacer for content padding
            Blank().height(AppTokens.Spacing.xxl + 80)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar & FAB Overlay
      Column() {
        Blank()
        Stack({ alignContent: Alignment.Top }) {
          // Bottom Bar Background
          Row() {
            BottomBarItem({ text: 'Home', active: true })
            Blank()
            BottomBarItem({ text: 'Reports', active: false })
            Blank()
            // Invisible placeholder for FAB space
            Blank().width(56)
            Blank()
            BottomBarItem({ text: 'Goals', active: false })
            Blank()
            BottomBarItem({ text: 'Settings', active: false })
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .height(80)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -5 })

          // FAB
          Button({ type: ButtonType.Normal }) {
            Stack() {
              Circle()
                .fill(AppTokens.Colors.primary)
                .width(56)
                .height(56)
                .shadow({ radius: 4, offsetY: 4, color: 'rgba(0,0,0,0.2)' })
              Image($r('sys.media.ohos_ic_public_add'))
                .width(24)
                .height(24)
                .fillColor(AppTokens.Colors.onPrimary)
            }
          }
          .offset({ y: -28 })
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
