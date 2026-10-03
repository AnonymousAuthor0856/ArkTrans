@Entry
@Component
struct Index {
  @State selectedId: number | null = null;

  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 }
  ];

  build() {
    Column() {
      Text('Client Detail')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#3E2723')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 12, bottom: 12 })

      Scroll() {
        Column() {
          // Regional Client Map banner
          Stack({ alignContent: Alignment.Center }) {
            Text('Regional Client Map')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.White)
          }
          .width('100%')
          .height(200)
          .linearGradient({
            angle: 135,
            colors: [['#FFB74D', 0.0], ['#FF7043', 1.0]]
          })
          .borderRadius(16)
          .margin({ bottom: 12 })

          // Map area with grid and markers
          Stack() {
            // Grid overlay
            Column() {
              ForEach(Array(6).fill(0), (_: number, i: number) => {
                Row()
                  .width('100%')
                  .height(1)
                  .backgroundColor('#FFECB3')
                  .margin({ top: i === 0 ? 0 : 'auto', bottom: 'auto' })
              })
            }
            .width('100%')
            .height('100%')
            .padding(16)
            .justifyContent(FlexAlign.SpaceEvenly)

            Row() {
              ForEach(Array(6).fill(0), (_: number, i: number) => {
                Column()
                  .width(1)
                  .height('100%')
                  .backgroundColor('#FFECB3')
                  .margin({ left: i === 0 ? 0 : 'auto', right: 'auto' })
              })
            }
            .width('100%')
            .height('100%')
            .padding(16)
            .justifyContent(FlexAlign.SpaceEvenly)

            // Markers
            ForEach(this.clients, (c: Client) => {
              MapMarker({
                label: c.name,
                level: c.level,
                selected: this.selectedId === c.id,
                x: c.x,
                y: c.y,
                onClick: () => {
                  this.selectedId = this.selectedId === c.id ? null : c.id;
                }
              })
            }, (c: Client) => c.id.toString())
          }
          .width('100%')
          .aspectRatio(0.9)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#E0C097' })
          .borderRadius(16)
          .margin({ bottom: 12 })

          // Client list cards
          Column() {
            ForEach(this.clients, (c: Client) => {
              Row() {
                Column() {
                  Text(c.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#3E2723')
                  Text(c.region)
                    .fontSize(14)
                    .fontColor('#3E2723')
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                Text('Level ' + c.level)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF7043')
              }
              .width('100%')
              .padding(16)
              .backgroundColor(Color.White)
              .border({ width: 1, color: '#E0C097' })
              .borderRadius(12)
              .margin({ bottom: 12 })
              .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
            }, (c: Client) => c.id.toString())
          }
          .width('100%')
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8E1')
  }
}

@Component
struct MapMarker {
  label: string = '';
  level: string = '';
  selected: boolean = false;
  x: number = 0;
  y: number = 0;
  onClick: () => void = () => {};

  @Builder
  markerColor(): ResourceColor {
    if (this.level === 'A') return '#FF7043';
    if (this.level === 'B') return '#FFB74D';
    return '#FFD54F';
  }

  build() {
    Stack() {
      // Marker dot
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.markerColor())
        .stroke({
          color: this.selected ? Color.White : Color.White,
          width: 2
        })
        .position({ x: 0, y: 0 })

      // Label card
      Text(this.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#3E2723')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFECB3')
        .border({ width: 1, color: '#E0C097' })
        .borderRadius(8)
        .shadow({ radius: 4, color: 'rgba(0,0,0,0.1)', offsetY: 2 })
        .position({ x: 20, y: -4 })
        .onClick(() => this.onClick())
    }
    .position({
      x: this.x * '100%',
      y: this.y * '100%'
    })
    .translate({ x: -11, y: -11 })
  }
}

interface Client {
  id: number;
  name: string;
  region: string;
  level: string;
  x: number;
  y: number;
}
