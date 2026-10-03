// Approval Flow - ArkTS implementation
// Converted from SwiftUI

// MARK: - App Design Tokens

class AppColors {
  static primary: string = '#FF111111'
  static secondary: string = '#FF2A2A2A'
  static tertiary: string = '#FF444444'
  static background: string = '#FFF7F7F7'
  static surface: string = '#FFFFFFFF'
  static surfaceVariant: string = '#FFEDEDED'
  static outline: string = '#FFD6D6D6'
  static success: string = '#FF1E7D4C'
  static warning: string = '#FFB98400'
  static error: string = '#FFB3261E'
  static onPrimary: string = '#FFFFFFFF'
  static onSecondary: string = '#FFFFFFFF'
  static onTertiary: string = '#FFFFFFFF'
  static onBackground: string = '#FF0A0A0A'
  static onSurface: string = '#FF0A0A0A'
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
  opacityStr: string = '#1A000000'

  constructor(radius: number, y: number, opacityStr: string) {
    this.radius = radius
    this.y = y
    this.opacityStr = opacityStr
  }
}

class AppElevation {
  static level1: ShadowSpec = new ShadowSpec(4, 2, '#1A000000')
  static level2: ShadowSpec = new ShadowSpec(8, 4, '#24000000')
  static level3: ShadowSpec = new ShadowSpec(12, 6, '#29000000')
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
      .fontSize(this.isSelected ? 16 : 14)
      .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Regular)
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

// MARK: - MapPin Component

@Component
struct MapPin {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0)
  selected: boolean = false
  onPinClick: () => void = () => {}

  private getPinColor(): string {
    if (this.pin.status === 'Approved') {
      return AppColors.success
    } else if (this.pin.status === 'Pending') {
      return AppColors.warning
    } else if (this.pin.status === 'Rejected') {
      return AppColors.error
    } else {
      return '#FF888888'
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getPinColor())
        .stroke({ color: this.selected ? AppColors.primary : AppColors.surface, width: 2 })

      Text(this.pin.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
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
          color: AppElevation.level1.opacityStr,
          offsetY: AppElevation.level1.y,
          offsetX: 0
        })
        .border({
          width: 1,
          color: AppColors.outline,
          radius: AppShapes.small
        })
        .margin({ left: 18, top: -4 })
    }
    .onClick(() => {
      this.onPinClick()
    })
  }
}

// MARK: - MapGridOverlay Component

@Component
struct MapGridOverlay {
  build() {
    Stack() {
      Column() {
        Blank().layoutWeight(1)
        Divider().color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

      Row() {
        Blank().layoutWeight(1)
        Divider().vertical(true).color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().vertical(true).color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().vertical(true).color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().vertical(true).color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().vertical(true).color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
        Divider().vertical(true).color(AppColors.surfaceVariant).strokeWidth(1)
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg })
    }
  }
}

// MARK: - SelectedPinDetail Component

@Component
struct SelectedPinDetail {
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0)

  build() {
    Column() {
      Blank().layoutWeight(1)
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text(this.pin.title)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(this.pin.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
        }
        .alignItems(HorizontalAlign.Start)

        Blank().layoutWeight(1)

        Text('Details')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .height(40)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.medium)
          .onClick(() => {})
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .shadow({
        radius: AppElevation.level3.radius,
        color: AppElevation.level3.opacityStr,
        offsetY: AppElevation.level3.y,
        offsetX: 0
      })
      .border({
        width: 1,
        color: AppColors.outline,
        radius: AppShapes.large
      })
      .margin(AppSpacing.md)
    }
    .width('100%')
    .height('100%')
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
  @State selectedIndex: number = -1
  @State hasSelection: boolean = false

  private shouldShowPin(p: ApprovalPin): boolean {
    if (p.status === 'Pending') {
      return this.activeFilters.indexOf('Pending') !== -1
    } else if (p.status === 'Approved') {
      return this.activeFilters.indexOf('Approved') !== -1
    } else {
      return true
    }
  }

  private updateSelectedIndex(): void {
    if (this.selectedPinId === -1) {
      this.selectedIndex = -1
      this.hasSelection = false
      return
    }
    for (let i = 0; i < this.pins.length; i++) {
      if (this.pins[i].id === this.selectedPinId) {
        this.selectedIndex = i
        this.hasSelection = true
        return
      }
    }
    this.selectedIndex = -1
    this.hasSelection = false
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        Column() {
          Text('Approval Flow')
            .fontSize(28)
            .fontWeight(FontWeight.SemiBold)
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
                    onPinClick: () => {
                      if (this.selectedPinId === p.id) {
                        this.selectedPinId = -1
                      } else {
                        this.selectedPinId = p.id
                      }
                      this.updateSelectedIndex()
                    }
                  })
                    .position({
                      x: p.x * 100 + '%',
                      y: p.y * 100 + '%'
                    })
                }
              }, (p: ApprovalPin) => p.id.toString())

              if (this.hasSelection) {
                SelectedPinDetail({
                  pin: this.pins[this.selectedIndex]
                })
              }
            }
            .width('100%')
            .height(360)
            .aspectRatio(0.9)
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
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppColors.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .opacity(this.hasSelection ? 1 : 0.4)

            Text('Approve')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
              .opacity(this.hasSelection ? 1 : 0.4)
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
          color: AppElevation.level2.opacityStr,
          offsetY: -AppElevation.level2.y,
          offsetX: 0
        })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank().layoutWeight(1)
        Row() {
          Blank().layoutWeight(1)
          Text('+')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
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
