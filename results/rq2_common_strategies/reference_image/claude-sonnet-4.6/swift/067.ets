// ClientDetailPage.ets

interface ClientModel {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number; // relative X (0.0 - 1.0)
  y: number; // relative Y (0.0 - 1.0)
}

// MARK: - AppTokens / Colors
const C_PRIMARY: string = '#FF7043';
const C_SECONDARY: string = '#FFB74D';
const C_TERTIARY: string = '#FFD54F';
const C_BACKGROUND: string = '#FFF8E1';
const C_SURFACE: string = '#FFFFFF';
const C_SURFACE_VARIANT: string = '#FFECB3';
const C_OUTLINE: string = '#E0C097';
const C_ON_PRIMARY: string = '#FFFFFF';
const C_ON_SURFACE: string = '#3E2723';

// MARK: - Spacing / Shapes / Elevation
const SP_XS: number = 4;
const SP_SM: number = 8;
const SP_MD: number = 12;
const SP_LG: number = 16;
const SP_XXL: number = 32;

const R_SMALL: number = 8;
const R_MEDIUM: number = 12;
const R_LARGE: number = 16;

const ELEV1_RADIUS: number = 4;
const ELEV1_DY: number = 2;
const ELEV1_COLOR: string = 'rgba(0, 0, 0, 0.10)';

@Entry
@Component
struct ClientDetailPage {
  @State selectedId: number = -1;

  private clients: ClientModel[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  private gridIndexes: number[] = [0, 1, 2, 3, 4, 5, 6];

  private markerColor(level: string): string {
    if (level === 'A') {
      return C_PRIMARY;
    }
    if (level === 'B') {
      return C_SECONDARY;
    }
    return C_TERTIARY;
  }

  // MARK: - Top App Bar
  @Builder
  TopBar() {
    Row() {
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_SURFACE)
    }
    .width('100%')
    .height(56)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(C_BACKGROUND)
  }

  // MARK: - Gradient banner
  @Builder
  Banner() {
    Row() {
      Text('Regional Client Map')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(C_ON_PRIMARY)
    }
    .width('100%')
    .height(200)
    .justifyContent(FlexAlign.Center)
    .borderRadius(R_LARGE)
    .linearGradient({
      angle: 90,
      colors: [[C_SECONDARY, 0.0], [C_PRIMARY, 1.0]]
    })
  }

  // MARK: - Map grid overlay (6 lines => 7 evenly spaced segments)
  @Builder
  MapGrid() {
    Column() {
      ForEach(this.gridIndexes, (row: number) => {
        Row() {
          ForEach(this.gridIndexes, (col: number) => {
            Column()
              .layoutWeight(1)
              .height('100%')
              .border({
                width: { right: col < 6 ? 1 : 0, bottom: row < 6 ? 1 : 0 },
                color: C_SURFACE_VARIANT,
                style: BorderStyle.Solid
              })
          }, (col: number) => `col_${col}`)
        }
        .width('100%')
        .layoutWeight(1)
      }, (row: number) => `row_${row}`)
    }
    .width('100%')
    .height('100%')
    .padding(SP_LG)
  }

  // MARK: - Map marker (dot + label card)
  @Builder
  Marker(client: ClientModel) {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selectedId === client.id ? 28 : 22)
        .height(this.selectedId === client.id ? 28 : 22)
        .fill(this.markerColor(client.level))
        .stroke(this.selectedId === client.id ? C_ON_PRIMARY : C_SURFACE)
        .strokeWidth(2)

      Text(client.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(C_ON_SURFACE)
        .padding({
          left: SP_SM,
          right: SP_SM,
          top: SP_XS,
          bottom: SP_XS
        })
        .backgroundColor(C_SURFACE_VARIANT)
        .borderRadius(R_SMALL)
        .border({ width: 1, color: C_OUTLINE })
        .shadow({
          radius: ELEV1_RADIUS,
          color: ELEV1_COLOR,
          offsetX: 0,
          offsetY: ELEV1_DY
        })
        .offset({ x: 20, y: -4 })
        .onClick(() => {
          this.selectedId = this.selectedId === client.id ? -1 : client.id;
        })
    }
    .position({ x: `${client.x * 100}%`, y: `${client.y * 100}%` })
  }

  // MARK: - Map card
  @Builder
  MapCard() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(C_SURFACE)
        .borderRadius(R_LARGE)
        .border({ width: 1, color: C_OUTLINE })

      this.MapGrid()

      ForEach(this.clients, (client: ClientModel) => {
        this.Marker(client)
      }, (client: ClientModel) => `marker_${client.id}`)
    }
    .width('100%')
    .aspectRatio(0.8)
    .constraintSize({ minHeight: 360 })
    .clip(true)
  }

  // MARK: - Client list
  @Builder
  ClientList() {
    Column({ space: SP_MD }) {
      ForEach(this.clients, (client: ClientModel) => {
        Row() {
          Column({ space: SP_XS }) {
            Text(client.name)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(C_ON_SURFACE)
            Text(client.region)
              .fontSize(14)
              .fontWeight(FontWeight.Regular)
              .fontColor(C_ON_SURFACE)
          }
          .alignItems(HorizontalAlign.Start)

          Blank()

          Text(`Level ${client.level}`)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(C_PRIMARY)
        }
        .width('100%')
        .padding(SP_LG)
        .backgroundColor(C_SURFACE)
        .borderRadius(R_MEDIUM)
        .border({ width: 1, color: C_OUTLINE })
        .shadow({
          radius: ELEV1_RADIUS,
          color: ELEV1_COLOR,
          offsetX: 0,
          offsetY: ELEV1_DY
        })
        .onClick(() => {
          this.selectedId = this.selectedId === client.id ? -1 : client.id;
        })
      }, (client: ClientModel) => `card_${client.id}`)
    }
    .width('100%')
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: SP_MD }) {
          this.Banner()
          this.MapCard()
          this.ClientList()
        }
        .width('100%')
        .padding({
          left: SP_LG,
          right: SP_LG,
          top: SP_MD,
          bottom: SP_XXL
        })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .layoutWeight(1)
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
      .backgroundColor(C_BACKGROUND)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}