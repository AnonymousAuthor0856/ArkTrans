// AppTokens (设计系统令牌)
class AppColors {
  primary: string = '#020617';
  secondary: string = '#4ADE80';
  tertiary: string = '#64748B';
  background: string = '#F8FAFC';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#F1F5F9';
  outline: string = '#E2E8F0';
  success: string = '#22C55E';
  warning: string = '#F59E0B';
  error: string = '#EF4444';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#020617';
  onTertiary: string = '#FFFFFF';
  onBackground: string = '#020617';
  onSurface: string = '#020617';
}

class AppTypographyStyle {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class AppTypography {
  display: AppTypographyStyle = new AppTypographyStyle(48, FontWeight.Bold);
  headline: AppTypographyStyle = new AppTypographyStyle(28, FontWeight.Medium);
  title: AppTypographyStyle = new AppTypographyStyle(20, FontWeight.Medium);
  body: AppTypographyStyle = new AppTypographyStyle(16, FontWeight.Regular);
  label: AppTypographyStyle = new AppTypographyStyle(12, FontWeight.Medium);
}

class AppShapes {
  small: number = 8;
  medium: number = 16;
  large: number = 24;
}

class AppSpacing {
  xs: number = 4;
  sm: number = 8;
  md: number = 16;
  lg: number = 24;
  xl: number = 32;
  xxl: number = 48;
}

class AppShadowSpec {
  radius: number;
  dy: number;
  opacity: number;
  color: string;

  constructor(radius: number, dy: number, opacity: number) {
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
    this.color = `rgba(0,0,0,${opacity})`;
  }
}

class AppElevation {
  level1: AppShadowSpec = new AppShadowSpec(3, 1, 0.05);
  level2: AppShadowSpec = new AppShadowSpec(8, 2, 0.08);
  level3: AppShadowSpec = new AppShadowSpec(12, 4, 0.10);
}

class AppTokens {
  static readonly Colors: AppColors = new AppColors();
  static readonly Typography: AppTypography = new AppTypography();
  static readonly Shapes: AppShapes = new AppShapes();
  static readonly Spacing: AppSpacing = new AppSpacing();
  static readonly Elevation: AppElevation = new AppElevation();
}

// Data Models (数据模型)
interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  label: string;
}

interface NavItem {
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State private selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true },
  ];

  private controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' },
  ];

  private navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' },
  ];

  build() {
    Stack() {
      Column() {
        // 顶部栏
        this.TopAppBar();

        // 主要内容区域
        Scroll() {
          Column({ space: AppTokens.Spacing.lg }) {
            // 总余额卡片
            this.TotalBalanceCard();

            // 控制操作按钮行
            this.ControlActionsRow();

            // 最近活动标题
            this.RecentActivityHeader();

            // 交易列表
            ForEach(this.transactions, (transaction: Transaction) => {
              this.TransactionCard(transaction);
            }, (transaction: Transaction) => transaction.id.toString());
          }
          .padding({
            left: AppTokens.Spacing.md,
            right: AppTokens.Spacing.md,
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
          .width('100%');
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ bottom: AppTokens.Spacing.sm });

        // 底部导航栏
        this.BottomNavigationBar();
      }
      .width('100%')
      .height('100%');
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%');
  }

  @Builder
  TopAppBar() {
    Row() {
      Button() {}
      .width(28)
      .height(28)
      .borderRadius(14)
      .backgroundColor(AppTokens.Colors.surfaceVariant);

      Blank();

      Text('My Wallet')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onBackground);

      Blank();

      Button() {}
      .width(28)
      .height(28)
      .borderRadius(14)
      .backgroundColor(AppTokens.Colors.surfaceVariant);
    }
    .width('100%')
    .height(56)
    .padding({
      left: AppTokens.Spacing.md,
      right: AppTokens.Spacing.md,
      top: AppTokens.Spacing.sm,
      bottom: AppTokens.Spacing.sm
    });
  }

  @Builder
  TotalBalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .opacity(0.7);

      Blank().height(AppTokens.Spacing.sm);

      Text('$ 1,145.14')
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(AppTokens.Colors.onPrimary);

      Blank().height(AppTokens.Spacing.xs);

      Row() {
        Circle({ width: 10, height: 10 })
          .fill(AppTokens.Colors.secondary);

        Text('+$234.10 today')
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(AppTokens.Typography.body.weight)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ left: AppTokens.Spacing.sm });
      }
      .alignItems(VerticalAlign.Center);
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.primary)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.Elevation.level2.radius,
      color: AppTokens.Elevation.level2.color,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level2.dy
    });
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppTokens.Spacing.sm }) {
          Button() {}
          .width(64)
          .height(64)
          .borderRadius(32)
          .backgroundColor(AppTokens.Colors.surface)
          .shadow({
            radius: AppTokens.Elevation.level1.radius,
            color: AppTokens.Elevation.level1.color,
            offsetX: 0,
            offsetY: AppTokens.Elevation.level1.dy
          });

          Text(action.label)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(AppTokens.Colors.onBackground);
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center);
      }, (action: ControlAction) => action.label);
    }
    .width('100%');
  }

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onBackground);

      Blank();

      Button() {
        Text('View All')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.tertiary);
      }
      .backgroundColor(Color.Transparent);
    }
    .width('100%');
  }

  @Builder
  TransactionCard(transaction: Transaction) {
    Row({ space: AppTokens.Spacing.md }) {
      Column()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium);

      Column() {
        Text(transaction.name)
          .fontSize(AppTokens.Typography.body.size)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface);

        Text(transaction.detail)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.tertiary)
          .margin({ top: 2 });
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1);

      Text(transaction.amount)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(FontWeight.Medium)
        .fontColor(transaction.isCredit ? AppTokens.Colors.success : AppTokens.Colors.onSurface);
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline });
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column({ space: AppTokens.Spacing.xs }) {
            Circle({ width: 24, height: 24 })
              .fill(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.outline);

            Text(item.label)
              .fontSize(AppTokens.Typography.label.size)
              .fontWeight(AppTokens.Typography.label.weight)
              .fontColor(this.selectedNavItem === item.label ? AppTokens.Colors.primary : AppTokens.Colors.tertiary);
          }
          .padding({
            top: AppTokens.Spacing.sm,
            bottom: AppTokens.Spacing.sm
          })
          .backgroundColor(this.selectedNavItem === item.label ? AppTokens.Colors.surfaceVariant : Color.Transparent)
          .borderRadius(AppTokens.Shapes.medium);
        }
        .layoutWeight(1)
        .backgroundColor(Color.Transparent);
      }, (item: NavItem) => item.label);
    }
    .width('100%')
    .height(80)
    .padding({
      left: AppTokens.Spacing.xs,
      right: AppTokens.Spacing.xs
    })
    .backgroundColor(AppTokens.Colors.surface)
    .shadow({
      radius: AppTokens.Elevation.level3.radius,
      color: AppTokens.Elevation.level3.color,
      offsetX: 0,
      offsetY: AppTokens.Elevation.level3.dy
    });
  }
}