import { router } from '@kit.ArkUI';

const PRIMARY_COLOR = '#2563EB';
const SECONDARY_COLOR = '#38BDF8';
const TERTIARY_COLOR = '#60A5FA';
const BACKGROUND_COLOR = '#F8FAFC';
const SURFACE_COLOR = '#FFFFFF';
const SURFACE_VARIANT_COLOR = '#E2E8F0';
const OUTLINE_COLOR = '#CBD5E1';
const ON_PRIMARY_COLOR = '#FFFFFF';
const ON_SECONDARY_COLOR = '#0F172A';
const ON_BACKGROUND_COLOR = '#0F172A';
const ON_SURFACE_COLOR = '#1E293B';

@Component
struct MarkerBox {
  unit: string = '';
  value: string = '';
  active: boolean = false;

  build() {
    Row() {
      Column() {
        Text(this.unit)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(ON_SURFACE_COLOR)
        Text(this.value)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(ON_SURFACE_COLOR)
      }
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(80)
    .backgroundColor(this.active ? '#4DD6F3FC' : SURFACE_COLOR)
    .borderRadius(10)
    .border({ width: 1, color: OUTLINE_COLOR })
    .padding(10)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct MapArea {
  selected: string = '';

  build() {
    Column() {
      Text('Unit Map Visualization')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(ON_SURFACE_COLOR)
      Blank().height(10)
      Text(`Active Unit: ${this.selected}`)
        .fontSize(12)
        .fontWeight(FontWeight.Normal)
        .fontColor(ON_SURFACE_COLOR)
    }
    .width('100%')
    .height(240)
    .backgroundColor(SURFACE_VARIANT_COLOR)
    .borderRadius(14)
    .border({ width: 1, color: OUTLINE_COLOR })
    .padding(14)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}

@Entry
@Component
struct RootScreen {
  markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  @State active: string = 'Length';

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 180,
          colors: [['#26B8E8F8', 0.0], ['#26DBEAFB', 1.0]]
        })

      Scroll() {
        Column() {
          Text('Unit Converter')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(ON_BACKGROUND_COLOR)
            .margin({ bottom: 14 })

          MapArea({ selected: this.active })
            .margin({ bottom: 14 })

          ForEach(this.markers, (item: string) => {
            MarkerBox({
              unit: item,
              value: 'Tap to convert',
              active: this.active === item
            })
              .margin({ bottom: 14 })
          })

          Blank().height(10)

          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Center }) {
            ForEach(this.markers, (item: string) => {
              Button(item)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.active === item ? ON_PRIMARY_COLOR : ON_SURFACE_COLOR)
                .backgroundColor(this.active === item ? PRIMARY_COLOR : SURFACE_VARIANT_COLOR)
                .borderRadius(10)
                .margin(5)
                .onClick(() => {
                  this.active = item;
                })
            })
          }
          .width('100%')
          .margin({ bottom: 14 })
        }
        .padding(14)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_COLOR)
  }
}