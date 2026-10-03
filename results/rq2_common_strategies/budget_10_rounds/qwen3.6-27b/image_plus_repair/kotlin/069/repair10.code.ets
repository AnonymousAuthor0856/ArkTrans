import { router } from '@kit.ArkUI';

// Design Tokens and Constants
const NAME = "131*SupplyHub*en";
const UI_TYPE = "Grid";
const STYLE_THEME = "Muted Earth";
const LANG = "en";
const BASELINE_SIZE = "720x1280";
const COLOR_PALETTE = "primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C background:#100C08 surface:#19110D surfaceVariant:#2A1C14 outline:#4F3A2C success:#6ECE89 warning:#E19F41 error:#D96666 onPrimary:#100C08 onSecondary:#100C08 onTertiary:#120E04 onBackground:#F7EAD8 onSurface:#FBEFE0";
const DENSITY_SPACING = "Medium";
const COMPLEXITY = "Grid,Image,LazyList";
const EXTRA = "Muted earth cargo grid with image placeholders";

interface CargoCard {
  title: string;
  id: string;
  fill: string;
}

interface ManifestEntry {
  origin: string;
  destination: string;
  status: string;
}

interface HubFilter {
  label: string;
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'All';
  private cards: CargoCard[] = [
    { title: "Copper stack", id: "SH-014", fill: "78%" },
    { title: "Fiber reels", id: "SH-022", fill: "64%" },
    { title: "Agro crates", id: "SH-031", fill: "92%" },
    { title: "Glass kits", id: "SH-045", fill: "51%" },
    { title: "Steel mesh", id: "SH-057", fill: "88%" },
    { title: "Raw silica", id: "SH-063", fill: "43%" }
  ];
  private manifest: ManifestEntry[] = [
    { origin: "Santiago", destination: "Lima", status: "Boarding" },
    { origin: "Mecca", destination: "Algiers", status: "At dock" },
    { origin: "Reykjavík", destination: "Oslo", status: "Delayed" },
    { origin: "Perth", destination: "Jakarta", status: "In flight" }
  ];
  private filters: HubFilter[] = [
    { label: "All" },
    { label: "Atlantic" },
    { label: "Pacific" },
    { label: "Inland" }
  ];

  build() {
    Column() {
      // Top Bar
      Row() {
        Button()
          .width(26)
          .height(26)
          .backgroundColor('#2A1C14')
          .borderRadius(13)
          .onClick(() => {
            // Handle navigation icon click
          })

        Column() {
          Text('SupplyHub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
          Text('Logistics grid')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.Gray)
        }
        .alignItems(HorizontalAlign.Center)

        Button()
          .width(26)
          .height(26)
          .backgroundColor('#2A1C14')
          .borderRadius(13)
          .onClick(() => {
            // Handle action icon click
          })
      }
      .width('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#19110D')

      // Main Content
      Scroll() {
        Column() {
          // Filter Buttons
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.filters, (filter: HubFilter) => {
              Button(filter.label)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.activeFilter === filter.label ? '#100C08' : '#FBEFE0')
                .backgroundColor(this.activeFilter === filter.label ? '#C27D38' : '#2A1C14')
                .borderRadius(10)
                .margin({ right: 10, bottom: 10 })
                .onClick(() => {
                  this.activeFilter = filter.label;
                })
            })
          }
          .width('100%')
          .padding({ left: 26, right: 26 })

          // Cargo Grid Section
          Column() {
            Text('Cargo grid')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FBEFE0')
              .margin({ top: 26, bottom: 18 })

            GridContainer()
              .columnsTemplate('1fr 1fr')
              .rowsTemplate('auto')
              .gap(14)
              .width('100%')
              .padding({ left: 26, right: 26 })
              .childCount(this.cards.length)
              .getComponent((index: number): Component => {
                const card = this.cards[index];
                return new CargoCardItem({ card: card });
              })
          }
          .width('100%')

          // Route Manifest Section
          Column() {
            Text('Route manifest')
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FBEFE0')
              .margin({ top: 26, bottom: 18 })

            ForEach(this.manifest, (entry: ManifestEntry) => {
              ManifestItem({ entry: entry });
            })
          }
          .width('100%')
          .padding({ left: 26, right: 26, bottom: 100 }) // Bottom padding for bottom bar
        }
        .width('100%')
      }
      .layoutWeight(1)
      .backgroundColor('#100C08')

      // Bottom Bar
      Row() {
        Column() {
          Text('Manifest filter')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
          Text(this.activeFilter)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FBEFE0')
        }
        .alignItems(HorizontalAlign.Start)

        Button('Dispatch')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#100C08')
          .backgroundColor('#8B6B4C')
          .borderRadius(18)
          .margin({ left: 20 })
          .onClick(() => {
            // Handle dispatch button click
          })
      }
      .width('100%')
      .padding({ left: 26, right: 26, top: 18, bottom: 18 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#19110D')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#100C08')
  }
}

@Component
struct CargoCardItem {
  @Prop card: CargoCard;

  build() {
    Column() {
      // Image Placeholder
      Row() {
        Circle()
          .width(60)
          .height(60)
          .fill('#F2C57C')
          .opacity(0.4)
      }
      .width('100%')
      .height(90)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#19110D')
      .borderRadius(10)

      Column() {
        Text(this.card.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FBEFE0')
        Text(this.card.id)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(Color.Gray)
        Text(`Fill ${this.card.fill}`)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#6ECE89')
      }
      .margin({ top: 14 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(18)
    .backgroundColor('#2A1C14')
    .borderRadius(18)
  }
}

@Component
struct ManifestItem {
  @Prop entry: ManifestEntry;

  build() {
    Row() {
      Column() {
        Text(`${this.entry.origin} → ${this.entry.destination}`)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FBEFE0')
        Text(this.entry.status)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.getStatusColor())
      }
      .alignItems(HorizontalAlign.Start)

      Button('Details')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#100C08')
        .backgroundColor('#C27D38')
        .borderRadius(10)
        .margin({ left: 20 })
        .onClick(() => {
          // Handle details button click
        })
    }
    .width('100%')
    .padding(18)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor('#2A1C14')
    .borderRadius(18)
    .margin({ bottom: 14 })
  }

  private getStatusColor(): Color {
    switch (this.entry.status) {
      case 'Delayed':
        return new Color('#E19F41');
      case 'In flight':
        return new Color('#6ECE89');
      default:
        return Color.Gray;
    }
  }
}