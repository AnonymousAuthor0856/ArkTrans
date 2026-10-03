import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';
import { drawing } from '@kit.ArkGraphics';

// Define color constants matching the design tokens
const COLORS: Record<string, string> = {
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
  startColor: string;
  endColor: string;
}

// Sample data
const BUDGET_DATA: BudgetItem[] = [
  { name: "Housing", value: 1250.00, startColor: COLORS.gradient1Start, endColor: COLORS.gradient1End },
  { name: "Food", value: 480.50, startColor: COLORS.gradient2Start, endColor: COLORS.gradient2End },
  { name: "Transport", value: 210.75, startColor: COLORS.gradient3Start, endColor: COLORS.gradient3End },
  { name: "Entertainment", value: 150.00, startColor: COLORS.gradient4Start, endColor: COLORS.gradient4End },
  { name: "Utilities", value: 320.00, startColor: COLORS.gradient5Start, endColor: COLORS.gradient5End }
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
          .fontWeight(FontWeight.Bold)
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
          PieChartComponent({ totalSpent: this.totalSpent })
            .margin({ top: 24, bottom: 24 })

          // List of Budget Items
          ForEach(BUDGET_DATA, (item: BudgetItem) => {
            BudgetItemCard({ item: item })
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
      BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}

@Component
struct PieChartComponent {
  @Prop totalSpent: number;

  build() {
    Stack() {
      // Canvas for drawing the pie chart
      Canvas()
        .width(240)
        .height(240)
        .onReady((context: CanvasRenderingContext2D, canvas: Canvas) => {
          const centerX = canvas.width / 2;
          const centerY = canvas.height / 2;
          const radius = Math.min(centerX, centerY) - 10; // Leave some padding
          const strokeWidth = 20;
          let startAngle = -Math.PI / 2; // Start from top in radians

          for (let i = 0; i < BUDGET_DATA.length; i++) {
            const item = BUDGET_DATA[i];
            const sweepAngle = (item.value / this.totalSpent) * 2 * Math.PI;
            
            // Create linear gradient for each arc segment
            const gradient = context.createLinearGradient(0, 0, canvas.width, canvas.height);
            gradient.addColorStop(0, item.startColor);
            gradient.addColorStop(1, item.endColor);
            
            context.beginPath();
            context.arc(centerX, centerY, radius, startAngle, startAngle + sweepAngle, false);
            context.lineWidth = strokeWidth;
            context.lineCap = drawing.LineCap.BUTT;
            context.strokeStyle = gradient;
            context.stroke();
            
            startAngle += sweepAngle;
          }
        })

      // Center Text
      Column() {
        Text("Total Spent")
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.5)
          .fontColor(COLORS.secondary)
        
        Text(formatCurrency(this.totalSpent))
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.primary)
          .margin({ top: 4 })
      }
      .alignItems(HorizontalAlign.Center)
    }
    .width(240)
    .height(240)
  }
}

@Component
struct BudgetItemCard {
  @Prop item: BudgetItem;

  build() {
    Row() {
      // Color Indicator Circle
      Row() {
        // Use a simple circle with the start color of the gradient
        Circle()
          .width(20)
          .height(20)
          .fill(this.item.startColor)
      }
      .margin({ right: 16 })

      // Item Name
      Text(this.item.name)
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor(COLORS.onSurface)
        .layoutWeight(1)

      // Item Value
      Text(formatCurrency(this.item.value))
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLORS.onSurface)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 16 })
    .backgroundColor(COLORS.surface)
    .borderRadius(16)
    .shadow({
      radius: 3,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 1
    })
  }
}

@Component
struct BottomNavigationBar {
  build() {
    Row() {
      BottomNavItem({ label: "Home", isActive: true })
      BottomNavItem({ label: "Reports", isActive: false })
      
      // Spacer for FAB
      Blank().width(48)
      
      BottomNavItem({ label: "Goals", isActive: false })
      BottomNavItem({ label: "Settings", isActive: false })
    }
    .width('100%')
    .height(64)
    .backgroundColor(COLORS.surface)
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
    .shadow({
      radius: 15,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: -5
    })
  }
}

@Component
struct BottomNavItem {
  @Prop label: string;
  @Prop isActive: boolean;

  build() {
    Column() {
      // Icon placeholder (circle)
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

// Floating Action Button Component
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
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(COLORS.primary)
    .borderRadius(28)
    .shadow({
      radius: 15,
      color: 'rgba(0, 0, 0, 0.10)',
      offsetX: 0,
      offsetY: 5
    })
    .onClick(() => {
      // Handle add new expense action
    })
  }
}