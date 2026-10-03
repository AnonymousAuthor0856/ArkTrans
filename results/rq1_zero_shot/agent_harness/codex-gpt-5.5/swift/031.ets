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

@Entry
@Component
struct RootScreen {
  @State private selectedNavItem: string = 'Home';

  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ];
  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More'];
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile'];

  @Builder
  TopAppBar() {
    Row() {
      Button() { Circle().width(28).height(28).fill('#F1F5F9') }
        .backgroundColor(Color.Transparent)
      Blank()
      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')
      Blank()
      Button() { Circle().width(28).height(28).fill('#F1F5F9') }
        .backgroundColor(Color.Transparent)
    }
    .height(56)
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor('#F8FAFC')
  }

  @Builder
  TotalBalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('#B3FFFFFF')
      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ top: 8 })
      Row() {
        Circle().width(10).height(10).fill('#4ADE80')
        Text('+$234.10 today')
          .fontSize(16)
          .fontColor('#4ADE80')
          .margin({ left: 8 })
      }
      .margin({ top: 4 })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(24)
    .backgroundColor('#020617')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: string) => {
        Column() {
          Button() {
            Rect().width(24).height(24).fill('#020617').radius(8)
          }
          .width(64)
          .height(64)
          .backgroundColor('#FFFFFF')
          .borderRadius(32)
          .shadow({ radius: 3, color: '#0D000000', offsetX: 0, offsetY: 1 })
          Text(action)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#020617')
            .margin({ top: 8 })
        }
        .layoutWeight(1)
      }, (action: string) => action)
    }
    .width('100%')
  }

  @Builder
  TransactionCard(transaction: Transaction) {
    Row() {
      Rect().width(48).height(48).fill('#F1F5F9').radius(16)
      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#020617')
        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#64748B')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })
      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(transaction.isCredit ? '#22C55E' : '#020617')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E2E8F0', radius: 16 })
    .borderRadius(16)
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: string) => {
        Button() {
          Column() {
            Circle()
              .width(24)
              .height(24)
              .fill(this.selectedNavItem === item ? '#020617' : '#E2E8F0')
            Text(item)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item ? '#020617' : '#64748B')
              .margin({ top: 4 })
          }
          .width('100%')
          .padding({ top: 8, bottom: 8 })
          .backgroundColor(this.selectedNavItem === item ? '#F1F5F9' : Color.Transparent)
          .borderRadius(16)
        }
        .layoutWeight(1)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.selectedNavItem = item;
        })
      }, (item: string) => item)
    }
    .width('100%')
    .height(80)
    .padding({ left: 4, right: 4 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: '#1A000000', offsetX: 0, offsetY: 4 })
  }

  build() {
    Column() {
      this.TopAppBar()
      Scroll() {
        Column() {
          this.TotalBalanceCard()
          this.ControlActionsRow()
            .margin({ top: 24 })
          Row() {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#020617')
            Blank()
            Button('View All')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#64748B')
              .backgroundColor(Color.Transparent)
          }
          .width('100%')
          .margin({ top: 24 })
          ForEach(this.transactions, (transaction: Transaction) => {
            this.TransactionCard(transaction)
              .margin({ top: 24 })
          }, (transaction: Transaction) => transaction.id.toString())
        }
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
