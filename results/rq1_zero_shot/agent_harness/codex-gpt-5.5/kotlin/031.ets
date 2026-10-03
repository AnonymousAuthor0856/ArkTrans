const NAME: string = '032_WalletDashFinance_en';
const UI_TYPE: string = 'Finance/Wallet';
const STYLE_THEME: string = 'Monochrome Comfortable';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#020617';
  static readonly secondary: string = '#4ADE80';
  static readonly tertiary: string = '#64748B';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#020617';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#020617';
  static readonly onSurface: string = '#020617';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

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
  constructor(label: string) { this.label = label; }
}

class NavItem {
  label: string;
  constructor(label: string) { this.label = label; }
}

@Entry
@Component
struct MainActivity {
  @State selectedNavItem: string = 'Home';
  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ];
  private controlActions: ControlAction[] = [new ControlAction('Send'), new ControlAction('Receive'), new ControlAction('Add'), new ControlAction('More')];
  private navItems: NavItem[] = [new NavItem('Home'), new NavItem('Cards'), new NavItem('Activity'), new NavItem('Profile')];

  @Builder
  TopBar(): void {
    Row() {
      Circle().width(28).height(28).fill(AppColors.surfaceVariant);
      Blank();
      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank();
      Circle().width(28).height(28).fill(AppColors.surfaceVariant);
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.md, right: AppSpacing.md })
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BalanceCard(): void {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('#B3FFFFFF');
      Blank().height(AppSpacing.sm);
      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary);
      Blank().height(AppSpacing.xs);
      Row({ space: AppSpacing.sm }) {
        Circle().width(10).height(10).fill(AppColors.secondary);
        Text('+$234.10 today')
          .fontSize(16)
          .fontColor(AppColors.secondary);
      }
      .alignItems(VerticalAlign.Center);
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.primary)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14000000', offsetY: 2 })
    .alignItems(HorizontalAlign.Start);
  }

  @Builder
  QuickActions(): void {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppSpacing.sm }) {
          Button('')
            .backgroundColor(AppColors.surface)
            .borderRadius(32)
            .width(64)
            .height(64);
          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface);
        }
        .alignItems(HorizontalAlign.Center);
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  SectionHeader(): void {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface);
      Blank();
      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary);
    }
    .width('100%')
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  TransactionRow(transaction: Transaction): void {
    Row({ space: AppSpacing.md }) {
      Rect().width(48).height(48).fill(AppColors.surfaceVariant).radius(16);
      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface);
        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary);
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);
      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(transaction.isCredit ? AppColors.success : AppColors.onSurface)
        .textAlign(TextAlign.End);
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .borderRadius(16)
    .alignItems(VerticalAlign.Center);
  }

  @Builder
  BottomNav(): void {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: AppSpacing.xs }) {
          Circle()
            .width(24)
            .height(24)
            .fill(this.selectedNavItem === item.label ? AppColors.primary : AppColors.outline);
          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label ? AppColors.primary : AppColors.tertiary);
        }
        .layoutWeight(1)
        .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNavItem = item.label;
        });
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 12, color: '#1A000000', offsetY: -4 });
  }

  build() {
    Column() {
      this.TopBar();
      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.BalanceCard();
          this.QuickActions();
          this.SectionHeader();
          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionRow(transaction);
          }, (transaction: Transaction) => transaction.id.toString())
        }
        .width('100%')
        .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm });
      }
      .layoutWeight(1);
      this.BottomNav();
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background);
  }
}
