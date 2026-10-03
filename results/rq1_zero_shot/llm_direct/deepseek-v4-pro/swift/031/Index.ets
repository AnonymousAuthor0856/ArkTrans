@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  private transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ]

  private controlActions: string[] = ['Send', 'Receive', 'Add', 'More']
  private navItems: string[] = ['Home', 'Cards', 'Activity', 'Profile']

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        this.topAppBar()
        Scroll() {
          Column({ space: 24 }) {
            this.totalBalanceCard()
            this.controlActionsRow()
            this.recentActivityHeader()
            ForEach(this.transactions, (transaction: Transaction) => {
              this.transactionCard(transaction)
            }, (transaction: Transaction) => transaction.id.toString())
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        this.bottomNavigationBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  topAppBar() {
    Row() {
      Button() {
      }
      .width(28)
      .height(28)
      .backgroundColor('#F1F5F9')
      .borderRadius(14)

      Blank()

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')

      Blank()

      Button() {
      }
      .width(28)
      .height(28)
      .backgroundColor('#F1F5F9')
      .borderRadius(14)
    }
    .width('100%')
    .height(56)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
  }

  @Builder
  totalBalanceCard() {
    Column({ space: 0 }) {
      Text('Total Balance')
        .fontSize(16)
        .fontWeight(FontWeight.Regular)
        .fontColor('#FFFFFFB3')
      Row().height(8)
      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .letterSpacing(-0.5)
      Row().height(4)
      Row({ space: 8 }) {
        Circle()
          .width(10)
          .height(10)
          .fill('#4ADE80')
        Text('+$234.10 today')
          .fontSize(16)
          .fontWeight(FontWeight.Regular)
          .fontColor('#4ADE80')
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(24)
    .backgroundColor('#020617')
    .borderRadius(24)
    .shadow({ radius: 8, color: '#14020617', offsetY: 2 })
  }

  @Builder
  controlActionsRow() {
    Row({ space: 0 }) {
      ForEach(this.controlActions, (action: string) => {
        Column({ space: 8 }) {
          Button() {
          }
          .width(64)
          .height(64)
          .backgroundColor('#FFFFFF')
          .borderRadius(32)
          .shadow({ radius: 3, color: '#0D020617', offsetY: 1 })
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)

          Text(action)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#020617')
            .letterSpacing(0.2)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
      }, (action: string) => action)
    }
    .width('100%')
  }

  @Builder
  recentActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')
      Blank()
      Button('View All') {
      }
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor('#64748B')
      .letterSpacing(0.2)
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
  }

  @Builder
  transactionCard(transaction: Transaction) {
    Row({ space: 16 }) {
      Row()
        .width(48)
        .height(48)
        .backgroundColor('#F1F5F9')
        .borderRadius(16)

      Column({ space: 0 }) {
        Text(transaction.name)
          .fontSize(16)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#020617')
        Text(transaction.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#64748B')
          .letterSpacing(0.2)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(transaction.amount)
        .fontSize(16)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(transaction.isCredit ? '#22C55E' : '#020617')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E2E8F0' })
  }

  @Builder
  bottomNavigationBar() {
    Row({ space: 0 }) {
      ForEach(this.navItems, (item: string) => {
        Button() {
          this.selectedNavItem = item
        }
        .layoutWeight(1)
        .backgroundColor(this.selectedNavItem === item ? '#F1F5F9' : Color.Transparent)
        .borderRadius(16)
        .padding({ top: 8, bottom: 8 })
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
      }, (item: string) => item)
    }
    .width('100%')
    .height(80)
    .padding({ left: 4, right: 4 })
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: '#1A020617', offsetY: 4 })
  }
}

interface Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean
}