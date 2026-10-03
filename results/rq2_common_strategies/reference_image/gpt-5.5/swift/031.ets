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
  static readonly onPrimary70: string = 'rgba(255, 255, 255, 0.70)';
  static readonly clear: string = 'rgba(0, 0, 0, 0)';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 16;
  static readonly large: number = 24;
}

class AppShadow {
  static readonly level1Color: string = 'rgba(0, 0, 0, 0.05)';
  static readonly level2Color: string = 'rgba(0, 0, 0, 0.08)';
  static readonly level3Color: string = 'rgba(0, 0, 0, 0.10)';
}

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  id: number;
  label: string;
}

interface NavItem {
  id: number;
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: ControlAction[] = [
    { id: 1, label: 'Send' },
    { id: 2, label: 'Receive' },
    { id: 3, label: 'Add' },
    { id: 4, label: 'More' }
  ];

  private navItems: NavItem[] = [
    { id: 1, label: 'Home' },
    { id: 2, label: 'Cards' },
    { id: 3, label: 'Activity' },
    { id: 4, label: 'Profile' }
  ];

  build() {
    Stack() {
      Column() {
        this.topAppBar()

        Scroll() {
          Column({ space: AppSpacing.lg }) {
            this.totalBalanceCard()
            this.controlActionsRow()
            this.recentActivityHeader()

            ForEach(this.transactions, (transaction: Transaction) => {
              this.transactionCard(transaction)
            }, (transaction: Transaction) => transaction.id.toString())
          }
          .width('100%')
          .padding({
            left: AppSpacing.md,
            right: AppSpacing.md,
            top: AppSpacing.sm,
            bottom: AppSpacing.sm
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .padding({ bottom: AppSpacing.sm })

        this.bottomNavigationBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  private topAppBar() {
    Row() {
      Stack()
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(AppColors.surfaceVariant)

      Blank()
        .layoutWeight(1)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)

      Blank()
        .layoutWeight(1)

      Stack()
        .width(28)
        .height(28)
        .borderRadius(14)
        .backgroundColor(AppColors.surfaceVariant)
    }
    .width('100%')
    .height(72)
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(AppColors.background)
  }

  @Builder
  private totalBalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onPrimary70)

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .letterSpacing(-0.5)
        .margin({ top: AppSpacing.sm })

      Row({ space: AppSpacing.sm }) {
        Circle()
          .width(10)
          .height(10)
          .fill(AppColors.secondary)

        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.secondary)
      }
      .margin({ top: AppSpacing.xs })
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.primary)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: 8,
      color: AppShadow.level2Color,
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  private controlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column({ space: AppSpacing.sm }) {
          Stack() {
            Stack()
              .width(24)
              .height(24)
              .borderRadius(AppRadius.small)
              .backgroundColor(AppColors.primary)
          }
          .width(64)
          .height(64)
          .borderRadius(32)
          .backgroundColor(AppColors.surface)
          .shadow({
            radius: 3,
            color: AppShadow.level1Color,
            offsetX: 0,
            offsetY: 1
          })

          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(AppColors.onBackground)
        }
        .width('25%')
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
        })
      }, (action: ControlAction) => action.id.toString())
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private recentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)

      Blank()
        .layoutWeight(1)

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .letterSpacing(0.2)
        .fontColor(AppColors.tertiary)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  private transactionCard(transaction: Transaction) {
    Row({ space: AppSpacing.md }) {
      Stack()
        .width(48)
        .height(48)
        .borderRadius(AppRadius.medium)
        .backgroundColor(AppColors.surfaceVariant)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)

        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .letterSpacing(0.2)
          .fontColor(AppColors.tertiary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? AppColors.success : AppColors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppRadius.medium
    })
  }

  @Builder
  private bottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: AppSpacing.xs }) {
          Circle()
            .width(24)
            .height(24)
            .fill(this.selectedNavItem === item.label ? AppColors.primary : AppColors.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .letterSpacing(0.2)
            .fontColor(this.selectedNavItem === item.label ? AppColors.primary : AppColors.tertiary)
        }
        .width('25%')
        .height(64)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(this.selectedNavItem === item.label ? AppColors.surfaceVariant : AppColors.clear)
        .borderRadius(AppRadius.medium)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .height(80)
    .padding({ left: AppSpacing.xs, right: AppSpacing.xs })
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: 12,
      color: AppShadow.level3Color,
      offsetX: 0,
      offsetY: -4
    })
  }
}