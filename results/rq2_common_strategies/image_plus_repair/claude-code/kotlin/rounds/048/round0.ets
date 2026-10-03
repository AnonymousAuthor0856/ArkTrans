@Entry
@Component
struct LiveShopPage {
  private liveList: LiveItem[] = [
    new LiveItem(1, "Smartphone Flash Deal", 1234, "$699"),
    new LiveItem(2, "Gaming Chair Special", 880, "$249"),
    new LiveItem(3, "Headphones Clearance", 1640, "$99"),
    new LiveItem(4, "Mechanical Keyboard", 512, "$129")
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text("Live Shop Events")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.primary)
          .width('100%')
          .margin({ left: 16, right: 16, top: 16, bottom: 10 })

        List({ space: 10 }) {
          ForEach(this.liveList, (item: LiveItem) => {
            ListItem() {
              this.LiveCardItem(item)
            }
          }, (item: LiveItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 96 })
      }
      .width('100%')
      .height('100%')
      .background({
        linearGradient: {
          angle: 180,
          colors: [
            [AppTokens.Colors.background, 0],
            [AppTokens.Colors.surfaceVariant, 0.5],
            [AppTokens.Colors.background, 1]
          ]
        }
      })

      // Bottom Navigation Bar
      Row() {
        Text("Home")
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.primary)

        Text("Live")
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)

        Text("Cart")
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)

        Text("Profile")
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppTokens.Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppTokens.Colors.surface)
      .justifyContent(FlexAlign.SpaceAround)
      .alignItems(VerticalAlign.Center)

      // Floating Action Button
      Text("+")
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSecondary)
        .width(56)
        .height(56)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.secondary)
        .borderRadius(28)
        .margin({ right: 24, bottom: 88 })
        .shadow({
          radius: 8,
          color: 'rgba(0,0,0,0.18)',
          offsetX: 0,
          offsetY: 4
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }

  @Builder
  LiveCardItem(item: LiveItem) {
    Column({ space: 6 }) {
      // Image placeholder
      Row() {}
      .width('100%')
      .height(160)
      .backgroundColor(AppTokens.Colors.secondary)
      .borderRadius(10)

      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Text(item.viewers.toString() + " viewers")
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppTokens.Colors.tertiary)

      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.primary)

        Button("Join Live")
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(10)
          .height(40)
          .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(16)
    .shadow({
      radius: 4,
      color: 'rgba(0,0,0,0.12)',
      offsetX: 0,
      offsetY: 2
    })
  }
}

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

namespace AppTokens {
  export namespace Colors {
    export const primary: string = '#FF1E3A8A';
    export const secondary: string = '#FF3B82F6';
    export const tertiary: string = '#FF60A5FA';
    export const background: string = '#FFF5F8FF';
    export const surface: string = '#FFFFFFFF';
    export const surfaceVariant: string = '#FFE8EEFA';
    export const outline: string = '#FFCBD5E1';
    export const success: string = '#FF22C55E';
    export const warning: string = '#FFF59E0B';
    export const error: string = '#FFEF4444';
    export const onPrimary: string = '#FFFFFFFF';
    export const onSecondary: string = '#FFFFFFFF';
    export const onTertiary: string = '#FF0B1220';
    export const onBackground: string = '#FF0B1220';
    export const onSurface: string = '#FF0B1220';
  }
}
