class ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number

  constructor(id: number, title: string, status: string, x: number, y: number) {
    this.id = id
    this.title = title
    this.status = status
    this.x = x
    this.y = y
  }
}

class AppColors {
  static readonly primary: string = '#111111'
  static readonly secondary: string = '#2A2A2A'
  static readonly tertiary: string = '#444444'
  static readonly background: string = '#F7F7F7'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#EDEDED'
  static readonly outline: string = '#D6D6D6'
  static readonly success: string = '#1E7D4C'
  static readonly warning: string = '#B98400'
  static readonly error: string = '#B3261E'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSurface: string = '#0A0A0A'
  static readonly disabled: string = '#D0D0D0'
  static readonly disabledText: string = '#888888'
}

@Entry
@Component
struct Index {
  @State private active: string[] = ['Pending']
  @State private selectedId: number = -1

  private filters: string[] = ['Pending', 'Approved']
  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ]

  private toggleFilter(filter: string): void {
    if (this.active.includes(filter)) {
      this.active = this.active.filter((item: string) => item !== filter)
    } else {
      this.active = [...this.active, filter]
    }
  }

  private togglePin(id: number): void {
    this.selectedId = this.selectedId === id ? -1 : id
  }

  private visiblePins(): ApprovalPin[] {
    return this.pins.filter((pin: ApprovalPin) => {
      if (pin.status === 'Pending') {
        return this.active.includes('Pending')
      }
      if (pin.status === 'Approved') {
        return this.active.includes('Approved')
      }
      return true
    })
  }

  @Builder
  private FilterChip(filter: string) {
    Stack({ alignContent: Alignment.Center }) {
      Text(filter)
        .fontSize(this.active.includes(filter) ? 16 : 14)
        .fontWeight(this.active.includes(filter) ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.active.includes(filter) ? AppColors.onPrimary : AppColors.onSurface)
        .padding({ left: 16, right: 16 })
    }
    .height(32)
    .borderRadius(8)
    .backgroundColor(this.active.includes(filter) ? AppColors.primary : AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.toggleFilter(filter)
    })
  }

  @Builder
  private MapGridOverlay() {
    Stack() {
      ForEach([1, 2, 3, 4, 5, 6], (index: number) => {
        Blank()
          .width('90%')
          .height(1)
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: '5%', y: `${index * 100 / 7}%` })
      }, (index: number) => index.toString())

      ForEach([1, 2, 3, 4, 5, 6], (index: number) => {
        Blank()
          .width(1)
          .height('90%')
          .backgroundColor(AppColors.surfaceVariant)
          .position({ x: `${5 + index * 90 / 7}%`, y: '5%' })
      }, (index: number) => `v${index}`)
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  private SelectedCard(pin: ApprovalPin) {
    Row() {
      Column({ space: 4 }) {
        Text(pin.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(pin.status)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .layoutWeight(1)

      Stack({ alignContent: Alignment.Center }) {
        Text('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .height(40)
      .padding({ left: 12, right: 12 })
      .borderRadius(12)
      .backgroundColor(AppColors.surfaceVariant)
    }
    .width('92%')
    .padding(16)
    .borderRadius(16)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 12, color: '#29000000', offsetX: 0, offsetY: 6 })
    .position({ x: '4%', y: '78%' })
  }

  @Builder
  private ActionButton(label: string, primary: boolean) {
    Stack({ alignContent: Alignment.Center }) {
      Text(label)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedId !== -1 ? (primary ? AppColors.onPrimary : AppColors.onSurface) : AppColors.disabledText)
    }
    .height(48)
    .layoutWeight(1)
    .borderRadius(12)
    .backgroundColor(this.selectedId !== -1 ? (primary ? AppColors.primary : AppColors.surfaceVariant) : AppColors.disabled)
    .onClick(() => {
    })
  }

  build() {
    Stack() {
      Column() {
        Column() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .height(88)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppColors.surface)

        Column({ space: 20 }) {
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              this.FilterChip(filter)
            }, (filter: string) => filter)
          }
          .width('100%')
          .height(32)

          Stack() {
            this.MapGridOverlay()

            ForEach(this.visiblePins(), (pin: ApprovalPin) => {
              MapPinView({
                pin: pin,
                selected: this.selectedId === pin.id,
                onSelect: (id: number) => {
                  this.togglePin(id)
                }
              })
            }, (pin: ApprovalPin) => pin.id.toString())

            if (this.selectedId !== -1) {
              ForEach(this.pins.filter((pin: ApprovalPin) => pin.id === this.selectedId), (pin: ApprovalPin) => {
                this.SelectedCard(pin)
              }, (pin: ApprovalPin) => `selected${pin.id}`)
            }
          }
          .width('100%')
          .aspectRatio(0.9)
          .constraintSize({ minHeight: 360 })
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppColors.outline })

          Blank()
            .layoutWeight(1)

          Row({ space: 12 }) {
            this.ActionButton('Reject', false)
            this.ActionButton('Approve', true)
          }
          .width('100%')
          .height(48)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 20, bottom: 14 })
        .backgroundColor(AppColors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Stack({ alignContent: Alignment.Center }) {
        Text('+')
          .fontSize(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.primary)
      .shadow({ radius: 14, color: '#33000000', offsetX: 0, offsetY: 8 })
      .align(Alignment.BottomEnd)
      .margin({ right: 16, bottom: 96 })
      .onClick(() => {
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct MapPinView {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0)
  selected: boolean = false
  onSelect: (id: number) => void = () => {
  }

  private statusColor(): string {
    if (this.pin.status === 'Approved') {
      return AppColors.success
    }
    if (this.pin.status === 'Pending') {
      return AppColors.warning
    }
    return AppColors.error
  }

  build() {
    Stack() {
      Stack()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .borderRadius(this.selected ? 14 : 11)
        .backgroundColor(this.statusColor())
        .border({ width: 2, color: this.selected ? AppColors.primary : AppColors.surface })
        .onClick(() => {
          this.onSelect(this.pin.id)
        })

      Text(this.pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .maxLines(1)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        .backgroundColor(AppColors.surface)
        .borderRadius(8)
        .border({ width: 1, color: AppColors.outline })
        .shadow({ radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 })
        .position({ x: 18, y: -4 })
        .onClick(() => {
          this.onSelect(this.pin.id)
        })
    }
    .width(300)
    .height(40)
    .position({ x: `${this.pin.x * 100}%`, y: `${this.pin.y * 100}%` })
  }
}