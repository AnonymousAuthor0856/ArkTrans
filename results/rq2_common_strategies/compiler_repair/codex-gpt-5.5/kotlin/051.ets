class Departure {
  time: string;
  line: string;

  constructor(time: string, line: string) {
    this.time = time;
    this.line = line;
  }
}

class StationPoint {
  label: string;
  x: number;
  y: number;

  constructor(label: string, x: number, y: number) {
    this.label = label;
    this.x = x;
    this.y = y;
  }
}

class MetroColors {
  static readonly primary: string = '#00FFFF';
  static readonly secondary: string = '#00B4FF';
  static readonly background: string = '#0A0A1A';
  static readonly surface: string = '#141436';
  static readonly surfaceVariant: string = '#1E1E4A';
  static readonly success: string = '#00FFAA';
  static readonly onPrimary: string = '#0A0A1A';
  static readonly onSurface: string = '#FFFFFF';
}

@Entry
@Component
struct Index {
  private stations: StationPoint[] = [
    new StationPoint('A', 18, 55),
    new StationPoint('B', 74, 185),
    new StationPoint('C', 130, 55),
    new StationPoint('D', 186, 185),
    new StationPoint('E', 242, 55),
    new StationPoint('F', 298, 185)
  ];
  private departures: Departure[] = [
    new Departure('08:45', 'Line 1'),
    new Departure('09:10', 'Line 2'),
    new Departure('09:30', 'Line 3')
  ];

  @Builder
  Segment(left: number, top: number, width: number, rotate: number) {
    Text('')
      .width(width)
      .height(6)
      .backgroundColor(MetroColors.secondary)
      .borderRadius(3)
      .position({ x: left, y: top })
      .rotate({ angle: rotate })
  }

  @Builder
  RouteMap() {
    Stack() {
      this.Segment(34, 112, 150, 66)
      this.Segment(90, 112, 150, -66)
      this.Segment(146, 112, 150, 66)
      this.Segment(202, 112, 150, -66)
      this.Segment(258, 112, 88, 66)

      ForEach(this.stations, (station: StationPoint) => {
        Column() {
          Circle()
            .width(32)
            .height(32)
            .fill(MetroColors.primary)
          Circle()
            .width(12)
            .height(12)
            .fill(MetroColors.background)
            .position({ x: 10, y: 10 })
          Text(station.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(MetroColors.onSurface)
            .margin({ top: 6 })
        }
        .width(42)
        .position({ x: station.x, y: station.y })
      }, (station: StationPoint) => station.label)
    }
    .width('100%')
    .height(260)
    .backgroundColor(MetroColors.surfaceVariant)
    .borderRadius(22)
  }

  @Builder
  DeparturesCard() {
    Column() {
      Text('Next Departures')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(MetroColors.secondary)
        .width('100%')
        .margin({ bottom: 10 })

      ForEach(this.departures, (item: Departure) => {
        Row() {
          Text(item.time + '  ' + item.line)
            .fontSize(14)
            .fontColor(MetroColors.onSurface)
            .layoutWeight(1)
          Text('On Time')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(MetroColors.success)
        }
        .width('100%')
        .margin({ top: 8 })
      }, (item: Departure) => item.time)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(MetroColors.surface)
    .borderRadius(22)
    .shadow({ radius: 8, color: '#26000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Routes')
        .fontSize(14)
        .fontColor(MetroColors.secondary)
      Text('Planner')
        .fontSize(14)
        .fontColor(MetroColors.onSurface)
      Text('Tickets')
        .fontSize(14)
        .fontColor(MetroColors.onSurface)
      Text('Profile')
        .fontSize(14)
        .fontColor(MetroColors.onSurface)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(MetroColors.surface)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Text('Metro Planner')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(MetroColors.primary)
          .width('100%')
          .margin({ bottom: 16 })

        this.RouteMap()

        Column() {
          this.DeparturesCard()
        }
        .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 80 })
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[MetroColors.background, 0.0], [MetroColors.surfaceVariant, 0.5], [MetroColors.background, 1.0]]
      })

      Column() {
        this.BottomBar()
      }
      .width('100%')
      .align(Alignment.Bottom)

      Button('+')
        .width(56)
        .height(56)
        .borderRadius(28)
        .fontSize(24)
        .fontColor(MetroColors.onPrimary)
        .backgroundColor(MetroColors.primary)
        .margin({ right: 24, bottom: 76 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(MetroColors.background)
  }
}
