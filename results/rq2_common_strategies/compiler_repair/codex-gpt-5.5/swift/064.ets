class AppColors {
  static primary: string = '#111111'
  static secondary: string = '#2A2A2A'
  static tertiary: string = '#444444'
  static background: string = '#F7F7F7'
  static surface: string = '#FFFFFF'
  static surfaceVariant: string = '#EDEDED'
  static outline: string = '#D6D6D6'
  static success: string = '#1E7D4C'
  static warning: string = '#B98400'
  static error: string = '#B3261E'
  static onPrimary: string = '#FFFFFF'
  static onSecondary: string = '#FFFFFF'
  static onTertiary: string = '#FFFFFF'
  static onBackground: string = '#0A0A0A'
  static onSurface: string = '#0A0A0A'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
}

class AppShape {
  static small: number = 8
  static medium: number = 12
  static large: number = 16
}

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

@Entry
@Component
struct Index {
  @State activePending: boolean = true
  @State activeApproved: boolean = false
  @State selectedPinId: number = 0
  private filters: string[] = ['Pending', 'Approved']
  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 18, 35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 52, 42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 76, 58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 33, 72)
  ]

  private isFilterActive(filter: string): boolean {
    if (filter === 'Pending') {
      return this.activePending
    }
    return this.activeApproved
  }

  private shouldShowPin(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.activePending
    }
    if (pin.status === 'Approved') {
      return this.activeApproved
    }
    return true
  }

  private pinColor(status: string): string {
    if (status === 'Approved') {
      return AppColors.success
    }
    if (status === 'Pending') {
      return AppColors.warning
    }
    if (status === 'Rejected') {
      return AppColors.error
    }
    return AppColors.tertiary
  }

  private selectedTitle(): string {
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) {
        return this.pins[i].title
      }
    }
    return ''
  }

  private selectedStatus(): string {
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) {
        return this.pins[i].status
      }
    }
    return ''
  }

  @Builder
  FilterChip(text: string) {
    Text(text)
      .fontSize(this.isFilterActive(text) ? 16 : 14)
      .fontWeight(this.isFilterActive(text) ? FontWeight.Medium : FontWeight.Regular)
      .fontColor(this.isFilterActive(text) ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .backgroundColor(this.isFilterActive(text) ? AppColors.primary : AppColors.surface)
      .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
      .onClick(() => {
        if (text === 'Pending') {
          this.activePending = !this.activePending
        } else {
          this.activeApproved = !this.activeApproved
        }
      })
  }

  @Builder
  MapGridOverlay() {
    Stack() {
      ForEach([16, 32, 48, 64, 80], (pos: number) => {
        Rect()
          .width('90%')
          .height(1)
          .fill(AppColors.surfaceVariant)
          .position({ x: '50%', y: pos.toString() + '%' })
      })
      ForEach([16, 32, 48, 64, 80], (pos: number) => {
        Rect()
          .width(1)
          .height('90%')
          .fill(AppColors.surfaceVariant)
          .position({ x: pos.toString() + '%', y: '50%' })
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  MapPin(pin: ApprovalPin) {
    Stack() {
      Circle()
        .width(this.selectedPinId === pin.id ? 28 : 22)
        .height(this.selectedPinId === pin.id ? 28 : 22)
        .fill(this.pinColor(pin.status))
        .stroke(this.selectedPinId === pin.id ? AppColors.primary : AppColors.surface)
        .strokeWidth(2)
        .position({ x: '0%', y: '20%' })

      Text(pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
        .backgroundColor(AppColors.surface)
        .border({ width: 1, color: AppColors.outline, radius: AppShape.small })
        .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        .position({ x: '55%', y: '10%' })
    }
    .width(170)
    .height(48)
    .position({ x: pin.x.toString() + '%', y: pin.y.toString() + '%' })
    .onClick(() => {
      this.selectedPinId = this.selectedPinId === pin.id ? 0 : pin.id
    })
  }

  @Builder
  DetailCard() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.selectedTitle())
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text(this.selectedStatus())
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Details')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .height(40)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.medium)
    }
    .width('92%')
    .padding(AppSpacing.lg)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
    .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
    .position({ x: '50%', y: '88%' })
  }

  @Builder
  MapArea() {
    Stack() {
      this.MapGridOverlay()
      ForEach(this.pins, (pin: ApprovalPin) => {
        if (this.shouldShowPin(pin)) {
          this.MapPin(pin)
        }
      })
      if (this.selectedPinId !== 0) {
        this.DetailCard()
      }
    }
    .width('100%')
    .height(360)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
  }

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.md }) {
      Button('Reject')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShape.medium)
        .enabled(this.selectedPinId !== 0)

      Button('Approve')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .height(48)
        .layoutWeight(1)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
        .enabled(this.selectedPinId !== 0)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetY: -4 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        .justifyContent(FlexAlign.Center)
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  this.FilterChip(filter)
                })
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Column() {
              this.MapArea()
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.md })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .width(56)
        .height(56)
        .borderRadius(28)
        .backgroundColor(AppColors.primary)
        .margin(AppSpacing.lg)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
