const PRIMARY: number = 0xFFFF7043;
const SECONDARY: number = 0xFFFFB74D;
const TERTIARY: number = 0xFFFFD54F;
const BACKGROUND: number = 0xFFFFF8E1;
const SURFACE: number = 0xFFFFFFFF;
const SURFACE_VARIANT: number = 0xFFFFECB3;
const OUTLINE: number = 0xFFE0C097;
const ON_SURFACE: number = 0xFF3E2723;

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

const CLIENTS: Client[] = [
  { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.20, y: 0.30 },
  { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.50, y: 0.45 },
  { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.60 },
  { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
];

function markerColor(level: string): number {
  if (level === 'A') {
    return PRIMARY;
  }
  if (level === 'B') {
    return SECONDARY;
  }
  return TERTIARY;
}

@Component
struct MapMarker {
  @Prop client: Client;
  @Prop selected: boolean;
  onTap: () => void = () => {};

  build() {
    Stack() {
      Circle()
        .width(this.selected ? 30 : 26)
        .height(this.selected ? 30 : 26)
        .fill(markerColor(this.client.level))
        .strokeWidth(2)
        .stroke(SURFACE)
        .position({ x: `${this.client.x * 100}%`, y: `${this.client.y * 100}%` });

      Text(this.client.name)
        .fontSize(24)
        .fontColor(ON_SURFACE)
        .fontWeight(FontWeight.Medium)
        .padding({ left: 16, right: 16, top: 7, bottom: 7 })
        .backgroundColor(SURFACE_VARIANT)
        .borderRadius(16)
        .border({ width: 1, color: OUTLINE })
        .shadow({ radius: 8, color: 0x26000000, offsetY: 3 })
        .position({ x: `calc(${this.client.x * 100}% + 20vp)`, y: `calc(${this.client.y * 100}% - 4vp)` })
        .onClick(() => this.onTap());
    }
    .width('100%')
    .height('100%');
  }
}

@Component
struct MapGrid {
  build() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (index: number) => {
        Row()
          .height(1)
          .width('100%')
          .backgroundColor(SURFACE_VARIANT)
          .position({ x: 0, y: `${16 + ((100 - 32) / 7) * index}%` });
      });
      ForEach([1, 2, 3, 4, 5, 6], (index: number) => {
        Column()
          .width(1)
          .height('100%')
          .backgroundColor(SURFACE_VARIANT)
          .position({ x: `${16 + ((100 - 32) / 7) * index}%`, y: 0 });
      });
    }
    .width('100%')
    .height('100%')
    .padding(16);
  }
}

@Entry
@Component
struct ClientDetailPage {
  @State selectedId: number = 0;

  build() {
    Column() {
      Text('Client Detail')
        .fontSize(52)
        .fontWeight(FontWeight.Bold)
        .fontColor(ON_SURFACE)
        .width('100%')
        .textAlign(TextAlign.Center)
        .height(104)
        .padding({ top: 25, bottom: 12 });

      Scroll() {
        Column({ space: 24 }) {
          Stack() {
            Row()
              .width('100%')
              .height('100%')
              .linearGradient({
                angle: 90,
                direction: GradientDirection.Right,
                colors: [[SECONDARY, 0.0], [PRIMARY, 1.0]]
              })
              .borderRadius(36);

            Text('Regional Client Map')
              .fontSize(40)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White);
          }
          .width('calc(100% - 32vp)')
          .height(400)
          .margin({ top: 16 });

          Stack() {
            Column()
              .width('100%')
              .height('100%')
              .backgroundColor(SURFACE)
              .borderRadius(36)
              .border({ width: 2, color: OUTLINE });

            MapGrid();

            ForEach(CLIENTS, (client: Client) => {
              MapMarker({
                client: client,
                selected: this.selectedId === client.id,
                onTap: () => {
                  this.selectedId = this.selectedId === client.id ? 0 : client.id;
                }
              });
            }, (client: Client) => client.id.toString());
          }
          .width('calc(100% - 32vp)')
          .height(760);

          Column({ space: 16 }) {
            ForEach(CLIENTS, (client: Client) => {
              Row() {
                Column({ space: 4 }) {
                  Text(client.name)
                    .fontSize(22)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(ON_SURFACE);
                  Text(client.region)
                    .fontSize(18)
                    .fontColor(ON_SURFACE);
                }
                .alignItems(HorizontalAlign.Start);

                Blank();

                Text(`Level ${client.level}`)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(PRIMARY);
              }
              .width('100%')
              .height(82)
              .padding(16)
              .backgroundColor(SURFACE)
              .borderRadius(16)
              .border({ width: 1, color: OUTLINE })
              .shadow({ radius: 8, color: 0x26000000, offsetY: 3 });
            }, (client: Client) => client.id.toString());
          }
          .width('calc(100% - 32vp)')
          .padding({ bottom: 32 });
        }
        .width('100%')
        .alignItems(HorizontalAlign.Center);
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off);
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
  }
}
