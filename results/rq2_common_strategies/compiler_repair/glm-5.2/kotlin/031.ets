// 032_WalletDashFinance_en - Finance/Wallet - Monochrome Comfortable - en - 720x1280

interface TransactionData {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlActionData {
  label: string;
}

interface NavItemData {
  label: string;
}

class AppTokens {
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

  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 16;
  static readonly lg: number = 24;
  static readonly xl: number = 32;
  static readonly xxl: number = 48;
}

@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home';

  private transactions: TransactionData[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ];

  private controlActions: ControlActionData[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ];

  private navItems: NavItemData[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ];

  @Builder
  TopBar() {
    Row() {
      Row() {
        Circle({ width: 28, height: 28 })
          .fill(AppTokens.surfaceVariant)
      }
      .width(40)
      .height(40)
      .justifyContent(FlexAlign.Center)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Row() {
        Circle({ width: 28, height: 28 })
          .fill(AppTokens.surfaceVariant)
      }
      .width(40)
      .height(40)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppTokens.md, right: AppTokens.md })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor(Color.White.toString())
        .opacity(0.7)

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTokens.onPrimary)
        .margin({ top: AppTokens.sm })

      Row() {
        Circle({ width: 10, height: 10 })
          .fill(AppTokens.secondary)
        Text('+$234.10 today')
          .fontSize(16)
          .fontColor(AppTokens.secondary)
          .margin({ left: AppTokens.sm })
      }
      .margin({ top: AppTokens.xs })
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.lg)
    .borderRadius(24)
    .backgroundColor(AppTokens.primary)
  }

  @Builder
  ControlItem(action: ControlActionData) {
    Column() {
      Button() {
        Column() {
          Row()
            .width(24)
            .height(24)
            .backgroundColor(AppTokens.primary)
            .borderRadius(8)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }
      .width(64)
      .height(64)
      .borderRadius(32)
      .backgroundColor(AppTokens.surface)
      .borderWidth(1)
      .borderColor(AppTokens.outline)

      Text(action.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .margin({ top: AppTokens.sm })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlActionData) => {
        this.ControlItem(action)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionItem(transaction: TransactionData) {
    Row() {
      Row()
        .width(48)
        .height(48)
        .backgroundColor(AppTokens.surfaceVariant)
        .borderRadius(16)

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.onSurface)
        Text(transaction.detail)
          .fontSize(12)
          .fontColor(AppTokens.tertiary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .margin({ left: AppTokens.md })
      .alignItems(HorizontalAlign.Start)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? AppTokens.success : AppTokens.onSurface)
    }
    .width('100%')
    .padding(AppTokens.md)
    .borderRadius(16)
    .backgroundColor(AppTokens.surface)
    .borderWidth(1)
    .borderColor(AppTokens.outline)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      ForEach(this.navItems, (item: NavItemData) => {
        Column() {
          Row()
            .width(24)
            .height(24)
            .borderRadius(12)
            .backgroundColor(this.selectedNavItem === item.label ? AppTokens.primary : AppTokens.outline)

          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavItem === item.label ? AppTokens.primary : AppTokens.tertiary)
            .margin({ top: AppTokens.xs })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNavItem = item.label;
        })
      })
    }
    .width('100%')
    .height(64)
    .backgroundColor(AppTokens.surface)
    .borderWidth(1)
    .borderColor(AppTokens.outline)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.BalanceCard()

          this.ControlActionsRow()

          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.onSurface)
              .layoutWeight(1)

            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.tertiary)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)

          ForEach(this.transactions, (transaction: TransactionData) => {
            this.TransactionItem(transaction)
          })
        }
        .width('100%')
        .padding({ left: AppTokens.md, right: AppTokens.md, top: AppTokens.sm, bottom: AppTokens.lg })
      }
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }
}