// Approval Flow - ArkTS implementation
// Converted from SwiftUI

// MARK: - AppTokens

class AppColors {
  static primary: Color = new Color('#FF111111')
  static secondary: Color = new Color('#FF2A2A2A')
  static tertiary: Color = new Color('#FF444444')
  static background: Color = new Color('#FFF7F7F7')
  static surface: Color = new Color('#FFFFFFFF')
  static surfaceVariant: Color = new Color('#FFEDEDED')
  static outline: Color = new Color('#FFD6D6D6')
  static success: Color = new Color('#FF1E7D4C')
  static warning: Color = new Color('#FFB98400')
  static error: Color = new Color('#FFB3261E')
  static onPrimary: Color = new Color('#FFFFFFFF')
  static onSecondary: Color = new Color('#FFFFFFFF')
  static onTertiary: Color = new Color('#FFFFFFFF')
  static onBackground: Color = new Color('#FF0A0A0A')
  static onSurface: Color = new Color('#FF0A0A0A')
}

class AppTypography {
  static display: Font = Font.Size(28).Weight(FontWeight.SemiBold)
  static headline: Font = Font.Size(20).Weight(FontWeight.Medium)
  static title: Font = Font.Size(16).Weight(FontWeight.Medium)
  static body: Font = Font.Size(14).Weight(FontWeight.Regular)
  static label: Font = Font.Size(12).Weight(FontWeight.Medium)
}

class AppShapes {
  static small: number = 8
  static medium: number = 12
  static large: number = 16
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
}

class ShadowSpec {
  radius: number = 0
  y: number = 0
  opacity: number = 0

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius
    this.y = y
    this.opacity = opacity
  }
}

