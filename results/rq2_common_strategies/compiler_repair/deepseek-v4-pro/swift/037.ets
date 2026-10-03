@Entry
@Component
struct ContentView {
  @State selectedTab: number = 0
  private budgetData: BudgetItem[] = [
    { name: "Housing", value: 1250.00, color: '#FF63B3ED' },
    { name: "Food", value: 480.50, color: '#FF4FD1C5' },
    { name: "Transport", value: 210.75, color: '#FF667EEA' },
    { name: "Entertainment", value: 150.00, color: '#FFED64A6' },
    { name: "Utilities", value: 320.00, color: '#FFF6AD55' }
  ]

  build() {
    Stack() {
      Column({ space: 0 }) {
        // Top Bar
        Row({ space: 0 }) {
          Blank().layoutWeight(1)
          Text('Monthly Budget')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .foregroundColor('#FF4A5568')
            .padding({ top: 16, bottom: 16 })
          Blank().layoutWeight(1)
        }
        .width('100%')
        .backgroundColor('#FFF7FAFC')

        // Scrollable content using List
        List({ space: 16 }) {
          // Pie Chart placeholder
          ListItem() {
            Stack({ alignContent: Alignment.Center }) {
              // Outer circle (placeholder)
              Button() { }
                .width(240)
                .height(240)
                .borderRadius(120)
                .border({ width: 0, color: '#FFFFFFFF' })
                .backgroundColor('#FFE2E8F0')

              // Inner circle with total text
              Column({ space: 0 }) {
                Text('Total Spent')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF718096')
                Text(formatCurrency(this.budgetData.reduce((sum, item) => sum + item.value, 0)))
                  .fontSize(24)
                  .fontWeight(FontWeight.Bold)
                  .foregroundColor('#FF4A5568')
              }
              .width(200)
              .height(200)
              .borderRadius(100)
              .backgroundColor('#FFFFFFFF')
            }
            .width('100%')
            .padding({ top: 24, bottom: 24 })
          }

          // Budget item list
          ForEach(this.budgetData, (item: BudgetItem) => {
            ListItem() {
              Row({ space: 16 }) {
                // Color indicator circle
                Button() { }
                  .width(20)
                  .height(20)
                  .borderRadius(10)
                  .backgroundColor(item.color)

                // Name column
                Column({ space: 0 }) {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Regular)
                    .foregroundColor('#FF1A202C')
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                // Value
                Text(formatCurrency(item.value))
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF1A202C')
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
              .backgroundColor('#FFFFFFFF')
              .borderRadius(16)
              .shadow({ radius: 3, color: 'rgba(0,0,0,0.05)', offsetX: 0, offsetY: 1 })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFF7FAFC')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFF7FAFC')

      // Bottom bar overlay
      Column({ space: 0 }) {
        Blank().layoutWeight(1)

        Stack({ alignContent: Alignment.Top }) {
          // Bottom bar background
          Row({ space: 0 }) {
            // Home
            Column({ space: 4 }) {
              Button() { }
                .width(24).height(24).borderRadius(12)
                .backgroundColor(this.selectedTab === 0 ? 'rgba(74,85,104,0.2)' : '#FFA0AEC0')
              Text('Home')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor(this.selectedTab === 0 ? '#FF4A5568' : '#FFA0AEC0')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => { this.selectedTab = 0 })

            Blank().width(56) // FAB placeholder space

            // Reports
            Column({ space: 4 }) {
              Button() { }
                .width(24).height(24).borderRadius(12)
                .backgroundColor(this.selectedTab === 1 ? 'rgba(74,85,104,0.2)' : '#FFA0AEC0')
              Text('Reports')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor(this.selectedTab === 1 ? '#FF4A5568' : '#FFA0AEC0')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => { this.selectedTab = 1 })

            Blank().width(56)

            // Goals
            Column({ space: 4 }) {
              Button() { }
                .width(24).height(24).borderRadius(12)
                .backgroundColor(this.selectedTab === 2 ? 'rgba(74,85,104,0.2)' : '#FFA0AEC0')
              Text('Goals')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor(this.selectedTab === 2 ? '#FF4A5568' : '#FFA0AEC0')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => { this.selectedTab = 2 })

            // Settings
            Column({ space: 4 }) {
              Button() { }
                .width(24).height(24).borderRadius(12)
                .backgroundColor(this.selectedTab === 3 ? 'rgba(74,85,104,0.2)' : '#FFA0AEC0')
              Text('Settings')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .foregroundColor(this.selectedTab === 3 ? '#FF4A5568' : '#FFA0AEC0')
            }
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => { this.selectedTab = 3 })
          }
          .width('100%')
          .height(80)
          .padding({ left: 16, right: 16 })
          .backgroundColor('#FFFFFFFF')
          .shadow({ radius: 15, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: -5 })

          // FAB
          Button() {
            Text('+')
              .fontSize(24)
              .fontWeight(FontWeight.Bold)
              .foregroundColor('#FFFFFFFF')
          }
          .width(56)
          .height(56)
          .borderRadius(28)
          .backgroundColor('#FF4A5568')
          .shadow({ radius: 4, color: 'rgba(0,0,0,0.2)', offsetX: 0, offsetY: 4 })
          .margin({ top: -28 })
          .onClick(() => { })
          .alignSelf(ItemAlign.Center) // Center horizontally within Stack
        }
        .width('100%')
        .height(80)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF7FAFC')
  }
}

function formatCurrency(value: number): string {
  return '$' + value.toFixed(2)
}

interface BudgetItem {
  name: string
  value: number
  color: string
}