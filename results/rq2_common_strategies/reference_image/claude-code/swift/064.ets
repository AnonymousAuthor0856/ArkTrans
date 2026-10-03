// Approval Flow - ArkTS implementation
// Converted from SwiftUI

// MARK: - AppTokens

class AppTokens {
  static Colors = class {
    static primary: Color = Color(0xFF111111)
    static secondary: Color = Color(0xFF2A2A2A)
    static tertiary: Color = Color(0xFF444444)
    static background: Color = Color(0xFFF7F7F7)
    static surface: Color = Color(0xFFFFFFFF)
    static surfaceVariant: Color = Color(0xFFEDEDED)
    static outline: Color = Color(0xFFD6D6D6)
    static success: Color = Color(0xFF1E7D4C)
    static warning: Color = Color(0xFFB98400)
    static error: Color = Color(0xFFB3261E)
    static onPrimary: Color = Color(0xFFFFFFFF)
    static onSecondary: Color = Color(0xFFFFFFFF)
    static onTertiary: Color = Color(0xFFFFFFFF)
    static onBackground: Color = Color(0xFF0A0A0A)
    static onSurface: Color = Color(0xFF0A0A0A)
  }

  static Typography = class {
    static display: Font = Font.Size(28).Weight(FontWeight.SemiBold)
    static headline: Font = Font.Size(20).Weight(FontWeight.Medium)
    static title: Font = Font.Size(16).Weight(FontWeight.Medium)
    static body: Font = Font.Size(14).Weight(FontWeight.Regular)
    static label: Font = Font.Size(12).Weight(FontWeight.Medium)
  }

  static Shapes = class {
    static small: number = 8
    static medium: number = 12
    static large: number = 16
  }

  static Spacing = class {
    static xs: number = 4
    static sm: number = 8
    static md: number = 12
    static lg: number = 16
  }

  static Elevation = class {
    static level1 = { radius: 4, y: 2, opacity: 0.10 }
    static level2 = { radius: 8, y: 4, opacity: 0.14 }
    static level3 = { radius: 12, y: 6, opacity: 0.16 }
  }
}

// MARK: - Data Model

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

// MARK: - FilterChip Component

@Component
struct FilterChip {
  text: string = ''
  isSelected: boolean = false
  onTap: () => void = () => {}

  build() {
    Text(this.text)
      .font(this.isSelected ? AppTokens.Typography.title : AppTokens.Typography.body)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({
        left: AppTokens.Spacing.sm,
        right: AppTokens.Spacing.sm,
        top: AppTokens.Spacing.xs,
        bottom: AppTokens.Spacing.xs
      })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({
        width: 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.small
      })
      .onClick(() => {
        this.onTap()
      })
  }
}

// MARK: - CardView Component

@Component
struct CardView {
  @BuilderParam content: () => void = () => {}
  elevation: { radius: number, y: number, opacity: number } = AppTokens.Elevation.level1
  cornerRadius: number = AppTokens.Shapes.small
  borderWidth: number = 1
  borderColor: Color = AppTokens.Colors.outline
  hasBorder: boolean = true
  onClickAction: () => void = () => {}

  build() {
    Stack() {
      this.content()
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(this.cornerRadius)
    .shadow({
      radius: this.elevation.radius,
      color: `rgba(0, 0, 0, ${this.elevation.opacity})`,
      offsetY: this.elevation.y,
      offsetX: 0
    })
    .border(this.hasBorder ? {
      width: this.borderWidth,
      color: this.borderColor,
      radius: this.cornerRadius
    } : {})
    .onClick(() => {
      this.onClickAction()
    })
  }
}

// MARK: - MapPin Component

@Component
struct MapPin {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0)
  selected: boolean = false
  onClick: () => void = () => {}

  @Builder
  PinLabel() {
    Stack() {
      Text(this.pin.title)
        .font(AppTokens.Typography.label)
        .fontColor(AppTokens.Colors.onSurface)
        .padding({
          left: AppTokens.Spacing.sm,
          right: AppTokens.Spacing.sm,
          top: AppTokens.Spacing.xs,
          bottom: AppTokens.Spacing.xs
        })
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.small)
    .shadow({
      radius: AppTokens.Elevation.level1.radius,
      color: `rgba(0, 0, 0, ${AppTokens.Elevation.level1.opacity})`,
      offsetY: AppTokens.Elevation.level1.y,
      offsetX: 0
    })
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.small
    })
  }

  private getPinColor(): Color {
    if (this.pin.status === 'Approved') return AppTokens.Colors.success
    if (this.pin.status === 'Pending') return AppTokens.Colors.warning
    if (this.pin.status === 'Rejected') return AppTokens.Colors.error
    return Color.Gray
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getPinColor())
        .stroke({
          color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface,
          width: 2
        })

      this.PinLabel()
        .margin({ left: 18, top: -4 })
    }
    .onClick(() => {
      this.onClick()
    })
  }
}