class AppElevation {
  static level1: ShadowSpec = new ShadowSpec(4, 2, 0.10)
  static level2: ShadowSpec = new ShadowSpec(8, 4, 0.14)
  static level3: ShadowSpec = new ShadowSpec(12, 6, 0.16)
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
      .font(this.isSelected ? AppTypography.title : AppTypography.body)
      .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs
      })
      .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
      .borderRadius(AppShapes.small)
      .border({
        width: 1,
        color: AppColors.outline,
        radius: AppShapes.small
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
  elevation: ShadowSpec = AppElevation.level1
  cornerRadius: number = AppShapes.small
  borderWidth: number = 1
  borderColor: Color = AppColors.outline
  showBorder: boolean = true
  onClickAction: () => void = () => {}

  @Builder
  CardContentBuilder() {
    Stack() {
      this.content()
    }
    .backgroundColor(AppColors.surface)
    .borderRadius(this.cornerRadius)
    .shadow({
      radius: this.elevation.radius,
      color: Color.Black.opacity(this.elevation.opacity),
      offsetY: this.elevation.y,
      offsetX: 0
    })
  }

  build() {
    if (this.showBorder) {
      this.CardContentBuilder()
        .border({
          width: this.borderWidth,
          color: this.borderColor,
          radius: this.cornerRadius
        })
        .onClick(() => {
          this.onClickAction()
        })
    } else {
      this.CardContentBuilder()
        .onClick(() => {
          this.onClickAction()
        })
    }
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
    Text(this.pin.title)
      .font(AppTypography.label)
      .fontColor(AppColors.onSurface)
      .padding({
        left: AppSpacing.sm,
        right: AppSpacing.sm,
        top: AppSpacing.xs,
        bottom: AppSpacing.xs
      })
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.small)
      .shadow({
        radius: AppElevation.level1.radius,
        color: Color.Black.opacity(AppElevation.level1.opacity),
        offsetY: AppElevation.level1.y,
        offsetX: 0
      })
      .border({
        width: 1,
        color: AppColors.outline,
        radius: AppShapes.small
      })
  }

  private getPinColor(): Color {
    if (this.pin.status === 'Approved') {
      return AppColors.success
    } else if (this.pin.status === 'Pending') {
      return AppColors.warning
    } else if (this.pin.status === 'Rejected') {
      return AppColors.error
    } else {
      return Color.Gray
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getPinColor())
        .stroke({
          color: this.selected ? AppColors.primary : AppColors.surface,
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
  private gridCount: number[] = [0, 1, 2, 3, 4, 5]

  build() {
    Stack() {
      Column() {
        ForEach(this.gridCount, (_: number, index: number) => {
          Blank()
            .layoutWeight(1)
          Divider()
            .color(AppColors.surfaceVariant)
            .strokeWidth(1)
        }, (item: number, index: number) => 'h' + index.toString())
        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

      Row() {
        ForEach(this.gridCount, (_: number, index: number) => {
          Blank()
            .layoutWeight(1)
          Divider()
            .vertical(true)
            .color(AppColors.surfaceVariant)
            .strokeWidth(1)
        }, (item: number, index: number) => 'v' + index.toString())
        Blank()
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
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
  @State selectedPinId: number = -1

  private shouldShowPin(p: ApprovalPin): boolean {
    if (p.status === 'Pending') {
      return this.activeFilters.indexOf('Pending') !== -1
    } else if (p.status === 'Approved') {
      return this.activeFilters.indexOf('Approved') !== -1
    } else {
      return true
    }
  }

  private getSelectedPinIndex(): number {
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) {
        return i
      }
    }
    return -1
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Column() {
          Text('Approval Flow')
            .font(AppTypography.display)
            .fontColor(AppColors.onSurface)
        }
        .width('100%')
        .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChip({
                    text: f,
                    isSelected: this.activeFilters.indexOf(f) !== -1,
                    onTap: () => {
                      const idx: number = this.activeFilters.indexOf(f)
                      if (idx !== -1) {
                        this.activeFilters.splice(idx, 1)
                      } else {
                        this.activeFilters.push(f)
                      }
                    }
                  })
                }, (f: string) => f)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .margin({ top: AppSpacing.md })

            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()

              ForEach(this.pins, (p: ApprovalPin) => {
                if (this.shouldShowPin(p)) {
                  MapPin({
                    pin: p,
                    selected: this.selectedPinId === p.id,
                    onClick: () => {
                      this.selectedPinId = this.selectedPinId === p.id ? -1 : p.id
                    }
                  })
                    .position({
                      x: p.x * 100 + '%',
                      y: p.y * 100 + '%'
                    })
                }
              }, (p: ApprovalPin) => p.id.toString())

              if (this.selectedPinId !== -1 && this.getSelectedPinIndex() !== -1) {
                Column() {
                  Blank()
                    .layoutWeight(1)
                  CardView({
                    elevation: AppElevation.level3,
                    cornerRadius: AppShapes.large,
                    borderColor: AppColors.outline,
                    showBorder: true
                  }) {
                    Row() {
                      Column({ space: AppSpacing.xs }) {
                        Text(this.pins[this.getSelectedPinIndex()].title)
                          .font(AppTypography.title)
                          .fontColor(AppColors.onSurface)
                        Text(this.pins[this.getSelectedPinIndex()].status)
                          .font(AppTypography.label)
                          .fontColor(AppColors.onSurface)
                      }
                      .alignItems(HorizontalAlign.Start)

                      Blank()
                        .layoutWeight(1)

                      Text('Details')
                        .font(AppTypography.label)
                        .fontColor(AppColors.onSurface)
                        .padding({ left: AppSpacing.md, right: AppSpacing.md })
                        .height(40)
                        .backgroundColor(AppColors.surfaceVariant)
                        .borderRadius(AppShapes.medium)
                        .onClick(() => {})
                    }
                    .padding(AppSpacing.lg)
                    .width('100%')
                  }
                  .margin(AppSpacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .aspectRatio(0.9)
            .minHeight(360)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)
            .border({
              width: 1,
              color: AppColors.outline,
              radius: AppShapes.large
            })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            .margin({ bottom: AppSpacing.md })
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        Column() {
          Row({ space: AppSpacing.md }) {
            Text('Reject')
              .font(AppTypography.title)
              .fontColor(AppColors.onSurface)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .opacity(this.selectedPinId !== -1 ? 1 : 0.4)

            Text('Approve')
              .font(AppTypography.title)
              .fontColor(AppColors.onPrimary)
              .fontWeight(FontWeight.Medium)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
              .opacity(this.selectedPinId !== -1 ? 1 : 0.4)
          }
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
          radius: AppElevation.level2.radius,
          color: Color.Black.opacity(AppElevation.level2.opacity),
          offsetY: -AppElevation.level2.y,
          offsetX: 0
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank()
          .layoutWeight(1)
        Row() {
          Blank()
            .layoutWeight(1)
          Text('+')
            .font(AppTypography.headline)
            .fontColor(AppColors.onPrimary)
            .textAlign(TextAlign.Center)
            .width(56)
            .height(56)
            .backgroundColor(AppColors.primary)
            .borderRadius(28)
            .onClick(() => {})
            .margin(AppSpacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
