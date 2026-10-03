import promptAction from '@ohos.promptAction'

interface Account {
  name: string
  balance: string
  accent: string
}

interface Transaction {
  title: string
  subtitle: string
  amount: string
  positive: boolean
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State showIncome: boolean = false
  @State showExpense: boolean = false

  private readonly filters: string[] = ['All', 'Week', 'Month', 'Year']
  private readonly accounts: Account[] = [
    { name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ]
  private readonly transactions: Transaction[] = [
    { title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  build() {
    Stack() {
      Column() {
        Row() {
          Column()
            .width(40)
            .height(40)
            .borderRadius(11)
            .backgroundColor('#1F2937')

          Text('Wallet')
            .fontSize(34)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
            .margin({ left: 10 })

          Blank()
        }
        .width('100%')
        .height(96)
        .padding({ left: 32, right: 16 })
        .alignItems(VerticalAlign.Center)

        Scroll() {
          Column({ space: 16 }) {
            Row() {
              Row({ space: 8 }) {
                ForEach(this.filters, (filter: string) => {
                  Button(filter)
                    .fontSize(filter === this.selectedFilter ? 25 : 22)
                    .fontColor(filter === this.selectedFilter ? '#FFFFFF' : '#111827')
                    .fontWeight(filter === this.selectedFilter ? FontWeight.Medium : FontWeight.Regular)
                    .backgroundColor(filter === this.selectedFilter ? '#1F2937' : '#FFFFFF')
                    .border({
                      width: filter === this.selectedFilter ? 0 : 1,
                      color: '#D1D5DB'
                    })
                    .borderRadius(16)
                    .height(64)
                    .padding({ left: 20, right: 20 })
                    .onClick(() => {
                      this.selectedFilter = filter
                    })
                })
              }

              Blank()

              Text('Hide')
                .fontSize(20)
                .fontColor('#0B1220')
                .margin({ right: 12 })

              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .width(72)
                .height(40)
                .selectedColor('#1F2937')
                .switchPointColor('#D1D5DB')
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
            }
            .width('100%')
            .height(64)
            .alignItems(VerticalAlign.Center)

            ForEach(this.accounts, (account: Account) => {
              this.accountCard(account)
            })

            Row() {
              Text('Recent Activity')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0B1220')

              Blank()

              Button('Income')
                .fontSize(15)
                .fontColor(this.showIncome ? '#0B1220' : '#111827')
                .backgroundColor(this.showIncome ? '#10B981' : '#FFFFFF')
                .border({ width: 1, color: '#D1D5DB' })
                .borderRadius(10)
                .height(36)
                .padding({ left: 12, right: 12 })
                .onClick(() => {
                  this.showIncome = !this.showIncome
                })

              Button('Expense')
                .fontSize(15)
                .fontColor(this.showExpense ? '#0B1220' : '#111827')
                .backgroundColor(this.showExpense ? '#10B981' : '#FFFFFF')
                .border({ width: 1, color: '#D1D5DB' })
                .borderRadius(10)
                .height(36)
                .padding({ left: 12, right: 12 })
                .margin({ left: 8 })
                .onClick(() => {
                  this.showExpense = !this.showExpense
                })
            }
            .width('100%')
            .margin({ top: 4 })

            ForEach(this.transactions, (transaction: Transaction) => {
              this.transactionCard(transaction)
            })

            Blank().height(120)
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 8, bottom: 24 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F3F4F6')

      Column() {
        Row() {
          Column() {
            Text('Total Balance')
              .fontSize(20)
              .fontColor('#0B1220')
            Text(this.showBalance ? '$26,395.75' : '•••••••')
              .fontSize(30)
              .fontWeight(FontWeight.Bold)
              .fontColor('#0B1220')
              .margin({ top: 2 })
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Button('Add Money')
            .fontSize(24)
            .fontColor('#0B1220')
            .backgroundColor('#10B981')
            .borderRadius(20)
            .width(280)
            .height(88)
            .onClick(() => {
              promptAction.showToast({ message: 'Add Money' })
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .shadow({
        radius: 12,
        color: '#26000000',
        offsetX: 0,
        offsetY: -2
      })
      .align(Alignment.Bottom)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  accountCard(account: Account) {
    Column() {
      Row() {
        Row() {
          Column()
            .width(32)
            .height(32)
            .borderRadius(10)
            .backgroundColor(account.accent)

          Text(account.name)
            .fontSize(28)
            .fontColor('#0B1220')
            .margin({ left: 8 })
        }

        Blank()

        Button('Manage')
          .fontSize(20)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .border({ width: 1, color: '#D1D5DB' })
          .borderRadius(12)
          .height(44)
          .padding({ left: 14, right: 14 })
      }
      .width('100%')

      Stack() {
        Text(this.showBalance ? account.balance : '•••••••')
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
      }
      .width('100%')
      .height(244)
      .backgroundColor('#E5E7EB')
      .borderRadius(14)
      .margin({ top: 8, bottom: 8 })

      Row() {
        Button('Transfer')
          .fontSize(20)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .border({ width: 1, color: '#D1D5DB' })
          .borderRadius(12)
          .height(48)
          .padding({ left: 16, right: 16 })

        Button('Details')
          .fontSize(20)
          .fontColor('#111827')
          .backgroundColor('#FFFFFF')
          .border({ width: 1, color: '#D1D5DB' })
          .borderRadius(12)
          .height(48)
          .padding({ left: 16, right: 16 })
          .margin({ left: 8 })
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .border({ width: 1, color: '#D1D5DB' })
    .shadow({
      radius: 8,
      color: '#24000000',
      offsetX: 0,
      offsetY: 2
    })
  }

  @Builder
  transactionCard(transaction: Transaction) {
    Row() {
      Row() {
        Column()
          .width(42)
          .height(42)
          .borderRadius(10)
          .backgroundColor(transaction.positive ? '#16A34A' : '#EF4444')

        Column() {
          Text(transaction.title)
            .fontSize(20)
            .fontColor('#0B1220')
          Text(transaction.subtitle)
            .fontSize(16)
            .fontColor('#4B5563')
            .margin({ top: 3 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10 })
      }

      Blank()

      Text(transaction.amount)
        .fontSize(19)
        .fontWeight(FontWeight.Medium)
        .fontColor(transaction.positive ? '#16A34A' : '#EF4444')
    }
    .width('100%')
    .height(76)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#D1D5DB' })
    .shadow({
      radius: 5,
      color: '#1F000000',
      offsetX: 0,
      offsetY: 1
    })
  }
}
