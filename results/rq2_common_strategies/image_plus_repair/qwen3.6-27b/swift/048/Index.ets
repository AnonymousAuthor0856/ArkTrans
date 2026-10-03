// App.ets
import { router } from '@kit.ArkUI';

@Entry
@Component
struct LiveShopApp {
  @State liveList: LiveItem[] = [
    new LiveItem(1, "Smartphone Flash Deal", 1234, "$699"),
    new LiveItem(2, "Gaming Chair Special", 880, "$249"),
    new LiveItem(3, "Headphones Clearance", 1640, "$99"),
    new LiveItem(4, "Mechanical Keyboard", 512, "$129")
  ];

  build() {
    Stack() {
      Column() {
        // Main Content Area
        Column({ space: 10 }) {
          Text("Live Shop Events")
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E3A8A')
            .alignSelf(ItemAlign.Start)

          Scroll() {
            Column({ space: 10 }) {
              ForEach(this.liveList, (item: LiveItem) => {
                LiveItemCard({ item: item })
              }, (item: LiveItem) => item.id.toString())
            }
            .padding({ bottom: 96 }) // Padding for FAB
          }
          .layoutWeight(1)
          .scrollBar(BarState.Off)
        }
        .padding(16)
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 90,
          colors: [['#F5F8FF', 0], ['#E8EEFA', 0.5], ['#F5F8FF', 1]]
        })

        // Bottom Navigation Bar
        BottomNavBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F8FF')

      // Floating Action Button (FAB)
      Row() {
        Blank()
        Button() {
          Text("+")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width(56)
        .height(56)
        .backgroundColor('#3B82F6')
        .borderRadius(28)
        .margin({ right: 16, bottom: 96 }) // 16 margin + 80 bar height
      }
      .width('100%')
      .position({ x: 0, y: '100%' }) 
      .translate({ y: -70 }) // Adjust position to sit above nav bar
    }
    .width('100%')
    .height('100%')
  }
}

// Helper Class for Data Model
class LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;

  constructor(id: number, title: string, viewers: number, price: string) {
    this.id = id;
    this.title = title;
    this.viewers = viewers;
    this.price = price;
  }
}

@Component
struct LiveItemCard {
  @Prop item: LiveItem;

  build() {
    Column({ space: 6 }) {
      // Placeholder Image
      Rect()
        .fill('#3B82F6')
        .width('100%')
        .height(160)
        .borderRadius(10)

      Text(this.item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#0B1220')
        .alignSelf(ItemAlign.Start)

      Text(`${this.item.viewers.toLocaleString()} viewers`)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#60A5FA')
        .alignSelf(ItemAlign.Start)

      Row() {
        Text(this.item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1E3A8A')
        
        Blank()

        Button("Join Live")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
          .backgroundColor('#1E3A8A')
          .borderRadius(10)
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      }
    }
    .padding(16)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 4, color: 'rgba(0, 0, 0, 0.12)', offsetY: 2 })
  }
}

@Component
struct BottomNavBar {
  build() {
    Row() {
      Text("Home")
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#1E3A8A')
      
      Text("Live")
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#0B1220')
      
      Text("Cart")
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#0B1220')
      
      Text("Profile")
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor('#0B1220')
    }
    .width('100%')
    .height(80)
    .justifyContent(FlexAlign.SpaceEvenly)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 0.5, color: 'rgba(0, 0, 0, 0.1)', offsetY: -1 })
  }
}