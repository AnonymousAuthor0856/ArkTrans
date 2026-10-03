import { router } from '@kit.ArkUI';

// --- Data Models ---
interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: string;
}

const sampleTeas: TeaGuide[] = [
  { id: 1, name: "Sencha Green", origin: "Japan", temp: "70°C / 158°F", time: "1-2 min", colorCode: "#8BC34A" },
  { id: 2, name: "Earl Grey", origin: "Blend", temp: "95°C / 203°F", time: "3-5 min", colorCode: "#795548" },
  { id: 3, name: "Silver Needle", origin: "China", temp: "80°C / 176°F", time: "3-4 min", colorCode: "#E0E0E0" },
  { id: 4, name: "Darjeeling", origin: "India", temp: "90°C / 194°F", time: "3 min", colorCode: "#D7CCC8" },
  { id: 5, name: "Chamomile", origin: "Egypt", temp: "100°C / 212°F", time: "5-7 min", colorCode: "#FFEB3B" },
  { id: 6, name: "Matcha", origin: "Japan", temp: "80°C / 176°F", time: "Whisk", colorCode: "#4CAF50" },
  { id: 7, name: "Oolong", origin: "Taiwan", temp: "85°C / 185°F", time: "3-5 min", colorCode: "#FF9800" }
];

// --- InfoBadge Component ---
@Component
struct InfoBadge {
  label: string = '';

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor('#000000')
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor('#FFFFFF')
      .borderRadius(6)
      .border({ width: 1, color: '#E0E0E0' })
  }
}

// --- PromoCard Component ---
@Component
struct PromoCard {
  build() {
    Row() {
      Column() {
        Text("Tip of the day")
          .fontSize(12)
          .fontColor('#9E9E9E')
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 })

        Text("Use filtered water for a purer taste profile.")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#121212')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(16)

      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(48)
          .height(48)
          .fill('#FFFFFF')

        Image($r('app.media.ic_public_info'))
          .width(24)
          .height(24)
          .fillColor('#9E9E9E')
      }
      .width(48)
      .height(48)
    }
    .width('100%')
    .padding(24)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceBetween)
    .backgroundColor('#F0F0F0')
    .borderRadius(20)
  }
}

// --- TeaItemCard Component ---
@Component
struct TeaItemCard {
  tea: TeaGuide = {
    id: 0,
    name: '',
    origin: '',
    temp: '',
    time: '',
    colorCode: '#000000'
  };

  build() {
    Row() {
      // Visual Dot identifier
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(50)
          .height(50)
          .fill('#FFFFFF')
          .stroke(this.tea.colorCode)
          .strokeWidth(2)

        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode)
      }
      .width(50)
      .height(50)
      .borderRadius(25)
      .backgroundColor('#FFFFFF')
      .border({ width: 2, color: this.tea.colorCode })

      Blank().width(16)

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')

        Text(this.tea.origin)
          .fontSize(12)
          .fontColor('#757575')

        Blank().height(6)

        Row() {
          InfoBadge({ label: this.tea.temp })
          Blank().width(8)
          InfoBadge({ label: this.tea.time })
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Play Button
      Stack({ alignContent: Alignment.Center }) {
        Circle()
          .width(40)
          .height(40)
          .fill('#FFFFFF')
          .stroke('#E0E0E0')
          .strokeWidth(1)

        Image($r('app.media.ic_public_play'))
          .width(20)
          .height(20)
          .fillColor('#121212')
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .backgroundColor('#FFFFFF')
      .border({ width: 1, color: '#E0E0E0' })
      .onClick(() => {})
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#F9F9F9')
    .borderRadius(16)
    .border({ width: 1, color: '#EEEEEE' })
  }
}

// --- Main Page ---
@Entry
@Component
struct ZenBrewApp {
  build() {
    Column() {
      // TopAppBar
      Row() {
        Column() {
          Text("ZenBrew")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#121212')
            .letterSpacing(-0.5)

          Text("Mindful Steeping Guide")
            .fontSize(14)
            .fontColor('#757575')
            .fontWeight(FontWeight.Normal)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Image($r('app.media.ic_public_settings'))
          .width(24)
          .height(24)
          .fillColor('#121212')
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 16, bottom: 16 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      // Scrollable Content
      Scroll() {
        Column() {
          // Promo Card
          PromoCard()
            .margin({ bottom: 16 })

          // Collections Header
          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#121212')
            .width('100%')
            .padding({ top: 8, bottom: 8 })

          // Tea Items
          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({ tea: tea })
              .margin({ bottom: 16 })
          }, (tea: TeaGuide) => tea.id.toString())

          // Bottom spacer for FAB
          Blank().height(80)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor('#FFFFFF')

      // FAB - Custom Brew Button
      Row() {
        Row() {
          Image($r('app.media.ic_public_add'))
            .width(20)
            .height(20)
            .fillColor('#FFFFFF')
            .margin({ right: 8 })

          Text("Custom Brew")
            .fontSize(16)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .height(56)
        .padding({ left: 20, right: 20 })
        .backgroundColor('#121212')
        .borderRadius(16)
        .onClick(() => {})
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
      .padding({ right: 20, bottom: 20, top: 10 })
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}