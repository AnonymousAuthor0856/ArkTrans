class Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;

  constructor(id: number, name: string, region: string, level: string, x: number, y: number) {
    this.id = id;
    this.name = name;
    this.region = region;
    this.level = level;
    this.x = x;
    this.y = y;
  }
}

class ClientColors {
  static readonly primary: string = '#FF7043';
  static readonly secondary: string = '#FFB74D';
  static readonly tertiary: string = '#FFD54F';
  static readonly background: string = '#FFF8E1';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFECB3';
  static readonly outline: string = '#E0C097';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSurface: string = '#3E2723';
}

@Entry
@Component
struct Index {
  @State selectedId: number = 0;
  private clients: Client[] = [
    new Client(1, 'Sunrise Tech', 'Shanghai', 'A', 0.2, 0.3),
    new Client(2, 'Delta Logistics', 'Beijing', 'B', 0.5, 0.45),
    new Client(3, 'Oceanic Foods', 'Guangzhou', 'A', 0.72, 0.6),
    new Client(4, 'Horizon Ltd.', 'Chengdu', 'C', 0.33, 0.75)
  ];

  private markerColor(level: string): string {
    if (level === 'A') {
      return ClientColors.primary;
    }
    if (level === 'B') {
      return ClientColors.secondary;
    }
    return ClientColors.tertiary;
  }

  @Builder
  Hero() {
    Stack({ alignContent: Alignment.Center }) {
      Text('Regional Client Map')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(ClientColors.onPrimary)
    }
    .width('100%')
    .height(200)
    .borderRadius(16)
    .linearGradient({
      direction: GradientDirection.Right,
      colors: [[ClientColors.secondary, 0.0], [ClientColors.primary, 1.0]]
    })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Text('')
          .width('90%')
          .height(1)
          .backgroundColor(ClientColors.surfaceVariant)
          .position({ x: 16, y: 36 + index * 48 })
      }, (index: number) => 'h' + index.toString())
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Text('')
          .width(1)
          .height('88%')
          .backgroundColor(ClientColors.surfaceVariant)
          .position({ x: 26 + index * 52, y: 16 })
      }, (index: number) => 'v' + index.toString())
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapMarker(client: Client) {
    Row() {
      Circle()
        .width(this.selectedId === client.id ? 28 : 22)
        .height(this.selectedId === client.id ? 28 : 22)
        .fill(this.markerColor(client.level))
        .stroke(this.selectedId === client.id ? ClientColors.onPrimary : ClientColors.surface)
        .strokeWidth(2)

      Text(client.name)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ClientColors.onSurface)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(ClientColors.surfaceVariant)
        .borderRadius(8)
        .border({ width: 1, color: ClientColors.outline })
        .margin({ left: 6 })
    }
    .alignItems(VerticalAlign.Center)
    .position({ x: client.x * 310, y: client.y * 330 })
    .onClick(() => {
      if (this.selectedId === client.id) {
        this.selectedId = 0;
      } else {
        this.selectedId = client.id;
      }
    })
  }

  @Builder
  MapPanel() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.clients, (client: Client) => {
        this.MapMarker(client)
      }, (client: Client) => client.id.toString())
    }
    .width('100%')
    .height(360)
    .backgroundColor(ClientColors.surface)
    .borderRadius(16)
    .border({ width: 1, color: ClientColors.outline })
  }

  @Builder
  ClientCard(client: Client) {
    Row() {
      Column() {
        Text(client.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ClientColors.onSurface)
        Text(client.region)
          .fontSize(14)
          .fontColor(ClientColors.onSurface)
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Text('Level ' + client.level)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ClientColors.primary)
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ClientColors.surface)
    .borderRadius(12)
    .border({ width: 1, color: ClientColors.outline })
    .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
  }

  build() {
    Column() {
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(ClientColors.onSurface)
        .width('100%')
        .height(58)
        .textAlign(TextAlign.Center)

      Scroll() {
        Column() {
          this.Hero()
          Column() { this.MapPanel() }.margin({ top: 12 })

          ForEach(this.clients, (client: Client) => {
            Column() {
              this.ClientCard(client)
            }
            .margin({ top: 12 })
          }, (client: Client) => client.id.toString())
        }
        .width('100%')
        .padding({ bottom: 32 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 16, right: 16, top: 12 })
    .backgroundColor(ClientColors.background)
  }
}
