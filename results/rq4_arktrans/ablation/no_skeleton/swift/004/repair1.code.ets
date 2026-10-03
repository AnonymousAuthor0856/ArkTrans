@Entry
@Component
struct FinanceWalletApp {
  @State showBalance: boolean = true
  @State selectedFilter: string = 'Month'
  @State flags: Set<string> = new Set<string>()

  // Data Models
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

  private filters: string[] = ['All', 'Week', 'Month', 'Year']

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Background ===
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F3F4F6')

      // === Main Content ===
      Column() {
        // === Top Bar ===
        Row() {
          Image($r('app.media.startIcon'))
            .width(20)
            .height(20)
            .borderRadius(6)
            .objectFit(ImageFit.Cover)
          
          Text('Wallet')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0B1220')
          
          Blank()
        }
        .width('100%')
        .padding(16)
        .alignItems(VerticalAlign.Center)

        // === Scrollable Area ===
        Scroll() {
          Column({ space: 8 }) {
            
            // === Filters Row ===
            Row() {
              Row({ space: 4 }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChip(filter, this.selectedFilter === filter, () => {
                    this.selectedFilter = filter
                  })
                })
              }
              
              Blank()
              
              Row({ space: 4 }) {
                Text('Hide')
                  .fontSize(10)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0B1220')
                
                this.CustomSwitch(!this.showBalance, (val: boolean) => {
                  this.showBalance = !val
                })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // === Accounts List ===
            ForEach(this.accounts, (account: AccountCardModel) => {
              this.AccountCardView(account, this.showBalance)
            })

            // === Recent Activity Header ===
            Row() {
              Text('Recent Activity')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0B1220')
              
              Blank()
              
              Row({ space: 4 }) {
                this.AssistChip('Income', this.flags.has('Income'), () => {
                  if (this.flags.has('Income')) {
                    this.flags.delete('Income')
                  } else {
                    this.flags.add('Income')
                  }
                })
                this.AssistChip('Expense', this.flags.has('Expense'), () => {
                  if (this.flags.has('Expense')) {
                    this.flags.delete('Expense')
                  } else {
                    this.flags.add('Expense')
                  }
                })
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            // === Transactions List ===
            ForEach(this.transactions, (tx: TxItemModel) => {
              this.TransactionCard(tx)
            })

            // Bottom Padding for FAB/BottomBar
            Column().height(100)
          }
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      // === Bottom Bar Overlay ===
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
          .alignItems(HorizontalAlign.Start)
          
          Blank()
          
          Button('Add Money')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
            .width(140)
            .height(44)
            .backgroundColor('#10B981')
            .borderRadius(12)
        }
        .width('100%')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .backgroundColor('#FFF')
      .shadow({ radius: 6, color: '#29000000', offsetY: -1.5 })
    }
    .width('100%')
    .height('100%')
  }

  // --- Components ---

  @Builder
  FilterChip(label: string, isSelected: boolean, onClick: () => void) {
    Button() {
      Text(label)
        .fontSize(isSelected ? 14 : 12)
        .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(isSelected ? '#FFF' : '#0B1220')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    }
    .backgroundColor(isSelected ? '#1F2937' : '#FFF')
    .borderRadius(8)
    .border({ width: isSelected ? 0 : 1, color: '#D1D5DB', radius: 8 })
    .onClick(onClick)
  }

  @Builder
  AssistChip(label: string, isSelected: boolean, onClick: () => void) {
    Button() {
      Text(label)
        .fontSize(10)
        .fontWeight(FontWeight.Medium)
        .fontColor(isSelected ? '#0B1220' : '#0B1220')
        .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    }
    .backgroundColor(isSelected ? '#10B981' : '#FFF')
    .borderRadius(6)
    .border({ width: 1, color: '#D1D5DB', radius: 6 })
    .onClick(onClick)
  }

  @Builder
  CustomSwitch(isOn: boolean, onChange: (val: boolean) => void) {
    Row() {
      Stack() {
        // Track
        Capsule()
          .fill(isOn ? '#1F2937' : '#E5E7EB')
          .width(36)
          .height(20)
        
        // Thumb
        Circle()
          .fill(isOn ? '#FFF' : '#D1D5DB')
          .width(16)
          .height(16)
          .margin({ left: isOn ? 18 : 2 })
      }
      .width(36)
      .height(24)
      .onClick(() => {
        onChange(!isOn)
      })
    }
  }

  @Builder
  AccountCardView(account: AccountCardModel, showBalance: boolean) {
    Column({ space: 4 }) {
      // Header
      Row() {
        Row({ space: 4 }) {
          Rect()
            .fill(account.accent)
            .width(16)
            .height(16)
            .borderRadius(6)
          
          Text(account.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
        }
        
        Blank()
        
        Button('Manage')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .borderRadius(6)
          .border({ width: 1, color: '#D1D5DB', radius: 6 })
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      
      // Balance Box
      Column() {
        Text(showBalance ? account.balance : '•••••••')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0B1220')
      }
      .width('100%')
      .aspectRatio(2.8)
      .backgroundColor('#E5E7EB')
      .borderRadius(8)
      
      // Actions
      Row({ space: 4 }) {
        Button('Transfer')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#10B981')
          .borderRadius(6)
          .border({ width: 1, color: '#D1D5DB', radius: 6 })
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
        
        Button('Details')
          .fontSize(10)
          .fontWeight(FontWeight.Medium)
          .fontColor('#0B1220')
          .backgroundColor('#FFF')
          .borderRadius(6)
          .border({ width: 1, color: '#D1D5DB', radius: 6 })
          .padding({ left: 8, right: 8, top: 6, bottom: 6 })
      }
    }
    .padding(8)
    .width('100%')
    .height(120)
    .backgroundColor('#FFF')
    .borderRadius(12)
    .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
    .border({ width: 1, color: '#D1D5DB', radius: 12 })
  }

  @Builder
  TransactionCard(tx: TxItemModel) {
    Row() {
      Row({ space: 6 }) {
        Rect()
          .fill(tx.positive ? '#16A34A' : '#EF4444')
          .width(32)
          .height(32)
          .borderRadius(6)
        
        Column({ space: 2 }) {
          Text(tx.title)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#0B1220')
          
          Text(tx.subtitle)
            .fontSize(12)
            .fontWeight(FontWeight.Regular)
            .fontColor('#0B1220')
        }
        .alignItems(HorizontalAlign.Start)
      }
      
      Blank()
      
      Text(tx.amount)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .fontColor(tx.positive ? '#16A34A' : '#EF4444')
    }
    .width('100%')
    .height(72)
    .padding(8)
    .backgroundColor('#FFF')
    .borderRadius(12)
    .shadow({ radius: 2, color: '#1F000000', offsetY: 0.5 })
    .border({ width: 1, color: '#D1D5DB', radius: 12 })
  }
}

// Interfaces
interface AccountCardModel {
  id: number;
  name: string;
  balance: string;
  accent: string;
}

interface TxItemModel {
  id: number;
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}