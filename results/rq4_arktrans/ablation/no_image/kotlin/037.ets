@Entry
@Component
struct Index {
  @State sizeHeight: string = '0'
  @State totalSpent: string = '0'
  @State formatCurrencyTotalValue: string = '0'
  @State itemName: string = ''
  @State formatCurrencyItemValue: string = '0'
  @State monthlyBudget: string = '0'
  @State plusSign: string = '+'
  @State homeText: string = 'Home'
  @State textLabel: string = ''
  @State reportsText: string = 'Reports'
  @State modifierWidthXl: string = '0'
  @State goalsText: string = 'Goals'
  @State settingsText: string = 'Settings'

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 16 }) {
        ListItem() {
          // PieChart placeholder
          Stack({ alignContent: Alignment.Center }) {
            Canvas().width('100%').height('100%')
            Column({ space: 0 }) {
              Text('Total Spent').fontColor('#718096').fontSize(12)
              Text('formatCurrency(totalValue)').fontColor('#4A5568').fontSize(24).fontWeight(FontWeight.Bold)
            }.alignItems(HorizontalAlign.Center)
          }.width(240).height(240)
        }

        ListItem() {
          Column() {
            Blank().height(24)
          }
        }

        ListItem() {
          // Card / BudgetItemRow
          Column() {
            Row({ space: 0 }) {
              Row({ space: 16 }) {
                // Box placeholder for icon/brush
                Stack({ alignContent: Alignment.Center }) {
                  // Placeholder for item.brush background
                }.width(20).height(20).borderRadius(10).backgroundColor('#E2E8F0')
                
                Text('item.name').fontColor('#1A202C').fontSize(16)
              }.alignItems(VerticalAlign.Center)
              
              Text('formatCurrency(item.value)').fontColor('#1A202C').fontSize(18).fontWeight(FontWeight.Medium)
            }.alignItems(VerticalAlign.Center).width('100%').padding({ left: 16, right: 16, top: 16, bottom: 16 })
          }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%')
        }

        ListItem() {
          Column() {
            Blank().height(48)
          }
        }
      }.padding({ left: 24, right: 24 }).width('100%').layoutWeight(1)

      // CenterAlignedTopAppBar
      Row() {
        Text('Monthly Budget').fontColor('#4A5568').fontSize(24).fontWeight(FontWeight.Bold)
      }.width('100%').height(56).justifyContent(FlexAlign.Center).backgroundColor('#F7FAFC')

      // FloatingActionButton
      Button() {
        Text('+').fontColor('#FFFFFF').fontSize(32).fontWeight(FontWeight.Bold)
      }.width(56).height(56).backgroundColor('#4A5568').borderRadius(28).margin({ right: 24, bottom: 80 })
        .position({ right: 0, bottom: 0 })

      // BottomAppBar
      Row({ space: 0 }) {
        // Home Item
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
            // Icon placeholder
          }.width(24).height(24).borderRadius(12).backgroundColor('#4A5568')
          Text('Home').fontColor('#4A5568').fontSize(12)
        }.alignItems(HorizontalAlign.Center)

        // Reports Item
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
            // Icon placeholder
          }.width(24).height(24).borderRadius(12).backgroundColor('#CBD5E0')
          Text('Reports').fontColor('#718096').fontSize(12)
        }.alignItems(HorizontalAlign.Center)

        Blank().width(16)

        // Goals Item
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
            // Icon placeholder
          }.width(24).height(24).borderRadius(12).backgroundColor('#CBD5E0')
          Text('Goals').fontColor('#718096').fontSize(12)
        }.alignItems(HorizontalAlign.Center)

        // Settings Item
        Column({ space: 4 }) {
          Stack({ alignContent: Alignment.Center }) {
            // Icon placeholder
          }.width(24).height(24).borderRadius(12).backgroundColor('#CBD5E0')
          Text('Settings').fontColor('#718096').fontSize(12)
        }.alignItems(HorizontalAlign.Center)
      }.alignItems(VerticalAlign.Center).width('100%').padding({ left: 8, right: 8, top: 12, bottom: 12 })
        .backgroundColor('#FFFFFF').shadow({ radius: 4, color: '#1A000000' })
        .position({ bottom: 0, left: 0 })
    }.width('100%').height('100%').backgroundColor('#F7FAFC')
  }
}