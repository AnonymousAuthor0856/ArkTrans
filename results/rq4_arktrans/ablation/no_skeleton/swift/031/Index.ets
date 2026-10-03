@Entry
@Component
struct RootScreen {
  @State selectedNavItem: string = 'Home'

  // Data Models
  transactions: Transaction[] = [
    { id: 1, name: 'Spotify', detail: 'Subscription', amount: '-$9.99', isCredit: false },
    { id: 2, name: 'Income', detail: 'Monthly Salary', amount: '+$2,500.00', isCredit: true },
    { id: 3, name: 'Starbucks', detail: 'Coffee', amount: '-$5.75', isCredit: false },
    { id: 4, name: 'Amazon', detail: 'Shopping', amount: '-$124.50', isCredit: false },
    { id: 5, name: 'Refund', detail: 'Amazon Return', amount: '+$32.00', isCredit: true }
  ]
  controlActions: ControlAction[] = [
    { label: 'Send' },
    { label: 'Receive' },
    { label: 'Add' },
    { label: 'More' }
  ]
  navItems: NavItem[] = [
    { label: 'Home' },
    { label: 'Cards' },
    { label: 'Activity' },
    { label: 'Profile' }
  ]

  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#F8FAFC')

      Column() {
        // Top App Bar
        Row() {
          Button() {
            Circle()
              .fill('#F1F5F9')
              .width(28)
              .height(28)
          }.type(ButtonType.Normal).backgroundColor(Color.Transparent).borderWidth(0)

          Blank()

          Text('My Wallet')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor('#020617')

          Blank()

          Button() {
            Circle()
              .fill('#F1F5F9')
              .width(28)
              .height(28)
          }.type(ButtonType.Normal).backgroundColor(Color.Transparent).borderWidth(0)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })

        // Main Content Scrollable Area
        List({ space: 24 }) {
          ListItem() {
            // Total Balance Card
            Column() {
              Text('Total Balance')
                .fontSize(16)
                .fontColor('#FFFFFF')
                .opacity(0.7)

              Text('$ 1,145.14')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(-0.5)
                .fontColor('#FFFFFF')
                .margin({ top: 8 })

              Row() {
                Circle()
                  .fill('#4ADE80')
                  .width(10)
                  .height(10)

                Text('+$234.10 today')
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
            .shadow({ radius: 8, color: '#14000000', offsetY: 2 })
          }

          ListItem() {
            // Control Actions Row
            Row() {
              ForEach(this.controlActions, (action: ControlAction) => {
                Column() {
                  Button() {
                    Circle()
                      .fill('#020617')
                      .width(24)
                      .height(24)
                      .borderRadius(8)
                  }
                  .type(ButtonType.Normal)
                  .backgroundColor('#FFFFFF')
                  .borderWidth(0)
                  .width(64)
                  .height(64)
                  .borderRadius(32)
                  .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })

                  Text(action.label)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.2)
                    .fontColor('#020617')
                    .margin({ top: 8 })
                }
                .layoutWeight(1)
                .justifyContent(FlexAlign.Center)
              })
            }
            .width('100%')
          }

          ListItem() {
            // Recent Activity Header
            Row() {
              Text('Recent Activity')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#020617')

              Blank()

              Button() {
                Text('View All')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .letterSpacing(0.2)
                  .fontColor('#64748B')
              }.type(ButtonType.Normal).backgroundColor(Color.Transparent).borderWidth(0)
            }
            .width('100%')
          }

          // Transaction List Items
          ForEach(this.transactions, (transaction: Transaction) => {
            ListItem() {
              Row() {
                // Icon Placeholder
                Circle()
                  .fill('#F1F5F9')
                  .width(48)
                  .height(48)
                  .borderRadius(16)

                Column() {
                  Text(transaction.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Bold)
                    .fontColor('#020617')

                  Text(transaction.detail)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.2)
                    .fontColor('#64748B')
                    .margin({ top: 2 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

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
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .listDirection(Axis.Vertical)
        .scrollBar(BarState.Off)

        // Bottom Navigation Bar
        Row() {
          ForEach(this.navItems, (item: NavItem) => {
            Button() {
              Column() {
                Circle()
                  .fill(this.selectedNavItem === item.label ? '#020617' : '#E2E8F0')
                  .width(24)
                  .height(24)

                Text(item.label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .letterSpacing(0.2)
                  .fontColor(this.selectedNavItem === item.label ? '#020617' : '#64748B')
                  .margin({ top: 4 })
              }
              .width('100%')
              .justifyContent(FlexAlign.Center)
            }
            .type(ButtonType.Normal)
            .backgroundColor(this.selectedNavItem === item.label ? '#F1F5F9' : Color.Transparent)
            .borderWidth(0)
            .layoutWeight(1)
            .onClick(() => {
              this.selectedNavItem = item.label
            })
          })
        }
        .width('100%')
        .height(80)
        .padding({ left: 4, right: 4 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// Interfaces for data models
interface Transaction {
  id: number;
  name: string;
  detail: string;
  amount: string;
  isCredit: boolean;
}

interface ControlAction {
  label: string;
}

interface NavItem {
  label: string;
}