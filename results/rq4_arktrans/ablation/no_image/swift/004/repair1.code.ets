@Entry
@Component
struct Index {
  @State showBalance: boolean = true

  build() {
    Stack() {
      // === ZStack ===
      Stack() {
        // === VStack ===
        Column({ space: 0 }) {
          // === HStack ===
          Row({ space: 8 }) {
            // === RoundedRectangle ===
            Rect().width(20).height(20).fill(0x1F2937)
            // === Text ===
            Text('Wallet').fontColor(0x0B1220).fontSize(24)
            // === Spacer ===
            Blank()
          }.backgroundColor(0xF3F4F6).padding(16)

          // === ScrollView ===
          Scroll() {
            // === VStack ===
            Column({ space: 24 }) {
              // === HStack ===
              Row() {
                // === HStack ===
                Row({ space: 8 }) {
                  // === ForEach ===
                  ForEach(['All', 'Crypto', 'NFTs'], (item: string) => {
                    Button() {
                      Text(item).fontColor(this.showBalance ? 0x0B1220 : 0x0B1220).fontSize(14)
                    }
                    .type(ButtonType.Normal)
                    .backgroundColor(this.showBalance ? 0x1F2937 : 0xFFFFFF)
                    .borderRadius(8)
                    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                    .border({ width: this.showBalance ? 0 : 1, color: 0xD1D5DB, radius: 8 })
                  }, (item: string) => item)
                }
                // === Spacer ===
                Blank()
                // === HStack ===
                Row({ space: 8 }) {
                  // === Text ===
                  Text('Hide').fontColor(0x0B1220).fontSize(10)
                  // === Toggle ===
                  Toggle({ type: ToggleType.Switch, isOn: !this.showBalance })
                    .onChange((isOn: boolean) => {
                      this.showBalance = !isOn
                    })
                    .width(44)
                    .height(24)
                }
              }

              // === ForEach ===
              ForEach([
                { name: 'Main Wallet', balance: '$12,450.00', accent: 0x3B82F6 },
                { name: 'Savings', balance: '$13,945.75', accent: 0x10B981 }
              ], (account: { name: string, balance: string, accent: number }) => {
                // === VStack ===
                Column() {
                  // === HStack ===
                  Row() {
                    // === HStack ===
                    Row({ space: 8 }) {
                      // === RoundedRectangle ===
                      Rect().width(16).height(16).fill(account.accent)
                      // === Text ===
                      Text(account.name).fontColor(0x0B1220).fontSize(14)
                    }
                    // === Spacer ===
                    Blank()
                    // === Button ===
                    Button() {}
                  }
                  // === ZStack ===
                  Stack() {
                    // === Text ===
                    Text(this.showBalance ? account.balance : "•••••••").fontColor(0x0B1220).fontSize(18)
                  }.width('100%')
                  // === HStack ===
                  Row({ space: 8 }) {
                    // === Button ===
                    Button() {}
                    // === Button ===
                    Button() {}
                  }
                }
                .height(120)
                .backgroundColor(0xFFFFFF)
                .borderRadius(16)
                .shadow({ radius: 4, color: '#24000000', offsetY: 1 })
                .border({ width: 1, color: 0xE5E7EB, radius: 16 })
              }, (account: { name: string, balance: string, accent: number }) => account.name)

              // === HStack ===
              Row() {
                // === Text ===
                Text('Recent Activity').fontColor(0x0B1220).fontSize(18)
                // === Spacer ===
                Blank()
                // === HStack ===
                Row({ space: 8 }) {
                  // === Button ===
                  Button() {
                    Text('Income').fontColor(0x0B1220).fontSize(12)
                  }
                  .type(ButtonType.Normal)
                  .backgroundColor(0xFFFFFF)
                  .borderRadius(6)
                  .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                  .border({ width: 1, color: 0xD1D5DB, radius: 6 })

                  // === Button ===
                  Button() {
                    Text('Expense').fontColor(0x0B1220).fontSize(12)
                  }
                  .type(ButtonType.Normal)
                  .backgroundColor(0xFFFFFF)
                  .borderRadius(6)
                  .padding({ left: 8, right: 8, top: 6, bottom: 6 })
                  .border({ width: 1, color: 0xD1D5DB, radius: 6 })
                }
              }

              // === ForEach ===
              ForEach([
                { title: 'Apple Store', subtitle: 'Electronics', amount: '-$120.50', positive: false },
                { title: 'Salary', subtitle: 'Work', amount: '+$3,200.00', positive: true }
              ], (tx: { title: string, subtitle: string, amount: string, positive: boolean }) => {
                // === HStack ===
                Row() {
                  // === HStack ===
                  Row({ space: 12 }) {
                    // === RoundedRectangle ===
                    Rect().width(32).height(32).fill(tx.positive ? 0x16A34A : 0xEF4444)
                    // === VStack ===
                    Column({ space: 2 }) {
                      // === Text ===
                      Text(tx.title).fontColor(0x0B1220).fontSize(14)
                      // === Text ===
                      Text(tx.subtitle).fontColor(0x0B1220).fontSize(12)
                    }
                  }
                  // === Spacer ===
                  Blank()
                  // === Text ===
                  Text(tx.amount).fontColor(tx.positive ? 0x16A34A : 0xEF4444).fontSize(14)
                }
                .height(72)
                .backgroundColor(0xFFFFFF)
                .borderRadius(16)
                .shadow({ radius: 2, color: '#1F000000', offsetY: 0.5 })
                .border({ width: 1, color: 0xE5E7EB, radius: 16 })
              }, (tx: { title: string, subtitle: string, amount: string, positive: boolean }) => tx.title)

              // === Spacer ===
              Blank().height(100)
            }
            .padding({ top: 16, bottom: 16, left: 24, right: 24 })
          }
        }

        // === VStack ===
        Column() {
          // === Spacer ===
          Blank()
          // === VStack ===
          Column() {
            // === HStack ===
            Row() {
              // === VStack ===
              Column({ space: 2 }) {
                // === Text ===
                Text('Total Balance').fontColor(0x0B1220).fontSize(14)
                // === Text ===
                Text(this.showBalance ? "$26,395.75" : "•••••••").fontColor(0x0B1220).fontSize(18)
              }
              // === Spacer ===
              Blank()
              // === Button ===
              Button() {}
            }
            .padding({ top: 16, bottom: 16, left: 24, right: 24 })
          }
          .backgroundColor(0xFFFFFF)
          .shadow({ radius: 6, color: '#29000000', offsetY: -1.5 })
        }
      }
    }.width('100%').height('100%')
  }
}