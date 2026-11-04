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

class WalletColors {
  static primary: string = '#020617';
  static secondary: string = '#4ADE80';
  static tertiary: string = '#64748B';
  static background: string = '#F8FAFC';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#F1F5F9';
  static outline: string = '#E2E8F0';
  static success: string = '#22C55E';
  static onPrimary: string = '#FFFFFF';
  static onSecondary: string = '#020617';
  static onSurface: string = '#020617';
}

@Entry
@Component
struct Index {
  @State selectedNavItem: string = 'Home';

  private actions: string[] = ['Send', 'Receive', 'Add', 'More'];
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile'];
  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ];

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('#B3FFFFFF')
        .lineHeight(24)
      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(WalletColors.onPrimary)
        .lineHeight(56)
        .margin({ top: 8 })
      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill(WalletColors.secondary)
        Text('+$234.10 today')
          .fontSize(16)
          .fontColor(WalletColors.secondary)
          .lineHeight(24)
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 4 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(WalletColors.primary)
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  ActionButton(label: string) {
    Column() {
      Button() {
        Text('')
          .width(24)
          .height(24)
          .backgroundColor(WalletColors.primary)
          .borderRadius(8)
      }
      .width(64)
      .height(64)
      .backgroundColor(WalletColors.surface)
      .borderRadius(32)
      .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(WalletColors.onSurface)
        .lineHeight(16)
        .margin({ top: 8 })
    }
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  TransactionCard(transaction: Transaction) {
    Row() {
      Text('')
        .width(48)
        .height(48)
        .backgroundColor(WalletColors.surfaceVariant)
        .borderRadius(16)
      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(WalletColors.onSurface)
          .lineHeight(24)
        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(WalletColors.tertiary)
          .lineHeight(16)
      }
      .layoutWeight(1)
      .margin({ left: 16 })
      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? WalletColors.success : WalletColors.onSurface)
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(WalletColors.surface)
    .border({ width: 1, color: WalletColors.outline, radius: 16 })
    .borderRadius(16)
  }

  @Builder
  BottomNavItem(label: string) {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(this.selectedNavItem === label ? WalletColors.primary : WalletColors.outline)
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedNavItem === label ? WalletColors.primary : WalletColors.tertiary)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Center)
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {
      this.selectedNavItem = label;
    })
  }

  build() {
    Column() {
      Row() {
        Circle().width(28).height(28).fill(WalletColors.surfaceVariant)
        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(WalletColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Circle().width(28).height(28).fill(WalletColors.surfaceVariant)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .alignItems(VerticalAlign.Center)

      Scroll() {
        Column() {
          this.BalanceCard()

          Row() {
            ForEach(this.actions, (action: string) => {
              this.ActionButton(action)
            }, (action: string) => action)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 24 })

          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(WalletColors.onSurface)
            Blank()
            Text('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(WalletColors.tertiary)
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
          .margin({ top: 24 })

          ForEach(this.transactions, (transaction: Transaction) => {
            Column() {
              this.TransactionCard(transaction)
            }
            .width('100%')
            .margin({ top: 24 })
          }, (transaction: Transaction) => transaction.id.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)

      Row() {
        ForEach(this.navItems, (item: string) => {
          this.BottomNavItem(item)
        }, (item: string) => item)
      }
      .width('100%')
      .backgroundColor(WalletColors.surface)
      .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(WalletColors.background)
  }
}
