import { BusinessError } from '@kit.BasicServicesKit';
import { common, window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

// Define color constants matching the design tokens
const COLORS = {
  primary: '#4A5568',
  secondary: '#718096',
  tertiary: '#A0AEC0',
  background: '#F7FAFC',
  surface: '#FFFFFF',
  onPrimary: '#FFFFFF',
  onSurface: '#1A202C',
  gradient1Start: '#63B3ED',
  gradient1End: '#4299E1',
  gradient2Start: '#4FD1C5',
  gradient2End: '#38B2AC',
  gradient3Start: '#667EEA',
  gradient3End: '#5A67D8',
  gradient4Start: '#ED64A6',
  gradient4End: '#D53F8C',
  gradient5Start: '#F6AD55',
  gradient5End: '#ED8936'
};

// Data model for budget items
interface BudgetItem {
  name: string;
  value: number;
  startColor: ResourceColor;
  endColor: ResourceColor;
}

// Sample data
const BUDGET_DATA: BudgetItem[] = [
  { name: "Housing", value: 1250.00, startColor: $r('app.color.gradient1Start'), endColor: $r('app.color.gradient1End') },
  { name: "Food", value: 480.50, startColor: $r('app.color.gradient2Start'), endColor: $r('app.color.gradient2End') },
  { name: "Transport", value: 210.75, startColor: $r('app.color.gradient3Start'), endColor: $r('app.color.gradient3End') },
  { name: "Entertainment", value: 150.00, startColor: $r('app.color.gradient4Start'), endColor: $r('app.color.gradient4End') },
  { name: "Utilities", value: 320.00, startColor: $r('app.color.gradient5Start'), endColor: $r('app.color.gradient5End') }
];

// Helper function to format currency
function formatCurrency(value: number): string {
  return '$' + value.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
}

@Entry
@Component
struct MonthlyBudgetScreen {
  @State totalSpent: number = BUDGET_DATA.reduce((sum, item) => sum + item.value, 0);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Monthly Budget")
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(COLORS.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(56)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Scroll() {
        Column() {
          // Pie Chart Section
          PieChart({ totalValue: this.totalSpent })
            .width(240)
            .height(240)
            .margin({ top: 24, bottom: 24 })

          // List of Budget Items
          ForEach(BUDGET_DATA, (item: BudgetItem) => {
            BudgetItemCard(item)
              .margin({ bottom: 16 })
          })
          
          // Bottom padding for scroll area
          Blank().height(80)
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}

// Custom Component for the Pie Chart
@Component
struct PieChart {
  @Prop totalValue: number;

  build() {
    Stack() {
      // Canvas for drawing the pie chart
      Canvas(this)
        .width('100%')
        .height('100%')
        .onReady(() => {
          this.drawPieChart();
        })

      // Center Text
      Column() {
        Text("Total Spent")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(COLORS.secondary)
        
        Text(formatCurrency(this.totalValue))
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(COLORS.primary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
    }
  }

  drawPieChart() {
    let ctx = this.getContext().getRenderingContext();
    if (!ctx) {
      return;
    }

    const centerX = 120; // Half of width (240)
    const centerY = 120; // Half of height (240)
    const radius = 100;
    const strokeWidth = 20;
    
    let startAngle = -Math.PI / 2; // Start from top (-90 degrees)

    for (let i = 0; i < BUDGET_DATA.length; i++) {
      const item = BUDGET_DATA[i];
      const sweepAngle = (item.value / this.totalValue) * 2 * Math.PI;

      // Create linear gradient
      const gradient = ctx.createLinearGradient(centerX, centerY - radius, centerX, centerY + radius);
      gradient.addColorStop(0, item.startColor);
      gradient.addColorStop(1, item.endColor);

      ctx.beginPath();
      ctx.arc(centerX, centerY, radius, startAngle, startAngle + sweepAngle);
      ctx.lineWidth = strokeWidth;
      ctx.strokeStyle = gradient;
      ctx.lineCap = 'butt'; // Important for seamless segments
      ctx.stroke();

      startAngle += sweepAngle;
    }
  }
}

// Custom Component for each budget item card
@Component
struct BudgetItemCard {
  private item: BudgetItem;

  constructor(item: BudgetItem) {
    this.item = item;
  }

  build() {
    Row() {
      // Color indicator circle
      Row() {
        // Simulate gradient with a solid color for simplicity in this context
        // In a real app, you might use a custom shape or image
        Circle()
          .width(20)
          .height(20)
          .fill(this.item.startColor)
      }
      
      Text(this.item.name)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLORS.onSurface)
        .margin({ left: 16 })
        .layoutWeight(1)

      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSurface)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor(COLORS.surface)
    .borderRadius(16)
    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
  }
}

// Custom Component for the bottom navigation bar
@Component
struct BottomNavBar {
  build() {
    Row() {
      BottomNavItem("Home", true)
      BottomNavItem("Reports", false)
      Blank().layoutWeight(1) // Spacer
      BottomNavItem("Goals", false)
      BottomNavItem("Settings", false)
    }
    .width('100%')
    .height(60)
    .backgroundColor(COLORS.surface)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetY: 5 })
  }
}

// Custom Component for individual bottom nav items
@Component
struct BottomNavItem {
  private label: string;
  private isActive: boolean;

  constructor(label: string, isActive: boolean) {
    this.label = label;
    this.isActive = isActive;
  }

  build() {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(this.isActive ? COLORS.primary : COLORS.tertiary)
        .opacity(0.2)
      
      Text(this.label)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.5)
        .fontColor(this.isActive ? COLORS.primary : COLORS.tertiary)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}

// Floating Action Button (FAB) - Positioned absolutely over the content
@Component
struct FloatingActionButton {
  build() {
    Column() {
      Text("+")
        .fontSize(36)
        .fontWeight(FontWeight.Bold)
        .fontColor(COLORS.onPrimary)
    }
    .width(56)
    .height(56)
    .backgroundColor(COLORS.primary)
    .borderRadius(28)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .shadow({ radius: 10, color: 'rgba(0,0,0,0.2)', offsetY: 4 })
    .position({ x: 'calc(100% - 72vp)', y: 'calc(100% - 120vp)' }) // Position relative to parent
  }
}

// Note: The FAB is not included in the main stack because its position is complex.
// In a real app, you would add it to the main Column with absolute positioning.
// For this single-file example, we'll add it to the main screen's build method.

// Updated Entry Component to include FAB
@Entry
@Component
struct MonthlyBudgetScreenWithFab {
  @State totalSpent: number = BUDGET_DATA.reduce((sum, item) => sum + item.value, 0);

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text("Monthly Budget")
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(COLORS.primary)
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .height(56)
      .justifyContent(FlexAlign.Center)

      // Main Content Area
      Scroll() {
        Column() {
          // Pie Chart Section
          PieChart({ totalValue: this.totalSpent })
            .width(240)
            .height(240)
            .margin({ top: 24, bottom: 24 })

          // List of Budget Items
          ForEach(BUDGET_DATA, (item: BudgetItem) => {
            BudgetItemCard(item)
              .margin({ bottom: 16 })
          })
          
          // Bottom padding for scroll area
          Blank().height(80)
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
    
    // Add FAB here
    FloatingActionButton()
  }
}