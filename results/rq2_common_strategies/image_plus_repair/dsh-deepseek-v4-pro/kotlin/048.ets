// Translated from Kotlin/Compose to ArkTS/ArkUI
// Source: 048.kt — "063*LiveShop*en" ECommerce / Modern Blue theme

const PRIMARY: string = '#1E3A8A';
const SECONDARY: string = '#3B82F6';
const TERTIARY: string = '#60A5FA';
const BACKGROUND: string = '#F5F8FF';
const SURFACE: string = '#FFFFFF';
const SURFACE_VARIANT: string = '#E8EEFA';
const OUTLINE: string = '#CBD5E1';
const SUCCESS: string = '#22C55E';
const WARNING: string = '#F59E0B';
const ERROR: string = '#EF4444';
const ON_PRIMARY: string = '#FFFFFF';
const ON_SECONDARY: string = '#FFFFFF';
const ON_TERTIARY: string = '#0B1220';
const ON_BACKGROUND: string = '#0B1220';
const ON_SURFACE: string = '#0B1220';

const SP_SM: number = 6;
const SP_MD: number = 10;
const SP_LG: number = 16;
const SP_XL: number = 24;
const SP_XXL: number = 36;

const RADIUS_SMALL: number = 6;
const RADIUS_MEDIUM: number = 10;
const RADIUS_LARGE: number = 16;

interface LiveItem {
  id: number;
  title: string;
  viewers: number;
  price: string;
}

const liveList: LiveItem[] = [
  { id: 1, title: 'Smartphone Flash Deal', viewers: 1234, price: '$699' },
  { id: 2, title: 'Gaming Chair Special', viewers: 880, price: '$249' },
  { id: 3, title: 'Headphones Clearance', viewers: 1640, price: '$99' },
  { id: 4, title: 'Mechanical Keyboard', viewers: 512, price: '$129' }
];

@Entry
@Component
struct RootScreen {
  @State items: LiveItem[] = liveList;

  @Builder
  LiveCard(item: LiveItem) {
    Column() {
      Column({ space: SP_SM }) {
        Column()
          .width('100%')
          .height(160)
          .backgroundColor(SECONDARY)
          .borderRadius(RADIUS_MEDIUM)

        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE)

        Text(item.viewers + ' viewers')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(TERTIARY)

        Row() {
          Text(item.price)
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(PRIMARY)

          Button('Join Live')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .backgroundColor(PRIMARY)
            .fontColor(ON_PRIMARY)
            .borderRadius(RADIUS_MEDIUM)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .padding(SP_LG)
    }
    .width('100%')
    .padding(SP_MD)
    .borderRadius(RADIUS_LARGE)
    .backgroundColor(SURFACE)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(PRIMARY)
      Text('Live')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
      Text('Cart')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
      Text('Profile')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE)
    }
    .width('100%')
    .padding({ left: SP_LG, right: SP_LG })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(SURFACE)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column({ space: SP_MD }) {
          Text('Live Shop Events')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(PRIMARY)

          List({ space: SP_MD }) {
            ForEach(this.items, (item: LiveItem) => {
              ListItem() {
                this.LiveCard(item)
              }
              .padding({ bottom: SP_MD })
            }, (item: LiveItem) => item.id.toString())
          }
          .width('100%')
          .layoutWeight(1)
          .contentEndOffset(96)
        }
        .width('100%')
        .height('100%')
        .padding(SP_LG)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[BACKGROUND, 0.0], [SURFACE_VARIANT, 0.5], [BACKGROUND, 1.0]]
      })

      Button() {
        Text('+')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SECONDARY)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(SECONDARY)
      .margin({ right: SP_LG, bottom: SP_XL + SP_LG })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
  }
}
