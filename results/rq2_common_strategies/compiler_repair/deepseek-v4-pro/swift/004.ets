@Entry
@Component
struct FinanceWalletApp {
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State flags: string[] = []

  private filters: string[] = ['All', 'Week', 'Month', 'Year']
  private accounts: AccountCardModel[] = [
    { id: 1, name: 'Wallet', balance: '$2,845.20', accent: '#10B981' },
    { id: 2, name: 'Savings', balance: '$8,120.00', accent: '#3B82F6' },
    { id: 3, name: 'Investments', balance: '$15,430.55', accent: '#F59E0B' }
  ]
  private transactions: TxItemModel[] = [
    { id: 1, title: 'Grocery Market', subtitle: 'Today • 12:40', amount: '-$32.18', positive: false },
    { id: 2, title: 'Salary', subtitle: 'Yesterday • 09:00', amount: '+$3,200.00', positive: true },
    { id: 3, title: 'Coffee Shop', subtitle: 'Yesterday • 15:22', amount: '-$4.90', positive: false },
    { id: 4, title: 'ETF Purchase', subtitle: 'Mon • 10:05', amount: '-$250.00', positive: false },
    { id: 5, title: 'Refund', subtitle: 'Sun • 18:40', amount: '+$18.99', positive: true }
  ]

  build() {
    Stack() {
      // Background layer
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F3F4F6')

      Column({ space: 0 }) {
        // Top Bar
        Row({ space: 4 }) {
          Blank().width(20).height(20).backgroundColor('#1F2937').borderRadius(6)
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
          Blank()
        }
        .padding(8)
        .backgroundColor('#F3F4F6')

        // Scrollable content
        List() {
          // Filters Row + Toggle
          ListItem() {
            Row() {
              Row({ space: 4 }) {
                ForEach(this.filters, (filter: string) => {
                  Button() {
                    Text(filter)
                      .fontSize(this.selectedFilter === filter ? 14 : 12)
                      .fontWeight(this.selectedFilter === filter ? FontWeight.Medium : FontWeight.Regular)
                      .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0B1220')
                      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  }
                  .backgroundColor(this.selectedFilter === filter ? '#1F2937' : '#FFFFFF')
                  .borderRadius(8)
                  .border({ width: 1, color: '#D1D5DB' })
                  .onClick(() => { this.selectedFilter = filter })
                })
              }
              Blank()
              Row({ space: 4 }) {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                Button() {
                  Text(this.showBalance ? 'ON' : 'OFF')
                    .fontSize(10)
                    .fontColor(this.showBalance ? '#FFFFFF' : '#0B1220')
                }
                .backgroundColor(this.showBalance ? '#1F2937' : '#E5E7EB')
                .borderRadius(12)
                .width(36)
                .height(20)
                .border({ width: 1, color: '#D1D5DB' })
                .onClick(() => { this.showBalance = !this.showBalance })
              }
            }
          }

          // Accounts List
          ForEach(this.accounts, (account: AccountCardModel) => {
            ListItem() {
              // Account card inline
              Column({ space: 4 }) {
                // Header
                Row() {
                  Row({ space: 4 }) {
                    Blank().width(16).height(16).backgroundColor(account.accent).borderRadius(6)
                    Text(account.name)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0B1220')
                  }
                  Blank()
                  Button() {
                    Text('Manage')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0B1220')
                      .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                  }
                  .backgroundColor('#10B981')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D1D5DB' })
                  .onClick(() => {})
                }

                // Balance Box
                Stack() {
                  Text(this.showBalance ? account.balance : '•••••••')
                    .fontSize(18)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#0B1220')
                }
                .width('100%')
                .aspectRatio(2.8)
                .borderRadius(8)
                .backgroundColor('#E5E7EB')

                // Actions
                Row({ space: 4 }) {
                  Button() {
                    Text('Transfer')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0B1220')
                      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                  }
                  .backgroundColor('#10B981')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D1D5DB' })
                  .onClick(() => {})

                  Button() {
                    Text('Details')
                      .fontSize(10)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0B1220')
                      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                  }
                  .backgroundColor('#FFFFFF')
                  .borderRadius(6)
                  .border({ width: 1, color: '#D1D5DB' })
                  .onClick(() => {})
                }
              }
              .padding(8)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 4, color: '#24000000' })
              .border({ width: 1, color: '#D1D5DB' })
              .width('100%')
            }
          })

          // Recent Activity Header + Chips
          ListItem() {
            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0B1220')
              Blank()
              Row({ space: 4 }) {
                Button() {
                  Text('Income')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.flags.indexOf('Income') !== -1 ? '#0B1220' : '#0B1220')
                    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                }
                .backgroundColor(this.flags.indexOf('Income') !== -1 ? '#10B981' : '#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#D1D5DB' })
                .onClick(() => {
                  let idx = this.flags.indexOf('Income')
                  if (idx !== -1) {
                    this.flags.splice(idx, 1)
                  } else {
                    this.flags.push('Income')
                  }
                })

                Button() {
                  Text('Expense')
                    .fontSize(10)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.flags.indexOf('Expense') !== -1 ? '#0B1220' : '#0B1220')
                    .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                }
                .backgroundColor(this.flags.indexOf('Expense') !== -1 ? '#10B981' : '#FFFFFF')
                .borderRadius(6)
                .border({ width: 1, color: '#D1D5DB' })
                .onClick(() => {
                  let idx = this.flags.indexOf('Expense')
                  if (idx !== -1) {
                    this.flags.splice(idx, 1)
                  } else {
                    this.flags.push('Expense')
                  }
                })
              }
            }
          }

          // Transactions List
          ForEach(this.transactions, (tx: TxItemModel) => {
            ListItem() {
              // Transaction card inline
              Row() {
                Row({ space: 6 }) {
                  Blank().width(32).height(32).backgroundColor(tx.positive ? '#16A34A' : '#EF4444').borderRadius(6)
                  Column({ space: 2 }) {
                    Text(tx.title)
                      .fontSize(14)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#0B1220')
                    Text(tx.subtitle)
                      .fontSize(12)
                      .fontColor('#0B1220')
                  }
                }
                Blank()
                Text(tx.amount)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(tx.positive ? '#16A34A' : '#EF4444')
              }
              .padding(8)
              .backgroundColor('#FFFFFF')
              .borderRadius(12)
              .shadow({ radius: 2, color: '#1F000000' })
              .border({ width: 1, color: '#D1D5DB' })
              .width('100%')
              .height(72)
            }
          })

          // Bottom space
          ListItem() {
            Column().height(100)
          }
        }
        .width('100%')
        .layoutWeight(1)
        .backgroundColor('#F3F4F6')
      }

      // Bottom Bar Overlay
      Column() {
        Blank()
        Column() {
          Row() {
            Column({ space: 2 }) {
              Text('Total Balance')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
              Text(this.showBalance ? '$26,395.75' : '•••••••')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0B1220')
            }
            Blank()
            Button() {
              Text('Add Money')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0B1220')
                .width(140)
                .height(44)
            }
            .backgroundColor('#10B981')
            .borderRadius(12)
            .width(140)
            .height(44)
            .onClick(() => {})
          }
          .padding({ left: 8, right: 8, top: 8, bottom: 8 })
        }
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 6, color: '#29000000' })
      }
    }
    .width('100%')
    .height('100%')
  }
}

interface AccountCardModel {
  id: number
  name: string
  balance: string
  accent: string
}

interface TxItemModel {
  id: number
  title: string
  subtitle: string
  amount: string
  positive: boolean
}