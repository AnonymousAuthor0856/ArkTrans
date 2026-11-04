class AccountCardModel {
  id: number
  name: string
  balance: string
  accent: string

  constructor(id: number, name: string, balance: string, accent: string) {
    this.id = id
    this.name = name
    this.balance = balance
    this.accent = accent
  }
}

class TxItemModel {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean

  constructor(id: number, title: string, subtitle: string, amount: string, positive: boolean) {
    this.id = id
    this.title = title
    this.subtitle = subtitle
    this.amount = amount
    this.positive = positive
  }
}

@Entry
@Component
struct Index {
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State incomeSelected: boolean = false
  @State expenseSelected: boolean = false

  private cPrimary: string = '#1F2937'
  private cSecondary: string = '#10B981'
  private cTertiary: string = '#3B82F6'
  private cPageBg: string = '#F3F4F6'
  private cSurface: string = '#FFFFFF'
  private cSurfaceVariant: string = '#E5E7EB'
  private cLine: string = '#D1D5DB'
  private cSuccess: string = '#16A34A'
  private cError: string = '#EF4444'
  private cText: string = '#0B1220'
  private filters: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCardModel[] = [
    new AccountCardModel(1, 'Wallet', '$2,845.20', '#10B981'),
    new AccountCardModel(2, 'Savings', '$8,120.00', '#3B82F6'),
    new AccountCardModel(3, 'Investments', '$15,430.55', '#F59E0B')
  ]
  private transactions: TxItemModel[] = [
    new TxItemModel(1, 'Grocery Market', 'Today - 12:40', '-$32.18', false),
    new TxItemModel(2, 'Salary', 'Yesterday - 09:00', '+$3,200.00', true),
    new TxItemModel(3, 'Coffee Shop', 'Yesterday - 15:22', '-$4.90', false),
    new TxItemModel(4, 'ETF Purchase', 'Mon - 10:05', '-$250.00', false),
    new TxItemModel(5, 'Refund', 'Sun - 18:40', '+$18.99', true)
  ]

  private isAssistSelected(label: string): boolean {
    return label === 'Income' ? this.incomeSelected : this.expenseSelected
  }

  private toggleAssist(label: string): void {
    if (label === 'Income') {
      this.incomeSelected = !this.incomeSelected
    } else {
      this.expenseSelected = !this.expenseSelected
    }
  }

  @Builder
  FilterChip(label: string) {
    Button(label)
      .height(34)
      .padding({ left: 12, right: 12 })
      .fontSize(this.selectedFilter === label ? 14 : 12)
      .fontWeight(this.selectedFilter === label ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.selectedFilter === label ? Color.White : this.cText)
      .backgroundColor(this.selectedFilter === label ? this.cPrimary : this.cSurface)
      .border({ width: this.selectedFilter === label ? 0 : 1, color: this.cLine, radius: 8 })
      .margin({ right: 4 })
      .onClick(() => {
        this.selectedFilter = label
      })
  }

  @Builder
  AssistChip(label: string) {
    Button(label)
      .height(28)
      .padding({ left: 8, right: 8 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isAssistSelected(label) ? this.cText : this.cText)
      .backgroundColor(this.isAssistSelected(label) ? this.cSecondary : this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 6 })
      .margin({ left: 4 })
      .onClick(() => {
        this.toggleAssist(label)
      })
  }

  @Builder
  SmallAction(label: string, filled: boolean) {
    Button(label)
      .height(30)
      .padding({ left: 8, right: 8 })
      .fontSize(10)
      .fontWeight(FontWeight.Medium)
      .fontColor(filled ? this.cText : this.cText)
      .backgroundColor(filled ? this.cSecondary : this.cSurface)
      .border({ width: 1, color: this.cLine, radius: 6 })
      .margin({ right: 4 })
  }

  @Builder
  AccountCard(account: AccountCardModel) {
    Column() {
      Row() {
        Row() {
          Rect()
            .width(16)
            .height(16)
            .radius(6)
            .fill(account.accent)
            .margin({ right: 4 })
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
        }
        Blank()
        this.SmallAction('Manage', true)
      }
      .width('100%')

      Stack({ alignContent: Alignment.Center }) {
        Rect()
          .width('100%')
          .height('100%')
          .radius(8)
          .fill(this.cSurfaceVariant)
        Text(this.showBalance ? account.balance : '*******')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.cText)
      }
      .width('100%')
      .aspectRatio(2.8)
      .margin({ top: 8, bottom: 8 })

      Row() {
        this.SmallAction('Transfer', true)
        this.SmallAction('Details', false)
      }
      .width('100%')
    }
    .width('100%')
    .constraintSize({ minHeight: 120 })
    .padding(8)
    .backgroundColor(this.cSurface)
    .border({ width: 1, color: this.cLine, radius: 12 })
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
  }

  @Builder
  TransactionCard(tx: TxItemModel) {
    Row() {
      Row() {
        Rect()
          .width(32)
          .height(32)
          .radius(6)
          .fill(tx.positive ? this.cSuccess : this.cError)
          .margin({ right: 6 })
        Column() {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
            .width('100%')
          Text(tx.subtitle)
            .fontSize(12)
            .fontColor(this.cText)
            .width('100%')
            .margin({ top: 2 })
        }
      }
      .layoutWeight(1)

      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? this.cSuccess : this.cError)
    }
    .width('100%')
    .constraintSize({ minHeight: 72 })
    .padding(8)
    .backgroundColor(this.cSurface)
    .border({ width: 1, color: this.cLine, radius: 12 })
    .shadow({ radius: 2, color: '#1F000000', offsetY: 1 })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row() {
          Rect()
            .width(20)
            .height(20)
            .radius(6)
            .fill(this.cPrimary)
            .margin({ right: 4 })
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.cText)
          Blank()
        }
        .width('100%')
        .padding(16)
        .backgroundColor(this.cPageBg)

        Scroll() {
          Column() {
            Row() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChip(filter)
                }, (filter: string) => filter)
              }
              .layoutWeight(1)

              Row() {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.cText)
                  .margin({ right: 4 })
                Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                  .width(42)
                  .height(24)
                  .onChange((value: boolean) => {
                    this.showBalance = !value
                  })
              }
            }
            .width('100%')
            .margin({ bottom: 8 })

            ForEach(this.accounts, (account: AccountCardModel) => {
              this.AccountCard(account)
            }, (account: AccountCardModel) => account.id.toString())

            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.cText)
              Blank()
              this.AssistChip('Income')
              this.AssistChip('Expense')
            }
            .width('100%')
            .margin({ top: 8, bottom: 8 })

            ForEach(this.transactions, (tx: TxItemModel) => {
              this.TransactionCard(tx)
            }, (tx: TxItemModel) => tx.id.toString())

            Blank().height(100)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.cPageBg)

      Column() {
        Row() {
          Column() {
            Text('Total Balance')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.cText)
              .width('100%')
            Text(this.showBalance ? '$26,395.75' : '*******')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.cText)
              .width('100%')
              .margin({ top: 2 })
          }
          .layoutWeight(1)

          Button('Add Money')
            .width(140)
            .height(44)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.cText)
            .backgroundColor(this.cSecondary)
            .borderRadius(12)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .backgroundColor(this.cSurface)
      }
      .width('100%')
      .shadow({ radius: 6, color: '#29000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.cPageBg)
  }
}
