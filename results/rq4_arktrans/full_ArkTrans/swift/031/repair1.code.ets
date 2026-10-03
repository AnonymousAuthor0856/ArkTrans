@Entry
@Component
struct Index {
  @State transactions: TransactionItem[] = [
    { id: '1', title: 'Spotify', subtitle: 'Subscription', amount: '-$9.99', isPositive: false },
    { id: '2', title: 'Income', subtitle: 'Monthly Salary', amount: '+$2,500.00', isPositive: true }
  ]

  build() {
    Stack() {
      Column() {
        // Header
        Text('My Wallet')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 60, bottom: 30 })

        // Balance Card
        Column() {
          Text('Total Balance')
            .fontColor('#A1A1AA')
            .fontSize(18)
            .margin({ bottom: 10 })
          
          Text('$ 1,145.14')
            .fontColor('#FFFFFF')
            .fontSize(56)
            .fontWeight(FontWeight.Bold)
            .margin({ bottom: 10 })
          
          Row() {
            Circle()
              .width(10)
              .height(10)
              .fill('#4ADE80')
            
            Text('+$234.10 today')
              .fontColor('#4ADE80')
              .fontSize(18)
              .margin({ left: 8 })
          }
        }
        .width('100%')
        .padding(30)
        .backgroundColor('#0F172A')
        .borderRadius(30)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)

        // Action Buttons
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceBetween }) {
          this.ActionButton('Send')
          this.ActionButton('Receive')
          this.ActionButton('Add')
          this.ActionButton('More')
        }
        .width('100%')
        .margin({ top: 30 })

        // Recent Activity Header
        Row() {
          Text('Recent Activity')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .layoutWeight(1)
          
          Text('View All')
            .fontColor('#64748B')
            .fontSize(16)
        }
        .width('100%')
        .margin({ top: 30 })

        // Transactions List
        Column() {
          ForEach(this.transactions, (item: TransactionItem) => {
            this.TransactionCard(item)
          })
        }
        .width('100%')
        .margin({ top: 20 })
        .padding({ bottom: 100 }) // Space for tab bar
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F8FAFC')
      .padding({ left: 20, right: 20 })

      // Tab Bar
      Row() {
        this.TabItem('Home', true)
        this.TabItem('Cards', false)
        this.TabItem('Activity', false)
        this.TabItem('Profile', false)
      }
      .width('100%')
      .height(80)
      .position({ x: 0, y: -80 })
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 20, color: '#00000010' })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  ActionButton(label: string) {
    Column() {
      Image($r('app.media.startIcon'))
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
      
      Text(label)
        .fontSize(14)
        .margin({ top: 8 })
    }
    .width(70)
    .height(70)
    .borderRadius(35)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 10, color: '#00000005' })
    .margin({ bottom: 10 })
  }

  @Builder
  TransactionCard(item: TransactionItem) {
    Row() {
      // Icon placeholder
      Rect()
        .width(50)
        .height(50)
        .borderRadius(12)
        .fill('#F1F5F9')
      
      Column() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
        
        Text(item.subtitle)
          .fontSize(14)
          .fontColor('#64748B')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .margin({ left: 15 })
      .alignItems(HorizontalAlign.Start)
      
      Text(item.amount)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(item.isPositive ? '#4ADE80' : '#0F172A')
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .margin({ bottom: 15 })
    .shadow({ radius: 10, color: '#00000005' })
  }

  @Builder
  TabItem(label: string, isActive: boolean) {
    Column() {
      Circle()
        .width(isActive ? 24 : 20)
        .height(isActive ? 24 : 20)
        .fill(isActive ? '#0F172A' : '#E2E8F0')
      
      Text(label)
        .fontSize(14)
        .fontColor(isActive ? '#0F172A' : '#64748B')
        .margin({ top: 4 })
    }
    .layoutWeight(1)
  }
}

interface TransactionItem {
  id: string;
  title: string;
  subtitle: string;
  amount: string;
  isPositive: boolean;
}