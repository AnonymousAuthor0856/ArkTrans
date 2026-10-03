@Entry
@Component
struct Index {
  @State showBalance: boolean = true

  build() {
    Stack() {
      Column() {
        Row() {
          Rect().fill('#1F2937').borderRadius(4).width(20).height(20)
          Text('Wallet').fontColor('#0B1220').fontSize(24).fontWeight(FontWeight.Bold)
          Blank()
        }.padding({ left: 20, right: 20, top: 50, bottom: 20 }).backgroundColor('#F3F4F6')

        Scroll() {
          Column() {
            // Filter Bar
            Row() {
              this.FilterChip('All', false)
              this.FilterChip('Week', false)
              this.FilterChip('Month', true)
              this.FilterChip('Year', false)
              Blank()
              Text('Hide').fontColor('#0B1220').fontSize(14)
              Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                .onChange((isOn: boolean) => {
                  this.showBalance = !isOn
                })
                .width(44).height(24)
            }.width('100%').padding({ left: 20, right: 20, top: 10, bottom: 10 })

            // Accounts List
            ForEach([
              { name: 'Wallet', balance: '$2,845.20', color: '#10B981' },
              { name: 'Savings', balance: '$8,120.00', color: '#3B82F6' },
              { name: 'Investments', balance: '$15,430.55', color: '#F59E0B' }
            ], (item: AccountItem) => {
              Column() {
                Row() {
                  Row() {
                    Rect().fill(item.color).borderRadius(4).width(16).height(16)
                    Text(item.name).fontColor('#0B1220').fontSize(18).margin({ left: 8 })
                  }
                  Blank()
                  Button('Manage')
                    .backgroundColor('#10B981')
                    .fontColor('#FFFFFF')
                    .borderRadius(8)
                    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    .fontSize(14)
                }.width('100%')

                Stack() {
                  Text(this.showBalance ? item.balance : '•••••••')
                    .fontColor('#0B1220')
                    .fontSize(24)
                    .fontWeight(FontWeight.Medium)
                }
                .width('100%')
                .height(120)
                .backgroundColor('#E5E7EB')
                .borderRadius(12)
                .alignContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .margin({ top: 12 })

                Row() {
                  Button('Transfer')
                    .backgroundColor('#10B981')
                    .fontColor('#FFFFFF')
                    .borderRadius(8)
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .fontSize(14)
                  
                  Button('Details')
                    .backgroundColor('#FFFFFF')
                    .fontColor('#0B1220')
                    .borderRadius(8)
                    .borderWidth(1)
                    .borderColor('#D1D5DB')
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                    .fontSize(14)
                    .margin({ left: 8 })
                }.margin({ top: 12 })

              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 4, color: '#00000020', offsetY: 2 })
              .margin({ bottom: 16 })
            }, (item: AccountItem) => item.name)

            // Recent Activity Header
            Row() {
              Text('Recent Activity').fontColor('#0B1220').fontSize(18).fontWeight(FontWeight.Bold)
              Blank()
              this.FilterChip('All', true)
              this.FilterChip('Income', false).margin({ left: 8 })
            }.width('100%').padding({ left: 20, right: 20, top: 10, bottom: 10 })

            // Transactions List
            ForEach([
              { title: 'Netflix Subscription', subtitle: 'Entertainment', amount: '-$14.99', positive: false },
              { title: 'Salary Deposit', subtitle: 'Work', amount: '+$3,200.00', positive: true },
              { title: 'Grocery Store', subtitle: 'Food & Drink', amount: '-$85.40', positive: false }
            ], (tx: TransactionItem) => {
              Row() {
                Row() {
                  Rect()
                    .fill(tx.positive ? '#10B981' : '#EF4444')
                    .borderRadius(8)
                    .width(32)
                    .height(32)
                  
                  Column() {
                    Text(tx.title).fontColor('#0B1220').fontSize(14).fontWeight(FontWeight.Medium)
                    Text(tx.subtitle).fontColor('#6B7280').fontSize(12).margin({ top: 2 })
                  }.alignItems(HorizontalAlign.Start).margin({ left: 12 })
                }
                Blank()
                Text(tx.amount)
                  .fontColor(tx.positive ? '#10B981' : '#EF4444')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              .padding(16)
              .backgroundColor('#FFFFFF')
              .borderRadius(16)
              .shadow({ radius: 2, color: '#0000001F', offsetY: 1 })
              .margin({ bottom: 12 })
            }, (tx: TransactionItem) => tx.title)

            Blank().height(100)
          }.padding({ left: 20, right: 20 })
        }
      }.width('100%').height('100%').backgroundColor('#F3F4F6')

      // Bottom Sheet
      Column() {
        Blank()
        Column() {
          Row() {
            Column() {
              Text('Total Balance').fontColor('#0B1220').fontSize(14)
              Text(this.showBalance ? '$26,395.75' : '•••••••')
                .fontColor('#0B1220')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 4 })
            }.alignItems(HorizontalAlign.Start)
            Blank()
            Button('Add Money')
              .backgroundColor('#10B981')
              .fontColor('#FFFFFF')
              .borderRadius(16)
              .padding({ left: 24, right: 24, top: 12, bottom: 12 })
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }.width('100%').padding({ left: 20, right: 20, top: 16, bottom: 16 })
        }
        .width('100%')
        .backgroundColor('#FFFFFF')
        .borderRadius({ topLeft: 24, topRight: 24 })
        .shadow({ radius: 8, color: '#00000029', offsetY: -2 })
      }.width('100%').alignItems(HorizontalAlign.End)
    }.width('100%').height('100%')
  }

  @Builder
  FilterChip(label: string, isSelected: boolean) {
    Button(label)
      .backgroundColor(isSelected ? '#1F2937' : '#FFFFFF')
      .fontColor(isSelected ? '#FFFFFF' : '#0B1220')
      .borderRadius(12)
      .borderWidth(isSelected ? 0 : 1)
      .borderColor('#D1D5DB')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .fontSize(14)
      .fontWeight(isSelected ? FontWeight.Medium : FontWeight.Normal)
  }
}

interface AccountItem {
  name: string;
  balance: string;
  color: string;
}

interface TransactionItem {
  title: string;
  subtitle: string;
  amount: string;
  positive: boolean;
}