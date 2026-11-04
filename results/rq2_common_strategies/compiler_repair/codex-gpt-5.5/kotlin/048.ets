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

class AppColors {
  static readonly primary: string = '#1E3A8A';
  static readonly secondary: string = '#3B82F6';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F5F8FF';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E8EEFA';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onSurface: string = '#0B1220';
}

@Entry
@Component
struct Index {
  private liveList: LiveItem[] = [
    new LiveItem(1, 'Smartphone Flash Deal', 1234, '$699'),
    new LiveItem(2, 'Gaming Chair Special', 880, '$249'),
    new LiveItem(3, 'Headphones Clearance', 1640, '$99'),
    new LiveItem(4, 'Mechanical Keyboard', 512, '$129')
  ];

  @Builder
  LiveCard(item: LiveItem) {
    Column() {
      Text('')
        .width('100%')
        .height(160)
        .backgroundColor(AppColors.secondary)
        .borderRadius(10)

      Text(item.title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ top: 6 })

      Text(item.viewers.toString() + ' viewers')
        .fontSize(14)
        .fontColor(AppColors.tertiary)
        .width('100%')
        .margin({ top: 6 })

      Row() {
        Text(item.price)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primary)
          .layoutWeight(1)

        Button('Join Live')
          .fontSize(12)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(10)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .shadow({ radius: 4, color: '#1F000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(14)
        .fontColor(AppColors.primary)
      Text('Live')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
      Text('Cart')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
      Text('Profile')
        .fontSize(14)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Live Shop Events')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)
          .width('100%')
          .margin({ bottom: 10 })

        Scroll() {
          Column() {
            ForEach(this.liveList, (item: LiveItem) => {
              Column() {
                this.LiveCard(item)
              }
              .margin({ bottom: 10 })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .padding({ bottom: 96 })
        }
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 64 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[AppColors.background, 0.0], [AppColors.surfaceVariant, 0.5], [AppColors.background, 1.0]]
      })

      Column() {
        this.BottomBar()
      }
      .width('100%')
      .align(Alignment.Bottom)

      Button('+')
        .fontSize(24)
        .fontColor(AppColors.onSecondary)
        .backgroundColor(AppColors.secondary)
        .width(56)
        .height(56)
        .borderRadius(28)
        .margin({ right: 24, bottom: 76 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
