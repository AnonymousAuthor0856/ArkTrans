const Colors = {
  primary: '#111111',
  secondary: '#2A2A2A',
  tertiary: '#444444',
  background: '#F7F7F7',
  surface: '#FFFFFF',
  surfaceVariant: '#EDEDED',
  outline: '#D6D6D6',
  success: '#1E7D4C',
  warning: '#B98400',
  error: '#B3261E',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#0A0A0A',
  onSurface: '#0A0A0A',
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
}

interface ApprovalPin {
  id: number
  title: string
  status: string
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
struct MapPin {
  @Prop title: string = ''
  @Prop status: string = ''
  @Prop selected: boolean = false
  onClick: () => void = () => {}

  private baseColor(): string {
    if (this.status === 'Approved') {
      return Colors.success
    } else if (this.status === 'Pending') {
      return Colors.warning
    } else {
      return Colors.error
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Blank()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.baseColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({ width: 2, color: this.selected ? Colors.primary : Colors.surface })
      Button() {
        Text(this.title)
          .fontSize(12)
          .fontColor(Colors.onSurface)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Colors.surface)
      .borderRadius(8)
      .border({ width: 1, color: Colors.outline })
      .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      .position({ x: 18, y: -4 })
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
  @State filters: string[] = ['Pending', 'Approved']
  @State active: string[] = ['Pending']
  @State selectedId: number | null = null
  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 },
  ]

  private visiblePins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => {
      if (p.status === 'Pending') {
        return this.active.indexOf('Pending') >= 0
      }
      if (p.status === 'Approved') {
        return this.active.indexOf('Approved') >= 0
      }
      return true
    })
  }

  private selectedPin(): ApprovalPin | undefined {
    if (this.selectedId === null) {
      return undefined
    }
    return this.pins.find((p: ApprovalPin) => p.id === this.selectedId)
  }

  build() {
    Column() {
      Row() {
        Text('Approval Flow')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      Stack({ alignContent: Alignment.BottomEnd }) {
        Column({ space: Spacing.md }) {
          Scroll() {
            Row({ space: Spacing.sm }) {
              ForEach(this.filters, (f: string) => {
                Button() {
                  Text(f)
                    .fontSize(this.active.indexOf(f) >= 0 ? 16 : 14)
                    .fontColor(this.active.indexOf(f) >= 0 ? Colors.onPrimary : Colors.onSurface)
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.active.indexOf(f) >= 0 ? Colors.primary : Colors.surface)
                .borderRadius(8)
                .border({ width: 1, color: Colors.outline })
                .onClick(() => {
                  if (this.active.indexOf(f) >= 0) {
                    this.active = this.active.filter((x: string) => x !== f)
                  } else {
                    this.active = this.active.concat([f])
                  }
                })
              }, (f: string) => f)
            }
          }
          .scrollable(ScrollDirection.Horizontal)
          .scrollBar(BarState.Off)
          .width('100%')

          Stack({ alignContent: Alignment.Bottom }) {
            MapGridOverlay()
            ForEach(this.visiblePins(), (p: ApprovalPin) => {
              MapPin({
                title: p.title,
                status: p.status,
                selected: this.selectedId === p.id,
                onClick: () => {
                  this.selectedId = this.selectedId === p.id ? null : p.id
                }
              })
                .position({ x: (p.x * 100).toString() + '%', y: (p.y * 100).toString() + '%' })
            }, (p: ApprovalPin) => p.id.toString())

            if (this.selectedPin() !== undefined) {
              Row({ space: Spacing.sm }) {
                Column({ space: Spacing.xs }) {
                  Text(this.selectedPin()!.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                  Text(this.selectedPin()!.status)
                    .fontSize(12)
                    .fontColor(Colors.onSurface)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Start)

                Button('Details')
                  .type(ButtonType.Normal)
                  .fontSize(12)
                  .fontColor(Colors.onSurface)
                  .backgroundColor(Colors.surfaceVariant)
                  .borderRadius(12)
                  .height(40)
                  .padding({ left: Spacing.sm, right: Spacing.sm })
                  .onClick(() => {})
              }
              .width('100%')
              .padding(Spacing.lg)
              .backgroundColor(Colors.surface)
              .borderRadius(16)
              .border({ width: 1, color: Colors.outline })
              .alignItems(VerticalAlign.Center)
            }
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .border({ width: 1, color: Colors.outline })
        }
        .width('100%')
        .height('100%')
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })

        Button('+')
          .type(ButtonType.Normal)
          .fontSize(20)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(28)
          .width(56)
          .height(56)
          .margin({ right: Spacing.lg, bottom: Spacing.lg })
          .onClick(() => {})
      }
      .layoutWeight(1)
      .width('100%')

      Row({ space: Spacing.md }) {
        Button('Reject')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null)
          .onClick(() => {})
        Button('Approve')
          .type(ButtonType.Normal)
          .fontSize(16)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null)
          .onClick(() => {})
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
      .backgroundColor(Colors.surface)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
