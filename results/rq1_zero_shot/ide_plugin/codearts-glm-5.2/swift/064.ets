class AppTokens {
  static readonly Colors = {
    primary: '#FF111111',
    secondary: '#FF2A2A2A',
    tertiary: '#FF444444',
    background: '#FFF7F7F7',
    surface: '#FFFFFFFF',
    surfaceVariant: '#FFEDEDED',
    outline: '#FFD6D6D6',
    success: '#FF1E7D4C',
    warning: '#FFB98400',
    error: '#FFB3261E',
    onPrimary: '#FFFFFFFF',
    onSecondary: '#FFFFFFFF',
    onTertiary: '#FFFFFFFF',
    onBackground: '#FF0A0A0A',
    onSurface: '#FF0A0A0A',
  }
  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
  }
  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16,
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
  }
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
  @Prop text: string
  @Prop isSelected: boolean
  onSelect: () => void = () => {}

  build() {
    Text(this.text)
      .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
      .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
      .onClick(() => {
        this.onSelect()
      })
  }
}

@Entry
@Component
struct RootScreen {
  @State activeFilters: string[] = ['Pending']
  @State selectedPinId: number = -1
  private filters: string[] = ['Pending', 'Approved']
  private pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72),
  ]

  private getPinColor(status: string): string {
    if (status === 'Approved') return AppTokens.Colors.success
    if (status === 'Pending') return AppTokens.Colors.warning
    if (status === 'Rejected') return AppTokens.Colors.error
    return '#FF888888'
  }

  private isPinVisible(pin: ApprovalPin): boolean {
    if (pin.status === 'Pending') return this.activeFilters.indexOf('Pending') >= 0
    if (pin.status === 'Approved') return this.activeFilters.indexOf('Approved') >= 0
    return true
  }

  private toggleFilter(f: string) {
    const idx = this.activeFilters.indexOf(f)
    if (idx >= 0) {
      this.activeFilters.splice(idx, 1)
    } else {
      this.activeFilters.push(f)
    }
  }

  private getSelectedPin(): ApprovalPin | null {
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) return this.pins[i]
    }
    return null
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {
          Text('Approval Flow')
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .justifyContent(FlexAlign.Center)

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChipView({
                    text: f,
                    isSelected: this.activeFilters.indexOf(f) >= 0,
                    onSelect: () => { this.toggleFilter(f) }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ top: AppTokens.Spacing.md })

            Stack() {
              ForEach([0, 1, 2, 3, 4], () => {
                Column()
                  .width('100%')
                  .height(1)
                  .backgroundColor(AppTokens.Colors.surfaceVariant)
              })

              ForEach(this.pins, (p: ApprovalPin) => {
                if (this.isPinVisible(p)) {
                  Stack() {
                    Circle({ width: this.selectedPinId === p.id ? 28 : 22, height: this.selectedPinId === p.id ? 28 : 22 })
                      .fill(this.getPinColor(p.status))
                      .border({ width: 2, color: this.selectedPinId === p.id ? AppTokens.Colors.primary : AppTokens.Colors.surface })
                      .onClick(() => {
                        this.selectedPinId = this.selectedPinId === p.id ? -1 : p.id
                      })
                  }
                  .position({ x: `${p.x * 100}%`, y: `${p.y * 100}%` })
                }
              })

              if (this.selectedPinId >= 0) {
                Column() {
                  Blank()
                  Row() {
                    Column({ space: AppTokens.Spacing.xs }) {
                      Text(this.getSelectedPin()?.title ?? '')
                        .fontSize(AppTokens.Typography.title.size)
                        .fontWeight(AppTokens.Typography.title.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                      Text(this.getSelectedPin()?.status ?? '')
                        .fontSize(AppTokens.Typography.label.size)
                        .fontWeight(AppTokens.Typography.label.weight)
                        .fontColor(AppTokens.Colors.onSurface)
                    }
                    .alignItems(HorizontalAlign.Start)
                    .layoutWeight(1)

                    Text('Details')
                      .fontSize(AppTokens.Typography.label.size)
                      .fontWeight(AppTokens.Typography.label.weight)
                      .fontColor(AppTokens.Colors.onSurface)
                      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                      .height(40)
                      .backgroundColor(AppTokens.Colors.surfaceVariant)
                      .borderRadius(AppTokens.Shapes.medium)
                  }
                  .width('100%')
                  .padding(AppTokens.Spacing.lg)
                  .backgroundColor(AppTokens.Colors.surface)
                  .borderRadius(AppTokens.Shapes.large)
                  .border({ width: 1, color: AppTokens.Colors.outline })
                  .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
                  .margin(AppTokens.Spacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .height(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .margin({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')

        Row({ space: AppTokens.Spacing.md }) {
          Button('Reject')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.surfaceVariant)
            .borderRadius(AppTokens.Shapes.medium)
            .enabled(this.selectedPinId >= 0)

          Button('Approve')
            .fontSize(AppTokens.Typography.title.size)
            .fontWeight(AppTokens.Typography.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .layoutWeight(1)
            .height(48)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .enabled(this.selectedPinId >= 0)
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
      }
      .width('100%')
      .height('100%')

      Button('+')
        .fontSize(AppTokens.Typography.headline.size)
        .fontWeight(AppTokens.Typography.headline.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width(56)
        .height(56)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(28)
        .margin({ right: AppTokens.Spacing.lg, bottom: 80 + AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}