class Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean

  constructor(id: number, name: string, detail: string, amount: string, isCredit: boolean) {
    this.id = id
    this.name = name
    this.detail = detail
    this.amount = amount
    this.isCredit = isCredit
  }
}

class ControlAction {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

class NavItem {
  label: string

  constructor(label: string) {
    this.label = label
  }
}

@Entry
@Component
struct Index {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    new Transaction(1, 'Spotify', 'Subscription', '-$9.99', false),
    new Transaction(2, 'Income', 'Monthly Salary', '+$2,500.00', true),
    new Transaction(3, 'Starbucks', 'Coffee', '-$5.75', false),
    new Transaction(4, 'Amazon', 'Shopping', '-$124.50', false),
    new Transaction(5, 'Refund', 'Amazon Return', '+$32.00', true)
  ]
  private controlActions: ControlAction[] = [
    new ControlAction('Send'),
    new ControlAction('Receive'),
    new ControlAction('Add'),
    new ControlAction('More')
  ]
  private navItems: NavItem[] = [
    new NavItem('Home'),
    new NavItem('Cards'),
    new NavItem('Activity'),
    new NavItem('Profile')
  ]

  @Builder
  TopAppBar() {
    Row() {
      Button() {
        Circle()
          .width(28)
          .height(28)
          .fill('#F1F5F9')
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button() {
        Circle()
          .width(28)
          .height(28)
          .fill('#F1F5F9')
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor('#F8FAFC')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TotalBalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('#B3FFFFFF')
        .width('100%')

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .width('100%')
        .margin({ top: 8 })

      Row() {
        Circle()
          .width(10)
          .height(10)
          .fill('#4ADE80')
        Text('+$234.10 today')
          .fontSize(16)
          .fontColor('#4ADE80')
          .margin({ left: 8 })
      }
      .alignItems(VerticalAlign.Center)
      .margin({ top: 4 })
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#020617')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14000000', offsetY: 2 })
  }

  @Builder
  ControlActionsRow() {
    Row() {
      ForEach(this.controlActions, (action: ControlAction) => {
        Column() {
          Button() {
            Rect()
              .width(24)
              .height(24)
              .radius(8)
              .fill('#020617')
          }
          .width(64)
          .height(64)
          .backgroundColor('#FFFFFF')
          .borderRadius(32)
          .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })

          Text(action.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#020617')
            .margin({ top: 8 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }, (action: ControlAction) => action.label)
    }
    .width('100%')
  }

  @Builder
  RecentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')
        .layoutWeight(1)

      Button('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#64748B')
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  TransactionCard(transaction: Transaction) {
    Row() {
      Rect()
        .width(48)
        .height(48)
        .radius(16)
        .fill('#F1F5F9')

      Column() {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#020617')
          .width('100%')
        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#64748B')
          .width('100%')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 16, right: 16 })

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(transaction.isCredit ? '#22C55E' : '#020617')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#E2E8F0', radius: 16 })
  }

  @Builder
  BottomNavigationBar() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Button() {
          Column() {
            Circle()
              .width(24)
              .height(24)
              .fill(this.selectedNavItem === item.label ? '#020617' : '#E2E8F0')
            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item.label ? '#020617' : '#64748B')
              .margin({ top: 4 })
          }
          .width('100%')
          .padding({ top: 8, bottom: 8 })
          .backgroundColor(this.selectedNavItem === item.label ? '#F1F5F9' : '#FFFFFF')
          .borderRadius(16)
        }
        .layoutWeight(1)
        .backgroundColor(Color.Transparent)
        .onClick(() => {
          this.selectedNavItem = item.label
        })
      }, (item: NavItem) => item.label)
    }
    .width('100%')
    .height(80)
    .padding({ left: 4, right: 4 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: '#1A000000', offsetY: 4 })
  }

  build() {
    Column() {
      this.TopAppBar()

      Scroll() {
        Column() {
          Column() {
            this.TotalBalanceCard()
          }
          .margin({ bottom: 24 })

          Column() {
            this.ControlActionsRow()
          }
          .margin({ bottom: 24 })

          Column() {
            this.RecentActivityHeader()
          }
          .margin({ bottom: 24 })

          ForEach(this.transactions, (transaction: Transaction) => {
            Column() {
              this.TransactionCard(transaction)
            }
            .margin({ bottom: 24 })
          }, (transaction: Transaction) => transaction.id.toString())
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)
      .backgroundColor('#F8FAFC')
      .scrollBar(BarState.Off)

      this.BottomNavigationBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}
