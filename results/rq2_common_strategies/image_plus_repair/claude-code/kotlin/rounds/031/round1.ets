@Entry
@Component
struct WalletPage {
  @State selectedNavIndex: number = 0

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
    Column() {
      this.TopBar()

      Scroll() {
        Column() {
          this.BalanceCard()
          this.ActionRow()
          this.ActivityHeader()
          this.TransactionList()
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
      .layoutWeight(1)

      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  TopBar() {
    Row() {
      Circle({ width: 28, height: 28 })
        .fill('#F1F5F9')

      Text('My Wallet')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Circle({ width: 28, height: 28 })
        .fill('#F1F5F9')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BalanceCard() {
    Column() {
      Text('Total Balance')
        .fontSize(16)
        .fontColor('rgba(255, 255, 255, 0.7)')
        .margin({ bottom: 8 })

      Text('$ 1,145.14')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .margin({ bottom: 4 })

      Row() {
        Circle({ width: 10, height: 10 })
          .fill('#4ADE80')
          .margin({ right: 8 })

        Text('+$234.10 today')
          .fontSize(16)
          .fontColor('#4ADE80')
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor('#020617')
    .borderRadius(24)
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetY: 2 })
    .margin({ top: 8, bottom: 24 })
  }

  @Builder
  ActionRow() {
    Row() {
      ForEach(this.controlActions, (action: string) => {
        Column() {
          Circle({ width: 64, height: 64 })
            .fill('#FFFFFF')
            .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
            .margin({ bottom: 8 })

          Text(action)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#020617')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .margin({ bottom: 24 })
  }

  @Builder
  ActivityHeader() {
    Row() {
      Text('Recent Activity')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor('#020617')
        .layoutWeight(1)

      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#64748B')
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .margin({ bottom: 16 })
  }

  @Builder
  TransactionList() {
    Column() {
      ForEach(this.transactions, (tx: Transaction) => {
        this.TransactionItem(tx)
      }, (tx: Transaction) => tx.id.toString())
    }
    .width('100%')
  }

  @Builder
  TransactionItem(tx: Transaction) {
    Row() {
      Rect({ width: 48, height: 48 })
        .fill('#F1F5F9')
        .radius(16)
        .margin({ right: 16 })

      Column() {
        Text(tx.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#020617')

        Text(tx.detail)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#64748B')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text(tx.amount)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.isCredit ? '#22C55E' : '#020617')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E2E8F0' })
    .margin({ bottom: 12 })
  }

  @Builder
  BottomNav() {
    Row() {
      ForEach(this.navItems, (label: string, index: number) => {
        Column() {
          Circle({ width: 24, height: 24 })
            .fill(this.selectedNavIndex === index ? '#020617' : '#E2E8F0')
            .margin({ bottom: 4 })

          Text(label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNavIndex === index ? '#020617' : '#64748B')
        }
        .alignItems(HorizontalAlign.Center)
        .layoutWeight(1)
        .onClick(() => {
          this.selectedNavIndex = index;
        })
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 16 })
    .backgroundColor('#FFFFFF')
    .justifyContent(FlexAlign.SpaceAround)
    .alignItems(VerticalAlign.Top)
  }
}

interface Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean
}
