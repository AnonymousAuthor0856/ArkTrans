// BudgetPieApp.ets

// MARK: - App Tokens & Colors
interface ColorsType {
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

interface SpacingType {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

interface ShapesType {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static Colors: ColorsType = {
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

  static Spacing: SpacingType = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  };

  static Shapes: ShapesType = {
    small: 4,
    medium: 8,
    large: 16,
  };
}

// MARK: - Models
class BudgetItem {
  name: string;
  value: number;
  gradient: string[];
  
  constructor(name: string, value: number, gradient: string[]) {
    this.name = name;
    this.value = value;
    this.gradient = gradient;
  }
}

// MARK: - Helpers
function formatCurrency(value: number): string {
  return '$' + value.toFixed(2);
}

// MARK: - Main Entry Point
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

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // Top Bar
        Row() {
          Blank()
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Medium)
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
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            // List Items
            Column({ space: AppTokens.Spacing.md }) {
              ForEach(this.budgetData, (item: BudgetItem) => {
                CardView({ item: item })
              })
            }
            
            // Bottom Spacer
            Blank().height(AppTokens.Spacing.xxl + 80)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Bottom App Bar & FAB Overlay
      Stack({ alignContent: Alignment.Top }) {
        Row() {
          BottomBarItem({ text: 'Home', active: true })
          Blank()
          BottomBarItem({ text: 'Reports', active: false })
          Blank()
          // Invisible placeholder for FAB space
          Column().width(56)
          Blank()
          BottomBarItem({ text: 'Goals', active: false })
          Blank()
          BottomBarItem({ text: 'Settings', active: false })
        }
        .width('100%')
        .height(80)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetY: -5 })

        // FAB
        Button() {
          Stack() {
            Circle({ width: 56, height: 56 })
              .fill(AppTokens.Colors.primary)
              .shadow({ radius: 4, offsetY: 4 })
            Text('+')
              .fontSize(28)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTokens.Colors.onPrimary)
          }
        }
        .backgroundColor(Color.Transparent)
        .offset({ y: -28 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

// Pie Chart Component
@Component
struct PieChart {
  items: BudgetItem[] = [];
  strokeWidth: number = 20;
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  
  private getTotalValue(): number {
    let total = 0;
    for (let item of this.items) {
      total += item.value;
    }
    return total;
  }

  build() {
    Stack({ alignContent: Alignment.Center }) {
      // Canvas to draw the pie chart
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .onReady(() => {
          let canvas = this.context;
          let w = canvas.width;
          let h = canvas.height;
          let centerX = w / 2;
          let centerY = h / 2;
          let radius = Math.min(w, h) / 2;

          let totalValue = this.getTotalValue();
          let startAngle = -Math.PI / 2; // -90 degrees

          for (let item of this.items) {
            let sweepAngle = (item.value / totalValue) * Math.PI * 2;
            let endAngle = startAngle + sweepAngle;

            canvas.strokeStyle = item.gradient[0]; 
            canvas.lineWidth = this.strokeWidth;
            canvas.beginPath();
            canvas.arc(centerX, centerY, radius - this.strokeWidth / 2, startAngle, endAngle);
            canvas.stroke();

            startAngle = endAngle;
          }
        })

      // Center Text
      Column() {
        Text('Total Spent')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
        Text(formatCurrency(this.getTotalValue()))
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)
      }
    }
  }
}

// Card View Component
@Component
struct CardView {
  item: BudgetItem = new BudgetItem('', 0, []);
  
  build() {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Circle({ width: 20, height: 20 })
          .fill(this.item.gradient[0])
        Text(this.item.name)
          .fontSize(16)
          .fontColor(AppTokens.Colors.onSurface)
      }

      Blank()

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md, left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
  }
}

// Bottom Bar Item Component
@Component
struct BottomBarItem {
  text: string = '';
  active: boolean = false;
  
  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle({ width: 24, height: 24 })
        .fill(this.active ? '#334A5568' : '#33A0AEC0')
        
      Text(this.text)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
  }
}