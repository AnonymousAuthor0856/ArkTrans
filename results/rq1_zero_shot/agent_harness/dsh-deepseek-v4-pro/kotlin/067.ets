const Colors = {
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
  onSurface: '#3E2723',
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
}

interface Client {
  id: number
  name: string
  region: string
  level: string
  x: number
  y: number
}

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
        Divider()
          .width('100%')
          .height(1)
          .backgroundColor(Colors.surfaceVariant)
          .position({ x: 0, y: ((i * 100) / 7).toString() + '%' })
      }, (i: number) => 'h' + i.toString())
      ForEach([1, 2, 3, 4, 5, 6], (i: number) => {
        Divider()
          .width(1)
          .height('100%')
          .backgroundColor(Colors.surfaceVariant)
          .position({ x: ((i * 100) / 7).toString() + '%', y: 0 })
      }, (i: number) => 'v' + i.toString())
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapMarker {
  @Prop label: string = ''
  @Prop level: string = ''
  @Prop selected: boolean = false
  onClick: () => void = () => {}

  private markerColor(): string {
    if (this.level === 'A') {
      return Colors.primary
    } else if (this.level === 'B') {
      return Colors.secondary
    } else {
      return Colors.tertiary
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Blank()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.markerColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({ width: 2, color: this.selected ? Colors.onPrimary : Colors.surface })
      Button() {
        Text(this.label)
          .fontSize(12)
          .fontColor(Colors.onSurface)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Colors.surfaceVariant)
      .borderRadius(8)
      .border({ width: 1, color: Colors.outline })
      .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      .position({ x: 20, y: -4 })
      .onClick(() => {
        this.onClick()
      })
    }
    .width(28)
    .height(28)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Entry
@Component
struct Index {
  @State selectedId: number | null = null
  private clients: Client[] = [
    { id: 1, name: 'Sunrise Tech', region: 'Shanghai', level: 'A', x: 0.2, y: 0.3 },
    { id: 2, name: 'Delta Logistics', region: 'Beijing', level: 'B', x: 0.5, y: 0.45 },
    { id: 3, name: 'Oceanic Foods', region: 'Guangzhou', level: 'A', x: 0.72, y: 0.6 },
    { id: 4, name: 'Horizon Ltd.', region: 'Chengdu', level: 'C', x: 0.33, y: 0.75 },
  ]

  build() {
    Column() {
      Row() {
        Text('Client Detail')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Column({ space: Spacing.md }) {
        Stack({ alignContent: Alignment.Center }) {
          Text('Regional Client Map')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onPrimary)
        }
        .width('100%')
        .height(200)
        .borderRadius(16)
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [[Colors.secondary, 0], [Colors.primary, 1]]
        })

        Stack({ alignContent: Alignment.TopStart }) {
          MapGridOverlay()
          ForEach(this.clients, (c: Client) => {
            MapMarker({
              label: c.name,
              level: c.level,
              selected: this.selectedId === c.id,
              onClick: () => {
                this.selectedId = this.selectedId === c.id ? null : c.id
              }
            })
              .position({ x: (c.x * 100).toString() + '%', y: (c.y * 100).toString() + '%' })
          }, (c: Client) => c.id.toString())
        }
        .width('100%')
        .aspectRatio(0.9)
        .constraintSize({ minHeight: 360 })
        .backgroundColor(Colors.surface)
        .borderRadius(16)
        .border({ width: 1, color: Colors.outline })

        Scroll() {
          Column({ space: Spacing.md }) {
            ForEach(this.clients, (c: Client) => {
              Row() {
                Column({ space: Spacing.xs }) {
                  Text(c.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(c.region)
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                }
                .alignItems(HorizontalAlign.Start)

                Text('Level ' + c.level)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.primary)
              }
              .width('100%')
              .padding(Spacing.lg)
              .backgroundColor(Colors.surface)
              .borderRadius(12)
              .border({ width: 1, color: Colors.outline })
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
            }, (c: Client) => c.id.toString())
          }
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