// MARK: - MapGridOverlay Component

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // Horizontal grid lines
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
          Blank()
          Divider()
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
        })
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // Vertical grid lines
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], (_: number) => {
          Blank()
          Divider()
            .vertical(true)
            .color(AppTokens.Colors.surfaceVariant)
            .strokeWidth(1)
        })
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
  }
}

// MARK: - RootScreen

@Entry
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved']
  @State activeFilters: string[] = ['Pending']
  @State pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.45, 0.78),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.65, 0.92)
  ]
  @State selectedPinId: number | null = null

  private getFilteredPins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => {
      if (p.status === 'Pending') return this.activeFilters.indexOf('Pending') !== -1
      if (p.status === 'Approved') return this.activeFilters.indexOf('Approved') !== -1
      if (p.status === 'Rejected') return true
      return true
    })
  }

  private getSelectedPin(): ApprovalPin | null {
    if (this.selectedPinId === null) return null
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) return this.pins[i]
    }
    return null
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column() { }
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column() {
        // Top App Bar
        Column() {
          Text('Approval Flow')
            .font(AppTokens.Typography.display)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filter chips row
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChip({
                    text: f,
                    isSelected: this.activeFilters.indexOf(f) !== -1,
                    onTap: () => {
                      const idx = this.activeFilters.indexOf(f)
                      if (idx !== -1) {
                        this.activeFilters.splice(idx, 1)
                      } else {
                        this.activeFilters.push(f)
                      }
                    }
                  })
                }, (f: string) => f)
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ top: AppTokens.Spacing.md })

            // Map area
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              // Pins
              ForEach(this.getFilteredPins(), (p: ApprovalPin) => {
                MapPin({
                  pin: p,
                  selected: this.selectedPinId === p.id,
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === p.id ? null : p.id
                  }
                })
                  .position({
                    x: p.x * 100 + '%',
                    y: p.y * 100 + '%'
                  })
              }, (p: ApprovalPin) => p.id.toString())

              // Selected pin detail card at bottom
              if (this.getSelectedPin() !== null) {
                Column() {
                  Blank()
                  CardView({
                    elevation: AppTokens.Elevation.level3,
                    cornerRadius: AppTokens.Shapes.large,
                    borderColor: AppTokens.Colors.outline
                  }) {
                    Row() {
                      Column({ space: AppTokens.Spacing.xs }) {
                        Text(this.getSelectedPin()!.title)
                          .font(AppTokens.Typography.title)
                          .fontColor(AppTokens.Colors.onSurface)
                        Text(this.getSelectedPin()!.status)
                          .font(AppTokens.Typography.label)
                          .fontColor(AppTokens.Colors.onSurface)
                      }
                      .alignItems(HorizontalAlign.Start)

                      Blank()

                      Row({ space: AppTokens.Spacing.sm }) {
                        Text('Details')
                          .font(AppTokens.Typography.label)
                          .fontColor(AppTokens.Colors.onSurface)
                          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                          .height(40)
                          .backgroundColor(AppTokens.Colors.surfaceVariant)
                          .borderRadius(AppTokens.Shapes.medium)
                          .onClick(() => {})
                      }
                    }
                    .padding(AppTokens.Spacing.lg)
                    .width('100%')
                  }
                  .margin(AppTokens.Spacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .aspectRatio(0.9)
            .minHeight(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({
              width: 1,
              color: AppTokens.Colors.outline,
              radius: AppTokens.Shapes.large
            })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .margin({ bottom: AppTokens.Spacing.md })
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        // Bottom App Bar
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Text('Reject')
              .font(AppTokens.Typography.title)
              .fontColor(AppTokens.Colors.onSurface)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .opacity(this.selectedPinId !== null ? 1 : 0.4)

            Text('Approve')
              .font(AppTokens.Typography.title)
              .fontColor(AppTokens.Colors.onPrimary)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .opacity(this.selectedPinId !== null ? 1 : 0.4)
          }
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.md
          })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: `rgba(0, 0, 0, ${AppTokens.Elevation.level2.opacity})`,
          offsetY: -AppTokens.Elevation.level2.y,
          offsetX: 0
        })
      }
      .width('100%')
      .height('100%')

      // FAB
      Column() {
        Blank()
        Row() {
          Blank()
          Text('+')
            .font(AppTokens.Typography.headline)
            .fontColor(AppTokens.Colors.onPrimary)
            .textAlign(TextAlign.Center)
            .width(56)
            .height(56)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(28)
            .onClick(() => {})
            .margin(AppTokens.Spacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}
