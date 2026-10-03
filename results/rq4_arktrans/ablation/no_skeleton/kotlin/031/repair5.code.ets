// src/main/ets/view/WalletDashFinance.ets

@Entry
@Component
struct WalletDashFinance {
  @State selectedNavItem: string = "Home"

  build() {
    Column() {
      // === Top Bar ===
      Row() {
        // Left Icon Placeholder
        Circle({ width: '28vp', height: '28vp' }).fill('#F1F5F9')
        Blank()
        Text('My Wallet').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#020617')
        Blank()
        // Right Icon Placeholder
        Circle({ width: '28vp', height: '28vp' }).fill('#F1F5F9')
      }.width('100%').height(56).padding({ left: 16, right: 16 })

      // === Scrollable Content ===
      Scroll() {
        Column({ space: 24 }) {
          // === Balance Card ===
          Column({ space: 8 }) {
            Text('Total Balance').fontSize(16).fontColor('#94A3B8')
            Text('$ 1,145.14').fontSize(48).fontWeight(FontWeight.Bold).fontColor('#FFFFFF')
            Row({ space: 8 }) {
              Circle({ width: '10vp', height: '10vp' }).fill('#4ADE80')
              Text('+$234.10 today').fontSize(16).fontColor('#4ADE80')
            }
          }
          .width('100%')
          .padding(24)
          .backgroundColor('#020617')
          .borderRadius(24)
          .shadow({ radius: 8, color: '#14000000', offsetY: 2 })

          // === Control Actions ===
          Row({ space: 16 }) {
            this.buildControlAction('Send')
            this.buildControlAction('Receive')
            this.buildControlAction('Add')
            this.buildControlAction('More')
          }.width('100%').justifyContent(FlexAlign.SpaceAround)

          // === Recent Activity Header ===
          Row() {
            Text('Recent Activity').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#020617')
            Blank()
            Text('View All').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#64748B')
          }.width('100%')

          // === Transaction List ===
          Column({ space: 12 }) {
            this.buildTransactionItem('Spotify', 'Subscription', '-$9.99', false)
            this.buildTransactionItem('Income', 'Monthly Salary', '+$2,500.00', true)
            this.buildTransactionItem('Starbucks', 'Coffee', '-$5.75', false)
            this.buildTransactionItem('Amazon', 'Shopping', '-$124.50', false)
            this.buildTransactionItem('Refund', 'Amazon Return', '+$32.00', true)
          }.width('100%')
        }
        .width('100%')
        .padding({ top: 16, bottom: 80 }) // Bottom padding for nav bar
      }.layoutWeight(1)

      // === Bottom Navigation ===
      Row({ space: 24 }) {
        this.buildNavItem('Home', 'Home')
        this.buildNavItem('Cards', 'Cards')
        this.buildNavItem('Activity', 'Activity')
        this.buildNavItem('Profile', 'Profile')
      }
      .width('100%')
      .height(80)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 12, color: '#1A000000', offsetY: -4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }

  @Builder
  buildControlAction(label: string) {
    Column({ space: 8 }) {
      Button() {
        // Using the required resource name as per rules
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .borderRadius(8)
      }
      .width(64)
      .height(64)
      .shape(CircleShape())
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 3, color: '#0D000000', offsetY: 1 })

      Text(label).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#020617')
    }
  }

  @Builder
  buildNavItem(label: string, key: string) {
    Column({ space: 4 }) {
      Circle({ width: '24vp', height: '24vp' })
        .fill(this.selectedNavItem === key ? '#020617' : '#E2E8F0')
      
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedNavItem === key ? '#020617' : '#64748B')
    }
    .onClick(() => {
      this.selectedNavItem = key
    })
  }

  @Builder
  buildTransactionItem(name: string, detail: string, amount: string, isCredit: boolean) {
    Row({ space: 16 }) {
      // Avatar Placeholder
      Column().width(48).height(48).backgroundColor('#F1F5F9').borderRadius(16)
      
      Column({ space: 4 }) {
        Text(name).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#020617')
        Text(detail).fontSize(12).fontWeight(FontWeight.Medium).fontColor('#64748B')
      }.layoutWeight(1)

      Text(amount)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(isCredit ? '#22C55E' : '#020617')
        .textAlign(TextAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E2E8F0' })
  }
}