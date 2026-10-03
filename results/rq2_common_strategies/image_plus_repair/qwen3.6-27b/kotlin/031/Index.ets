// entry/src/main/ets/components/WalletScreen.ets

interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

@Entry
@Component
struct WalletScreen {
  @State transactions: Transaction[] = [
    { id: 1, name: "Spotify", detail: "Subscription", amount: "-$9.99", isCredit: false },
    { id: 2, name: "Income", detail: "Monthly Salary", amount: "+$2,500.00", isCredit: true },
    { id: 3, name: "Starbucks", detail: "Coffee", amount: "-$5.75", isCredit: false },
    { id: 4, name: "Amazon", detail: "Shopping", amount: "-$124.50", isCredit: false },
    { id: 5, name: "Refund", detail: "Amazon Return", amount: "+$32.00", isCredit: true }
  ];

  @State controlActions: string[] = ["Send", "Receive", "Add", "More"];
  @State navItems: string[] = ["Home", "Cards", "Activity", "Profile"];
  @State selectedNavItem: string = "Home";

  build() {
    Column() {
      // Top Bar
      Row() {
        Circle()
          .width(28)
          .height(28)
          .backgroundColor('#F1F5F9')
        
        Text("My Wallet")
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor('#020617')
          .textAlign(TextAlign.Center)
          .layoutWeight(1)
        
        Circle()
          .width(28)
          .height(28)
          .backgroundColor('#F1F5F9')
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })

      // Scrollable Content
      Scroll() {
        Column() {
          // Balance Card
          Column() {
            Text("Total Balance")
              .fontSize(16)
              .fontColor('#FFFFFF')
              .opacity(0.7)
            
            Text("$ 1,145.14")
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
              .margin({ top: 8 })
            
            Row() {
              Circle()
                .width(10)
                .height(10)
                .backgroundColor('#4ADE80')
              
              Text("+$234.10 today")
                .fontSize(16)
                .fontColor('#4ADE80')
                .margin({ left: 8 })
            }
            .margin({ top: 4 })
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#020617')
          .borderRadius(24)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetY: 2 })
          .margin({ bottom: 24 })

          // Control Actions
          Row() {
            ForEach(this.controlActions, (action: string) => {
              Column() {
                Stack() {
                  Circle()
                    .width(64)
                    .height(64)
                    .backgroundColor('#FFFFFF')
                    .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetY: 1 })
                  
                  Rect()
                    .width(24)
                    .height(24)
                    .borderRadius(8)
                    .fill('#020617')
                }
                
                Text(action)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#020617')
                  .margin({ top: 8 })
              }
              .alignItems(HorizontalAlign.Center)
            }, (item: string) => item)
          }
          .justifyContent(FlexAlign.SpaceAround)
          .width('100%')
          .margin({ bottom: 24 })

          // Recent Activity Header
          Row() {
            Text("Recent Activity")
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#020617')
              .layoutWeight(1)
            
            Text("View All")
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#64748B')
          }
          .width('100%')
          .margin({ bottom: 16 })

          // Transactions List
          ForEach(this.transactions, (transaction: Transaction) => {
            Row() {
              Rect()
                .width(48)
                .height(48)
                .borderRadius(16)
                .fill('#F1F5F9')
              
              Column() {
                Text(transaction.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .fontColor('#020617')
                
                Text(transaction.detail)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#64748B')
              }
              .layoutWeight(1)
              .margin({ left: 16 })
              
              Text(transaction.amount)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor(transaction.isCredit ? '#22C55E' : '#020617')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#E2E8F0' })
            .margin({ bottom: 16 })
          }, (item: Transaction) => item.id.toString())
        }
        .padding({ left: 16, right: 16, bottom: 80 })
      }
      .layoutWeight(1)

      // Bottom Navigation
      Row() {
        ForEach(this.navItems, (item: string) => {
          Column() {
            Circle()
              .width(24)
              .height(24)
              .backgroundColor(this.selectedNavItem === item ? '#020617' : '#E2E8F0')
            
            Text(item)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNavItem === item ? '#020617' : '#64748B')
              .margin({ top: 4 })
          }
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNavItem = item;
          })
        }, (item: string) => item)
      }
      .justifyContent(FlexAlign.SpaceAround)
      .width('100%')
      .height(60)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: 'rgba(0,0,0,0.10)', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}