interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}

@Entry
@Component
struct ApprovalFlowApp {
  @State activeFilter: string = 'Pending'
  @State selectedPinId: number = -1

  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]

  build() {
    Stack() {
      Column() {
        Column() {
          Text('Approval Flow')
            .fontSize(54)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0A0A0A')
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(115)
        .justifyContent(FlexAlign.Center)
        .backgroundColor('#FFFFFF')

        Scroll() {
          Column() {
            Row() {
              this.filterChip('Pending', this.activeFilter === 'Pending')
              this.filterChip('Approved', this.activeFilter === 'Approved')
            }
            .width('100%')
            .height(78)
            .padding({ left: 32, top: 25 })
            .alignItems(VerticalAlign.Top)

            Stack() {
              this.grid()

              ForEach(this.pins, (pin: ApprovalPin) => {
                if (pin.status === 'Rejected' || pin.status === this.activeFilter) {
                  this.pin(pin)
                }
              }, (pin: ApprovalPin) => pin.id.toString())
            }
            .width('calc(100% - 64vp)')
            .height(764)
            .margin({ left: 32, right: 32, bottom: 208 })
            .borderRadius(36)
            .border({ width: 2, color: '#D6D6D6' })
            .backgroundColor('#FFFFFF')
            .clip(true)
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .backgroundColor('#F7F7F7')

        Row() {
          Button('Reject')
            .fontSize(30)
            .fontColor(this.selectedPinId < 0 ? '#888888' : '#0A0A0A')
            .backgroundColor('#F7F7F7')
            .borderRadius(20)
            .height(96)
            .layoutWeight(1)
            .enabled(this.selectedPinId >= 0)
            .onClick(() => {
              this.selectedPinId = -1
            })

          Button('Approve')
            .fontSize(30)
            .fontColor('#D6D6D6')
            .backgroundColor(this.selectedPinId >= 0 ? '#111111' : '#999999')
            .borderRadius(20)
            .height(96)
            .layoutWeight(1)
            .enabled(this.selectedPinId >= 0)
            .onClick(() => {
              this.selectedPinId = -1
            })
        }
        .width('100%')
        .height(144)
        .padding({ left: 32, right: 32, top: 24, bottom: 24 })
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F7F7F7')

      Button('+')
        .width(112)
        .height(112)
        .fontSize(44)
        .fontWeight(FontWeight.Bold)
        .fontColor('#FFFFFF')
        .backgroundColor('#111111')
        .borderRadius(56)
        .position({ right: 32, bottom: 32 })
        .zIndex(5)
        .onClick(() => {
          this.selectedPinId = -1
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
  }

  @Builder
  filterChip(text: string, selected: boolean) {
    Button(text)
      .fontSize(31)
      .fontColor(selected ? '#FFFFFF' : '#111111')
      .fontWeight(selected ? FontWeight.Medium : FontWeight.Regular)
      .height(52)
      .padding({ left: 17, right: 17 })
      .backgroundColor(selected ? '#111111' : '#FFFFFF')
      .borderRadius(17)
      .border({ width: 2, color: '#D6D6D6' })
      .margin({ right: 16 })
      .onClick(() => {
        this.activeFilter = text
      })
  }

  @Builder
  grid() {
    Stack() {
      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Row()
          .width('calc(100% - 64vp)')
          .height(1)
          .backgroundColor('#E6E6E6')
          .position({ left: 32, top: 108 + index * 109 })
      })

      ForEach([0, 1, 2, 3, 4, 5], (index: number) => {
        Column()
          .width(1)
          .height('calc(100% - 64vp)')
          .backgroundColor('#E6E6E6')
          .position({ left: 96 + index * 99, top: 32 })
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  pin(pin: ApprovalPin) {
    Row() {
      Circle()
        .width(42)
        .height(42)
        .fill(pin.status === 'Pending' ? '#C48A00' : '#B3261E')
        .border({
          width: this.selectedPinId === pin.id ? 3 : 2,
          color: this.selectedPinId === pin.id ? '#111111' : '#FFFFFF'
        })

      Text(pin.title)
        .fontSize(25)
        .fontColor('#111111')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .height(48)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FFFFFF')
        .borderRadius(16)
        .border({ width: 2, color: '#D6D6D6' })
        .shadow({ radius: 6, color: '#26000000', offsetY: 2 })
        .margin({ left: -1 })
    }
    .position({
      left: `${pin.x * 100}%`,
      top: `${pin.y * 100}%`
    })
    .onClick(() => {
      this.selectedPinId = this.selectedPinId === pin.id ? -1 : pin.id
    })
  }
}
