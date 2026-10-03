@Entry
@Component
struct ApprovalFlow {
  @State selectedId: number | null = null
  @State activeFilters: string[] = ['Pending']

  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 0.18, y: 0.35 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 0.52, y: 0.42 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 0.76, y: 0.58 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 0.33, y: 0.72 }
  ]

  build() {
    Column() {
      // Header
      Text('Approval Flow')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111111')
        .textAlign(TextAlign.Center)
        .width('100%')
        .margin({ top: 20, bottom: 16 })

      // Filter Chips
      Row({ space: 8 }) {
        ForEach(['Pending', 'Approved'], (filter: string) => {
          Button(filter)
            .backgroundColor(this.activeFilters.includes(filter) ? '#111111' : '#FFFFFF')
            .borderWidth(1)
            .borderColor('#D6D6D6')
            .borderRadius(8)
            .height(36)
            .onClick(() => {
              if (this.activeFilters.includes(filter)) {
                this.activeFilters = this.activeFilters.filter(f => f !== filter)
              } else {
                this.activeFilters.push(filter)
              }
            })
        })
      }
      .margin({ left: 16, right: 16, bottom: 16 })

      // Map Area
      Stack() {
        // Grid Background
        Column() {
          ForEach([0, 1, 2, 3, 4, 5], () => {
            Divider().color('#EDEDED').width('100%')
          })
        }
        .layoutWeight(1)
        .padding({ left: 16, right: 16 })

        Row() {
          ForEach([0, 1, 2, 3, 4, 5], () => {
            Divider().vertical(true).color('#EDEDED').layoutWeight(1)
          })
        }
        .layoutWeight(1)
        .padding({ top: 16, bottom: 16 })

        // Pins
        ForEach(this.pins, (pin: ApprovalPin) => {
          if (this.shouldShowPin(pin.status)) {
            this.MapPinComponent(pin)
          }
        })

        // Selected Card
        if (this.selectedId !== null) {
          const sel = this.getSelectedPin();
          if (sel) {
            Column() {
              Row() {
                Column() {
                  Text(sel.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111111')
                  Text(sel.status)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#111111')
                    .margin({ top: 4 })
                }
                Blank()
                Button('Details')
                  .backgroundColor('#EDEDED')
                  .borderRadius(12)
                  .height(40)
                  .margin({ right: 16 })
              }
              .width('100%')
              .padding(16)
            }
            .width('90%')
            .backgroundColor('#FFFFFF')
            .borderRadius(16)
            .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
            .align(Alignment.Bottom)
            .margin({ bottom: 20 })
          }
        }

        // FAB
        Button('+')
          .width(56)
          .height(56)
          .backgroundColor('#111111')
          .borderRadius(28)
          .shadow({ radius: 8, color: '#40000000', offsetY: 4 })
          .align(Alignment.BottomEnd)
          .margin({ bottom: 20, right: 20 })
      }
      .width('100%')
      .height(400)
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .border({ width: 1, color: '#D6D6D6' })
      .margin({ left: 16, right: 16 })

      Blank()

      // Bottom Actions
      Row({ space: 12 }) {
        Button('Reject')
          .backgroundColor(this.selectedId === null ? '#CCCCCC' : '#EDEDED')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null)

        Button('Approve')
          .backgroundColor(this.selectedId === null ? '#CCCCCC' : '#111111')
          .borderRadius(12)
          .height(48)
          .layoutWeight(1)
          .enabled(this.selectedId !== null)
      }
      .width('100%')
      .margin({ left: 16, right: 16, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F7F7F7')
    .padding({ top: 10 })
  }

  shouldShowPin(status: string): boolean {
    if (status === 'Rejected') return true
    return this.activeFilters.includes(status)
  }

  getSelectedPin(): ApprovalPin | undefined {
    return this.pins.find(p => p.id === this.selectedId)
  }

  @Builder
  MapPinComponent(pin: ApprovalPin) {
    Stack() {
      // Dot
      Circle()
        .width(this.selectedId === pin.id ? 28 : 22)
        .height(this.selectedId === pin.id ? 28 : 22)
        .fill(this.getStatusColor(pin.status))
        .border({ width: 2, color: this.selectedId === pin.id ? '#111111' : '#FFFFFF' })

      // Label
      Text(pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#111111')
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .border({ width: 1, color: '#D6D6D6' })
        .offset({ x: 18, y: -4 })
        .onClick(() => {
          this.selectedId = this.selectedId === pin.id ? null : pin.id
        })
    }
    .position({ x: `${pin.x * 100}%`, y: `${pin.y * 100}%` })
  }

  getStatusColor(status: string): string {
    switch (status) {
      case 'Approved': return '#1E7D4C'
      case 'Pending': return '#B98400'
      default: return '#B3261E'
    }
  }
}

interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
}