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

@Entry
@Component
struct WalletDashFinance {
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
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          this.BalanceCard()
          this.Controls()
          this.ActivityHeader()

          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionCard(transaction)
          }, (transaction: Transaction) => transaction.id.toString())
        }
        .width('100%')
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
          bottom: AppSpacing.lg
        })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(AppColors.background)

      this.BottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Blank()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(14)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)
        .lineHeight(28)

      Blank()
        .width(28)
        .height(28)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(14)
    }
    .width('100%')
    .height(64)
    .padding({ left: 28, right: 28 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Normal)
        .fontColor('#B3FFFFFF')
        .lineHeight(24)

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .lineHeight(56)
        .margin({ top: AppSpacing.sm })

      Row() {
        Blank()
          .width(10)
          .height(10)
          .backgroundColor(AppColors.secondary)
          .borderRadius(5)

        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColors.secondary)
          .lineHeight(24)
          .margin({ left: AppSpacing.sm })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: AppSpacing.xs })
    }
    .width('100%')
    .height(154)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.primary)
    .borderRadius(24)
    .shadow({
      radius: 8,
      color: '#14000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  Controls() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppSpacing.sm }) {
          Stack({ alignContent: Alignment.Center }) {
            Blank()
              .width(24)
              .height(24)
              .backgroundColor(AppColors.primary)
              .borderRadius(8)
          }
          .width(64)
          .height(64)
          .backgroundColor(AppColors.surface)
          .borderRadius(32)
          .shadow({
            radius: 3,
            color: '#0D000000',
            offsetX: 0,
            offsetY: 1
          })
          .border({
            width: 1,
            color: '#F0F2F5'
          })

          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .lineHeight(16)
        }
        .alignItems(HorizontalAlign.Center)
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  ActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)
        .lineHeight(28)

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.tertiary)
        .lineHeight(16)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionCard(transaction: Transaction) {
    Row() {
      Blank()
        .width(48)
        .height(48)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(16)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
          .lineHeight(24)

        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .lineHeight(16)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: AppSpacing.md })

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? AppColors.success : AppColors.onSurface)
        .lineHeight(24)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .height(78)
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }

  @Builder
  BottomNavigation() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 6 }) {
          Stack({ alignContent: Alignment.Center }) {
            if (this.selectedNavItem === item.label) {
              Blank()
                .width(24)
                .height(24)
                .backgroundColor(AppColors.primary)
                .borderRadius(12)
            } else {
              Blank()
                .width(24)
                .height(24)
                .backgroundColor(AppColors.outline)
                .borderRadius(12)
            }
          }
          .width(this.selectedNavItem === item.label ? 64 : 48)
          .height(32)
          .backgroundColor(this.selectedNavItem === item.label ? AppColors.surfaceVariant : AppColors.surface)
          .borderRadius(18)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label ? AppColors.primary : AppColors.tertiary)
            .lineHeight(16)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(68)
    .padding({ left: 12, right: 12, top: 7, bottom: 7 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 12,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -2
    })
  }
}