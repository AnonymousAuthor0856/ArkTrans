import { Image, List, ListItem, Scroller } from '@kit.ArkUI'

// ==================== Data Models ====================

interface PreviewCardInfo {
  mainTitle: string;
  mainAmount: string;
  subTitle: string;
  subAmount: string;
  cardLabel: string;
  bgIndex: number;
}

interface PreviewStatement {
  initials: string;
  shopName: string;
  transactionId: string;
  amount: string;
  transactionDate: string;
}

enum MpesaScreen {
  Home = "Home",
  Transact = "Transact",
  Discover = "Discover",
  Growth = "Growth"
}

// ==================== Mock Data ====================

const mockCards: PreviewCardInfo[] = [
  {
    mainTitle: "TOTAL SPENT THIS WEEK",
    mainAmount: "KSH. 1,500.00",
    subTitle: "DAILY AVERAGE",
    subAmount: "KSH.845.87",
    cardLabel: "MPESA",
    bgIndex: 0
  },
  {
    mainTitle: "TOTAL SPENT THIS WEEK",
    mainAmount: "KSH. 1,500.00",
    subTitle: "DAILY AVERAGE",
    subAmount: "KSH.845.87",
    cardLabel: "GENERAL",
    bgIndex: 1
  },
  {
    mainTitle: "TOTAL SPENT THIS WEEK",
    mainAmount: "KSH. 1,500.00",
    subTitle: "DAILY AVERAGE",
    subAmount: "KSH.845.87",
    cardLabel: "FAMILY",
    bgIndex: 2
  },
  {
    mainTitle: "TOTAL SPENT THIS WEEK",
    mainAmount: "KSH. 1,500.00",
    subTitle: "DAILY AVERAGE",
    subAmount: "KSH.845.87",
    cardLabel: "BILLS",
    bgIndex: 3
  }
];

const mockStatements: PreviewStatement[] = [
  { initials: "KS", shopName: "GROCERY", transactionId: "122229393", amount: "Ksh. 2,455.0", transactionDate: "12/01/2022" },
  { initials: "AP", shopName: "AIRTIME PURCHASE", transactionId: "1234", amount: "Ksh. 12.34", transactionDate: "10/06/2022" },
  { initials: "KS", shopName: "GROCERY", transactionId: "122229393", amount: "Ksh. 2,455.0", transactionDate: "12/01/2022" },
  { initials: "AP", shopName: "NETFLIX", transactionId: "1234", amount: "Ksh. -12.34", transactionDate: "10/06/2022" },
  { initials: "KS", shopName: "PRIME", transactionId: "122229393", amount: "Ksh. 2,455.0", transactionDate: "12/01/2022" },
  { initials: "AP", shopName: "SHOWMAX", transactionId: "1234", amount: "Ksh. 12.34", transactionDate: "10/06/2022" },
  { initials: "KS", shopName: "TWITCH", transactionId: "122229393", amount: "Ksh. 2,455.0", transactionDate: "12/01/2022" },
  { initials: "AP", shopName: "YOUTUBE", transactionId: "1234", amount: "Ksh. -12.34", transactionDate: "10/06/2022" }
];

// ==================== Main Entry ====================

@Entry
@Component
struct MpesaApp {
  @State currentScreen: MpesaScreen = MpesaScreen.Home;
  @State balanceVisible: boolean = true;
  @State currentPage: number = 0;
  private scroller: Scroller = new Scroller();

  build() {
    Column() {
      // Top Bar
      Row() {
        Image($r('app.media.ic_person'))
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor('#CCCCCC')
          .objectFit(ImageFit.Contain)
        
        Flex({ justifyContent: FlexAlign.End, alignItems: ItemAlign.Center }) {
          Image($r('app.media.ic_notifications'))
            .width(24)
            .height(24)
            .margin({ right: 16 })
          
          Text("QR")
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor('#7A7979')
        }.layoutWeight(1)
      }
      .width('100%')
      .padding({ left: 15, right: 15, top: 12, bottom: 12 })

      // Balance Section
      Column() {
        Text("BALANCE")
          .fontSize(16)
          .fontColor('#7A7979')
          .textAlign(TextAlign.Center)
        
        Row() {
          Text(this.balanceVisible ? "KSH. 2,456" : "KSH. ****")
            .fontSize(22)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
          
          Text(this.balanceVisible ? "HIDE" : "SHOW")
            .fontSize(12)
            .fontColor('#09AF00')
            .onClick(() => {
              this.balanceVisible = !this.balanceVisible;
            })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 4 })
      }
      .width('100%')
      .padding({ left: 15, right: 15 })

      // Quick Actions
      Row() {
        this.QuickActionButton($r('app.media.ic_share'), "SEND", '#09AF00', Color.White)
        this.QuickActionButton($r('app.media.ic_shopping_cart'), "PAY", '#3722F6', Color.White)
        this.QuickActionTextButton("W", "WITHDRAW", '#D32F2F')
        this.QuickActionButton($r('app.media.ic_phone'), "AIRTIME", '#2979FF', Color.White)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ left: 15, right: 15, top: 16, bottom: 16 })

