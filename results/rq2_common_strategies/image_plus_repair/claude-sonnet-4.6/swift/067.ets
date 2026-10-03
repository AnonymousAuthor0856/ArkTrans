// Design tokens
const colorPrimary: number = 0xFFFF7043;
const colorSecondary: number = 0xFFFFB74D;
const colorTertiary: number = 0xFFFFD54F;
const colorBackground: number = 0xFFFFF8E1;
const colorSurface: number = 0xFFFFFFFF;
const colorSurfaceVariant: number = 0xFFFFECB3;
const colorOutline: number = 0xFFE0C097;
const colorOnPrimary: number = 0xFFFFFFFF;
const colorOnSurface: number = 0xFF3E2723;

interface ClientData {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
        Divider()
          .width('100%')
          .height(1)
          .color(colorSurfaceVariant)
          .position({ x: 0, y: (i / 7.0) * 100 + '%' })
      })
      ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
        Divider()
          .vertical(true)
          .width(1)
          .height('100%')
          .color(colorSurfaceVariant)
          .position({ x: (i / 7.0) * 100 + '%', y: 0 })
      })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarkerView {
  label: string = '';
  level: string = '';
  selected: boolean = false;
  xRatio: number = 0;
  yRatio: number = 0;
  onMarkerClick: () => void = () => {};

  getMarkerColor(): number {
    if (this.level === 'A') {
      return colorPrimary;
    } else if (this.level === 'B') {
      return colorSecondary;
    } else {
      return colorTertiary;
    }
  }

  getDotSize(): number {
    return this.selected ? 28 : 22;
  }

  getDotOffset(): number {
    return this.selected ? -14 : -11;
  }

  getBorderColor(): number {
    return this.selected ? colorOnPrimary : colorSurface;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Stack() {
        Circle()
          .width(this.getDotSize())
          .height(this.getDotSize())
          .fill(this.getMarkerColor())
        Circle()
          .width(this.getDotSize())
          .height(this.getDotSize())
          .fill(Color.Transparent)
          .stroke(this.getBorderColor())
          .strokeWidth(2)
      }
      .position({
        x: this.xRatio * 100 + '%',
        y: this.yRatio * 100 + '%'
      })
      .translate({ x: this.getDotOffset(), y: this.getDotOffset() })

      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(colorOnSurface)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(colorSurfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: colorOutline, radius: 8 })
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .onClick(() => {
          this.onMarkerClick();
        })
        .position({
          x: this.xRatio * 100 + '%',
          y: this.yRatio * 100 + '%'
        })
        .translate({ x: 12, y: -14 })
    }
    .width('100%')
    .height('100%')
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedId: number = -1;

  clients: ClientData[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 },
  ];

  handleMarkerClick(clientId: number): void {
    if (this.selectedId === clientId) {
      this.selectedId = -1;
    } else {
      this.selectedId = clientId;
    }
  }

  build() {
    Column() {
      // Top Bar
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(colorOnSurface)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(colorBackground)

      // Scrollable content
      Scroll() {
        Column({ space: 12 }) {
          // Regional Client Map header
          Row() {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(colorOnPrimary)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .borderRadius(16)
          .linearGradient({
            angle: 90,
            colors: [[colorSecondary, 0.0], [colorPrimary, 1.0]]
          })
          .margin({ left: 16, right: 16, top: 12 })

          // Map area
          Stack({ alignContent: Alignment.TopStart }) {
            Column()
              .width('100%')
              .height('100%')
              .borderRadius(16)
              .backgroundColor(colorSurface)
              .border({ width: 1, color: colorOutline, radius: 16 })

            MapGridOverlay()
              .width('100%')
              .height('100%')

            ForEach(this.clients, (client: ClientData) => {
              MapMarkerView({
                label: client.name,
                level: client.level,
                selected: this.selectedId === client.id,
                xRatio: client.x,
                yRatio: client.y,
                onMarkerClick: () => {
                  this.handleMarkerClick(client.id);
                }
              })
            })
          }
          .width('100%')
          .height(400)
          .margin({ left: 16, right: 16 })

          // Client list
          Column({ space: 12 }) {
            ForEach(this.clients, (client: ClientData) => {
              Row() {
                Column({ space: 4 }) {
                  Text(client.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(colorOnSurface)
                  Text(client.region)
                    .fontSize(14)
                    .fontColor(colorOnSurface)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text('Level ' + client.level)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(colorPrimary)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(colorSurface)
              .borderRadius(12)
              .border({ width: 1, color: colorOutline, radius: 12 })
              .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 32 })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(colorBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}