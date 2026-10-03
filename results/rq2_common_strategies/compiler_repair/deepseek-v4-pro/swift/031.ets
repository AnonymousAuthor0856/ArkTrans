@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = "Home"
  private transactions: Transaction[] = [
    { id: 1, name: "Spotify", detail: "Subscription", amount: "-$9.99", isCredit: false },
    { id: 2, name: "Income", detail: "Monthly Salary", amount: "+$2,500.00", isCredit: true },
    { id: 3, name: "Starbucks", detail: "Coffee", amount: "-$5.75", isCredit: false },
    { id: 4, name: "Amazon", detail: "Shopping", amount: "-$124.50", isCredit: false },
    { id: 5, name: "Refund", detail: "Amazon Return", amount: "+$32.00", isCredit: true }
  ]
  private controlActions: ControlAction[] = [
    { label: "Send" },
    { label: "Receive" },
    { label: "Add" },
    { label: "More" }
  ]
  private navItems: NavItem[] = [
    { label: "Home" },
    { label: "Cards" },
    { label: "Activity" },
    { label: "Profile" }
  ]

  build() {
    Column({ space: 0 }) {
      // Top bar
      Row({ space: 0 }) {
        Button() {
          Text('').width(28).height(28).backgroundColor('#FFF1F5F9').borderRadius(14)
        }
        Blank().layoutWeight(1)
        Text('My Wallet')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#FF020617')
        Blank().layoutWeight(1)
        Button() {
          Text('').width(28).height(28).backgroundColor('#FFF1F5F9').borderRadius(14)
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('rgba(248,250,252,0.01)')

      // Scrollable content using List
      List({ space: 24 }) {
        // Total Balance Card
        ListItem() {
          Column({ space: 0 }) {
            Text('Total Balance')
              .fontSize(16)
              .fontWeight(FontWeight.Regular)
              .foregroundColor('rgba(255,255,255,0.7)')
            Blank().height(8)
            Text('$ 1,145.14')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#FFFFFFFF')
            Blank().height(4)
            Row({ space: 8 }) {
              Text('').width(10).height(10).backgroundColor('#FF4ADE80').borderRadius(5)
              Text('+$234.10 today')
                .fontSize(16)
                .fontWeight(FontWeight.Regular)
                .foregroundColor('#FF4ADE80')
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#FF020617')
          .borderRadius(24)
          .shadow({ radius: 8, color: 'rgba(0,0,0,0.08)', offsetX: 0, offsetY: 2 })
        }

        // Control Actions Row
        ListItem() {
          Row({ space: 0 }) {
            ForEach(this.controlActions, (action: ControlAction) => {
              Column({ space: 8 }) {
                Button() {
                  Text('').width(24).height(24).backgroundColor('#FF020617').borderRadius(12)
                }
                .width(64)
                .height(64)
                .backgroundColor('#FFFFFFFF')
                .borderRadius(32)
                .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
                .onClick(() => {
                  // Handle action click
                })
                Text(action.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF020617')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Center)
            })
          }
          .width('100%')
        }

        // Recent Activity Header
        ListItem() {
          Row({ space: 0 }) {
            Text('Recent Activity')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF020617')
            Blank().layoutWeight(1)
            Button() {
              Text('View All')
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#FF64748B')
            }.onClick(() => {})
          }
          .width('100%')
        }

        // Transaction Items
        ForEach(this.transactions, (transaction: Transaction) => {
          ListItem() {
            Row({ space: 16 }) {
              // Icon placeholder
              Text('').width(48).height(48).backgroundColor('#FFF1F5F9').borderRadius(16)
              // Name and detail
              Column({ space: 0 }) {
                Text(transaction.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Bold)
                  .foregroundColor('#FF020617')
                Text(transaction.detail)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF64748B')
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)
              // Amount
              Text(transaction.amount)
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .foregroundColor(transaction.isCredit ? '#FF22C55E' : '#FF020617')
                .textAlign(TextAlign.End)
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFFFF')
            .borderRadius(16)
            .border({ width: 1, color: '#FFE2E8F0' })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#FFF8FAFC')

      // Bottom Navigation Bar
      Row({ space: 0 }) {
        ForEach(this.navItems, (item: NavItem) => {
          Button() {
            Column({ space: 4 }) {
              Text('').width(24).height(24)
                .backgroundColor(this.selectedNavItem === item.label ? '#FF020617' : '#FFE2E8F0')
                .borderRadius(12)
              Text(item.label)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .foregroundColor(this.selectedNavItem === item.label ? '#FF020617' : '#FF64748B')
            }
            .width('100%')
            .padding({ top: 8, bottom: 8 })
            .backgroundColor(this.selectedNavItem === item.label ? '#FFF1F5F9' : Color.Transparent)
            .borderRadius(16)
          }
          .layoutWeight(1)
          .onClick(() => {
            this.selectedNavItem = item.label
          })
        })
      }
      .width('100%')
      .height(80)
      .padding({ left: 4, right: 4 })
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 12, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
  }
}

interface Transaction {
  id: number
  name: string
  detail: string
  amount: string
  isCredit: boolean
}

interface ControlAction {
  label: string
}

interface NavItem {
  label: string
}