      // Spending Cards Pager
      Column() {
        Swiper() {
          ForEach(mockCards, (card: PreviewCardInfo, index: number) => {
            this.SpendingCard(card)
          })
        }
        .autoPlay(true)
        .indicator(false)
        .loop(true)
        .onChange((index: number) => {
          this.currentPage = index;
        })

        // Page Indicators
        Row() {
          ForEach(mockCards.map((_, i) => i), (index: number) => {
            Circle({ width: this.currentPage === index ? 8 : 6, height: this.currentPage === index ? 8 : 6 })
              .fill(this.currentPage === index ? '#EF6136' : '#7A7979')
              .margin({ left: 3, right: 3 })
          })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ top: 12, bottom: 12 })
      }

      // Statements Header
      Row() {
        Text("M-PESA STATEMENTS")
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text("SEE ALL")
          .fontSize(12)
          .fontColor('#09AF00')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: 15, right: 15, top: 12, bottom: 12 })

      // Statements List
      List({ space: 0, scroller: this.scroller }) {
        ForEach(mockStatements, (statement: PreviewStatement) => {
          ListItem() {
            this.StatementRow(statement)
          }
        })
      }
      .width('100%')
      .layoutWeight(1)

      // Bottom Navigation
      this.BottomNavBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  @Builder
  QuickActionButton(iconRes: Resource, label: string, bgColor: string, iconColor: string) {
    Column() {
      Image(iconRes)
        .width(20)
        .height(20)
        .objectFit(ImageFit.Contain)
        .backgroundColor(bgColor)
        .borderRadius(20)
        .width(40)
        .height(40)
      
      Text(label)
        .fontSize(11)
        .textAlign(TextAlign.Center)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
  }

  @Builder
  QuickActionTextButton(text: string, label: string, bgColor: string) {
    Column() {
      Text(text)
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
        .backgroundColor(bgColor)
        .borderRadius(20)
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .textAlignVertical(TextAlign.Center)
      
      Text(label)
        .fontSize(11)
        .textAlign(TextAlign.Center)
        .fontColor(Color.Black)
        .margin({ top: 4 })
    }
  }

  @Builder
  SpendingCard(card: PreviewCardInfo) {
    Column() {
      // Gradient Background simulation using stacked rectangles or simple color for demo
      // In real ArkTS, use LinearGradientBrush if available or image assets
      Column() {
        Text(card.mainTitle)
          .fontSize(10)
          .fontColor('#CAC8C8')
        
        Text(card.mainAmount)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 4 })
        
        Flex().layoutWeight(1)
        
        Text(card.subTitle)
          .fontSize(14)
          .fontColor('#E6E5E5')
        
        Text(card.subAmount)
          .fontSize(14)
          .fontColor(Color.White)
      }
      .width('100%')
      .height(200)
      .padding(12)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#CF4195', 0],
          ['#EF6136', 0.5],
          ['#346FDE', 1]
        ]
      })
      .borderRadius(12)
      .shadow({ radius: 10, color: '#33000000', offsetY: 2 })

      // Overlay Badge
      Row() {
        Text("MY SPEND")
          .fontSize(11)
          .fontColor(Color.White)
      }
      .position({ x: 'auto', y: 12 })
      .alignSelf(ItemAlign.End)
      .margin({ right: 12 })
      .backgroundColor('#25000000')
      .borderRadius(50)
      .padding({ left: 16, right: 16, top: 6, bottom: 6 })

      // Label
      Text(card.cardLabel)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#B3FFFFFF')
        .position({ x: 'auto', y: 'auto' })
        .alignSelf(ItemAlign.End)
        .margin({ right: 12, bottom: 12 })
    }
    .width('100%')
    .margin({ left: 15, right: 15 })
  }

  @Builder
  StatementRow(statement: PreviewStatement) {
    Row() {
      // Avatar
      Text(statement.initials)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor('#BBDEFB')
        .backgroundColor('#F1F8E9')
        .borderRadius(25)
        .width(50)
        .height(50)
        .textAlign(TextAlign.Center)
        .textAlignVertical(TextAlign.Center)
        .border({ width: 3, color: Color.White })
      
      Column() {
        Text(statement.shopName)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
        
        Text(statement.transactionId)
          .fontSize(11)
          .fontColor('#7A7979')
      }
      .margin({ left: 16 })
      .layoutWeight(1)
      
      Column({ align: HorizontalAlign.End }) {
        Text(statement.amount)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .textAlign(TextAlign.End)
        
        Text(statement.transactionDate)
          .fontSize(11)
          .fontColor('#7A7979')
      }
    }
    .width('100%')
    .padding({ left: 15, right: 15, top: 7, bottom: 7 })
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomNavBar() {
    Row() {
      this.NavItem(MpesaScreen.Home, $r('app.media.ic_home'), "Home")
      this.NavItem(MpesaScreen.Transact, $r('app.media.ic_list'), "Transact")
      this.NavItem(MpesaScreen.Discover, $r('app.media.ic_search'), "Discover")
      this.NavItem(MpesaScreen.Growth, $r('app.media.ic_star'), "Growth")
    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceAround)
    .backgroundColor(Color.White)
  }

  @Builder
  NavItem(screen: MpesaScreen, iconRes: Resource, label: string) {
    Column() {
      Image(iconRes)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
        .fillColor(this.currentScreen === screen ? '#09AF00' : '#7A7979')
      
      Text(label)
        .fontSize(11)
        .fontColor(this.currentScreen === screen ? '#09AF00' : '#7A7979')
        .margin({ top: 4 })
    }
    .onClick(() => {
      this.currentScreen = screen;
    })
  }
}