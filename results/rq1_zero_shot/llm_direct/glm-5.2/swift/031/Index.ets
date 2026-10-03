// index.ets
import { Length, ResourceStr } from '@ohos.arkui';

// MARK: - AppTokens (设计系统令牌)
class AppTokens {
  static Colors = {
    primary: '#020617',
    secondary: '#4ADE80',
    tertiary: '#64748B',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#F1F5F9',
    outline: '#E2E8F0',
    success: '#22C55E',
    warning: '#F59E0B',
    error: '#EF4444',
    onPrimary: '#FFFFFF',
    onSecondary: '#020617',
    onTertiary: '#FFFFFF',
    onBackground: '#020617',
    onSurface: '#020617'
  };

  static TypographyTokens = {
    display: { size: 48, weight: FontWeight.Bold },
    headline: { size: 28, weight: FontWeight.Medium },
    title: { size: 20, weight: FontWeight.Medium },
    body: { size: 16, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes = {
    small: 8,
    medium: 16,
    large: 24
  };

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  };

  static ElevationMapping = {
    level1: { radius: 3, dy: 1, opacity: 0.05, color: '#000000' },
    level2: { radius: 8, dy: 2, opacity: 0.08, color: '#000000' },
    level3: { radius: 12, dy: 4, opacity: 0.10, color: '#000000' }
  };
}

// MARK: - Data Models (数据模型)
class Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;

  constructor(id: number, name: string, detail: string, amount: string, isCredit: boolean) {
    this.id = id;
    this.name = name;
    this.detail = detail;
    this.amount = amount;
    this.isCredit = isCredit;
  }
}

class ControlAction {
  label: string;
  constructor(label: string) {
    this.label = label;
  }
}

class NavItem {
  label: string;
  constructor(label: string) {
    this.label = label;
  }
}

// MARK: - RootScreen View (主屏幕视图)
@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ];

  private controlActions: ControlAction[] = [
    new ControlAction('Send'),
    new ControlAction('Receive'),
    new ControlAction('Add'),
    new ControlAction('More')
  ];

  private navItems: NavItem[] = [
    new NavItem('Home'),
    new NavItem('Cards'),
    new NavItem('Activity'),
    new NavItem('Profile')
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Scaffold background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main Content
      Column() {
        // Top App Bar
        this.TopAppBar()

        // Scrollable Content
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // Total Balance Card
            this.TotalBalanceCard()

            // Control Actions Row
            this.ControlActionsRow()

            // Recent Activity Header
            this.RecentActivityHeader()

            // Transaction List
            ForEach(this.transactions, (transaction: Transaction) => {
              this.TransactionCard(transaction)
            }, (transaction: Transaction) => transaction.id.toString())
          }
          .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ bottom: AppTokens.Spacing.sm })

        // Bottom Navigation Bar
        this.BottomNavigationBar()
      }
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  // MARK: - Subviews (子视图)
  @Builder TopAppBar() {
    Row() {
      Button() {
        Circle({ width: 28, height: 28 })
          .fillColor(AppTokens.Colors.surfaceVariant)
      }
      .backgroundColor(Color.Transparent)

      Blank()

      Text('My Wallet')
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button() {
        Circle({ width: 28, height: 28 })
          .fillColor(AppTokens.Colors.surfaceVariant)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(56)
    .padding({ horizontal: AppTokens.Spacing.md, vertical: AppTokens.Spacing.sm })
  }

  @Builder TotalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .opacity(0.7)

      Blank().height(AppTokens.Spacing.sm)

      Text('$ 1,145.14')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .letterSpacing(-0.5)

      Blank().height(AppTokens.Spacing.xs)

      Row({ space: AppTokens.Spacing.sm }) {
        Circle({ width: 10, height: 10 })
          .fillColor(AppTokens.Colors.secondary)
        Text('+$234.10 today')
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: AppTokens.ElevationMapping.level2.color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }

  @Builder ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {
            // Inner Box
            Column()
              .width(24)
              .height(24)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.small)
          }
          .width(64)
          .height(64)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(32) // CircleShape
          .shadow({
            radius: AppTokens.ElevationMapping.level1.radius,
            color: AppTokens.ElevationMapping.level1.color,
            offsetX: 0,
            offsetY: AppTokens.ElevationMapping.level1.dy
          })
          .padding(0)

          Text(action.label)
            .fontSize(AppTokens.TypographyTokens.label.size)
            .fontWeight(AppTokens.TypographyTokens.label.weight)
            .fontColor(AppTokens.Colors.onBackground)
            .letterSpacing(0.2)
        }
        .layoutWeight(1) // SpaceAround equivalent
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
  }

  @Builder RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onBackground)

      Blank()

      Button('View All') {
        Text('View All')
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.tertiary)
          .letterSpacing(0.2)
      }
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder TransactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      // Icon Box
      Column()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      // Details
      Column() {
        Text(transaction.name)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text(transaction.detail)
          .fontSize(AppTokens.TypographyTokens.label.size)
          .fontWeight(AppTokens.TypographyTokens.label.weight)
          .fontColor(AppTokens.Colors.tertiary)
          .letterSpacing(0.2)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Amount
      Text(transaction.amount)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(FontWeight.Medium)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }

  @Builder BottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) {
            Circle({ width: 24, height: 24 })
              .fillColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            Text(item.label)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary)
              .letterSpacing(0.2)
          }
          .padding({ vertical: AppTokens.Spacing.sm })
          .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent)
          .borderRadius(AppTokens.Shapes.medium)
        }
        .layoutWeight(1)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(80)
    .padding({ horizontal: AppTokens.Spacing.xs })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.ElevationMapping.level3.radius,
      color: AppTokens.ElevationMapping.level3.color,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level3.dy
    })
  }
}