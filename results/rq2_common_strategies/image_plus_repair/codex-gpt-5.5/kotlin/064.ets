interface ApprovalPin {
  id: number
  title: string
  status: string
  x: number
  y: number
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
}

@Entry
@Component
struct ApprovalFlowPage {
  @State activeFilters: string[] = ['Pending']
  @State selectedId: number = -1

  private filters: string[] = ['Pending', 'Approved']
  private pins: ApprovalPin[] = [
    { id: 1, title: 'Purchase Order #1042', status: 'Pending', x: 118, y: 256 },
    { id: 2, title: 'Travel Request #552', status: 'Approved', x: 340, y: 306 },
    { id: 3, title: 'Contract #A77', status: 'Pending', x: 500, y: 426 },
    { id: 4, title: 'Budget Change #09', status: 'Rejected', x: 216, y: 526 }
  ]
  private gridMarks: number[] = [0, 1, 2, 3, 4, 5]

  private hasFilter(value: string): boolean {
    return this.activeFilters.indexOf(value) >= 0
  }

  private toggleFilter(value: string): void {
    if (this.hasFilter(value)) {
      this.activeFilters = this.activeFilters.filter((item: string) => item !== value)
    } else {
      this.activeFilters = [...this.activeFilters, value]
    }
  }

  private isVisible(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.hasFilter('Pending')
    }
    if (pin.status === 'Approved') {
      return this.hasFilter('Approved')
    }
    return true
  }

  private statusColor(status: string): string {
    if (status === 'Approved') {
      return AppColors.success
    }
    if (status === 'Pending') {
      return AppColors.warning
    }
    return AppColors.error
  }

  @Builder
  private FilterChip(label: string) {
    Stack() {
      Text(label)
        .fontSize(this.hasFilter(label) ? 30 : 28)
        .fontWeight(this.hasFilter(label) ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.hasFilter(label) ? AppColors.onPrimary : AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .maxLines(1)
    }
    .height(64)
    .padding({ left: 31, right: 31 })
    .backgroundColor(this.hasFilter(label) ? AppColors.primary : AppColors.surface)
    .border({
      width: 2,
      color: AppColors.outline
    })
    .borderRadius(16)
    .margin({ right: 18 })
    .onClick(() => {
      this.toggleFilter(label)
    })
  }

  @Builder
  private MapGridOverlay() {
    ForEach(this.gridMarks, (mark: number) => {
      Text('')
        .width(592)
        .height(2)
        .backgroundColor(AppColors.surfaceVariant)
        .position({ x: 32, y: 123 + mark * 96 })
    }, (mark: number) => mark.toString())
    ForEach(this.gridMarks, (mark: number) => {
      Text('')
        .width(2)
        .height(664)
        .backgroundColor(AppColors.surfaceVariant)
        .position({ x: 114 + mark * 85, y: 32 })
    }, (mark: number) => `v${mark}`)
  }

  @Builder
  private PinBubble(pin: ApprovalPin) {
    Stack() {
      Text('')
        .width(this.selectedId === pin.id ? 44 : 40)
        .height(this.selectedId === pin.id ? 44 : 40)
        .backgroundColor(this.statusColor(pin.status))
        .border({
          width: this.selectedId === pin.id ? 3 : 4,
          color: this.selectedId === pin.id ? AppColors.primary : AppColors.surface
        })
        .borderRadius(24)
        .position({ x: 0, y: 0 })

      Stack() {
        Text(pin.title)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .padding({ left: 14, right: 14 })
      }
      .height(42)
      .constraintSize({ minWidth: 0, maxWidth: 330 })
      .backgroundColor(AppColors.surface)
      .border({
        width: 2,
        color: AppColors.outline
      })
      .borderRadius(15)
      .shadow({
        radius: 6,
        color: '#33000000',
        offsetX: 0,
        offsetY: 2
      })
      .position({ x: 34, y: 16 })
      .onClick(() => {
        this.selectedId = this.selectedId === pin.id ? -1 : pin.id
      })
    }
    .width(370)
    .height(64)
    .position({ x: pin.x, y: pin.y })
  }

  @Builder
  private SelectionCard(pin: ApprovalPin) {
    Row() {
      Column() {
        Text(pin.title)
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
        Text(pin.status)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.tertiary)
          .margin({ top: 4 })
      }
      .layoutWeight(1)

      Stack() {
        Text('Details')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .height(40)
      .padding({ left: 20, right: 20 })
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(12)
    }
    .width(610)
    .padding({ left: 24, right: 24, top: 18, bottom: 18 })
    .backgroundColor(AppColors.surface)
    .border({
      width: 2,
      color: AppColors.outline
    })
    .borderRadius(24)
    .shadow({
      radius: 12,
      color: '#29000000',
      offsetX: 0,
      offsetY: 6
    })
    .position({ x: 23, y: 604 })
  }

  @Builder
  private MapPanel() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.pins, (pin: ApprovalPin) => {
        if (this.isVisible(pin)) {
          this.PinBubble(pin)
        }
      }, (pin: ApprovalPin) => pin.id.toString())
      ForEach(this.pins, (pin: ApprovalPin) => {
        if (this.selectedId === pin.id) {
          this.SelectionCard(pin)
        }
      }, (pin: ApprovalPin) => `selected${pin.id}`)
    }
    .width(656)
    .height(728)
    .backgroundColor(AppColors.surface)
    .border({
      width: 2,
      color: AppColors.outline
    })
    .borderRadius(28)
    .clip(true)
  }

  @Builder
  private BottomAction(title: string, approve: boolean) {
    Stack() {
      Text(title)
        .fontSize(30)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selectedId === -1 ? '#888888' : (approve ? AppColors.onPrimary : AppColors.onSurface))
    }
    .height(96)
    .layoutWeight(1)
    .backgroundColor(this.selectedId === -1 ? '#D1D1D1' : (approve ? AppColors.primary : AppColors.surfaceVariant))
    .borderRadius(20)
    .opacity(this.selectedId === -1 ? 0.9 : 1)
  }

  build() {
    Stack() {
      Column() {
        Stack() {
          Text('Approval Flow')
            .fontSize(54)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
            .textAlign(TextAlign.Center)
            .width('100%')
            .position({ x: 0, y: 78 })
        }
        .width('100%')
        .height(176)
        .backgroundColor(AppColors.surface)

        Column() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              this.FilterChip(filter)
            }, (filter: string) => filter)
          }
          .width('100%')
          .height(64)
          .alignItems(VerticalAlign.Center)
          .margin({ top: 40 })

          Blank()
            .height(41)
          this.MapPanel()
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 32, right: 32 })
        .backgroundColor(AppColors.background)

        Row() {
          this.BottomAction('Reject', false)
          Blank()
            .width(24)
          this.BottomAction('Approve', true)
        }
        .height(152)
        .width('100%')
        .padding({ left: 40, right: 40, top: 28, bottom: 28 })
        .backgroundColor(AppColors.surface)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Stack() {
        Text('+')
          .fontSize(42)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
      }
      .width(112)
      .height(112)
      .backgroundColor(AppColors.primary)
      .borderRadius(56)
      .shadow({
        radius: 18,
        color: '#33000000',
        offsetX: 0,
        offsetY: 8
      })
      .position({ x: 576, y: 976 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
