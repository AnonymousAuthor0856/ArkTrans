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

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
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

@Component
struct FilterChipView {
  text: string = ''
  isSelected: boolean = false
  onTap: () => void = () => {
  }

  build() {
    Row() {
      Text(this.text)
        .fontSize(this.isSelected ? 16 : 14)
        .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Regular)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.sm,
      right: AppSpacing.sm,
      top: AppSpacing.xs,
      bottom: AppSpacing.xs
    })
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.small)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.onTap()
    })
  }
}

@Component
struct MapGridOverlay {
  private readonly lines: number[] = [0, 1, 2, 3, 4, 5]

  build() {
    Stack() {
      Column() {
        Blank()
        ForEach(this.lines, (item: number) => {
          Divider()
            .strokeWidth(1)
            .color(AppColors.surfaceVariant)
          Blank()
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding({ left: 32, right: 32 })

      Row() {
        Blank()
        ForEach(this.lines, (item: number) => {
          Column() {
          }
          .width(1)
          .height('100%')
          .backgroundColor(AppColors.surfaceVariant)

          Blank()
        }, (item: number) => item.toString())
      }
      .width('100%')
      .height('100%')
      .padding({ top: 32, bottom: 32 })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct MapPinView {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0)
  selected: boolean = false
  onClick: () => void = () => {
  }

  private statusColor(): string {
    if (this.pin.status === 'Approved') {
      return AppColors.success
    }
    if (this.pin.status === 'Pending') {
      return AppColors.warning
    }
    if (this.pin.status === 'Rejected') {
      return AppColors.error
    }
    return '#808080'
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row() {
      }
      .width(this.selected ? 28 : 22)
      .height(this.selected ? 28 : 22)
      .borderRadius(this.selected ? 14 : 11)
      .backgroundColor(this.statusColor())
      .border({
        width: 2,
        color: this.selected ? AppColors.primary : AppColors.surface
      })
      .shadow({
        radius: 4,
        color: '#1A000000',
        offsetX: 0,
        offsetY: 2
      })

      Row() {
        Text(this.pin.title)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
      }
      .padding({
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs
      })
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.small)
      .border({ width: 1, color: AppColors.outline })
      .shadow({
        radius: 4,
        color: '#1A000000',
        offsetX: 0,
        offsetY: 2
      })
      .offset({ x: 18, y: -4 })
    }
    .width(260)
    .height(44)
    .onClick(() => {
      this.onClick()
    })
  }
}

@Component
struct SelectedPinCard {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0)

  build() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.pin.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .maxLines(1)

        Text(this.pin.status)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button() {
        Text('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
      }
      .type(ButtonType.Normal)
      .height(40)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: 12,
      color: '#29000000',
      offsetX: 0,
      offsetY: 6
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State activeFilters: string[] = ['Pending']
  @State selectedPinId: number = -1

  private readonly filters: string[] = ['Pending', 'Approved']
  private readonly pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ]

  private isFilterActive(filter: string): boolean {
    return this.activeFilters.indexOf(filter) >= 0
  }

  private toggleFilter(filter: string): void {
    if (this.isFilterActive(filter)) {
      this.activeFilters = this.activeFilters.filter((item: string) => item !== filter)
    } else {
      this.activeFilters = [...this.activeFilters, filter]
    }
  }

  private isPinVisible(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') {
      return this.isFilterActive('Pending')
    }
    if (pin.status === 'Approved') {
      return this.isFilterActive('Approved')
    }
    if (pin.status === 'Rejected') {
      return true
    }
    return true
  }

  private selectedPin(): ApprovalPin {
    let found: ApprovalPin | undefined = this.pins.find((pin: ApprovalPin) => pin.id === this.selectedPinId)
    if (found !== undefined) {
      return found
    }
    return this.pins[0]
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Column() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding({ top: 28, bottom: AppSpacing.md })
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  FilterChipView({
                    text: filter,
                    isSelected: this.isFilterActive(filter),
                    onTap: () => {
                      this.toggleFilter(filter)
                    }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ top: AppSpacing.md })

            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.pins.filter((pin: ApprovalPin) => this.isPinVisible(pin)), (pin: ApprovalPin) => {
                MapPinView({
                  pin: pin,
                  selected: this.selectedPinId === pin.id,
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === pin.id ? -1 : pin.id
                  }
                })
                  .position({
                    x: `${pin.x * 100}%`,
                    y: `${pin.y * 100}%`
                  })
              }, (pin: ApprovalPin) => pin.id.toString())

              if (this.selectedPinId !== -1) {
                Column() {
                  Blank()
                  SelectedPinCard({ pin: this.selectedPin() })
                    .margin(AppSpacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .height(760)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)
            .border({ width: 1, color: AppColors.outline })
            .margin({
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              bottom: AppSpacing.md
            })
          }
          .width('100%')
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)

        Column() {
          Row({ space: AppSpacing.md }) {
            Button() {
              Text('Reject')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
            }
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(48)
            .enabled(this.selectedPinId !== -1)
            .opacity(this.selectedPinId !== -1 ? 1 : 0.45)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.medium)

            Button() {
              Text('Approve')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(48)
            .enabled(this.selectedPinId !== -1)
            .opacity(this.selectedPinId !== -1 ? 1 : 0.45)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
        }
        .width('100%')
        .backgroundColor(AppColors.surface)
        .shadow({
          radius: 8,
          color: '#24000000',
          offsetX: 0,
          offsetY: -4
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Button() {
        Text('+')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
      .type(ButtonType.Normal)
      .width(56)
      .height(56)
      .borderRadius(28)
      .backgroundColor(AppColors.primary)
      .shadow({
        radius: 12,
        color: '#29000000',
        offsetX: 0,
        offsetY: 6
      })
      .margin({ right: AppSpacing.lg, bottom: AppSpacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}