// 112*ClientDetail*en - Dashboard - Warm Gradient (translated from Kotlin/Compose)
interface Palette {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  success: string;
  warning: string;
  error: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const C: Palette = {
  primary: '#FF7043',
  secondary: '#FFB74D',
  tertiary: '#FFD54F',
  background: '#FFF8E1',
  surface: '#FFFFFF',
  surfaceVariant: '#FFECB3',
  outline: '#E0C097',
  success: '#43A047',
  warning: '#FBC02D',
  error: '#E53935',
  onPrimary: '#FFFFFF',
  onSecondary: '#3E2723',
  onTertiary: '#3E2723',
  onBackground: '#3E2723',
  onSurface: '#3E2723'
};

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}

@Entry
@Component
struct ClientDetailPage {
  @State selectedId: number = -1;
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;
  private gridIndex: number[] = [0, 1, 2, 3, 4, 5];

  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  markerColor(level: string): string {
    if (level === 'A') {
      return C.primary;
    }
    if (level === 'B') {
      return C.secondary;
    }
    return C.tertiary;
  }

  @Builder
  MapGrid() {
    Column() {
      ForEach(this.gridIndex, (item: number) => {
        Row()
          .width('100%')
          .height(1)
          .backgroundColor(C.surfaceVariant)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceEvenly)

    Row() {
      ForEach(this.gridIndex, (item: number) => {
        Column()
          .width(1)
          .height('100%')
          .backgroundColor(C.surfaceVariant)
      }, (item: number) => item.toString())
    }
    .width('100%')
    .height('100%')
    .padding(16)
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  MapMarker(c: Client, selected: boolean, px: number, py: number) {
    Stack({ alignContent: Alignment.TopStart }) {
      Stack()
        .width(selected ? 28 : 22)
        .height(selected ? 28 : 22)
        .backgroundColor(this.markerColor(c.level))
        .borderRadius(selected ? 14 : 11)
        .border({ width: 2, color: selected ? C.onPrimary : C.surface })

      Text(c.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C.onSurface)
        .backgroundColor(C.surfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: C.outline })
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .offset({ x: 20, y: -4 })
        .onClick(() => {
          this.selectedId = (this.selectedId === c.id) ? -1 : c.id;
        })
    }
    .position({ x: px, y: py })
  }

  @Builder
  MapArea() {
    Stack({ alignContent: Alignment.TopStart }) {
      this.MapGrid()
      ForEach(this.clients, (c: Client) => {
        this.MapMarker(c, this.selectedId === c.id, this.mapWidth * c.x, this.mapHeight * c.y)
      }, (c: Client) => c.id.toString())
    }
    .width('100%')
    .constraintSize({ minHeight: 360 })
    .aspectRatio(0.9)
    .backgroundColor(C.surface)
    .borderRadius(16)
    .border({ width: 1, color: C.outline })
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.mapWidth = Number(newValue.width);
      this.mapHeight = Number(newValue.height);
    })
  }

  @Builder
  ClientList() {
    List({ space: 12 }) {
      ForEach(this.clients, (c: Client) => {
        ListItem() {
          Row() {
            Column({ space: 4 }) {
              Text(c.name)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(C.onSurface)
              Text(c.region)
                .fontSize(14)
                .fontWeight(FontWeight.Normal)
                .fontColor(C.onSurface)
            }
            .alignItems(HorizontalAlign.Start)

            Text('Level ' + c.level)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(C.primary)
          }
          .width('100%')
          .padding(16)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
        }
        .backgroundColor(C.surface)
        .borderRadius(12)
        .border({ width: 1, color: C.outline })
      }, (c: Client) => c.id.toString())
    }
    .width('100%')
    .layoutWeight(1)
    .padding({ bottom: 32 })
    .divider({ strokeWidth: 0 })
    .scrollBar(BarState.Off)
  }

  build() {
    Column() {
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(C.onSurface)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(C.surface)

      Column({ space: 12 }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Regional Client Map')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(C.onPrimary)
        }
        .width('100%')
        .height(200)
        .linearGradient({ angle: 135, colors: [[C.secondary, 0], [C.primary, 1]] })
        .borderRadius(16)

        this.MapArea()

        this.ClientList()
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C.background)
  }
}
