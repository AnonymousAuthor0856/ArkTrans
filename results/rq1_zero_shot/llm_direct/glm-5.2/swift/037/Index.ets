// BudgetPieApp.ets

// MARK: - App Tokens & Colors
class AppTokens {
  static Colors = {
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
    
    // Gradients represented as color arrays
    gradient1: ['#63B3ED', '#4299E1'],
    gradient2: ['#4FD1C5', '#38B2AC'],
    gradient3: ['#667EEA', '#5A67D8'],
    gradient4: ['#ED64A6', '#D53F8C'],
    gradient5: ['#F6AD55', '#ED8936']
  }
  
  static Typography = {
    display: { size: 36, weight: FontWeight.Bold },
    headline: { size: 24, weight: FontWeight.Medium },
    title: { size: 18, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Normal },
    label: { size: 14, weight: FontWeight.Medium }
  }
  
  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  }
  
  static Shapes = {
    small: 4,
    medium: 8,
    large: 16
  }
  
  static Elevation = {
    level1: 1,
    level2: 4,
    level3: 8
  }
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
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top Bar
        Text('Monthly Budget')
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.primary)
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .width('100%')
          .textAlign(TextAlign.Center)
          .backgroundColor(AppTokens.Colors.background)

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Pie Chart
            PieChart({ items: this.budgetData, strokeWidth: 20 })
              .width(240)
              .height(240)
              .margin({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })

            // List Items
            ForEach(this.budgetData, (item: BudgetItem) => {
              CardView({ content: () => this.BudgetItemRow(item) })
            })
            
            // Bottom Spacer
            Column().height(AppTokens.Spacing.xxl + 80)
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // Bottom App Bar & FAB Overlay
      Stack({ alignContent: Alignment.Top }) {
        // Bottom Bar Background
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
              .fontSize(24)
              .fontWeight(FontWeight.Medium)
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

  @Builder
  BudgetItemRow(item: BudgetItem) {
    Row() {
      Row({ space: AppTokens.Spacing.md }) {
        Circle({ width: 20, height: 20 })
          .fill(new LinearGradient({
            colors: item.gradient,
            angle: 180
          }))
        
        Text(item.name)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
      }

      Blank()

      Text(formatCurrency(item.value))
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
    }
    .width('100%')
    .padding({
      top: AppTokens.Spacing.md,
      bottom: AppTokens.Spacing.md,
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md
    })
  }
}

// MARK: - Components

@Component
struct PieChart {
  items: BudgetItem[];
  strokeWidth: number = 20;

  // Compute total value
  private get totalValue(): number {
    return this.items.reduce((sum, item) => sum + item.value, 0);
  }

  build() {
    Stack() {
      // Draw Pie Slices
      ForEach(this.items, (item: BudgetItem, index: number) => {
        PieSlice({
          startAngle: this.getStartAngle(index),
          endAngle: this.getEndAngle(index),
          strokeWidth: this.strokeWidth,
          colors: item.gradient
        })
      })

      // Center Text
      Column() {
        Text('Total Spent')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
        Text(formatCurrency(this.totalValue))
          .fontSize(AppTokens.Typography.headline.size)
          .fontWeight(AppTokens.Typography.headline.weight)
          .fontColor(AppTokens.Colors.primary)
      }
    }
    .width('100%')
    .height('100%')
  }

  private getStartAngle(index: number): number {
    let angle = -90;
    for (let i = 0; i < index; i++) {
      angle += (this.items[i].value / this.totalValue) * 360;
    }
    return angle;
  }

  private getEndAngle(index: number): number {
    let angle = -90;
    for (let i = 0; i <= index; i++) {
      angle += (this.items[i].value / this.totalValue) * 360;
    }
    return angle;
  }
}

@Component
struct PieSlice {
  startAngle: number;
  endAngle: number;
  strokeWidth: number;
  colors: string[];

  build() {
    Shape() {
      Path()
        .commands(this.getArcCommands())
    }
    .width('100%')
    .height('100%')
    .viewPort({ x: 0, y: 0, width: 240, height: 240 })
    .stroke(new LinearGradient({
      colors: this.colors,
      angle: 180
    }))
    .strokeWidth(this.strokeWidth)
    .strokeLineCap(LineCapStyle.Butt)
  }

  private getArcCommands(): string {
    const radius = 120; // Half of 240
    const cx = 120;
    const cy = 120;
    
    const startRad = (this.startAngle * Math.PI) / 180;
    const endRad = (this.endAngle * Math.PI) / 180;
    
    const x1 = cx + radius * Math.cos(startRad);
    const y1 = cy + radius * Math.sin(startRad);
    const x2 = cx + radius * Math.cos(endRad);
    const y2 = cy + radius * Math.sin(endRad);
    
    const largeArcFlag = (this.endAngle - this.startAngle) > 180 ? 1 : 0;
    
    return `M ${x1} ${y1} A ${radius} ${radius} 0 ${largeArcFlag} 1 ${x2} ${y2}`;
  }
}

@Component
struct CardView {
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
  }
}

@Component
struct BottomBarItem {
  text: string;
  active: boolean = false;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle({ width: 24, height: 24 })
        .fill(this.active ? `${AppTokens.Colors.primary}33` : `${AppTokens.Colors.tertiary}33`)
      
      Text(this.text)
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(this.active ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
        .textAlign(TextAlign.Center)
    }
  }
}