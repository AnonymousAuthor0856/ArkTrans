// index.ets
import { Length, ResourceStr } from '@ohos.kit';

// --- Data Models ---

interface TeaGuide {
  id: number;
  name: string;
  origin: string;
  temp: string;
  time: string;
  colorCode: ResourceColor;
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

// --- UI Components ---

@Component
struct InfoBadge {
  private label: string = "";

  build() {
    Text(this.label)
      .fontSize(11)
      .fontColor("#000000")
      .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      .backgroundColor("#FFFFFF")
      .borderRadius(6)
      .border({ width: 1, color: "#E0E0E0" });
  }
}

@Component
struct PromoCard {
  private textColor: ResourceColor = "#121212";

  build() {
    Row() {
      Column() {
        Text("Tip of the day")
          .fontSize(12)
          .fontColor("#888888")
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 });
        Text("Use filtered water for a purer taste profile.")
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.textColor);
      }
      .layoutWeight(1);

      // Icon Circle
      Row() {
        Text("ℹ")
          .fontSize(20)
          .fontColor("#888888");
      }
      .width(48)
      .height(48)
      .backgroundColor("#FFFFFF")
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center);
    }
    .padding(24)
    .width("100%")
    .backgroundColor("#F0F0F0")
    .borderRadius(20)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center);
  }
}

@Component
struct TeaItemCard {
  private tea: TeaGuide = sampleTeas[0];
  private bgColor: ResourceColor = "#F9F9F9";
  private titleColor: ResourceColor = "#121212";
  private subtitleColor: ResourceColor = "#757575";

  build() {
    Row() {
      // Visual Dot identifier
      Stack() {
        Text(this.tea.name.charAt(0))
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.tea.colorCode);
      }
      .width(50)
      .height(50)
      .backgroundColor("#FFFFFF")
      .borderRadius(25)
      .border({ width: 2, color: this.tea.colorCode });

      Column() {
        Text(this.tea.name)
          .fontSize(17)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.titleColor);
        Text(this.tea.origin)
          .fontSize(12)
          .fontColor(this.subtitleColor)
          .margin({ top: 2 });

        Row() {
          InfoBadge({ label: this.tea.temp })
          InfoBadge({ label: this.tea.time })
        }
        .margin({ top: 6 })
        .alignItems(VerticalAlign.Center);
      }
      .layoutWeight(1)
      .margin({ left: 16 });

      // Play Button
      Stack() {
        Text("▶")
          .fontSize(16)
          .fontColor(this.titleColor);
      }
      .width(40)
      .height(40)
      .backgroundColor("#FFFFFF")
      .borderRadius(20)
      .border({ width: 1, color: "#E0E0E0" })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center);
    }
    .width("100%")
    .padding(16)
    .backgroundColor(this.bgColor)
    .borderRadius(16)
    .border({ width: 1, color: "#EEEEEE" })
    .alignItems(VerticalAlign.Center);
  }
}

@Entry
@Component
struct ZenBrewApp {
  private primaryBlack: ResourceColor = "#121212";
  private textGrey: ResourceColor = "#757575";
  private backgroundWhite: ResourceColor = "#FFFFFF";
  private cardBackground: ResourceColor = "#F9F9F9";

  build() {
    Column() {
      // TopAppBar
      Row() {
        Column() {
          Text("ZenBrew")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.primaryBlack);
          Text("Mindful Steeping Guide")
            .fontSize(14)
            .fontColor(this.textGrey)
            .margin({ top: 2 });
        }
        .layoutWeight(1);

        Text("⚙")
          .fontSize(24)
          .fontColor(this.primaryBlack);
      }
      .width("100%")
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      .backgroundColor(this.backgroundWhite);

      // Content List
      Scroll() {
        Column() {
          PromoCard({ textColor: this.primaryBlack });

          Text("Collections")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .margin({ top: 16, bottom: 8 });

          ForEach(sampleTeas, (tea: TeaGuide) => {
            TeaItemCard({
              tea: tea,
              bgColor: this.cardBackground,
              titleColor: this.primaryBlack,
              subtitleColor: this.textGrey
            })
            .margin({ bottom: 12 });
          });

          // Extra spacer for FAB
          Column().height(80);
        }
        .padding({ left: 20, right: 20, top: 10, bottom: 10 })
        .width("100%");
      }
      .layoutWeight(1)
      .backgroundColor(this.backgroundWhite);

      // Floating Action Button equivalent
      Row() {
        Text("+ Custom Brew")
          .fontSize(16)
          .fontColor("#FFFFFF");
      }
      .padding({ left: 24, right: 24, top: 16, bottom: 16 })
      .backgroundColor(this.primaryBlack)
      .borderRadius(16)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: 20 });
    }
    .width("100%")
    .height("100%")
    .backgroundColor(this.backgroundWhite);
  }
}